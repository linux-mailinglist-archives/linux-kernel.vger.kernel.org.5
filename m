Return-Path: <linux-kernel+bounces-29543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D93830FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23E31F28AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6962C864;
	Wed, 17 Jan 2024 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N1jpdSJ7"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D454428DC0;
	Wed, 17 Jan 2024 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532843; cv=none; b=WkBKy1wDPk43lZ7XeQYxdg1WdH7CWjCZomjAhjXyoriuXGTqwHPcNTQcSszATDv2G/IozAv/HAQRvq+IlSNUf7sBCiiNR5E7il6WJXkjlQ0TqiWtuOb7v39R2wpZmDJmZ4nrtqo+8Rph3qZx+ZQOKShb/qwLZAPfOloto7ss9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532843; c=relaxed/simple;
	bh=DdymCnLkI27rGLQLx/CbSqqG9VBvyCiclIx2NAPLf98=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=UEvItUAPJdAFyBrsRuxVebjT6lBMp9XQtXmSIQ2h9B5ubBJM4VnJAPDVLJj0+9sFfVq6yxibSwStt6X5QRtlMjfOYDjzesDusp6PYfbABxZpSYlASnYgzu0KxLd1/EVNgR0nDFAHjYbpfc/5Ymc/Qtc+0XO1oRKu9KgjgJ3aXFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N1jpdSJ7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=l0w1dsym1D/QG/0mtlqKSd3j1TQngBvbzezDyJnZL68=; b=N1jpdSJ7XNunvOhxbX1M1L2rJ5
	5BkibONmiWR8b3469QCpJWp1VTg1C/4hJL9oYL5qrV8jaCJRvkp4gMbVmb8EfrB4oGsbOn7r2g/Ce
	sD6oPLKpJkTdyq/pmi+z6FedH5GNDjr952hWAmHX+XlY4cDcCDZoCl/mJ3wDGpsaUdc+OQU4TMbQM
	cKauxSRRKsPiHyb1a/DWfLFaVW+5smRb9ylQK6FJ2GE+qm1ec5hwBIAvS+wVxuO4Cyv+36+qMGusH
	gINFg2tPJ89ogG4wu8Oai/iIxDImrx/H9wvqpeWTYewYBomCyxsSvzw9S/lLpq/Zz05r2sTL+Hv3+
	xI+U/F+w==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQF0C-0011su-38;
	Wed, 17 Jan 2024 23:07:21 +0000
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
Subject: [PATCH 09/10] KVM: arm64: vgic-its: fix kernel-doc warnings
Date: Wed, 17 Jan 2024 15:07:13 -0800
Message-ID: <20240117230714.31025-10-rdunlap@infradead.org>
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

Correct the function parameter name "@save tables" -> "@save_tables".
Use the "typedef" keyword in the kernel-doc comment for a typedef.

These changes prevent kernel-doc warnings:

vgic/vgic-its.c:174: warning: Function parameter or struct member 'save_tables' not described in 'vgic_its_abi'
arch/arm64/kvm/vgic/vgic-its.c:2152: warning: expecting prototype for entry_fn_t(). Prototype was for int() instead

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
 arch/arm64/kvm/vgic/vgic-its.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -158,7 +158,7 @@ struct vgic_translation_cache_entry {
  * @cte_esz: collection table entry size
  * @dte_esz: device table entry size
  * @ite_esz: interrupt translation table entry size
- * @save tables: save the ITS tables into guest RAM
+ * @save_tables: save the ITS tables into guest RAM
  * @restore_tables: restore the ITS internal structs from tables
  *  stored in guest RAM
  * @commit: initialize the registers which expose the ABI settings,
@@ -2139,7 +2139,7 @@ static u32 compute_next_eventid_offset(s
 }
 
 /**
- * entry_fn_t - Callback called on a table entry restore path
+ * typedef entry_fn_t - Callback called on a table entry restore path
  * @its: its handle
  * @id: id of the entry
  * @entry: pointer to the entry

