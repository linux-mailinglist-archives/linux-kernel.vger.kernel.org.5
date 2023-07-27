Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E3B765B54
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjG0S2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjG0S2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:28:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DFD26B2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:28:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-584375eacacso13072487b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690482483; x=1691087283;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LdqBlA80Wg7TTifhsmcWRJBqXp5WhnKqMSkVfyET1zg=;
        b=2ORqFkA2f3Z9uBQcEXJuPsfPoD3pbCZzEg9K5vjpSb+ANKuVree8tmQXRURnLx56ld
         kaGAjGT3BxZrdF3VUT+aDQokKYfTI8kUwreH2Ab+JrMFGHHJcKLVDG2OXYPZ3VLXA/Fv
         6stescGuyXhxkUxbS5ZRNT907yR2cFGVnzi34CqfJbBZ2Z+D5sawwHlSDSnFU104J90i
         glA8cm4ApX4r3QoQCorCX6/v+SGlMnEfQVVz+ZVvLaIBZSFCBwZ0nBPt7llVhUy8I30v
         wq5c/3NJErPcbxT2Qp0L2yDOnvEnZGEV87lSNUYeBc0TkL8RMv3mWzLs08LIc7xWbRRW
         ya0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690482483; x=1691087283;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LdqBlA80Wg7TTifhsmcWRJBqXp5WhnKqMSkVfyET1zg=;
        b=UeOpQQ93+iycItHxWIq1wTocRg+nD/uYCK83W706vx30Uhuzd5vfm40qwZtWkUosw/
         AWR7tYU4Za1eT6vda9pVWazk44NRBAIVRBNg2TCCp6dK+qBWNoGyTcxZi+zWghKQ8l5G
         mR1q9FKBqC5+T4xJeTT/wjULV3I1cpf71lknbNrPnLEXEc0ZZAM+kFp25hPgtWNd2Oq/
         l837prZFYt4mqETGCsekhHingkpj/qOWb7Ljqj5CTJj6yugzQ8/9lL6qUhpdLIeNAfA2
         1Zfl4OwmG73oXSvxE0V7Tt5q/YCtEO6ApBTLzCZAbQ7pGo2DXjy7qv/7Xmduz3QE7ZbT
         QAhg==
X-Gm-Message-State: ABy/qLZHjB9a16eWobKKm9i6/F8f8O81FamFEpkzew3YCPLgWpnmtuZF
        rG8DCGgrF1GvcjDB9NfS9YK1m42bcqvX
X-Google-Smtp-Source: APBJJlFu1RmIM9I2XbdYtCItJzT1I4AJtth2QNNJiNYVh4Yo5EZk+wFwLwBJ0TaQyZTQq3wAjZaAjFpkxTME
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:780f:26da:d952:3463])
 (user=mshavit job=sendgmr) by 2002:a05:690c:72c:b0:576:cd91:b888 with SMTP id
 bt12-20020a05690c072c00b00576cd91b888mr805ywb.0.1690482483158; Thu, 27 Jul
 2023 11:28:03 -0700 (PDT)
Date:   Fri, 28 Jul 2023 02:26:16 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230727182647.4106140-1-mshavit@google.com>
Subject: [PATCH v1 0/7] Refactor the SMMU's CD table ownership
From:   Michael Shavit <mshavit@google.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
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
https://linux-review.git.corp.google.com/c/linux/kernel/git/torvalds/linux/+/24729

Thanks,
Michael Shavit

Changelog
v1:
* Replace s1_cfg with arm_smmu_ctx_desc_cfg representing the CD table
* Assume that the CD table is owned by the SMMU master for most
  operations. This is forward-compatible with the nested patch series as
  these operations wouldn't be called when the installed CD table comes
  from nested domains.
* Split off as a distinct patch series Split-off from:
https://lore.kernel.org/all/20230621063825.268890-1-mshavit@google.com/

Michael Shavit (7):
  iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
  iommu/arm-smmu-v3: Replace s1_cfg with ctx_desc_cfg
  iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
  iommu/arm-smmu-v3: move stall_enabled to the cd table
  iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
  iommu/arm-smmu-v3: Refactor write_ctx_desc
  iommu/arm-smmu-v3: Move CD table to arm_smmu_master

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  35 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 167 ++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  39 ++--
 3 files changed, 123 insertions(+), 118 deletions(-)


base-commit: 0a8db05b571ad5b8d5c8774a004c0424260a90bd
-- 
2.41.0.585.gd2178a4bd4-goog

