Return-Path: <linux-kernel+bounces-138665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7958F89F8D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B9B1F2F712
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF97181BAF;
	Wed, 10 Apr 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cN9CkAvP"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949BC181327
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756488; cv=none; b=ozT1z6r2kRbnyohLP48cFMQaT2szTVKq9Jjk5NEBOuhvg8Q3RS5F5j0luR/Fc0Q3hExo3CE/R84rB6D+CGxa5BfLYw0kIPngwz7/dkV5idrtVmpZuZC9gKOlBMb/sfHucNO5X1sWYH+c9Ekgr8mjBKEJ6GZs/gu39YdKL6VuaNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756488; c=relaxed/simple;
	bh=GXy2NCi8uXzU6Hc5qvGIBLwCCNQ9bIeLqQeevRksNVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZUb6SVCQTTTGxwnk1AYbABHASVLnWt3lHzU+fhAMBMe1qq0CSciXoEvY5Pz0Ww1RswOTwmlyjnmxPqUMAn3QcL8bOJ+KUfY4W/bw98w/Qc6P04ZFMBGQSQcIz0hUsUkfE6dTLRzJo1HUCYDU22YFxtW+nLE5qruGqxt2iyzpwKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cN9CkAvP; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d8743ecebdso48571451fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1712756485; x=1713361285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qI23KqzcJt38Hlh/8lKvteGzbiZhgHD+Qy4akVKdJqc=;
        b=cN9CkAvPGfmMvZq2/2zFbXC8/W29pbAQQnDraDkOj7Y7KKgZgTKr0MDcaFVkNzwV45
         UuffDlTPvw4Kfmd/ua7N7I7k4ZY1iYaCw6hgoKueKUI9txx5EvtruQpq2NE5UrJcgbmw
         mKvxjOQ/JyHeqAWTUP8EqDMD0SXjj5QAezwejWEzuBwxZKJN50iEq/QuW0FHrBABf3Vv
         Hs3yXrAkYnjO0kU0YXza2uyAjvk9i0htoLTI+oE3OI1NRhevF0X0CP/ssELZNKrN+Xfj
         M6bi9WjOdBh2rhbGg7YsZ4onA4UtqaAFpajGMe2ayUbxeOfRiGOnVOsmwYY07cWcw9O4
         heIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712756485; x=1713361285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qI23KqzcJt38Hlh/8lKvteGzbiZhgHD+Qy4akVKdJqc=;
        b=o6/KLAwc+YXg8VBjydC2RGCnjosTCX6gz7EHZyU5ysyeLhRWwqhmau90NTAa69YsKp
         qXznB9gjJEq8FZ1BlFxWlg0jBBaWzmZeUcu4Gx/YOHHdzUJuY0jtj5eBYsV385u7Nmbt
         RNJB69nlAj2T37KYKvibYmrJ2jfiJDcztoOqTg6oWjzTG4d2EVVj51iln2VcBIm+jKul
         4cZf5Ik8Oc1py5767/kMD3M9wtw63cyEuza09s6/Yeg9zZbeqD4P0pUhb0e24tpYkhij
         pm8k7rPxWgWL4XnfsdpV/pzW1CPqCZfICfK+Lf///gmVaQRWtDnfCVABYIS4EmaziG39
         8XfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr60G72Z6S9lIk4H/UXHIh6X8LupFl561aj2rL79CH88jT4/SwIP88b0XViLjCUgIoF9JHuYDxbFLqTNhyRSsCECeH+oF3/D3UeUey
X-Gm-Message-State: AOJu0YyQkJsC+BIbVIu6rW+46D3meADgEuzl6Uwa3r0qbZ4ioSr6HEc/
	hV/GhGS0nttx3fSEV1myiZ/bndQmnyx47MXHdmgcUVEMTg4v4h4NHNDz2xsgn8A=
X-Google-Smtp-Source: AGHT+IFhrlweALOximZcC0BHFuTkzJPdrxOAXLFJAQUUC628k9E6cX0jEMuaEZy3td7RELRpQOev1A==
X-Received: by 2002:a2e:8682:0:b0:2d7:f07:89f8 with SMTP id l2-20020a2e8682000000b002d70f0789f8mr2135166lji.45.1712756484813;
        Wed, 10 Apr 2024 06:41:24 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.8])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c500f00b00417c0fa4b82sm872528wmr.25.2024.04.10.06.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:41:24 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
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
Subject: [PATCH RESEND v8 10/10] dt-bindings: watchdog: renesas,wdt: Document RZ/G3S support
Date: Wed, 10 Apr 2024 16:40:44 +0300
Message-Id: <20240410134044.2138310-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v8:
- none

Changes in v7:
- none

Changes in v6:
- none

Changes in v5:
- none

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
index ffb17add491a..eba454d1680f 100644
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


