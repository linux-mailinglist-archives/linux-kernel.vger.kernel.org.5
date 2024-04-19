Return-Path: <linux-kernel+bounces-151256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CC88AAC04
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FB3AB2184D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F5885948;
	Fri, 19 Apr 2024 09:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RDXZTLyW"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E647B3FA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520173; cv=none; b=WjxHfprO40iHjg9QEJr0eT4GCrvVh3L0P7VCJKxlluufGzvrhECoMtGYWc5EXzCeJPHball9Mvj6+gEMcYNkp0DwCAOs8pelJifbDqNNALSRrKlRAeyhx6Poievbt8gkvGKt8EotYcFTfucDbEM4ai9eTA82piK49aMbos9Gq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520173; c=relaxed/simple;
	bh=+AXbzIt1DCOyX+j9nTM1S5LGWAW6l5Ne8tHYdxY2P08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rBA7nXJCu2mChZJZFIJt2DEo46G3ukeGZevkWOOeUzKFElXoZyQ1SWIlh7GOtXNI5p96CivvwxXKUPDtq8ep2HwJctdsNhENWXMsf9ndtiQHngrY+xmTzLR8IMOy3bfAchNlI/07RrND0ZmRFRdhODI/eymsyckLudYSkQPcurM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RDXZTLyW; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78f03917484so111326185a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713520171; x=1714124971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5MK517M661jXeUTMXVPJlov9z4l8/dISyr2IlNuzMY=;
        b=RDXZTLyWM1k8dfz8A7WFBrq7+rQc1zX11Zn60dcP33fCc05oAyeDWx+WhVTNfuyiYq
         SZf4mw1lAQXWdrsEEtmTze09iT73ZK8HUFB+yyMCM98PKAzQZ9yUBEwnWEYyj7UYt9T8
         xA2Rx2ovIzqhYA7DyPbfNIZlLqwxAtlu+p69s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713520171; x=1714124971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5MK517M661jXeUTMXVPJlov9z4l8/dISyr2IlNuzMY=;
        b=rogJXYF8Pyuz3UgA1UEPcjVN1Bd0SdAJOZC9b0sZeUUB13tRx2r3bzOTKju9SlBQjF
         Au5jmqWutAPS+NKp2OR4lhhcmNXAl6++/Kq8BSUi7Lj423ZD31yFtzAUCUkNWkUqXK1o
         56BFanib/M265XI4wLautqNjxsphkM6BCQRtTkiuDk5jrhqC+3uIH5OUOI4YZ+/kPYFc
         mf2hG7QYTEAIWRN2zqsECw3GgLyrkBe7u997fTm1V8ez6KkIVZK0Zw3zMFFN6BMpf5T5
         36jZ9ZGxG3EFfFmCB8xlTzeLEtNCThPJthqzENU5W+DOyNNszIH4he+FZ75pSS95CEhB
         3oog==
X-Forwarded-Encrypted: i=1; AJvYcCUHIouwX9bwMkmkX2dmtZdxbTVDXxD1j8NzlAKn06Ww1C1ewl7IGfDcVcw+c1xRm1G0FEz+XUBP0klRM96D0kkj4JqPGVUs/qmUvogI
X-Gm-Message-State: AOJu0Yxn9z7BSi8US3PYAy1ZPpTVxLL+82RzVoCBG/S1w4hgQDvalQ4P
	qiUPde1qjPPBJ6AtEGvIowsGqD8u4d/6MgdVygMmu9+Xng6WfaidlxnZ26A5MQ==
X-Google-Smtp-Source: AGHT+IGTA8hVputhy9D1xoHe1Hnr3yG2C7dQHpLq8IKH//vLRvJ+A58aCJR9JO6Y/w8HTYrMtJHvqA==
X-Received: by 2002:a05:620a:1da6:b0:78d:5065:c5df with SMTP id pj38-20020a05620a1da600b0078d5065c5dfmr1596268qkn.18.1713520171055;
        Fri, 19 Apr 2024 02:49:31 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id dt14-20020a05620a478e00b0078d735ca917sm1434532qkb.123.2024.04.19.02.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 02:49:30 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 19 Apr 2024 09:47:56 +0000
Subject: [PATCH v2 10/26] staging: media: tegra-video: Use swap macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-fix-cocci-v2-10-2119e692309c@chromium.org>
References: <20240419-fix-cocci-v2-0-2119e692309c@chromium.org>
In-Reply-To: <20240419-fix-cocci-v2-0-2119e692309c@chromium.org>
To: Martin Tuma <martin.tuma@digiteqautomotive.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
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
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
 Sylvain Petinot <sylvain.petinot@foss.st.com>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Makes the code simpler and cocci happier:

drivers/staging/media/tegra-video/tegra20.c:324:44-45: WARNING opportunity for swap()

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/tegra-video/tegra20.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/tegra-video/tegra20.c b/drivers/staging/media/tegra-video/tegra20.c
index 630e2ff987a3..7b8f8f810b35 100644
--- a/drivers/staging/media/tegra-video/tegra20.c
+++ b/drivers/staging/media/tegra-video/tegra20.c
@@ -317,13 +317,8 @@ static void tegra20_channel_queue_setup(struct tegra_vi_channel *chan)
 		chan->addr_offset_v = chan->addr_offset_u + stride * height / 4;
 
 		/* For YVU420, we swap the locations of the U and V planes. */
-		if (chan->format.pixelformat == V4L2_PIX_FMT_YVU420) {
-			unsigned long temp;
-
-			temp = chan->addr_offset_u;
-			chan->addr_offset_u = chan->addr_offset_v;
-			chan->addr_offset_v = temp;
-		}
+		if (chan->format.pixelformat == V4L2_PIX_FMT_YVU420)
+			swap(chan->addr_offset_u, chan->addr_offset_v);
 
 		chan->start_offset_u = chan->addr_offset_u;
 		chan->start_offset_v = chan->addr_offset_v;

-- 
2.44.0.769.g3c40516874-goog


