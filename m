Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23340757510
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjGRHMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjGRHMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:12:18 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715D510B;
        Tue, 18 Jul 2023 00:12:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666ed230c81so5476747b3a.0;
        Tue, 18 Jul 2023 00:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689664337; x=1692256337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J+3/4KtrV8kbephpJ22EviWFdjs0YaC3yiKObYCwqJM=;
        b=RlI9I82l/kFy2u6fnTKaU7c/oVV126yW9wTkZvV9hAL5qomkuipM4CPaxdAc/YkVpR
         ReFgM728Vx2U5eq95VDoE6Nes/QaGYvnhtafQGVEji2C4KkLctoYfI9KLLUmcr4AqkY1
         zPie+6yy4vcEB6RwmYCwbqHkBrws4w14pCzpw3c2f271D++XZmgW6ReOrmY0hNmDsBj1
         mtWGdL28PFdgKK2Ngpmfcimc5xw2n3rMsoGoz4DIUwlABkk/56pR16ByctEoGpCsIpig
         SGed/mNdI56m3t0mCj4g7D/Pi8SiQHRHWCJywoLBYqGLu7p/nwXzyVyIb2z2aElbhZEm
         vDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689664337; x=1692256337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+3/4KtrV8kbephpJ22EviWFdjs0YaC3yiKObYCwqJM=;
        b=UINwORi0JvEHvbfMhrLtIAo1HPRe4L8m7CvU5kKTW8X3ohw0sZSvmxrBsCxJJBdxLZ
         Ysvac+jECSfNFOLAIMabAsUIAeoaQNyetynGDMTLUrYrz8VMPcy4W63QDxeSdxD+NOin
         hmg5fOmoU7x82faZ/53OYTqpO6LqqryQwEJ+8li2Ime6qMyXN0kz31FzqUDad4KukP/7
         zMICUjuZEytEnlVRJcs+bja9ulDzP2gIqFLHT26U0XvV/anmDXFNAnVAfQ4SkrfWPGud
         mdm1GdVKesLFY+62FiEAXDR2WAmnM43OUSCR0y5dB7e3R3ZMz08HBcA6BUGP0SobU+zR
         NeZg==
X-Gm-Message-State: ABy/qLbX9OgrRK2DhuxIzuz+KjaCSakMyagqWJrEybP9Su8MguMq0Y/4
        SiZXOaj8HCshbytVJ1r8sPU=
X-Google-Smtp-Source: APBJJlGwiWAMaxnx4OaS4h4d1wbAsEImE3dOadjpjGzazMe54xvo1BYqIpVFwkiwpZJmVp0ks+6mvw==
X-Received: by 2002:a05:6a00:1acc:b0:668:81c5:2f8d with SMTP id f12-20020a056a001acc00b0066881c52f8dmr18984419pfv.3.1689664336896;
        Tue, 18 Jul 2023 00:12:16 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.251])
        by smtp.gmail.com with ESMTPSA id l23-20020a62be17000000b00682a8e600f0sm879553pff.35.2023.07.18.00.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:12:16 -0700 (PDT)
From:   Huanpeng Xin <xinhuanpeng9@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org, axboe@kernel.dk
Cc:     senozhatsky@chromium.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, xinhuanpeng <xinhuanpeng@xiaomi.com>
Subject: [PATCH] zram: set zram bio priority to REQ_PRIO.
Date:   Tue, 18 Jul 2023 15:11:54 +0800
Message-Id: <20230718071154.21566-1-xinhuanpeng9@gmail.com>
X-Mailer: git-send-email 2.37.2
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

From: xinhuanpeng <xinhuanpeng@xiaomi.com>

When the system memory pressure is high, set zram bio priority
to REQ_PRIO can quickly swap zarm's memory to backing device,
freeing up more space for zram.

Signed-off-by: xinhuanpeng <xinhuanpeng@xiaomi.com>
---
 drivers/block/zram/zram_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b8549c61ff2c..af56766a036b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -616,7 +616,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 {
 	struct bio *bio;
 
-	bio = bio_alloc(zram->bdev, 1, parent ? parent->bi_opf : REQ_OP_READ,
+	bio = bio_alloc(zram->bdev, 1, parent ? parent->bi_opf : REQ_OP_READ | REQ_PRIO,
 			GFP_NOIO);
 	if (!bio)
 		return -ENOMEM;
@@ -746,7 +746,7 @@ static ssize_t writeback_store(struct device *dev,
 		}
 
 		bio_init(&bio, zram->bdev, &bio_vec, 1,
-			 REQ_OP_WRITE | REQ_SYNC);
+			 REQ_OP_WRITE | REQ_SYNC | REQ_PRIO);
 		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
 
 		bio_add_page(&bio, bvec.bv_page, bvec.bv_len,
-- 
2.37.2

