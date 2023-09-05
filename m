Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAC9792A60
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbjIEQfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354460AbjIELun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:50:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8770E1AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 04:50:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d745094c496so2017927276.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693914638; x=1694519438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SzB7/p5kiVgqDZadgU1A1MlN/VGpPTK51C1Zm9U7VD8=;
        b=47m+SJUpLPTFbrT8QGb7+ZjNOpkAJrH2lfiwzDiuc+w7Dtuct6wEBD7ArccUQ7Q59C
         SLF7TrAQCzc7lRcKtUw21YCeqcb6/KWuwBIjePrV4dTjVE5ITnz9wOYZ2UHscaCpb6nw
         LE3adwx5vINKk4H7uSsoObPQExugKOwt/jCEdaR0CMu4l3YIpU3XFqIkIxW3N++NOajn
         AgU7uAntthvWvIPDmPG9V/YAoZntRtkrUjkWoXIs/pgb+Ynl7gLwRPoc4yjiFe/dfjn7
         gMfJ433qil46be/RmK/VXFDLh91ySrwHFeC5Nfb4p9oV5PrVxZ7KE2RlFVkTYxHGcVXq
         EAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693914638; x=1694519438;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SzB7/p5kiVgqDZadgU1A1MlN/VGpPTK51C1Zm9U7VD8=;
        b=GtogY6LQSo5JS64dvtY6VcxZx7qICm5uc1HelJgp//mqEZYfAL1n1w5HznU/k70qkS
         FD1hYffXYCx9rpNpN9GYuWi0vIDrhIS/4iQId86CBrojvz4BEVjeu/4a7f5oqcXAf36h
         nM2KutzkA0c+77d7aCQ4ZrKqBlZGaRWO9akiun7tBwAfFm8Dd3Fu+nLXsb1DZGzfXtfp
         T6lkGTS2tQk61Tm6WlxB1KFMLUZoCioQF+/1I6CRfTB5Nd8m/vL9DBsCeKyzUxND9Gy/
         rF9PSlfHZc/zIUweLsgqbHhcwBV5ZcLkkSrouNXKlCv6+Vtx6NWaH4tdprgr/WEhvZSW
         84mA==
X-Gm-Message-State: AOJu0YxBZwTF6+YJRKiSVOKiOPJJe3fiQyMVlC56ka0a1cBP3YN3p1JY
        w+C0ZHdT1ugDugHqZhHZrE4e9HG6fluu
X-Google-Smtp-Source: AGHT+IHnCMAXRadb7D/VG+uuqzw6rDCLizjl0eoGPjlSpcOcMPhC2fjWoy8tcBS4IofcN1BaFhx2zvF7ED8E
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c4a8:fdce:d8d3:7b02])
 (user=mshavit job=sendgmr) by 2002:a25:2543:0:b0:d4d:8ade:4dfa with SMTP id
 l64-20020a252543000000b00d4d8ade4dfamr331712ybl.1.1693914638742; Tue, 05 Sep
 2023 04:50:38 -0700 (PDT)
Date:   Tue,  5 Sep 2023 19:49:11 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230905115013.1572240-1-mshavit@google.com>
Subject: [PATCH v1 0/3] Clean-up arm-smmu-v3-sva.c: remove arm_smmu_bond
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com,
        jean-philippe@linaro.org, jgg@nvidia.com, tina.zhang@intel.com,
        Michael Shavit <mshavit@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Tomas Krcka <krckatom@amazon.de>,
        Yicong Yang <yangyicong@hisilicon.com>
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


This small series was originally part of a larger effort to support
set_dev_pasid in arm-smmu-v3.c and a related SVA refactoring. But it can
also stand on its own as an initial and prepatory clean-up.

The crux of this series relies on the observation that SVA won't
allocate multiple SVA domains for the same device and mm pair. There's
therefore no reason for the driver to try to normalize data allocated
for a device/mm pair across set_dev_pasid calls. This simplification
then allows set_dev_pasid to use the SVA iommu_domain to hold
information instead of allocating a "bond" to represent the attachement.
Note that long term, we'll likely want to represent the SVA domain using
the same arm_smmu_domain struct used in arm-smmu-v3. This series serves
as an interim step to make those later refactors easier to reason about.

Note that arm-smmu-v3-sva performs a second level of normalization by
mapping multiple bonds (now SVA domains) attached to devices with the
same SMMU (if those devices have the same RID domain attached) to a
single arm_smmu_mmu_notifier. This is not affected by these patches.


Michael Shavit (3):
  iommu/arm-smmu-v3-sva: Remove unused iommu_sva handle
  iommu/arm-smmu-v3-sva: Remove bond refcount
  iommu/arm-smmu-v3-sva: Remove arm_smmu_bond

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 90 ++++++-------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
 3 files changed, 28 insertions(+), 65 deletions(-)


base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
-- 
2.42.0.283.g2d96d420d3-goog

