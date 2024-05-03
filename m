Return-Path: <linux-kernel+bounces-168033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9BE8BB2C6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F15B2119B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A5715921F;
	Fri,  3 May 2024 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Dl14eVK5"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7AB158DCE
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760331; cv=none; b=vCZ2Kr9fA33Z4sve6ol3JXVveopv2Tl6BDeCaQ6pD40LxZl5GVN0tlbNQ5h3NybqdFoV6B3Vp1sg/+roHmwpL7rz1yflS/2Lptx27TuwIHoRLn6igY5hHsxWfqhkjkv87IbIUJ0dsP0OcsX0vsOyMVfALw8ICN4+JQh8HmI/QRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760331; c=relaxed/simple;
	bh=eg5f+2eUdPorsjTg1AXnvbZp1Gz8QKwXU/sn4bArQ/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N25RT41AUQQEVZF9Ksw3NkHV4nBlysqD/ThHEx00zyTGwd/GxxyfQd/cH+vfb6uYAxrEEp5l69HtXJTTXv5q+SkIXeOzt/C1L/NF/VGCdmDtQcSwDZLZOzJ2iS9GijvKoM8QkMEsuheS1f1z2KPZcScCeZdjkrUv6uD2VhUJiVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Dl14eVK5; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f4178aec15so18758b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 11:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714760330; x=1715365130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xb9tww82u8GPwb/D9ZGp2c9YRfA1MZ53TtnEydxWwQE=;
        b=Dl14eVK5AOK/YGsz54ifFptcjgJkFJBSUGLdx03++zyRnNlH4V6sQ/qMuyKzhdTVXI
         nr/0nIWfEVsMcV9v5EJYYyk/xkNrMkXilCv5WlyDma9/qil4dQGfNkfKJ8XdujI/vYcv
         0HljhaIYlrebrF9FGWNGmYGEKc2sMqM3bYQFM95uxe/jf+Nq7jJvu1Us3q/sS+vyCpVr
         +vfT0wDDym3MLUstGZLqkBhXsCUmpFLTMeHK6LU8fd8UuYh39GUuuhG+49DlN5FkaQM/
         9jSasoahDRPyqm7fwIjN4o8vTvZB0Ft2mLJLN+N4YA60Jlhcv/y+qwKETkcCoSqMkDgV
         ibmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714760330; x=1715365130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xb9tww82u8GPwb/D9ZGp2c9YRfA1MZ53TtnEydxWwQE=;
        b=I5hDbgI4P00iECCLBDvtlKappqbmlrgPprRpitvdSJVvSxTcdqpx7vM1YL3xjTLwd4
         tORG1OnOmcixyi9P69GJp4OPUCyhp9ubc+ViCFXMVV19AMMME1v4/NN5QncSO3H6Ugyk
         4CXI8XDlbefTEV9fW4dA+MUutEyPlooKj3QKnCoEMZH9MKfMdubVk7F/egdrGtJ3BReE
         sr8FGo4vP59USEtz6jk+Lk4IsQKXQMo2ijIW1jPBY04Feo+9eUBJRl96j5xmGNuW3NxL
         Rqnlf7HB97p2iNO25CZ8a+pcZRT9BI4yULe0mxTmVLRQB96vn7aqxNWnt3ZGcAOEQipg
         wtvw==
X-Forwarded-Encrypted: i=1; AJvYcCXcMdcwfHo7LsO9JUVKWXx8dEjBGsh8Dh3hGiOhywLawMtfaU1szOCfPuWwjmvNgQEX0A1lX7+16kAm6FgVSypFJR35ntsVbHGgq8wS
X-Gm-Message-State: AOJu0Yx9wFoksqwdaY51MOd+jIBnf29Ozwz+IOuKq15pTPSZ8A18o3Z5
	x7emi07z/AmGpXsmEL5W2VQvCC3INISUbUzHMxBaAwfb9BfGKuXgYK/458aAxOc=
X-Google-Smtp-Source: AGHT+IFy7bjwb5Tc2k3ELswk0ckQlxflBBtAMpFeTTm74dAZvij2X2R0LCw+XDzJCWrMJUDPuSACWA==
X-Received: by 2002:a05:6a20:f393:b0:1a7:4b40:96db with SMTP id qr19-20020a056a20f39300b001a74b4096dbmr3340804pzb.10.1714760330034;
        Fri, 03 May 2024 11:18:50 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id fu6-20020a056a00610600b006f3f5d3595fsm3355421pfb.80.2024.05.03.11.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:18:49 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 03 May 2024 11:18:19 -0700
Subject: [PATCH v6 04/17] riscv: dts: allwinner: Add xtheadvector to the
 D1/D1s devicetree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-dev-charlie-support_thead_vector_6_9-v6-4-cb7624e65d82@rivosinc.com>
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
In-Reply-To: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714760318; l=904;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=eg5f+2eUdPorsjTg1AXnvbZp1Gz8QKwXU/sn4bArQ/o=;
 b=6g1xI1qEsC25DUPbbFpRsxXutxb45Sm732q6PItZvN9xNDcps0BAvC/bY1rPUIPcJI36yR/lz
 CNxoaMn0OIdCbC6bJdMpDz6ehBx1GiDP/MZbJJlSKdQjCj7lyJtPXxb
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


