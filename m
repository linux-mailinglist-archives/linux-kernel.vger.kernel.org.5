Return-Path: <linux-kernel+bounces-155203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CD98AE6B3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10A48B24187
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFB8138489;
	Tue, 23 Apr 2024 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1ipyj/0R"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ED013775B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876234; cv=none; b=LAROBxKwkEE8epxRZmy5K/UUO53b2e70mQLrqrqs7urtGO+BpBS54i6QYplj+e9BUZ6ZErUEPjlDfBY0LqOJki3zX8UAeVgaLDjcqvvtwIjytvpX7hHvcEIvyU4XDKtlbvOBhOlp3qZLAFaGWYlbXrZP2GXLhmIlTVXjmrjW/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876234; c=relaxed/simple;
	bh=VBYIkTZIleyOsUo3Vs7GTW09WzwtONhQK0/AstEMTYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVOEWWFwq+Vf5KgSo9oviJRbfQxVVIK3sDXTxn2wW5nsHZRCJwpRbSN/0qtfwCN/88ZkxcvQ5AHEP4JDlyZ3+fu7bq8YBTOTRWndUygpLtZko5W+KBG9ff+zF4CCdSN8D6/qw3gktdUoN30B1PXjMSX3uj67A1Gorw9oc5GXs38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1ipyj/0R; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34a0cc29757so678259f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713876231; x=1714481031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdCfPjm06PN8DLWdVlWU7iGB8QhHqS8f5T3HQCXkkpY=;
        b=1ipyj/0R4wuaXYiZe9UOQtmKwvgc9sqS8D/5SMqvsfhUxasa1ImT7CMDuvAwBYHwet
         zIbY88j+DHI5lb29GgCQ4854zrDhNhB+ZStYBCY9PBZEiMxNAKxcutGICai+7L9xQHXI
         mwZUAIv23+OOPBfeS/Q3yQ2Z8v70supyWxlnGL/aBWJBXfKRjJjejKhMy9dg4OCaAXhf
         JMUtjU9Q0T/qLNRPP/Ygz9PIf4dGmKzWkuSzwHhZj6FuP2zP0RYIlra0qpc5aBFeIZv3
         ENB/9nKRTeKMnR5EL8L9wlaH/kDEYfPchinDA8/CP5Cx1GAIWaOsVf46T6AWw20PiQw4
         ziyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713876231; x=1714481031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdCfPjm06PN8DLWdVlWU7iGB8QhHqS8f5T3HQCXkkpY=;
        b=dGWtssKQj0xozLiQ0jk3rmJXzNpcdP9o/12kaI4dBUfSPlWNwzvowCK82MlISfz9yd
         cufQU9H7hjz+cqScjQtIuekwf1Ugvw3I+kRku4Vv9ZDwZaMAw3spCZ2+befdLHAdV/NP
         S/PLSe3RrVTB1nhPqRz5ua5S5GAMnnt/mJ51jrPPVOyK7L0JBrdb4957xFow2rS/8lLV
         3OL+wFfng48IR0pHQYRgxNrxQ3hDAstwHTL4KWwsP0Ueq9KvGPx32YIAYIN+Bkpv7HfU
         4BGSPogCXivi7eQ4hHLnGUBfV3VqnQW/WgyyO3ddAN2S7yiAXx/ymTRP4XGjKCQfwXeH
         Uvow==
X-Forwarded-Encrypted: i=1; AJvYcCW7EiyA0/MTPVyeaaYQCwpfFjIfyeFz7zPXnVcMPh/fS9/T6nQKREQmmX6xq7iFypQOfHgglGWcTUXRQ4SVb2Ib2lANTHcyoJZUle8S
X-Gm-Message-State: AOJu0Yz4cCozEMpSal7Ztse0+v1EGcorYN1vtK+TwhoWrW/Vt/pN813T
	RGU2a9JVaGkXQR1E/Tjh+kUe/7mgi+vNO/kxbHLCsYG0CgE0mVHT9KJE9HgL7eA=
X-Google-Smtp-Source: AGHT+IEwxP4cmnlN65ejt3BUPk7jfIkLB8aRDSbaf6thvUjYkqGY2x1c1seifl/qbhrG1IVOTMxUHw==
X-Received: by 2002:a05:6000:22d:b0:34a:5640:453c with SMTP id l13-20020a056000022d00b0034a5640453cmr7273001wrz.2.1713876231406;
        Tue, 23 Apr 2024 05:43:51 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:71cb:1f75:7053:849c])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b00418a386c059sm19975709wmo.42.2024.04.23.05.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 05:43:50 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 09/11] riscv: hwprobe: export Zcmop ISA extension
Date: Tue, 23 Apr 2024 14:43:23 +0200
Message-ID: <20240423124326.2532796-10-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423124326.2532796-1-cleger@rivosinc.com>
References: <20240423124326.2532796-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Export Zcmop ISA extension through hwprobe.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 4 ++++
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index bf96b4e8ba3b..e3187659a077 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -212,6 +212,10 @@ The following keys are defined:
        ("Zcf doesn't exist on RV64 as it contains no instructions") of
        riscv-code-size-reduction.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZCMOP`: The Zcmop May-Be-Operations extension is
+       supported as defined in the RISC-V ISA manual starting from commit
+       c732a4f39a4 ("Zcmop is ratified/1.0").
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index dd4ad77faf49..d97ac5436447 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -64,6 +64,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCB		(1ULL << 38)
 #define		RISCV_HWPROBE_EXT_ZCD		(1ULL << 39)
 #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 40)
+#define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 41)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 2ffa0fe5101e..9457231bd1c0 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -114,6 +114,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZIMOP);
 		EXT_KEY(ZCA);
 		EXT_KEY(ZCB);
+		EXT_KEY(ZCMOP);
 
 		if (has_vector()) {
 			EXT_KEY(ZVBB);
-- 
2.43.0


