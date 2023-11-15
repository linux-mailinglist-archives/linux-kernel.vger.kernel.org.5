Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FDE7EC97A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjKORQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjKORQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:16:58 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DA318E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:16:54 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da0ccfc4fc8so8898668276.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700068613; x=1700673413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jvaWmO0FnVQSvQa+hPtEgtYlB7ewMwZZNTNrDNriGoM=;
        b=Id+NKevkOHduDfuz18MeJCn/gclNpmmDIniqFm9SVVYGzj8Gpg7h2enFmk3VUAzXTI
         94W/sfGNaMciXnjxPAcdqgHIk8pjj2DA6jqsgILU3bhRvQVWBULiTzGEkoXqun70DeXB
         6tqFUs9+wFlaUoaB881Kgs3iZkAJTBecK6WCyFP8pgaDgRtAoeVt9vw2aMGzzuKA2Ony
         BfJkzTC5Kzh9+T2I6MYXXG2vUVNV4UHaoEjp+c/mJbMdF24XV9T8Nw9FQlIxuMGEP25R
         9RXGCUUOyXqaMqwK7XzDJT/cR2LkO+Nd1GeE7xP0I64caiPPUi2688CYIyl8Uw0FCNtE
         8KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700068613; x=1700673413;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jvaWmO0FnVQSvQa+hPtEgtYlB7ewMwZZNTNrDNriGoM=;
        b=asnR6TNTJnZ1NDsXtATyzkN8Vht1nKGI3FoFFPODQ11aAV8dFWZrhZyYPcuum3aUEj
         UHgW6Y8WBL1kqCGMmHd1Fy76WHF+0FMPwdZ3t8R50DqPd5X+lgKDr9p9qAP6eI6UVGC2
         wERuQ3AdKKXcXSX8Mq0wnNWworowAbbsefpep7+Lu7XWSv2cvDzb4AGkj+CbBVnqIncR
         UTAZqCsJKN25Nwic7HTU30Ae6q6greyTh/YACAwDXDQiGqjyhSK9tGtuoK3UD28rc/8k
         g7T7NfucRSmUVKI8qwF7VhtlkTS3tx5emPon22MaDdqrf2SdYGrcC7AHE6k/4wmjXRVR
         dsbQ==
X-Gm-Message-State: AOJu0YyW/I8I5RzqP9vW0sHD33MWodxLn/nRisawSZe+Tg2iOhjt2SMc
        F3fo8TjZG3navJzcvwL6I5MYNJUbGeOitKqUb5Q=
X-Google-Smtp-Source: AGHT+IGpTPHEt6mqVGX4OcHH3rw9Bhky+H2JiZ2u6YBAqgXzSwAP/9U1Wj0MXTkRRyqmx1wx/ooeavPE5/IIuxO7qck=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a25:24c7:0:b0:daf:660e:9bdb with SMTP
 id k190-20020a2524c7000000b00daf660e9bdbmr176609ybk.6.1700068613223; Wed, 15
 Nov 2023 09:16:53 -0800 (PST)
Date:   Wed, 15 Nov 2023 17:16:30 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231115171639.2852644-2-sebastianene@google.com>
Subject: [PATCH v3 00/10] arm64: ptdump: View the second stage page-tables
From:   Sebastian Ene <sebastianene@google.com>
To:     will@kernel.org, Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com,
        mark.rutland@arm.com, akpm@linux-foundation.org, maz@kernel.org
Cc:     kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vdonnefort@google.com, qperret@google.com, smostafa@google.com,
        Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Link to the second version:
https://lore.kernel.org/all/20231019144032.2943044-1-sebastianene@google.com/#r

Link to the first version:
https://lore.kernel.org/all/20230927112517.2631674-1-sebastianene@google.com/

Changelog:

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
  KVM: arm64: Add snap shooting the host stage-2 pagetables
  arm64: ptdump: Use the mask from the state structure
  arm64: ptdump: Add the walker function to the ptdump info structure
  KVM: arm64: Move pagetable definitions to common header
  arm64: ptdump: Add hooks on debugfs file operations
  arm64: ptdump: Register a debugfs entry for the host stage-2 tables
  arm64: ptdump: Parse the host stage-2 page-tables from the snapshot
  arm64: ptdump: Interpret memory attributes based on runtime
    configuration
  arm64: ptdump: Interpret pKVM ownership annotations
  arm64: ptdump: Add support for guest stage-2 pagetables dumping

 arch/arm64/include/asm/kvm_asm.h              |   1 +
 arch/arm64/include/asm/kvm_pgtable.h          |  85 +++
 arch/arm64/include/asm/ptdump.h               |  27 +
 arch/arm64/kvm/Kconfig                        |  13 +
 arch/arm64/kvm/arm.c                          |   2 +
 arch/arm64/kvm/debug.c                        |   6 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   8 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  20 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 102 ++++
 arch/arm64/kvm/hyp/pgtable.c                  |  98 ++--
 arch/arm64/kvm/mmu.c                          |   2 +
 arch/arm64/mm/ptdump.c                        | 483 +++++++++++++++++-
 arch/arm64/mm/ptdump_debugfs.c                |  64 ++-
 13 files changed, 852 insertions(+), 59 deletions(-)

-- 
2.43.0.rc0.421.g78406f8d94-goog

