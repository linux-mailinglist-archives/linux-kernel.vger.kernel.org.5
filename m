Return-Path: <linux-kernel+bounces-95697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A96875165
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32F81F24AFF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5032612F39E;
	Thu,  7 Mar 2024 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZEPoQr9I"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989D812DDB9
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820473; cv=none; b=ee84er5nkH/ce/OrHPdnzRQ8ee5P01wd1eDLZYmIsIa67aUNtn0gYeVDoryAVCARNqRJv0VAjQKYnYhqTcD+bftG+Xt3+Ko+3CdTUu4Eh55eYFfBpgHgdANcF5Mt4Df7PZp0OL52+7/7PrzUXVknfIniAfGV75fKr21c2+jdFcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820473; c=relaxed/simple;
	bh=XwJePHR8JwAlM46pqy20irY3849tfnaYAJPxlYfkslU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kbujp2569QXc80bYPtuhbs6BQOi6dqxHYwjPAnmuQvIQd33PNO0+iT++E0U8Si+XbhiVfBHKxkvagizhCDhovddWsGk5OHYpTgBKvhRwwkTlfyXI/P0R23TsM/VIwUKfbowCqyIudIinNkTLsgJeX0qy0JoqQ+rTobHlAS60XEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZEPoQr9I; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so153876566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1709820470; x=1710425270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3CLBaLmfGzBk9sYN2coRPBc2x0uVbMYMLbwW+J65ZE=;
        b=ZEPoQr9IGxV+X8SiFgRIA72A9RoqSxqAukvzTb5bhTJuEj1tC9OODVQLNIjoDtIJmr
         TVDoyi3bBqJBuPr8ZMOcsFaTjTuNDAACJ3XKgBVn8XD437OfWPoAcfbue43/0xri6+lM
         cKVfxDn9u6A97UIIsItF4tGpJVEe4w+FlHlrDCNIsWIvdtwHaPmVBDlF44xG1pq7Ii2Q
         jmPgN1N62cUX2bjqZZBIRn2kIBwsRJA/pqm3qsvjv5FAtjWByxhOcvy/9hXXp1pxwMlB
         N7Jgwbabs18SFo5gn5/mVBWOG+0rVdk1vs5cTZ7kgnhc/lZ0764+erEBVnQc4DMyzwWM
         oB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709820470; x=1710425270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3CLBaLmfGzBk9sYN2coRPBc2x0uVbMYMLbwW+J65ZE=;
        b=fgkEUmtPGFhcD4opX2mXXptgTQubhSOnQaSbuWSpscSnarCzcW7hoBPpf3wgkCuV5c
         xxJNzEEKzuH8u1KmiD5XwkgQonmc+aJ4cuhRdJQZF7E6lFAF4Z76LcdEK5BIE/45PjA3
         WqHcrYUzJ2qKeUz+1i8twvLxLjdenk8cj6Z1ntiiqWFwlUtpDsE0h+j5i0v/6zAU8yUp
         CWPH5ceK3sgWHV0Ms+JZbmyTmM3Nqk0xwwqtMyLb6QK5MJ+khWbztJOWyNHByWgMKYcB
         qvjr85RbIBVuWgKOIgIPUGO2DBons+UHQgfCr5alk2dyVTM6h4t5Br3lK1IgKBcAmmOn
         QKlg==
X-Forwarded-Encrypted: i=1; AJvYcCUJgCioP6xrPJvKmrHmMsxSOvcNpsfEeCLXePv7uL9anX7c7J18O6U4F29MB/kZPiAyqTz44qKdP5UIrdqsXf6tduKuwtSAdxVdbUTl
X-Gm-Message-State: AOJu0Yz9HPub6tGtdE6MRGR/x3duI/3/xArtDZqzP82RJkaMQwWlMZsg
	E3kluhdGz48UrqzjYJOMsI0vfsxeoP6xirTl5wCyZr1rNIpM8NINTFgAP3nO0kQ=
X-Google-Smtp-Source: AGHT+IGatn/XfS6VmNx5vTLwO1xoHqWIlZ0V06r/HAylNfXwQY9U+fAaiRRmKabEpEgvfWd+vnD2vQ==
X-Received: by 2002:a17:906:3846:b0:a3d:ed30:11c8 with SMTP id w6-20020a170906384600b00a3ded3011c8mr12781367ejc.15.1709820469848;
        Thu, 07 Mar 2024 06:07:49 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709067d9700b00a42ee62b634sm8200648ejo.106.2024.03.07.06.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 06:07:49 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	magnus.damm@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 03/10] dt-bindings: clock: r9a07g054-cpg: Add power domain IDs
Date: Thu,  7 Mar 2024 16:07:21 +0200
Message-Id: <20240307140728.190184-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add power domain IDs for RZ/V2L (R9A07G054) SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes in v2:
- collected tag

 include/dt-bindings/clock/r9a07g054-cpg.h | 58 +++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/include/dt-bindings/clock/r9a07g054-cpg.h b/include/dt-bindings/clock/r9a07g054-cpg.h
index 43f4dbda872c..2c99f89397c4 100644
--- a/include/dt-bindings/clock/r9a07g054-cpg.h
+++ b/include/dt-bindings/clock/r9a07g054-cpg.h
@@ -226,4 +226,62 @@
 #define R9A07G054_TSU_PRESETN		83
 #define R9A07G054_STPAI_ARESETN		84
 
+/* Power domain IDs. */
+#define R9A07G054_PD_ALWAYS_ON		0
+#define R9A07G054_PD_GIC		1
+#define R9A07G054_PD_IA55		2
+#define R9A07G054_PD_MHU		3
+#define R9A07G054_PD_CORESIGHT		4
+#define R9A07G054_PD_SYC		5
+#define R9A07G054_PD_DMAC		6
+#define R9A07G054_PD_GTM0		7
+#define R9A07G054_PD_GTM1		8
+#define R9A07G054_PD_GTM2		9
+#define R9A07G054_PD_MTU		10
+#define R9A07G054_PD_POE3		11
+#define R9A07G054_PD_GPT		12
+#define R9A07G054_PD_POEGA		13
+#define R9A07G054_PD_POEGB		14
+#define R9A07G054_PD_POEGC		15
+#define R9A07G054_PD_POEGD		16
+#define R9A07G054_PD_WDT0		17
+#define R9A07G054_PD_WDT1		18
+#define R9A07G054_PD_SPI		19
+#define R9A07G054_PD_SDHI0		20
+#define R9A07G054_PD_SDHI1		21
+#define R9A07G054_PD_3DGE		22
+#define R9A07G054_PD_ISU		23
+#define R9A07G054_PD_VCPL4		24
+#define R9A07G054_PD_CRU		25
+#define R9A07G054_PD_MIPI_DSI		26
+#define R9A07G054_PD_LCDC		27
+#define R9A07G054_PD_SSI0		28
+#define R9A07G054_PD_SSI1		29
+#define R9A07G054_PD_SSI2		30
+#define R9A07G054_PD_SSI3		31
+#define R9A07G054_PD_SRC		32
+#define R9A07G054_PD_USB0		33
+#define R9A07G054_PD_USB1		34
+#define R9A07G054_PD_USB_PHY		35
+#define R9A07G054_PD_ETHER0		36
+#define R9A07G054_PD_ETHER1		37
+#define R9A07G054_PD_I2C0		38
+#define R9A07G054_PD_I2C1		39
+#define R9A07G054_PD_I2C2		40
+#define R9A07G054_PD_I2C3		41
+#define R9A07G054_PD_SCIF0		42
+#define R9A07G054_PD_SCIF1		43
+#define R9A07G054_PD_SCIF2		44
+#define R9A07G054_PD_SCIF3		45
+#define R9A07G054_PD_SCIF4		46
+#define R9A07G054_PD_SCI0		47
+#define R9A07G054_PD_SCI1		48
+#define R9A07G054_PD_IRDA		49
+#define R9A07G054_PD_RSPI0		50
+#define R9A07G054_PD_RSPI1		51
+#define R9A07G054_PD_RSPI2		52
+#define R9A07G054_PD_CANFD		53
+#define R9A07G054_PD_ADC		54
+#define R9A07G054_PD_TSU		55
+
 #endif /* __DT_BINDINGS_CLOCK_R9A07G054_CPG_H__ */
-- 
2.39.2


