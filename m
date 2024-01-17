Return-Path: <linux-kernel+bounces-29541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD690830FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A46428BF0B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EB02C6B0;
	Wed, 17 Jan 2024 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WnGLn10S"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E08222F16;
	Wed, 17 Jan 2024 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532842; cv=none; b=DtyTJDJiohYqjhUvYR8yMMvt+JHiu9Z/M8Z3UrWRbCA8p6fWJRCBJch17KgIxKDnvsx3wI6WNsMjLdLXlpLNV3p85GvfWHxF7YCaoOv6OF8e3UbGSlVIUHyhABFKYbihiySEgaGRUupDoxeiPzqL5qv7czGW6Ln/mHBQL6c0+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532842; c=relaxed/simple;
	bh=aeEiGwIx8qsK2ZA3R5/Sp9ad7VIHQstjCj1Q1oj46ws=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=B4Q1bVXh5MJ+1lRVdy2L6kPi4GuWqy1QgTWSaiJ8KE5WsaMDglYmqGNKXIRgSiVFcHwaANrNvCR+d7vvQro8CDWXO6VKqyhJRAWOLOnqIEBD1zD94MWG/4x1hVltwWGSg/KWjb4FQDHAFzl27PQpNgFKu1pDjwM6yB5kBtZVS64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WnGLn10S; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OkMmSUUzqla7nDqkHEtROz1zMAm2J8YGPaDlVU8GXs0=; b=WnGLn10SkFXQy4WxXtZftFWBvb
	iIPZ7CI0D/9n6whLhQ3NKJ0z9XsPngXKyZM6CEsFnuoz2MuakwUTTgI/5q7zZcZ8WzOHkcncE3Yz6
	BU+e8Hh7AP+GHsNfsl+KC+tqOmaWWyvxrH0DC3jIMhSnIxJIjJKDqVqCV24C5W6YW4NlpfjW/2mht
	h6/gEFkv96JF5TI673TW/tda4me7yey+3M+kznIC+uWeLmN36LnDxWlsRgxyHYpuedJ1zjt0+jCz8
	ELArJDl20U2teOO6xKvMfGn/8lQGF7zDgilUTgIpYC/svoxQOk8aDoMdTw48gEFqGiZDurglEqlRv
	azcWBpuA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQF0A-0011su-2T;
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
Subject: [PATCH 03/10] KVM: arm64: hyp/aarch32: fix kernel-doc warnings
Date: Wed, 17 Jan 2024 15:07:07 -0800
Message-ID: <20240117230714.31025-4-rdunlap@infradead.org>
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

Use the correct function name in the kernel-doc comments to prevent
kernel-doc warnings:

arch/arm64/kvm/hyp/vhe/../aarch32.c:97: warning: expecting prototype for adjust_itstate(). Prototype was for kvm_adjust_itstate() instead
arch/arm64/kvm/hyp/vhe/../aarch32.c:127: warning: expecting prototype for kvm_skip_instr(). Prototype was for kvm_skip_instr32() instead

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
 arch/arm64/kvm/hyp/aarch32.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/arch/arm64/kvm/hyp/aarch32.c b/arch/arm64/kvm/hyp/aarch32.c
--- a/arch/arm64/kvm/hyp/aarch32.c
+++ b/arch/arm64/kvm/hyp/aarch32.c
@@ -84,7 +84,7 @@ bool kvm_condition_valid32(const struct
 }
 
 /**
- * adjust_itstate - adjust ITSTATE when emulating instructions in IT-block
+ * kvm_adjust_itstate - adjust ITSTATE when emulating instructions in IT-block
  * @vcpu:	The VCPU pointer
  *
  * When exceptions occur while instructions are executed in Thumb IF-THEN
@@ -120,7 +120,7 @@ static void kvm_adjust_itstate(struct kv
 }
 
 /**
- * kvm_skip_instr - skip a trapped instruction and proceed to the next
+ * kvm_skip_instr32 - skip a trapped instruction and proceed to the next
  * @vcpu: The vcpu pointer
  */
 void kvm_skip_instr32(struct kvm_vcpu *vcpu)

