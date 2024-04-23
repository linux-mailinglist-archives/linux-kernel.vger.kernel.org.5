Return-Path: <linux-kernel+bounces-155711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4258AF601
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD011F23F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EC31420D0;
	Tue, 23 Apr 2024 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/QIrE/D"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71CD13FD7D;
	Tue, 23 Apr 2024 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895163; cv=none; b=DXaWwLid5kR8ulIKflZngXl+qr2XvF/DqRyCMR8nJGQTlZKysUJ6r8OXrljllJhQ4i+n6PtLspCc6WTvEpSHNAaN+ASB51VnMCBm1sSgY22p4HFAAFHHqiIuANttUP+0YVGxwN40W7RYbCqvR8KM5zGSteg3Us1l73IwsETrmpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895163; c=relaxed/simple;
	bh=kOAveoyeqUZd1efPc/EGSTTdWmb/wq66OfdkFiE4P4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PSbUUscRr4ExzbPt3ZtKcutwxl8J7BcxlX3lQ2ywkHl8Gswn7/b15GA8pikPcftaoAeyXrLQ/SQKoq5//wXBxZ0SNE192fZnBkbifB887fcQ6tg+P40zochd0KATxBibsDW4/9aP4zjyOgez7wmpqJWxrvsqzorL8q2UsTBr450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/QIrE/D; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41ae95468efso1780255e9.2;
        Tue, 23 Apr 2024 10:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713895160; x=1714499960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4smdOkFXv6apnbibsUhiBNRZnnDGWylV+F3FCL/HXXQ=;
        b=U/QIrE/DCaETfbomlOLV3ms1NPfEl9m/rep+j42TPgyvY5UPMP+sZhyEamvsKNP/og
         Eo6SBTYq4WuBHw3QlZoNspaGMWeBziWyD4sOELhFqetn+3YsQuoFQrAh5JP0cBPSGR3H
         ZuLMQtkMzALfO0yQvkqBgVVd02l2KqpgDidEVBLq8cUAadMJ/LAY8h/y+nzCarYuGJOU
         RLKqwne1SKgabiqt3X++uWtyhy+axKNb26B1quPL+Q077Iv/0X4HTrOcM0U4apErcwb+
         CU8yK+0cYzwjDyFIQfh3IvGynasFgJmI8YoRm+ok+3t/y1a3AMxEAl/oCRAF03zFxXbE
         lM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895160; x=1714499960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4smdOkFXv6apnbibsUhiBNRZnnDGWylV+F3FCL/HXXQ=;
        b=cgrsV7yhKoI4KIVwNUClOie36HDDkjgHIsSWVmmTxwLw7JBh27MC4N8yf7onfiekog
         VCUaRAdenJjIawsVt8KqcOdn6xEXX+R/Pof71Obs7WgfCpZv4yfjesFDVKryhGllzYa0
         cS1bNv18ibhMOiXbkoMoJsHIfdHER2oQ+vJyTFYC8UycC6CjHOSHlqMGaqsreWTKRito
         MTcA57JHYrjHhZEkap+fpWujbACEjuiU23NTRjy1ocItE1z68gSQnYLvKXmKvWwJxoRg
         xoM+n5WdWYikxqCxTgHgaLYJ0X8IuNUEg1zyqiiXDi53Qngj5p9nd8DzSRoj71keCbfX
         bulQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+9MJeM1c90+m0NJINXONp71Jz1UWZmw2zFfE26cPhek0WQ73EE8KDsxI2lEoUePbFdsq3oo/vZB803IfgtOaHS47Zt07ZGGywg5rvC8n7DjjYNCjz/vFIpPFcI25Oyc3gy/sofJUIF5ydPKWTXotpo3Lc9dADTIIf5vlQXeeVy1xFwIahoNEfP3OO
X-Gm-Message-State: AOJu0Yw2eOFKCUKrgMi6GN/4U/EYxv8C0Cs22NFCOXVOo5gnKym6QRyu
	CYIzPY+5zbSVyhAaXC61oLzlbvnvBCxYP//a9LBQAlZnmRbz+OA+
X-Google-Smtp-Source: AGHT+IHNLUXedQfoGfcBwbl0iKJA+aaqKG0F6TiEyHRmg7KQJrlIPREFvWynPkBiGD2HU6MTj0CTGw==
X-Received: by 2002:a05:600c:46c8:b0:414:d95:cc47 with SMTP id q8-20020a05600c46c800b004140d95cc47mr1456wmo.30.1713895160037;
        Tue, 23 Apr 2024 10:59:20 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:cef0:9ed3:1428:f85f])
        by smtp.gmail.com with ESMTPSA id fl5-20020a05600c0b8500b0041abeaaf7f0sm2808145wmb.28.2024.04.23.10.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:59:19 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 04/13] pinctrl: renesas: pinctrl-rzg2l: Allow parsing of variable configuration for all architectures
Date: Tue, 23 Apr 2024 18:58:51 +0100
Message-Id: <20240423175900.702640-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Enable parsing of variable configuration for all architectures. This patch
is in preparation for adding support for the RZ/V2H SoC, which utilizes the
ARM64 architecture and features port pins with variable configuration.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC->v2
- No change
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 9bb9cc63f9df..c944d94b9a36 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -322,7 +322,6 @@ struct rzg2l_pinctrl {
 
 static const u16 available_ps[] = { 1800, 2500, 3300 };
 
-#ifdef CONFIG_RISCV
 static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct rzg2l_pinctrl *pctrl,
 					      u64 pincfg,
 					      unsigned int port,
@@ -339,6 +338,7 @@ static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct rzg2l_pinctrl *pctrl,
 	return 0;
 }
 
+#ifdef CONFIG_RISCV
 static const struct rzg2l_variable_pin_cfg r9a07g043f_variable_pin_cfg[] = {
 	{
 		.port = 20,
@@ -2299,13 +2299,11 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 		if (i && !(i % RZG2L_PINS_PER_PORT))
 			j++;
 		pin_data[i] = pctrl->data->port_pin_configs[j];
-#ifdef CONFIG_RISCV
 		if (pin_data[i] & PIN_CFG_VARIABLE)
 			pin_data[i] = rzg2l_pinctrl_get_variable_pin_cfg(pctrl,
 									 pin_data[i],
 									 j,
 									 i % RZG2L_PINS_PER_PORT);
-#endif
 		pins[i].drv_data = &pin_data[i];
 	}
 
-- 
2.34.1


