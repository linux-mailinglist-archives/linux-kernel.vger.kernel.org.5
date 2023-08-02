Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A48476D3D1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbjHBQfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjHBQee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:34:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF4D35BC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:34:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-584126c65d1so82150427b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 09:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690994047; x=1691598847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yNDoyQCVv3of8CbzD7UrBZ/J064WuiNsrQAu+4gPoJw=;
        b=COmmzr/ZrzYU67GXsaAkeCXcFTbuJ4N8bt6e/ulY4MJB1st5jFNkRFhT/96mRMHlz+
         nDJ0CKW6+HGNxd2G2NDaa+3+cbydrawx8InWmB8xrO4E/yMJBV42TKmhqE/Ydulfwzbc
         5f7EkEk6lU0H1/tArBx2LsVPEdl45hoKc0tDzDQTGPcORkHWZw3ESp1OUVk4MGPkpZ17
         xuz4LlVY+3IgMv9G21YFJ66iibwnU+0jp2Le7P3y3olqcOEoYLoh/sWwhQ/C5wY0w5wu
         reRZS2ocDr1HijC+xabhRJy5L71w9aKwcLgE52nPKM9ig6A8G87EtLRFx5j9s10DvhTM
         OdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690994047; x=1691598847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yNDoyQCVv3of8CbzD7UrBZ/J064WuiNsrQAu+4gPoJw=;
        b=UTc7Cg6K6ZfbdgahMpoPFJ6gSe5ubb0PlaMUDqXUu5wWExOT8sSU8hEU6KM9Pzhoyu
         n8hbV3hyUF429doxR3xdSRVXyqJbMMpZ1unfszvPRv7+cLY8LsLWWFcXogljhW1pHu1+
         FoVBameCtWm6DLe7oFvWIgWAcc5GYezMJHcmMzaCXpAm0QhakWZGFMYzgukbnRVufcQH
         w+S0PFQ2tKWEcRIqTxw4dj4b0FfefFU+E01g870pgiKyTDKyTF7ChjnWXD/dUsdLg3pD
         0yokhsOFhKfeTTITJ9zDKyRkzrUG9VyCW3veyHOrcREooJUa5TQuV+BTph3l7Toi0Iuy
         aP7w==
X-Gm-Message-State: ABy/qLY99Ogesb9e4wyLmfptt1Z9iKS3qHG9GPo1Su0elD1weroFbrdo
        n7keGZ0HTWmCCBOWvOBtgymY10B77R01
X-Google-Smtp-Source: APBJJlEsy+/m4IjjcjYGAp6bgcwwwvW6CNiqjOP+V/RjmxBEbdQ/ZzssDS1E1hx9GXz5q6Yk4d1bzfTzej4b
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a05:6902:160e:b0:d09:6ba9:69ec with SMTP
 id bw14-20020a056902160e00b00d096ba969ecmr129159ybb.4.1690994047546; Wed, 02
 Aug 2023 09:34:07 -0700 (PDT)
Date:   Thu,  3 Aug 2023 00:32:35 +0800
In-Reply-To: <20230802163328.2623773-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230802163328.2623773-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803003234.v4.7.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
Subject: [PATCH v4 7/8] iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com,
        jgg@nvidia.com, jean-philippe@linaro.org,
        Michael Shavit <mshavit@google.com>
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

This commit explicitly keeps track of whether a CD table is installed in
an STE so that arm_smmu_sync_cd can skip the sync when unnecessary. This
was previously achieved through the domain->devices list, but we are
moving to a model where arm_smmu_sync_cd directly operates on a master
and the master's CD table instead of a domain.

Signed-off-by: Michael Shavit <mshavit@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---

(no changes since v3)

Changes in v3:
- Flip the cd_table.installed bit back off when table is detached
- re-order the commit later in the series since flipping the installed
  bit to off isn't obvious when the cd_table is still shared by multiple
  masters.

Changes in v2:
- Store field as a bit instead of a bool. Fix comment about STE being
  live before the sync in write_ctx_desc().

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e2c33024ad85..00b602ae9636 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -985,6 +985,9 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 		},
 	};
 
+	if (!master->cd_table.installed)
+		return;
+
 	cmds.num = 0;
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.cfgi.sid = master->streams[i].id;
@@ -1091,7 +1094,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 		cdptr[3] = cpu_to_le64(cd->mair);
 
 		/*
-		 * STE is live, and the SMMU might read dwords of this CD in any
+		 * STE may be live, and the SMMU might read dwords of this CD in any
 		 * order. Ensure that it observes valid values before reading
 		 * V=1.
 		 */
@@ -1360,6 +1363,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 				  cd_table->l1_desc ?
 					  STRTAB_STE_0_S1FMT_64K_L2 :
 					  STRTAB_STE_0_S1FMT_LINEAR);
+		cd_table->installed = true;
+	} else {
+		master->cd_table.installed = false;
 	}
 
 	if (s2_cfg) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1f3b37025777..e76452e735a0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -599,6 +599,8 @@ struct arm_smmu_ctx_desc_cfg {
 	u8				max_cds_bits;
 	/* Whether CD entries in this table have the stall bit set. */
 	u8				stall_enabled:1;
+	/* Whether this CD table is installed in any STE */
+	u8				installed:1;
 };
 
 struct arm_smmu_s2_cfg {
-- 
2.41.0.585.gd2178a4bd4-goog

