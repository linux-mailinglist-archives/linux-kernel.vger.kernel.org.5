Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2D2803C35
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjLDSE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjLDSE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:04:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E3BFA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 10:04:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D72FC433C8;
        Mon,  4 Dec 2023 18:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701713073;
        bh=0phZvSzPedzW6aghBJdL/2EodTWmVUATApogRYUPDL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JJUpsYKjhndUIiQOWhL/JnuOSKRB4lZI+bnPJji3zxHnVVmcPDhoE/U0MgdbyqWrs
         zgqIk78WA38WbHWv8Xn/2rJyK5Aeh7aF4VWtrnadkOBuzDx1IJPFp91pgOS1pZPnX5
         4fjfBp8Z4ioemkmo0f5iq/aQ8ngMnYp+fdDEZaBU2uDlTvf35o8taW9N0hE4jcuFjE
         nQv9bB/Mb8Zb/2tCyrBPTCrNs0QKiKi06ePBjMHppvd/tY00JhKNmm3CS2Axk0AMSu
         4iKlvZcfK8Opeqt44AlZe+tmTLGnOZSwiRBaHcX/aEgLNdSvCgggjf/WVmcHTjf9Rf
         2UDGeWImdFb3A==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs: check write pointers when checkpoint=disable
Date:   Mon,  4 Dec 2023 10:04:27 -0800
Message-ID: <20231204180428.925779-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204180428.925779-1-jaegeuk@kernel.org>
References: <20231204180428.925779-1-jaegeuk@kernel.org>
MIME-Version: 1.0
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

Even if f2fs was rebooted as staying checkpoint=disable, let's match the write
pointers all the time.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 617340e9ea7f..9a874b4d1501 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4741,7 +4741,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 #ifdef CONFIG_QUOTA
 	f2fs_recover_quota_end(sbi, quota_enabled);
 #endif
-
+reset_checkpoint:
 	/*
 	 * If the f2fs is not readonly and fsync data recovery succeeds,
 	 * check zoned block devices' write pointer consistency.
@@ -4752,7 +4752,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 			goto free_meta;
 	}
 
-reset_checkpoint:
 	f2fs_init_inmem_curseg(sbi);
 
 	/* f2fs_recover_fsync_data() cleared this already */
-- 
2.43.0.rc2.451.g8631bc7472-goog

