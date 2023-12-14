Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F2B812DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443825AbjLNK4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443957AbjLNK4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:56:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9480810C7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:55:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB0FC433C8;
        Thu, 14 Dec 2023 10:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702551328;
        bh=dOHfKJ1H5Yv4IAoRy4gpJnm+3MqfFLCm0K0QAMRIqk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMFfqC4fH1moFbk3rbUruEybthFx4pghbNQ3GrwVQ101Jz8GdgjwxNQbifFnkvmy8
         2keVRO8t2F8SxAiafKclJilYeTpyLvpt+yzkWg0R69zw1IjcWQJMsRISxGlsbRXmzZ
         qA+a25hALeHaDgNztnvx6+W6CsCKMgsrdh1phd+Ws0N/AVQNBNLcYcbePobluRIFd5
         2P4810geWzWzy/baIcXAFzlzfcQy7DE95e5eP4FG9fbeHrg79nzSNyNme52tkB7Tqd
         4VF9F6XJ4WaWod7fxaILA0a5agkzAijmmTjUhldOStFtS+KKIGKVvvHLLXHOURZ/gA
         CQ8UUqsYztKGA==
From:   Christian Brauner <brauner@kernel.org>
To:     Andrei Vagin <avagin@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 1/2 v2] fs/proc: show correct device and inode numbers in /proc/pid/maps
Date:   Thu, 14 Dec 2023 11:55:04 +0100
Message-ID: <20231214-datieren-maler-10004f2ff2c3@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214064439.1023011-1-avagin@google.com>
References: <20231214064439.1023011-1-avagin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=brauner@kernel.org; h=from:subject:message-id; bh=dOHfKJ1H5Yv4IAoRy4gpJnm+3MqfFLCm0K0QAMRIqk8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRW3Wff3frux6qykENz9S+anNN6efD5zrY9LgvvKpidi ZX2z9Ap7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIGxcjwyfliWs2v7m/V77w zJPtfA9k9lgnrrzj13NSL0D8qEjEzo0M/8tuF77hXLvkmErfgW3l2ftvHXK9/HcO/7LPTYkxiTL 9SVwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 22:44:38 -0800, Andrei Vagin wrote:
> /proc/pid/maps shows device and inode numbers of vma->vm_file-s. Here is
> an issue. If a mapped file is on a stackable file system (e.g.,
> overlayfs), vma->vm_file is a backing file whose f_inode is on the
> underlying filesystem. To show correct numbers, we need to get a user
> file and shows its numbers. The same trick is used to show file paths in
> /proc/pid/maps.
> 
> [...]

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

[1/2] fs/proc: show correct device and inode numbers in /proc/pid/maps
      https://git.kernel.org/vfs/vfs/c/26b50595e169
[2/2] selftests/overlayfs: verify device and inode numbers in /proc/pid/maps
      https://git.kernel.org/vfs/vfs/c/22d9cfff4639
