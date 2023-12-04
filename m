Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B61803E48
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjLDTW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjLDTWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:22:55 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FA3113
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:22:59 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d0538d9bbcso29694955ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701717779; x=1702322579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2NsrjOGbg4NmIjD8PWqjBsvJk5exDijeITeH9cgLNWk=;
        b=AAcg67/jcfnRc4sfFu2LqcKLViC3D2sgC3j0n8L0w6K2k0aLP9twhp1HbOADmt7PzR
         445gnAbwlrT6SxjW6SFEBg2SwmIOJlSPVZTcOH+imQ4Cbux8YQiEXIwlXkkdrbsjGfZU
         PsZIU30OFt8nHyOj+fGrc/Hlxn5L99FuM7zs6DSFqv131rmnz53tKpvT6jcUHUYPz1AZ
         YBoFdtujxExYQv+Rl8pXGx+0cBKmNcBTli2g0pp5XuoQZyjhkG83FhdJ21sCbBt2IdKk
         v6Rg5Y7uW5hgslSG7A2roeG8R6ED79+PA5aW2pZ15aTGsvhU4o7JEsWZNymsy7KxNsOI
         uIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701717779; x=1702322579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NsrjOGbg4NmIjD8PWqjBsvJk5exDijeITeH9cgLNWk=;
        b=U5N7IfD0KRKK1B+uVHHI6yvZO3zzRhKUvIiOTaJS+dPDvgINSG3sdUXEChO7Hj4irY
         iR+DdEEucU5ZIcXpi9ICw4TAdWLK/69gj2o7Xcg5jduTCBzOBxDb8hqo77PfU93bpcdI
         nSvAqswObIyP7ehBfD2I6+Q1sfeHqHMAdZ3vPAWEiN/6e98AQ7QD18aUNMkLXBCMdkoo
         0FN7SnsztzpPYVDUQUMKDaNFfISV/BtfW3KMqU8q+0usdYSzc6eB6cb7938f59kt4DUk
         VMVTCUWx2S8780unXviQzA9mZTPpMfDB5r8Luw+85DIE7JH+xFEmFLncN44+MGwEePC/
         ZtwA==
X-Gm-Message-State: AOJu0YybyYrFrCAHnnXIokQQhrQJFdwO2FEUb+nMN5455oHXqdIqpFMP
        qv2uzqfz0D+3PedVZJMI/nVK4xMSSiw=
X-Google-Smtp-Source: AGHT+IEd8ztf0T46rO8eqjfh+HBBSeiqKtVN5wRE53nvIDe3epX1CVDUgVsHKD8Vx1RM5sUOMcJY/g==
X-Received: by 2002:a17:902:7842:b0:1d0:649b:89d0 with SMTP id e2-20020a170902784200b001d0649b89d0mr3912917pln.52.1701717778840;
        Mon, 04 Dec 2023 11:22:58 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:727a:d07a:2bd2:a437])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902dac400b001cfe19e2508sm8687675plx.274.2023.12.04.11.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 11:22:58 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: skip finishing zones for current zones
Date:   Mon,  4 Dec 2023 11:22:51 -0800
Message-ID: <20231204192251.2518865-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Do not finishing zones for current zones.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Fixes: 06a25b021d15 ("f2fs-tools: make six open zone check resilient")
---
 fsck/fsck.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 8acb822..5121a56 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -3265,8 +3265,9 @@ static int chk_and_fix_wp_with_sit(int UNUSED(i), void *blkzone, void *opaque)
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	block_t zone_block, wp_block, wp_blkoff;
 	unsigned int zone_segno, wp_segno;
-	int ret, last_valid_blkoff;
+	int i, ret, last_valid_blkoff;
 	int log_sectors_per_block = sbi->log_blocksize - SECTOR_SHIFT;
+	unsigned int segs_per_zone = sbi->segs_per_sec * sbi->secs_per_zone;
 
 	if (blk_zone_conv(blkz))
 		return 0;
@@ -3309,6 +3310,15 @@ static int chk_and_fix_wp_with_sit(int UNUSED(i), void *blkzone, void *opaque)
 		return 0;
 	}
 
+	/* if a curseg points to the zone, do not finishing zone */
+	for (i = 0; i < NO_CHECK_TYPE; i++) {
+		struct curseg_info *cs = CURSEG_I(sbi, i);
+
+		if (zone_segno <= cs->segno &&
+				cs->segno < zone_segno + segs_per_zone)
+			return 0;
+	}
+
 	/*
 	 * If valid blocks exist in the zone beyond the write pointer, it
 	 * is a bug. No need to fix because the zone is not selected for the
-- 
2.43.0.rc2.451.g8631bc7472-goog

