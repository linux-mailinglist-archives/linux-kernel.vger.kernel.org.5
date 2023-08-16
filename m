Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0026477E26F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245495AbjHPNUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245514AbjHPNUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:20:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C3E2711
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:20:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d1c693a29a0so7552551276.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692192013; x=1692796813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wahm0+n9syTK68V4+8/kXjO64+N5fjxBx7U2bn3Amxs=;
        b=5X6G7uiEUz25+dwfPfk290Fi7oAijcXS8dxWAYPl3C0idvCWhFxffS/uKyZe16ZlzU
         erdGHRmPDZES2vTp/CoPIS/5n9kmJTz9XA9vgsEkAKgM+pMlk9BGYAFWkDZEh17yg7xO
         HLS8lQlUROOod87aQrZnmG9YhQwf24640kNEsuetuYzzw3DPIQx8OBAsQf01fJ/jzgfT
         OYBd556Y6KMbTcWHGdpMcGODJT3Up26h6QaIdBp6N/nrsaRM3Omj2ueJ9uPWQNAi0ALK
         t9i/hvQ9M8iRrgxDmB83NzQGytZIDC+bKfU8KELKwBQxYOZH8DaCk8npKwWJ3grgSbuW
         ib9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692192013; x=1692796813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wahm0+n9syTK68V4+8/kXjO64+N5fjxBx7U2bn3Amxs=;
        b=lDV9TFLfqanBoXFsoDabCZH/6QIwGCe0bP/z6bAJ2LUQ3oG+YD1+nrLNYeKdWHIKmU
         +xuPPONwTXAEM1cO+YubHq7PsVUHHELP/mjBR8ZmaQ7JvNBkFqpwnKKXVWpCZpjHpp/m
         aLLSCebgv3btyJhOf6qW5R7ZxjjTulJOv8MPedEADKWD+UMXKHLOb9chNFWVlkavjCYt
         DWkXPktl7ob15+bSNG928Wj+cNVn4+i4mdOA9omDxR8qLAa7m2MnhtIycP79wcswpbsM
         6403WUGTJ06/KLYhE+LDAAH6jcdDD3aJAz9mCjJ+QafwwNBTa2dWrlSyN6GYaBsszkFB
         GcFw==
X-Gm-Message-State: AOJu0Yy0uSDhDurQGhjuEhZc+JSM/Ifrct7lAxo3Ke1T93b8hn1HpNyG
        xAlJQxqtLiUaevgRl42UkwwOhWoZ8Hnw
X-Google-Smtp-Source: AGHT+IGfrAEWxCBxWzZSyOwYafJU+OJBdmpgGQY9CJWSDxC54cz937JgjBYjmMiDVRGJsEgo8GrKs2p0hY4Z
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:ae98:2006:2abd:3434])
 (user=mshavit job=sendgmr) by 2002:a25:df07:0:b0:c78:c530:6345 with SMTP id
 w7-20020a25df07000000b00c78c5306345mr25973ybg.7.1692192013420; Wed, 16 Aug
 2023 06:20:13 -0700 (PDT)
Date:   Wed, 16 Aug 2023 21:18:49 +0800
In-Reply-To: <20230816131925.2521220-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230816131925.2521220-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816211849.v6.9.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
Subject: [PATCH v6 09/10] iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, will@kernel.org, jean-philippe@linaro.org,
        jgg@nvidia.com, nicolinc@nvidia.com,
        Michael Shavit <mshavit@google.com>
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

This commit explicitly keeps track of whether a CD table is installed in
an STE so that arm_smmu_sync_cd can skip the sync when unnecessary. This
was previously achieved through the domain->devices list, but we are
moving to a model where arm_smmu_sync_cd directly operates on a master
and the master's CD table instead of a domain.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---
Happy to drop this commit if we don't think it's useful.

(no changes since v5)

Changes in v5:
- Fix an issue where cd_table.installed wasn't correctly updated.

Changes in v3:
- Flip the cd_table.installed bit back off when table is detached
- re-order the commit later in the series since flipping the installed
  bit to off isn't obvious when the cd_table is still shared by multiple
  masters.

Changes in v2:
- Store field as a bit instead of a bool. Fix comment about STE being
  live before the sync in write_ctx_desc().

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 +++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3c8bfeca89d5c..104b8d6ea5972 100644
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
@@ -1335,6 +1338,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		 */
 		if (smmu)
 			arm_smmu_sync_ste_for_sid(smmu, sid);
+		master->cd_table.installed = false;
 		return;
 	}
 
@@ -1358,6 +1362,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
 			FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax) |
 			FIELD_PREP(STRTAB_STE_0_S1FMT, cd_table->s1fmt);
+		cd_table->installed = true;
+	} else {
+		master->cd_table.installed = false;
 	}
 
 	if (s2_cfg) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 2f4b832e0deb4..b7a91c8e9b523 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -600,6 +600,8 @@ struct arm_smmu_ctx_desc_cfg {
 	u8				s1cdmax;
 	/* Whether CD entries in this table have the stall bit set. */
 	u8				stall_enabled:1;
+	/* Whether this CD table is installed in any STE */
+	u8				installed:1;
 };
 
 struct arm_smmu_s2_cfg {
-- 
2.41.0.694.ge786442a9b-goog

