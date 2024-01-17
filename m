Return-Path: <linux-kernel+bounces-29534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4697830FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E811F25D36
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8B428699;
	Wed, 17 Jan 2024 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cmnv6kko"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9956224C2;
	Wed, 17 Jan 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532840; cv=none; b=NigVH1nI1ysDZI7njiK9OPhcQtNOuEAhZduqoOyXN0GfnB8pszjSLPOEnNU6bChIX4IoIMgPahRFwYEZMDUI9td+SpHw2jNU7LdxN3cUoF4R4YILTAcSoNUwSrugoJa1zbUQE1K8yrvT5+oGXo1Q3TWHKugf7s9goFKOiprTPmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532840; c=relaxed/simple;
	bh=AxL2pBXazAzg//MRXlYnFJ53tGOVmTSBSNMjNVOlrTQ=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=GXdL1HAoH54cFJwrJgYU8758c+ExduJIiWjcjGQ6MWzB9KAlfsrUz1i7kAlEHSN0s2ndt0fZXa4S1j0Lpm5jlDnPlAfC4bxJECQ9PgBZZpALJ/lUiPlM/PjezMuvZiGeLKyypSDLf74D0e2/O7y90fq/DvkBI8Xm1aiErLSUGzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cmnv6kko; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=33pXiC615tAp01UX0oIvnU0m5UyE9DId90eSm2AOiDA=; b=Cmnv6kko4O6H4EJIhtFSqIpoQp
	hhIHa5nLJ04S5KtXMPDlgR2LRpGkaqeRAtoN8iiTsqcAwuv6QsHOS9S3b19eZwO9bxF6Cuc5k4Z2z
	eeDXeeoaZ5cOj+bJSk32R01arFIetSHojqNyIKi8YA7Q4MPEyGpT4PxiTKkY7WQNDUceL2D+vizAx
	SYTAllYONNHpFNToNSpWPhDu3O7FX00ZwnA6UikLt66+Xes+jxooifGSV0lwvEHKbdlLMYx84oVbC
	9w2UaJ+++NK0WrPCcAI6R5TuIcc/u2doq3w13LM4YR2tsx2PVpEnZIJFrAvq2zXDqSSrOaxXL1nUE
	TWj7KjRw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQF09-0011su-32;
	Wed, 17 Jan 2024 23:07:18 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 01/10] KVM: arm64: debug: fix kernel-doc warnings
Date: Wed, 17 Jan 2024 15:07:05 -0800
Message-ID: <20240117230714.31025-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117230714.31025-1-rdunlap@infradead.org>
References: <20240117230714.31025-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change one "/**" comment to a common "/*" comment since the comment
is not in kernel-doc format.
Add description for the @vcpu function parameter.

These changes prevent warnings:

debug.c:27: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * save/restore_guest_debug_regs
debug.c:27: warning: missing initial short description on line:
 * save/restore_guest_debug_regs
debug.c:149: warning: Function parameter or struct member 'vcpu' not described in 'kvm_arm_reset_debug_ptr'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Zenghui Yu <yuzenghui@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/debug.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -23,7 +23,7 @@
 
 static DEFINE_PER_CPU(u64, mdcr_el2);
 
-/**
+/*
  * save/restore_guest_debug_regs
  *
  * For some debug operations we need to tweak some guest registers. As
@@ -143,6 +143,7 @@ void kvm_arm_vcpu_init_debug(struct kvm_
 
 /**
  * kvm_arm_reset_debug_ptr - reset the debug ptr to point to the vcpu state
+ * @vcpu:	the vcpu pointer
  */
 
 void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu)

