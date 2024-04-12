Return-Path: <linux-kernel+bounces-141890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABED8A24BD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0B31C21FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A91818C08;
	Fri, 12 Apr 2024 04:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bklgnJRD"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D39D182A0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895098; cv=none; b=JyoYg8XzChPqzDIf7OH7kHjeHYJ6iGZOmnrJUJk/5k826oXMMcigRSRErhl3t8lKRuuB4Dhj8N5B1g4VnMcooT+2lfp2f4UtdIsf5o6ZQX2Zx+YxWeOknwWWD4Znm6OR50YsghLJHdoJfUbVNZXeQcKGu8+HFbxVzW2RARBCneE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895098; c=relaxed/simple;
	bh=aeD7kpIXCYXPUehTkm7IjjI1zeG+m9VrzZ6zXfF/zjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LhgEZtwgcPXEZas/f/uJaVS8S70XDVrm+rzXQDzmA588f79lxuoZMJoJTTmFKapsQE5IzZw7VsS6omOZtId7Th3wt9qW6drLzqit343D+sYMgZfXxsFk+BNC02msEk2Pl8cZ1IFsO/FIQuVzCRRw22RfMt5HbeSrLYGMvWjEkEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bklgnJRD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed01c63657so505589b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712895095; x=1713499895; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvKWdpWCLanAFVX5zPtD2b3biice8x1/52aRbRjA/1Y=;
        b=bklgnJRDvcG3j4QnnlMpqNheKHlTV7L59nfYoryfLAR8vNt1jZXmW8mAPfcTlJIcui
         kP5vV8YzFDwcD4D3hgwC5Xbjnmag9KLgcNQJniO3eGN5K9Vr5KX5SXQm9jy8hHw2ZHIB
         bIcpvaWTK7aMKCGg3q2aVYVWAIkYx1vv8nQp+XrkTLyIApyJyPGXbkwDpOccxfEoR5c9
         P57jGBjKqRfM61++xUkCv/gZvGEqUNPtc1fsZOs4ya1BYkGE7cR7c2ZLtC4pXjSSLs9n
         haqbkHWKrBqNI7HWRwrGT+kxlhwuDNlptMq+PCxYPm8ReCnMepkkS4plRDlyh/kveYZm
         ZQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712895095; x=1713499895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvKWdpWCLanAFVX5zPtD2b3biice8x1/52aRbRjA/1Y=;
        b=VOW1X/HtdmAy6VxcSUT1CtYy9harNSfldKBcjeBwSiwCcI0cEYQxXhcTFY50ln1di9
         FdE0lLXr1ksTD9acOLUq1nHDGuT4XWuTcbP5SXyPw/XEUNUdHMoi9XU9E2PUNDiGcqX1
         oJmB+wW+Hzx1EQTF1aeAtzxZ49v944jeBzyLLVUFYK+CIECnzeGevd6XQ1B1rKhzG57q
         EogfjZkVY3LGdDKYQQxwTgL4y0yCoacrqXdv/T3ERYKCbI+zH5OS8EfoF0y3UsssSTcR
         UHFZTZ2LYoEbA12eXKjNZ5LerZGMjvaEWDe2p7702reJmcWhmirXWUfcOXgZ+eKAa7HR
         hyVw==
X-Forwarded-Encrypted: i=1; AJvYcCXRwqXrMP+9stovZl0LIln7aly/PgBNsa3x6WfW5ovcWRFdZwXUykuNU1HIEpgyAXWHbuP24mz65N+uYwRSkYB4LAUCCHgebC/y01UB
X-Gm-Message-State: AOJu0YxPtT4pHBU3ntLLl/Fr4ycDhA76lKUc7E8o0SOcf56mL9g8MVn8
	88+SfCwdPJ5fZGjiH379AaIj9cz8lF+8N/3TGHuGgLf+m9FO8UAIozyw5SD+IdE=
X-Google-Smtp-Source: AGHT+IGEzhFDfz+tEhZaJYNr7eckM5oEi1A9mXDPnazuRSbWbM8XnHfKloHOzQmsXo7SSe+IWRZJtA==
X-Received: by 2002:a05:6a00:cd3:b0:6ed:2f52:9acd with SMTP id b19-20020a056a000cd300b006ed2f529acdmr2081497pfv.24.1712895095597;
        Thu, 11 Apr 2024 21:11:35 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ka13-20020a056a00938d00b006e57247f4e5sm1949712pfb.8.2024.04.11.21.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 21:11:34 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 11 Apr 2024 21:11:07 -0700
Subject: [PATCH 01/19] dt-bindings: riscv: Add vendorid and archid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-dev-charlie-support_thead_vector_6_9-v1-1-4af9815ec746@rivosinc.com>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712895091; l=1246;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=aeD7kpIXCYXPUehTkm7IjjI1zeG+m9VrzZ6zXfF/zjg=;
 b=gyzpquIQ9EZPFl6tdB4X44dN/ns59zY4ew9u14pmot3GwLVRAjLHanoVkOR4IpnFrYW6m6+IQ
 FGixAlkBa5oBmgLlwpqraJRGcsWGjHUOq+pqsZuW+UYTSJ6pTTDEzAR
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

vendorid and marchid are required during devicetree parsing to determine
known hardware capabilities. This parsing happens before the whole
system has booted, so only the boot hart is online and able to report
the value of its vendorid and archid.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d87dd50f1a4b..c21d7374636c 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -94,6 +94,17 @@ properties:
     description:
       The blocksize in bytes for the Zicboz cache operations.
 
+  riscv,vendorid:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description:
+      Same value as the mvendorid CSR.
+
+  riscv,archid:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description:
+      Same value as the marchid CSR.
+
+
   # RISC-V has multiple properties for cache op block sizes as the sizes
   # differ between individual CBO extensions
   cache-op-block-size: false

-- 
2.44.0


