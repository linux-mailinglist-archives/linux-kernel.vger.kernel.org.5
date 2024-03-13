Return-Path: <linux-kernel+bounces-101436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD0F87A711
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A0F1C22DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FA73F8F7;
	Wed, 13 Mar 2024 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evR5oD4i"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8E93EA95
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710329197; cv=none; b=IrIGGKbxW9bUFTQoLaH9qOqzbIe0dmCfmXuy2mPlk8HV4UkU7eaasBxDmKI2yW8o2Q3cwkwNjUHebtxiLSHWIO8rLjQbhWfamH5ZbS1Y/6n/daK/y/LsEf1RjRV8T7h1kgIBA6f4kPFCBwM16w5X6GV+njUGKAKoJQkVMLO+PKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710329197; c=relaxed/simple;
	bh=5qzekjfuvebL2UR1FzA7R5gK9ijJWsW3F2Wj7DKSuvU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X+be6JG4bdK7Mip9vlDucitX265aXYgs91nwx6krQyL/CGBZnEw4SSdizpB/J2gaq4vUjsI1ovTMPwdJUsubMVJvp4rkOzpXACeiVmoTuv5pCo7HsSf9Bgzum2VDNeGFoA8JDdPYL4l7j75+8btIFAGj0+v5R6s3/KFPDh/ywf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evR5oD4i; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513ca834ad7so410605e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710329193; x=1710933993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lfLsFRDMtbO4BOATAAgu9+j4r/MV0Lasvl2lY8+nWuI=;
        b=evR5oD4iN2shkeS6cKn0OKllt93/i4ofoMUwVEBW0Tw3SVkq6dftPXKvPKg8lTrVSV
         2V5c/4zt1l1eCfGUzzQyUSBety6WWjuJko9PRiFsao7hTtppNow/UGzuG/s+Hdprk0Ss
         dckRqZQkama+FGMt7M56tLQrPPsn6IPqRrb/srIoOf9ZGF0b2au8NM14eiXhCx1d9J8S
         SYOYOpCoboohIELoNvjtSIJRxlD9lgwZniQ1MJP05vB/QtG1omewjM8h+bjsHlmi7X7+
         c+owQfFnexghzg4wm0CPar+LwUtSFMivijvCkXMhU5ktsOufFJCvUdsor5XRsQrSf1On
         Uyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710329193; x=1710933993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfLsFRDMtbO4BOATAAgu9+j4r/MV0Lasvl2lY8+nWuI=;
        b=sq6NSvi8NDa/YZUAyeRd8cjhNfdL9v+0eayfmTkLjLc9tI//NQbSjVmq8g9jdrbVKB
         5EeZOAbyEiN3CfmiLBo49rJe+jUq0EuP2IJ57zojFWivwmmezHLMsfVMiwmiicwOYrQl
         +7KuZRFuWBo9IhJwTf5rDAP5whZDz8TI8qYFCiCizteAS9483o53qyh2IVVxSwQPrc4P
         C6OcY/TxAcTwn2kl1yhnSE/rYnw9peLn4BbTCFPsORn5fSHQhFwq/t+G3vWV6cq16Wcd
         IG3PUF+Xq/hZGglH9P1btEX3kDlj9MiBJCNj1r0Knv4cweRUSJQz0zuDZ8X4O4qZZm1o
         JSIA==
X-Forwarded-Encrypted: i=1; AJvYcCV4NFSZVs66QOP2UqTEi2wt/R5Wb2P58ETCP7acrUC9gs7j9LhSCqWL32L8rsFrcDTbsMUs9YL0XyxpgcUxsWPKt4YoAFfYhzHVnPQb
X-Gm-Message-State: AOJu0Yy6H44HjmzX/9TgoUxlBCiMyuBB9YZ62jNXJe6+JXkn+q+r8VEW
	JYaqWoOyjhwh56pNV3T0vkJSluQ+D8FwUs+laXs6HAOsf2UOHEnhfjAK3MunhsWhsQ==
X-Google-Smtp-Source: AGHT+IE09mLx4VQegu+Vnd0FwZuy7/tra7X+S5yizQYa4igYpoiDi330J+2AjIJz1BQLwhk6pLz3rA==
X-Received: by 2002:ac2:5506:0:b0:512:a4ce:abaa with SMTP id j6-20020ac25506000000b00512a4ceabaamr7845165lfk.48.1710329192820;
        Wed, 13 Mar 2024 04:26:32 -0700 (PDT)
Received: from localhost.localdomain ([212.22.67.162])
        by smtp.gmail.com with ESMTPSA id g5-20020a19e045000000b00513201a0e56sm268249lfj.78.2024.03.13.04.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 04:26:32 -0700 (PDT)
From: Maxim Korotkov <korotkov.maxim.s@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Maxim Korotkov <korotkov.maxim.s@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Maxim Korotkov <m.korotkov@securitycode.ru>
Subject: [PATCH] drm/bochs: avoided potential integer overflow
Date: Wed, 13 Mar 2024 14:25:18 +0300
Message-Id: <20240313112518.2030805-1-korotkov.maxim.s@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

if the bochs_dispi_read() function returns a value between
0x8000 and 0xFFFF, then an overflow may occurs.

Found by Security Code and Linux Verification Center (linuxtesting.org)

Signed-off-by: Maxim Korotkov <m.korotkov@securitycode.ru>
---
 drivers/gpu/drm/tiny/bochs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index c23c9f0cf49c..ad31049f9779 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -240,7 +240,7 @@ static int bochs_hw_init(struct drm_device *dev)
 
 	id = bochs_dispi_read(bochs, VBE_DISPI_INDEX_ID);
 	mem = bochs_dispi_read(bochs, VBE_DISPI_INDEX_VIDEO_MEMORY_64K)
-		* 64 * 1024;
+		* mul_u32_u32(64, 1024);
 	if ((id & 0xfff0) != VBE_DISPI_ID0) {
 		DRM_ERROR("ID mismatch\n");
 		return -ENODEV;
-- 
2.34.1


