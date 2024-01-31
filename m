Return-Path: <linux-kernel+bounces-46217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7FC843C60
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4EE1C29912
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8854F7BB16;
	Wed, 31 Jan 2024 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="fcUhICZP"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19177BB0D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696449; cv=none; b=jxS+LZMf5+rc/J8PRM2hvgFbSfTF2GcHc+iFv4pIhpABTv7Fngnb5vK0WYbvg0KiP4+FBCnAdB5dm3psN1EFo16kbWcs2LLUg7OowLDxr6nxnjJm9hC3Nq8ez4Ir3bl0r1EjgcVCRzPqgn44EvoMAB0HFBJjjIHM6CnxAvEfLKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696449; c=relaxed/simple;
	bh=wT2twA9lBFQ9GfBDBM65zJOM0hifl2dwZasWPoBrtWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sJmJGIDoudAenUsKzJ9a9mvANOdZRCEHiik0ypQuWWXPUYbsf7mSZI/tnKGHPcpV7QJ59zClJiAkJYj19Cyeo3E/5IBYlel0sX683qoCu2GL1FgHhz+WCkPUGaQF2idbRFvHt+GGGURgdH8YZVyFrmhHj7ljwH/nKuN7KFUDbOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=fcUhICZP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2a17f3217aso686947766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706696446; x=1707301246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cEqK4k1A7PVq0QJziHE6k8iVWTQh9yIWRh++Qn1t9A=;
        b=fcUhICZPGSIa82MpzbXwIBdXgsWC7+x2I4AZ5wlTGDTDBqZ8xNRjmri13y/afrmhLP
         M1gcAvsGMKf6cZAV4bg7hProNb9znfoCxhg5cv2Y2yfOBLfL3u6Rw++jostXa1eEV+1V
         mqWbz4Z767YqdAFIMmIjWYkl39Itqa3nV642LOv8Mmu7HbwbX7i48SoF0OOP0mZgdCup
         kcI6CUkMwOwMWPOYm9JpwqFhPkKYZH2WSLlG99UWQIhUSJFJbK0xu+eskCxsGIHub/0m
         kH9itJegyjZZkzCmkFLtyG/T9NMizoPFPIBrxXOnRC7+5HYSocIdpK4zI62K3McRdhG6
         fweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706696446; x=1707301246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cEqK4k1A7PVq0QJziHE6k8iVWTQh9yIWRh++Qn1t9A=;
        b=a/uKX85INFNrC2Wa2dk8gwHMOYXw5TK3nHXWhCsp9lFHkiX0juE6HtiA//i25Cq6Z6
         NzRlsiHfitdPRi2JgIBtQ7phajCTfXBPTGC/uCUnGdr9V0TJLMxviZD90yLoTztiaCns
         fSyyrioVhQc1wUb5E+gE325S4IcwfX6qZaRouTRvAH/SGTeP05NGQtXnzNXvNDGfCBJm
         vaWlcKnpY9YoW/4OKUa0FTBsVBfDfsgFlzPFsWk3RvcmjX9WZOZmZ62Q0awxqs3nTIhp
         gmGnc/KDdP+IQB89R+s5LoOGyzSCZp8a9iLSTlh3lsE9NmDFQyWjcRaBOIIMyqIwNIuH
         jq/Q==
X-Gm-Message-State: AOJu0YxQegtTC0TADPEa0c4Pb4Nw82EZmVCS2eh8O6JAjB3yytR7nVFK
	5e40SA0IGQoi+HMHA0uTsq+qzHVqijsI+52r+Ob3YFtQFjvGWr/xa9R6jiEOEXTtcoTpVama3tg
	O
X-Google-Smtp-Source: AGHT+IHaruO06vu0kGjs4fVXjxYqlkZO5gWImdkgO8i59fTy0v8FKtn34c2CwaOEyfCvlfz6+Bu/Zg==
X-Received: by 2002:a17:906:7fc9:b0:a36:8b9b:bc1c with SMTP id r9-20020a1709067fc900b00a368b9bbc1cmr354388ejs.71.1706696446075;
        Wed, 31 Jan 2024 02:20:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXkZpikAZ1gjM9N3uZkKy1KiYWhb+LW7nmrtHggi4T1YOS7pUcDxpKM9MasBpWNrR+lGhTEpNuGopVk2ok3CAS53EIKVQZXGVcpznPZUixLv9TlBJhb3BYdr54gqaDVxKESFTHQLZ2Zfde3FGRday4OCNKe5mYc9/JzGyJzPWbSgyhUOwW87KidZI5I1B5K14Q+C8NHTp6vDUNIyWDm4jlP3ugSG41QidEE13lsai097p/TvfbYp2keUynLLFSVrdiIyntAkmNcWv38GCGtvUKlTqA+SYsLpWokEDKL6viW35iObmZ4PV5SowHz4up/ujXFuo5qshCbLZu4Q6icGJa7nmq5idcqhj/dGo+AZY6TxAS+8xxUoTT3ExcXGkBK8kUqVYncL/LgievwmEO92f4Rye/s8c4gYngEc1Kw6xfv4AqXmuiYAy+qFX58nNogufN3ATFIoFnK+NbnAOan2wWfDsjbI1oknZ+COywXK1S8iwPC7mSbK7zc7SxdGWpTeKsaDTWzKrdyzLmNZ2YndKiFWocd1iD96Hm8/CazyJBYBJQGHvDWtpq0NHvUiAw/Fa1PfbodEn/Is2CxP5tNbjPQqhkeqEapy0LKTsziHWdYarU=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id vk6-20020a170907cbc600b00a3524be5a86sm5212966ejc.103.2024.01.31.02.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 02:20:45 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	biju.das.jz@bp.renesas.com
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 11/11] arm64: dts: renesas: rzg3s-smarc-som: Enable the watchdog interface
Date: Wed, 31 Jan 2024 12:20:17 +0200
Message-Id: <20240131102017.1841495-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131102017.1841495-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240131102017.1841495-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable the watchdog interface (accessible by Cortex-A of RZ/G3S SoC) on
RZ/G3S SMARC SoM.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index f062d4ad78b7..2b7fa5817d58 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -336,3 +336,8 @@ mux {
 		};
 	};
 };
+
+&wdt0 {
+	timeout-sec = <60>;
+	status = "okay";
+};
-- 
2.39.2


