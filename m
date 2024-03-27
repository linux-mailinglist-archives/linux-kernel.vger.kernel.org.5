Return-Path: <linux-kernel+bounces-120220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B43CB88D491
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD701F23D05
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711A320B34;
	Wed, 27 Mar 2024 02:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSgP2yeB"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB9C8F6B;
	Wed, 27 Mar 2024 02:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506835; cv=none; b=mkdCqsLCrMQBShlvqFFYDYL86QyrDqZShW/KTfUetH4UEWtOdTHsLwXFOOxbXwYn6HKE5mbky+HLYusGgBH0tucrr8adH1nKiRFS6V2oKo2UHbIiNLvPk3FtooM2lSDI4GvcxaH66Cp2OY8f7okKWDSsh/GlMHGKTX3XZ/Jqxps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506835; c=relaxed/simple;
	bh=fqxbjdG/J9dPK4Wf42csZTCr+nu7BxaXdN+9IM5WVuk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sNdfkEVgxCQ+49yZeTxuKzPLHhKdmXEY7J/BWFLi4sJZrxL5hi8sPTkFsbC48B8BYkHH+ccPcG3aYEFh5HEl8606BZDtjOECnl/AdOKvutFnoq87UNfDgD2xOLm1t6nG7z8TXP1vWzHpEdVUx8kvnrY+ZGLnKZk0/FldfLqnm9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSgP2yeB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6b729669bso5181982b3a.3;
        Tue, 26 Mar 2024 19:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711506834; x=1712111634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mFE/WKj5+GBAYBCA9TZu6+BYrqSKo8UWK4STAPr+tFI=;
        b=eSgP2yeBnApz5n/zcaEoob+orpHHinF3ImLny/udBCiToUHxgMXvmc359w9M6VrOq+
         nTs7Arj/cmVlNgrAPZ2V5F5XUYpAt2OX3z/vuXWyOJNHI4aQ0sHbcK7HHoXB3/OgEZX+
         0RyUSt8au6T658wRo/R5J2e2ivTWWPW2fH3FfjDmrOrIyeryC9/1P36AV/Kp2SpSV6mm
         J9IwrKBNiR6uJKJP9/avfCd66NSaE2vS8xvOOuO6BMHFGphTgkzW/60kcP3lUnTG6kmz
         upUBy0ttg44SzBe8V7xVRHf81OT6CbC/9DNs91gXKgn5NqurlPhisnaivq6DepLe9ICE
         3l7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711506834; x=1712111634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFE/WKj5+GBAYBCA9TZu6+BYrqSKo8UWK4STAPr+tFI=;
        b=XPtklpBwW3eD9BEZhSaJHZ0IDo7qFJq/+vHqIlWZLmBZ+hKrVcRkZAaSwxyKhLvEvo
         kGDIGR/h6Jrf5HEza+RgCDFU/QfSEnoQT9pfUQtc38AI9uMx482yVCfAG6hWwjyukCk5
         pQ6XF5yGrCJARCQHcYAW+aZpPfiNPefYSc6tKev3nHgSth371dY4tE8paVs4E79hhe00
         ph9nPmKekzLlSHQrYKy4zubcHg4CgV3yQWbDx8XyivAlWIYPIXd93uzyuHxgLpfszXwJ
         Xv/uVxxhKHqxZTbxEPTd/WTfg9MFZFTtUG8cpKvIrZW1x2DlIrWsy6zfFGxs8qLVlv83
         UNHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlnPuk6UYsjFDvDzwdqyv/XGbQFbSIJSpoKAH2nS16ZHchYY+SC653Ywd+J9oci/yexqvH8S5DrQ02piuZUCFENswhCqOLclbeYewPH3S/siA76hrin6ydZ/8xFQWZ74xm4PmIl26BI7E=
X-Gm-Message-State: AOJu0YzLA4cG3Hw+c7Jvzgy4s23cxyg5LWFQ2buaqYOCEX7eyDX8N/8L
	rZ96ihWU8Ld2FMAkMDwL5kq/mMiVx8BVw0Jwra86valV9vtbMYn/
X-Google-Smtp-Source: AGHT+IHALrwx+sm0l+OwSsy7AtHVrSvCQg1e5TSoosF5tEtKe338lI3N4UKnH3zPdgfXjfwA/xQdsg==
X-Received: by 2002:a05:6a00:3d51:b0:6e6:88c3:8b7d with SMTP id lp17-20020a056a003d5100b006e688c38b7dmr15983050pfb.10.1711506833394;
        Tue, 26 Mar 2024 19:33:53 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1161:203b:4df1:bb4e:1183:2058])
        by smtp.gmail.com with ESMTPSA id s2-20020aa78d42000000b006eac41e9674sm1008168pfe.146.2024.03.26.19.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 19:33:53 -0700 (PDT)
From: coolrrsh@gmail.com
To: slongerbeam@gmail.com,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	gregkh@linuxfoundation.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v3] staging: media: remove duplicate line
Date: Wed, 27 Mar 2024 08:03:40 +0530
Message-Id: <20240327023340.3710-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

The kernel configuration VIDEO_DEV is defined twice in Kconfig.
Thus, the redundant code is removed.

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>

---
v1->v2
changed the commit message
v2->v3
changed the subject

---
 drivers/staging/media/imx/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/imx/Kconfig b/drivers/staging/media/imx/Kconfig
index 21fd79515042..772f49b1fe52 100644
--- a/drivers/staging/media/imx/Kconfig
+++ b/drivers/staging/media/imx/Kconfig
@@ -4,7 +4,6 @@ config VIDEO_IMX_MEDIA
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on HAS_DMA
 	depends on VIDEO_DEV
-	depends on VIDEO_DEV
 	select MEDIA_CONTROLLER
 	select V4L2_FWNODE
 	select V4L2_MEM2MEM_DEV
-- 
2.25.1


