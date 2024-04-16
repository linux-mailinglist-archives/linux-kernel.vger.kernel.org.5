Return-Path: <linux-kernel+bounces-147266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEE08A71BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CCF287FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65485131BC9;
	Tue, 16 Apr 2024 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fovZW8aR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA8612AAE3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286525; cv=none; b=CN4arDMFs5A+ffRHwpBnlm2xN1fuF97AQ2470CJFVqERBylh8yertIWnWnekxKvP+qlOCNGK4ZJStxiDwmUd0BLmzhd8Y1pF/w07ZnWwHAbmei1ylJ+keiL6e3IFKOz8Z96GCBmB4AnGlwk8cBOMhXCybc0+TGFSyWuu+nhBgYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286525; c=relaxed/simple;
	bh=hn4PejrHf/0xoIeGngF0uMMcOnNiG9soQVpr4eN2C28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxypMiwZEU2frQpdh6rSpAqHBL12X6ypBOyHw9t1oJTgFrOQmEsK7PeUvAARjBzeiqZ3bzQA+IYqxQaQb4QHPs9Yfx+M5nxg3xl4N5G8s04f/91p7Tr6DOKjO27V6yz4nl/Q1UVtVUJWsHDvYuHXwndwOrPBtDN8FzcqrQzgBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fovZW8aR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713286522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+xQpuNwWw1Mss/aSYYGuvtFUaskyKzvL9S/zN6YeiM=;
	b=fovZW8aR/t7gUOQ1TE/xEp4yZqovpFeHjBaa2ZIZKhkw2S7mVLvPkR6gGLdT1TFmHD1uiE
	LH8SyWdEeri7mF8xQigChZYW87e/HEKX/xqWM/iWnO4wg/NacoyT9JQo9vFkmWGj7EGZy8
	E6AvRgl/94KoCFCRdfUN63XHTBYhp64=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-DVpRlERyNK-yKRmwpYvnQA-1; Tue, 16 Apr 2024 12:55:18 -0400
X-MC-Unique: DVpRlERyNK-yKRmwpYvnQA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343c7fa0dd5so3078129f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 09:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713286517; x=1713891317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+xQpuNwWw1Mss/aSYYGuvtFUaskyKzvL9S/zN6YeiM=;
        b=wNTWvTSb83Ktkh/+v3XL+Q9t2Az+Og3QBiczDfPpFcGER8wAZMPtXD7uAMqYII6QaV
         On5dVYNMLBrJGNhlE6yy/uCW3nQgM8/7KAbcJauem4a2PMzwy4KvPaJ5vb495y+5lJfh
         llC7OW4OEq38iTTUIxBZgx9auUKV+7Znb3KAhY5dOsxWijUDKCz17SUw2RmJSEmIjwj9
         TJPEbXwXoyG77rNG1bf/w0Q/Vu/AqkWA9Pd9pAm0qvJ+lz0zKDdqNPGlcUdqAtbGm5pZ
         VnagHWoxmRIjIJx/DP6Hgm+D2avsgVAVeOzklU7NyinX2yMIiLdlLB5gxEfvRFSjiU5G
         6hrw==
X-Forwarded-Encrypted: i=1; AJvYcCWifQHWvLMYZwuN69ZykQ0NQE5DsR/KFc3WR0Uer5sDMSdrqOX8hDyPU9mK+ipDkJSjltRv9+FN/NqfVghwaqqoEKApVcHkJuuv2I8i
X-Gm-Message-State: AOJu0Yx0m0qliKMxQdEpArWMOsqX95l40lfR5T6iDJ0L9IFDDteGjexa
	dKNGbM0DjgnSfmftlFCRI+Nye4Re8z/U0vri6JPkqRvsLXaMGuDSmXiNjck9A9+mT/gtwqza00f
	c6O+9/A7YOaZnaEhcSE0jPKLZBZFgbYsklAd5Vc8yNu4HRkb6wej5/gQN5HrC+oD+gl6AhJNDtW
	h6dxDC3oKrKyI8JwADHgZWRGZVWSv4G0X6l+gz
X-Received: by 2002:adf:ef8f:0:b0:346:65dd:560a with SMTP id d15-20020adfef8f000000b0034665dd560amr8113225wro.3.1713286517318;
        Tue, 16 Apr 2024 09:55:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAcorU0V2YC1HmmO0dLUEzT/HK2cx+LJgepb7IEcMpi9K3mQ88H20AuTm1qARWPMyw7eXswIfJ6kMGrArsbL4=
X-Received: by 2002:adf:ef8f:0:b0:346:65dd:560a with SMTP id
 d15-20020adfef8f000000b0034665dd560amr8113212wro.3.1713286516895; Tue, 16 Apr
 2024 09:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411203529.1866998-1-seanjc@google.com>
In-Reply-To: <20240411203529.1866998-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Apr 2024 18:55:05 +0200
Message-ID: <CABgObfanoru0cEHFbNOw9QDv8EWAkye4YPzfyDMyBmUwpJjiTA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Fixes for 6.9-rcN
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:35=E2=80=AFPM Sean Christopherson <seanjc@google=
com> wrote:
>
> Please pull a big pile of fixes for 6.9.  Many of these were sent even be=
fore
> the 6.9 merge window, but I was on vacation until rc2, and things piled u=
p.
>
> The back half of the commits were _just_ rebased to drop my version of th=
e
> LVTPC masking fixes, but that's your fault. :-)  For giggles, I also push=
ed
> kvm-x86 tags/kvm-x86-fixed-6.9-rcN-unrebased if you or anyone else want a=
 paper
> trail for the pre-rebase commits.
>
> Note, there's a perf change in here that didn't get an Ack from anyone, b=
ut the
> fixes have been on-list for over a month, and I can't imagine anyone obje=
cting
> to adding a new feature flag to x86_pmu_capability, which for all intents=
 and
> purposes exists purely for KVM.
>
> Thanks!

Pulled, thanks.

Paolo

> The following changes since commit fec50db7033ea478773b159e0e2efb135270e3=
b7:
>
>   Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.9-rcN
>
> for you to fetch changes up to eefb85b3f0310c2f4149c50cb9b13094ed1dde25:
>
>   KVM: Drop unused @may_block param from gfn_to_pfn_cache_invalidate_star=
t() (2024-04-11 12:58:53 -0700)
>
> ----------------------------------------------------------------
> KVM fixes for 6.9-rcN:
>
>  - Fix a mostly benign bug in the gfn_to_pfn_cache infrastructure where K=
VM
>    would allow userspace to refresh the cache with a bogus GPA.  The bug =
has
>    existed for quite some time, but was exposed by a new sanity check add=
ed in
>    6.9 (to ensure a cache is either GPA-based or HVA-based).
>
>  - Drop an unused param from gfn_to_pfn_cache_invalidate_start() that got=
 left
>    behind during a 6.9 cleanup.
>
>  - Disable support for virtualizing adaptive PEBS, as KVM's implementatio=
n is
>    architecturally broken and can leak host LBRs to the guest.
>
>  - Fix a bug where KVM neglects to set the enable bits for general purpos=
e
>    counters in PERF_GLOBAL_CTRL when initializing the virtual PMU.  Both =
Intel
>    and AMD architectures require the bits to be set at RESET in order for=
 v2
>    PMUs to be backwards compatible with software that was written for v1 =
PMUs,
>    i.e. for software that will never manually set the global enables.
>
>  - Disable LBR virtualization on CPUs that don't support LBR callstacks, =
as
>    KVM unconditionally uses PERF_SAMPLE_BRANCH_CALL_STACK when creating t=
he
>    virtual LBR perf event, i.e. KVM will always fail to create LBR events=
 on
>    such CPUs.
>
>  - Fix a math goof in x86's hugepage logic for KVM_SET_MEMORY_ATTRIBUTES =
that
>    results in an array overflow (detected by KASAN).
>
>  - Fix a flaw in the max_guest_memory selftest that results in it exhaust=
ing
>    the supply of ucall structures when run with more than 256 vCPUs.
>
>  - Mark KVM_MEM_READONLY as supported for RISC-V in set_memory_region_tes=
t.
>
>  - Fix a bug where KVM incorrectly thinks a TDP MMU root is an indirect s=
hadow
>    root due KVM unnecessarily clobbering root_role.direct when userspace =
sets
>    guest CPUID.
>
>  - Fix a dirty logging bug in the where KVM fails to write-protect TDP MM=
U
>    SPTEs used for L2 if Page-Modification Logging is enabled for L1 and t=
he L1
>    hypervisor is NOT using EPT (if nEPT is enabled, KVM doesn't use the T=
DP MMU
>    to run L2).  For simplicity, KVM always disables PML when running L2, =
but
>    the TDP MMU wasn't accounting for root-specific conditions that force =
write-
>    protect based dirty logging.
>
> ----------------------------------------------------------------
> Andrew Jones (1):
>       KVM: selftests: fix supported_flags for riscv
>
> David Matlack (4):
>       KVM: x86/mmu: Write-protect L2 SPTEs in TDP MMU when clearing dirty=
 status
>       KVM: x86/mmu: Remove function comments above clear_dirty_{gfn_range=
,pt_masked}()
>       KVM: x86/mmu: Fix and clarify comments about clearing D-bit vs. wri=
te-protecting
>       KVM: selftests: Add coverage of EPT-disabled to vmx_dirty_log_test
>
> Maxim Levitsky (1):
>       KVM: selftests: fix max_guest_memory_test with more that 256 vCPUs
>
> Rick Edgecombe (1):
>       KVM: x86/mmu: x86: Don't overflow lpage_info when checking attribut=
es
>
> Sean Christopherson (11):
>       KVM: Add helpers to consolidate gfn_to_pfn_cache's page split check
>       KVM: Check validity of offset+length of gfn_to_pfn_cache prior to a=
ctivation
>       KVM: Explicitly disallow activatating a gfn_to_pfn_cache with INVAL=
ID_GPA
>       KVM: x86/pmu: Disable support for adaptive PEBS
>       KVM: x86/pmu: Set enable bits for GP counters in PERF_GLOBAL_CTRL a=
t "RESET"
>       KVM: selftests: Verify post-RESET value of PERF_GLOBAL_CTRL in PMCs=
 test
>       KVM: VMX: Snapshot LBR capabilities during module initialization
>       perf/x86/intel: Expose existence of callback support to KVM
>       KVM: VMX: Disable LBR virtualization if the CPU doesn't support LBR=
 callstacks
>       KVM: x86/mmu: Precisely invalidate MMU root_role during CPUID updat=
e
>       KVM: Drop unused @may_block param from gfn_to_pfn_cache_invalidate_=
start()
>
> Tao Su (1):
>       KVM: VMX: Ignore MKTME KeyID bits when intercepting #PF for allow_s=
maller_maxphyaddr
>
>  arch/x86/events/intel/lbr.c                        |  1 +
>  arch/x86/include/asm/perf_event.h                  |  1 +
>  arch/x86/kvm/mmu/mmu.c                             |  9 ++--
>  arch/x86/kvm/mmu/tdp_mmu.c                         | 51 ++++++++--------=
--
>  arch/x86/kvm/pmu.c                                 | 16 +++++-
>  arch/x86/kvm/vmx/pmu_intel.c                       |  2 +-
>  arch/x86/kvm/vmx/vmx.c                             | 41 ++++++++++++---
>  arch/x86/kvm/vmx/vmx.h                             |  6 ++-
>  .../testing/selftests/kvm/max_guest_memory_test.c  | 15 +++---
>  .../testing/selftests/kvm/set_memory_region_test.c |  2 +-
>  .../selftests/kvm/x86_64/pmu_counters_test.c       | 20 +++++++-
>  .../selftests/kvm/x86_64/vmx_dirty_log_test.c      | 60 ++++++++++++++++=
+-----
>  virt/kvm/kvm_main.c                                |  3 +-
>  virt/kvm/kvm_mm.h                                  |  6 +--
>  virt/kvm/pfncache.c                                | 50 ++++++++++++----=
--
>  15 files changed, 194 insertions(+), 89 deletions(-)
>


