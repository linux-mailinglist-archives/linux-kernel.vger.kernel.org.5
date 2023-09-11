Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3558079A126
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjIKCQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjIKCQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:16:52 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A230B19C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 19:16:47 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c0c6d4d650so32469995ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 19:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694398607; x=1695003407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqoA9GhDYxmGiRCW6kUKLzalkSujRXWk0xXWsVaqSl0=;
        b=RT5yWhx3n44RuOqc/LXzstJ4VO9cuodC5ir2Oq1VpbOTsEUrC4UEclMtWwfpltZbc+
         rfFuUshjQ9ZFZCH9+tvcN0sQGoyjf4F2jgYrlpsakKLxRn3fhbCGPDdZtYVMSnYGxnn7
         YCIbZYwQ5eDNQoluaL9B6Ha09pWxcrYH1/Arc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694398607; x=1695003407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqoA9GhDYxmGiRCW6kUKLzalkSujRXWk0xXWsVaqSl0=;
        b=CKi/6NOkDdXRvys6SZIVkuf9LLmnr4WYjSKamcEv4onO4D9yjI3xCm8cGYKMAlfM2w
         7n2beF9QBfK7fs7Rh9oVwivTzlGvn/5r8m+T0HEqYS3+Y666JMpYRvHeKa00PIRCegOa
         AKJD2Z8pwC1qmhkvxkA7fmXlg5KDCrCrBIWoidNlBZQn+R9WcafZQ6KVcPavfws8gO3e
         Rbj1cp0mecjs+6gy6LbUhcX4hJs6VxMfGaDzHhiwmeRFeqYFU4T3HsrSOSK++KH9EmbU
         9R2JPrlqLzFOg38cd3Bq01lBT2xc2idUwFM47mtiZVG8AxCzoNZ+6kwJVsNHOfO0Zwfy
         kzbw==
X-Gm-Message-State: AOJu0Yx6fVelE1NE+kNlnm4Fq2+O8fHIfTlrhhGMYoQevYerUZp0AOVc
        +9w2xs//Vdfouu4vQkZREjc9yg==
X-Google-Smtp-Source: AGHT+IHwrp4u7peThbJCv3jlphOZQ/t5wNetdYpbttfEVToV24awEthc+P0HA+ZZ6XmS9NnPtx+BLg==
X-Received: by 2002:a17:902:ed53:b0:1bf:64c9:a67c with SMTP id y19-20020a170902ed5300b001bf64c9a67cmr8538505plb.22.1694398607060;
        Sun, 10 Sep 2023 19:16:47 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:282a:59c8:cc3a:2d6])
        by smtp.gmail.com with UTF8SMTPSA id g2-20020a1709026b4200b001b8a00d4f7asm5171961plt.9.2023.09.10.19.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 19:16:46 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v9 0/6] KVM: allow mapping non-refcounted pages
Date:   Mon, 11 Sep 2023 11:16:30 +0900
Message-ID: <20230911021637.1941096-1-stevensd@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

This patch series adds support for mapping VM_IO and VM_PFNMAP memory
that is backed by struct pages that aren't currently being refcounted
(e.g. tail pages of non-compound higher order allocations) into the
guest.

Our use case is virtio-gpu blob resources [1], which directly map host
graphics buffers into the guest as "vram" for the virtio-gpu device.
This feature currently does not work on systems using the amdgpu driver,
as that driver allocates non-compound higher order pages via
ttm_pool_alloc_page.

First, this series replaces the __gfn_to_pfn_memslot API with a more
extensible __kvm_faultin_pfn API. The updated API rearranges
__gfn_to_pfn_memslot's args into a struct and where possible packs the
bool arguments into a FOLL_ flags argument. The refactoring changes do
not change any behavior.

From there, this series extends the __kvm_faultin_pfn API so that
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

David Stevens (5):
  KVM: mmu: Introduce __kvm_follow_pfn function
  KVM: mmu: Improve handling of non-refcounted pfns
  KVM: Migrate kvm_vcpu_map to __kvm_follow_pfn
  KVM: x86: Migrate to __kvm_follow_pfn
  KVM: x86/mmu: Handle non-refcounted pages

Sean Christopherson (1):
  KVM: Assert that a page's refcount is elevated when marking
    accessed/dirty

 arch/x86/kvm/mmu/mmu.c          |  93 +++++++---
 arch/x86/kvm/mmu/mmu_internal.h |   1 +
 arch/x86/kvm/mmu/paging_tmpl.h  |   8 +-
 arch/x86/kvm/mmu/spte.c         |   4 +-
 arch/x86/kvm/mmu/spte.h         |  12 +-
 arch/x86/kvm/mmu/tdp_mmu.c      |  22 ++-
 arch/x86/kvm/x86.c              |  12 +-
 include/linux/kvm_host.h        |  42 ++++-
 virt/kvm/kvm_main.c             | 294 +++++++++++++++++++-------------
 virt/kvm/kvm_mm.h               |   3 +-
 virt/kvm/pfncache.c             |  11 +-
 11 files changed, 339 insertions(+), 163 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog

