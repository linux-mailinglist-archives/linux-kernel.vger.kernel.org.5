Return-Path: <linux-kernel+bounces-38006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADF483B99C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6012D1C23926
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F4F1171F;
	Thu, 25 Jan 2024 06:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="k+lyewFH"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6180D11705
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164110; cv=none; b=XAZh+I/g+3bEhxzFBxmkzWfXeR2A0CoVIVMAmrrTkeGPLTUD9TYEa6vdz6izW8t46e2iPY1MvcbhbKI6P2mvk9dnmVcdCfqzwC1gTVvqdnK96x41cfR46/+RW78Mt5G79Cs07sVbZnzryZyFVZfInTU50UFscZFa0kkHnson6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164110; c=relaxed/simple;
	bh=rjN/tLQGMBp9jnM1L1ZfLUL/UMdi1I4Umc0mfIrOoTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ky8V3E46qkqa10CaW+WR4GhHhWdkguXSg8O0X8pLg65hucm+WTJwjTjZvraol4P5h3m91JUW7xQenklw3q17OcaOkgR/qThkUpGMjrbu58J6imWNy0wF6Shtm2scZoVviZFsjb48GxMHd9Sj6P0t6A+xHKSjRf+LMljAQ8rDIQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=k+lyewFH; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so4243757b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164108; x=1706768908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioE1LIRdb8UGU7iHQDrnlckX+FNXkyoBwT0Lgj/da5g=;
        b=k+lyewFHKBBrNOC49D2eN5Y5EaN2zFjK84usZ1N+KfHDyi4q4P8wbC56+bZwkhoIng
         keBUe8N7Qh2Ib6uQ6KUjjRZbmKCMAbO0AgSSwOys+gLUDony6adiZ7CttyKgeJK0tGdF
         a5PSxrBHanp8WedZiHW17LwFjOPJP81n4A/tbXCqYNgITr6cEGUulWAVO79Dsv0MjRoq
         jEmBNedCQBE+Ogl1IdJv8jGRwhezsQ7AWyULYqL0iO5AXfvJFXc0BYPRcD33ZVwhTM+D
         juUhUq6/OIybst9O17HQP3/yUJxRZZfmPA/u/88cHoP2XtmxWG3NhMMfauA6ckgjwkVs
         y3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164108; x=1706768908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioE1LIRdb8UGU7iHQDrnlckX+FNXkyoBwT0Lgj/da5g=;
        b=VVb2gahmHDYhce8xslIEyoDi/tSVbd1yhsrQn2UuDI2jGDFiZZAF3JlQCsM43aSFbf
         aK7ITrSwsLPR35dez3H8lr/jJl160Ba9y+eF2EPcWSi1abJVUoPAtZxbtcqyykFRx0fR
         RCQbB3s3dY1x17bXIqkMnKc0Aj73K3MPC/Hh/VHGa6UyyVKfJgAmxA9zVUBf+ZJ05wI3
         +2IE2Ud/JWhQUbIpConseizNcEwfz2H+9P/BhswfHXc8cEpICSkM5AO489mAGdArltRd
         uRY2Nu6N8j8hyDmUMIfnj/nNkRCM78QKsCHnS+E/+CfmfUZvCH3hxk9CSwk5zy7WokdY
         LzfA==
X-Gm-Message-State: AOJu0Yx6wUff0sBlZb+c8xyKfNzi0zFoZfvzWrlyM3B5hgclSlh4SnTf
	nw41fgpTyrZCnmlamXWqWxNmwotP6f2kgInacrnC7lL76uVbm0xp9IQzuAVPCRk=
X-Google-Smtp-Source: AGHT+IEDX9sIkxnHph4wuJVvd42o38950kc3fb8mUyOs60adtjswg3LDjUQk/s2QDj8rOhFBqYZqog==
X-Received: by 2002:a05:6808:159a:b0:3bd:7218:f318 with SMTP id t26-20020a056808159a00b003bd7218f318mr526373oiw.4.1706164108504;
        Wed, 24 Jan 2024 22:28:28 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:28:28 -0800 (PST)
From: debug@rivosinc.com
To: rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com
Cc: corbet@lwn.net,
	aou@eecs.berkeley.edu,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	waylingii@gmail.com,
	greentime.hu@sifive.com,
	heiko@sntech.de,
	jszhang@kernel.org,
	shikemeng@huaweicloud.com,
	david@redhat.com,
	charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn,
	willy@infradead.org,
	vincent.chen@sifive.com,
	andy.chiu@sifive.com,
	gerg@kernel.org,
	jeeheng.sia@starfivetech.com,
	mason.huo@starfivetech.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	ruscur@russell.cc,
	bgray@linux.ibm.com,
	alx@kernel.org,
	baruch@tkos.co.il,
	zhangqing@loongson.cn,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	joey.gouly@arm.com,
	shr@devkernel.io,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v1 03/28] riscv: define default value for envcfg
Date: Wed, 24 Jan 2024 22:21:28 -0800
Message-ID: <20240125062739.1339782-4-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125062739.1339782-1-debug@rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Deepak Gupta <debug@rivosinc.com>

Defines a base default value for envcfg per task. By default all tasks
should have cache zeroing capability. Any future capabilities can be
turned on.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 2 ++
 arch/riscv/kernel/process.c  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index b3400517b0a9..01ba87954da2 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -202,6 +202,8 @@
 #define ENVCFG_CBIE_FLUSH		_AC(0x1, UL)
 #define ENVCFG_CBIE_INV			_AC(0x3, UL)
 #define ENVCFG_FIOM			_AC(0x1, UL)
+/* by default all threads should be able to zero cache */
+#define ENVCFG_BASE			ENVCFG_CBZE
 
 /* Smstateen bits */
 #define SMSTATEEN0_AIA_IMSIC_SHIFT	58
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 4f21d970a129..2420123444c4 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -152,6 +152,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 	else
 		regs->status |= SR_UXL_64;
 #endif
+	current->thread_info.envcfg = ENVCFG_BASE;
 }
 
 void flush_thread(void)
-- 
2.43.0


