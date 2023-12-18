Return-Path: <linux-kernel+bounces-3786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD618171A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AA6DB22564
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4E01D13B;
	Mon, 18 Dec 2023 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Icnq8gmb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9957415AC0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-336628333caso1046335f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 05:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702907987; x=1703512787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P8r4T7nvDO4uBvNXHdAFoty11B3AGf8jb80RWrKCDHk=;
        b=Icnq8gmbigbdTaIU0fQGeK24acLL7EqucE+MvOL4Q6oN7VDvmAX/iTunk6tqF0z5xx
         F2fei8RICw3JTvrpnDQhXnH0rv223XmnzZQwucInTUvMj9iazw7zq1rfzcDIOE/pVGNZ
         BRewP9E2Cc1jp9F75R8FpnRi/Np2m2cvTE76E0CjWybvjNCd50swu8s4isVNLhGWSCZh
         xStwyCh3c/z8FC+IxSr7a3Vlvh+pjQhQQcmLDx4nR71IsZhBc+dfaeNtbpNRMWgTL/FG
         xPXW+RTUicn0R09ckSZ0xBbPWBgSy60uzwSETi0VJiZ6Ro41JcjrAK6Gq9udxINy20NI
         19yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702907987; x=1703512787;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P8r4T7nvDO4uBvNXHdAFoty11B3AGf8jb80RWrKCDHk=;
        b=Rxk5mvgcQnxSwCAyGypw4sxcSMAEmGqWW52JpQL9aM+aztpL7OuZ7WCKpf2A0kzXgQ
         pA72gk1qwLOiO83IIqvcrZQuCsMx025b6UDOIEOV4A4HC5M9FyNOVXsl3GK8Hs/RDdwV
         tLlXmzWAYpnjI29IFIlW2g30RIIfZQEsEIlOdttxHQv1iVVSLvr74HI2wZIk8EWvQBWK
         xC3vzBGxNFRhfwLyseMCBoIo/OGrOmJeocBgVUDgfqQKUN0NRPG0q2MCk17u6wt4M2YL
         HgPULXjDTXTD3PRzLl7MuZGbW1vwF+opdySM5FA/4OT0eAdgUZyzIuklD3VLwXK7nWmg
         1qOQ==
X-Gm-Message-State: AOJu0YzhPOu1lDmMtipccSOiysLQw7WrAIpVpjaBRQSKU+tISJNbAwm+
	liJtzzKgAxZtdK66Jf12CEdHttMAxufcfsnBPb8=
X-Google-Smtp-Source: AGHT+IGh1SOpBCEZN0uVflQ0cEhgKsbz2gBXoiY11ZQ7CD2sg8aW63UXfV3LhaVdXurCvs+8akIVUFrnqZUBKBaeib8=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:2109:b0:408:3b1a:f9cd with
 SMTP id u9-20020a05600c210900b004083b1af9cdmr303600wml.8.1702907986774; Mon,
 18 Dec 2023 05:59:46 -0800 (PST)
Date: Mon, 18 Dec 2023 13:58:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218135859.2513568-2-sebastianene@google.com>
Subject: [PATCH v4 00/10] arm64: ptdump: View the second stage page-tables
From: Sebastian Ene <sebastianene@google.com>
To: will@kernel.org, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com, mark.rutland@arm.com, 
	akpm@linux-foundation.org, maz@kernel.org
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, vdonnefort@google.com, 
	qperret@google.com, smostafa@google.com, 
	Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

This can be used as a debugging tool for dumping the second stage
page-tables.

When CONFIG_PTDUMP_STAGE2_DEBUGFS is enabled, ptdump registers 
'/sys/debug/kvm/<guest_id>/stage2_page_tables' entry with debugfs
upon guest creation. This allows userspace tools (eg. cat) to dump the
stage-2 pagetables by reading the registered file.

Reading the debugfs file shows stage-2 memory ranges in following format:
<IPA range> <size> <descriptor type> <access permissions> <mem_attributes>

Under pKVM configuration(kvm-arm.mode=protected) ptdump registers an entry
for the host stage-2 pagetables in the following path:
/sys/debug/kvm/host_stage2_page_tables/

The tool interprets the pKVM ownership annotation stored in the invalid
entries and dumps to the console the ownership information. To be able
to access the host stage-2 page-tables from the kernel, a new hypervisor
call was introduced which allows us to snapshot the page-tables in a host
provided buffer. The hypervisor call is hidden behind CONFIG_NVHE_EL2_DEBUG
as this should be used under debugging environment.

Link to the third version:
https://lore.kernel.org/all/20231115171639.2852644-2-sebastianene@google.com/

Link to the second version:
https://lore.kernel.org/all/20231019144032.2943044-1-sebastianene@google.com/#r

Link to the first version:
https://lore.kernel.org/all/20230927112517.2631674-1-sebastianene@google.com/

Changelog:
  v3 -> current_version:
  * refactorization: moved all the **KVM** specific components under
    kvm/ as suggested by Oliver. Introduced a new file
    arm64/kvm/ptdump.c which handled the second stage translation.
    re-used only the display portion from mm/ptdump.c

  * pagetable snapshot creation now uses memory donated from the host.
    The memory is no longer shared with the host as this can pose a security
    risk if the host has access to manipulate the pagetable copy while
    the hypervisor iterates it.

  * fixed a memory leak: while memory was used from the memcache for
    building the snapshot pagetable, it was no longer giving back the
    pages to the host for freeing. A separate array was introduced to
    keep track of the pages allocated from the memcache.

  v2 -> v3:
  * register the stage-2 debugfs entry for the host under
    /sys/debug/kvm/host_stage2_page_tables and in
    /sys/debug/kvm/<guest_id>/stage2_page_tables for guests.

  * don't use a static array for parsing the attributes description,
    generate it dynamically based on the number of pagetable levels

  * remove the lock that was guarding the seq_file private inode data,
    and keep the data private to the open file session.

  * minor fixes & renaming of CONFIG_NVHE_EL2_PTDUMP_DEBUGFS to
    CONFIG_PTDUMP_STAGE2_DEBUGFS

  v1 -> v2:
  * use the stage-2 pagetable walker for dumping descriptors instead of
    the one provided by ptdump.

  * support for guests pagetables dumping under VHE/nVHE non-protected

Thanks,

Sebastian Ene (10):
  KVM: arm64: Add snapshot interface for the host stage-2 pagetable
  KVM: arm64: Add ptdump registration with debugfs for the stage-2
    pagetables
  KVM: arm64: Invoke the snapshot interface for the host stage-2
    pagetable
  arm64: ptdump: Expose the attribute parsing functionality
  arm64: ptdump: Use the mask from the state structure
  KVM: arm64: Move pagetable definitions to common header
  KVM: arm64: Walk the pagetable snapshot and parse the ptdump
    descriptors
  arm64: ptdump: Interpret memory attributes based on the runtime config
  arm64: ptdump: Interpret pKVM ownership annotations
  arm64: ptdump: Add guest stage-2 pagetables dumping

 arch/arm64/include/asm/kvm_asm.h              |   1 +
 arch/arm64/include/asm/kvm_pgtable.h          | 111 +++++
 arch/arm64/include/asm/ptdump.h               |  49 +-
 arch/arm64/kvm/Kconfig                        |  13 +
 arch/arm64/kvm/Makefile                       |   1 +
 arch/arm64/kvm/arm.c                          |   2 +
 arch/arm64/kvm/debug.c                        |   6 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  27 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  12 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 186 ++++++++
 arch/arm64/kvm/hyp/pgtable.c                  |  85 ++--
 arch/arm64/kvm/kvm_ptdump.h                   |  21 +
 arch/arm64/kvm/ptdump.c                       | 436 ++++++++++++++++++
 arch/arm64/mm/ptdump.c                        |  55 +--
 14 files changed, 897 insertions(+), 108 deletions(-)
 create mode 100644 arch/arm64/kvm/kvm_ptdump.h
 create mode 100644 arch/arm64/kvm/ptdump.c

-- 
2.43.0.472.g3155946c3a-goog


