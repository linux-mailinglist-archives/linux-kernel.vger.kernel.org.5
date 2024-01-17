Return-Path: <linux-kernel+bounces-29536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883AF830FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAEE11C24411
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B393D28DB6;
	Wed, 17 Jan 2024 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vukh56S4"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C20322EFE;
	Wed, 17 Jan 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532841; cv=none; b=rdQIBAPwEBGdiL4gkbJWikBQYVSZPk7K2zih4tkqsR0OVN8euEwQ+53W0MTYKWj3zxX4twaUy6lgjLoXQHbaxMiTOH0ABt+3wJB0n3Ee57skMMnD5je2ItRN/8kE3Sr9bYMYhDyKWvUMRIZi6ITOcadef4Cvu+lHdRk7fXhNwWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532841; c=relaxed/simple;
	bh=qe4FjNte+EfV+SxIMOllnF2vE+IqSHEb4QBYlyFCKsw=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=QRQSm5IGhuuDI9iP5rFe1ldILdOXBdttVYNgysbjjwPpdWxCrMwhhQJ9IZrXc2j5e6h25ddkZgCgCX10ZXobR7smy2SRjZof5nKPEPGBh5oYSxcJ+tnqL74MFpPWW08stpZym6lwx1dQU6X20C9Jwr2fDgjuHi2RvsArc0mrKHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vukh56S4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ypndJ3q6jZFQH0yBwkGZzBndYEsmF1d2BBCzWXEQX3w=; b=vukh56S447fwfDPuha9YigmbqP
	xSj28FnXgN2ji/AhU5njJCQrHUZXD7c2czNhmxmWTBmgs0rUxN7j6I+8+weQYQHM8KloLlg1BRX/O
	OE+lfxPBfWTWB6sPHlfx1tH9ABKq5PYWkCxxEmrHjpEojMumot9bai3FYKkW7Wg9ozrfFGI49tnn4
	oyCbodzxiV6e66TB2CBkVYdEkkKFbReJavH3yrDrsS5Rwr/c5McMrwK+S/1JV0fPWSrIHt7ole8kV
	bTFg7BrOWIMMAXJSBUVl1PHvUhhPmXmctYj7VeToE+r+OfF86H3AuAgdWDX8laDmcGlzQ6mg45Ll8
	gLBz2VZA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQF0A-0011su-15;
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
Subject: [PATCH 02/10] KVM: arm64: guest: fix kernel-doc warnings
Date: Wed, 17 Jan 2024 15:07:06 -0800
Message-ID: <20240117230714.31025-3-rdunlap@infradead.org>
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

Fix multiple function parameter descriptions to prevent warnings:

guest.c:718: warning: Function parameter or struct member 'vcpu' not described in 'kvm_arm_num_regs'
guest.c:736: warning: Function parameter or struct member 'vcpu' not described in 'kvm_arm_copy_reg_indices'
guest.c:736: warning: Function parameter or struct member 'uindices' not described in 'kvm_arm_copy_reg_indices'
arch/arm64/kvm/guest.c:915: warning: Excess function parameter 'kvm' description in 'kvm_arch_vcpu_ioctl_set_guest_debug'
arch/arm64/kvm/guest.c:915: warning: Excess function parameter 'kvm_guest_debug' description in 'kvm_arch_vcpu_ioctl_set_guest_debug'

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
 arch/arm64/kvm/guest.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff -- a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -711,6 +711,7 @@ static int copy_sve_reg_indices(const st
 
 /**
  * kvm_arm_num_regs - how many registers do we present via KVM_GET_ONE_REG
+ * @vcpu: the vCPU pointer
  *
  * This is for all registers.
  */
@@ -729,6 +730,8 @@ unsigned long kvm_arm_num_regs(struct kv
 
 /**
  * kvm_arm_copy_reg_indices - get indices of all registers.
+ * @vcpu: the vCPU pointer
+ * @uindices: register list to copy
  *
  * We do core registers right here, then we append system regs.
  */
@@ -902,8 +905,8 @@ int kvm_arch_vcpu_ioctl_translate(struct
 
 /**
  * kvm_arch_vcpu_ioctl_set_guest_debug - set up guest debugging
- * @kvm:	pointer to the KVM struct
- * @kvm_guest_debug: the ioctl data buffer
+ * @vcpu: the vCPU pointer
+ * @dbg: the ioctl data buffer
  *
  * This sets up and enables the VM for guest debugging. Userspace
  * passes in a control flag to enable different debug types and

