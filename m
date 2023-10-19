Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E147CFD0D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345834AbjJSOkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346204AbjJSOkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:40:43 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAC518E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:40:40 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-32dceab634dso955699f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697726438; x=1698331238; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VwGo+pxMqRlSrxNR7lfucT+VBcms/xUP2WA4dRFnCj4=;
        b=VG2hVk9F+nnrPsmVmXWMsUPLWSclBiXbEMhbPG6yll9TrLkv/riQY0fmPPlYFHYuLV
         bAgf8CTFTNGMqRra5ywZwOZZwJtfC+eJi4zy/d8KflxsSVy0qYyoBhi6ZfXpCMLXLQsm
         vnZfWGkHrcaGeyOYlfS10e0mhHXsNnigNh0sdlyXilnkdEcWXwISWKPsB/aPsO9wzRAg
         XOMi53waf9mZDmHrKiOZFozyYivMFvnAFSUYFbbY5zlkvKRZyQiv/boWzJjLUO2hm6CS
         lLbAVkDfiNn83vNfL5yRuFsoMnEa215a1TeZDc3TW9Am0UefTAVvi2vF9GA3KVisoABK
         8j6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726438; x=1698331238;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VwGo+pxMqRlSrxNR7lfucT+VBcms/xUP2WA4dRFnCj4=;
        b=cnYMSC/kDJetipCzftDjQbwmiDBDzsAl1qVXgvbg2cA/LK/FSIwMW+exFykDvwVX/j
         Sox4Loz5j2sni5slDyX7hF5LbDJHpOtUksYQ9EFtuJYyB2PTlcWzOaLsrEGnahlbRmS/
         dnsyEilWOfSra2O2OIZNsaCu4NL3q8PPuJ3sDn9VfMGyFKZBa3bzXMNQ4cJUMQ6Yytxw
         0mKsNThpdO2bsOBBSUQl2NaDr0MWzPx9xw56vw2ugwJBRxQWYEsC+EG9ZlKI13JOPHAV
         9thUXApeS80SVxcO20QpVGksoYUcJqCCVifGpJvavtFKmk6AAW81t36S+n9aMeQ0dyaT
         BKwQ==
X-Gm-Message-State: AOJu0YxqUAHS7n5xTvwPUdocGAu0ghiQfMZmjdVtWO7TfdkKD+auxyBf
        3WwKIZ9SLfEwgqQZ+FgXXphI3e56dlt7nGVC0xg=
X-Google-Smtp-Source: AGHT+IEdeG3rqm1nPbv+lFnddJa6jldymd4uGysEwA9huT/6yR6SSQkIa3NaWsfM8wQFBToxJRYPLQR/btv3VCqKrcc=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:adf:9d86:0:b0:32d:885e:a0fa with SMTP
 id p6-20020adf9d86000000b0032d885ea0famr21519wre.10.1697726438121; Thu, 19
 Oct 2023 07:40:38 -0700 (PDT)
Date:   Thu, 19 Oct 2023 14:40:21 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019144032.2943044-1-sebastianene@google.com>
Subject: [PATCH v2 00/11] arm64: ptdump: View the second stage page-tables
From:   Sebastian Ene <sebastianene@google.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, maz@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, vdonnefort@google.com, qperret@google.com,
        smostafa@google.com, Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This can be used as a debugging tool for dumping the second stage
page-tables under debugfs.

From the previous feedback I re-worked the series and added support for
guest page-tables dumping under VHE & nVHE configuration. I extended the
list of reviewers as I missed the interested parties in the first round. 

When CONFIG_NVHE_EL2_PTDUMP_DEBUGFS is enabled under pKVM environment,
ptdump registers the 'host_stage2_kernel_page_tables' entry with debugfs.
Guests are registering a file named '%u_guest_stage2_page_tables' when
they are created. 

This allows us to dump the host stage-2 page-tables with the following command:
cat /sys/kernel/debug/host_stage2_kernel_page_tables.

The output is showing the entries in the following format:
<IPA range> <size> <descriptor type> <access permissions> <mem_attributes>

The tool interprets the pKVM ownership annotation stored in the invalid
entries and dumps to the console the ownership information. To be able
to access the host stage-2 page-tables from the kernel, a new hypervisor
call was introduced which allows us to snapshot the page-tables in a host
provided buffer. The hypervisor call is hidden behind CONFIG_NVHE_EL2_DEBUG
as this should be used under debugging environment.

Link to the first version:
https://lore.kernel.org/all/20230927112517.2631674-1-sebastianene@google.com/

Changelog:
  v1 -> v2:
  * use the stage-2 pagetable walker for dumping descriptors instead of
    the one provided by ptdump.

  * support for guests pagetables dumping under VHE/nVHE non-protected

Thanks,


Sebastian Ene (11):
  KVM: arm64: Add snap shooting the host stage-2 pagetables
  arm64: ptdump: Use the mask from the state structure
  arm64: ptdump: Add the walker function to the ptdump info structure
  KVM: arm64: Move pagetable definitions to common header
  arm64: ptdump: Introduce stage-2 pagetables format description
  arm64: ptdump: Add hooks on debugfs file operations
  arm64: ptdump: Register a debugfs entry for the host stage-2
    page-tables
  arm64: ptdump: Parse the host stage-2 page-tables from the snapshot
  arm64: ptdump: Interpret memory attributes based on runtime
    configuration
  arm64: ptdump: Interpret pKVM ownership annotations
  arm64: ptdump: Add support for guest stage-2 pagetables dumping

 arch/arm64/include/asm/kvm_asm.h              |   1 +
 arch/arm64/include/asm/kvm_pgtable.h          |  85 +++
 arch/arm64/include/asm/ptdump.h               |  27 +-
 arch/arm64/kvm/Kconfig                        |  12 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   8 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  18 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 103 ++++
 arch/arm64/kvm/hyp/pgtable.c                  |  98 ++--
 arch/arm64/kvm/mmu.c                          |   3 +
 arch/arm64/mm/ptdump.c                        | 487 +++++++++++++++++-
 arch/arm64/mm/ptdump_debugfs.c                |  42 +-
 11 files changed, 822 insertions(+), 62 deletions(-)

-- 
2.42.0.655.g421f12c284-goog

