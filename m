Return-Path: <linux-kernel+bounces-72122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AF985AFA9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04EF285D28
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48CD56B96;
	Mon, 19 Feb 2024 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="5PP/5MQS"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F2150A87;
	Mon, 19 Feb 2024 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708384309; cv=none; b=e1rBNxLpjw/FoM3qHwavpH5NHUAs/iA9zYmhv9qd+6fll1+WSnb9f86Y2QAgkjT/K6Lsvgu0PVGQ9KMoe1ripwLiMr/qQluI0w2RCdvuWZZgUxMUdoo/LDJ6uviFsq0kaDXvFUCJNvElevBJdFyD0xRmEPn4KA0LnsKj3RBqr0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708384309; c=relaxed/simple;
	bh=O9YMNtZsdJs0ZoYFcgO+aLhFGygFWBl09MvW27EqzNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tZomJVfBYPP5M4fof++vyajDGPCAtfJBSMqcWbnupOYrHdAYH1Hjq1cIqG+/T+WVvii6uq9+sfwM0z+L4ZlvBl9nDTxzKrpiqNSESZPsnRHG3ABBOfR/jQ2OoVT68XTw7VKw0XETMlqlrPJreHIfKJoeyqpnqCTOQ0+C6jlFMWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=5PP/5MQS; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1708384299; bh=O9YMNtZsdJs0ZoYFcgO+aLhFGygFWBl09MvW27EqzNs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=5PP/5MQS/NZGiSIhjFC+hhb796yKqY9eIf/WVyc816zMf/ybvf5bZWh5Z/4fcd9bz
	 0JHM5PQoWge37lkmPN1ge30RyJwWZo96ZcIC2nXFRPLOw7makclHCprFkVWtrk5wZF
	 3u3qNriw4SDgdMI7C/j6IQyqU42dMGQOsn19HxMc=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Tue, 20 Feb 2024 00:11:19 +0100
Subject: [PATCH 1/4] backlight: lm3630a: Initialize backlight_properties on
 init
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-lm3630a-fixups-v1-1-9ca62f7e4a33@z3ntu.xyz>
References: <20240220-lm3630a-fixups-v1-0-9ca62f7e4a33@z3ntu.xyz>
In-Reply-To: <20240220-lm3630a-fixups-v1-0-9ca62f7e4a33@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Lee Jones <lee@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "G.Shark Jeong" <gshark.jeong@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maximilian Weigand <mweigand@mweigand.net>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=O9YMNtZsdJs0ZoYFcgO+aLhFGygFWBl09MvW27EqzNs=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl0+AmkPMYimxC9RpcBH7pJ2gK7RCa2Jy2ieylP
 OpvmUPTil+JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZdPgJgAKCRBy2EO4nU3X
 VtkcD/9fwi4fxP0SycQ4dCjxctRHRSvDpH+GAoMyZ3M2g1/fwAEId+gPCE0mNaE0WONLGs32pqs
 o9AhRwC8QFTC0XMOZ1gRGUTgmmf4a3v4o/c+SVJw6R/0IRIRbRdUatb0RnJpUTcGyuXtF7+wwsh
 la5IqIgdBfyWc3Uh7yFXeaNzYmg2J47uQDmlSPFcKcnWkM05dbSfz1chi5i75b/gta7zo43KRAI
 tAtJNP5v8JjQiEwun/g3l17xiD/mjr2W47NOlISG4DknjP55c59b5ExD4l+NyjLbQA840nLQJZd
 1W7I6Rz8x62p9slPWIAP3S7vDfArGCSZLU8YXWTZmROecRPQtGK/O0/JT4CYmLcuSD9snO5wPJI
 fXvxAmJXVeSC6FUII9yl6DkbDx78lzoVW6hrTb4O+EypMiMcdtNR7IM/NE2EDb8XRHBH6tSE3RZ
 v1KrCIFsDxvSL2eC5h5ddBRWNlc3DcNPP6qA0oXx26OjnFiFKcx1xiUUsb6qRYpi4aRnq/E8Xud
 LIo2YJkvNZKlfS9mDaXzwm58i6h8p4t+tj9g3d9ZaNTdPZt1pYtQ6ligvuLquiSSRvDa7NFhhHT
 VRxoEokazRn4Ivwzl/tAkulw+DIj2j+olzz6++dEeHA8TndVUORUpynWm7Z3AvH4S04Js4ah4SF
 wPwvHdfGVGWWKRg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

The backlight_properties struct should be initialized to zero before
using, otherwise there will be some random values in the struct.

Fixes: 0c2a665a648e ("backlight: add Backlight driver for lm3630 chip")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/video/backlight/lm3630a_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index a3412c936ca2..8e275275b808 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -343,6 +343,7 @@ static int lm3630a_backlight_register(struct lm3630a_chip *pchip)
 	struct backlight_properties props;
 	const char *label;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	if (pdata->leda_ctrl != LM3630A_LEDA_DISABLE) {
 		props.brightness = pdata->leda_init_brt;

-- 
2.43.2


