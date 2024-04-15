Return-Path: <linux-kernel+bounces-145816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAB18A5B47
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5361F227EF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF97D16C843;
	Mon, 15 Apr 2024 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RXSntWiL"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C94165FC4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209709; cv=none; b=QLRpLTTtITE7mHpYOkJ0TJc5FVAm2oHQaqXAv1t+9uzLoW/r+zBC2u8bfoc+wZv4qYZTPba9MgQLofxsskl8jvXwjR77OYZ7Z6eUTACBwj5XahxEmF91nUOVRIR+vHwLjkRNnvvESAZCNRA/L3xmvn0s7K0R1j7t1TC8+zzBJ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209709; c=relaxed/simple;
	bh=sbLzegDZJboKAA9/je+6QpJ4kVwKzeKe1sqk5xJ4+pg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aC85k5SoDMA8KtYMsBknRGuLcF8v0sJvfsATz/iBpRJaBaGHmrQ3y6fyAKiyvx49AQPi3Znt4cuqDNok1GQC9tFjZmdjZCOuCJfm2qEPvr9nR6G5P/9I+tZJVed0GQD25J17hwwAb/OwEVmMmY5ntWa+qumDBAmcElNwIvcw93Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RXSntWiL; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e0f43074edso2568768a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713209704; x=1713814504; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZ69zvEi+2hVMHqGREi0s+o1FDmo1qxeLo8vD8Yn8BA=;
        b=RXSntWiLyE71kiYiA81ZnAMAJVFNDDjTsj2344Bh++m7oSZB6zkq28jsVCwAdLhoT5
         CFBB8TIzvhOpRXt3uRq7wtFjH/xY6SH6NjMpWKmK64oiUxSK4cz/1NSf2X5CKEt217ON
         TkMAeyFxlnnOuSssWf0HdQLyikhjSSceC2xQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713209704; x=1713814504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZ69zvEi+2hVMHqGREi0s+o1FDmo1qxeLo8vD8Yn8BA=;
        b=I08AVrzw9i6V7sWP2Esz6TEXP+J4kjue4kSV75ytqFfCk7Bfmvongi/fZpAQMthQrW
         MCOTJTtfnm5Oe819b014ilPHwX6e2wszU777oBUFFlCH1c20fhD/BpwO12KGEgieZNOy
         Mvh5ffCbkAtVg3lii1gt5sZLl0vb+IQfO4Ts5/fa2wALSYkWQpKNVLJk2M/7eXhcfcvu
         yQqamuhcNnaNxET2fUGdtziR+IpFBtdDU1f1RrK0oOj2SrCKmoGrX5ICGJYXs72eL/co
         HZjCp0hVAeF1iTFZHaxhrcbIdisCqwyAIqkiq4n8VN2qzfLvzL1MCxdCkqGWmDMudiDU
         e5Mg==
X-Forwarded-Encrypted: i=1; AJvYcCU222BCxFWmiYU3Mk06YifxxjxNIiXa9KFdQZTq7ZP7ONNmK8xB6gWymoJjsAxsba/+sn1ME3zHE6QJ+mlI0T4OI7657maEbh7YNgpG
X-Gm-Message-State: AOJu0YzKpUXthHY5TZNKCU/vBJwoc957fOY3iAzURYRlkwsFNjOy86MA
	m7Uq299SdBzWvmuZIhhxkKq+xNeuLeW1msxUNJcFLlia2WY0nZl6VMA90ACtqw==
X-Google-Smtp-Source: AGHT+IGR6r574HxBWsbrxXxGaHrf3NXllaDQAZexGaElZz4TGdMFy5/7Wsa4Z+FqqK7nCIYg/Ya87w==
X-Received: by 2002:a9d:77cf:0:b0:6eb:68b7:581f with SMTP id w15-20020a9d77cf000000b006eb68b7581fmr7839393otl.22.1713209703885;
        Mon, 15 Apr 2024 12:35:03 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id s26-20020ae9f71a000000b0078d3b54eb76sm6718055qkg.78.2024.04.15.12.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 12:35:03 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 15 Apr 2024 19:34:49 +0000
Subject: [PATCH 32/35] media: si4713: Refator return path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-fix-cocci-v1-32-477afb23728b@chromium.org>
References: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
In-Reply-To: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
To: Martin Tuma <martin.tuma@digiteqautomotive.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Hugues Fruchet <hugues.fruchet@foss.st.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>, Sergey Kozlov <serjk@netup.ru>, 
 Abylay Ospan <aospan@netup.ru>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Dmitry Osipenko <digetx@gmail.com>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
 Sylvain Petinot <sylvain.petinot@foss.st.com>, 
 Jacopo Mondi <jacopo+renesas@jmondi.org>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Pavel Machek <pavel@ucw.cz>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

This is a nop, but let cocci now that this is not a good candidate for
min()

drivers/media/radio/si4713/radio-usb-si4713.c:309:15-16: WARNING opportunity for min()
drivers/media/radio/si4713/radio-usb-si4713.c:360:15-16: WARNING opportunity for min()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/radio/si4713/radio-usb-si4713.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/radio/si4713/radio-usb-si4713.c b/drivers/media/radio/si4713/radio-usb-si4713.c
index 2cf36c8abdde..0ad1bfe09004 100644
--- a/drivers/media/radio/si4713/radio-usb-si4713.c
+++ b/drivers/media/radio/si4713/radio-usb-si4713.c
@@ -306,7 +306,9 @@ static int send_command(struct si4713_usb_device *radio, u8 *payload, char *data
 					0x09, 0x21, 0x033f, 0, radio->buffer,
 					BUFFER_LENGTH, USB_TIMEOUT);
 
-	return retval < 0 ? retval : 0;
+	if (retval < 0)
+		return retval;
+	return 0;
 }
 
 static int si4713_i2c_read(struct si4713_usb_device *radio, char *data, int len)
@@ -357,7 +359,9 @@ static int si4713_i2c_write(struct si4713_usb_device *radio, char *data, int len
 						data, len);
 	}
 
-	return retval < 0 ? retval : 0;
+	if (retval < 0)
+		return retval;
+	return 0;
 }
 
 static int si4713_transfer(struct i2c_adapter *i2c_adapter,

-- 
2.44.0.683.g7961c838ac-goog


