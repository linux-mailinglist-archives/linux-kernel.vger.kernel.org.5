Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C64792655
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345817AbjIEQVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354462AbjIELuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:50:52 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4FD1AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 04:50:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5925f39aa5cso39146447b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 04:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693914647; x=1694519447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kiLWhPR0jjr+cIjF17/kc7vpb8l797DMDN7j160OqHY=;
        b=4p4KPY7Mg+JEoOF4tMA1/5PuaNdWUIsHz4tJKxO/1uYvCuUmBd5ip425soJntDVxVB
         NbGhUfJyCIOPj+QgR0oUi/JyrC2+txTCVq80QROLzMW3Z9M9Q4TNfnAcDQF7GnMp+D4g
         ZsxupNtRzsq6zdVeAgckvdB/wjN7Ug2yEgSsTVuPpLWeeNkT9VVmZATRoR6WQK7q8Bn+
         MOxbpIFIufObm/ZBneS7QutPwLDPWgIpvA61R+Xlk4c/oK3RD/+vfsZve9X0jXOjPasg
         s2Ss1KwiKlIIIzPE4kr0xwsISSiYN7Z8SAwG9xWOfff5YAoUMFlBQGXuHtBCuHu32lbh
         pX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693914647; x=1694519447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kiLWhPR0jjr+cIjF17/kc7vpb8l797DMDN7j160OqHY=;
        b=XbaycVkzYUVqeH4SM2GTBdXi3PlarF0ahpT/n7rAtQV1BFNxoyvogEw04zScYtGrfG
         NuykNdFQ7G09CH1tZrmVTUr616QO2f9VsqCAAn2aop1AP/8o7ZNv4rkw8EV7qZSrC53V
         gFQH83ZNJE8EA3ky/9A2abwRKR+kiSPU4hkzgqZ7wdQfRQR8FkKYrURaMt423vzKVFQH
         0/uQ3ttdszkAjpPIcdDboxwTSXLrylBX3Dr/YGMyIhI+2uVIpqUuej2Js0djGy7QZDrq
         LSqHtqzXmYmLUsnzNW+uNbJhwRj3+B9jHaSMvZsUe5PIAsObDzEIYS+zq4oInJAcJHgi
         /stg==
X-Gm-Message-State: AOJu0YzVX7ZxIaxW6Kp91talOg5HNJdSe4zl2j6I+ktsARHguJmRc+8R
        GR6nXPY0cvmYpq8swNVEZ9tf2DVqtm9A
X-Google-Smtp-Source: AGHT+IGymTxyTPXDcoYXyE6qZoihZHB7S/W+Yq4eYVfv8eLSmaPP4Buo5WAaDyqII2ZPuy1FBGzp51eq/fFg
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c4a8:fdce:d8d3:7b02])
 (user=mshavit job=sendgmr) by 2002:a05:690c:2b8b:b0:594:f596:e232 with SMTP
 id en11-20020a05690c2b8b00b00594f596e232mr325586ywb.2.1693914647753; Tue, 05
 Sep 2023 04:50:47 -0700 (PDT)
Date:   Tue,  5 Sep 2023 19:49:13 +0800
In-Reply-To: <20230905115013.1572240-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230905115013.1572240-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230905194849.v1.2.Id3ab7cf665bcead097654937233a645722a4cce3@changeid>
Subject: [PATCH v1 2/3] iommu/arm-smmu-v3-sva: Remove bond refcount
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

Always allocate a new arm_smmu_bond in __arm_smmu_sva_bind and remove
the bond refcount since arm_smmu_bond can never be shared across calls
to __arm_smmu_sva_bind.

The iommu framework will not allocate multiple SVA domains for the same
(device/mm) pair, nor will it call set_dev_pasid for a device if a
domain is already attached on the given pasid. There's also a one-to-one
mapping between MM and PASID. __arm_smmu_sva_bind is therefore never
called with the same (device/mm) pair, and so there's no reason to try
and normalize allocations of the arm_smmu_bond struct for a (device/mm)
pair across set_dev_pasid.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
Note that this is true today because iommu_sva_bind_device calls
iommu_get_domain_for_dev_pasid to elude the iommu_attach_device_pasid if
a domain is already attached.
But even with Tina's patch series where iommu_get_domain_for_dev_pasid
is no longer used, iommu_attach_device_pasid also checks whether a
domain is already attached in the group's pasid_array.

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 32784758ccce6..9fb6907c5e7d4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -28,7 +28,6 @@ struct arm_smmu_bond {
 	struct mm_struct		*mm;
 	struct arm_smmu_mmu_notifier	*smmu_mn;
 	struct list_head		list;
-	refcount_t			refs;
 };
 
 #define sva_to_bond(handle) \
@@ -330,20 +329,11 @@ static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	if (!master || !master->sva_enabled)
 		return -ENODEV;
 
-	/* If bind() was already called for this {dev, mm} pair, reuse it. */
-	list_for_each_entry(bond, &master->bonds, list) {
-		if (bond->mm == mm) {
-			refcount_inc(&bond->refs);
-			return &bond->sva;
-		}
-	}
-
 	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
 	if (!bond)
 		return -ENOMEM;
 
 	bond->mm = mm;
-	refcount_set(&bond->refs, 1);
 
 	bond->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain, mm);
 	if (IS_ERR(bond->smmu_mn)) {
@@ -522,7 +512,7 @@ void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 		}
 	}
 
-	if (!WARN_ON(!bond) && refcount_dec_and_test(&bond->refs)) {
+	if (!WARN_ON(!bond)) {
 		list_del(&bond->list);
 		arm_smmu_mmu_notifier_put(bond->smmu_mn);
 		kfree(bond);
-- 
2.42.0.283.g2d96d420d3-goog

