Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1470776ED2C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbjHCOu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbjHCOu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2BAF0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D8AE61DD9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 14:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E16C433C8;
        Thu,  3 Aug 2023 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691074224;
        bh=6UZ5Gq0Pftm4pZ1Q4anPSCaaEuJ7ONFvaauXq89PWYk=;
        h=Date:From:To:Cc:Subject:From;
        b=dBfX/AKyXewYh0itdzvWTevQIm9Ubf3+i5bVQPUClQhMHUXuoW+iXY8cTJONPsxrR
         Dx6cwUG22/6EL9vKiUqEkg/bM9S9vtvLqrazAKqOFBWwhPw+Um+47T5rayq3SX7sTB
         Nq5xh5J+erfVlwoKo0a51J6KGHP9sOYJCDZZRwJkUuvOxvZTbP/RjnAMqlk3isCrdA
         oVaHjrV5cNLNOOMy8MUJ9Mg5hJ6lOaG6rEfzOMt/Z3xp+GvMFsDfo1/T2a8JtXx/3n
         KE8eZsxXH7kqJljajkbl/8+Qp3Ohhr66LJfIZDLY9qWWORGMxMPuX7Rtjurm1cX6BT
         dmaW+H1GPySCw==
Date:   Thu, 3 Aug 2023 22:50:19 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Shijie Sun <sunshijie@xiaomi.com>, Yue Hu <huyue2@coolpad.com>,
        Chao Yu <chao@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
Subject: [GIT PULL] erofs fixes for 6.5-rc5
Message-ID: <ZMu+q8oCAVG6PqK1@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Shijie Sun <sunshijie@xiaomi.com>, Yue Hu <huyue2@coolpad.com>,
        Chao Yu <chao@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Sorry about another pull due to new reports this cycle, but could you
consider these two patches for 6.5-rc5?

One patch addresses a data corruption of compressed data deduplication
reported by Shijie Sun who is using this feature in their products.

The other one actually drops a useless WARN_ON() in erofs_kill_sb().
Since the commit is trivial and the WARN_ON() was actually broken in
the -next tree (and triggered a syzbot report) due to a behavior change
of .kill_sb() for the next cycle, it'd be better to fix it upstream now.

All commits have been in -next for a while and no potential merge
conflict is observed.

Thanks,
Gao Xiang

The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.5-rc5-fixes

for you to fetch changes up to 4da3c7183e186afe8196160f16d5a0248a24e45d:

  erofs: drop unnecessary WARN_ON() in erofs_kill_sb() (2023-08-01 16:12:24 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix data corruption caused by insufficient decompression on
   deduplicated compressed extents;

 - Drop a useless s_magic checking in erofs_kill_sb().

----------------------------------------------------------------
Gao Xiang (2):
      erofs: fix wrong primary bvec selection on deduplicated extents
      erofs: drop unnecessary WARN_ON() in erofs_kill_sb()

 fs/erofs/super.c | 2 --
 fs/erofs/zdata.c | 7 ++++---
 2 files changed, 4 insertions(+), 5 deletions(-)
