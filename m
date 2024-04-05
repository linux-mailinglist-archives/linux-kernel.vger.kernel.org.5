Return-Path: <linux-kernel+bounces-132936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2FD899C30
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3964E28204D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A754416D303;
	Fri,  5 Apr 2024 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UF8NNnVz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B7016C6B1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712318308; cv=none; b=Ohpsr6HlbTts0Urc/McU9/ofjzQo023V4K2oHjr/AawSaTi0Vgj84oXWBZXlQMHvAowuOmsplzcxkxFlP+jFi63TnVvDfJzs88QgGWo/uB1gQqq5q9XwKpyyY+j+18J5z9yeywzC01pCCQ2UNu9C+VOTa7fI0hFrZCbycOq5GKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712318308; c=relaxed/simple;
	bh=2JWd/jbsS4JWnaAnGX+DxvfAkF7VrJqaJ4JcNlZZdG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ikceei6S60MkvGc/fXvLQEUCc4klqfKFUaykEhnr3spdev9YBGYWG4F1gVaG0kMFdJmqatfV+zUrAxB7ws9FxpcYbb7iM8uj/6sWsW0NS6WfMeOPjsjuMv+p9jM5NYh+wgCiQJXvV0DiH6a4XI7ogJGSNF49wKbu4j1E9R5iYeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UF8NNnVz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712318304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W+x0+CoZa6QVpu1rtgd+fH2pAb0xlu8sJLIuEb6A4kU=;
	b=UF8NNnVzDf/DQIBknZnHp0hw1idQ4fgvBp96CrPquMIa30b2eepda8I+08PWwzRVs8szYi
	0QHlBqr024GiHJWAOtBErRW+J2qPZ/hxlb95EA+FXJrK3mq/8UQt7lB17w70aRvBO+KIZu
	mDtXOC9US4jYuhC9Ax1VU0MYiCN8rA0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-LvYJznJmMXOAGq3bGEzUmg-1; Fri,
 05 Apr 2024 07:58:19 -0400
X-MC-Unique: LvYJznJmMXOAGq3bGEzUmg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 675AB1C05AF2;
	Fri,  5 Apr 2024 11:58:18 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 20CB240C6CB5;
	Fri,  5 Apr 2024 11:58:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Nicholas Piggin <npiggin@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 0/4] KVM, mm: remove the .change_pte() MMU notifier and set_pte_at_notify()
Date: Fri,  5 Apr 2024 07:58:11 -0400
Message-ID: <20240405115815.3226315-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

The .change_pte() MMU notifier callback was intended as an optimization
and for this reason it was initially called without a surrounding
mmu_notifier_invalidate_range_{start,end}() pair.  It was only ever
implemented by KVM (which was also the original user of MMU notifiers)
and the rules on when to call set_pte_at_notify() rather than set_pte_at()
have always been pretty obscure.

It may seem a miracle that it has never caused any hard to trigger
bugs, but there's a good reason for that: KVM's implementation has
been nonfunctional for a good part of its existence.  Already in
2012, commit 6bdb913f0a70 ("mm: wrap calls to set_pte_at_notify with
invalidate_range_start and invalidate_range_end", 2012-10-09) changed the
change_pte() callback to occur within an invalidate_range_start/end()
pair; and because KVM unmaps the sPTEs during .invalidate_range_start(),
change_pte() has no hope of finding a sPTE to change.

Therefore, all the code for .change_pte() can be removed from both KVM
and mm/, and set_pte_at_notify() can be replaced with just set_pte_at().

Please review!  Also feel free to take the KVM patches through the mm
tree, as I don't expect any conflicts.

Thanks,

Paolo

Paolo Bonzini (4):
  KVM: delete .change_pte MMU notifier callback
  KVM: remove unused argument of kvm_handle_hva_range()
  mmu_notifier: remove the .change_pte() callback
  mm: replace set_pte_at_notify() with just set_pte_at()

 arch/arm64/kvm/mmu.c                  | 34 -----------------
 arch/loongarch/include/asm/kvm_host.h |  1 -
 arch/loongarch/kvm/mmu.c              | 32 ----------------
 arch/mips/kvm/mmu.c                   | 30 ---------------
 arch/powerpc/include/asm/kvm_ppc.h    |  1 -
 arch/powerpc/kvm/book3s.c             |  5 ---
 arch/powerpc/kvm/book3s.h             |  1 -
 arch/powerpc/kvm/book3s_64_mmu_hv.c   | 12 ------
 arch/powerpc/kvm/book3s_hv.c          |  1 -
 arch/powerpc/kvm/book3s_pr.c          |  7 ----
 arch/powerpc/kvm/e500_mmu_host.c      |  6 ---
 arch/riscv/kvm/mmu.c                  | 20 ----------
 arch/x86/kvm/mmu/mmu.c                | 54 +--------------------------
 arch/x86/kvm/mmu/spte.c               | 16 --------
 arch/x86/kvm/mmu/spte.h               |  2 -
 arch/x86/kvm/mmu/tdp_mmu.c            | 46 -----------------------
 arch/x86/kvm/mmu/tdp_mmu.h            |  1 -
 include/linux/kvm_host.h              |  2 -
 include/linux/mmu_notifier.h          | 44 ----------------------
 include/trace/events/kvm.h            | 15 --------
 kernel/events/uprobes.c               |  5 +--
 mm/ksm.c                              |  4 +-
 mm/memory.c                           |  7 +---
 mm/migrate_device.c                   |  8 +---
 mm/mmu_notifier.c                     | 17 ---------
 virt/kvm/kvm_main.c                   | 50 +------------------------
 26 files changed, 10 insertions(+), 411 deletions(-)

-- 
2.43.0


