Return-Path: <linux-kernel+bounces-124136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF5B8912D3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1208F286EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45FA54F83;
	Fri, 29 Mar 2024 04:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hSHHA9Ke"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D08253E31
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711687609; cv=none; b=dCzVfC9n5lIags2XumEtUiOcPuW4NOc1H/4pdxEHnAZSGur4m7g6pER7l7b7Hs2dBq/MP75V8lc9KCSAjD9TZhKTrlsJnb++iQHcIGVavBj9RC/G2HCs5VA2RbgxNaSqgKXaumqmq0MlO+4Rw8PXCTEQFhmFhm7c5z3aUQYUhqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711687609; c=relaxed/simple;
	bh=tp04Tian2VbAgQyGkrhWqNwzdHeK/WyQhUL89J1WvPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GwEVJkvOjK0lPHqfARoSyZmlILLvqBz33mWRdv9cmoAHoBu6fHSV8LJvMSgGm3qidxq75BAJkhS5XTMqEDx2azoFcVDdnX17awy7rSe+8dqS4jNOHIFNX2JdM6LyewzmjimghsP9K6fVn459vs64ztIEwNh0YPyBPdFlyk9Onlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hSHHA9Ke; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ea8a0d1a05so1782398b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711687606; x=1712292406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jzaUmiaVJT+7AndpgdFUVtlaA8dH1VTGpl1Yp0ZHRo=;
        b=hSHHA9Ke2WuQz9S+0ugebZaQHaPdXUt9olJ+rrReaptyxKFNAvhkZEjvUyjaCjfSTf
         Pa6C8KDgRKeT9OKuNFagB4AC3OaKbZvn+Y+RKGy81yCBkxCDu1b+ngLgQ4AQm6nC2X5P
         JUApcOcjXOedWZeyg5iGD2MNnzVcDnU5KbrtgH8r5uaGfbom0ARX5Bp0FIcLiVo221kD
         T2wYs9HymvMf9vQMzYzVPQjm/KlvunLoTCemqDpvgIYKQLz5E0IeJxMxkituXNKNRnkl
         0FzbWBftSF1BE/GNtT1P+Q3VLw7JrIJyD8dmmzOF+TsMc5CPERdXIF8FYcCycztqorHP
         cNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711687606; x=1712292406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jzaUmiaVJT+7AndpgdFUVtlaA8dH1VTGpl1Yp0ZHRo=;
        b=pTC0E0WoASsiUFAF7lYuV8/ls4oJY4T79VUdrD3+O1v23icSkni62BZWPRcZbDJ5By
         oU3yGxvUYsVs0P05PwIEdNHYPCYxaKYWEx9+5D30v07+v65CAjRizkAD2fvV6lvczzvR
         m+qIY5UnmrzA/EDxbR13ETsJPElrjquREm056QbKq0Mbu3yGnJqxdMplFS1nHtnrJuQ9
         1+LjKInpXd5CQ/ggZDQzWTBxhxlXpok+S6HGGTvSv5YvqpImalWsXQuJKtnbQBc/N4hT
         qrGana8tUxszRZApdbyiCfX5VhWNCqCom09mWlq+h1WPrJoTSdUjJ0dfLdTwht/dfC/X
         qHDA==
X-Forwarded-Encrypted: i=1; AJvYcCUMSVND5RC1uTFHuqRjrxnNyU+PGATK0/X8GHbTSz8cCmIgffp6L2X7DYwFxuKq8cbQS5Hhl39gnKozpR9GzVdXSSZnnxINoV62ZdJp
X-Gm-Message-State: AOJu0Ywuiwpu7kdu+RwB7dqjNEeTcIvYfM2feSEuFUgbGSfhPqebJ+Ms
	QJODfucpHCqPxf/Kt3SiyVvpHCffN2XhTf60Cp5Vn/Ir/UeZVz9IUeYiojjLMTs=
X-Google-Smtp-Source: AGHT+IFw+iNT/fZ7ZDIngivJRJR8RkOVDCFWMSifsiSz96HEhcDTVYzJoolJ7eKeIz36X1Q6OzEzmg==
X-Received: by 2002:a05:6a20:8414:b0:1a5:6c7a:a60b with SMTP id c20-20020a056a20841400b001a56c7aa60bmr1845203pzd.11.1711687606505;
        Thu, 28 Mar 2024 21:46:46 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id i18-20020aa78b52000000b006ea7e972947sm2217120pfd.130.2024.03.28.21.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:46:46 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	samuel.holland@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	tech-j-ext@lists.risc-v.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	hankuan.chen@sifive.com,
	greentime.hu@sifive.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	charlie@rivosinc.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	sameo@rivosinc.com,
	shikemeng@huaweicloud.com,
	willy@infradead.org,
	vincent.chen@sifive.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	gerg@kernel.org,
	heiko@sntech.de,
	bhe@redhat.com,
	jeeheng.sia@starfivetech.com,
	cyy@cyyself.name,
	maskray@google.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bgray@linux.ibm.com,
	mpe@ellerman.id.au,
	baruch@tkos.co.il,
	alx@kernel.org,
	david@redhat.com,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	shr@devkernel.io,
	deller@gmx.de,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: [PATCH v2 19/27] riscv/kernel: update __show_regs to print shadow stack register
Date: Thu, 28 Mar 2024 21:44:51 -0700
Message-Id: <20240329044459.3990638-20-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329044459.3990638-1-debug@rivosinc.com>
References: <20240329044459.3990638-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updating __show_regs to print captured shadow stack pointer as well.
On tasks where shadow stack is disabled, it'll simply print 0.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 105ceb8880c1..97c812753c9c 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -89,8 +89,8 @@ void __show_regs(struct pt_regs *regs)
 		regs->s8, regs->s9, regs->s10);
 	pr_cont(" s11: " REG_FMT " t3 : " REG_FMT " t4 : " REG_FMT "\n",
 		regs->s11, regs->t3, regs->t4);
-	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT "\n",
-		regs->t5, regs->t6);
+	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT " ssp : " REG_FMT "\n",
+		regs->t5, regs->t6, get_active_shstk(current));
 
 	pr_cont("status: " REG_FMT " badaddr: " REG_FMT " cause: " REG_FMT "\n",
 		regs->status, regs->badaddr, regs->cause);
-- 
2.43.2


