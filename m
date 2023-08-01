Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA0576BC95
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjHASi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjHASix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:38:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC381B0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 11:38:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5840614b13cso1989357b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915132; x=1691519932;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZKmg+CBz4TGm3r8jvwoY5Ho1uNwN27lHQV4gjuCiVEY=;
        b=WN9JtxmSArmKBsGxfpIM9wVLy9+C6iQuScP8JgRAPyYIsjB1QhSS6REc4sx85JNdat
         wTqfJP8iKE7mtxK3C1609C1ha546DHUEqnB6DeVj5dqsenNNsYUxStXjncy6z283IYMV
         0kfuAiBZUiHireumid0OFqFQd7Rxr101ZuM1SgKNRGN7gaPKQZHtbCWZBgDfE/OL3MoS
         i7eAMbs6tLq6lTnlccfVNlptKum7sZixicEVJEBeg39vZbD0MlFVEhTNH0tYiBTtASu1
         AcMJwWH5Bkye55mOl9tFLnGJtx7EaJCssZj/tFp7CPU+tdMYIZ5vtuNk/VvOtBKwbk4w
         6m6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915132; x=1691519932;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKmg+CBz4TGm3r8jvwoY5Ho1uNwN27lHQV4gjuCiVEY=;
        b=QFe0thqrhkCBdJ1U991DnS0ak6oRGrw0zjnZLW8sr4oPkIJtIxCJSh6k2uVfSwbO4r
         AbWVH0ZDrsNzf8tqm53I7Tye47nukChH1lKzLc4w/m0qRbBc7qbAEs+BYrUUUTQdzfzI
         Dk0DqdNm+QvDvOkc69YEr+LMl9pf6tPWzRcN4fI0ypQ7nhhlbtr3o0+hzBZKa/BSvzDM
         qXolrIFnIrofwwf/vWtHFdwoxpggWojbG3voRSrb3Shnj1lGiZJbcky7UDKFonTlDCKX
         TKpHhpiTbykGzbfAVMiMgq/7+wRsixmdgoltxNt5g5+rY2ZeaXbWktUNHPxidDGN/n9D
         ugog==
X-Gm-Message-State: ABy/qLZ2bEMAsU90lMJh49PX2MVOPaZgZpiqLM9jrOWHM3ZqalsUaMQv
        wDpkEMFB5b8zMc2Z4sYf06fj7tB0rUNt
X-Google-Smtp-Source: APBJJlFDRod3DJ+lSa5o4srOuFHgar/AXipUr4WoI/zCNUj0ZKIooFMM936vlc3PkZZ94um3k1jNJWxotc0W
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a54:d53d:50e4:b5b8])
 (user=mshavit job=sendgmr) by 2002:a05:690c:3504:b0:57a:6bb:c027 with SMTP id
 fq4-20020a05690c350400b0057a06bbc027mr186493ywb.1.1690915132183; Tue, 01 Aug
 2023 11:38:52 -0700 (PDT)
Date:   Wed,  2 Aug 2023 02:35:17 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801183845.4026101-1-mshavit@google.com>
Subject: [PATCH v3 0/8] Refactor the SMMU's CD table ownership
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, will@kernel.org, jean-philippe@linaro.org,
        jgg@nvidia.com, nicolinc@nvidia.com,
        Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
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
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24742/3

Thanks,
Michael Shavit

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
- Link to v1: https://lore.kernel.org/all/20230727182647.4106140-1-mshavit@google.com/

Changes in v1:
- Replace s1_cfg with arm_smmu_ctx_desc_cfg representing the CD table
- Assume that the CD table is owned by the SMMU master for most
  operations. This is forward-compatible with the nested patch series as
  these operations wouldn't be called when the installed CD table comes
  from nested domains.
- Split off as a distinct patch series from https://lore.kernel.org/all/20230621063825.268890-1-mshavit@google.com/

Michael Shavit (8):
  iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
  iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
  iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
  iommu/arm-smmu-v3: move stall_enabled to the cd table
  iommu/arm-smmu-v3: Refactor write_ctx_desc
  iommu/arm-smmu-v3: Move CD table to arm_smmu_master
  iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
  iommu/arm-smmu-v3: Rename cdcfg to cd_table

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  33 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 217 ++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  21 +-
 3 files changed, 139 insertions(+), 132 deletions(-)


base-commit: 57012c57536f8814dec92e74197ee96c3498d24e
-- 
2.41.0.585.gd2178a4bd4-goog

