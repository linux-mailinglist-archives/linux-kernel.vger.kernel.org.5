Return-Path: <linux-kernel+bounces-38013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C2383B9B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580BDB24C09
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D517A11731;
	Thu, 25 Jan 2024 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MlBNrdFr"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D71171C9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164152; cv=none; b=j1x2sF+DN9FDfybUQsTr3LkvMsTfkd2Q4XFgtln6KNL4b3kTK9/ItaSvKcu/i6SVPcuVxNC1YQyQrh/2MKZAeU6rNyL+/v63x7hfiqDNoU3YGEVzYSgzFCm4cx1LYEQdTKBydRJBFPHt31YjLfI3qtgYdsOTf7gPBpqN61vWLjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164152; c=relaxed/simple;
	bh=YOP4K+DKiAnz0Jji3XIKk9AXAI7kwxzmy/xw9j2XMaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3awepzETPuXz5n0CDZTQG3+UN/RfM7duHobcexHqJen6WdRcl34cxpQ4qOI9/O+6g2SxSmE4aIgmSU3FoUkT/ObZyeTC/Tty20WTyv+jUGk+NSDt5XAEABQDgK6FKlDQgkHo00X1fSqMRMUsLB/CdRJhJmzJaopV6Ljc/7tWuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MlBNrdFr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6db9e52bbccso4043838b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164149; x=1706768949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqhJyw4qKw6ttxWAjpEt4kkwqgUPwpH+MlNDa4SEbVQ=;
        b=MlBNrdFr+fR3YH8tCDcoaZrtlQXY2vJ/kp93E6iPWe+2KHu2cw6AbUhU7ZxfTmkTkd
         ygtOZp9C9ROUq4wfplrV66IEj2MmW1wRuLCNEhKUvmqeOi6sOBlBgz9V8thCzMsqCHZe
         03wx8KwQwC/Wc+S0d/Sj/zMwq++jCO/yHFFSx8ywUIzgnUQxB2VlF+89d630ChOZgPme
         gAz0W+7Ma/Jqf+pqW3bmvezEh3TYLiTNc5smiCuvvZaIwFWsdjfDNJp4Ge7q83V2km0t
         FwyluvEBgzx3n9RSa3JgngAe1kUyWhtLMZeezz2bAIDIeQJ5b04m7yNdxR3EMpQV4Agu
         5VGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164149; x=1706768949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqhJyw4qKw6ttxWAjpEt4kkwqgUPwpH+MlNDa4SEbVQ=;
        b=IKCanJ/RvNxkdvP368XfwegKjkmz4AOEMrr5cJyrX1E0nWNue9aTiUY/ZBVVm6USry
         1+LQtXMYKUMYZlQ3DrnDW5Hf2pXDPzxR3zMv6Tj36AolvE1njJr81UL0VK6KWbaYtm0K
         4jz2qjNuJON8uA81KDot/d6ZAy8516h2lGkLtPrHZXK+6J1H/UYoCRkmdZFBgRtAdb8x
         1FW2+fTjauvSkLl1NLHZA16J1w5T+1s42Mx5hph7mFMaiTrnZ1P5PPX6bhoo4GtJvtT8
         IMNkqm9Ee9vqyfhZ2sMkEIvqbK454AZqDkkxv/PgjSNIzNFhdHPGhlxRAPVSLSjOBZoV
         xV/A==
X-Gm-Message-State: AOJu0YzPFBp41N6UWXcYQHa9kQ4RhK67yB8YviFsrndYzJjeq67Pa0Wk
	DYzwhN33ujR9wqmxW/WMncmZcm53MUWbp6zxGg9GBtFcLykv/+SxwH7xQCCJzIk=
X-Google-Smtp-Source: AGHT+IEl63VLMXT2mHqAciM7L/Xopf+jIyT34V6he9kHeUuUlxwxwREqJzJ6MMes7H6nQTQcNzI7AA==
X-Received: by 2002:a05:6a00:2194:b0:6dd:c69f:1e31 with SMTP id h20-20020a056a00219400b006ddc69f1e31mr202939pfi.51.1706164147768;
        Wed, 24 Jan 2024 22:29:07 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:29:07 -0800 (PST)
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
Subject: [RFC PATCH v1 08/28] mm: Define VM_SHADOW_STACK for RISC-V
Date: Wed, 24 Jan 2024 22:21:33 -0800
Message-ID: <20240125062739.1339782-9-debug@rivosinc.com>
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

VM_SHADOW_STACK is defined by x86 as vm flag to mark a shadow stack vma.

x86 uses VM_HIGH_ARCH_5 bit but that limits shadow stack vma to 64bit only.
arm64 follows same path
https://lore.kernel.org/lkml/20231009-arm64-gcs-v6-12-78e55deaa4dd@kernel.org/#r

On RISC-V, write-only page table encodings are shadow stack pages. This patch
re-defines VM_WRITE only to be VM_SHADOW_STACK.

Next set of patches will set guard rail that no other mm flow can set VM_WRITE
only in vma except when specifically creating shadow stack.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 418d26608ece..dfe0e8118669 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -352,7 +352,19 @@ extern unsigned int kobjsize(const void *objp);
  * for more details on the guard size.
  */
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_5
-#else
+#endif
+
+#ifdef CONFIG_RISCV_USER_CFI
+/*
+ * On RISC-V pte encodings for shadow stack is R=0, W=1, X=0 and thus RISCV
+ * choosing to use similar mechanism on vm_flags where VM_WRITE only means
+ * VM_SHADOW_STACK. RISCV as well doesn't support VM_SHADOW_STACK to be set
+ * with VM_SHARED.
+ */
+#define VM_SHADOW_STACK	VM_WRITE
+#endif
+
+#ifndef VM_SHADOW_STACK
 # define VM_SHADOW_STACK	VM_NONE
 #endif
 
-- 
2.43.0


