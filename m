Return-Path: <linux-kernel+bounces-168039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E828BB2E0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA2DFB2350F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787A615AAD6;
	Fri,  3 May 2024 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="iJ8F2e4v"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D0815ADBA
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760346; cv=none; b=ZQTiR9kTWUbeP1XY3sQ7OOhDKBIdxxUlbCskvCH1qPoOKmsbhoyEgrTw6OaerlzYcsx22QUojUppj9qEOCiJFYEj25Sbci2FMRneK6w/Bh3MtlGDhH8xivyCe4lzN+KjfKp8NNe1ykEOZCsZ5jVSBlncEFSsfKW5G3ww9LvID5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760346; c=relaxed/simple;
	bh=wcB/ebDhkfkPBVDQxoUt3AjUlhzpSXzz59SF5DkeLyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U9jLl3kRJHJPUj4WQSEQiIdkDY4yYqbqW54GLn2JCq/AjLi4bgyda+ItLfi+ZagzVE7j8Fzs+W3KZxj6uI52K/v8GVpIi3MO12Bs2ExZiAUPsQsQfqeOioDoSXI1kQJBOaipyg2KYau5uNVN5VnNDF+G19x8SodChtvmlXR3NdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=iJ8F2e4v; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f453d2c5a1so2852b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 11:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714760343; x=1715365143; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bC8+jsiLZWKY+UGyCwiSu3stdoXyccUkl5+IF/7wAA4=;
        b=iJ8F2e4vTS4lY9LLj/66eS94/tGJMg16Y4r9oadvooy/STIUVKOI+lx+AcwyNva1pE
         4UdmtE4URe/KzESsyeHl93YsNTkpGOl2aDn1gXz2iNq9FJFNjzltpRIiQyNaInghDkHK
         laimliVcAIoKWldzipp4lQmCeflRKeZV0UyaYeSXD2uxDDMbShteB/LgjLkb6iDOfXfI
         yVh+l/LVE4vk5+n4BmStuxsLIcl/VACs7OYaFgechostkcWSs+BIT+WHUz9zoIKMTDHg
         rBDImFZydLmUbo3uy/k/p7Ky3QBK/xUchF4XqkqemP+iqedzRSHmOTALLqKbl9fA2qdh
         v5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714760343; x=1715365143;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bC8+jsiLZWKY+UGyCwiSu3stdoXyccUkl5+IF/7wAA4=;
        b=BuXh+fJ8qQE3QW0SdEe4ooGIXf0w5m2bBx9GabTX0mptrdEIwkm0say3CN/o1zgnop
         8nGwz3By+I9hvHx+y+xhVvshOZ2XYFCM9Yorf/h2l4Uc/Ji/V9BjnQtikm4Oa23BS+f3
         YtW/I0ygM6XCiF+QHFSogW1TmmurHutInII6iPTuXaEaQd1T5KtlmTOt2dfJNjxCFBrc
         50SWR04+lpva27F9ET1cWqtxhrPLQsr5xED5+JnJNi2Aoym4TZkl2ITw/8LH3RrtYn4q
         kv8nxX83KENREQig5gt8MPTZkGIOjfvqldHTPy1OT2eSvlj1DZQWGmaJm+Vjl78MdEnc
         sL4g==
X-Forwarded-Encrypted: i=1; AJvYcCWs4JFl1pUJiJ7J5lJO1drRsU9ZXU+jh+kfRngvPaIySKlpe6u8SxugjiKDmPhlkw1SCJd2+Ny/BEf20Vxnu7FqhzJLJ92aldrRS62p
X-Gm-Message-State: AOJu0YymgKbwy3gvi2UeuX7fxOXlrX3EQ65CNO7FJ6fz+CUt2UtJAaiE
	ezBbYeVeWU0OMazJAk9lQFRNzdlWF3MWoy/Ir7BPL9qlXGRYq0KkdhanB7crmyI=
X-Google-Smtp-Source: AGHT+IF7gftC9fEPBK3Bggf4eQiSggGKhcVSlVmTLAC1VCCJYp1g2BuCN/OUrXEqJOUkjFfaFq/CxQ==
X-Received: by 2002:a05:6a00:a1a:b0:6f3:368d:6f64 with SMTP id p26-20020a056a000a1a00b006f3368d6f64mr4353833pfh.2.1714760343431;
        Fri, 03 May 2024 11:19:03 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id fu6-20020a056a00610600b006f3f5d3595fsm3355421pfb.80.2024.05.03.11.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:19:02 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 03 May 2024 11:18:25 -0700
Subject: [PATCH v6 10/17] RISC-V: define the elements of the VCSR vector
 CSR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-dev-charlie-support_thead_vector_6_9-v6-10-cb7624e65d82@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>, 
 Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714760319; l=954;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=C7F1c584ODJM4qF9TPT5kMoM8fDlOPYyEMw6010Mea8=;
 b=QAfri3k8PmVP8oWnQJb1YOL2NJYh4cui2R3V9rrymRbcl7uWQRGXqUcdkbJemfvjyjiKlMNx8
 hUbYcNkff72Ce8B0MIDoDdfDtiaumUjXLUkJ+tfHlem018s17zddUrA
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

From: Heiko Stuebner <heiko@sntech.de>

The VCSR CSR contains two elements VXRM[2:1] and VXSAT[0].

Define constants for those to access the elements in a readable way.

Acked-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 2468c55933cd..13bc99c995d1 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -215,6 +215,11 @@
 #define SMSTATEEN0_SSTATEEN0_SHIFT	63
 #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
 
+/* VCSR flags */
+#define VCSR_VXRM_MASK			3
+#define VCSR_VXRM_SHIFT			1
+#define VCSR_VXSAT_MASK			1
+
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00
 #define CSR_TIME		0xc01

-- 
2.44.0


