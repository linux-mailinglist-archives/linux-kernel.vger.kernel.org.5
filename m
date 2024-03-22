Return-Path: <linux-kernel+bounces-111687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A695D886FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2B91F230DF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AA453815;
	Fri, 22 Mar 2024 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCB+xVGW"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1764C601;
	Fri, 22 Mar 2024 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120429; cv=none; b=rMaKmHqklfC8f5/vFsaK16ivQTU24bbkGDEzP0ouCat+f01VZCJVxIfuspn2C7xYt4wggm2Fa7uUAUQbMSAZhqh1VckOBsdvuf8PG9kklaZuQiFuMHqX4UvKpZ/o+KhApSrduqDIZ66dy/BDoqkwlz68IXhYMdQmEuAerhTAH9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120429; c=relaxed/simple;
	bh=Mtx4UlDCoD30gYNXnL0H7Veu3VlcdwrFVjkH1VRFDWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yhv+1NsnQ3ifzy5idN5QGBP3LOHwLSBrhoDuGuCgLlrxEnPW2OtsyDGZB5MSxrpVv/mN/kyESCmUWqLlYWQ4nNJbP+9K9eRpIF5oPk5rdcKHn5lHrxMl0bz3cMOHN4GiSr7/jGbl4zPziLNVXMmAWPXwgm0H+wcyUPEk6HaKpQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCB+xVGW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4146e9e45c8so16348225e9.1;
        Fri, 22 Mar 2024 08:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711120426; x=1711725226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63C607gHx9pywKiULwhlpXCQK4+G7vLtHWHwiOZNKFo=;
        b=RCB+xVGWqXhyt1ezJA566LQbse+hyk+imAsGknFQMeXANx94hVQfhcVE1fQ4QVuXaU
         naWiaAUm1U69Vk/lEANNqe7KHvnACqFCTeGpKtS4EOzz0p+t/7yEJ9FKUY8JXE6uUz7e
         cfsL2759zDAfZke3wJ+Zl6aN3i6cnauJlDX0STQh6/PHKAvwCam5zEvPI0CKYJ/aQS22
         LpMWz9UPz7oVBnGcBN+t2cqcFPK4NOw7029CEOtSbaczfsr8jkumMceDhj3I+uZI5V47
         /DWxPhfo8FJsgid0d45Ru3K6OFOrQH/PlwZySmtnYAU/yi72sERH9pXqC0ToJXmLcP2a
         UOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120426; x=1711725226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63C607gHx9pywKiULwhlpXCQK4+G7vLtHWHwiOZNKFo=;
        b=I3sdsdPTtcGWbQcKgC9+ZoccfH7p6fkkvkVzJEtw8Gh+C/rBQXL+H30zQRFtAJjL4M
         Z2H2Q28EmPTupH3pbVM7qeu1tyn0tYSBw6zPMDM3AdXq3OL9OUsokAJLzPtPFjidUi0Z
         PjRour8pEihZpEY2v51QXdiWOB81aUmc5PWJdenu9NkXwaHhMLcBqWnMtZExQeES5N82
         0a/MxSzMhQn7cNAt25oGuSUPG70IM0qFw8BDs4lkPR36AbsciBmPHalZJRIu1kDmzpUl
         nxG3FnfmxE6kNiGEnPRpecEmrklDObKallloTHj5p7ygPBdRdgwm9GpcenNb0aHP4mCs
         KNZA==
X-Forwarded-Encrypted: i=1; AJvYcCUFo52loAOU50OAo//b1apnhDjg0zNIhxQNXHq1NQnCgUDDmZyx4W2OSjnnn5Tx/wbyObiNPCv8iOit4GsQJBdtMBHoVk+/khd4ttEF3VdLseFiTWq/tJFLOcLUvFc+sTMumoQ71QzQTyo0QSze
X-Gm-Message-State: AOJu0YznQhihN/UrddBIuyguUfWARIB9Iv7WyOZG4Va4VYj1NI5F24fJ
	TdpPJM1FwGm6mj53fvPvjIYh2ZAbN42BabVOBe2Dqe/i9c5kyTpF
X-Google-Smtp-Source: AGHT+IEBpnrmy4adz5ura4/qevleksk9NbIdy5W1llbhiL5BGERQqY6jT1jMSEU04uJKvmSae0FHnw==
X-Received: by 2002:a05:600c:1caa:b0:413:2a42:8af5 with SMTP id k42-20020a05600c1caa00b004132a428af5mr2129407wms.15.1711120426034;
        Fri, 22 Mar 2024 08:13:46 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:7b89:721b:d6b0:d7e8])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b004146d736fcdsm8626677wmo.36.2024.03.22.08.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:13:45 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Brandt <chris.brandt@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: timer: renesas: ostm: Document Renesas RZ/V2H(P) SoC
Date: Fri, 22 Mar 2024 15:12:18 +0000
Message-Id: <20240322151219.885832-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322151219.885832-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240322151219.885832-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document the General Timer Module (a.k.a OSTM) block on Renesas RZ/V2H(P)
("R9A09G057") SoC, which is identical to the one found on the RZ/A1H and
RZ/G2L SoCs. Add the "renesas,r9a09g057-ostm" compatible string for the
RZ/V2H(P) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v1->v2
- Included Ack and RB tags
---
 Documentation/devicetree/bindings/timer/renesas,ostm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
index 8b06a681764e..e8c642166462 100644
--- a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
@@ -26,6 +26,7 @@ properties:
           - renesas,r9a07g043-ostm # RZ/G2UL and RZ/Five
           - renesas,r9a07g044-ostm # RZ/G2{L,LC}
           - renesas,r9a07g054-ostm # RZ/V2L
+          - renesas,r9a09g057-ostm # RZ/V2H(P)
       - const: renesas,ostm        # Generic
 
   reg:
@@ -58,6 +59,7 @@ if:
           - renesas,r9a07g043-ostm
           - renesas,r9a07g044-ostm
           - renesas,r9a07g054-ostm
+          - renesas,r9a09g057-ostm
 then:
   required:
     - resets
-- 
2.34.1


