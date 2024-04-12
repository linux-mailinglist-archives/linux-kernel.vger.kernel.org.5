Return-Path: <linux-kernel+bounces-141903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBD08A24EF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B674A1F22F90
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A5E47F7A;
	Fri, 12 Apr 2024 04:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rywHYn9t"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FDB1BC2A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895120; cv=none; b=KMQtuYD1YwqTTaW3gzx4bhXfkXb8epqKolrui8Kjwx+9lGbNp8SoANh4HveT90WZfUaxLmGFs98CoQErCq2SwKJ+J5oc6WHvOpcrgsPYPPb1Yt+5ClRgvn7Zye++JteZSbY5sFh6x+1kPFDS+79f9mRbQ+6RZnJoF8MAGvwDkzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895120; c=relaxed/simple;
	bh=dpMQyQf6EiV3FnyfDhr0ctcgVQcOupbnA1FwXdRflyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EE4EjWA955bdZoW7qCwTpzotd2uGVz3XO+J7JSzsdMyHU5t6LB3w8upZ5POf265tlmxSA4arG3Ei+qlqwwZjRE+o3D3VtURKXFH3GQNlGpKE/BSgWMOGIN9jeN7DLKYmVJ5flSLbz6BWqZMlYXZiJkG04jun2RSLzPPpFdyGXq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rywHYn9t; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ea26393116so439490a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712895118; x=1713499918; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89KkigznkOkTkIiVd8Bev6F1MF+EXqz9OwTBLz7EuqI=;
        b=rywHYn9tv3v1cE4QI4KzwTiv6PgWbr2Uzof5kCJmXk+KGO9YPbmO4tgLuQ99iEOmqD
         Zs2Pw7c60AEbLuH3s1LnDHSiGPNDr0NArj1ltBiZuxc+mDgRcvr9GTPmrT3bDM455yUu
         Cog3Q4dK4UBQJrt81lYYzrcfxE5E6IKTQW7lrb2h2gXaTUA/TduxAEH6s/px/GBcmhpz
         8a7Teg8kgXuXoMHoMIJaTETE4jRESN1hnokb2EU4EHOPz3cWfK5b7fckO8bjFj87lkrW
         j1yQROFG9kB9fTLabqO2wa6zrIZ7y7VehTZnYV6GCORJeNgDbiV2hv58Hfk7yU6gD/V4
         jJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712895118; x=1713499918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89KkigznkOkTkIiVd8Bev6F1MF+EXqz9OwTBLz7EuqI=;
        b=QmIR/ir59Jwi7dF93efznZ+dplArvUlz4zAvv1UMbk9fWg9Ge5UEu6jISuI6Ar5fET
         d6bjuYQ6xN+X0AZd7KdxG6jiHgpai5yQu2MRDHSHCVsHBodhRK6fD6VQYV3hoUIekP58
         yIelzB6/YraPHiICYCWrjAjiSjor2m8BsMvvxOy/WzX1yclemyit5whs5xxtBQB+rAUk
         ZrFOEPcCq0bSh4KQdQr6EsglL9iXjy9boQG1Pmdd3G0aeA1R8wqWk2MIF15drhjOIrMA
         8sHBQi8O2ldj0bwsa8+y9JtntGbAd20O6ReYxLDmBSCTbFipGqeaMZazWacLmBvCDYOV
         1bAg==
X-Forwarded-Encrypted: i=1; AJvYcCWL2KRES7u0cfF0/e9ed9wKdDxKps4xeMKtoVMGh2ZdRVnBtTptJdxjEEoVPWpSqvEak5clfQuy3z4qeIsHgI9BnGl7CeFKxriZu+WI
X-Gm-Message-State: AOJu0YygMsVGnffaazFinnp6wuK8aay82YDGupvt5pqlVdChJ2rRNyc7
	zoosN8ysCvJ6suuj5S4PYsGRuvIhNvZDgYee6NyY2vx4UZ6IUQBADx5Z277m+aw=
X-Google-Smtp-Source: AGHT+IGcw1jnW0l0MGMcAPq0tGxntmRUuPWox6H1ipX7MybXPBxYHdvKCOaV97uW9OMyYzsQMOMbXQ==
X-Received: by 2002:a54:458c:0:b0:3c5:f333:3819 with SMTP id z12-20020a54458c000000b003c5f3333819mr1496177oib.21.1712895118136;
        Thu, 11 Apr 2024 21:11:58 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ka13-20020a056a00938d00b006e57247f4e5sm1949712pfb.8.2024.04.11.21.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 21:11:57 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 11 Apr 2024 21:11:20 -0700
Subject: [PATCH 14/19] riscv: hwprobe: Disambiguate vector and xtheadvector
 in hwprobe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-dev-charlie-support_thead_vector_6_9-v1-14-4af9815ec746@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712895091; l=1077;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=dpMQyQf6EiV3FnyfDhr0ctcgVQcOupbnA1FwXdRflyI=;
 b=yG9+AKMmuUbWWqUzPvnobYPlplrI2ZeAtqu5dbsmkCx71ozS6qstYkuGJ9cZehtHrREk7qb+H
 OVTyBaKWh53DGh3LtPRjDx7F743TkUYJceC/ov23653q6S2VSI+xJZN
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Ensure that hwprobe does not flag "v" when xtheadvector is present.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/kernel/sys_hwprobe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 8cae41a502dd..e0a42c851511 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -69,7 +69,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 	if (riscv_isa_extension_available(NULL, c))
 		pair->value |= RISCV_HWPROBE_IMA_C;
 
-	if (has_vector())
+	if (has_vector() && !riscv_has_vendor_extension_unlikely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR))
 		pair->value |= RISCV_HWPROBE_IMA_V;
 
 	/*
@@ -112,7 +112,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZACAS);
 		EXT_KEY(ZICOND);
 
-		if (has_vector()) {
+		if (has_vector() && !riscv_has_vendor_extension_unlikely(RISCV_ISA_VENDOR_EXT_XTHEADVECTOR)) {
 			EXT_KEY(ZVBB);
 			EXT_KEY(ZVBC);
 			EXT_KEY(ZVKB);

-- 
2.44.0


