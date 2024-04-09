Return-Path: <linux-kernel+bounces-136275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDEE89D229
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B393A1F23B26
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3117D3EC;
	Tue,  9 Apr 2024 06:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rTcw5ook"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AD96FE35
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643131; cv=none; b=g9TiZrpoBUKtAiEI7NI6NQAr+UQ3ytsjX/jeTu9emzKQCWFfG0crLyTo7VU4JxymxOdEZsjUOvNT6HXJyjDwMnrtH5cMmdRNfFZJSBvYvbJ1S3ULFD+ItfJdcJwFMZ5Ks8swZABtQ3jzBxnThzqMVGxuhflvOEjAJFkOChW4Yz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643131; c=relaxed/simple;
	bh=VqVo0bzh6XJftKAe8XsJ+Ul+IauZxO02HTjKRZ5kZE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t1+hFLJcV33LFh1IxUrViP7uoWwNzycyc7SoB9WakAQ1V00jMyMcK9emA1aLV9IxSCbSXJCMpQzyEPlMyFVdqEFSQ/Uhl7SlK7QxCD2sKv2rFrVEZJi+g3yVujpojvYn335K0SmD6hdu7fLTPI8n4QUvHmhZHVVRHDATsefJ704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rTcw5ook; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e220e40998so32728915ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 23:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712643129; x=1713247929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vK6fRyMYl1P58cmeO0LU6+3feTaUZnDC3wku/DDJlMg=;
        b=rTcw5ook+3U4ts/9UAM8TkYaP0aRMEX5mRp33rhaboYXM3nbp8KeXa17yDpljNgsIo
         OXGp2GuHAF3ilgvY7WHuN35kqXmpTqsy0cft1mnSD6wmvb7Vcryo3z0XPs7TPbMO45s/
         fK5/hL9pO63EifTwZnHsrpoogplFghwKgO5kH6p6SWkeb7Bt1xy1hob2JTNpuAk08zVP
         niL2iq3V+xlmbyhfNxhBFDiJaBuHkSExARdThAtLBvFOMBj/KDyKaapnL8TznluVcdj3
         miEsWWq+0rZrLjrNo7WdI5gWDoONI0A0HSgoIllMUZrin58tcpT3VDfgobkJMr2Ojg8v
         t2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643129; x=1713247929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vK6fRyMYl1P58cmeO0LU6+3feTaUZnDC3wku/DDJlMg=;
        b=VeEzXEP4xKJVin0vdT49sUVzTrFaR9HQDgBYTcgM5/XkGKGmV0VD/C2BB71ZhNnPrw
         6DEqIU58WMSAOKVTyadrp8v1ckMZB7TTZRyD0+Iz5WCT5hq2pNAPNrlTbhvIzWTe04uv
         kJ2LFLVcg39ioGpC2WjOIjLWvRS7J3jlEjDwcgwMGdRBJRmpC3PardvN1FZ88pYPGeo8
         t6kqjZPLX/W3nIB+vyRonuy1ZUmUhzmffz+7hN5adwp9exH51hBRX2A6jizY541qx/C4
         tTE1r+vWs1knGmu/FvPjCGr48qtDku6KN+OQfzGeCf+ZujQhUAYaJbM/4+3w/oEbx16S
         y/Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXXTTO51jTDDT9EgvG0G25s9v55Pe/GgP2Mi+mtxqWUZhDzInbsesgtQU48AqlvTMdfNxiBLm8UAi0E0qXFwZraLq4mDUBzOj6lnGeM
X-Gm-Message-State: AOJu0Yz96VVSJYS7gbpmIjLHuqqbrxjka2MlvhIYLF8quWRKsZSyjWoL
	PQDGL0Xrtc4Veif+bY1u67kL2bdyZMy4CJQA1x5m0aTdOdftqhPIQ8cwBE7P4Eg=
X-Google-Smtp-Source: AGHT+IHgZW6LjlIuQt5UvFz+14tJ+M4rswVyzT+uN214hG5uWWodDhWYY3GIvVhaCwgATxAIZVKVqw==
X-Received: by 2002:a17:902:c407:b0:1e2:96d3:1bc1 with SMTP id k7-20020a170902c40700b001e296d31bc1mr13068819plk.1.1712643129552;
        Mon, 08 Apr 2024 23:12:09 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001e3dd5972ccsm5775564plf.185.2024.04.08.23.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 23:12:09 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	andy.chiu@sifive.com,
	debug@rivosinc.com,
	hankuan.chen@sifive.com,
	guoren@kernel.org,
	greentime.hu@sifive.com,
	samitolvanen@google.com,
	cleger@rivosinc.com,
	apatel@ventanamicro.com,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	waylingii@gmail.com,
	sameo@rivosinc.com,
	alexghiti@rivosinc.com,
	akpm@linux-foundation.org,
	shikemeng@huaweicloud.com,
	rppt@kernel.org,
	charlie@rivosinc.com,
	xiao.w.wang@intel.com,
	willy@infradead.org,
	jszhang@kernel.org,
	leobras@redhat.com,
	songshuaishuai@tinylab.org,
	haxel@fzi.de,
	samuel.holland@sifive.com,
	namcaov@gmail.com,
	bjorn@rivosinc.com,
	cuiyunhui@bytedance.com,
	wangkefeng.wang@huawei.com,
	falcon@tinylab.org,
	viro@zeniv.linux.org.uk,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	hca@linux.ibm.com,
	arnd@arndb.de,
	kent.overstreet@linux.dev,
	boqun.feng@gmail.com,
	oleg@redhat.com,
	paulmck@kernel.org,
	broonie@kernel.org,
	rick.p.edgecombe@intel.com
Subject: [RFC PATCH 06/12] scs: place init shadow stack in .shadowstack section
Date: Mon,  8 Apr 2024 23:10:37 -0700
Message-Id: <20240409061043.3269676-7-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409061043.3269676-1-debug@rivosinc.com>
References: <20240409061043.3269676-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If compiled for riscv and dynamic scs is turned on, place shadow stack in
`.shadowstack` section. Arch specific linker script can place logic to
protect this section against regular stores.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/init_task.h |  5 +++++
 init/init_task.c          | 12 ++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index bccb3f1f6262..f025022e1164 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -40,4 +40,9 @@ extern struct cred init_cred;
 /* Attach to the thread_info data structure for proper alignment */
 #define __init_thread_info __section(".data..init_thread_info")
 
+#if defined(CONFIG_RISCV) && defined(CONFIG_DYNAMIC_SCS)
+/* init shadow stack page */
+#define __init_shadow_stack __section(".shadowstack..init")
+#endif
+
 #endif
diff --git a/init/init_task.c b/init/init_task.c
index 4daee6d761c8..3c0a01455978 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -52,10 +52,18 @@ static struct sighand_struct init_sighand = {
 };
 
 #ifdef CONFIG_SHADOW_CALL_STACK
-unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)] = {
+unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)]
+#if defined(CONFIG_RISCV) && defined(CONFIG_DYNAMIC_SCS)
+	/* RISC-V dynamic SCS implements shadow stack and must go in special section */
+	__init_shadow_stack = {
+	[0] = SCS_END_MAGIC
+};
+#else
+	= {
 	[(SCS_SIZE / sizeof(long)) - 1] = SCS_END_MAGIC
 };
-#endif
+#endif /* CONFIG_RISCV && CONFIG_DYNAMIC_SCS */
+#endif /* CONFIG_SHADOW_CALL_STACK */
 
 /*
  * Set up the first task table, touch at your own risk!. Base=0,
-- 
2.43.2


