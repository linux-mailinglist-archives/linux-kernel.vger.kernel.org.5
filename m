Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF40277E263
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245445AbjHPNTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245447AbjHPNTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:19:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F53E52
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:19:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58c561f4ac3so21304737b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692191971; x=1692796771;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cFp68mVNc3zD0WpZGdDicdW6hVzQCXNZQbBR0zKXsLo=;
        b=Hi1romN5rhySt7t1khPi6B/g9cHisWG75w+xtAmc/6GQh5sQVP/7ezcz5rUK41jisg
         omDnuJB32WQZKOkIMEYw8GDIxGHujDUCGAYKfo2f8V4BRwUOr9VWKBtKY38/gI3dzfYn
         szaofXi4/nDcKsWlDqvfN+QoMz32cAs6NaOij+wnOU4LmtA0VQffSXQj/Tu1mQPLBWj8
         r9eIBpkOl3lhwNC//zQa+Ngx1nTsdekgRaLzhd9VW7JR3l4CKjGj5SicLIFsqu8QAwjo
         SnN+UOgrzRzR/bc/Mj5tc4dboCURc3BRPd7f3+F55HdewtpxPl7RRTsWIoctG41GQ7zF
         JBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692191971; x=1692796771;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cFp68mVNc3zD0WpZGdDicdW6hVzQCXNZQbBR0zKXsLo=;
        b=Edgf521o0BT7/tPtO2tn6BHbjyVFEy1EF34UV0CTVLKM5wQLT8QiaOEAMw5/f+YPPJ
         NRkPwS+Icig3z7tMGCTg/Mg6D5qQ/bjqxyPQBrlazwqthpIRjSidOhicsntcCA5y8TUz
         MeNmHW5RB2lCnyZ2aIrUfvwiOk00tA4WcBFF2//s5uqLIG55WIJGIniODCNfvTDIAjQd
         16mwcAWN9wzFm9qJ25D7pE22JWoCnMix3IbSxnZ2EKs9eKo8FIOCJefBLo4Sh4d1kqgM
         +Co+qvMX40mdXEtykTPw3TvGiY349Y95Hxc67FqiAc+Yhx+GBxX/wcDHoqWc9qysa/sB
         agWg==
X-Gm-Message-State: AOJu0YxMhGgeiVbtEnxEBrQMfWrHBlM3Voexzj0989IP19AeyJRZHoVv
        ugqtDuRxZw/Gw8zlHU+CIFnC9xvTDDZg
X-Google-Smtp-Source: AGHT+IFptDPVwuTKLjZZfmu+XC50egRaTONZ0DqUxp3ayBws3zvg5ys8Ai8bqzxd9fFitLfwCGXj+NLBCw2w
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:ae98:2006:2abd:3434])
 (user=mshavit job=sendgmr) by 2002:a81:4524:0:b0:58c:b8c4:2b4a with SMTP id
 s36-20020a814524000000b0058cb8c42b4amr21884ywa.4.1692191971662; Wed, 16 Aug
 2023 06:19:31 -0700 (PDT)
Date:   Wed, 16 Aug 2023 21:18:40 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816131925.2521220-1-mshavit@google.com>
Subject: [PATCH v6 00/10] Refactor the SMMU's CD table ownership
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, will@kernel.org, jean-philippe@linaro.org,
        jgg@nvidia.com, nicolinc@nvidia.com,
        Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24770/9

Thanks,
Michael Shavit

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
- Fix an issue where cd_table.installed wasn't correctly updated.
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
- Flip the cd_table.installed bit back off when table is detached
- re-order the commit later in the series since flipping the installed
  bit to off isn't obvious when the cd_table is still shared by multiple
  masters.
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

Michael Shavit (10):
  iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
  iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
  iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
  iommu/arm-smmu-v3: move stall_enabled to the cd table
  iommu/arm-smmu-v3: Refactor write_ctx_desc
  iommu/arm-smmu-v3: Move CD table to arm_smmu_master
  iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
  iommu/arm-smmu-v3: Update comment about STE liveness
  iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
  iommu/arm-smmu-v3: Rename cdcfg to cd_table

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  40 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 259 +++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  19 +-
 3 files changed, 176 insertions(+), 142 deletions(-)


base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
-- 
2.41.0.694.ge786442a9b-goog

