Return-Path: <linux-kernel+bounces-54447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2AC84AF62
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD29B1C23ECC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C3C12D17B;
	Tue,  6 Feb 2024 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PCGSyNaK"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA7C12D15E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205946; cv=none; b=Ub0NDa9WsJdAZSaezj0/KWHLiXH/4sMIeUalQ6QTquE6CXK15gvi58qTytp4LstkT8gs8XEXAnmz1vO+TBfaGuZUTbC8qgBecA6BIL6H7vAMxhhsd3u0vBNKYy6YjXIZerpVQvOKw9PnBjpRAUY9nk+TQDZy/+X+zL0biwBdCyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205946; c=relaxed/simple;
	bh=vR/061UDD5TR2oXq7LH1zZoAUat7cIdF/cOUx86FGVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iUBpzfarF7fR/LvrJTLrQKBWVsnZytzxjKlDmoUESXWecCK09knshcUtxT+/haatG6c+YODb3GGN3hT6rCfirMrj/sDDzH2lFfta0tlquUoOWhaMzLezlDxarUxwRI7DKNfQ4CjEvcwikQ2x5dK9YssfP+N6TQqg7XhX84Hw9W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PCGSyNaK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fe2e746bdso2619285e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 23:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707205943; x=1707810743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nslo2KqQ/crFqeERQmjq+RimgA4EmUsTWWhunmms0IA=;
        b=PCGSyNaKpUdTBV44ZY8r19owFJGHQLPyEeECUal6K3csajvkOmHc1MrAPlCQtKijjH
         qtcDgNmt4Vr4Je1DEyR9RK3xrosIn5z0eYf2XiIMOMhgyweFresF5XtPSo1y1an0nP3q
         k0iyrZfQlZsxL7lXQ5ogmh561ukWXn4W+uKVin/QLHyfMOAGYn+I66GOaYI9EU9Zyy4/
         HNQS+I9OHCoFbAfAVQImEcIRZidlBSlCm5tAATMXEdn1jt82xTxQ54aih+l27Aklq3cM
         a9G+K3vqWCrY+Wre+6C5M/rS3U6b/J59ku1aZDdiSP6gTQTSwombUEbBgGqTB4Okx90T
         5DFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707205943; x=1707810743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nslo2KqQ/crFqeERQmjq+RimgA4EmUsTWWhunmms0IA=;
        b=gDD8E7/01A17e1329eBxeuDbwvHyjxZ60AtS3/mUflVltDHHyIysvxLwmNRsm4YXfK
         A+Nr/5mPRt3VPH6KYNJ2rePjyqpysumB4NhL/HfqD2kBGCv9XJtcMbm86zJ4wLEfAhVj
         hiF+g1P+CnBGV7rty1PxHRUdiGaN7rIDtwLwecFCobHSsVSg9fy1M7/PSi6f5IgCMHAi
         Nc4jTyE8xVeY514JIKSH3fA9Znggu21GOBfgkzPA/v+DeNoLZZbMrcm/XBdhfbCLVFkH
         Am9hG+n1MPBuGDB9ZPScfLp0fphCqOzJkipYcalj0Ib2IY2HVTbqBWeNrl7UO61eSKew
         y/Ew==
X-Gm-Message-State: AOJu0YzETx/6isfDIuOfzs4QZ3pqqUNXcZ//+wEvCQhSNjBcrOtDOwxO
	MLLzL5CPqtNfhlCoExTPmPt8PgQ67jHtMvHSg3Gyv7KxoVSI9I+lOd+bnMB/4o0=
X-Google-Smtp-Source: AGHT+IH0DcABr6gfcMRuxGn3CUTdqmHBzNB66l7a8pXOCpsFRKIZ5TZrhJVEsEPoXJfelqK22/1wSA==
X-Received: by 2002:a05:600c:a39c:b0:40f:b283:bb00 with SMTP id hn28-20020a05600ca39c00b0040fb283bb00mr905382wmb.18.1707205943227;
        Mon, 05 Feb 2024 23:52:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUByh8gVDOXfKSjUHDj4WM2iwjOaOi+9J3toa0ywjhR3II4dU3o9/xJri/AmIRviLmjV78QUbbf/HvcU649LBSZdQPKGCk64WxZQD16KXO1YSke2CvHYlX8q1WajPTf1CSR9+uyHq8rJXbkCXCNVl5g4JAErCysyVMxGFiORo5GkNF97ejKsuyNeDv41fvIp5RXaQjIR7aG7BDz3gegTI6uGe6hAWpM2ihYg/kmQudwmFVpwpqLZEjuB9e7ncXiS61MKrDvm7vTwwvkulylQX2AgAkpAlTk2+7xyrQJBnH4lP5pxiAp/hf88OF0HyafUY/uFY2RVujXTtukqZqlgkhY4z5H+X7OhkHjoFyp+Jks+ItdvRkf2OJLMGUPmZintxSbTCbUQi77MZfYSVH2SRPSls5a9lbovCxxo+Hq23ipc/yvd30oTCROiomILHQXVqgh3K0iDTl/g51gT5QLNDDCGOKB0mz5Ik44D9P0o6/BvkRxZupdukyY/ipnR+TItJcxCLfcZ4DcAfVaoy58d6XzqhsJG2yttuR1zAOSFA94+5aAdUM=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.154])
        by smtp.gmail.com with ESMTPSA id j32-20020a05600c1c2000b0040fbad272f6sm1106843wms.46.2024.02.05.23.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 23:52:22 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 9/9] dt-bindings: watchdog: renesas,wdt: Document RZ/G3S support
Date: Tue,  6 Feb 2024 09:51:49 +0200
Message-Id: <20240206075149.864996-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240206075149.864996-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240206075149.864996-1-claudiu.beznea.uj@bp.renesas.com>
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
RZ/G2L SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes in v4:
- none

Changes in v3:
- re-arranged the tags as my b4 am/shazam placed previously the
  Ab, Rb tags before the author's Sob

Changes in v2:
- collected tags
- s/G2UL/G2L in patch description

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


