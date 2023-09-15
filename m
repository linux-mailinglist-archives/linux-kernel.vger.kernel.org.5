Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1017A1FB4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbjIONVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjIONVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:21:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F631FFA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:20:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d816fa2404aso2625187276.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694784056; x=1695388856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZV+5obZZPjtyN99AFuK0kTrPuoWugweFSb+6lVpe7IA=;
        b=imk5spPSTvu2FQ+ZpKfz5uYNswl00oJk5DdHbXx0clEN+tu4mu+R4j0NTW6U/o2/Z2
         8gcLiXcKbEGzYdryyiL22TEpBvoqel5AcZjJ6H+AlqKzST/IfWPYelEKF9vKsxSAGzS0
         B4K5dJ+iqnBRsubPSqdAQ2ly7H7f8Mh9vxVlXTD27Os+J9w5GgzxyG+Tm/XZAhVY4dGm
         WkwGDL2SkteJvx6KGaaBla3ChJaFEDN9GfDOF5KLM4nxt3+BRjh0Cq9NLaWM7XZrQNNp
         MAUT06aa94FXBSMUTOqbjYKPTUqGWGP02K/yL/tn+eDi3j31jbsJfVr5lc8XvxEe7sK1
         9SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784056; x=1695388856;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZV+5obZZPjtyN99AFuK0kTrPuoWugweFSb+6lVpe7IA=;
        b=eSF7dhTvQ7dVQaUFzlET4AqfpWxoKlBd8QOaBsQQxJdPg32rirCK4HwpCUUt5qw0SR
         E90H0CAGsP8swKHa0T+9YevJYNOLWJqcRu7VkjikSp+iQ/JNSj1hmrW/clwXhuNPBXyj
         CEMtZEigeBOEGwcZZSiIIvZjWnNyKm6U60xbvp5q2WbqM0daeZxRJsKEWJWfhuyPgabS
         bH38jwaJbTIIziTK96YMDdt/Hf0UAQ7YmnUeJ9TFzUrt2TmljYSFuMHJG6sgodzBPCGy
         3WiJtSdF8F7h6l3UhrL/2k66cTFnTFYH/KnlXzCZoiGdkOkFlSslQNS2iPX/lqhPJsxQ
         +4mw==
X-Gm-Message-State: AOJu0Yyx/EWCE4N9MZgqvP3k6fCtgKIFTeOjLYvFYSjUZzXucxXUr/aM
        uOvq6dv7Apsz2g+JLYm8rceZXcJ4I4vU
X-Google-Smtp-Source: AGHT+IH7PahQke2KqAynkZD30WddmgZmHFr+fdpWBNhmiVjrvdceKOJzM3qP7QMkAywD+uGxh5HnE4b5IPYu
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:47bc:d53f:1c50:a3f2])
 (user=mshavit job=sendgmr) by 2002:a25:2903:0:b0:d7a:bfcf:2d7 with SMTP id
 p3-20020a252903000000b00d7abfcf02d7mr33173ybp.6.1694784056791; Fri, 15 Sep
 2023 06:20:56 -0700 (PDT)
Date:   Fri, 15 Sep 2023 21:17:31 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915132051.2646055-1-mshavit@google.com>
Subject: [PATCH v8 0/9] Refactor the SMMU's CD table ownership
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org,
        robin.murphy@arm.com, will@kernel.org,
        Michael Shavit <mshavit@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tomas Krcka <krckatom@amazon.de>
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

This series refactors stage 1 domains so that they describe a single CD
entry. These entries are now inserted into a CD table that is owned by
the arm_smmu_master instead of the domain.
This is conceptually cleaner and unblocks other features, such as
attaching domains with PASID (for unmanaged/dma domains).

This patch series was originally part of a larger patch series that
implemented the set_dev_pasid callback for non-SVA domains but is now
split into a distinct series.

This patch series is also available on gerrit with Jean's SMMU test
engine patches cherry-picked on top for testing:
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24742/16

Thanks,
Michael Shavit

Changes in v8:
- Rebased off of 6.6-rc1
- Drive-by update of the "Move ctx_desc out of s1_cfg" commit message to be less
  vague.
- Link to v7: https://lore.kernel.org/linux-iommu/20230831174536.103472-1-mshavit@google.com/

Changes in v7:
- Change the amr_smmu_write_ctx_desc_devices helper introduced to
  arm_smmu_update_ctx_desc_devices to distinguish from the case where
  a potentially new CD entry is written to. Add a comment to clarify
  that it is assumed that the operation can't fail and that it's
  therefore safe not to handle the return. In contrast, the case where a
  new CD entry is written-to does not use the helper and does have to
  handle failure.
- Update commit message to be more clear about locking purpose.
- Drop "Skip cd sync if CD table isn't active" commit, and remove
  related comment in the "Move CD table to arm_smmu_master patch.
- And some minor cosmetic changes based on v6 feedback.
- Link to v6: https://lore.kernel.org/all/20230816131925.2521220-1-mshavit@google.com/

Changes in v6:
- Undo removal of s1fmt and renaming of s1cdmax
- Unwind the loop in amr_smmu_write_ctx_desc_devices to NULL out the CD
  entries we succesfully wrote on failure.
- Add a comment clarifying the different usages of
  amr_smmu_write_ctx_desc_devices
- Grab the asid lock while writing the RID CD to prevent a race with
  SVA.
- Add the device to the devices list before writing the CD to the table
  and installing the CD table.
- Link to v5: https://lore.kernel.org/all/20230808171446.2187795-1-mshavit@google.com/

Changes in v5:
- Clear the 0th CD entry when the domain is detached. Not clearing it
  caused a bug in arm_smmu_write_ctx_desc which doesn't expect the entry
  to already be set.
- Added commit to clean-up now unused master parameter in
  arm_smmu_domain_finalise
- Link to v4: https://lore.kernel.org/all/20230802163328.2623773-1-mshavit@google.com/

Changes in v4:
- Added comment about the cd_table's dependency on the iommu core's
  group mutex.
- Narrowed the range of code for which the domain's init_mutex is held
  on attach since it now only protects the arm_smmu_domain_finalise
  call.
- Link to v3: https://lore.kernel.org/all/20230801183845.4026101-1-mshavit@google.com/

Changes in v3:
- Add a helper to write a CD to all masters that a domain is attached
  to.
- Fixed an issue where an arm_smmu_write_ctx_desc error return wasn't
  correctly handled by its caller.
- Link to v2: https://lore.kernel.org/all/20230731104833.800114-1-mshavit@google.com/

Changes in v2:
- Allocate CD table when it's first needed instead of on probe.
- Minor changes
- Added commit to rename remaining usages of cdcfg to cd_table
- Link to v1: https://lore.kernel.org/all/20230727182647.4106140-1-mshavit@google.com/#r

Changes in v1:
- Replace s1_cfg with arm_smmu_ctx_desc_cfg representing the CD table
- Assume that the CD table is owned by the SMMU master for most
  operations. This is forward-compatible with the nested patch series as
  these operations wouldn't be called when the installed CD table comes
  from nested domains.
- Split off as a distinct patch series from https://lore.kernel.org/all/20230621063825.268890-1-mshavit@google.com/

Michael Shavit (9):
  iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
  iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
  iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
  iommu/arm-smmu-v3: move stall_enabled to the cd table
  iommu/arm-smmu-v3: Refactor write_ctx_desc
  iommu/arm-smmu-v3: Move CD table to arm_smmu_master
  iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
  iommu/arm-smmu-v3: Update comment about STE liveness
  iommu/arm-smmu-v3: Rename cdcfg to cd_table

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  41 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 251 +++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  17 +-
 3 files changed, 166 insertions(+), 143 deletions(-)


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.42.0.459.ge4e396fd5e-goog

