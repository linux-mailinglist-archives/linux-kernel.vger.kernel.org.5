Return-Path: <linux-kernel+bounces-41751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A42283F750
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6713DB2114F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDE567721;
	Sun, 28 Jan 2024 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DBhVCham"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AA6664AD
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458447; cv=none; b=RSUdWraqcrhYy/GO6kDL2LHjRzPG0Ilct8pMwmOoyR+RWGoSfjXXwAOx820QqCUsBI3nWjw4sJtx6cOwPt1Ey2ZezFb4yuAtVGgq50yJCow04hZX/xi2ppXawSH1wVJgzqAi2EvnXoddWgq67QyOve4chsjkMQopN6TR4fFUiL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458447; c=relaxed/simple;
	bh=kX1smuKrBmV0CLC0kA1GU07Ctzs/J2a31TpEn1dthpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m4JSTubpkzKvOl/RzKXVAb8oyWXBYCetEeDZOhnW4T6JC57kbiE5pq6faWKW2FfVLSg6g37sCuFtipJLfhSaa5iHG3fuUJ53+dSfJFP2D78sV69/YQOUTEep+XWh53aoHK1Y4SJyoh7zLDUrIoJGrkGD6aVBESYH2Ufo08qb1oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DBhVCham; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6818a9fe380so16708626d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 08:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706458444; x=1707063244; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0m/P1zm+p3BLtEev+qUE8lpx92ojld2E2PJGrd3/bdc=;
        b=DBhVChamScDpPuZOsf1dh0dusltwcYJixkZ3rAqVSNhoD230gU3usuAhGazpLGadPu
         6yH91TZAGuY26ou7sSipelcjWeBI7NsmnLTHZxUolq/5Yzgvw1mhiQGk57xSdvB/OZ2C
         PMhEpN4fliag772bRXuiYGxNinpm9P+BZuzOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706458444; x=1707063244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0m/P1zm+p3BLtEev+qUE8lpx92ojld2E2PJGrd3/bdc=;
        b=IlYruclaMuSkBwQO781xDv0rzWhAECfWce2dww4ga1+hpZzzLx8vfF2SfGbVszzSoN
         Gf3uttyYwLO8CqdrIahscswB6qe7NdraPDqrpve1xNNsjkp3tFzMpp5SmNpz3SwLrSK9
         dZtiwYQo3x0apSc2/ZFjtRVjvSG/LOxCpUsVRrOG1AzW3c713+7IGEJ13UmXc/Y7frfW
         /L1Vh5ixRCwHep8IZ2908kvEuUWVQpH8c/jOoVoLAmTycSB7AsudiWm3XdCGwbGIM2Jz
         KarIhg4G1+ej7WhzG0T1x8Xt86TEi1Nx2nT/rkX190GIryUz/gbeEwGD/5XgApxX7Ags
         BhKQ==
X-Gm-Message-State: AOJu0Yx0YhHxn7me6rIn5QTqU8q+iISM8dcN6eNmWOO9qD5Ji3VW0sdS
	W9zMxmGiA33pc1/uvI+qNaxlFx91RSKbz6en0If6L+gWnrHkijnlVL8BXPiOniur8g2B8WvbZD7
	0NA==
X-Google-Smtp-Source: AGHT+IFpFnYrtsvv/PZSGrHMTLLAsQo9nx3jvGx+Qy0aib/OUFMOdMy+oEDsUYYR6HbDZ0N/K9VkLw==
X-Received: by 2002:a05:6214:e88:b0:685:5639:fb1a with SMTP id hf8-20020a0562140e8800b006855639fb1amr5171396qvb.102.1706458444437;
        Sun, 28 Jan 2024 08:14:04 -0800 (PST)
Received: from denia.c.googlers.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id dz11-20020ad4588b000000b0068c493426edsm566640qvb.104.2024.01.28.08.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 08:14:03 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 28 Jan 2024 16:13:57 +0000
Subject: [PATCH 2/2] media: usb: s2255: Refactor s2255_get_fx2fw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240128-gcc-11-warnings-v1-2-52bbdf492049@chromium.org>
References: <20240128-gcc-11-warnings-v1-0-52bbdf492049@chromium.org>
In-Reply-To: <20240128-gcc-11-warnings-v1-0-52bbdf492049@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.3

Resize the buffer to the actual size needed and initialize it. With this
we can convince gcc-11 that the variable is not used uninitialized.

drivers/media/usb/s2255/s2255drv.c:1914:25: warning: 'transBuffer' may be used uninitialized [-Wmaybe-uninitialized]

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/s2255/s2255drv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/s2255/s2255drv.c b/drivers/media/usb/s2255/s2255drv.c
index 3c2627712fe9..8e1de1e8bd12 100644
--- a/drivers/media/usb/s2255/s2255drv.c
+++ b/drivers/media/usb/s2255/s2255drv.c
@@ -1906,9 +1906,10 @@ static int s2255_get_fx2fw(struct s2255_dev *dev)
 {
 	int fw;
 	int ret;
-	unsigned char transBuffer[64];
-	ret = s2255_vendor_req(dev, S2255_VR_FW, 0, 0, transBuffer, 2,
-			       S2255_VR_IN);
+	u8 transBuffer[2] = {};
+
+	ret = s2255_vendor_req(dev, S2255_VR_FW, 0, 0, transBuffer,
+			       sizeof(transBuffer), S2255_VR_IN);
 	if (ret < 0)
 		dprintk(dev, 2, "get fw error: %x\n", ret);
 	fw = transBuffer[0] + (transBuffer[1] << 8);

-- 
2.43.0.429.g432eaa2c6b-goog


