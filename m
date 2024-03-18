Return-Path: <linux-kernel+bounces-106438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDED787EEAB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEEAF1C20E67
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAFA55C2D;
	Mon, 18 Mar 2024 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS+b/lVq"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED255766;
	Mon, 18 Mar 2024 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782556; cv=none; b=eyz29Nw17jI94Yr7L1YBzZNEplwqy5djtHEugv+JXw2tK809BcwlzE/Toz6nrhhEXgB31k/lZ01R//gBcSGFSPbBzGN8sKnwjsaiy2J93EQWnXnME1CUYydfyd1MeobR73mZoDlne0TMjYbaYfVaphsILe0h12w4IHslL+a4j9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782556; c=relaxed/simple;
	bh=DxUeEWghL1qBvTbdce443YWKW5y5lQBBOdm0WQN/JN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VxpLYhBJWhJIeRxc0fn8V5RhjNuKq4sb2A5ZajXR2tnuc0Nbq2PSgFYe0YIIwjPGmceTMMWIi7SaE0FmW7yK9XsxC+dB8yBpKdn800sOX6o7pYjbEWFddqDpr7VfsEEh88iXqVnsVjwaq0uuFp7jizWuJidmjFnjfPQjZPpvM5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cS+b/lVq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33ecb04e018so2438300f8f.1;
        Mon, 18 Mar 2024 10:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710782553; x=1711387353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xC8sglUOTL51HQEeemp8tDBYDHbm4d9oew8hHsnu7oE=;
        b=cS+b/lVq94+ejuanA5Lh9ci5Pc5nHWcP60bAgQcM0rj2cmWGMSmm9Yk2shkCwDVbpS
         P8g4cGQwAMHX/ma7k90+wD83GJla6BDCH+uoVSi0VMlsXQRX05nPGzWBG2Tju8RNOdue
         uqubYjTrVr5nuldohcW90jNDPLnUKhWDBnscQlfk845YdjT6XwoRBkiTK8T3twwd6SqF
         pcoUmH/4359vfcb7C+7SJWzbv+ebjVwU5NfMvgg9BcEVdD1IP4aaXvfiis62IrgCzCHf
         XNnJx66mzDNPXD+1ND+KP2PUYgRSaw9WONgrwKk/Zz9emx/hThpvHAG8FyWWrdYlQGB7
         bvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710782553; x=1711387353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xC8sglUOTL51HQEeemp8tDBYDHbm4d9oew8hHsnu7oE=;
        b=TjyCpcLT5/BAvcPWZz9HLbw35Hdlc+TT9EQ7OfZscCLWeNblg/sw2IiS8BmfDmdH0q
         FLywKsH8iNGkaVk93WPZT767Vl7nDjNw3ZJsM9i1ZmypZMBo/gRog+HsFjqM6NsJ5Di0
         wQRlqkNhHtagqiW2PkgxXRjqrs33u8Gx736mJyZO5niyTAAzY93YVUZ5EgP64mSV777V
         Iyqlb6QPIr8N+Umcp5V5XuPDD4ZiBJOegB6cBJdTXtE/1LuSyJP9ifueiPahDkukqX0x
         td2xq6FCvMKnUctcsZuRTkS3P6bgSfJxjVsiPWEd/71/GpGzlOXpPvPDP8ihC/lGKc9f
         H8cg==
X-Forwarded-Encrypted: i=1; AJvYcCW/NfgGS+ox2hCk35s5B7mNz2QN+haD3QGiEMJ4mIiCGlMl8dUc5xG4mmLI18tD7dfKstoib1rsxDQgfKM8VWdz8H9blN8wJqaXpNs3QEse4PyZJF5a2Z3v/fQjUcx5g/ZciowY/McihKfgtcMaONXlJMgz/9WtQtcN/96H9NZZDoPoCP5UA1n+94mh
X-Gm-Message-State: AOJu0Yy5AJ6hoWi+AzFWsOMHGgfvORGFf+mJ4+DwgZizpj28UCxmzu6x
	S/uWT1IA39frD5Teayf5NAGC+TNGs7VYmj5Sduahx5/Xj8zdVLr8
X-Google-Smtp-Source: AGHT+IEi/ESEcC3ZCWuMqbIdTPmh+4SQ/XDFuSwTgamsydwC3SLT3KoQJ52qjUlxrNK9zRLVPGSJwQ==
X-Received: by 2002:a05:6000:d01:b0:33e:9f65:3b62 with SMTP id dt1-20020a0560000d0100b0033e9f653b62mr7694967wrb.49.1710782552724;
        Mon, 18 Mar 2024 10:22:32 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:c23f:76ae:8149:291])
        by smtp.gmail.com with ESMTPSA id bv30-20020a0560001f1e00b0034180898569sm1140769wrb.72.2024.03.18.10.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:22:31 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: serial: renesas,scif: Move ref for serial.yaml at the end
Date: Mon, 18 Mar 2024 17:20:59 +0000
Message-Id: <20240318172102.45549-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318172102.45549-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240318172102.45549-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

In preparation for adding more validation checks move the ref for
'serial.yaml' to the end and also move reset check in 'allOf' block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2->v3
- no change
---
 .../bindings/serial/renesas,scif.yaml         | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 4610a5bd580c..af72c3420453 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -9,9 +9,6 @@ title: Renesas Serial Communication Interface with FIFO (SCIF)
 maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
 
-allOf:
-  - $ref: serial.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -160,18 +157,21 @@ required:
   - clock-names
   - power-domains
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - renesas,rcar-gen2-scif
-          - renesas,rcar-gen3-scif
-          - renesas,rcar-gen4-scif
-          - renesas,scif-r9a07g044
-then:
-  required:
-    - resets
+allOf:
+  - $ref: serial.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen2-scif
+              - renesas,rcar-gen3-scif
+              - renesas,rcar-gen4-scif
+              - renesas,scif-r9a07g044
+    then:
+      required:
+        - resets
 
 unevaluatedProperties: false
 
-- 
2.34.1


