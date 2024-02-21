Return-Path: <linux-kernel+bounces-74220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F85D85D145
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D8F1F219FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30703AC34;
	Wed, 21 Feb 2024 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fIQvEFdT"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6623A8E1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500357; cv=none; b=MEviM66vyx0dNrjFMHDK7MylUxDu9vVw8rqjAMR/V6JSrTOoU/MWxhZP+5ZiGbArRFIY+3O7U/lTnNwHaBbP7xtpTSu4+E42dd6YtINldWiGGR4fh4cMyEMu+M7yWibGA5qDX5h/17y6dc6GxVeP6R0m7DpkDdyAOZf0EXyJS0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500357; c=relaxed/simple;
	bh=BNvF2Qw/ckDsg5AFU3UAYnddVhnqJSdCPlAYGCYfcZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYaXZP43TZucrna7ZvtFKjhVDZTRuoU1KvnfE+fKCNo16fh8ZJGHvmJvVITillLOLtzZvpJuz+E5qt0l3gJGBBPIB1HFFFdlc+1ugC8MGRNCrrVU9zNp4XbcXG+JbyZQG1cXLufz1OtIa5DfCOmJRZQgsO7tDHzjFZW6J/dfKN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fIQvEFdT; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c15bef14c3so2061233b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708500355; x=1709105155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ueaOZVSLa3KihKWczeP0Mvx0Wg5V24kjzNwmuUZQlfQ=;
        b=fIQvEFdTXKgC8eE+5q2rOwBq0PqDTES2q50jjM1qPLM0W4N1Z9MEsQ0qCPFA4HhY0Z
         oFbeM/qqt2IzAHH5aQ03720AhNQBRc22zOpSZEVxxsnI0BMsXGLZhmaJUcO6kTtIvD5w
         HdSSQ0ox8pzwZ6sXmM51IuHs4+LmuH7ilAHVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708500355; x=1709105155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ueaOZVSLa3KihKWczeP0Mvx0Wg5V24kjzNwmuUZQlfQ=;
        b=hlIPlu1L9MZQRrCVMvD5t1Uc80pxZNfj7WAHIcQ9ltKZoRSACdjqBO2my8ob+pQbUR
         8kJG0LGyL45CvjiuQRdnjaaATDanoCgT1SzwWPKeWoDV11MXKnJP1YQEIiT99mHbIjes
         3myuwM8ihD2rVGDT4OFSUrP4lOMIFxabG1U5x5/HTl+H6MA5n0bVBfmqtSpTmcaJ4pGW
         FUQBta39CNsFXnnWlTy30V+OEQfeer2sVx0JHVctRYCl1KNXTnGngyoEtkX72gGk2BHX
         nNXSeWKo3Xsxg9903j7dCdBGAt8zaIBIA8F8QzqawrGO00bzTunMOydYF3ozP4t3YB4c
         BRmg==
X-Forwarded-Encrypted: i=1; AJvYcCUC4ZNTSi4rg/uiJHm6c9oAdhCzt0msuUaJTIKZrFIJq5AkpgusGrSOKBi8JznhsN4ss/sH1LIuRohWMOxByRmqYvRoYeEfYlY15sNC
X-Gm-Message-State: AOJu0YxBIaCRh3PxcxQpe3mUzeqqOWiK+jo2qFJUCn5S2JoxbPKFOfTN
	NpwREkKt7isSfsDJ4qB3oDY6N7UGFsyBVyGMNDrye5lYDDXPoX2nTebqxa/mMQ==
X-Google-Smtp-Source: AGHT+IGL0Q27aT+XYlwXJPM/BhQ1zwOcwczndAcAl1o/pm4io8+k2TjLjzNjsnDOJ3EtfYMWZoIgPw==
X-Received: by 2002:a05:6808:17a3:b0:3c1:37d9:dc93 with SMTP id bg35-20020a05680817a300b003c137d9dc93mr20410632oib.10.1708500355230;
        Tue, 20 Feb 2024 23:25:55 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:b417:5d09:c226:a19c])
        by smtp.gmail.com with UTF8SMTPSA id y5-20020a056a00180500b006e45daf9e89sm5832804pfa.131.2024.02.20.23.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 23:25:54 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Yu Zhang <yu.c.zhang@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v10 0/8] KVM: allow mapping non-refcounted pages
Date: Wed, 21 Feb 2024 16:25:18 +0900
Message-ID: <20240221072528.2702048-1-stevensd@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Stevens <stevensd@chromium.org>

This patch series adds support for mapping VM_IO and VM_PFNMAP memory
that is backed by struct pages that aren't currently being refcounted
(e.g. tail pages of non-compound higher order allocations) into the
guest.

Our use case is virtio-gpu blob resources [1], which directly map host
graphics buffers into the guest as "vram" for the virtio-gpu device.
This feature currently does not work on systems using the amdgpu driver,
as that driver allocates non-compound higher order pages via
ttm_pool_alloc_page().

First, this series replaces the gfn_to_pfn_memslot() API with a more
extensible kvm_follow_pfn() API. The updated API rearranges
gfn_to_pfn_memslot()'s args into a struct and where possible packs the
bool arguments into a FOLL_ flags argument. The refactoring changes do
not change any behavior.

From there, this series extends the kvm_follow_pfn() API so that
non-refconuted pages can be safely handled. This invloves adding an
input parameter to indicate whether the caller can safely use
non-refcounted pfns and an output parameter to tell the caller whether
or not the returned page is refcounted. This change includes a breaking
change, by disallowing non-refcounted pfn mappings by default, as such
mappings are unsafe. To allow such systems to continue to function, an
opt-in module parameter is added to allow the unsafe behavior.

This series only adds support for non-refcounted pages to x86. Other
MMUs can likely be updated without too much difficulty, but it is not
needed at this point. Updating other parts of KVM (e.g. pfncache) is not
straightforward [2].

[1]
https://patchwork.kernel.org/project/dri-devel/cover/20200814024000.2485-1-gurchetansingh@chromium.org/
[2] https://lore.kernel.org/all/ZBEEQtmtNPaEqU1i@google.com/

v9 -> v10:
 - Re-add FOLL_GET changes.
 - Split x86/mmu spte+non-refcount-page patch into two patches.
 - Rename 'foll' variables to 'kfp'.
 - Properly gate usage of refcount spte bit when it's not available.
 - Replace kfm_follow_pfn's is_refcounted_page output parameter with
   a struct page *refcounted_page pointing to the page in question.
 - Add patch downgrading BUG_ON to WARN_ON_ONCE.
v8 -> v9:
 - Make paying attention to is_refcounted_page mandatory. This means
   that FOLL_GET is no longer necessary. For compatibility with
   un-migrated callers, add a temporary parameter to sidestep
   ref-counting issues.
 - Add allow_unsafe_mappings, which is a breaking change.
 - Migrate kvm_vcpu_map and other callsites used by x86 to the new API.
 - Drop arm and ppc changes.
v7 -> v8:
 - Set access bits before releasing mmu_lock.
 - Pass FOLL_GET on 32-bit x86 or !tdp_enabled.
 - Refactor FOLL_GET handling, add kvm_follow_refcounted_pfn helper.
 - Set refcounted bit on >4k pages.
 - Add comments and apply formatting suggestions.
 - rebase on kvm next branch.
v6 -> v7:
 - Replace __gfn_to_pfn_memslot with a more flexible __kvm_faultin_pfn,
   and extend that API to support non-refcounted pages (complete
   rewrite).

David Stevens (7):
  KVM: Relax BUG_ON argument validation
  KVM: mmu: Introduce kvm_follow_pfn()
  KVM: mmu: Improve handling of non-refcounted pfns
  KVM: Migrate kvm_vcpu_map() to kvm_follow_pfn()
  KVM: x86: Migrate to kvm_follow_pfn()
  KVM: x86/mmu: Track if sptes refer to refcounted pages
  KVM: x86/mmu: Handle non-refcounted pages

Sean Christopherson (1):
  KVM: Assert that a page's refcount is elevated when marking
    accessed/dirty

 arch/x86/kvm/mmu/mmu.c          | 104 +++++++---
 arch/x86/kvm/mmu/mmu_internal.h |   2 +
 arch/x86/kvm/mmu/paging_tmpl.h  |   7 +-
 arch/x86/kvm/mmu/spte.c         |   4 +-
 arch/x86/kvm/mmu/spte.h         |  22 +-
 arch/x86/kvm/mmu/tdp_mmu.c      |  22 +-
 arch/x86/kvm/x86.c              |  11 +-
 include/linux/kvm_host.h        |  53 ++++-
 virt/kvm/guest_memfd.c          |   8 +-
 virt/kvm/kvm_main.c             | 349 +++++++++++++++++++-------------
 virt/kvm/kvm_mm.h               |   3 +-
 virt/kvm/pfncache.c             |  11 +-
 12 files changed, 399 insertions(+), 197 deletions(-)


base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
-- 
2.44.0.rc0.258.g7320e95886-goog


