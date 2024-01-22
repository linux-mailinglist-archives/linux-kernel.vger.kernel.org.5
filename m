Return-Path: <linux-kernel+bounces-32882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F6283615E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3941C25B44
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C494BA94;
	Mon, 22 Jan 2024 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DZWsPIdB"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD774B5B1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921916; cv=none; b=VRU9X33iGrOrFbPv6gI2Mt+ILbmf+ltxYxTxxcX0iWEc//7x2fgCmenehE1r+Dq3OhLBP01cFZLvWFJhr1FRXXD8vbwRo8PYuq/epIx5a3vvPV1SB2LjA1Lb7TQgjk5UJt1XD/iYx7MYtCoOM49zq6uy2YPItHzwY1WUZNjuCzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921916; c=relaxed/simple;
	bh=zTlqsx7mKfKM3c1U7q3bgF1ozq6SPgRhMiKSXezx7ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c7/+h227b3WiS7KK2svmIV3/o/8btDOhP3XARE0bHj6Bk9/EwToTJC3L+NL3d4n8/zsfq6eaf5fJzmH46TADY1BE4q+MsWf2230ZcKf1y0Al/ADd9X0BcDu4I37GMVneYap4vb7i8FBTVIBBu7/NVvb+8AIxQImyKZgMj5laWxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DZWsPIdB; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cd0f4797aaso27930621fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1705921912; x=1706526712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQQ0M1y0R9w1O9khQHwqELj36c//l3qAUiggBNqlLWY=;
        b=DZWsPIdBczQp1mym0FAttc4bI0Z56jLIXLHrtPecYWzvG2wfd0BtJcAp67PShMYVWI
         c2y2xHrton0QpqHqni8zdwTYZxefJXYR8wWM0R2Jt12HGLRU5UCGbAjZ0iXykAEmePro
         7P67A4SMGw19iplQD+tvvYW0oanClsul6dgXEF76LqYOecRWuah6oQB8iCP9ypudOlSg
         1F8KrwGFS32CTScTkAuKEWOhZV39geFHSM0J0fQShf90DcJakZbeb2n8RjcVSuo/Ege+
         1fFkkPh0I2DNFWmFLLIMz5tsEHqZHDoubGDQyscQj6HfOzI2cXbGt26FDfLloTXTHTFI
         s/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705921912; x=1706526712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQQ0M1y0R9w1O9khQHwqELj36c//l3qAUiggBNqlLWY=;
        b=EBvI2o/27uGG4/TrgFOA+FAUzW5FFOYe07DUYR1r8RmyjahULDsjrO3FTCbaGc9CBn
         autJC2js2W21VARTa2BG8wqguiSkKAVRWDoqFxfR19pTnt73votjIiHXtNjbHY48kewg
         OLye3T7HT+N+uoTSQ4ZBkf2pcF+txb2JK+0yPAHZ60f+2wBnnQ7j9Nl3kWoe4O4wdPkJ
         uD4P1vbrjuNgwS8jrvpQ5FauMBc3ueAGKa1q4z1iGeZ4y/1iNp+Z61VFSU5/+7DyOzkk
         PRCWOuE5TCfSYn0Do4ygc+OV9tSJ6PwP6KKhBhdH1O72kodGFwVWw5+ea9/ManV+jAb2
         7LMg==
X-Gm-Message-State: AOJu0YzULcrCmQQasc7xVs8geQhjMPOUrA4jZz+w8fwFXAPgImwv0Zgt
	Isaf//a8gGHXHs+j7guS5VKrP2fPPwFoKd88TmNpfNYKpll2JN772cIP+UPc0nk=
X-Google-Smtp-Source: AGHT+IHSSE1awmKtlpENu0dlTIoJBksSl9M22BcDbrDCiSEauFdroEktdrK8UjU0sUX9a3qUPgS0DA==
X-Received: by 2002:a2e:a786:0:b0:2cc:a636:d5a0 with SMTP id c6-20020a2ea786000000b002cca636d5a0mr1683977ljf.100.1705921912027;
        Mon, 22 Jan 2024 03:11:52 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.135])
        by smtp.gmail.com with ESMTPSA id t34-20020a056402242200b0055823c2ae17sm14194241eda.64.2024.01.22.03.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 03:11:51 -0800 (PST)
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
Subject: [PATCH 08/10] dt-bindings: watchdog: renesas,wdt: Document RZ/G3S support
Date: Mon, 22 Jan 2024 13:11:13 +0200
Message-Id: <20240122111115.2861835-9-claudiu.beznea.uj@bp.renesas.com>
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

Document the support for the watchdog IP available on RZ/G3S SoC. The
watchdog IP available on RZ/G3S SoC is identical to the one found on
RZ/G2UL SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
index 951a7d54135a..220763838df0 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
@@ -29,6 +29,7 @@ properties:
               - renesas,r9a07g043-wdt    # RZ/G2UL and RZ/Five
               - renesas,r9a07g044-wdt    # RZ/G2{L,LC}
               - renesas,r9a07g054-wdt    # RZ/V2L
+              - renesas,r9a08g045-wdt    # RZ/G3S
           - const: renesas,rzg2l-wdt
 
       - items:
-- 
2.39.2


