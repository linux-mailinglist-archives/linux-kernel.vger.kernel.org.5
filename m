Return-Path: <linux-kernel+bounces-46750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 770CA844396
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328EB289BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F9F12A176;
	Wed, 31 Jan 2024 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cSZJz4L8"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CAA63C7
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716899; cv=none; b=E6UQ8wZRcCpxq3N6kjLhHydd6LtfpK9QRfvPsRdYw2zgn2IIVyaTaymA4X6RzzjhPyf8mrpU20R0QsgVej2FK81QXq1ppH7/MGf5/eKDDVnb69gs3GhDsoiUzu0sHb7jN06Xj+2d4VEw/3cDgEC6s9FOXhW4HpNO9wsoWFjF72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716899; c=relaxed/simple;
	bh=Mg5KUcqZKde/DqexwQDNBEzmGIIExghhEG8nFsecXgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jKuMj0Um/3UiQIm5j4n0p7fq8LXwpKSwDMqERBXYSbjrNfOHMaWp5d+CLAwj35oD1hQrspxro/qNNXxrn6+MKd7F5qYZ7QnZpxXpaoFbKRQc6/tVU1GAvRywLxo+aIia8Mn0u0z6TYkNzCYFOEusF/xQDxlUwx71KSvhp2F2PTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cSZJz4L8; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33aea66a31cso2146599f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706716895; x=1707321695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7GGjOTfTMBIIqyaAo6ALuSMS6zgfYAZi7fWs6gtAQ0=;
        b=cSZJz4L8eeDraHTJ8O3+Td0UN8jZRCuNPZbzBYge47mHEynMjA4+4LP9wycEem8gSk
         IchKm9zrHFtP6IX1WnVlltxIWY34j3wjfC9OYZEoDI2ZRarGMoCO+zpxdtohvBSr7BzZ
         Lra4qdc7WEfwfsTDQawracthC2KL+NrbRwEuFudB1rHB1ZpDalHvi16nPZSmqVThv5S+
         E0FBjvAHRTL9bQOyxlHfw7IhR9lWJ1pv8fGp0fj+0mMXesEedXIT2IBsEQL3EKy84M7b
         s7hPzTMqwbVxKeP/i4CoM7cRPMU7uFnEANPl1K6hvSR0VaOPSSDcoE1x3nqbFdwVhV4P
         LLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706716895; x=1707321695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7GGjOTfTMBIIqyaAo6ALuSMS6zgfYAZi7fWs6gtAQ0=;
        b=MGsjjI+ytXh5G6dSA4eb6mPShNQs6Ovj/Hf0SP5QFAkoanO1x/qJeNEkFaSiFC78zm
         h3OyhkDgFWqbN0f4dQkqGX4jHoh2x6xrbLKF8a60Sy5odykEAu7evb9swK6RvN9Jcd2Z
         cBfHUgVCgDzY/NnXMqJbFaCXeDfJwfxr05UnLyxnJJSEjYub7PWYW1niM8Uc3rPzQhpt
         r1FvpmWy3XqwAVKvGJlj1YYqvdVqjHKou5Bant/kC8erRPBdftMca5oMjOIki/2SbqkJ
         tHBz1ybekFNT8A7bKm9+VzblvidlhPDxCiNXBQJSd+z5cLhL0smvQAG/ve933yQYrq0R
         bf5A==
X-Gm-Message-State: AOJu0YyVQxhwbBR/br9+hQ2JR8BCyAkPjME7Qg9aHuooHyb0D+oA71+Z
	wzUn6vPuze9awZ2ZnDLHo2kdT6mZqfslY4BAeNRx7YRZ8kt/t1sxh9EjETZmmX8=
X-Google-Smtp-Source: AGHT+IF78D/rn/QqKCF1O6AsFwlI/Sm4elG4q8phM412N9lSIrsSbe1rAE7TOm+63SArxDbMqaKiww==
X-Received: by 2002:adf:e292:0:b0:33a:d2d4:959 with SMTP id v18-20020adfe292000000b0033ad2d40959mr1290673wri.11.1706716895453;
        Wed, 31 Jan 2024 08:01:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUMmlfGb5QJrtWjQ3hwdRXHqr6tBQk0FIxMX0uA5P+4YYcbUZ8kMED0+5zSvPxp9Se7FDafq1n/DY934cDYAzBUsuJC61YJexveBQSJLg7aTm75drBWzhDXDpPnE0l7gnKGYL+NZ08V3zM9OcyZg18MIDPvkaVKY3n553LA+zl3U+PBNVZSqQ4OJFYlAd+XQCVFsqmjAvgAu94sEw9sEJBxzDIGrAwSiwP+rLI1AOEFoHCQko0EZIEwQuqgCuHpX6cP/EEYYWnOvDzGKbvNABXq1TpX3vYsnWd8cF2ONfdDW14WDtXiy37WLvtJt38NeCjgTKUFonqMDLWTEEk037t8rkyOgpIafa1COSx7MktRFXJuHq14e0rmtyCCAh2qsI+eJWk8yrEnwRA062YhoPJHPcwhqxqj4YGj8RGlqwf7fyXJbj6WVuGvHK7yb1D/+NGovyndWxjJOD2rhLLW/XWaX+s9UrHLCyvZef4E7hM2FoJhLzSFkuJKEvG/jCTxRNoVuv8MXActoVinBxYpoKfqtvQbEYibDAr9IFUTB7YggocoqH5QJHoXjU3mTpGGZyZnZP5qvj2lgg1N6C6BHU/XSetdZiGav2/UV2L5p7b7QF4caHnszz4xB08lDGxMWBuhhqpKVsqMtaPPUA==
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d5291000000b0033ae4ba8ca0sm11407009wrv.82.2024.01.31.08.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 08:01:34 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Matt Evans <mev@rivosinc.com>,
	Dylan Jhong <dylan@andestech.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH RFC/RFT v2 2/4] dt-bindings: riscv: Add Svvptc ISA extension description
Date: Wed, 31 Jan 2024 16:59:27 +0100
Message-Id: <20240131155929.169961-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131155929.169961-1-alexghiti@rivosinc.com>
References: <20240131155929.169961-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for the Svvptc ISA extension which was ratified recently.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 63d81dc895e5..59bf14d2c1eb 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -171,6 +171,13 @@ properties:
             memory types as ratified in the 20191213 version of the privileged
             ISA specification.
 
+        - const: svvptc
+          description:
+            The standard Svvptc supervisor-level extension for
+            address-translation cache behaviour with respect to invalid entries
+            as ratified in the XXXXXXXX version of the privileged ISA
+            specification.
+
         - const: zacas
           description: |
             The Zacas extension for Atomic Compare-and-Swap (CAS) instructions
-- 
2.39.2


