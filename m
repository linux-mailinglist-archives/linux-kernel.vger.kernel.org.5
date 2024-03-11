Return-Path: <linux-kernel+bounces-99268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88F38785B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E0D1C21FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A36356B9B;
	Mon, 11 Mar 2024 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="ARTcAiqf"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2755676F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175617; cv=none; b=rDWISzrQCfC4aUZVUbwaN1Hb62LfmW8HGTGsWo8Z9csNbszwWXyxp8t4+dxnMew4ovd6GZtuslEwxnoFqnKx7TKmjW4sCG/T+HRaHMUw2Ts1NezjX1p7YsoNFPpKqKiMcc+PrnzFYHS6+NS2VJJtFBY85d+ugLmAjKWEBT2lejc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175617; c=relaxed/simple;
	bh=SjdSy7wze8iqdobtOSWXvuZy+HC33whE98lynSJVzCI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omZfznI2ehvlr+NcxDdul+hwJdYhPNqNKk3sq31YJLa2+lSMt90P+Q1trfP5wQgwcuyWoBnXqyKOEOVIlqEOgon3uithKunnXRR9SxKUQRCVCT2frTdUwpu8ZmKoFoB8eqSWhUnwydRMl/hmPlhZbAHWzHA66l7dJmvrRn57kEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=ARTcAiqf; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-783045e88a6so277630385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710175614; x=1710780414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NGLgnjdxSReHw9wlD+FW1YibHNtCAjZjXR36RT3BbYQ=;
        b=ARTcAiqfV/nHTM50ECHtkfKwZoR4w7P0StEgR2k4YbupLc+QL+Qvhr06tCGrCwkljM
         9eNKpMpIbW860mYyIsyVagCnvWZBKDrKEik72y6JrjNvATLdwr+r/Mpv9TB6NCRh9UVC
         52KypElvcNowwDatOwJboNtQ9aXFLKJNcLsaowiP2m/0+CkesFqxbFhK69sLSwU+lsKd
         mbl/y923RY5IMwAi07Jq0wDjnPWGk9h+WaLov6ZlmbuJmNiUbCmwD4LvoKywV1S42IK8
         MADIv/W1v9ppHBrzqP9SXBFCdy3r35mG2g82lQbMVQ/eRDSMv7QrxHtJYjGqiakwv5PA
         nncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175614; x=1710780414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGLgnjdxSReHw9wlD+FW1YibHNtCAjZjXR36RT3BbYQ=;
        b=rZC6YWFU1xAA7u6x/Z8Yvjt08zPejEd+iPyZfIIpBC39TXfiKld4gAGVBRUMzB6Z1B
         Y6l+GkHmqyd/5P985lvRWMXYnibe2AoqqzHyDPDlX3A4yk2e95ICW1wZAWmduaxXyuRE
         iLzIrm1c6ILYzBWAnU0NezoJQc/SWulyY5C1JlWHiF88NivwFLovrJrJdC7cAIckig1X
         88GjElYIx/CFMugss+Gnb4KGD4YPvpb3PMU6qi5cl+CR/vVnrnII3fuaWHHCrcQtx/zO
         CRdRNJweCasoH1HEwza8sVteDQad65WV/yU/jn+jqoalflpH0R1VyCGZkBF3Wq9sV4cC
         nmpA==
X-Gm-Message-State: AOJu0Yx8T1mtYaVWH6VHyAUXyg1UU9/J2I8qwI1JhafM5fOtx2RjWyML
	T98BlaMXBiel1puENP7iOYGYcAGNyA3B17kT3UuKtNxEUxpKfBcToget9KrQujYNioiE3cUAvIe
	i8H0=
X-Google-Smtp-Source: AGHT+IHiFimL/uL6CiZ0/ffUHb5GjnvMvZQk5uciXsXYpJX5LXGSw9tTbmvr67JCBeLYBzWo/uqLsw==
X-Received: by 2002:a05:620a:45a1:b0:788:4e44:a9b7 with SMTP id bp33-20020a05620a45a100b007884e44a9b7mr11466669qkb.78.1710175614423;
        Mon, 11 Mar 2024 09:46:54 -0700 (PDT)
Received: from soleen.c.googlers.com.com (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a137b00b00788228fbe05sm2851589qkl.17.2024.03.11.09.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:46:54 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	x86@kernel.org,
	bp@alien8.de,
	brauner@kernel.org,
	bristot@redhat.com,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	dianders@chromium.org,
	dietmar.eggemann@arm.com,
	eric.devolder@oracle.com,
	hca@linux.ibm.com,
	hch@infradead.org,
	hpa@zytor.com,
	jacob.jun.pan@linux.intel.com,
	jgg@ziepe.ca,
	jpoimboe@kernel.org,
	jroedel@suse.de,
	juri.lelli@redhat.com,
	kent.overstreet@linux.dev,
	kinseyho@google.com,
	kirill.shutemov@linux.intel.com,
	lstoakes@gmail.com,
	luto@kernel.org,
	mgorman@suse.de,
	mic@digikod.net,
	michael.christie@oracle.com,
	mingo@redhat.com,
	mjguzik@gmail.com,
	mst@redhat.com,
	npiggin@gmail.com,
	peterz@infradead.org,
	pmladek@suse.com,
	rick.p.edgecombe@intel.com,
	rostedt@goodmis.org,
	surenb@google.com,
	tglx@linutronix.de,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	pasha.tatashin@soleen.com
Subject: [RFC 11/14] x86: add support for Dynamic Kernel Stacks
Date: Mon, 11 Mar 2024 16:46:35 +0000
Message-ID: <20240311164638.2015063-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
In-Reply-To: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dynamic_stack_fault() calls to the kernel faults, and also declare
HAVE_ARCH_DYNAMIC_STACK = y, so that dynamic kernel stacks can be
enabled on x86 architecture.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/Kconfig        | 1 +
 arch/x86/kernel/traps.c | 3 +++
 arch/x86/mm/fault.c     | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5edec175b9bf..9bb0da3110fa 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -197,6 +197,7 @@ config X86
 	select HAVE_ARCH_USERFAULTFD_WP         if X86_64 && USERFAULTFD
 	select HAVE_ARCH_USERFAULTFD_MINOR	if X86_64 && USERFAULTFD
 	select HAVE_ARCH_VMAP_STACK		if X86_64
+	select HAVE_ARCH_DYNAMIC_STACK		if X86_64
 	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_WITHIN_STACK_FRAMES
 	select HAVE_ASM_MODVERSIONS
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c3b2f863acf0..cc05401e729f 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -413,6 +413,9 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 	}
 #endif
 
+	if (dynamic_stack_fault(current, address))
+		return;
+
 	irqentry_nmi_enter(regs);
 	instrumentation_begin();
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index d6375b3c633b..651c558b10eb 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1198,6 +1198,9 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 	if (is_f00f_bug(regs, hw_error_code, address))
 		return;
 
+	if (dynamic_stack_fault(current, address))
+		return;
+
 	/* Was the fault spurious, caused by lazy TLB invalidation? */
 	if (spurious_kernel_fault(hw_error_code, address))
 		return;
-- 
2.44.0.278.ge034bb2e1d-goog


