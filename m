Return-Path: <linux-kernel+bounces-40825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D92783E691
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B00E61C22C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47E86088E;
	Fri, 26 Jan 2024 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JWNTWK01"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ECA5C90E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310975; cv=none; b=OPzSoEUf8iON3gEtkBKNT8X4GWsBiL911cjGy95V/OxHCreH1oX2qVOam/mrGMEeKtW/Bm8ZHLOR9wv61TNQrD7PcdtwgdYWfq9IQKkSQGZeL0we8dDSgIo07evXKd1BBj90xNkK8RvJxfgnDQXkqQaw2+lvlO+bjyUsXBLJViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310975; c=relaxed/simple;
	bh=ewPqTDJUBftEDpihVt9+vlqkTpp6AexDsJM1tz2Udmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oh//PEgmQWH+AvYXUd1i8ws/9Aexqa3PUswyYYFCawd9NWQhlbcvNoYkAo2IPpG7bP6tL0SkjZVfhIGbhurL+YwWbxpMnYQ4U+sRHos+6jWURNs2rNf5+cBbRqoWaqDTNXL+GkJ++lWh8zMzJ139vseoA14z5cxxxDhnkgFYfFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JWNTWK01; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7831806c51bso75185985a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706310972; x=1706915772; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1vQJsjbXwMoV42WRJ/mwpke5D4/XsDiuadCHfD7OFk=;
        b=JWNTWK01ByKfjwUiUGQiNdDamXdhWY7L5zeve2AmBdi5adosdyPav9ABjY5wB919JL
         MIDpe00vcrCS9vjxPGIZgDAfp0kc3/x3FIc0cZYykEg/Fk0fBX27FiJSNJPfDByqE3TI
         bGBzjeTkBwgm55iQqC3CG+rMIvUg2EloMzO/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706310972; x=1706915772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1vQJsjbXwMoV42WRJ/mwpke5D4/XsDiuadCHfD7OFk=;
        b=ZoZOVyC+LCv/adEzCjrd90oG6g1lQD3++9mxMOOmOUkwSu+qDinnxj0zz7H1a63KpT
         Ip0J1zRXTb5I+xktO3+G7iMwb7NgEV3kMczFu5h3FfttZqT5uyMe6BT3bcoPh6Zy0GQu
         kZjukBqrH/t7ftONJosaERBRvQ3vSREsicEvJLC5HeiUianb/1fOS3cLUDIroj8zkajX
         4PE//Xu8uHRUTKSB0X+yq43YCpOeB6+YOeZBY+qcNY0I2AYIhE/crm/xAMyjGsSZ4m5U
         Kashqp/k5bonhV5yaIAf/mKcQZyRGLdHtYKpwGpYDj+rgMNgQyQ1D6++BF1ZIZyNs99/
         LaGA==
X-Gm-Message-State: AOJu0YwAScQcxkPZHxHO9N+a20i8xjWXCzD7iKOSO+cFbZfzSSkpoYpo
	3Aw/uqT0I8OnRk4neBidY1bLGu2p0IG6bv1b/mX1i3AuMF1r3NpjLIs2SF0+0A==
X-Google-Smtp-Source: AGHT+IFXn0MsvuBZAXCBvS9dkUDMWpYZYCtB32osg432CHr09P1w9jeHvq+JeL7M7GqosemFCv0Elw==
X-Received: by 2002:a05:620a:628e:b0:783:daec:2fb8 with SMTP id ov14-20020a05620a628e00b00783daec2fb8mr553057qkn.13.1706310972372;
        Fri, 26 Jan 2024 15:16:12 -0800 (PST)
Received: from denia.c.googlers.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id m4-20020a05620a290400b00783de3ddf5esm507358qkp.70.2024.01.26.15.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 15:16:12 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Jan 2024 23:16:06 +0000
Subject: [PATCH 07/17] media: i2c: adv748: Fix kerneldoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-gix-mtk-warnings-v1-7-eed7865fce18@chromium.org>
References: <20240126-gix-mtk-warnings-v1-0-eed7865fce18@chromium.org>
In-Reply-To: <20240126-gix-mtk-warnings-v1-0-eed7865fce18@chromium.org>
To: Tiffany Lin <tiffany.lin@mediatek.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Yunfei Dong <yunfei.dong@mediatek.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Bin Liu <bin.liu@mediatek.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Bingbu Cao <bingbu.cao@intel.com>, 
 Tianshu Qiu <tian.shu.qiu@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-amlogic@lists.infradead.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.3

The field is gone, remove the documentation.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/adv748x/adv748x.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/i2c/adv748x/adv748x.h b/drivers/media/i2c/adv748x/adv748x.h
index 6f90f78f58cf..d2b5e722e997 100644
--- a/drivers/media/i2c/adv748x/adv748x.h
+++ b/drivers/media/i2c/adv748x/adv748x.h
@@ -173,7 +173,6 @@ struct adv748x_afe {
  *
  * @endpoints:		parsed device node endpoints for each port
  *
- * @i2c_addresses:	I2C Page addresses
  * @i2c_clients:	I2C clients for the page accesses
  * @regmap:		regmap configuration pages.
  *

-- 
2.43.0.429.g432eaa2c6b-goog


