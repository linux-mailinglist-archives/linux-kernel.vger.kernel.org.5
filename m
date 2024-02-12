Return-Path: <linux-kernel+bounces-61645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D079F8514E1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E88F1C20DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0614D10A;
	Mon, 12 Feb 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvujglPx"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295334C626
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743677; cv=none; b=nNAf77iag4FGRQByPGPeW1cvVQNCZZu4tslsOgfeZeLWeET5xUcVZ8c5EM9Cv0lKeQHwLSre+HRn+REH9ZzAB3u07jC5gD3E6YS+nWgf2oqWBkA19HxhVnbtTok5/RP/zbGIHk690kb9tQ9vnGlSuT7t6M1fPAudcjr+JgZMgBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743677; c=relaxed/simple;
	bh=MGljuiY0b08CbfXabKHR3arSgSpNqpPXAmOerQ85JFw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DfmUjO1y4vaB3z8bArNb/N4/O28ByBHIhIanw+Z5h5k2du3da20IMYvJUMW4QUbLaiEft0vFojNU2gvd2wLPyq1RNdah281jC/F+Zdx2lSEBreSWao9aeq2XmJU+CIcaBvxeNEigHYbZip4jXO26IFxkjCYdJf6HQwn2iankPAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VvujglPx; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-410d0660929so4553595e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707743673; x=1708348473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRe13GXsBNZ8mkxLlyJ1MfL527/NzLwP4cfZxeK7UxI=;
        b=VvujglPxX48kcJgSADWgCn1UVFBsld3Ij/wDfqpgYVn1zsXY7SmwUjSAXwBSXV6HLb
         sM2IGHWBSjEZnICV1NG4pJK7rWTKtGuiGMaRcq6MfC0O+gjilZZyClxo0KtLMpM6j9Cg
         qEcQ6hWQO2s7xB85rujQcKjApX1kT7AhRVdDxnrTTtf3RhcExrZZqZXPmFYw7Nw66UYH
         fBAv9sePGF2NYVitZGth4lA618JHCqS8Be/dus8MoINpvDWxpN+1jEQUz6FleyB0nu5K
         lo3N39KUVh+xLXS5yC2P7uYt4UszfaJAFNYtDQHtB1bUw5n/9qjmZe49Tv7k3xTSZ24F
         /cGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743673; x=1708348473;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rRe13GXsBNZ8mkxLlyJ1MfL527/NzLwP4cfZxeK7UxI=;
        b=SP3a0doTwJ/Nl1SWdEADkoiz46dk4XWL8Vo+AYcF8pozi0NecnUBkyVuIMoXSGWEKb
         LW/VGH4QG/KurcIS+HmB4m2kBfUOsTJqp2InSAHSQD6+ZP7BFbOYaNX0CBXlz6RyF4XF
         ylRlDX56NfVqzSSADau37k0RsJ1NODxDE9P1qBJXtyViLc8J6pddqovFQ3mBB8oGrvRV
         W0+MFvwbEn/5BU9A+YbYrBXnDMHHXUxkOxTtJHKZ0RpvBFPm2wCZ/cMdQGeoCBInHnjf
         smRNTEtEHc3nbRn2ZDB5b73QM/jAqUgyfKXZuLm1zQ4k61jYlyRxpifDkz4NxsatxzGv
         vjYQ==
X-Gm-Message-State: AOJu0Yzxfq/JH784iPmSH8eHyfzx+vILkmqwg4M/yikW7npLWddadkW0
	/pcvrsMEpOSTcg/Sm1VNuxGIPe2UJPWBH3pK3f6uiNeSISKG1FCiajwSWQZ+w3VgKO1uhYcXnar
	c4kFtYPLXGA==
X-Google-Smtp-Source: AGHT+IHeUQzQJMGFa36yvvo79Gf3XEOqIP1Fw3gP4UC8etm91PZ2z+b4H4rGeV3pFlboBijII39ElfpdFik0Kw==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:600c:4c96:b0:410:bb99:7ea2 with SMTP
 id g22-20020a05600c4c9600b00410bb997ea2mr35246wmp.3.1707743673486; Mon, 12
 Feb 2024 05:14:33 -0800 (PST)
Date: Mon, 12 Feb 2024 13:13:21 +0000
In-Reply-To: <20240212131323.2162161-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212131323.2162161-1-panikiel@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212131323.2162161-8-panikiel@google.com>
Subject: [PATCH 7/9] media: dt-bindings: Add Chameleon v3 framebuffer
From: "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
To: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org, 
	daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl, 
	krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com, 
	mchehab@kernel.org, mripard@kernel.org, robh+dt@kernel.org, 
	tzimmermann@suse.de
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, ribalda@chromium.org, 
	"=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The Chameleon v3 uses the framebuffer IP core to take the video signal
from different sources and directly write frames into memory.

Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
---
 .../bindings/media/google,chv3-fb.yaml        | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/google,chv3-fb.=
yaml

diff --git a/Documentation/devicetree/bindings/media/google,chv3-fb.yaml b/=
Documentation/devicetree/bindings/media/google,chv3-fb.yaml
new file mode 100644
index 000000000000..ba6643cc7232
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/google,chv3-fb.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/google,chv3-fb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Chameleon v3 video framebuffer
+
+maintainers:
+  - Pawe=C5=82 Anikiel <panikiel@google.com>
+
+properties:
+  compatible:
+    const: google,chv3-fb
+
+  reg:
+    items:
+      - description: core registers
+      - description: irq registers
+
+  interrupts:
+    maxItems: 1
+
+  google,legacy-format:
+    type: boolean
+    description: The incoming video stream is in 32-bit padded mode.
+
+  google,no-endpoint:
+    type: boolean
+    description:
+      The framebuffer isn't connected to a controllable endpoint.
+      The video interface still works, but EDID control is unavailable
+      and DV timing information only reports the active video width/height=
.
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - if:
+      not:
+        required:
+          - google,no-endpoint
+    then:
+      required:
+        - port
+
+additionalProperties: false
+
+examples:
+  - |
+    video@c0060500 {
+        compatible =3D "google,chv3-fb";
+        reg =3D <0xc0060500 0x100>,
+              <0xc0060f20 0x10>;
+        interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+        google,legacy-format;
+        google,no-endpoint;
+    };
+
+  - |
+    video@c0060600 {
+        compatible =3D "google,chv3-fb";
+        reg =3D <0xc0060600 0x100>,
+              <0xc0060f30 0x10>;
+        interrupts =3D <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+
+        port {
+            fb_mst0_0: endpoint {
+                remote-endpoint =3D <&dprx_mst_0>;
+            };
+        };
+    };
--=20
2.43.0.687.g38aa6559b0-goog


