Return-Path: <linux-kernel+bounces-62915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6018527CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DC9285D80
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D73F10A3C;
	Tue, 13 Feb 2024 03:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XJFJzuM6"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A160BE5B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707795472; cv=none; b=o1lmTC/wgCejwQTns+j1Q8dxG3SEEzhXuBn7233EyijOHQPQQ8hknNlxDfjNPLiiPJ3CCc9DjpqRSDBdRKKfKCzQ8AWDcKe7xYLst4DoN9HSdxxyk0CL+6WaD4+ljVGhMR5AfqIgtAaha4LAEebMEK/GpcRS1BqokXk7rie+XHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707795472; c=relaxed/simple;
	bh=+XzSJU8wJISBeAeCiej2B/wBCsa3VX7K7aJaMYWlWHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iN2aozxKqDNW/iuAoPJAeb4pIAmGWbp/JCHDPU/5tNYCj09TuZUF5IjsUAbQvSqtubN2nWIiLeJnkwBwf0c5Zrn6iZv31V7X9u2CXb38o24/pT7XLhFG9h+IkBSMI3upbJGrEatq3M9Q/SXzGj8Rgw0OQbWwFuSvYObNR/yoMsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XJFJzuM6; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3be9e11ee59so1944523b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 19:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707795470; x=1708400270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xt5jr7Ps3GScSgM4o7qnaO9gd+HMLeMAVDsngYj3hEM=;
        b=XJFJzuM67MXtfpkGs0KHvLwS+pPs4cY4Qf7d8/7K691a5Wo7068Y+7x9taLX3Te7lF
         4Zi/enU/fL4vFuVicBRhMa2tnYTB+qeXbgw28X0SPbez7cDGlsSjXL9yBuBlM3eoKo7t
         u3s3pKV6d6nTPuJt1vgvWPwMmXa3vyNBrXXYnUS3Y7gwbemmVROA/7ZRfp3qA/6XTt2E
         3YuiVI2Ue4kbid4qvzFPa9FJFHmBsXoapFUfmHzSRTmQGCiYO/QiJf7hqA4XGDSYxjCO
         Zpc1GQad9l44MaDubenm0oXXheawV/OuGIK2XrFkvZMk9NoZ5Hse3uydfJFTVPgAZSZa
         T4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707795470; x=1708400270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xt5jr7Ps3GScSgM4o7qnaO9gd+HMLeMAVDsngYj3hEM=;
        b=nK0YMNrLaf3ujJjF4dTlLcqN7FcOTP/JelLqkqilAbap47N3iFt0TAKHafPmyNuqNN
         ksBUxo8HNnU+PAyI+LvaNQZ41TZcqh9ticZVyaRfhbb8/QdmBIQDnzeXfq9M83Z2eSds
         UTThLZTLqKHY/vrZXRLBrCdaVBrviniGWtfFWGfyvh5bBWqRMfMADnQMagLXF2d7yXD7
         DveynSLAj/M6HpeuZHAGMI8tQBtJfwR2ULZHp1cqbbbe9VcghY23h6kkMvvEKsEttT19
         hw/zSOyU0a//3fNAXoXGTV7duFT1H5qfCg5S18RBpEN6k7JwTqCBnvWEd0IO2FIKl79j
         ZKVg==
X-Forwarded-Encrypted: i=1; AJvYcCWqdnN/qKMv3esE6j0BFs115IDYx1rjaLUlsckasTXB/AVcakxwlviX6ihSSsUn/T2HNC16cIWP1kIsxi7XIQcaJbxrarU4z23IpkV2
X-Gm-Message-State: AOJu0YzLJZg5KnSomudOOARTHObK6nq9rPwPE3vOxTBwBd2qXhJGtdM7
	jHwS8dShqwsQMRoK8Vc2iipvYdCAWR3oFpQdAu0NMqTALJg6lpvagRble51Ef2c=
X-Google-Smtp-Source: AGHT+IFxDqSZbCOTRS1NHVNzCKhxZQyImRcw90Jz8SlHs0SSV2MQ75bbrukIBm2CKyA3KzugicZ3nw==
X-Received: by 2002:a05:6808:318e:b0:3c0:3e26:5259 with SMTP id cd14-20020a056808318e00b003c03e265259mr3613268oib.55.1707795470293;
        Mon, 12 Feb 2024 19:37:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1Rc/sB1dWFTQwmx8p2iRKVv5LgWrJCCSeKr8P6rkMbd1uH7JfQSG1Hh74JOY/jKeiuxbEy02WDs3e/g0A9q30Q69s839YsJVcUxX+VSSGNa6J9l4dlN7oNmWZViRGWfRPnJ4HGTtAfEOZMIknw36bZj+YL2HlkbpMT607pb4e7y6zq/Em6Inl3R1cLd8ht02GMlwLAyCC8dUbcCwwaoAhdKHd9WN0x4go0e/Cp4Rmx44os1Oj
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id v11-20020a056a00148b00b006e0334e3dd9sm6188633pfu.76.2024.02.12.19.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 19:37:49 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan O'Rear <sorear@fastmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	stable@vger.kernel.org
Subject: [PATCH -fixes v2 4/4] riscv: Save/restore envcfg CSR during CPU suspend
Date: Mon, 12 Feb 2024 19:37:35 -0800
Message-ID: <20240213033744.4069020-5-samuel.holland@sifive.com>
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

The value of the [ms]envcfg CSR is lost when entering a nonretentive
idle state, so the CSR must be rewritten when resuming the CPU.

Cc: <stable@vger.kernel.org> # v6.7+
Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Check for privileged ISA v1.12 instead of the specific CSR
 - Use riscv_has_extension_likely() instead of new ALTERNATIVE()s

 arch/riscv/include/asm/suspend.h | 1 +
 arch/riscv/kernel/suspend.c      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
index 02f87867389a..491296a335d0 100644
--- a/arch/riscv/include/asm/suspend.h
+++ b/arch/riscv/include/asm/suspend.h
@@ -14,6 +14,7 @@ struct suspend_context {
 	struct pt_regs regs;
 	/* Saved and restored by high-level functions */
 	unsigned long scratch;
+	unsigned long envcfg;
 	unsigned long tvec;
 	unsigned long ie;
 #ifdef CONFIG_MMU
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index 239509367e42..be03615486ed 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -15,6 +15,8 @@
 void suspend_save_csrs(struct suspend_context *context)
 {
 	context->scratch = csr_read(CSR_SCRATCH);
+	if (riscv_has_extension_likely(RISCV_ISA_EXT_Sx1p12))
+		context->envcfg = csr_read(CSR_ENVCFG);
 	context->tvec = csr_read(CSR_TVEC);
 	context->ie = csr_read(CSR_IE);
 
@@ -36,6 +38,8 @@ void suspend_save_csrs(struct suspend_context *context)
 void suspend_restore_csrs(struct suspend_context *context)
 {
 	csr_write(CSR_SCRATCH, context->scratch);
+	if (riscv_has_extension_likely(RISCV_ISA_EXT_Sx1p12))
+		csr_write(CSR_ENVCFG, context->envcfg);
 	csr_write(CSR_TVEC, context->tvec);
 	csr_write(CSR_IE, context->ie);
 
-- 
2.43.0


