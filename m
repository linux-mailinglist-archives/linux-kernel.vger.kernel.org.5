Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C53783E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjHVK5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjHVK5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:57:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADD7196
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:57:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7494be34f8so3034606276.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692701865; x=1693306665;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yaIwxFy9mjgti4zQ5aoiFMHcHMhpN0UMC2eNirEVgXw=;
        b=U+QLIzfY85x7N5zJe55CYeVHa7UA1i+UczMg9dvYKujxPDNarCECMejcMxSLbPpNtF
         kfNPsaorMLHV6QSsWX4k1hHPDIK+6lZwcXKoxgiQmhQ5pkiOyE+rZ96LyYZImVi0KHlR
         07Kzd3d+99w+4X64z0/wt61ExkCswDlRf6KK2aosHRwbKHoueV1Fd/BhD9cKK/FK8enX
         rwWUDfiRRKxVWQzOaTReSWOqZaaAjSSKnQUTrFwJ3Eb1wG3aSMIlcJYB0icM5qgYsnEr
         e/Bnna+Rba0XEju0E6lsUmNppvsfWkoB2CbgwxjV6ZbXDbri1uTuFMQOdXdBChlCmxBV
         Q04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692701865; x=1693306665;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yaIwxFy9mjgti4zQ5aoiFMHcHMhpN0UMC2eNirEVgXw=;
        b=DLRmlkNHPVp6QbcuCPI+Zr6cVBh8+qWHlY7h34nHOh0EBrKVge7vH0WNvYhRvKyXf5
         Nl5AmO2hCS6JrxtDajZPpz30GsaJlAtzPNKVkt2P75FiTQfYEYdAZypPOC2aptrE73E7
         HRLVvkzZF1QT4pVVh+6U8A9Bm+URKACDWk5vnw232TgIWS2j5Haf47W9PwAjrSg9Oq4j
         Y+fNKtGcbhMYg5NB0giZPY1qFCOBv+nL8HHlQNEgIS3nBXwkc82rvviDhlzVbsqezX8J
         fapiuZUv/Pg2bl78z4wn0u7iJvyK/6RjaSCMdksgxBmSoXK1M0v2caAG7auDUGb8v5gl
         6//w==
X-Gm-Message-State: AOJu0YxZ8go7HGFjSpwexBG1GTHlNLnFqIL6C5Rf8JlFfGkNIHC76w+b
        A86DOKB0mIsaE6A4vLfGc8IudBzhExOz
X-Google-Smtp-Source: AGHT+IE2hoZFp+1ccggEqlGvc9+61aaUJAGlZBTA9JoRO68qaIvofVbP/HhsQ2nzuG0YqKQPJfEEdWb0DB20
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:44ad:3968:8aaa:c4fe])
 (user=mshavit job=sendgmr) by 2002:a05:6902:1141:b0:d58:6cea:84de with SMTP
 id p1-20020a056902114100b00d586cea84demr113941ybu.11.1692701865015; Tue, 22
 Aug 2023 03:57:45 -0700 (PDT)
Date:   Tue, 22 Aug 2023 18:56:56 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230822105738.1607365-1-mshavit@google.com>
Subject: [RFC PATCH v2 0/9] Install domain onto multiple smmus
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     nicolinc@nvidia.com, tina.zhang@intel.com,
        jean-philippe@linaro.org, will@kernel.org, robin.murphy@arm.com,
        jgg@nvidia.com, Michael Shavit <mshavit@google.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
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


Hi all,

This series refactors the arm-smmu-v3 driver to support attaching
domains onto masters belonging to different smmu devices.

The main objective of this series is allow further refactorings of
arm-smmu-v3-sva. Specifically, we'd like to reach the state where:
1. A single SVA domain is allocated per MM/ASID
2. arm-smmu-v3-sva's set_dev_pasid implementation directly attaches that
   SVA domain to different masters, regardless of whether those masters
   belong to different smmus.

If armm-smmu-v3-sva is handed iommu_domains that have a 1:1 relationship
with an MM struct, then it won't have to share a CD with multiple
domains (or arm_smmu_mmu_notifiers). But to get there, the arm-smmu-v3
driver must first support domains installed on multiple SMMU devices.

This series depends on the CD table ownership refactor: https://lore.kernel.org/all/20230816131925.2521220-1-mshavit@google.com/
as well as the VMID IDA patch: https://lore.kernel.org/all/169087904450.1290857.11726985177314533259.b4-ty@kernel.org/#r

Thanks,
Michael Shavit

Changes in v2:
- Moved the ARM_SMMU_FEAT_BTM changes into a new prepatory commit
- Access the pgtbl_cfg from the pgtable_ops instead of storing a copy in
  the arm_smmu_domain.
- Remove arm_smmu_installed_smmu structure, instead grouping masters
  attached to the same SMMU together in the smmu_domain->devices list.
- Add a parameter to arm_smmu_tlb_inv_range_asid to make skipping of BTM
  capable devices explicit.
- Moved VMID allocator to a global allocator instead of per-SMMU
- Link to v1: https://lore.kernel.org/all/20230817182055.1770180-1-mshavit@google.com/

Michael Shavit (9):
  iommu/arm-smmu-v3: group attached devices by smmu
  iommu/arm-smmu-v3-sva: Move SVA optimization into
    arm_smmu_tlb_inv_range_asid
  iommu/arm-smmu-v3: Issue invalidations commands to multiple SMMUs
  iommu/arm-smmu-v3-sva: Allocate new ASID from installed_smmus
  iommu/arm-smmu-v3: Alloc vmid from global pool
  iommu/arm-smmu-v3: check smmu compatibility on attach
  iommu/arm-smmu-v3: Add arm_smmu_device as a parameter to
    domain_finalise
  iommu/arm-smmu-v3: check for domain initialization using pgtbl_ops
  iommu/arm-smmu-v3: allow multi-SMMU domain installs.

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  34 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 277 +++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   7 +-
 3 files changed, 237 insertions(+), 81 deletions(-)


base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
prerequisite-patch-id: f701e5ac2cce085366342edff287a35d1cb82b9c
prerequisite-patch-id: c8d21ff19c2c1dd18799a6b83f483add654d187e
prerequisite-patch-id: 6ebba95cb12a723645843b4bd1bc45c94779d853
prerequisite-patch-id: 3f767e1c37d2996323c4f6d2a2d1912ab75281f7
prerequisite-patch-id: 5a4109fa3e22e2399ad064951c2ca1aeba4a68f7
prerequisite-patch-id: c4b3bd34b8be7afebd3e44bc4ec218d74753ce77
prerequisite-patch-id: 6d89e53518d25ac983ac99786950ee1a558c271f
prerequisite-patch-id: 447219e565cadc34b03db05dad58d8e5c4b5a382
prerequisite-patch-id: 63adb2c3f97d4948d96a0d5960184f5ac814d7f7
prerequisite-patch-id: e71195fcf1aa56d8ef9d7403b9e4492c17b8fb84
prerequisite-patch-id: ba82add44850bf8fb271292020edb746aef93a65
-- 
2.42.0.rc1.204.g551eb34607-goog

