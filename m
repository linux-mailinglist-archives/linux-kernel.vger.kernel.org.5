Return-Path: <linux-kernel+bounces-108168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FE7880709
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5B01C21A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848445FBA3;
	Tue, 19 Mar 2024 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="W85OC70k"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A41E4F889
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710885562; cv=none; b=nijB9tLFKzcgEklQMoeY+mY3ORdnCZ/MAHsjMLp9CXCdZZqbRKZyxE/A0BuZxMYqrlRXzHgyVfLCVFwlVQrMN+4PGhdJrcUk5q95cRhrzwuyndcfC4o8yqI0wssbS4Uwx7b3VXvhssZmF8H7qHZLUW/RPVfZFu4h8wfwNwQWnVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710885562; c=relaxed/simple;
	bh=wHfkhBjk4EJwleLNFDS1G7tKP4zQ9iqJu5m1epS8di0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+Fh70WhPi8VSsA60zjfPfsLgE7BuO3BQQvR8qFj1/U9oUZI7VV23d/+2kFQL3olc0Sxmwd82lFX9VBcWuyGLTkIj3wP9yFvi0WY8xEgXmE/a0qa1oIjgSLV37zzR0lYRk99I6YS3pVw/+yO29KhlXsj2Z+yAhiukWYhDeDQoc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=W85OC70k; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6ade6a66aso5353989b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710885560; x=1711490360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hw7AaJXdckjCcYy8ru8KTiHIANuUIN3Ni5CiYoljsMY=;
        b=W85OC70kddP+ELwthb4PQClo0mt5OfbkYkCHOk8qp1SSrRePovkJmn2NiM7rAauM5l
         vSzD2ozmK7dywJ3XXxZDzjthaXxjC8VYkRkht16CkJiPgzLsPEMay20PZwaV74Q5riPH
         yVcGcN1pEAtxju5wrUNItN7aIZDcFHR+GzjIl1LWSkmCJaVHQEOTIGQN3Fl5FBi/NAoe
         RL41NI2RrwhgSMCmuZkm2x44KdoBzxYlkLFbD6Csi2rYKlXFOFA1/ex5WfMrA5SWBeO5
         QKBhgcZBbKuf7YpUFuGtBn1SCSDz6Ec4FwCi17GDgnCRO+yfjLZgimcP3FZ6kYu358kc
         b+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710885560; x=1711490360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hw7AaJXdckjCcYy8ru8KTiHIANuUIN3Ni5CiYoljsMY=;
        b=JyQl9CcwFq2X8x9SnMF3LCbpQz0R5FZ+AYfAXfskDxjC2Phf50r7JP43u7dXcjGGxK
         NVD55yEvO887vIsCTG3rZHKO/Hx3lXLXTkKjckAH583SMIeL4srRNvpH6OUzEm40MklA
         iJCvEwd+C+X/y8rJn9J2l4J8+dpafdKCtZyDZF0wh+x1pIWJ3twdCEnzt6RSGdw3g9cq
         gdXVn+C4hIeMu/ejwKWN0c9zvsZ+3ZrW2YetgA7X68xGjB9FAPJI7qWIzjmtuurf+T9p
         EUVYYNIh86gRY1gtLR605urL+VauMapCMqDe/TkifWARZB1LXq2jMjl4hShgJOOcrrfk
         6tSA==
X-Forwarded-Encrypted: i=1; AJvYcCXEhK5oQl9oizOJLBoicy+yRotXa6U0+MQD5nQ2Lz/ZVqQzAgKJE/X1mWdXGPy0cJR4ImLE7/q6d4lFw40WnaC6Z9gMpH6o+dQHG7T9
X-Gm-Message-State: AOJu0Yzy/MpkVlEot39JVM2j+MhWfwa4PQxrZEMKy0JBPsFlk6oLmgRg
	N3cf0plwBbIqf04CM8d0ioXKPYuozWI8nnA1y2L+QOdME/cgW/oCzGkI+toTg9I=
X-Google-Smtp-Source: AGHT+IGDkK4VMEEzpfRCSNThBGjrgCcpdqf0s10wRrEBrgNVgbv2+4UnRTUBfVw5XKDLPYKeaCEdMQ==
X-Received: by 2002:a05:6a00:1701:b0:6e7:8047:96f0 with SMTP id h1-20020a056a00170100b006e7804796f0mr796041pfc.28.1710885560589;
        Tue, 19 Mar 2024 14:59:20 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id z25-20020aa785d9000000b006e6c61b264bsm10273892pfn.32.2024.03.19.14.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:59:20 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	tech-j-ext@lists.risc-v.org,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Greentime Hu <greentime.hu@sifive.com>
Subject: [RFC PATCH 3/9] riscv: Add CSR definitions for pointer masking
Date: Tue, 19 Mar 2024 14:58:29 -0700
Message-ID: <20240319215915.832127-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240319215915.832127-1-samuel.holland@sifive.com>
References: <20240319215915.832127-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pointer masking is controlled via a two-bit PMM field, which appears in
various CSRs depending on which extensions are implemented. Smmpm
defines the field in mseccfg; Smnpm defines the field in menvcfg; Ssnpm
defines the field in senvcfg and (if present) henvcfg and hstatus.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/csr.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 2468c55933cd..1d5a6d73482c 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -119,6 +119,10 @@
 
 /* HSTATUS flags */
 #ifdef CONFIG_64BIT
+#define HSTATUS_PMM		_AC(0x3000000000000, UL)
+#define HSTATUS_PMM_PMLEN_0	_AC(0x0000000000000, UL)
+#define HSTATUS_PMM_PMLEN_7	_AC(0x2000000000000, UL)
+#define HSTATUS_PMM_PMLEN_16	_AC(0x3000000000000, UL)
 #define HSTATUS_VSXL		_AC(0x300000000, UL)
 #define HSTATUS_VSXL_SHIFT	32
 #endif
@@ -194,6 +198,10 @@
 /* xENVCFG flags */
 #define ENVCFG_STCE			(_AC(1, ULL) << 63)
 #define ENVCFG_PBMTE			(_AC(1, ULL) << 62)
+#define ENVCFG_PMM			_AC(0x300000000, ULL)
+#define ENVCFG_PMM_PMLEN_0		_AC(0x000000000, ULL)
+#define ENVCFG_PMM_PMLEN_7		_AC(0x200000000, ULL)
+#define ENVCFG_PMM_PMLEN_16		_AC(0x300000000, ULL)
 #define ENVCFG_CBZE			(_AC(1, UL) << 7)
 #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
 #define ENVCFG_CBIE_SHIFT		4
@@ -215,6 +223,12 @@
 #define SMSTATEEN0_SSTATEEN0_SHIFT	63
 #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
 
+/* mseccfg bits */
+#define MSECCFG_PMM			ENVCFG_PMM
+#define MSECCFG_PMM_PMLEN_0		ENVCFG_PMM_PMLEN_0
+#define MSECCFG_PMM_PMLEN_7		ENVCFG_PMM_PMLEN_7
+#define MSECCFG_PMM_PMLEN_16		ENVCFG_PMM_PMLEN_16
+
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00
 #define CSR_TIME		0xc01
@@ -381,6 +395,8 @@
 #define CSR_MIP			0x344
 #define CSR_PMPCFG0		0x3a0
 #define CSR_PMPADDR0		0x3b0
+#define CSR_MSECCFG		0x747
+#define CSR_MSECCFGH		0x757
 #define CSR_MVENDORID		0xf11
 #define CSR_MARCHID		0xf12
 #define CSR_MIMPID		0xf13
-- 
2.43.1


