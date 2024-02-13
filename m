Return-Path: <linux-kernel+bounces-62912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B98EF8527C7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E632285B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FCFBA56;
	Tue, 13 Feb 2024 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lab23ese"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1B79479
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707795470; cv=none; b=GYoqNNpCWhv9+RvGzasqVEJ19StYBD+r1FjgKYU3ToAABiXlaePe7bYJTmcfXWdr3mhh+rkl75XOc66HtHKBtMdXxkXcrpxED/Uz3jBzbE4KqP9OYWAqcCiaTE6gWtVPfWYgYhkfHF57UDb3FteROVbwrwdzlVXm6aN9T1N/aw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707795470; c=relaxed/simple;
	bh=8pIhNYnxLRa/X2tsQjOh7P2wqEz3w33s57I1KemeK24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzHCynYHYgdr1EfdePCOKtGHFMdRHFUOLFHLC+bWVc33ahz/1Cpxh8eZvL3tOD8s0D5maz35ug0KamubCrlNK5lIQHKR4kS4hPeF6AAPlPxr9amAdY9S6VCiItnlfumRef/sHi3Efjq03q8LPZVXn0l3tj2CrZhxQuQiFE9izbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=lab23ese; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e0ac91e1e9so1435785b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 19:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707795468; x=1708400268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jim7Yvb6VmY6JIh3NrVmUpVFosXkDK31kcFuWFcbExg=;
        b=lab23esePh3NDeXbEI7/zXxRWu9K4hd3w4hojzCmQKAp4sN4dUe8Tzdl+oXym0ZwQz
         4v1kmmOXJXnABk/XZunIETPquj4uW4PaQwghKoQhtzAD3LBPD51Vd1esed4j3PARXtDv
         IIGeVDMOcAZz94s+6h7pnltOS6D+wXIsZh3o2M6i23mHykDkkakfzHJO5clp0+ZQ1+0W
         n5dzVy+ExteTrHHgXbTM4larYUecoBIbSBJDvHRiQu4bZehVD2qJdb30ovN88pbNeHXr
         TEHfmYvleoAYhwrJq4LzPpaMHNRb3iDdVVegINQ5xHNn6uzAAVgJs7rRmNXcoqFzlyEk
         z58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707795468; x=1708400268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jim7Yvb6VmY6JIh3NrVmUpVFosXkDK31kcFuWFcbExg=;
        b=uY1yOtPWVuXwcTRtIpFH60Z55yQeDQ6grbcVBeOvzY39e3HLXVO78gkw6kCWnLVM+d
         NKxlgWnBpxWz5TC9nWqySYdgjtXEhdbLwn8eYtM+6Ej4NSZGw2Rbb9+dEbEVbD7vJac3
         RLYHWib/57tLxc3QVFEzGxQVHJHS1TjrPhX/AQM6otz0Gl82kLvRoO9FzjwltJdOq7U2
         hILoEqitandbd1xMaaNYyieQYPc5QQkrmTQ9xVIyP76FCjlKWZqCyP/3ahqMAgndfeEN
         CiakWQtI02ZcybBYeMDtXj3Q2ZJTPQ7g2dcWjOxzTLC7SLAjETGLttwqXG+tOo+0SbzV
         fRXA==
X-Gm-Message-State: AOJu0YxUkgoFQbNbiTJlOPZbx5scVmJZC+gQhaY158r5dcewg6ki+5fI
	844yJFwo1IRjkdwAjPNQ0ytZge+nfQXAc0VIaiDBhJ76/fuwnsHmqh5Y416pUcc=
X-Google-Smtp-Source: AGHT+IFbg2lMISlaKKUl+aHHxXR8JKhjEYDdVh8gzIjglnj+bxXQjxbQ6rcFpTy0yXOTe8Cd48dVAQ==
X-Received: by 2002:aa7:8685:0:b0:6e0:5317:6772 with SMTP id d5-20020aa78685000000b006e053176772mr6713708pfo.1.1707795468162;
        Mon, 12 Feb 2024 19:37:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtDxXelkbmm+CM8OLoo8WM4giaZcxrKGw5FC1up94u0V6jYFdJloVUPvWRQ0Omxq/n9YRlGpQXAYGpmEIR7+klWd8162GgnV8tbjfr9NG9RNhsxttq1+vCK9foEoC0wKl6LWJ+VJ9OhaR6eZRwNvpqxF3p8xEUSYrb8ksnc2H07sCCYQfJvwH5l0u3YCp2Z9mi1xR2N69GDslZW7YF
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id v11-20020a056a00148b00b006e0334e3dd9sm6188633pfu.76.2024.02.12.19.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 19:37:47 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan O'Rear <sorear@fastmail.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH -fixes v2 2/4] dt-bindings: riscv: Add ratified privileged ISA versions
Date: Mon, 12 Feb 2024 19:37:33 -0800
Message-ID: <20240213033744.4069020-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213033744.4069020-1-samuel.holland@sifive.com>
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The baseline for the RISC-V privileged ISA is version 1.10. Using
features from newer versions of the privileged ISA requires the
supported version to be reported by platform firmware, either in the ISA
string (where the binding already accepts version numbers) or in the
riscv,isa-extensions property. So far two newer versions are ratified.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - New patch for v2

 .../devicetree/bindings/riscv/extensions.yaml | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 63d81dc895e5..7faf22df01af 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -121,6 +121,16 @@ properties:
             version of the privileged ISA specification.
 
         # multi-letter extensions, sorted alphanumerically
+        - const: sm1p11
+          description:
+            The standard Machine ISA v1.11, as ratified in the 20190608
+            version of the privileged ISA specification.
+
+        - const: sm1p12
+          description:
+            The standard Machine ISA v1.12, as ratified in the 20211203
+            version of the privileged ISA specification.
+
         - const: smaia
           description: |
             The standard Smaia supervisor-level extension for the advanced
@@ -134,6 +144,16 @@ properties:
             added by other RISC-V extensions in H/S/VS/U/VU modes and as
             ratified at commit a28bfae (Ratified (#7)) of riscv-state-enable.
 
+        - const: ss1p11
+          description:
+            The standard Supervisor ISA v1.11, as ratified in the 20190608
+            version of the privileged ISA specification.
+
+        - const: ss1p12
+          description:
+            The standard Supervisor ISA v1.12, as ratified in the 20211203
+            version of the privileged ISA specification.
+
         - const: ssaia
           description: |
             The standard Ssaia supervisor-level extension for the advanced
-- 
2.43.0


