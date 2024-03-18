Return-Path: <linux-kernel+bounces-106011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B7987E780
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45524283609
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4F537171;
	Mon, 18 Mar 2024 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bnjHSg5I"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EEC36AF8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758417; cv=none; b=mLewXOwscK9h240K/xKeu0Y6LXuvZTuwphnS0zSv+6aJQRNH8YP0wzD3/zcqf2zXiFhcLAfJ2ph8bI7Y8uAQEQnIdCxDyESbVg5/QS9uU/692FhmND3mnHC+IQJAGAR69yIMxVu8DuVFtcM+zwast12EpBvYsoiEN2ZIzgR8B4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758417; c=relaxed/simple;
	bh=DJ3PWtnNU805CN/0jpeY/+ABkiC+sQKo9gh6Hsyv3SE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PzYrPH6DQKap+F4HW/+yi9NmCMXtUc1/coWq9PTV+YStq3U0owS/VgFrLUr4AfY14t2cuowrzNyxS4itHZyCRjtFskJnzGeZDnAcyerKr5DV1564iTFCC3tlWgZTFY34kzL+HDtwJq8BAoknhMBd+I2g+fHb3QylFsUo6kVZuPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bnjHSg5I; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c38855957cso679603b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 03:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710758414; x=1711363214; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCQe6vm/oJxMTsi/9kKYpE7XwZ+h04uGmZi4xHD22QU=;
        b=bnjHSg5II2IEccumtfH8sR++/nlkTnFLMUptkD8ofUj6Q172e4YN5Ji6suaASYcnzX
         cuQgowLqBzvjYPdaCMdggeaVFwbS9o1N2Dxy/UJt5at9xeUIvpjNjs4VOIf4nH9xiVt2
         nsl0dIOUQWScYUSAs+eIHzzPH87ZFx40c1YS+eIqGiZljdFSVnzJ9s7MX9om27inIdM5
         T52uTFkkNWZglG0uJsDIcoh6Q6OoLkYzXc2YwVXa32dXEw+jrzFHysCzDAI5kwBTACsU
         SxtsTVoOdoYtcn9Zz/1nC3aBpHrmRQqR62h8fjm3OKVbvZGr6LOd8Eb7dRLX0hCyauYz
         to0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710758414; x=1711363214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCQe6vm/oJxMTsi/9kKYpE7XwZ+h04uGmZi4xHD22QU=;
        b=riX/lATrXKRoraCzOMT3qJ5s4zL//hCwiIGg6roQ/kzuFfn+ERPJBzJRZwKuyrT/wC
         2p32vDEqRN+KtMjM3iKlgPYizhb2Ib5yq6QL6ZTVCo7nYDLGN4bCoi3C26oRZZEKHZCr
         vmwguwQhcdbbcYp2Z78ilW0d48BvQ6+bu5ZCKc5lFnQn0qWioLAjDlO11yHGLgb0RoYP
         EFtClai8nfW43ZmDsAK8R9TgBV4+q9z8mfTGyeTPhatRkm08nzlUY4/NyJOc7ghHir9e
         gdiME+UT/Wdh0n77/Hnfl1ySgTBjK530wOtsJXaMvn8MEy3MKdOUY3a+z33u8ce5zKrt
         7BBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGNGJkaehCbXD2p14ksNIZAsRyOFBhTvKaQLLDwsMe57kdo8g75S4bdiRpwxE8LBC3qUCLwwsux+vGpFqVB9NDSJ+LneTjrEP1hfHa
X-Gm-Message-State: AOJu0YyoLuZ9+sOLnyEHtS+0m4jCYGkRawd0FM4O4HEGHmujMPFoABGr
	4PDdP42m0QnaUgncXGDdEaQ2kEOygbIQ3vB2HMIC1IlhzeEv4/d1soZSACAk0zo=
X-Google-Smtp-Source: AGHT+IGdrnrLbW+USxO7ZpyEu3j4S8IlYwCytamjxZATZlbSTeWt8QSbTr/yKlh7P89dlOk6bQ1eFA==
X-Received: by 2002:a05:6808:19a1:b0:3c2:355c:e68 with SMTP id bj33-20020a05680819a100b003c2355c0e68mr13595173oib.5.1710758414484;
        Mon, 18 Mar 2024 03:40:14 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id c11-20020a056a00008b00b006e647716b6esm7838969pfj.149.2024.03.18.03.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 03:40:14 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Mon, 18 Mar 2024 18:39:57 +0800
Subject: [PATCH v3 4/7] riscv: cpufeature: add zve32[xf] and zve64[xfd] isa
 detection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240318-zve-detection-v3-4-e12d42107fa8@sifive.com>
References: <20240318-zve-detection-v3-0-e12d42107fa8@sifive.com>
In-Reply-To: <20240318-zve-detection-v3-0-e12d42107fa8@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andy Chiu <andy.chiu@sifive.com>, Vincent Chen <vincent.chen@sifive.com>, 
 Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor.dooley@microchip.com>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, 
 Greentime Hu <greentime.hu@sifive.com>, Guo Ren <guoren@kernel.org>, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.13-dev-a684c

Multiple Vector subextensions are added. Also, the patch takes care of
the dependencies of Vector subextensions by macro expansions. So, if
some "embedded" platform only reports "zve64f" on the ISA string, the
parser is able to expand it to zve32x zve32f zve64x and zve64f.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
Changelog v3:
 - renumber RISCV_ISA_EXT_ZVE* to rebase on top of 6.9
 - alphabetically sort added extensions (Clément)
Changelog v2:
 - remove the extension itself from its isa_exts[] list (Clément)
 - use riscv_zve64d_exts for v's extension list (Samuel)
---
 arch/riscv/include/asm/hwcap.h |  5 +++++
 arch/riscv/kernel/cpufeature.c | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index bae7eac76c18..0a05c4e6dcec 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -81,6 +81,11 @@
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
 #define RISCV_ISA_EXT_XANDESPMU		74
+#define RISCV_ISA_EXT_ZVE32X		75
+#define RISCV_ISA_EXT_ZVE32F		76
+#define RISCV_ISA_EXT_ZVE64X		77
+#define RISCV_ISA_EXT_ZVE64F		78
+#define RISCV_ISA_EXT_ZVE64D		79
 
 #define RISCV_ISA_EXT_MAX		128
 #define RISCV_ISA_EXT_INVALID		U32_MAX
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index cbdd63165e85..6e294a35a4b0 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -187,6 +187,35 @@ static const unsigned int riscv_zvbb_exts[] = {
 	RISCV_ISA_EXT_ZVKB
 };
 
+#define RISCV_ISA_EXT_ZVE32F_IMPLY_LIST	\
+	RISCV_ISA_EXT_ZVE32X,
+
+#define RISCV_ISA_EXT_ZVE64F_IMPLY_LIST	\
+	RISCV_ISA_EXT_ZVE64X,		\
+	RISCV_ISA_EXT_ZVE32F,		\
+	RISCV_ISA_EXT_ZVE32F_IMPLY_LIST
+
+#define RISCV_ISA_EXT_ZVE64D_IMPLY_LIST	\
+	RISCV_ISA_EXT_ZVE64F,		\
+	RISCV_ISA_EXT_ZVE64F_IMPLY_LIST
+
+static const unsigned int riscv_zve32f_exts[] = {
+	RISCV_ISA_EXT_ZVE32F_IMPLY_LIST
+};
+
+static const unsigned int riscv_zve64f_exts[] = {
+	RISCV_ISA_EXT_ZVE64F_IMPLY_LIST
+};
+
+static const unsigned int riscv_zve64d_exts[] = {
+	RISCV_ISA_EXT_ZVE64D_IMPLY_LIST
+};
+
+static const unsigned int riscv_zve64x_exts[] = {
+	RISCV_ISA_EXT_ZVE32X,
+	RISCV_ISA_EXT_ZVE64X
+};
+
 /*
  * The canonical order of ISA extension names in the ISA string is defined in
  * chapter 27 of the unprivileged specification.
@@ -234,7 +263,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(d, RISCV_ISA_EXT_d),
 	__RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_q),
 	__RISCV_ISA_EXT_DATA(c, RISCV_ISA_EXT_c),
-	__RISCV_ISA_EXT_DATA(v, RISCV_ISA_EXT_v),
+	__RISCV_ISA_EXT_SUPERSET(v, RISCV_ISA_EXT_v, riscv_zve64d_exts),
 	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
 	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
 	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
@@ -269,6 +298,11 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(ztso, RISCV_ISA_EXT_ZTSO),
 	__RISCV_ISA_EXT_SUPERSET(zvbb, RISCV_ISA_EXT_ZVBB, riscv_zvbb_exts),
 	__RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
+	__RISCV_ISA_EXT_SUPERSET(zve32f, RISCV_ISA_EXT_ZVE32F, riscv_zve32f_exts),
+	__RISCV_ISA_EXT_DATA(zve32x, RISCV_ISA_EXT_ZVE32X),
+	__RISCV_ISA_EXT_SUPERSET(zve64d, RISCV_ISA_EXT_ZVE64D, riscv_zve64d_exts),
+	__RISCV_ISA_EXT_SUPERSET(zve64f, RISCV_ISA_EXT_ZVE64F, riscv_zve64f_exts),
+	__RISCV_ISA_EXT_SUPERSET(zve64x, RISCV_ISA_EXT_ZVE64X, riscv_zve64x_exts),
 	__RISCV_ISA_EXT_DATA(zvfh, RISCV_ISA_EXT_ZVFH),
 	__RISCV_ISA_EXT_DATA(zvfhmin, RISCV_ISA_EXT_ZVFHMIN),
 	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),

-- 
2.44.0.rc2


