Return-Path: <linux-kernel+bounces-24325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7626282BB0E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A478289C48
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AB75B5DC;
	Fri, 12 Jan 2024 05:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2xd4yOeq"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14FFF4F7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d9a541b720aso8455481276.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705038777; x=1705643577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Eek3/p9ES41h8PWH5gBdbupDvFtsA2EdHaKQWrImp7c=;
        b=2xd4yOeqR8nrOBg2mRW0V4ccmhgvtNUDIcM5DaiSnYuKTO/pCaavxsLNxVbc2AE9iY
         0Mvne0jlQkMPY/MGt/L+24HpzFAuUQxh0T7QSfeHO4zmpNNI7IhL9ardMSkXmpknHRRM
         EPDg+RO3w7t38C2Mi5Wjq62H+IeRgPFYupbN/JgIgrhW97mDzlqqRI6Fa6xczzHD02a5
         pfRmQjWyuXT3IWcA5a8RFFO+3iQrVnTognUwPBW+2x9KSUGn/TMjJ51DvckYmhmdbTd3
         lk1RvAPD6zw3yuKfhdyn1MyqE3AUI8RhuB9GcfS+LEwDuh3Gm4GgFILVp51Y5HyZnXPT
         V/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705038777; x=1705643577;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eek3/p9ES41h8PWH5gBdbupDvFtsA2EdHaKQWrImp7c=;
        b=oPRij60/3JpndkooiiiCbR/koae9ODZZ15uKCBXXY9X+oxQqrI2p5v7aGcnAeG0eeY
         XKeSdTvSzvtr2i/B8Ne3fSDKSxApJsX1JeItz/gdK5WrEcmi74xwMpCLfe8ErgSkSrTv
         YSzsogB+ovkVoYmOB/+iHZVXt6xJOZkqF7s7AY3gvkvgbXAxpd0kUx2eiGvLF5cId1L+
         BTchjfxCS/W8krBnQ4cEyw0p0dMi5oAH1WAd+cjHZoSG/13nviEaHOuZVxVqzMWgiLAX
         Jqt525Va980D8RtUXQKzLqH2eV3glw9MjVaWlT6E3w1QKUHq8sW3Et07cYtLxJX5oGgI
         sUEA==
X-Gm-Message-State: AOJu0YyP0MGM/U33a8JvOuWv19A15wt5crgMC8CeoP2sPso1H5u1ZV+b
	/SNqStROeUY8Bx+xyhgvhvegGgPtHkRbVTbzOdQvjso=
X-Google-Smtp-Source: AGHT+IHwTOdClhtUPbfkNLCqsrkV+DUCP10t3cc3JC0hHLwhlQAS7BqfEhb+YkVABN3l+xlef5DkGsoXndaAdE3b
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:43a4])
 (user=vannapurve job=sendgmr) by 2002:a05:6902:e88:b0:dbd:ea33:cc2 with SMTP
 id dg8-20020a0569020e8800b00dbdea330cc2mr138415ybb.12.1705038776754; Thu, 11
 Jan 2024 21:52:56 -0800 (PST)
Date: Fri, 12 Jan 2024 05:52:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240112055251.36101-1-vannapurve@google.com>
Subject: [RFC V1 0/5] x86: CVMs: Align memory conversions to 2M granularity
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, rientjes@google.com, bgardon@google.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, 
	jxgao@google.com, sagis@google.com, oupton@google.com, peterx@redhat.com, 
	vkuznets@redhat.com, dmatlack@google.com, pgonda@google.com, 
	michael.roth@amd.com, kirill@shutemov.name, thomas.lendacky@amd.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, andrew.jones@linux.dev, 
	corbet@lwn.net, hch@lst.de, m.szyprowski@samsung.com, bp@suse.de, 
	rostedt@goodmis.org, iommu@lists.linux.dev, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

Goal of this series is aligning memory conversion requests from CVMs to
huge page sizes to allow better host side management of guest memory and
optimized page table walks.

This patch series is partially tested and needs more work, I am seeking
feedback from wider community before making further progress.

Background
=====================
Confidential VMs(CVMs) support two types of guest memory ranges:
1) Private Memory: Intended to be consumed/modified only by the CVM.
2) Shared Memory: visible to both guest/host components, used for
non-trusted IO.

Guest memfd [1] support is set to be merged upstream to handle guest private
memory isolation from host usersapace. Guest memfd approach allows following
setup:
* private memory backed using the guest memfd file which is not accessible
  from host userspace.
* Shared memory backed by tmpfs/hugetlbfs files that are accessible from
  host userspace.

Userspace VMM needs to register two backing stores for all of the guest
memory ranges:
* HVA for shared memory
* Guest memfd ranges for private memory

KVM keeps track of shared/private guest memory ranges that can be updated at
runtime using IOCTLs. This allows KVM to back the guest memory using either HVA
(shared) or guest memfd file offsets (private) based on the attributes of the
guest memory ranges.

In this setup, there is possibility of "double allocation" i.e. scenarios where
both shared and private memory backing stores mapped to the same guest memory
ranges have memory allocated.

Guest issues an hypercall to convert the memory types which is forwarded by KVM
to the host userspace.
Userspace VMM is supposed to handle conversion as follows:
1) Private to shared conversion:
  * Update guest memory attributes for the range to be shared using KVM
    supported IOCTLs.
    - While handling this IOCTL, KVM will unmap EPT/NPT entries corresponding
      to the guest memory being converted.
  * Unback the guest memfd range.
2) Shared to private conversion:
  * Update guest memory attributes for the range to be private using KVM
    supported IOCTLs.
    - While handling this IOCTL, KVM will unmap EPT/NPT entries corresponding
      to the guest memory being converted.
  * Unback the shared memory file.

Note that unbacking needs to be done for both kinds of conversions in order to
avoid double allocation.

Problem
=====================
CVMs can convert memory between these two types at 4K granularity. Conversion
done at 4K granularity causes issues when using guest memfd support
with hugetlb/Hugepage backed guest private memory:
1) Hugetlb fs doesn't allow freeing subpage ranges when punching holes,
causing all the private to shared memory conversions to result in double
allocation.
2) Even if a new fs is implemented for guest memfd that allows splitting
hugepages, punching holes at 4K will cause:
   - loss of vmemmmap optimization [2]
   - more memory for EPT/NPT entries and extra pagetable walks for guest
     side accesses.
   - Shared memory mappings to consume more host pagetable entries and
     extra pagetalble walks for host side access.
   - Higher number of conversions with additional overhead of VM exits
     serviced by host userspace.

Memory conversion scenarios in the guest that are of major concern:
- SWIOTLB area conversion early during boot.
   * dma_map_* API invocations for CVMs result in using bounce buffers
     from SWIOTLB region which is already marked as shared.
- Device drivers allocating memory using dma_alloc_* APIs at runtime
  that bypass SWIOTLB.

Proposal
=====================
To counter above issues, this series proposes following:
1) Use boot time allocated SWIOTLB pools for all DMA memory allocated
using dma_alloc_* APIs.
2) Increase memory allocated at boot for SWIOTLB from 6% to 8% for CVMs.
3) Enable dynamic SWIOTLB [4] by default for CVMs so that SWITLB can be
scaled up as needed.
4) Ensure SWIOTLB pool is 2MB aligned so that all the conversions happen at
2M granularity once during boot.
5) Add a check to ensure all conversions happen at 2M granularity.

** This series leaves out some of the conversion sites which might not
be 2M aligned but should be easy to fix once the approach is finalized. **

1G alignment for conversion:
* Using 1G alignment may cause over-allocated SWIOTLB buffers but might
  be acceptable for CVMs depending on more considerations.
* It might be challenging to use 1G aligned conversion in OVMF. 2M
  alignment should be achievable with OVMF changes [3].

Alternatives could be:
1) Separate hugepage aligned DMA pools setup by individual device drivers in
case of CVMs.

[1] https://lore.kernel.org/linux-mips/20231105163040.14904-1-pbonzini@redhat.com/
[2] https://www.kernel.org/doc/html/next/mm/vmemmap_dedup.html
[3] https://github.com/tianocore/edk2/pull/3784
[4] https://lore.kernel.org/lkml/20230908080031.GA7848@lst.de/T/

Vishal Annapurve (5):
  swiotlb: Support allocating DMA memory from SWIOTLB
  swiotlb: Allow setting up default alignment of SWIOTLB region
  x86: CVMs: Enable dynamic swiotlb by default for CVMs
  x86: CVMs: Allow allocating all DMA memory from SWIOTLB
  x86: CVMs: Ensure that memory conversions happen at 2M alignment

 arch/x86/Kconfig             |  2 ++
 arch/x86/kernel/pci-dma.c    |  2 +-
 arch/x86/mm/mem_encrypt.c    |  8 ++++++--
 arch/x86/mm/pat/set_memory.c |  6 ++++--
 include/linux/swiotlb.h      | 22 ++++++----------------
 kernel/dma/direct.c          |  4 ++--
 kernel/dma/swiotlb.c         | 17 ++++++++++++-----
 7 files changed, 33 insertions(+), 28 deletions(-)

-- 
2.43.0.275.g3460e3d667-goog


