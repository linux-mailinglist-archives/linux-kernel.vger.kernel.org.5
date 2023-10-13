Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36287C853E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjJMMCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjJMMCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:02:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157C7181
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:02:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B202C433C9;
        Fri, 13 Oct 2023 12:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198530;
        bh=0q3ULsleNSG+Qgj9yUvTUCOAxNWyc2mBujTtoK7Xw6E=;
        h=Date:From:To:Cc:Subject:From;
        b=aTf+a/2ouWrbTA8PUoXwmI2tL3xdsJj/sMNkMNLsJgq53h3v7tOi65JwmbQBrGev3
         RyFpsh6HV1Hfpj/VWBe+PrtzoDpg22hxbjqbwmFCY9IukIKDKl1qijGto4h7BUmJVb
         ElNAIT6Leo9WfBVtCCieBJStxzawA5m4k4hgfO7H7/p3mL9tR/bftrKMEWQXAzz9X5
         UTrXU/T+wguJ2TYDQyYEuUs40MYnsb5sRyhDu9Kktlm8hS9lwe1cJKvKx7Z4WthCsK
         DrefVWjR0AshqwdPQ8ikWdnEU5UUtk3uk1CSDQX5iHtHOcqUww2xtA0K0V74IcFJXW
         hxMUCc5EsnxRA==
Date:   Fri, 13 Oct 2023 13:02:06 +0100
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 6.7
Message-ID: <20231013120205.GA13843@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please pull these Arm SMMU updates for 6.7. Usual summary in the tag,
but the bulk of this is refactoring to the way in which the SMMUv3
driver handles context descriptors in preparation for implementing the
'->set_dev_pasid()' operation for non-SVA domains. And of course there's
the obligatory DT updates for Qualcomm platforms.

Cheers,

Will

--->8

The following changes since commit d5afb4b47e13161b3f33904d45110f9e6463bad6:

  iommu/arm-smmu-v3: Fix soft lockup triggered by arm_smmu_mm_invalidate_range (2023-09-22 11:15:42 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to 548650921e617c7909c7f3229067e58ad3cb8088:

  Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates (2023-10-13 11:43:12 +0100)

----------------------------------------------------------------
Arm SMMU updates for 6.7

- Device-tree binding update:
  * Add qcom,sm7150-smmu-v2 for Adreno on SM7150 SoC

- SMMUv2:
  * Support for Qualcomm SDM670 (MDSS) and SM7150 SoCs

- SMMUv3:
  * Large refactoring of the context descriptor code to
    move the CD table into the master, paving the way
    for '->set_dev_pasid()' support on non-SVA domains

  * Minor cleanups to the SVA code

----------------------------------------------------------------
Danila Tikhonov (2):
      dt-bindings: arm-smmu: Add SM7150 GPU SMMUv2
      iommu/arm-smmu-qcom: Add SM7150 SMMUv2

Michael Shavit (11):
      iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
      iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
      iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
      iommu/arm-smmu-v3: move stall_enabled to the cd table
      iommu/arm-smmu-v3: Refactor write_ctx_desc
      iommu/arm-smmu-v3: Move CD table to arm_smmu_master
      iommu/arm-smmu-v3: Cleanup arm_smmu_domain_finalise
      iommu/arm-smmu-v3: Update comment about STE liveness
      iommu/arm-smmu-v3: Rename cdcfg to cd_table
      iommu/arm-smmu-v3-sva: Remove unused iommu_sva handle
      iommu/arm-smmu-v3-sva: Remove bond refcount

Richard Acayan (1):
      iommu/arm-smmu-qcom: Add SDM670 MDSS compatible

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates

 .../devicetree/bindings/iommu/arm,smmu.yaml        |   2 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  71 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 253 ++++++++++-----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  17 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   2 +
 5 files changed, 178 insertions(+), 167 deletions(-)
