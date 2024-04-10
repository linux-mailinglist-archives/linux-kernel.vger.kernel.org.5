Return-Path: <linux-kernel+bounces-138934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8914B89FC34
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0BE1F20F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D17F177994;
	Wed, 10 Apr 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIjTxazW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397A7176FDE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764561; cv=none; b=SRcfchK2zr+Epx0veTEjouNnPhE4E2G8wNCT8RHjA7YaMd6YfkqbpY+6mfLK9EzLWw5AnhngUpnab27wTDZnfuARbdqJPulzSNI1CfNFAlLrv7khDpG7gh5bnOtuF8t3mNFuIoKm32dMvoHANH+hRW9gLYHvgaXDQQvUHq6RwnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764561; c=relaxed/simple;
	bh=okKMZ/9tRuUWppQYtJVWHhxQwTWDkYyCwTrJdB/uGXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C8J1gyv6X1GdE/DKSXlOThor7eRSIiwSljDps5zckLfb4r3tr6eKoaWuSkwkzmyItLT6SetbwM+nNlBUM/KJyiBnMw63EAalHESRhSnPdDSQ9ma4xDh6upCVAiwqrYWoRs/5tXc81GxgOCbhvYx9B+RlFKD8/KKKu4m/dXxh+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIjTxazW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712764559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qTFHY6y1jGhK/6ym0GXMEo1jpYItqd9R+ftkmiWTBig=;
	b=gIjTxazW5PtaAFAsdst3+SC0uMmQOYWmRE5kmfEhZ4PPMBaUiPiaAMFzNvoTRiQXxu4OR0
	PNi7+IEkhbkl0YAtJ8P99ncJgFFG4F5uwkcNXOd/FIpYTjb72WDe+veh/kgSQ8yKJ3J2mh
	ltiD49g+FXZ3O5XqDzvlg6Z1QrFoAcM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-MVfPyvlgPJyPMPCCNqtQrA-1; Wed, 10 Apr 2024 11:55:53 -0400
X-MC-Unique: MVfPyvlgPJyPMPCCNqtQrA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68709887D03;
	Wed, 10 Apr 2024 15:55:52 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.162])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E56572E5;
	Wed, 10 Apr 2024 15:55:48 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	x86@kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yonghua Huang <yonghua.huang@intel.com>,
	Fei Li <fei1.li@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 0/3] mm: follow_pte() improvements and acrn follow_pte() fixes
Date: Wed, 10 Apr 2024 17:55:24 +0200
Message-ID: <20240410155527.474777-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Patch #1 fixes a bunch of issues I spotted in the acrn driver. It compiles,
that's all I know. I'll appreciate some review and testing from acrn
folks.

Patch #2+#3 improve follow_pte(), passing a VMA instead of the MM, adding
more sanity checks, and improving the documentation. Gave it a quick
test on x86-64 using VM_PAT that ends up using follow_pte().

Not CCing all s390x and x86 maintainers (but lists), to reduce noise.

As this depends on other stuff in mm-unstable, this should likely go via
the MM tree.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yonghua Huang <yonghua.huang@intel.com>
Cc: Fei Li <fei1.li@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

David Hildenbrand (3):
  drivers/virt/acrn: fix PFNMAP PTE checks in acrn_vm_ram_map()
  mm: pass VMA instead of MM to follow_pte()
  mm: follow_pte() improvements

 arch/s390/pci/pci_mmio.c        |  4 +--
 arch/x86/mm/pat/memtype.c       |  5 +--
 drivers/vfio/vfio_iommu_type1.c |  4 +--
 drivers/virt/acrn/mm.c          | 62 ++++++++++++++++++++++++---------
 include/linux/mm.h              |  2 +-
 mm/memory.c                     | 35 ++++++++++++-------
 virt/kvm/kvm_main.c             |  4 +--
 7 files changed, 77 insertions(+), 39 deletions(-)

-- 
2.44.0


