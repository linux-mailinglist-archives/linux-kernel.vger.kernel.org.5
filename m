Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D215176E551
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbjHCKOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbjHCKOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:14:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C50C272E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:14:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5840614b13cso13813747b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691057643; x=1691662443;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fVgHMX1sr8AcQcx105vokEVgUIzKx0M+De6kyi4f2qE=;
        b=niZqGqYtr3p2xGfUmasZnjAPX/OeMRTw6aza5d9thhbKzKRn5xtIhhPsfN98IeD9AQ
         nq/pYNbt3XnGZLQGfnzlqvb/SxjxaCHe6Q93XBBw8LXkdlk14twmjVxXS/Kw90l9VWmj
         2lu7pMOhy+G9hJ85UuI1rG7VSwMJoYvZneZteBMhnFpfanEtugrvn1/fKGg2bgKzSKPJ
         VqE34s3jgXyaBxy5t0Nr+P/tqiYGaweLEcYLOL4ntzOiCRyh8LEtLhZkKkXiWkhzPdYx
         TRvssOHwpMK9bdLyPX2Y0Kg1bXpeVimpwCEzgCBbGobM6a2bebWJT+H6m/oHzjl7K2LJ
         tquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057643; x=1691662443;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fVgHMX1sr8AcQcx105vokEVgUIzKx0M+De6kyi4f2qE=;
        b=lQjU2tsbfmueQQthiDoJh1xOBycTfEiyooiEDVMARXbG2UwYM6x3RpIQl3tbqU3h9Y
         QiZUybrCBCUnjq1G1R0oXUXwWrLZ456OQbJns9rYT+MMJ+NOduZCm1l9ItMbiZ4XUfqx
         lnmiCXU2qRCPV6/q3MVi0jqVJnM/azvmDdVh9K/1kjeXxbvrjWBy4FPFtLki73inRqQc
         eP764Yf8kJMLtp5HIYVUAaUu1jQBaXP6w03k0ss6XUvmCk8tfP3wz2bBsQjwG9YugbcU
         cxuqb2n/0ctWyYwmQBqF0ijdSce/5K1/tMkguKplA8op5fZkouuedKOZsXKxioUywsHc
         ianA==
X-Gm-Message-State: ABy/qLZXkgyGomKxQjjO7yqH+ZifH/DvbRgL3VDA4W9/Vz6TOiRTxFoq
        5nE/Rn85pew7W9PpBCx0YJTQZxhqr8A4
X-Google-Smtp-Source: APBJJlE7K1GSQsi/VVVhGXbw+cVlEoPlz/1jiaXcsCJSXM0lTDGJSv6Hq6VtqV5ijgB/OdXi4eqaBHyIpx8i
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a81:788e:0:b0:57a:6019:62aa with SMTP id
 t136-20020a81788e000000b0057a601962aamr244992ywc.5.1691057642789; Thu, 03 Aug
 2023 03:14:02 -0700 (PDT)
Date:   Thu,  3 Aug 2023 18:12:20 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803101351.1561031-1-mshavit@google.com>
Subject: [PATCH v5 0/6] Add PASID support to SMMUv3 unmanaged domains
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     baolu.lu@linux.intel.com, will@kernel.org, jgg@nvidia.com,
        jean-philippe@linaro.org, robin.murphy@arm.com,
        nicolinc@nvidia.com, Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implements the set_dev_pasid operation for DMA and UNMANAGED
iommu domains. The series depends on the CD table refactor patch series as a
pre-requisite.

This patch series is also available on gerrit with Jean's SMMU test
engine patches cherry-picked along with an additional set of tests for
this feature: https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24770/6

Thanks,
Michael Shavit

Changes in v5:
- Renamed domain_head to list for consistency with other lists
- Renamed attached_domains to attached_ssids to avoid confusion. This is
  a list of master/ssid pairs the domain is attached to, not a list of
  other domains.
- Fix missing error value return in set_dev_pasid
- Fix issue where nr_attached_pasid_domains isn't updated when
  arm_smmu_write_ctx_desc fails
- Fix missing free of the attached_domain node
- Split off the CD table refactor to separate patch series: https://lore.kernel.org/all/20230802163328.2623773-1-mshavit@google.com/
- Link to v4: https://lore.kernel.org/all/20230621063825.268890-1-mshavit@google.com/
- New commit: Free attached pasid domains on release_device() call

Changes in v4:
- Fix build warning and error on patch 07. The error was introduced
  during a v1->v2 rebase and hidden by patch 09 which removed the
  offending line.
- Link to v3: https://lore.kernel.org/all/20230614154304.2860121-1-mshavit@google.com/

Changes in v3:
- Dropped the bulk of the SVA refactoring to re-work as a follow-up
  series.
- Reworded cover letter to omit dropped changes.
- Rebased on 6.4 tip
- Link to v2: https://lore.kernel.org/all/20230606120854.4170244-1-mshavit@google.com/

Changes in v2:
- Reworded cover letter and commits based on v1 feedback.
- Split and reworked `iommu/arm-smmu-v3: Move cdtable to arm_smmu_master`
- Added SVA clean-up and refactor.
- A few other small bug fixes and cosmetics.
- Link to v1: https://lore.kernel.org/all/20230510205054.2667898-1-mshavit@google.com/

Michael Shavit (6):
  iommu/arm-smmu-v3: Simplify arm_smmu_enable_ats
  iommu/arm-smmu-v3: Keep track of attached ssids
  iommu/arm-smmu-v3: Add helper for atc invalidation
  iommu/arm-smmu-v3: Implement set_dev_pasid
  iommu/arm-smmu-v3: Free pasid domains on iommu release
  iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  28 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 283 ++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  31 +-
 3 files changed, 267 insertions(+), 75 deletions(-)


base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
prerequisite-patch-id: c8d21ff19c2c1dd18799a6b83f483add654d187e
prerequisite-patch-id: bdeb88498393e7049fd22cfc24d2b7674e81bb85
prerequisite-patch-id: b84be729e187aa2d67a7f90ec396e2b878c76243
prerequisite-patch-id: 0ee7da8eaae46e2f8a0a791808f421025e148d79
prerequisite-patch-id: 2d80d99964059ecb31065ec4954130c817b9046c
prerequisite-patch-id: 49910462ec68b834c6af18ae9c58de25982e2752
prerequisite-patch-id: 1daf192523b0b7ed24a670b47ad07366aca6d26d
prerequisite-patch-id: 96101f0f4fd95cdb442cfe0881d80c3a61a93716
-- 
2.41.0.585.gd2178a4bd4-goog

