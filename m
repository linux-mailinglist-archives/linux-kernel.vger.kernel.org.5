Return-Path: <linux-kernel+bounces-38007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6F683B9A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D7E1C23768
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585E0125DC;
	Thu, 25 Jan 2024 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="C1OXUsll"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7871173F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164116; cv=none; b=sCdBUClMyFbd9aOpDdRrNdgPI0cm2DSbPGfJKEDFx8c+S6ZInk+6GkBcmYmRkwa+ykbBmdXgvnas74Gx+od8eBjBCNk7epSwBsXkiRr0z8EwLNHmz/DMaYZpqpbMVvHTUqaUs7AtiXouDfbFunqTp5Muucbv+6icWhNxBjeh5OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164116; c=relaxed/simple;
	bh=DvURKy7m9g2YY6qGN901lbEW9UUyxM36gV6aFVQswig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Is2bJycXJ3LKGDF2NIA1jhiDJUE26Q9tEaniIrsp17M4guHdNAZNcH5lv89azPq76UKB8Hbkhr79/ia/e4DArBE+fTRTm/i/PnnM4Nt6U0PbUdyYkmbvFwQqqfcWbidLkUHB2gVuZWW/h7fQBSGTIHTLMhkyLBuaGP7DqANqazk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=C1OXUsll; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so4243810b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164113; x=1706768913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sk+gUexiyKjcB+TRRECBjEsvOh5bXAF+ZpNuCmy1Ha0=;
        b=C1OXUsllUNUSGrM4xwcfRa/Ff4mbB7tUOf6/mhg6OdNiU4m9sORYiBdi2eIDH3Aoi4
         VLvyTGSR1oharIc2bHbrdNu/zrgRZgWibh47+Txz/DWswtSA0rRfkQwPPpMv8/M84U7E
         qzWJyJVs9GSoeyU5Nr2et7zjlWzwvybebgCbj4PES8YcJg016Xu2Bs1IXc7KayDilwN8
         dJUei5TV3+mcPiSXBPz1M84FRH1eys1cjQglwnspuf8kBfFE3Pb67j4BxEE6aGSQfLv2
         peKs1eFKL8+YMoixGeLmhUcBiGZNHe1rRNFWICAm/oOiRwK5H+EUzaF4sAz5Gg13sDEh
         Od3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164114; x=1706768914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sk+gUexiyKjcB+TRRECBjEsvOh5bXAF+ZpNuCmy1Ha0=;
        b=GC9a2ScEfuQL5nZZ2xG4kfJIGtzU7DhtpJ0TMGWn8OvBlOabbFhtnjFxXn7niv5+JX
         1JxS09peVai5628zV4stI9Wf5JcM5WvgmdP7MaBaoW0pGwgx8cmYiZLm9ZJlfZ/NgK1Y
         Ap6VLvCD8ErWJY7ac20B/0Nc4nCyYmQ0r50mg6QdkXKUbsJ8oIYF6L8YlI2W1OweJGlB
         Ray/BKQgbqCNhoNmMFYLJiCC4EEA5O2m76cAunAGW7wYX6ZTJT13ZbzyvxkpYA6LKzT2
         Sb7egY0rTmKoXVs2rROFyvjLqjwUI4p7X4nyuCkhEPaGzuWD+DMDUgWp/GD0pWSi0/CA
         XmwA==
X-Gm-Message-State: AOJu0YzbNM8ypoJH1zMWnfPR5GoBtkTCcXuQWQS7KYjVL+R001GAR4jB
	FlMexmI+2ytECU9iaFNJFshC5+9wsdDOPQht5yCLHvRKdFA0ySecW8xNTBmjajA=
X-Google-Smtp-Source: AGHT+IHgnfgiRGT+J+bbquDHQHlbWjWMk2ANkfaKEEr2r5iLWrd51iWjTqQbhay0o6iShLRyInjd9g==
X-Received: by 2002:a05:6808:e84:b0:3bd:54a2:7df3 with SMTP id k4-20020a0568080e8400b003bd54a27df3mr377689oil.14.1706164113684;
        Wed, 24 Jan 2024 22:28:33 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:28:33 -0800 (PST)
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
Subject: [RFC PATCH v1 04/28] riscv/Kconfig: enable HAVE_EXIT_THREAD for riscv
Date: Wed, 24 Jan 2024 22:21:29 -0800
Message-ID: <20240125062739.1339782-5-debug@rivosinc.com>
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

riscv will need an implementation for exit_thread to clean up shadow stack
when thread exits. If current thread had shadow stack enabled, shadow
stack is allocated by default for any new thread.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Kconfig          | 1 +
 arch/riscv/kernel/process.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 95a2a06acc6a..9d386e9edc45 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -142,6 +142,7 @@ config RISCV
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_EXIT_THREAD
 	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 2420123444c4..c249cf3d8083 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -192,6 +192,11 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	return 0;
 }
 
+void exit_thread(struct task_struct *tsk)
+{
+	return;
+}
+
 int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
-- 
2.43.0


