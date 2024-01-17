Return-Path: <linux-kernel+bounces-29540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484D4830FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0503428BF0D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351E02C6AB;
	Wed, 17 Jan 2024 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dweo1j75"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C2128694;
	Wed, 17 Jan 2024 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532842; cv=none; b=OLYR/S3UI1TCnld9PamillUyDDKa7P+wRp2hLNoyzYC0sppKv+Y5dN/MqQGlnCD/YO0KvRnR7zeVOKQYuZbid/QX7x4Llt66fXrD2u8DVHQ1JiKbDyXh5UfH3jEl5WmBWv9igjY55fDnlwxQBy6Hh+AJyaEEbqn1dZJvzsi+iDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532842; c=relaxed/simple;
	bh=bskHYMIoZ8Px7JZI6eA5NMkXx5ScjCITwfg7FUAEcBo=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=HeI3zShOMBgPhYYJcyQmMDfZgHKcfnAJBh12k5KGpoRnu1Zmz5xSOJU6Jworq6XAzbMU7dQ7LiTzKDTXh8FPADijmeSqowaVhci/zlovvwqAReFsNARNp8fz5QlgULFGdfKKOxnwlGFX4gSErGB9HE+jOABIDKwOWZ0d47w9mrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dweo1j75; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=iT44W7v/FtTigM/DN0Ec+D1xmeouh8V4OkR9aPPtQ1Q=; b=dweo1j75EEMJ4/8gKndu/Cjl68
	7+AwoVbFi0N6WulHFli8LlsqC2vLbjeGU6T1lf2dx51cIyJ0C8gVHKCgiz8ShpiH0T6lYdtoX5jyT
	1u2PndgOL/HBnp4xvDDlfQEJKM1tey/n3HSqOyIfwRCXgW2HFUqSp1JkJZIuTuFrnRXgsqZHA0LBK
	pRWQm6YPMa0Z+v2GUvl3HotindYPuh5Bg1IThp0/zckBYy7/k2YhnN20uYB8HYtpOrvEq+ZSAgDL1
	CvDqHOu+9mnU/rOKLkv7Ag07kjCjAnOaoWuchujMlQik2F1O6PBLcnK0wQvHo45z8u/von5umO1NG
	Wpv1hScg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQF0C-0011su-0Z;
	Wed, 17 Jan 2024 23:07:20 +0000
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
Subject: [PATCH 07/10] KVM: arm64: sys_regs: fix kernel-doc warnings
Date: Wed, 17 Jan 2024 15:07:11 -0800
Message-ID: <20240117230714.31025-8-rdunlap@infradead.org>
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

Drop the @run function parameter descriptions and add the actual ones
for 2 functions to prevent kernel-doc warnings:

arch/arm64/kvm/sys_regs.c:3167: warning: Excess function parameter 'run' description in 'kvm_handle_cp_64'
arch/arm64/kvm/sys_regs.c:3335: warning: Excess function parameter 'run' description in 'kvm_handle_cp_32'

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
 arch/arm64/kvm/sys_regs.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff -- a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3159,7 +3159,8 @@ static void unhandled_cp_access(struct k
 /**
  * kvm_handle_cp_64 -- handles a mrrc/mcrr trap on a guest CP14/CP15 access
  * @vcpu: The VCPU pointer
- * @run:  The kvm_run struct
+ * @global: &struct sys_reg_desc
+ * @nr_global: size of the @global array
  */
 static int kvm_handle_cp_64(struct kvm_vcpu *vcpu,
 			    const struct sys_reg_desc *global,
@@ -3326,7 +3327,9 @@ static int kvm_emulate_cp15_id_reg(struc
 /**
  * kvm_handle_cp_32 -- handles a mrc/mcr trap on a guest CP14/CP15 access
  * @vcpu: The VCPU pointer
- * @run:  The kvm_run struct
+ * @params: &struct sys_reg_params
+ * @global: &struct sys_reg_desc
+ * @nr_global: size of the @global array
  */
 static int kvm_handle_cp_32(struct kvm_vcpu *vcpu,
 			    struct sys_reg_params *params,

