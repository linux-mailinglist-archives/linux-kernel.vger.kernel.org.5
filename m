Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C588878F21C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346525AbjHaRpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjHaRpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:45:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2B7CF3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:45:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5925f39aa5cso18594917b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693503946; x=1694108746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3TyP311oLDB7f/wd/rHD433Vsh3NwjwEGZRdFg/vh88=;
        b=Thxmxu1C8JFVK5VrYIqjaxelWIdoHBwPS70jgQTIskNlx++g7toeDDA4GEqyfu0aS3
         M6/wC7F+nBhMgxX7EaRL9+6TvwaK/sl1drrTBV9nnVfkdiHm7QvBlMKSbkfFsVfFyGz+
         68JteBxRE122Kg/kPOyYAeLOuB32LdCfcO8pOqkY7+yzlLpO5A1TP2f5vBJXnG/Ykvm2
         tGrtOn79H+MzhcIe/ELBYeZXOE8G5Bobl7hTee6p0R5AC+7l/D0l+OgsK4D9Wn10E7Pf
         U4QQIrr5VF10EqSySoW11r08MgKcw3MU5iAofoE1PYcbDEybxH3CEK/C8BuNduq/M08c
         Bahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693503946; x=1694108746;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3TyP311oLDB7f/wd/rHD433Vsh3NwjwEGZRdFg/vh88=;
        b=TSRGu1W/QAZrCb7Fbc98B0qEkhZGgfz3u8yNM+H9q3GbiQectD+MtIIX2Cy26UdQkq
         RV3AbSpYyBiMDk9c96dySXQ6HV4QUcGtjxprqYh3RnNz6M1Zx6C4xndK847eHpTttbpY
         z1YcYUTPkZy7/TQ+rFZs0ecQQYk4brwWRZOvD4wfe286feXNP+4APnrz5KbNw9ROH+Eg
         xVvztPjWWz/ebyu0JhFjcJshnHpLYsCpdriTvJjB4wtALOifEMT3IZ1O+jWO1O/mm2nV
         QdFuDOHroc7omgp13W1oZulw3ph84bD06jtUGbU6NkjiFND/qGIc9LNbC6e9v7hty/yv
         9ApA==
X-Gm-Message-State: AOJu0Yyb4Tu5uHhwwNCkA/EvhuQHmfBfJpuSuHqk0uhwmSgHkGjJ7UU1
        5FrzLhLoU2mmYA1oj8kb1cPh89FnoFnv
X-Google-Smtp-Source: AGHT+IGeekO0hDtnwCjLBcmgCPi6ukecPYF3K58dIbVBSkohSTIzFB3+CH2tmjGZTdJgAfpEPn5fhJtLWBLG
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:1a0a:7338:4a5a:5f83])
 (user=mshavit job=sendgmr) by 2002:a05:690c:e1a:b0:586:e91a:46c2 with SMTP id
 cp26-20020a05690c0e1a00b00586e91a46c2mr11312ywb.4.1693503946561; Thu, 31 Aug
 2023 10:45:46 -0700 (PDT)
Date:   Fri,  1 Sep 2023 01:44:29 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230831174536.103472-1-mshavit@google.com>
Subject: [PATCH v7 0/9] Refactor the SMMU's CD table ownership
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org,
        jgg@nvidia.com, nicolinc@nvidia.com,
        Michael Shavit <mshavit@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
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
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24742/15

Thanks,
Michael Shavit

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


base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
-- 
2.42.0.283.g2d96d420d3-goog

