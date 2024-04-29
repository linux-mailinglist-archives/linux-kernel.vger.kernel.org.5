Return-Path: <linux-kernel+bounces-162516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0938B5C86
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042AB283162
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4322F8594B;
	Mon, 29 Apr 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="arfppDYo"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D17084A34
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403092; cv=none; b=S04oXG0JMat91K+uuKK1o2VJ02vtY+fTCVWDZKW+Rm1GEgLQzGGjdZ0f2aG4qukbJDI465qNw53UC/cho1QPKTWAFoMqTP7uiaozSwl1xRdoKWeC82apwIVBBrsxLVQXtdf51hStn13YllBihklR0+fkkXZ3UQQND0YjqdLzTlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403092; c=relaxed/simple;
	bh=0D5nShbypA6DmVJUU2GsJZMlfeIorFidW38AxiLJVW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aaIIsygqpLvbCR8JYJ+OWumstaVODPhrUCy6NPvY/5ouySs+OUfrGKyiJCyQDQtcNMOuYgA9xUlveSbSsEhd7SJCvA/MSfGDjd8v2J0X54LmVwER1Ez9rADaWNKwu58vizJNFkqXBBcIe+X6bHP28G/SshUF5i+H4y/uLcXmNng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=arfppDYo; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-790f91b834cso71790685a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714403089; x=1715007889; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AThUs0uZjFFwmlw5yFatMODeeCPF6NJNDOtB7Vvi1Co=;
        b=arfppDYoWS3JgX2y+UJCrZIiI6qZ/f+oKfiGoFgwXz9QrJ2jNAJGaVDfaoYP24fkqB
         rgNaErjCFW8odxvKgdbqwyKY50LgpPPQTux2R6fzVqKMfxuY6ADzrdTqvBrx4SkLOA8c
         TXkAQAIfPQFE4ZO2u0KauvoN74wV08J0zu0Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714403089; x=1715007889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AThUs0uZjFFwmlw5yFatMODeeCPF6NJNDOtB7Vvi1Co=;
        b=DUUGgDDhn7OgCO50ccPQc/HLcwKWN8P0PvnBqxauUdXEoIwmyLnmY6+h847Owhl9tD
         OJ9Z8Q7sdpYtW3zshlh/S21nflLEbkRo38oPU8kNQ1f4yNgg2fzHblOFYTG5KBhHocps
         iaJlhDBc++p+uTUoUZaEvr/Iu1wYs0vzaffqrSQCw0mKtFy5d5tSn2JZS7m5x7wr29u4
         GoEZGOnAtI2cuGWoDLGrXyzuq5ys4/XzHbBnMEVdCzY/Q/uyh2PXMCm1KsdASNes2OZ7
         ZZswuXbFHEO24xm7U5yskYNpmJSpae8EnxrmRG9p9k5hj7ZoUeyQVhmS1kRj0kP7wwa5
         2Bnw==
X-Forwarded-Encrypted: i=1; AJvYcCW8LoQXqx+e0jq1dJ07OwRTOMguc4iRTIwSo1yO1IG0F65dLttAH1su+2SaB3nEhW8aQp6VCj+pNRriBlzVl4x933VSDS5vbXku9K5N
X-Gm-Message-State: AOJu0YzMYcmZ6vgk9lHxIGnLgRRBMkfe5DKVa7S52y58NkrdINKU4cRh
	8pRMGtsa5DFG+1pZSCXw5n+X5oHoLD07b6O4GSZtdOtIR9JmHYrRpT6jUo1FOg==
X-Google-Smtp-Source: AGHT+IGBuMWlT8BGDJs/bsSnyVE6ctAfT7ka0JR0PlzLBPx7ju98o6D15U4PhJiULbsFLxQvf+DlVA==
X-Received: by 2002:a05:620a:4094:b0:790:f4dc:ba36 with SMTP id f20-20020a05620a409400b00790f4dcba36mr4480887qko.33.1714403089247;
        Mon, 29 Apr 2024 08:04:49 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a056700b0078d3b9139edsm10568591qkp.97.2024.04.29.08.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:04:48 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 29 Apr 2024 15:04:45 +0000
Subject: [PATCH v3 06/26] media: stm32-dcmipp: Remove redundant printk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-fix-cocci-v3-6-3c4865f5a4b0@chromium.org>
References: <20240429-fix-cocci-v3-0-3c4865f5a4b0@chromium.org>
In-Reply-To: <20240429-fix-cocci-v3-0-3c4865f5a4b0@chromium.org>
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

platform_get_irq() already prints an error message.

Also platform_get_irq() can never return 0, so lets fix the condition
now that we are at it.

Found by cocci:
drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c:444:3-10: line 444 is redundant because platform_get_irq() already prints an error

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
index bce821eb71ce..4acc3b90d03a 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
@@ -439,11 +439,8 @@ static int dcmipp_probe(struct platform_device *pdev)
 				     "Could not get reset control\n");
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Could not get irq\n");
-		return irq ? irq : -ENXIO;
-	}
+	if (irq < 0)
+		return irq;
 
 	dcmipp->regs = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(dcmipp->regs)) {

-- 
2.44.0.769.g3c40516874-goog


