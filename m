Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A38774AD6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbjHHUgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjHHUfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:35:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE03165060
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:14:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58419550c3aso53884657b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691514896; x=1692119696;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aqkrOktIR1lETMTWBm5xIeJf9PjPMAED8VAbt11S0ko=;
        b=BjxXsVQyq6Kk7NLHxPXlJbIvmoLKGSzDyrShyA9qqwn54c59rPrH7AFMhL3vdhmF4Z
         +sB/FGUncUE2UOvlXj3gD8siD3LAaqDGz8TAupKaqIx9lBAgrtHCjc5BeByGnQdycknS
         p88EnfxIHxRaqwGPZheoLXnSbF5J7w76/2LzDJ4zGt+hQzh48vbcWarMqC03lnHX3CcK
         +1+KNwRzb/DtolH7b2Vh0mVTZxFFQPcnx3LotvA/zGxjxsrXgHkTEj2AyY2XIGM1EPT6
         tGx3Rk+qP3m7LYdH65s2GPxaiq6425qBuITd0q4sP0dgJxDN4bQuC49+my6ckvIcJEQ4
         k4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514896; x=1692119696;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqkrOktIR1lETMTWBm5xIeJf9PjPMAED8VAbt11S0ko=;
        b=aImACnCOgzZlRC6/eoYGMFcFyUn+Fs8hgp34ZG8LHaTuJFm+xh4p/chCm1RLn0oY0X
         8ZYWUNm0XrDU3oTyGykBc1gZ0l7+ZUBVkQYufYF/ZZSny7LMRQHY6BtshCj+MnBLKp1v
         DxK89fGN/eq8k64rW816x3Eow7zMSQ+wAFddwAfqXisJwKo56IZj+tX+i6qrQN7waNts
         hAUw2pSlObq/h8kggOMb8Lqn54yS2B9g0BTChtvKIRPuD9fSNpxx/p4E+2RtidFWxHVs
         sBYspMBeH4Z58G3xcb54UrsxtGY1rTsBAGY5Nr68ADTrAtVy9tADDspJ0prp2q/AVRa3
         2Odg==
X-Gm-Message-State: AOJu0Yw1Pezcf15W7NqHTpRItjJe9wK+GP64dgpXtu5EIQqldC1cPrDA
        oLzgrH7c1UFkPUzFPFu6ykDMeUsT62/Z
X-Google-Smtp-Source: AGHT+IHTdnoNRIRWWu8AlkQ0wSc0RDHpXiBAyp6iP3lVobNNN6cJwX8hzYT6lhshrprEzNrxkfmKQGmpHiBW
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:986a:71d7:3b1e:ac1d])
 (user=mshavit job=sendgmr) by 2002:a81:ad4e:0:b0:576:8cb6:62a9 with SMTP id
 l14-20020a81ad4e000000b005768cb662a9mr4750ywk.6.1691514895956; Tue, 08 Aug
 2023 10:14:55 -0700 (PDT)
Date:   Wed,  9 Aug 2023 01:11:56 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230808171446.2187795-1-mshavit@google.com>
Subject: [PATCH v5 0/9] Refactor the SMMU's CD table ownership
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com,
        jgg@nvidia.com, jean-philippe@linaro.org,
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
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24742/8

Thanks,
Michael Shavit

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

Michael Shavit (9):
  iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
  iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
  iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
  iommu/arm-smmu-v3: move stall_enabled to the cd table
  iommu/arm-smmu-v3: Refactor write_ctx_desc
  iommu/arm-smmu-v3: Move CD table to arm_smmu_master
  iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
  iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
  iommu/arm-smmu-v3: Rename cdcfg to cd_table

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  33 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 255 +++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  22 +-
 3 files changed, 161 insertions(+), 149 deletions(-)


base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
-- 
2.41.0.640.ga95def55d0-goog

