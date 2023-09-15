Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647127A1FBC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjIONWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbjIONWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:22:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD212729
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:21:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8153284d6eso2590786276.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694784094; x=1695388894; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HnObA/kZmhyC99jO+R9W14le1Eiuc2fMp54pXjmpHL4=;
        b=AnDhXPCmr8wwhBU+uUt/0IRBv/P9goCEfChRnROO0HJs2vpUsHQ/z/m7G2GZcPSJTe
         m9/In2YkLUk7nkzW1m9w24Iq2MgV/5VWG80TwvEGmSXk9UybXDo9cqokwu/M3LitLvik
         nh9QRnvtUxnAkBR5m4IOO8K9PfalCd1KRoszjmTw1YfiuvACOG/xrRmpk39wmAWE8fFe
         c3wbmTTdRkCISaFrBmSihlMPP9exE/Wim1rAOdmP3a76P697xQRNZEGPh8kHUmC9YcBk
         HFzqmtCvtjeGQTAFUNMgZO4UoLBMK0YxLF22+vcFldGYyHx34V3BQxlWK3c1ziRNlNdJ
         0Tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784094; x=1695388894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HnObA/kZmhyC99jO+R9W14le1Eiuc2fMp54pXjmpHL4=;
        b=vtKoydfJa0T7CdhTH+s+MtzWufDDeIq8gUxuzZ4U9cyyqTr5LCY0s3S3trCjSnrcJQ
         YslOnB3X+zfJMW9zu88wthAIfqldqrsjE4GCGKKmYlAHoknBMGqk45xtkjRtrJguw8YP
         8dWQwkBaRTytyDBaZwcouW3EfmejDuYIjCl5gb0xxkaT4NkoH4IcmU6XVjjLLx6r69ju
         P0b/aLOVWsBqKCib+ZjvrLFbs2V1w5/2hqVzSx/zt4/07gk8ILjr1P5RQma7rVxW+awW
         jUTM2SWwDsBHGhTBtmHuTbJsrRBSmCfek4CUSwAhAX0QnIGuF6eSJM97bT6lQi/0sXXf
         CRtg==
X-Gm-Message-State: AOJu0Yyd5o1lOzXQPnYyDqftTb2SnltIV4S2BtlAXfX94Wwjy/AxARmM
        aC8rEqtX7DyFT9GIkmuID/miZE6W9Frc
X-Google-Smtp-Source: AGHT+IHyk/sqE5aZccgTBXt08m7PCIRAy+acYkivPYOmlI58JYhGiCdcp65xDmKbHdJDgO6y9+7t5EQ2s/Xo
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:47bc:d53f:1c50:a3f2])
 (user=mshavit job=sendgmr) by 2002:a25:ab0d:0:b0:d7e:8dee:7813 with SMTP id
 u13-20020a25ab0d000000b00d7e8dee7813mr34021ybi.8.1694784094306; Fri, 15 Sep
 2023 06:21:34 -0700 (PDT)
Date:   Fri, 15 Sep 2023 21:17:39 +0800
In-Reply-To: <20230915132051.2646055-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230915132051.2646055-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915211705.v8.8.I7a8beb615e2520ad395d96df94b9ab9708ee0d9c@changeid>
Subject: [PATCH v8 8/9] iommu/arm-smmu-v3: Update comment about STE liveness
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

Update the comment to reflect the fact that the STE is not always
installed. arm_smmu_domain_finalise_s1 intentionnaly calls
arm_smmu_write_ctx_desc while the STE is not installed.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v6)

Changes in v6:
- New commit

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f9bfa2c8ab1e3..86e4e2df9e2fa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1091,7 +1091,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 		cdptr[3] = cpu_to_le64(cd->mair);
 
 		/*
-		 * STE is live, and the SMMU might read dwords of this CD in any
+		 * STE may be live, and the SMMU might read dwords of this CD in any
 		 * order. Ensure that it observes valid values before reading
 		 * V=1.
 		 */
-- 
2.42.0.459.ge4e396fd5e-goog

