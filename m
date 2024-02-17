Return-Path: <linux-kernel+bounces-70086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E6C8592E5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E861C20FA3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D7E80021;
	Sat, 17 Feb 2024 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPMRh6sN"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7470F7F7D8
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708204422; cv=none; b=C9rVUIyKDxgr+0YedKxU4Ri6NvXVwuDOz+WZ6hNtHuyh+6a1SoDGCDQT5lTdoKLb+1gCDDGPojN/u4b4X8UC3t/3QIdL3dF+tsjhSfGG47A6aiPJPtCTcdaRGWlkFVSxIveupyLgPedKhq+/0JnWdzrNP7p76PwO56XQ321KzxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708204422; c=relaxed/simple;
	bh=wVBHlEG71HiYpg+k8NXj4fmiRiTFWEkDOl1Zvw4CSdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=npe+wgwVjLYsF7doc41mXoyErwufSH+ANbPXwWIeJszcvm1layAMp2OEwdFcRF2+Bz6TnqIEehDKjWwazP3D+G9ptffUwMhhyB3OOdg6Zd2sjIDZ74gt5MZAgY5Vn6eeIG1BOuU5oSN8F/ouno79aLX/03J2gRb5rBWsEbkjp1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPMRh6sN; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso2817190a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708204419; x=1708809219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoV+G7y2w1NQPRt2wlW97bAxMHa5rqpMfVRm3MsQC8k=;
        b=jPMRh6sNlFsUc3dYsYZZXWhU3pKehppfkA4gFlzkwuPH1XGCiKCw9JvYggzVibY+Qg
         gYh7lojVRGM3jhKpimABd3AomT133jQTmKgp4dwg20KXU833zpby/3ZbhmGZ29m/izRE
         ibHntY8dyWGM90Y5usivNOO0RVWZ4N3UZUfahqSSVDA4TLWBWl2PMwQrxcdRIAexNYlT
         TYtSaFdJytcQsH73kF2s0vOuKNpq4js/Qi1RuMr3KAcpE0fbnWnA47za4mHyeDX5ucYY
         erQr8/uD8UB211XUwy+KM0QejnzjX9fgnPTrxNIfprbFhG8WOD4mgG/AHV4eoSIrHcLU
         j9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708204419; x=1708809219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoV+G7y2w1NQPRt2wlW97bAxMHa5rqpMfVRm3MsQC8k=;
        b=hyjb94D32IVVxQmmi6Vy/J1gNXge/Y1QQtcZK/e1vgUwTf1NGfwfavMZlBJ/OO9a7y
         +Ikl9f+VVNBC473plKVKgDP0gcn6/hXiWkFANv2dLF2Sbo1onaTnMcaKukdFV+r84Muv
         K+infWT21ngtfvYIAOKI4+GSTZq4AsLUwd+O/DO1es+DmSStjHM1uI8I06ZnR31w7aAy
         AljfSlrLzdSe7sRIF/zL5Uc/7nXZpgGYVIllHVHZVgx1WWy0QRfz6q0nhvBviNYVfg9T
         ZDgTEKj7UZVGjtTUHA1B1LwiGnp6Dh6JRptcNTdi8Bp1pUYap1PEM0x0YbcjkgN3sAUv
         kbiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtWa3V9b34CqG1hcRRg3B5shZfwqZxwc3WRLqhIFgwv+LJIvWjTH56OfAI8einsg6ON9KqCyYA4IWNwXf9ERZj29WOMxAkl2inEGsz
X-Gm-Message-State: AOJu0Yylia2RHZ2OldijhEnX5vNg8jqfXa3R6jbfuN5cDXIWQMWGk1IN
	/I7wuZS1UJ0MeiInEelLROq4EJbriZZxd+RD5P64oOY1D4m+zQ06
X-Google-Smtp-Source: AGHT+IH7PRjYOR9LxKzjIyfdSfGIuorzjh1VRhzRUWCXVCXGr5YgFETi939+BUYpFnfReT0NTmAMOQ==
X-Received: by 2002:a05:6402:2d2:b0:564:3854:f466 with SMTP id b18-20020a05640202d200b005643854f466mr816727edx.34.1708204418543;
        Sat, 17 Feb 2024 13:13:38 -0800 (PST)
Received: from pinguine.lan (ip-176-198-146-182.um43.pools.vodafone-ip.de. [176.198.146.182])
        by smtp.gmail.com with ESMTPSA id n3-20020a05640206c300b005644eca3befsm132087edy.85.2024.02.17.13.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 13:13:38 -0800 (PST)
From: "Moritz C. Weber" <mo.c.weber@gmail.com>
To: florian.fainelli@broadcom.com
Cc: linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Moritz C. Weber" <mo.c.weber@gmail.com>
Subject: [PATCH v2 4/8] Staging: vc04_services: bcm2835-camera: fix brace code style check
Date: Sat, 17 Feb 2024 22:12:42 +0100
Message-Id: <20240217211246.28882-5-mo.c.weber@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240217211246.28882-1-mo.c.weber@gmail.com>
References: <20240217211246.28882-1-mo.c.weber@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reformat function parameters to fix checkpatch check:
Increase readability and consistency

Signed-off-by: Moritz C. Weber <mo.c.weber@gmail.com>
---
 .../vc04_services/bcm2835-camera/bcm2835-camera.c      | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index dfa9e7670..e2d058732 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -465,11 +465,11 @@ static int disable_camera(struct bcm2835_mmal_dev *dev)
 				 "Failed disabling camera, ret %d\n", ret);
 			return -EINVAL;
 		}
-		vchiq_mmal_port_parameter_set(
-			dev->instance,
-			&dev->component[COMP_CAMERA]->control,
-			MMAL_PARAMETER_CAMERA_NUM, &i,
-			sizeof(i));
+		vchiq_mmal_port_parameter_set(dev->instance,
+					      &dev->component[COMP_CAMERA]->control,
+					      MMAL_PARAMETER_CAMERA_NUM,
+					      &i,
+					      sizeof(i));
 	}
 	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
 		 "Camera refcount now %d\n", dev->camera_use_count);
-- 
2.30.2


