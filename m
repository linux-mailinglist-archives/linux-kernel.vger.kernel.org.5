Return-Path: <linux-kernel+bounces-104787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6514687D399
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79952817F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51AA4F20E;
	Fri, 15 Mar 2024 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3hLQDDI+"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD8D44C77
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527379; cv=none; b=aqMQ8UkGn3exc++IeyiD0YZoUK0FNy1N68JSFaBHC/rGEnezbALYXTMvvQs0uw4Zr82wWMIaIT7Ia7bInT8ry2trePuctjV0xKY504rOV8tFh6LBDhGHwZs8d/rKDiV8cB3p8cq2oezoFV33LaXoMRVUmU1rSzSmCCNc6IpmF9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527379; c=relaxed/simple;
	bh=KUHOP8ehexowNIEsOotntCAdUefMeTgT8ndPqIvacRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVNXD0ySfGIcoDFFsz2LnOowl81+UbZLpaGKpZYaZwCbWpxwedCeKYDmqq/hLmT2sif6RTChP9n84iFDptbytEuuKQAxF29m5LXFn7ZIUwnvGA3EhkJlmqgCRK2yFtCp35BCRa9miF72kh9lcC/8llLbdBWiJqq18uktTmthwVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3hLQDDI+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6ce174d45so1927473b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710527376; x=1711132176; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Yx8GBGZtm8giG+I86hNAaIO2ye/1iwJfeXfUGn8W+g=;
        b=3hLQDDI+eEN3UTYekutR7sByJhxPou0i4tE2YGyQVOIZHWDIIHm4Zw7hynNsICviyr
         zlKN76yJ3PiWSPj7NiT1q65DGOXLcovhqrKNS7Veb9FfdV+0zZ8P57O3iNLvqWYURdQq
         IBuAd6069dIf4ZQh44QOO7ToDMXrhnYgflh+g67Kti/ohCcbiB8pfeKkxQs0ODMWQl7A
         /2b+r8EgyK7cvFoPV2voZr8WxXUk6U6Q9fEUg9/9PMiau8ThgSvjM1YNWvq2rx4BeAbg
         sSpRlSJGTDO9oRMfSAeuYg5J2HtpDf7chDJ7TRgpxcfPg/iwKSe++QghZysiop9LaG3C
         IZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710527376; x=1711132176;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Yx8GBGZtm8giG+I86hNAaIO2ye/1iwJfeXfUGn8W+g=;
        b=jlGIabG7QA6qF09RX2uAX8a/y+WjGejuYPOTo8h32NAa97tB79Ga+W1NoU1PdzaM78
         ipuSyUG63IEOaaoH2jzR+o8imFlXKANIuGmEH6/5N5or+o77IAgdKXnFXn0xP21jA37b
         t/wSKXp48lunGnllvt+8aA9ZpIF2fBbUX2P9DK8c1d7jRiv7yw/wZojJ5S2nGuLqHqlC
         pGcniHO2xcOw6BgCPwB9Q424twufL8k+6Ef7p6iPhUBw+2/Es9AhmGqxbhrpnV4IcCmJ
         NXmQSPnY9uGx5vjOaGNQomaBbex0BMfxU9BGqge0gdQLoWdHTNL4lc6sMAZ0J4hwEYAo
         T1Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUfBfIpHvWHMR45xJTQ1gI7xxraUsKhPwRwAv5M4zLpA0JiADtEy8R5HiGzlgpXzPY078y0zdDL++gf8RCdzwzhcGVvPyfbHBuI3HX3
X-Gm-Message-State: AOJu0YzmKLzK4GK00MZCPpmIjSAOr71dYRqbZWyEuwavH9b9jn4h2Teb
	ObxgQjcY+qycU/vEFIv1xTiQsFC/oF2n4ybfZ2fsUdh/9QK/vqHKpCOtn/14dg==
X-Google-Smtp-Source: AGHT+IHf+8j7zKnvwbaJH/TUrJOU+u8aCZhENiidgnodEi0/+PKq1PeMhJI52e2EQ4QfYyAqDADIhg==
X-Received: by 2002:a05:6a00:3d0d:b0:6e6:9f29:fc43 with SMTP id lo13-20020a056a003d0d00b006e69f29fc43mr7068182pfb.12.1710527375893;
        Fri, 15 Mar 2024 11:29:35 -0700 (PDT)
Received: from google.com (61.139.125.34.bc.googleusercontent.com. [34.125.139.61])
        by smtp.gmail.com with ESMTPSA id dr23-20020a056a020fd700b005d67862799asm2480674pgb.44.2024.03.15.11.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 11:29:33 -0700 (PDT)
Date: Fri, 15 Mar 2024 11:29:27 -0700
From: David Matlack <dmatlack@google.com>
To: syzbot <syzbot+900d58a45dcaab9e4821@syzkaller.appspotmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
	pbonzini@redhat.com, seanjc@google.com,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org,
	vipinsh@google.com
Subject: Re: [syzbot] [kvm?] WARNING in clear_dirty_gfn_range
Message-ID: <ZfSTh4bLuAMlF6Er@google.com>
References: <000000000000c6526f06137f18cc@google.com>
 <CALzav=euH_n9WXG29CFd10urh85O4Mw2L=StEizVmh27CYzrtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=euH_n9WXG29CFd10urh85O4Mw2L=StEizVmh27CYzrtQ@mail.gmail.com>

On 2024-03-15 11:07 AM, David Matlack wrote:
> On Tue, Mar 12, 2024 at 4:34 PM syzbot
> <syzbot+900d58a45dcaab9e4821@syzkaller.appspotmail.com> wrote:
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 5165 at arch/x86/kvm/mmu/tdp_mmu.c:1526 clear_dirty_gfn_range+0x3d6/0x540 arch/x86/kvm/mmu/tdp_mmu.c:1526
> > Modules linked in:
> > CPU: 1 PID: 5165 Comm: syz-executor417 Not tainted 6.8.0-syzkaller-01185-g855684c7d938 #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > RIP: 0010:clear_dirty_gfn_range+0x3d6/0x540 arch/x86/kvm/mmu/tdp_mmu.c:1526
> > Call Trace:
> >  <TASK>
> >  kvm_tdp_mmu_clear_dirty_slot+0x24f/0x2e0 arch/x86/kvm/mmu/tdp_mmu.c:1557
> >  kvm_mmu_slot_leaf_clear_dirty+0x38b/0x490 arch/x86/kvm/mmu/mmu.c:6783
> >  kvm_mmu_slot_apply_flags arch/x86/kvm/x86.c:12962 [inline]
> >  kvm_arch_commit_memory_region+0x299/0x490 arch/x86/kvm/x86.c:13031
> >  kvm_commit_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:1751 [inline]
> >  kvm_set_memslot+0x4d3/0x13e0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1994
> >  __kvm_set_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:2129 [inline]
> >  __kvm_set_memory_region+0xdbc/0x1520 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2020
> >  kvm_set_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:2150 [inline]
> >  kvm_vm_ioctl_set_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:2162 [inline]
> >  kvm_vm_ioctl+0x151c/0x3e20 arch/x86/kvm/../../../virt/kvm/kvm_main.c:5152
> 
> The reproducer uses nested virtualization to launch an L2 with EPT
> disabled. This creates a TDP MMU root with role.guest_mode=1, which
> triggers the WARN_ON() in kvm_tdp_mmu_clear_dirty_slot() because
> kvm_mmu_page_ad_need_write_protect() returns false whenever PML is
> enabled and the shadow page role.guest_mode=1.
> 
> If I'm reading prepare_vmcs02_constant_state() correctly, we always
> disable PML when running in L2. So when enable_pml=1 and L2 runs with
> EPT disabled we are blind to dirty tracking L2 accesses.

+Vipin

I believe this was introduced by 6.4 commit 5982a5392663 ("KVM: x86/mmu:
Use kvm_ad_enabled() to determine if TDP MMU SPTEs need wrprot").

I see two options to fix:

  1. Allow PML to be enabled when L2 is running with EPT is disabled.
  2. Fix the TDP MMU logic to write-protect role.guest_mode=1 SPTEs.

(1.) sounds more complicated and will require more testing. (2.) is
quite simple since an entire TDP MMU tree is either guest_mode=0 or
guest_mode=1.

Example fix (fixes syzbot repro but otherwise untested):

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 6ae19b4ee5b1..eb6fb8d9c00c 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1498,6 +1498,24 @@ void kvm_tdp_mmu_try_split_huge_pages(struct kvm *kvm,
 	}
 }
 
+static inline u64 tdp_mmu_dirty_bit(struct kvm_mmu_page *root, bool force_wrprot)
+{
+	if (force_wrprot || kvm_mmu_page_ad_need_write_protect(root) || !kvm_ad_enabled())
+		return PT_WRITABLE_MASK;
+
+	return shadow_dirty_mask;
+}
+
+static inline bool tdp_mmu_dirty_bit_invalid_for_spte(struct tdp_iter *iter, u64 dbit)
+{
+	/*
+	 * The decision of whether to clear the D-bit or W-bit is made based on
+	 * the root, as all TDP MMU SPTEs within a root should require the same
+	 * modifications. This check ensures that is actually the case.
+	 */
+	return dbit == shadow_dirty_mask && spte_ad_need_write_protect(iter->old_spte);
+}
+
 /*
  * Clear the dirty status of all the SPTEs mapping GFNs in the memslot. If
  * AD bits are enabled, this will involve clearing the dirty bit on each SPTE.
@@ -1508,7 +1526,7 @@ void kvm_tdp_mmu_try_split_huge_pages(struct kvm *kvm,
 static bool clear_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 			   gfn_t start, gfn_t end)
 {
-	u64 dbit = kvm_ad_enabled() ? shadow_dirty_mask : PT_WRITABLE_MASK;
+	u64 dbit = tdp_mmu_dirty_bit(root, false);
 	struct tdp_iter iter;
 	bool spte_set = false;
 
@@ -1523,8 +1541,7 @@ static bool clear_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 		if (tdp_mmu_iter_cond_resched(kvm, &iter, false, true))
 			continue;
 
-		KVM_MMU_WARN_ON(kvm_ad_enabled() &&
-				spte_ad_need_write_protect(iter.old_spte));
+		KVM_MMU_WARN_ON(tdp_mmu_dirty_bit_invalid_for_spte(&iter, dbit));
 
 		if (!(iter.old_spte & dbit))
 			continue;
@@ -1570,8 +1587,7 @@ bool kvm_tdp_mmu_clear_dirty_slot(struct kvm *kvm,
 static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
 				  gfn_t gfn, unsigned long mask, bool wrprot)
 {
-	u64 dbit = (wrprot || !kvm_ad_enabled()) ? PT_WRITABLE_MASK :
-						   shadow_dirty_mask;
+	u64 dbit = tdp_mmu_dirty_bit(root, wrprot);
 	struct tdp_iter iter;
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
@@ -1583,8 +1599,7 @@ static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
 		if (!mask)
 			break;
 
-		KVM_MMU_WARN_ON(kvm_ad_enabled() &&
-				spte_ad_need_write_protect(iter.old_spte));
+		KVM_MMU_WARN_ON(tdp_mmu_dirty_bit_invalid_for_spte(&iter, dbit));
 
 		if (iter.level > PG_LEVEL_4K ||
 		    !(mask & (1UL << (iter.gfn - gfn))))

