Return-Path: <linux-kernel+bounces-160690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC11A8B412A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06297B2209F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832033A1DA;
	Fri, 26 Apr 2024 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uGCxbewo"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BFE3A1D7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714166975; cv=none; b=GkZ3R4xeSydVFEM1Tjow7sZxGv5OBYW6l3OA7xmQ3uq6KyZVQXpGyY2AIFRGQQwUa1bkeiVABaIcpwQUpaEFjq//aRXIQmNhLG1MjeZQzJOEsPKtsJ+tUxM+a8YxoFn3g90V81XCZBnT7o/1yY2mhMMP+XpfeN9C6CfTNsTBEiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714166975; c=relaxed/simple;
	bh=eg5f+2eUdPorsjTg1AXnvbZp1Gz8QKwXU/sn4bArQ/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VH/2kgO0X0/gCdPIC7MChWbOBMzo8tSeIFJ4+ETyD70k5fJRqsZt7VYmUp7JAAWFq4bow+kZwiNi951saSRbUHWbCpnRydnR1XDRRvgZ+7I7grUo1yA7PbJ+qjQTQFlDxa0MZvPC1LwhAZUZp93pVFLuLr9v8XvJ/qCTkz+2uj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uGCxbewo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so23162865ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714166974; x=1714771774; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xb9tww82u8GPwb/D9ZGp2c9YRfA1MZ53TtnEydxWwQE=;
        b=uGCxbewooTQzz/gNhuA9zeEqDacU65L9p0w/+ODXw5fcpenfUCLch8KjmxtR/Md0S7
         SPt96KnuKT5AYv4vE0KDJ3m/FdBnoqb3UMzSvkR5vsWO157HqVKQuuXpegKoueR3Wo44
         FMhaOrmRsEyDOo9Mm8xt6M/Y2WhkmoIakHaIR20NWZVtqX15Z+fmE6W0emClbVTsLHVg
         KEc5UQMIeiC94/DeNUzFPHIlKo5K4vfIaD1D6jkEbEeSdSHGHkrBHsPjUTW9IBLoBoo6
         ekKw5UgFyK4LCMRsvTrzPjDDU3BRYAz+v8TMUIzZT+GbGZi9WMmiexMCFeKAVtFbOSH8
         NJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714166974; x=1714771774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xb9tww82u8GPwb/D9ZGp2c9YRfA1MZ53TtnEydxWwQE=;
        b=ufVSMD9/w8+KW3Sxh7IhYZOsOMFkXwEmsqPSPKw9r+dGqHcRTNyBPGgBIlYqJG6E16
         hUHuMwneoahgIJzujJNCWTPOI0pEefcGO7XMAqvsPRH1AOzAayiaGX3JgNXhfXF1fivy
         TJcSoVv5ATnEyaM/gGoqjC1y9liK+4S21X0DIOlYz58wcvDvo182Cfv5qcBTrBcwWD/d
         /U6jkY2NP0lAesk1+bNv+sL9uNiKGVWhrTfbEdb4v7mLNWxJydKCwo9rfZzSSosVaM2i
         lfT06sVQoBKsq83MkryMMyq0vPjC30u2BPcyynEbOaN6zkGfv0xgLcqGAY7LhoBf8JeO
         +0eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHguiFPh1E86JG+XS+vgyFJdI9+kmnP32MASbB46/nBnkZuY2EjgfD7u4Y/UfMlZdX8dfUL0WEYUN+LHeowdQcEE13+/82Xi3sjC3o
X-Gm-Message-State: AOJu0Yy+JjGgJGRIUQxatB9hPJ/JLsy8QSfC5HZZ2R1ULA072ZPevrwQ
	LMnl4jxEZk9JO170j0Bjyabb9Wa3HdoGiaTpV3FSBeVQvr5IOxw/0CewjS0rAQY=
X-Google-Smtp-Source: AGHT+IFEldMgHYwrrE/WDKjCeD0h2bT0Le//pf+RTk6e30ppKuQzsBrdr7KrhuDT58Oa4s45KZPzFw==
X-Received: by 2002:a17:902:d543:b0:1ea:c7a4:7e8 with SMTP id z3-20020a170902d54300b001eac7a407e8mr1151133plf.17.1714166973673;
        Fri, 26 Apr 2024 14:29:33 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902650300b001ea2838fa5dsm7226720plk.76.2024.04.26.14.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:29:32 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Apr 2024 14:29:18 -0700
Subject: [PATCH v4 04/16] riscv: dts: allwinner: Add xtheadvector to the
 D1/D1s devicetree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-dev-charlie-support_thead_vector_6_9-v4-4-b692f3c516ec@rivosinc.com>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
In-Reply-To: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714166962; l=904;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=eg5f+2eUdPorsjTg1AXnvbZp1Gz8QKwXU/sn4bArQ/o=;
 b=TRlVfhuV1SKW+NgB2OB5kOL4FF8D9pv84FgA25MEizKMQ2QpkjW4elwnFJEHnNkZ+bTFe0b42
 CPsJoDFwMOwAR8P1a4akFOABH0l1U2tKr+32Eqba9Iryz5WqcOWERRG
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The D1/D1s SoCs support xtheadvector so it can be included in the
devicetree. Also include vlenb for the cpu.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
index 64c3c2e6cbe0..50c9f4ec8a7f 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
@@ -27,7 +27,8 @@ cpu0: cpu@0 {
 			riscv,isa = "rv64imafdc";
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
-					       "zifencei", "zihpm";
+					       "zifencei", "zihpm", "xtheadvector";
+			riscv,vlenb = <128>;
 			#cooling-cells = <2>;
 
 			cpu0_intc: interrupt-controller {

-- 
2.44.0


