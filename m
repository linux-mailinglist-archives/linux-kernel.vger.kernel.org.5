Return-Path: <linux-kernel+bounces-145798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93DD8A5AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D6C5B22F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7375315F335;
	Mon, 15 Apr 2024 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Aw8PVAeS"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EC115E5DD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209690; cv=none; b=k1CkimxhUHuv5hiIBKvCyQh0zhvqr01Q2eEU8QwhKHbpFcej05hRCEk+6SW0qgCfXHIac95+r4H6PtcfNHlzZ6i45hqnOvx+tcQLlJyMJL+yL14GckeEJspqLOT/Y0imGtqVap6NnPIfW9wZGrS2lxTD61lgyaKN4XiSEqhYdGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209690; c=relaxed/simple;
	bh=QMsjv+wettsGw23pqby6M5jpWOg9Tw4lhss0lX66IJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jrxRFGboC0bpV1sa93a/hZAjVP+2JQhzpTLYFBg9auAAF2NkHLM2qyT1YLxvYoj9M2zBtJlJney/eWuFKIGrFCGRCPd8lAJF1+4YfbJfyL7Wo7Iq74bwogTIguh23ExNc7ibce7CX2Z1CefDO4tE+eKxY2+JyyQe2TaV8g9Cn0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Aw8PVAeS; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78ebc7e1586so472920985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713209687; x=1713814487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VH1TTY2R78PVfXYnT8sQaYwvCkEpO00JMLA8gBHoObU=;
        b=Aw8PVAeShZ4GKhUDYCsi2PsqSye237i9HPTPm5MU6c/HPaFPfsyJtQd89eZHNpm34a
         383SVnae4OoILq4kG05YEdXY9ArcAK+nX+5Ku2mIY+EiO3aJDpQuTbjmNjkWlMwyTPQJ
         6JDOEM/aiAPq5mgjy4d/Q3LEkvJKRx0KgKrMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713209687; x=1713814487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VH1TTY2R78PVfXYnT8sQaYwvCkEpO00JMLA8gBHoObU=;
        b=Ogn0r405rdFuXkaxQn3O7YYKbPHJHJb8TPMuP+LqfXvjq4e8eAlcs3PSLgjifl7FRg
         vtLsbWcHuH4JcPyiCxCrIXCT+5WfgHnQv8OxXe3agDmCn2jZD+CC+8gvOso3JXeL/i+i
         mDa5d7sDq2a7tRN0oXOdQSmgwm2np/vcUqaWAcqNQmtgmmwRfo2qXs5YNzLceh+wYDPD
         FLnhC0Q+Lq9QA94WySfX17oyVAjpYlTTZilrGiqvlmQfqbHrENeMGTFJ4aZ0nvzgpyQu
         15/3UG4PsCwqrhd3NKR6qqREAiEOATnMn8DZBGrFow8amvB416L93yPKhUhRn9mYvjip
         lGXw==
X-Forwarded-Encrypted: i=1; AJvYcCVfEOsc4pN9Ldm1JMvxavPehVEl3mwgbmxJ7TxLg2p1q4FAROqoSKrruQ8ymENIwtpcDF5Z1hpJMjgNquYJHFhuVzKHWhQ0FIqMGMZA
X-Gm-Message-State: AOJu0YzRpNZm0Q+q4t1w0Ss/DqHJVMB75AwpqiYPOIU5KymVEDGIjpTD
	2IYvS4ks3eFRWSGGZzdbOaiHaDmYIc3m4ve5dfNaY4fFluqulGgRMaPM1qU4TQ==
X-Google-Smtp-Source: AGHT+IFZZwBtLZMDNfJayMBU/PaT+EdKNrIoBaFoYxfd58lYWJrbZu6cOvIxZ8QNIWMRuOhipLdFVA==
X-Received: by 2002:a05:620a:2953:b0:78d:61fe:77c6 with SMTP id n19-20020a05620a295300b0078d61fe77c6mr1118634qkp.2.1713209687511;
        Mon, 15 Apr 2024 12:34:47 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id s26-20020ae9f71a000000b0078d3b54eb76sm6718055qkg.78.2024.04.15.12.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 12:34:47 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 15 Apr 2024 19:34:34 +0000
Subject: [PATCH 17/35] media: flexcop-usb: Use min macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-fix-cocci-v1-17-477afb23728b@chromium.org>
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

Simplifies the code.

Found by cocci:
drivers/media/usb/b2c2/flexcop-usb.c:201:8-9: WARNING opportunity for min()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/b2c2/flexcop-usb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/usb/b2c2/flexcop-usb.c b/drivers/media/usb/b2c2/flexcop-usb.c
index 790787f0eba8..3ba6a5ed7167 100644
--- a/drivers/media/usb/b2c2/flexcop-usb.c
+++ b/drivers/media/usb/b2c2/flexcop-usb.c
@@ -197,10 +197,7 @@ static int flexcop_usb_memory_req(struct flexcop_usb *fc_usb,
 		return -EINVAL;
 	}
 	for (i = 0; i < len;) {
-		pagechunk =
-			wMax < bytes_left_to_read_on_page(addr, len) ?
-				wMax :
-				bytes_left_to_read_on_page(addr, len);
+		pagechunk = min(wMax, bytes_left_to_read_on_page(addr, len));
 		deb_info("%x\n",
 			(addr & V8_MEMORY_PAGE_MASK) |
 				(V8_MEMORY_EXTENDED*extended));

-- 
2.44.0.683.g7961c838ac-goog


