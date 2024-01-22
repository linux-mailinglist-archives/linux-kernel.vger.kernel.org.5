Return-Path: <linux-kernel+bounces-32883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F535836163
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5192867D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2114C3AB;
	Mon, 22 Jan 2024 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="efZ8CXDA"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0DA4BA9A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921919; cv=none; b=Z9US5Dfhdceho6wRc2Bho59oPPhVGTUShiPCBvEluyF+4oATy3VFZl1RZc8ReQH7vEg+O0VDYNxs5gLkiopFzfvShty2kBeCwYA1CsNjUxBTOyuXsALKhidS3P1vr8ijHgsr3GztFh2oAK9/6D7+KlBipyKIXXzoX1mQ45cxSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921919; c=relaxed/simple;
	bh=ifaXXPlzQ7Cc0JIuS3Sr1nJdIEtZglhNMQ0Q1KYtPVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TbBtH2wAlMpsVzgJEkm/Bf14M3lkmiengjW8ejbvioSEvbLN7UGb+TvNrDEAuembwznrb/tj/NCgj6tgl3XZvXOXcylA7ooTAOPXxzCK7OSvJkYtL4lG1p8qzpAcQ57Tj/903DIrmRHXnxY2egBpc7NZpV2VJF7CJpPc5NggdpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=efZ8CXDA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so1865190a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1705921915; x=1706526715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVHTL5RIY+bNimER8/uVEqIPwk3bXfvGHZ/DYHY7974=;
        b=efZ8CXDAowoAVM6HA9+9w0thUwU1A2Zdw3LGpPKDmRF3HRGK0Ac+aaDzVEW+WxwW0G
         uiCpKZ6A/8Svl92HuNADCy7qFAwwHOqu134KP/3iSVwDbjrHdNZpcCeOxS+pAIpPghfu
         CPhJj2g3IR29NP6+KxodcKiJyTnsdRQByT4+oFxRZzYvKnXBCa9s0NfFYrLWb+KuUjNl
         uzXqdHCzDSDDf/bhtqPIrCZH9TqlzXuv8BwT1QqBUbDUFQyeVjpkonk6II3kDkHR/jrt
         pGl+TQO+WCxusk+D7+krBRe6a6AYqOeW/E18RWblllUPb2v1K1mbEXHAGnpqbBXE2qfp
         0mPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705921915; x=1706526715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVHTL5RIY+bNimER8/uVEqIPwk3bXfvGHZ/DYHY7974=;
        b=HlwE/Us8N9G3xUT3wlKQzhILvAHGoUY042kJLU5e/kdP/IsCDkxzsqVDfxlflPGfZ+
         VY9AhL650oBxM+LVfbGK1q0zlLgb8zy98fJuWISPw/peNBhmwCmNVC702mwzGjo0MPPY
         9eCniFmRVlNfROQFlUpo4YO/fHCwFXG36rqRZmsEn+Bv/JpF6FXT1hIi6QrL/6tJ9djh
         rsk7i/iJriQNoRrH5hC/Y43r2QZIWpBamUrz02ah4ClL2GmYwmbs1Y4d42QtkPAEfBd6
         3QyeWbXC6c6vAp72APaViSFc7LrnVRXkeA/EBRrkZgW7RSvOnysrffsG8wx+VgknuIaB
         6K9A==
X-Gm-Message-State: AOJu0YwKVLvCIxWmc6Bz5P2NY0c1o2myjDUONRbA4v2yzmwNLbetakeD
	HDUQPNtwpG5kjkMqYINVE/TLIVUXThssiyXcMjcwYk7gPEXQ6jPkC7mP3BDoUaY=
X-Google-Smtp-Source: AGHT+IE0QOOQauPyN7jiBB0wkj3vCQ/E4lksKRkdsglPNnpXOAnRbWLas218nPffKQxKybxy6Cr8AQ==
X-Received: by 2002:a50:e614:0:b0:55a:6dc3:59e3 with SMTP id y20-20020a50e614000000b0055a6dc359e3mr939510edm.139.1705921915306;
        Mon, 22 Jan 2024 03:11:55 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.135])
        by smtp.gmail.com with ESMTPSA id t34-20020a056402242200b0055823c2ae17sm14194241eda.64.2024.01.22.03.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 03:11:54 -0800 (PST)
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
Subject: [PATCH 10/10] arm64: dts: renesas: rzg3s-smarc-som: Enable the watchdog interface
Date: Mon, 22 Jan 2024 13:11:15 +0200
Message-Id: <20240122111115.2861835-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122111115.2861835-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240122111115.2861835-1-claudiu.beznea.uj@bp.renesas.com>
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

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
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


