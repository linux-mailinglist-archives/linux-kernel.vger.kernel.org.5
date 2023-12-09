Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B586080B765
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 00:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjLIXMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 18:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLIXMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 18:12:36 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE8312E;
        Sat,  9 Dec 2023 15:12:43 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c0fc1cf3dso35734925e9.0;
        Sat, 09 Dec 2023 15:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702163561; x=1702768361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fyY7xuerRfmnEXL+mjQb56JPNlX5ZA5VFzoyWh1LMIk=;
        b=IOYBpsJPJJpKaHzIcA6RxIdtDQKYhYFNiFY0nVUhe+0LUqkW1dkbUExszHf2Dns9po
         q5ZFQosOe3ruiXtJ2GoPZVaLcdpPPuDV11FoMo3ncNzvuJUfNH4inJ0Q+DymZr4+pZsx
         IZO6VSM7VLv/zkQfWQ2XhM19V8Xak71ocY6lA1rEuVgTWpHqEcdvozGg+ZdXCPmhB1EN
         +EH3m7JrHF72a9mvbPlqS84O4IHMSWLCuDwN7rzU5i5HnQfDGu1hwm4NKkxOw9IeqRxb
         flnvuMP6IXAOrx5U1lSJfZ3vMawuGncZXkUxEmF6pc2QReGvjoolGSDLCzVZDATuleUv
         B1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702163561; x=1702768361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyY7xuerRfmnEXL+mjQb56JPNlX5ZA5VFzoyWh1LMIk=;
        b=g2iQi3lV0mDanVHHFg9om/PWn37LZqUhc8swD6cfXNRc/W7unEzTdpVtYT6y67KXMJ
         YMvVM+UntxF09IgcTACsXjoXSIphSjtLVwDR7177u8QvFzoLebMAobAZh2ff4OeKGZd0
         5KuSLACAOy0wYZqd3HkVWUdT/8/WaSnC5jxiK0//FwIJy2e9DlNkG3yWpjjUgbl+H4dj
         rjoLNsSVWVnSq7c0Z7fR45JD5hFH+pGtHaKvSPW3XgSnW5ppSxK33OsyZLJ/Epq058dS
         rE5wLDC5520CY/18ldrSFJJQyE94Q6RuKc90FFZmt9JTjMnvppuRseRiZpG1Uv+dXfpU
         rDxQ==
X-Gm-Message-State: AOJu0YwLYyM1h0QUTK1YEVpQj0vaZ403rvr9hpzmktJRXQcgRUCvQA6u
        bwECiYvQssVRE6p4bcBNiNE=
X-Google-Smtp-Source: AGHT+IFdQhHVp2q3+OtY4B0AVXmBxuggoKt0nW2hBV9K4p3VmS1uZOxsooZUrel6k9hnzvgD0bYoDg==
X-Received: by 2002:a1c:6a16:0:b0:40c:25f6:4585 with SMTP id f22-20020a1c6a16000000b0040c25f64585mr991729wmc.73.1702163561253;
        Sat, 09 Dec 2023 15:12:41 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b0040b2c195523sm10130953wmo.31.2023.12.09.15.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 15:12:40 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] iommu/apple-dart: Fix spelling mistake "grups" -> "groups"
Date:   Sat,  9 Dec 2023 23:12:40 +0000
Message-Id: <20231209231240.4056082-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iommu/apple-dart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 7438e9c82ba9..497a516747bd 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -911,7 +911,7 @@ static struct iommu_group *apple_dart_device_group(struct device *dev)
 
 		ret = apple_dart_merge_master_cfg(group_master_cfg, cfg);
 		if (ret) {
-			dev_err(dev, "Failed to merge DART IOMMU grups.\n");
+			dev_err(dev, "Failed to merge DART IOMMU groups.\n");
 			iommu_group_put(group);
 			res = ERR_PTR(ret);
 			goto out;
-- 
2.39.2

