Return-Path: <linux-kernel+bounces-143131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E648A34D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B71C1C2349A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFB814D456;
	Fri, 12 Apr 2024 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aW0iPIR1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD621E53A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943337; cv=none; b=VCyGeImpDsgMAOfve4JzFdx8ymvhLGp+749/+go4KMXkKeX+kjB2+5YN7ASTRJK5qg3PlgVJygvpmt3kfhmwbHaCbTO/1NxbjHHkpk1TxNRQ1Tqh+mIEsk1hLcbQBM2sHWpgbvyNFLx5n4QgsgQCHG5cP7NPcb+r7wXNklQbT9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943337; c=relaxed/simple;
	bh=aJFKNG8JFdsknm0cM70DGXhrFg8VJGGZkSPTRdlR2Gw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YE8pszwLtPcZOZKfchfb1bupcM27VoDF9iXqxmOoJP0pCf6UTSePCs0wZp7gaXPSRnLMiuc8wFv9hHXYSRX4ip6DIN9rtaLUfx1HYCok73CIg0c7qpnMth9+TLbqM8KlLZ8aStlswcK0ep8ACX3c99YCSQwcmdFmyTWeNMPBk34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aW0iPIR1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712943335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7F11F8b0j1hRRpTpVJdUgzEjbTqkJrpProdSq6OmwYM=;
	b=aW0iPIR1UflS8NXIilLoUncqAeFV0TN76GAUTIqpplQigOuMftiMQbqrYx+VGX+Ni7nFOJ
	ablkZEHGCYWxI6NGaW4/oWIkeTGxuQzqBdzc6XSXzkjJ5knYK0SfKZ6Pj6PRWjeV7cGq6M
	bEJ2YLRSB3PP5y2/+nK6NS3dwzpPtW4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-lzXLJ7bZMau5hyJugf41rg-1; Fri,
 12 Apr 2024 13:35:33 -0400
X-MC-Unique: lzXLJ7bZMau5hyJugf41rg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F5A61C4C39B;
	Fri, 12 Apr 2024 17:35:33 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EBA7B492BC7;
	Fri, 12 Apr 2024 17:35:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 00/10] KVM: MMU changes for confidential computing
Date: Fri, 12 Apr 2024 13:35:22 -0400
Message-ID: <20240412173532.3481264-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

This includes the MMU parts of "TDX/SNP part 1 of n"[1] while the rest
was posted as "KVM: guest_memfd: New hooks and functionality for SEV-SNP
and TDX"[2] last week.

It includes two basic parts:

- Allow non-zero value for non-present SPTE and removed SPTE, so that
  TDX can set the "suppress VE" bit

- Use PFERR_GUEST_ENC_MASK to indicate fault is private.

The changes from v1 are:

- splitting #VE architectural definitions to their own patch

- replace the module parameter to trap #VE with a Kconfig symbol,
  enabling it by default if PROVE_MMU || DEBUG_KERNEL.

- Sean's suggestion that "if we're going to bother plumbing in the error
  code, then we should use it to do sanity checks" on async page faults.

- removing the dead function kvm_mmu_set_mmio_spte_value(), which can
  be added by TDX patches when they need it

Paolo

[1] https://patchew.org/linux/20240227232100.478238-1-pbonzini@redhat.com/
[2] https://patchew.org/linux/20240404185034.3184582-1-pbonzini@redhat.com/

Isaku Yamahata (3):
  KVM: x86/mmu: Add Suppress VE bit to EPT
    shadow_mmio_mask/shadow_present_mask
  KVM: VMX: Introduce test mode related to EPT violation VE
  KVM: x86/mmu: Pass around full 64-bit error code for KVM page faults

Paolo Bonzini (3):
  KVM, x86: add architectural support code for #VE
  KVM: x86/mmu: Use PFERR_GUEST_ENC_MASK to indicate fault is private
  KVM: x86/mmu: check for invalid async page faults involving private
    memory

Sean Christopherson (4):
  KVM: Allow page-sized MMU caches to be initialized with custom 64-bit
    values
  KVM: x86/mmu: Replace hardcoded value 0 for the initial value for SPTE
  KVM: x86/mmu: Allow non-zero value for non-present SPTE and removed
    SPTE
  KVM: x86/mmu: Track shadow MMIO value on a per-VM basis

 arch/x86/include/asm/kvm_host.h |  5 +++
 arch/x86/include/asm/vmx.h      | 13 +++++++
 arch/x86/kvm/Kconfig            | 13 +++++++
 arch/x86/kvm/mmu/mmu.c          | 50 ++++++++++++++++---------
 arch/x86/kvm/mmu/mmu_internal.h |  6 +--
 arch/x86/kvm/mmu/mmutrace.h     |  2 +-
 arch/x86/kvm/mmu/paging_tmpl.h  |  4 +-
 arch/x86/kvm/mmu/spte.c         | 10 +++--
 arch/x86/kvm/mmu/spte.h         | 22 +++++++++--
 arch/x86/kvm/mmu/tdp_mmu.c      | 18 ++++-----
 arch/x86/kvm/vmx/vmcs.h         |  5 +++
 arch/x86/kvm/vmx/vmx.c          | 65 ++++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/vmx.h          |  6 ++-
 include/linux/kvm_types.h       |  1 +
 virt/kvm/kvm_main.c             | 16 +++++++-
 15 files changed, 193 insertions(+), 43 deletions(-)

-- 
2.43.0


