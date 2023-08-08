Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D30774676
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjHHS5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjHHS4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:56:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158231CCF1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:15:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d06d36b49f9so5397585276.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691514932; x=1692119732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlBD+7PvoDhg41jrKYyWEK7ci2zLxvyOU6AJgUoKm4s=;
        b=TW3Soan/UyVtkLj9e3V9TL2NG58JntRmwZpTDHKv4J0UIWtkuXX8+30rVtgte8dZcL
         ved2RpyB9O2fIul744OJ1qVY8UdXNCrH3I/4Mym81B+yuP3trruh6EveFEeonMrHFykG
         RUO9gPYZUfwloT6QWn3Mbe7xgHhqRtCGiPV1j/c9iR+IyOSKfVU2IAus8J/kXrqBTx+t
         u/E1oyf1KPdvV31T+JDzOkK+IF5htyYXed6nJfNTIQEAwtboiLOTx+rgwuUuz/BeyNE/
         nCbLIkQL9jCq1ASoWVThVygeC96QTgEqRKIT5+2QViJO4GbMi0fo5tn2S7weNkNRbIOl
         20/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514932; x=1692119732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlBD+7PvoDhg41jrKYyWEK7ci2zLxvyOU6AJgUoKm4s=;
        b=atlimWn0Lmi3xHIG/8c6ndhmbcpALMTh1f76Yltz5++U4B+xPEpJPfLbyspxFjov0X
         wCg7q5tpSHe/D80ERrjEkDwFL4JtyHg9K3Dc26v/tW5rKgN+/D64Dh27m++FQXaJISwF
         OxCWXNby2JhrZQiWg5BsXGRSZn6bxnCRMhIJbwSAftOJ0tLuljido4Vtlhpg5YLuRoB3
         FhKBt/Uv6aOn4tS2kADmzbApSt+irV3OE1MnOcY7N3nRw3+220hqD/505gZ1qe5qIBnB
         kJhzJHkfsCi2XsBjreOnpX8FWMfD6EAxj4f/E/wPda7o91p/dFPN9idqn928xKPovmXE
         Xr1g==
X-Gm-Message-State: AOJu0Yy6JfffE+OIjnIQ0stKHs56XbTqhIs7BJQVMsaaPNIBSrwsByGg
        M9RIiFDBVAo0wIw5ABNPHnwoXXy+dBvA
X-Google-Smtp-Source: AGHT+IFAXu3FH/zEWQzNGj/ih1neSthyomibWGyX08Oyjek2n/+brnMg9867DZUVuzOMgGo9SDKtkkw74MiE
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:986a:71d7:3b1e:ac1d])
 (user=mshavit job=sendgmr) by 2002:a25:d24d:0:b0:d4d:564d:8fbf with SMTP id
 j74-20020a25d24d000000b00d4d564d8fbfmr3401ybg.13.1691514932248; Tue, 08 Aug
 2023 10:15:32 -0700 (PDT)
Date:   Wed,  9 Aug 2023 01:12:04 +0800
In-Reply-To: <20230808171446.2187795-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230809011204.v5.8.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
Subject: [PATCH v5 8/9] iommu/arm-smmu-v3: Skip cd sync if CD table isn't active
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com,
        jgg@nvidia.com, jean-philippe@linaro.org,
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

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f5ad386cc8760..488d12dd2d4aa 100644
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
@@ -1333,6 +1336,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		 */
 		if (smmu)
 			arm_smmu_sync_ste_for_sid(smmu, sid);
+		master->cd_table.installed = false;
 		return;
 	}
 
@@ -1360,6 +1364,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 				  cd_table->l1_desc ?
 					  STRTAB_STE_0_S1FMT_64K_L2 :
 					  STRTAB_STE_0_S1FMT_LINEAR);
+		cd_table->installed = true;
+	} else {
+		master->cd_table.installed = false;
 	}
 
 	if (s2_cfg) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1f3b370257779..e76452e735a04 100644
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
2.41.0.640.ga95def55d0-goog

