Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E127F7789
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345896AbjKXPTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345737AbjKXPTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:19:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B071BEC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:19:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40332C43391;
        Fri, 24 Nov 2023 15:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700839161;
        bh=AxnCrub8TDnlTzblxU/JgLVOnW/iV5OidhqOG/icin8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WyqkkMlCeftsYMjf0Vqa9+3fFEH7Yd7j5SJtfDSTGcgjjGmLLywaWqcJm0A4iJbBt
         fLaz4Un0Zy8VnrXcU9qQmhIbgi69X1z4E/JOJWcT5er5dK4US8pHeJor5Sb4YJVezx
         lx+pYJwu0e2870JDjgTFk3dlfKe750bY6oMD3l3iFOdWPsl1RPWmtTTTrg+I9QjA/f
         yWjPmfjhQfKvyEiuDYRVOM2ZxjXh6/QhKJ5/lAnY4EJnxxKAh7aK7o7+KQssdE8+F7
         3wa4ORDQ8BXEzjs/e0LvmOJHB2ip49l3l3CCqjp/HgrYxoTgJiTh+AV9NwainAvh2U
         IgI12j2v/SSzA==
From:   Christian Brauner <brauner@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] fs/pipe: Fix lockdep false-positive in watchqueue pipe_write()
Date:   Fri, 24 Nov 2023 16:19:00 +0100
Message-ID: <20231124-detailgetreu-solidarisch-ae74c731c362@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124150822.2121798-1-jannh@google.com>
References: <20231124150822.2121798-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1607; i=brauner@kernel.org; h=from:subject:message-id; bh=AxnCrub8TDnlTzblxU/JgLVOnW/iV5OidhqOG/icin8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQm7HusxnmZrd2q/KC2xjO1VZ/blq7bwnmhK7fyxqam6 80lT8+wdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEToeR4deDnK0M+7dV3649 /of30JbNaQp23OfXLTXmYdt0Ny5RYRbD/7Lu4Oxpx2oesq7Ta8vpT8+PNtRa25BS3CjzxtuJ4cU pZgA=
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

On Fri, 24 Nov 2023 16:08:22 +0100, Jann Horn wrote:
> When you try to splice between a normal pipe and a notification pipe,
> get_pipe_info(..., true) fails, so splice() falls back to treating the
> notification pipe like a normal pipe - so we end up in
> iter_file_splice_write(), which first locks the input pipe, then calls
> vfs_iter_write(), which locks the output pipe.
> 
> Lockdep complains about that, because we're taking a pipe lock while
> already holding another pipe lock.
> 
> [...]

Yeah, that looks to be a improvement in general, since you can't upgrade
a regular pipe to a O_NOTIFICATION pipe. IOW, peforming that check with
pipe_lock() isn't necessary.

(The check for watch queue in pipe_set_size() called from pipe_fcntl()
 also wouldn't need to be done with __pipe_lock() held fwiw.)

---

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs/pipe: Fix lockdep false-positive in watchqueue pipe_write()
      https://git.kernel.org/vfs/vfs/c/efb8f498327c
