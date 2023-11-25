Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22AF7F8BEC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjKYPHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjKYPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:07:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ED1F2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:07:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46699C433C8;
        Sat, 25 Nov 2023 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700924856;
        bh=/q54+mS73n57N6iwq9jTkLf9YVzPjCrTltEnmyKnZTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F6m/Q3m2C9dv/x1IrvMwUpR8bpLlJNc24Gp3v/Vc2ovKIDlh0vNRu2OEmZtSizOKf
         PAy35UaIxh08a5Mu13pW51gdbl7Re9EVHipdFS+kl4oAmzE1dXWBIgu6HAFPzX/TaA
         qnZk21Rr/tFPxpjYcqN+Eoti28DB6PsoSLwwW3oOowf+guc95M96Jx0ov5G0Sfebd0
         6bEE6s8dIZ6RyzqH10Yp1Fiwr1wUzq5TW1uaosYT0s0qxlMhrQXFCfpnV/wq+Gb3kG
         luMgV2ANlxx46DG1bGRPoHSg7bbeUKi4uzW98rmnQbJt1sZaDQuHRWAvB0udThpC9E
         ps6nvUJ51ysGQ==
From:   Christian Brauner <brauner@kernel.org>
To:     dhowells@redhat.com, Jia Zhu <zhujia.zj@bytedance.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jefflexu@linux.alibaba.com,
        Gao Xiang <xiang@kernel.org>, linux-cachefs@redhat.com
Subject: Re: [PATCH V6 RESEND 0/5] cachefiles: Introduce failover mechanism for on-demand mode
Date:   Sat, 25 Nov 2023 16:06:34 +0100
Message-ID: <20231125-latschen-bierkrug-d3bad5531859@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120041422.75170-1-zhujia.zj@bytedance.com>
References: <20231120041422.75170-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176; i=brauner@kernel.org; h=from:subject:message-id; bh=/q54+mS73n57N6iwq9jTkLf9YVzPjCrTltEnmyKnZTc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQm8Va+zrfe2JXb8Ig7bXpieu4x03bGd/5nbIKfnvP9d yv7TvbNjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkI72JkOPD/TmjayXeu3hn3 mrh/1vBJrpO1NHA1emn49sWU2YuX8jAy7Itw154XdWgxD/tLWUb93q6V7DYMQVIF575kt51ZJdP BCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 12:14:17 +0800, Jia Zhu wrote:
> Changes since v5:
> In cachefiles_daemon_poll(), replace xa_for_each_marked with xas_for_each_marked.
> 
> [Background]
> ============
> In the on-demand read mode, if user daemon unexpectedly closes an on-demand fd
> (for example, due to daemon crashing), subsequent read operations and inflight
> requests relying on these fd will result in a return value of -EIO, indicating
> an I/O error.
> While this situation might be tolerable for individual personal users, it
> becomes a significant concern when it occurs in a real public cloud service
> production environment (like us).  Such I/O errors will be propagated to cloud
> service users, potentially impacting the execution of their jobs and
> compromising the overall stability of the cloud service.  Besides, we have no
> way to recover this.
> 
> [...]

Applied to the vfs.fscache branch of the vfs/vfs.git tree.
Patches in the vfs.fscache branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fscache

[1/5] cachefiles: introduce object ondemand state
      https://git.kernel.org/vfs/vfs/c/357a18d03314
[2/5] cachefiles: extract ondemand info field from cachefiles_object
      https://git.kernel.org/vfs/vfs/c/3c5ecfe16e76
[3/5] cachefiles: resend an open request if the read request's object is closed
      https://git.kernel.org/vfs/vfs/c/0a7e54c1959c
[4/5] cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
      https://git.kernel.org/vfs/vfs/c/b817e22b2e91
[5/5] cachefiles: add restore command to recover inflight ondemand read requests
      https://git.kernel.org/vfs/vfs/c/e73fa11a356c
