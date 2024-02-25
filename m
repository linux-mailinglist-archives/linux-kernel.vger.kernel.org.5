Return-Path: <linux-kernel+bounces-80049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE019862A29
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2A3281C4B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7935D10979;
	Sun, 25 Feb 2024 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad2miNrs"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6DCFC02;
	Sun, 25 Feb 2024 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708862638; cv=none; b=XM9k2cwtJMNpssjtQnwnpof6hEttMq5Bf/hU4FtXDuuHvDJ77HFpY8BrDGGC72Y8VHZ3fcl7JDDT4FfmsaGWTLKxisHQ8hqDa37mqotOcwDE4gz0XpOxNZfgGPZ47cdiLZt8A/Zq+zw1hzlPLPsg/g+6D/P7+2ZK5sWvZSB90i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708862638; c=relaxed/simple;
	bh=sJqFSA98plXohQpP4cFLXG/YZWDMCuwBQsZdZ2R/3nE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LFH7+FYXXDcfdjxshwspwxLiQp1M9R+4QsDPW4J0O5G30Tz6ZZ0/LKzaflefFnpycy+cXO04RZa0L7HS9Z379AxajC6PpnsGo6Cajt7ixoxkj3bRRLaIiOWDEOwu9LjvnUGwKB60v8Y39XxE/948q78OQv3Wv6SetJL8MpqfPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ad2miNrs; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512b29f82d1so2812089e87.1;
        Sun, 25 Feb 2024 04:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708862635; x=1709467435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FC1twFM3dUlW6rVDhNZXcofSuGipZHhYOtvT1OvAccg=;
        b=Ad2miNrserBBBCTQ3P7hrb5F/1K1LEy7h4mCM7fCNK3VXGArj/pkfC4oolkk27UJCt
         xggvs8qgzMR1cNMH0Lrxf8FRXSoXPIHYpqX0gRQXpxCMw/dyJZXP/b7oKYi/G0itBpf2
         k8quVYuMtYrgHhRHlNw8gdW8qVZkVHHe4jTp3UFeyyM2HUk7ZYNY5Jk7jFbrndBy2vXM
         9+9roNgcJ0eCZblENqWaRuascdsZ8X/5YB67UcS7ZI3bCZse035RM36qpctv6IO6W7LL
         9BcS98uDZSnj5psFkjTKddkYci5Jf0AJA2FDtaa1JQtydDMQU9CezhdPae02NRIHfGep
         zU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708862635; x=1709467435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FC1twFM3dUlW6rVDhNZXcofSuGipZHhYOtvT1OvAccg=;
        b=uu6uoeCU2PuYqtw9jQh2D4bjyF5x+2x9GM9ZT3zW+6P8Y3Hv6U93OW4xNkpb6ENlcS
         RQgbAuMLfVj6sG8Fmifq5eq7HIMP3TymtsRtcoqt8iAR7WG1Da0KIqg5kPveSbSuTJhd
         m390CcS53wABEdKj2dPr2wOaYm6E2xD8KZYGOdgSTA3TRvoRGR8q4yZR4/Ah+Hj5f+Z5
         +L8H4XHh4s1yrC8SrvhxQB4gF/HqY3UxjFQZ3odI0QXRn+ILzL6Ylpx27c/kd9gwyEjh
         OWo0iYjGx2xn0CYGZCdwgmsPIYtzG1SIcno2Ewe925NEoAGsHXJmhG7JYsqLYHomLIbM
         UZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK2P1mSsa2FDguVbjco758u6bjjU6pEdysJJUJSKNFuzg8hN6Mv0aHYeRMvnh+P04jZprskr3gupfqixV/sN2XKQaLEdumG5/NRKQLk7U4Z01cSUTO6NnxVnZ8/2iAeZ1rMCkmvXslSqw=
X-Gm-Message-State: AOJu0YybN7dlcBZNvsGjsuPRvt2ltEQzNS9k32D1Q9QgeGdFD7n6VjR6
	GxGij3a/N2XAoIctkgWeyBnLN5SqML1uHb3/zjvpu00/vjX3GWGU
X-Google-Smtp-Source: AGHT+IG14uRpjk6zLINBgzWfBzR13Xfl87PUebJHNOP8WnVV2jwwRzPxaBRwsjf+yNg351cNtvnW9g==
X-Received: by 2002:a05:6512:3254:b0:512:d6a5:bb42 with SMTP id c20-20020a056512325400b00512d6a5bb42mr2235636lfr.18.1708862634973;
        Sun, 25 Feb 2024 04:03:54 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id c6-20020a196546000000b00512aadef912sm515987lfj.27.2024.02.25.04.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 04:03:54 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: hdegoede@redhat.com
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH] staging: media: atomisp: Fix various formatting issues and remove unneccesary braces
Date: Sun, 25 Feb 2024 13:03:50 +0100
Message-Id: <20240225120350.31226-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the following formatting issues:
 * Fix various misaligned * and */ in multiline block comments
 * Remove unnecessary braces from single line conditional statements
 * Remove repeated word "from" from comment

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/atomisp/pci/atomisp_cmd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
index d0db2efe0045..5fa9918c8e1e 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -65,7 +65,8 @@
  * At 15fps this means 133ms. We set the timeout a bit longer.
  * Each flash driver is supposed to set its own timeout, but
  * just in case someone else changed the timeout, we set it
- * here to make sure we don't damage the flash hardware. */
+ * here to make sure we don't damage the flash hardware.
+ */
 #define FLASH_TIMEOUT 800 /* ms */
 
 union host {
@@ -1261,11 +1262,10 @@ int atomisp_gdc_cac(struct atomisp_sub_device *asd, int flag,
 	}
 
 	asd->params.gdc_cac_en = !!*value;
-	if (asd->params.gdc_cac_en) {
+	if (asd->params.gdc_cac_en)
 		asd->params.config.morph_table = asd->params.css_param.morph_table;
-	} else {
+	else
 		asd->params.config.morph_table = NULL;
-	}
 	asd->params.css_update_params_needed = true;
 	atomisp_update_capture_mode(asd);
 	return 0;
@@ -3035,8 +3035,8 @@ void atomisp_handle_parameter_and_buffer(struct atomisp_video_pipe *pipe)
 }
 
 /*
-* Function to configure ISP parameters
-*/
+ * Function to configure ISP parameters
+ */
 int atomisp_set_parameters(struct video_device *vdev,
 			   struct atomisp_parameters *arg)
 {
@@ -3367,7 +3367,7 @@ int atomisp_fixed_pattern(struct atomisp_sub_device *asd, int flag,
 		return 0;
 	}
 
-	/* Add function to get black from from sensor with shutter off */
+	/* Add function to get black from sensor with shutter off */
 	return 0;
 }
 
-- 
2.40.1


