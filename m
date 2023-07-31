Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE3C76936D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjGaKtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjGaKso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:48:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148AB10CC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:48:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d061f324d64so4570354276.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690800522; x=1691405322;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MYD4KNk4I+aUCQIcFZ3n5/B+CXfxdz6VfnyKCw5fMRU=;
        b=0Jg1PJ+2Ms0SpImThAW1EMWAb2V0CT6cMZnANaGZF2LzzafL1BQJ6iWEjbVQHZyy4L
         J3xsZJOY4jXTy3SLnVtdiwKFv+0OfCVLR6D+t+5Tt+WGqib+Hcvl+m9yW0mgIk/5zI01
         ssSeQZGchb+HTawL1Y6Mm2dAcgXazGHrPWQs8v7nB82VonT9y8Mdh7s4A6z8boRiYvuv
         +IZDxY+VITXRjOeNgZxP+kAqStou6n8VgrksNelRVXISPTQyiCc6No6OHUlriiIO5Jjb
         VIyGQy00sBFZxEc1L30uG45g2U7cyMSwfNWMPvzZhQCJn3Hc5yVv2IdbAF6Lr1Np3I6b
         HnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800522; x=1691405322;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MYD4KNk4I+aUCQIcFZ3n5/B+CXfxdz6VfnyKCw5fMRU=;
        b=ZL0THZEdka5QbmERq60RzujcYJlpK8056HELEM0tCgRvsVwyrxGXBfeYC/gwsQlH8S
         ZsaKLZJmSLDO8WnPDQGe4wtmIrlrP/U5+KuvdGR7sG3R1xaE38mwQ424Gk/p9D+wV/A5
         ueJ9sqHBwcfzF6mY2sR6LR/d6tMPrF+NqZW6bebJKclq4ax988Qdnv+m7O/3gCm2kHlC
         ptso7rf58npylG7oW/MJcFH3ZOGm+k081PKxzi5wi/Q3KyOPj0sklGw0Rc1vzQSAMEfj
         KRx7moDSKbHXrJ+YKtJDerCLiPzRG6m3EGN0MztdmYUe5JpedorTCUlWbNXpG//YDUO4
         7jnw==
X-Gm-Message-State: ABy/qLZHnYy4IEJ5HRQrRiGNYxkOLOOcMBers4/vGtF2HBBC9Cv/ClvS
        hb4OdknMfWUnnJgH+6Qj9ZmHXbkX4bkb
X-Google-Smtp-Source: APBJJlET//ltWfSVaehdcwXyhhFbnIFncdpcb/9IJF01FhUX4aphRs5zX2WZ71v/0k8Wy9HtIpTSfZkGPHRc
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:affc:ad1d:5cbb:3c6a])
 (user=mshavit job=sendgmr) by 2002:a25:7493:0:b0:d09:17f2:d3b0 with SMTP id
 p141-20020a257493000000b00d0917f2d3b0mr53114ybc.9.1690800521971; Mon, 31 Jul
 2023 03:48:41 -0700 (PDT)
Date:   Mon, 31 Jul 2023 18:48:10 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230731104833.800114-1-mshavit@google.com>
Subject: [PATCH v2 0/8] Refactor the SMMU's CD table ownership
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com,
        jgg@nvidia.com, jean-philippe@linaro.org,
        Michael Shavit <mshavit@google.com>
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
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/24742/1

Thanks,
Michael Shavit

Changes in v2:
- Allocate CD table when it's first needed instead of on probe.
- Minor changes
- Added commit to rename remaining usages of cdcfg to cd_table

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
  iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
  iommu/arm-smmu-v3: Refactor write_ctx_desc
  iommu/arm-smmu-v3: Move CD table to arm_smmu_master
  iommu/arm-smmu-v3: Rename cdcfg to cd_table

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  35 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 219 ++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  21 +-
 3 files changed, 142 insertions(+), 133 deletions(-)


base-commit: 57012c57536f8814dec92e74197ee96c3498d24e
-- 
2.41.0.585.gd2178a4bd4-goog

