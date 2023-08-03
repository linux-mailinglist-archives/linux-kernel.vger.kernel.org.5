Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0806676E554
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjHCKOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbjHCKOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:14:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8505335A4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:14:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d061f324d64so888980276.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691057656; x=1691662456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rOifn/Wuhm3Lbc3GJRKlq49fGVZtVjA5QOC6h6hHPVo=;
        b=zJO63gTN+QV8Tfx+6gzEyj5dUonNQXVuyOR/4CqHTz6PD/3cyRUXHXVcphE0fpyuCR
         ZKz98+w5g8mFMMzzvIJ747TDQzawpo9yAa/1f6z+hOOvccv3tyru4rVG/SNKz9FZCl5s
         uIn2qnCLLDiJNac2CKJCfNSreSw5An3t/Kx+wsM8Pcw1M5SxyvLmfICMMkWalT4pT/fH
         IEFOJ549A2Nn1ee23hdlvSi7Y3WyIy4Tdve79X6p9c1NumDYR1CfcPF3sBfoSZXRe5Qr
         WrgHPCqRl2usHE3RPid/EudzlKgU3D4crbQvFz+8xt4Mn708pcq+X+TmyEB36fv7aHaX
         l0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057656; x=1691662456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOifn/Wuhm3Lbc3GJRKlq49fGVZtVjA5QOC6h6hHPVo=;
        b=g+hHLUbla0g8bJWqaRSy1XLABRj9dIXznRoXlUCIMhHGoyq1HiEW6fQvbu1d32KmXK
         1zCDIPpDGpH7psgoBE/9qK+GNrO8bkkC+K+gH3Yk+qI3zJvkJD5cZnPQuRphfUHtgQ3u
         qiv7UJnPE32RsLF7nV5deCeLw7LUYWWdZzteQ7NbvERHxdq7XubQoZQWNvCR63vPKCuK
         HSCWsGHFAWJgUwdMOTib4t47ieSTKXJu+GvPa0v0jXPGtrkammD0Ed60NenChlUXnhLh
         a9uiacnkb2Mx7IsjPQRMvrIA9/iOFt0NbManpAderGsq6fuLD5KiBEAA5cnCaSKrSOIu
         eyQg==
X-Gm-Message-State: ABy/qLZf137JNbsIKYn36vtP8fHLaMYUOqE8gWPFDPaf05Fs61uY3653
        v51i3w2D68n+3lR+Ha+3NIDlF4G0hij4
X-Google-Smtp-Source: APBJJlEww5GzZLOemvoHR0jnjoJTpv9UvSTAuAgQXGJ5jhZ7oiz42irlxltf7zXwxFAEDzkY/BIZ2zeS4ZW5
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a25:ab0b:0:b0:d0e:e780:81b3 with SMTP id
 u11-20020a25ab0b000000b00d0ee78081b3mr118271ybi.2.1691057656667; Thu, 03 Aug
 2023 03:14:16 -0700 (PDT)
Date:   Thu,  3 Aug 2023 18:12:23 +0800
In-Reply-To: <20230803101351.1561031-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230803101351.1561031-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803181225.v5.3.I374b2826d8b01f3a0110fd42a01208d2e8adb0a2@changeid>
Subject: [PATCH v5 3/6] iommu/arm-smmu-v3: Add helper for atc invalidation
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

This will be used to invalidate ATC entries made on an SSID for a master
when detaching a domain with pasid.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v2)

Changes in v2:
- Make use of arm_smmu_atc_inv_cmd_set_ssid

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6e614ad12fb48..e0565c644ffdb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1798,13 +1798,15 @@ arm_smmu_atc_inv_to_cmd(unsigned long iova, size_t size,
 	cmd->atc.size	= log2_span;
 }
 
-static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
+static int arm_smmu_atc_inv_master_ssid(struct arm_smmu_master *master,
+					int ssid)
 {
 	int i;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_cmdq_batch cmds;
 
 	arm_smmu_atc_inv_to_cmd(0, 0, &cmd);
+	arm_smmu_atc_inv_cmd_set_ssid(ssid, &cmd);
 	cmds.num = 0;
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
@@ -1814,6 +1816,11 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
 }
 
+static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
+{
+	return arm_smmu_atc_inv_master_ssid(master, 0);
+}
+
 /*
  * If ssid is non-zero, issue atc invalidations with the given ssid instead of
  * the one the domain is attached to. This is used by SVA since it's pasid
-- 
2.41.0.585.gd2178a4bd4-goog

