Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83A87526F3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjGMP2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjGMP21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:28:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457462117
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:27:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D57761985
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 15:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C87CC433C7;
        Thu, 13 Jul 2023 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689262074;
        bh=Yb0FwToWR1mPgzJmQRpGI5uiW5wHMqCirUi7MRvIv3A=;
        h=Date:From:To:Cc:Subject:From;
        b=OXtC9ZnyPa+EXeMNNjdqCu+mrCGWsYsc+qdrKid8H31wbOOA/FE9gbctWtSg3/5pJ
         ssiz/sqS6p3iVFF948KQseuq7J0TE6XaGq+wkFvt+5HkQGHid1It7lE4nz4H8b5a4o
         KGMrusNec3GwkBOEx+gKZrr9rpgSsS9TEyeX0nxWLtF1ep93fdRZoxriE7GPRPHqdq
         ieQ+i56bDarBQ/O4G7nYIZJqo4GiWchTnTGhKQ0SzGd78kniB+gv5prsJ/uEDr08jw
         8jPhKMze3TSccSZRiYfZtBcfI2GzbjpflAhiNDCyKt1LxJY+UB6j7q/wLL816azo98
         nA3lR1F0hvyRQ==
Date:   Thu, 13 Jul 2023 23:27:49 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>, Xin Yin <yinxin.x@bytedance.com>,
        Chunhai Guo <guochunhai@vivo.com>, Yue Hu <huyue2@coolpad.com>
Subject: [GIT PULL] erofs fixes for 6.5-rc2
Message-ID: <ZLAX9WApf3wGm5Q+@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>, Xin Yin <yinxin.x@bytedance.com>,
        Chunhai Guo <guochunhai@vivo.com>, Yue Hu <huyue2@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider these patches for 6.5-rc2?

Three patches address regressions related to post-EOF unexpected
behaviors and fsdax unavailability of chunk-based regular files.

The other two patches mainly get rid of kmap_atomic() and simplify
z_erofs_transform_plain() which I think they are simple enough to
be addressed in this cycle.

All commits have been in -next for a while and no potential merge
conflict is observed.

Thanks,
Gao Xiang

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.5-rc2-fixes

for you to fetch changes up to 18bddc5b67038722cb88fcf51fbf41a0277092cb:

  erofs: fix fsdax unavailability for chunk-based regular files (2023-07-12 00:50:56 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix two unexpected loop cases when reading beyond EOF;

 - Fix fsdax unavailability for chunk-based regular files;

 - Get rid of the remaining kmap_atomic();

 - Minor cleanups.

----------------------------------------------------------------
Chunhai Guo (2):
      erofs: avoid useless loops in z_erofs_pcluster_readmore() when reading beyond EOF
      erofs: avoid infinite loop in z_erofs_do_read_page() when reading beyond EOF

Gao Xiang (2):
      erofs: get rid of the remaining kmap_atomic()
      erofs: simplify z_erofs_transform_plain()

Xin Yin (1):
      erofs: fix fsdax unavailability for chunk-based regular files

 fs/erofs/decompressor.c | 37 +++++++++++++++++--------------------
 fs/erofs/inode.c        |  3 ++-
 fs/erofs/zdata.c        |  4 ++--
 3 files changed, 21 insertions(+), 23 deletions(-)
