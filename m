Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A707874E8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241772AbjHXQJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242376AbjHXQIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:08:43 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B181996
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:08:42 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-34ba9d6f033so23036115ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692893321; x=1693498121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mwl7q1yPOEcXF73xF3to8HfIIGKX018FgBcknfK83RE=;
        b=I1/T4RTD1WGrxc97G5vu4JwTSp917FtOlo0CqDDG3+i6LwOM/8n104SaMp2tAnvr+q
         KIkpZ7sUcDy62PT5VjM/+KVCz+i5nlXRBa1G6LlUTE6WbEx/9v70ZjD+S0OIc1BY6H+i
         jjuA9GG30sKqDwbxb36E6A77mVf+8lp1umaAmuZEv4CaFeDCGhu2sqqVaL1WqrKftHmn
         Ad7bkCDIXjob14zMX7uhEixZST3vRvRSEfpjiPKYCkIIOTkbxbl91IT7oCFNtLGLCKJE
         YpZ3GfJOt+Hr47oXdj3eurCSV4hgAa+74uQl6XhLkF/Gh6fG3Ciqci86Eyg9TNHJfCvl
         iQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692893321; x=1693498121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mwl7q1yPOEcXF73xF3to8HfIIGKX018FgBcknfK83RE=;
        b=T+Wa0i7Gh03rxsHShIF4YxqXcdY+NpzytM6+8ugIZP9WSsxG8of0GJ7Jpk2zfvJgxq
         YH1I780X86LG0kdj/k2AlwQm6L3xiOXpI8gqcQC22lBxchVcHijCZXp6IIwt7P877jvd
         q2otqOx8i1umw+0Y/3hInPki+xmErTpgz3xlcwk2Jfvnnjs6u669ywty5O9mt8kfu8jP
         1HrDXjc0jErR//87bi/ENwpTERp1+kgn8H8CdDNsyLtLXx4t5maePmQjKYTudUdl8p7K
         jrGEdTOSX7Ofdu/rw2mThGKD/7/vwNNKQQeHY6ZydByea3AmIhbidbP27dUDETjfiCPc
         hv4Q==
X-Gm-Message-State: AOJu0Yz8uUTnlbf4D0cyp0LKuOLsJhXnVwELnI6pE+kG5wfsPh8Fb50I
        bOsVJ0eyj+Q85lho/BJQ7E59Zmpt2is=
X-Google-Smtp-Source: AGHT+IGBcpwaFEsAg0jmQmnsciZ7Ss2OB5wbWgSqSzaLeCDbd15m13wj5d2RKi3X+7boqWqXGLtEGg==
X-Received: by 2002:a05:6e02:1ca8:b0:345:fae5:666c with SMTP id x8-20020a056e021ca800b00345fae5666cmr7377252ill.4.1692893321078;
        Thu, 24 Aug 2023 09:08:41 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:6826:ad3e:88eb:ebf3])
        by smtp.gmail.com with ESMTPSA id o9-20020a639209000000b0056946623d7esm11741234pgd.55.2023.08.24.09.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 09:08:40 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: use finish zone command when closing a zone
Date:   Thu, 24 Aug 2023 09:08:31 -0700
Message-ID: <20230824160832.3195155-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Use the finish zone command first when a zone should be closed.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/segment.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b38bf2b34490..d05b41608fc0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4948,12 +4948,19 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 		    GET_BLKOFF_FROM_SEG0(sbi, last_valid_block),
 		    wp_segno, wp_blkoff);
 
-	ret = blkdev_issue_zeroout(fdev->bdev, zone->wp,
-				zone->len - (zone->wp - zone->start),
-				GFP_NOFS, 0);
-	if (ret)
-		f2fs_err(sbi, "Fill up zone failed: %s (errno=%d)",
-			 fdev->path, ret);
+	ret = blkdev_zone_mgmt(fdev->bdev, REQ_OP_ZONE_FINISH,
+				zone->start, zone->len, GFP_NOFS);
+	if (ret == -EOPNOTSUPP) {
+		ret = blkdev_issue_zeroout(fdev->bdev, zone->wp,
+					zone->len - (zone->wp - zone->start),
+					GFP_NOFS, 0);
+		if (ret)
+			f2fs_err(sbi, "Fill up zone failed: %s (errno=%d)",
+					fdev->path, ret);
+	} else if (ret) {
+		f2fs_err(sbi, "Finishing zone failed: %s (errno=%d)",
+				fdev->path, ret);
+	}
 
 	return ret;
 }
-- 
2.42.0.rc1.204.g551eb34607-goog

