Return-Path: <linux-kernel+bounces-151255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 421E38AABFC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A731C2133B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C7F82D99;
	Fri, 19 Apr 2024 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UXRHmwDi"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFE17FBB7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520171; cv=none; b=gr4zipQW9dW705f/KPhz42LkL1K1t8i3zPVVMo/F3qxEnSKzZEWioSoxLJwREeLDiXeEZIOVfqJYZiHthyEEjYcPYqyvd/wSgiK+NcYUEiMibbaecshIIE4qsaH1ef9eUWI4p3Z6omwJhOgbWCwZ8w9UxWw/VrxC7Z/De6pi78Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520171; c=relaxed/simple;
	bh=8VkIhJC4qRo1P5qjabF5E6wLqOZFDXI1jx3/GEL4npI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U0VkyjPqpRHzssVIpZUml1PH7HYcqUH0wCtgtKnajNoFmy+Hbt3DzGsTfOA86QCHXYdq1yHA4UR53jtcSMggB5Q1iw0s+XeTqmXHiM6QYGppOqdiEVXKaH5tP11iXHAO4A+lZOf5+dnr3ugSXhgBwfMysn7VTI0Lr3VMTjFFiAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UXRHmwDi; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78ef59a369bso123582085a.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713520166; x=1714124966; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6LFW19gEC+T0JWPpzdeGsrE8gqRTr2t8fOHXzLwHuc=;
        b=UXRHmwDiZgg4fnOed5vajwDM+aHJfhFByRO/x+hO/xOFotApiMrRqtor6H3d9jqYDU
         65ZB9+Z+b95gK7NLjhiDJOt5ATcvHJxFUA91gJNARKpglhCkgxj2u4c8KrTLu8e3H3uT
         3+UMJyhlriT96lByrdPSHqYOk9ikT2Nyi/QxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713520166; x=1714124966;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6LFW19gEC+T0JWPpzdeGsrE8gqRTr2t8fOHXzLwHuc=;
        b=J761EW8562W95JSJMtvEh3mX3DL2JL/SA+o7zQKbCD1anf80XuIgM1ReNZHqHI+eDL
         awkGZT+4RBrszFgvvOp76cJKicrc6qYCF3vqY7uJk8qKd0ihiRy5TAyeR5HAEMfrteZz
         Rhs43ZY6/vumPjN8cZGkRaiFJu0Q7WjLEZEoi9Ga82EulP0fS23/HqlKEwGyKxLOaS1A
         qbGg+ZbOFYZVbGrSK3J+Rewu9XKXSV6905EeielkDSb0tkSpZd1WcjLRzlcEJOKyVDnE
         Pvv+BzuWG0Dvf2jXrE/WRJ3mMhzBt8dZLn8RLp9ILutpL1XIAhIQDutK9mZFMoC3BEfC
         1RLA==
X-Forwarded-Encrypted: i=1; AJvYcCUDufz9TXvBotGQqveai3NX5V8cOdvUK3engUCx7mgHYGfyYg+I5yJJXKngy3eRbiYx9Jdt6O00hao9pvfpJKZfVfiOH+aOqnUbtroB
X-Gm-Message-State: AOJu0Ywn8w2tjFRjho4nrY62ZKK+NuLbqyAVfwBIdi5DNRL18oRuyvEc
	vms2HYgNSMImFEITmj7mR9xbgEwFItzGVJFuquA+9qw0nEPMkudv9n2GAtAr6Q==
X-Google-Smtp-Source: AGHT+IHUtLmGGbi8XMjkj1WeDSrpOuo1PYSYaSFswG+8Ppa9nSbCTEFJOTOGzt08rmRjKE1fcvdYDA==
X-Received: by 2002:a05:620a:4586:b0:78d:70c7:af with SMTP id bp6-20020a05620a458600b0078d70c700afmr2461486qkb.13.1713520166155;
        Fri, 19 Apr 2024 02:49:26 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id dt14-20020a05620a478e00b0078d735ca917sm1434532qkb.123.2024.04.19.02.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 02:49:25 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 19 Apr 2024 09:47:51 +0000
Subject: [PATCH v2 05/26] media: go7007: Use min and max macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-fix-cocci-v2-5-2119e692309c@chromium.org>
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

It makes the code simpler and cocci happier:

drivers/media/usb/go7007/go7007-fw.c:1292:14-15: WARNING opportunity for max()
drivers/media/usb/go7007/go7007-fw.c:1293:14-15: WARNING opportunity for min()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/go7007/go7007-fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/go7007/go7007-fw.c b/drivers/media/usb/go7007/go7007-fw.c
index 018019ba47d4..86ce593e0c54 100644
--- a/drivers/media/usb/go7007/go7007-fw.c
+++ b/drivers/media/usb/go7007/go7007-fw.c
@@ -1289,8 +1289,8 @@ static int avsync_to_package(struct go7007 *go, __le16 *code, int space)
 		0xbf99,		(u16)((-adjratio) >> 16),
 		0xbf92,		0,
 		0xbf93,		0,
-		0xbff4,		f1 > f2 ? f1 : f2,
-		0xbff5,		f1 < f2 ? f1 : f2,
+		0xbff4,		max(f1, f2),
+		0xbff5,		min(f1, f2),
 		0xbff6,		f1 < f2 ? ratio : ratio + 1,
 		0xbff7,		f1 > f2 ? ratio : ratio + 1,
 		0xbff8,		0,

-- 
2.44.0.769.g3c40516874-goog


