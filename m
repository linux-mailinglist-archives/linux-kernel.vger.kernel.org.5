Return-Path: <linux-kernel+bounces-41752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A28083F751
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7131C20ABA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37B267729;
	Sun, 28 Jan 2024 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FzWuLFMx"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0A6664D8
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458447; cv=none; b=SZB7iNVTNDO9m+5meIAfNwXRCtBj25s9BJmSOEzQeNRW8umLNX8O4hmpx+7cS3qpbtFPrjcMhkjvZvKYYQF+FM1L58jFWni8fYMTVPik1FtiU5W4zjtBp5vWDAU/30bAiU7IrrvkDOi0KViZAUzGHIV/Fexqibu3snPriTKYYxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458447; c=relaxed/simple;
	bh=/xWOilo4Hud6QzZM3cj00D+5v080/58h43sQggsHgHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qph3M8QqODVMnOO5+1QprWQ04ADKAGSZgq7+/s7yN6jSDkLkCpaZ0B0HU3nXuDhfmMXOa0T4K/1K89nVo9uzpbemI159WpSrtzj72WdE/9T+JR27ACNOHVjCFlOLlO2z40qrcBTMpo0IFE2xYK8b2QdlshwaHSnaUekFdLKDr2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FzWuLFMx; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68c3b845643so12535046d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 08:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706458443; x=1707063243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyrr36Rbe8AgWubab7y8Kw9tDT0keELEe6KuPO/35LY=;
        b=FzWuLFMxaZaLG5NdsCCqSV2MCwNpFUQJkrzYErKrXyacRrj9MIM0G9DgtGnGcBKTrZ
         Km9+MW6IxrEpblm/gMQ0NKe9+SN+8Uh0AU5zwKL73erSXSVS1R8m9id2TihS+sbvcBk+
         s8B1xvVtdglp9AHNKjfV6UujEbzsd+CzrzOfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706458443; x=1707063243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyrr36Rbe8AgWubab7y8Kw9tDT0keELEe6KuPO/35LY=;
        b=rFFBAGE51kZCzV4jbih+hUa+7Q30T05HHNHuzEIzKY0kKeKHXLN7RDwRLkJFxYuRKO
         VGeJqTz7RBEn22AQM46R5KSgDJ84xF9nClUk1FStCsJ6iO0lnAJXcFCml0mpUl8Mfg63
         GvmceoxiivtG69HX9Ib+AdhEyHh8SrBlLQrpPVvXevsDB28Wccj4ipRIc4FK50cKEYal
         s5BKTOV0sHlmLry5N2EKwpAzNvP32whZZXBLz41ckYT93KXzItQ3E38yAQDW0I2lNnDZ
         nTw9CeojLdNc5xLvmhFqPJAkZxt7j35fK6iRPXL7BBR6CAHnC4Hsdzc4a8c6vz/ZUZ7V
         LL3w==
X-Gm-Message-State: AOJu0YzQqSKgIkyXAdfBSWIE7RvN3Xg1Cq+/OwHbOHjq8IOxTYOmFbZH
	CpRcvBGxfRuVm3F5i+Ii9i+9UJPBGJUf7Ex37Afn5kevmVjiTgK+ZnG1Onjpkw==
X-Google-Smtp-Source: AGHT+IEi91bgjGpdxd6b1KVJteAO32/e7rfk2MgI0un8dbL/yrThhpzpxRXTFzO5dYTWX+Rat0dJbg==
X-Received: by 2002:a05:6214:2483:b0:68c:46ab:c8df with SMTP id gi3-20020a056214248300b0068c46abc8dfmr1995323qvb.128.1706458443430;
        Sun, 28 Jan 2024 08:14:03 -0800 (PST)
Received: from denia.c.googlers.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id dz11-20020ad4588b000000b0068c493426edsm566640qvb.104.2024.01.28.08.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 08:14:03 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 28 Jan 2024 16:13:56 +0000
Subject: [PATCH 1/2] media: nxp: imx8-isi: Factor out a variable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240128-gcc-11-warnings-v1-1-52bbdf492049@chromium.org>
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

gcc-11 seems to believe that coffs can be used uninitialized. Refactor
the code and remove the csen variable to convince gcc that we are doing
a good job.

drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:218:20: warning: 'coeffs' may be used uninitialized in this function [-Wmaybe-uninitialized]

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
index 19e80b95ffea..5623914f95e6 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
@@ -215,8 +215,7 @@ static void mxc_isi_channel_set_csc(struct mxc_isi_pipe *pipe,
 		[MXC_ISI_ENC_RGB] = "RGB",
 		[MXC_ISI_ENC_YUV] = "YUV",
 	};
-	const u32 *coeffs;
-	bool cscen = true;
+	const u32 *coeffs = NULL;
 	u32 val;
 
 	val = mxc_isi_read(pipe, CHNL_IMG_CTRL);
@@ -235,14 +234,13 @@ static void mxc_isi_channel_set_csc(struct mxc_isi_pipe *pipe,
 		val |= CHNL_IMG_CTRL_CSC_MODE(CHNL_IMG_CTRL_CSC_MODE_RGB2YCBCR);
 	} else {
 		/* Bypass CSC */
-		cscen = false;
 		val |= CHNL_IMG_CTRL_CSC_BYPASS;
 	}
 
 	dev_dbg(pipe->isi->dev, "CSC: %s -> %s\n",
 		encodings[in_encoding], encodings[out_encoding]);
 
-	if (cscen) {
+	if (coeffs) {
 		mxc_isi_write(pipe, CHNL_CSC_COEFF0, coeffs[0]);
 		mxc_isi_write(pipe, CHNL_CSC_COEFF1, coeffs[1]);
 		mxc_isi_write(pipe, CHNL_CSC_COEFF2, coeffs[2]);
@@ -253,7 +251,7 @@ static void mxc_isi_channel_set_csc(struct mxc_isi_pipe *pipe,
 
 	mxc_isi_write(pipe, CHNL_IMG_CTRL, val);
 
-	*bypass = !cscen;
+	*bypass = !coeffs;
 }
 
 void mxc_isi_channel_set_alpha(struct mxc_isi_pipe *pipe, u8 alpha)

-- 
2.43.0.429.g432eaa2c6b-goog


