Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBB0771637
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 19:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjHFRIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 13:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjHFRIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 13:08:48 -0400
Received: from so254-32.mailgun.net (so254-32.mailgun.net [198.61.254.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667EC1BE8
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 10:08:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1691341702; x=1691348902; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=A782TrwYmIkHVfhZ26Y5dfqSG3A3PGeugjDnAevKJYo=;
 b=OyFh2Jaoajiy1vTqWI7CwMxcrcTC4c2AFf0KyLofX4WSetw8mZYXaTggnGsm7qynTngXFbUKZuPplpIgnQwdZ9jKnuOVsQvN8qpskipk0LQaD0soZqeDkTBTbKhONoW5/8PXnDBXZh7F39I+j8iaPXGAHxk/fRfUrLU2pRQdtOS/FHKou33z/jVWn+zm8NskIlhq4uZnjiJJ5X5yi0fcSy9TEChoXbeq3YiXtPTgSqEr4A1VNMncCAp14pjd5vY6rqTyzzBVKTGFNByr3Qqsni4GHOOSPfK1xeg6FXNLc1V30gv+mzACVOHQAqQ4xLvmSkFICfhtRi3M/bJdy1AC3Q==
X-Mailgun-Sending-Ip: 198.61.254.32
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 612ac3bab8bf with SMTP id
 64cfd386c57a92cb4d24aa82 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 06 Aug 2023 17:08:22 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     James Seo <james@equiv.tech>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/12] scsi: mpt3sas: Use struct_size() for struct size calculations
Date:   Sun,  6 Aug 2023 10:05:59 -0700
Message-Id: <20230806170604.16143-8-james@equiv.tech>
In-Reply-To: <20230806170604.16143-1-james@equiv.tech>
References: <20230806170604.16143-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After converting terminal variable arrays into flexible array
members, use the bounds-checking struct_size() helper when possible
to avoid open-coded arithmetic struct size calculations.

Signed-off-by: James Seo <james@equiv.tech>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c      |  3 +--
 drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 18 ++++++------------
 drivers/scsi/mpt3sas/mpt3sas_transport.c |  9 +++------
 drivers/scsi/mpt3sas/mpt3sas_warpdrive.c |  3 +--
 4 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 53f5492579cb..2ae0185938f3 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4876,8 +4876,7 @@ mpt3sas_base_update_missing_delay(struct MPT3SAS_ADAPTER *ioc,
 	if (!num_phys)
 		return;
 
-	sz = offsetof(Mpi2SasIOUnitPage1_t, PhyData) + (num_phys *
-	    sizeof(Mpi2SasIOUnit1PhyData_t));
+	sz = struct_size(sas_iounit_pg1, PhyData, num_phys);
 	sas_iounit_pg1 = kzalloc(sz, GFP_KERNEL);
 	if (!sas_iounit_pg1) {
 		ioc_err(ioc, "failure at %s:%d/%s()!\n",
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index c3c1f466fe01..d5426a520a77 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -2431,8 +2431,7 @@ _scsih_get_volume_capabilities(struct MPT3SAS_ADAPTER *ioc,
 	}
 
 	raid_device->num_pds = num_pds;
-	sz = offsetof(Mpi2RaidVolPage0_t, PhysDisk) + (num_pds *
-	    sizeof(Mpi2RaidVol0PhysDisk_t));
+	sz = struct_size(vol_pg0, PhysDisk, num_pds);
 	vol_pg0 = kzalloc(sz, GFP_KERNEL);
 	if (!vol_pg0) {
 		dfailprintk(ioc,
@@ -5966,8 +5965,7 @@ _scsih_update_vphys_after_reset(struct MPT3SAS_ADAPTER *ioc)
 	/*
 	 * Read SASIOUnitPage0 to get each HBA Phy's data.
 	 */
-	sz = offsetof(Mpi2SasIOUnitPage0_t, PhyData) +
-	    (ioc->sas_hba.num_phys * sizeof(Mpi2SasIOUnit0PhyData_t));
+	sz = struct_size(sas_iounit_pg0, PhyData, ioc->sas_hba.num_phys);
 	sas_iounit_pg0 = kzalloc(sz, GFP_KERNEL);
 	if (!sas_iounit_pg0) {
 		ioc_err(ioc, "failure at %s:%d/%s()!\n",
@@ -6145,8 +6143,7 @@ _scsih_get_port_table_after_reset(struct MPT3SAS_ADAPTER *ioc,
 	u64 attached_sas_addr;
 	u8 found = 0, port_count = 0, port_id;
 
-	sz = offsetof(Mpi2SasIOUnitPage0_t, PhyData) + (ioc->sas_hba.num_phys
-	    * sizeof(Mpi2SasIOUnit0PhyData_t));
+	sz = struct_size(sas_iounit_pg0, PhyData, ioc->sas_hba.num_phys);
 	sas_iounit_pg0 = kzalloc(sz, GFP_KERNEL);
 	if (!sas_iounit_pg0) {
 		ioc_err(ioc, "failure at %s:%d/%s()!\n",
@@ -6579,8 +6576,7 @@ _scsih_sas_host_refresh(struct MPT3SAS_ADAPTER *ioc)
 		  ioc_info(ioc, "updating handles for sas_host(0x%016llx)\n",
 			   (u64)ioc->sas_hba.sas_address));
 
-	sz = offsetof(Mpi2SasIOUnitPage0_t, PhyData) + (ioc->sas_hba.num_phys
-	    * sizeof(Mpi2SasIOUnit0PhyData_t));
+	sz = struct_size(sas_iounit_pg0, PhyData, ioc->sas_hba.num_phys);
 	sas_iounit_pg0 = kzalloc(sz, GFP_KERNEL);
 	if (!sas_iounit_pg0) {
 		ioc_err(ioc, "failure at %s:%d/%s()!\n",
@@ -6731,8 +6727,7 @@ _scsih_sas_host_add(struct MPT3SAS_ADAPTER *ioc)
 	ioc->sas_hba.num_phys = num_phys;
 
 	/* sas_iounit page 0 */
-	sz = offsetof(Mpi2SasIOUnitPage0_t, PhyData) + (ioc->sas_hba.num_phys *
-	    sizeof(Mpi2SasIOUnit0PhyData_t));
+	sz = struct_size(sas_iounit_pg0, PhyData, ioc->sas_hba.num_phys);
 	sas_iounit_pg0 = kzalloc(sz, GFP_KERNEL);
 	if (!sas_iounit_pg0) {
 		ioc_err(ioc, "failure at %s:%d/%s()!\n",
@@ -6754,8 +6749,7 @@ _scsih_sas_host_add(struct MPT3SAS_ADAPTER *ioc)
 	}
 
 	/* sas_iounit page 1 */
-	sz = offsetof(Mpi2SasIOUnitPage1_t, PhyData) + (ioc->sas_hba.num_phys *
-	    sizeof(Mpi2SasIOUnit1PhyData_t));
+	sz = struct_size(sas_iounit_pg1, PhyData, ioc->sas_hba.num_phys);
 	sas_iounit_pg1 = kzalloc(sz, GFP_KERNEL);
 	if (!sas_iounit_pg1) {
 		ioc_err(ioc, "failure at %s:%d/%s()!\n",
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index e8a4750f6ec4..421ea511b664 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -1792,8 +1792,7 @@ _transport_phy_enable(struct sas_phy *phy, int enable)
 	/* handle hba phys */
 
 	/* read sas_iounit page 0 */
-	sz = offsetof(Mpi2SasIOUnitPage0_t, PhyData) + (ioc->sas_hba.num_phys *
-	    sizeof(Mpi2SasIOUnit0PhyData_t));
+	sz = struct_size(sas_iounit_pg0, PhyData, ioc->sas_hba.num_phys);
 	sas_iounit_pg0 = kzalloc(sz, GFP_KERNEL);
 	if (!sas_iounit_pg0) {
 		ioc_err(ioc, "failure at %s:%d/%s()!\n",
@@ -1833,8 +1832,7 @@ _transport_phy_enable(struct sas_phy *phy, int enable)
 	}
 
 	/* read sas_iounit page 1 */
-	sz = offsetof(Mpi2SasIOUnitPage1_t, PhyData) + (ioc->sas_hba.num_phys *
-	    sizeof(Mpi2SasIOUnit1PhyData_t));
+	sz = struct_size(sas_iounit_pg1, PhyData, ioc->sas_hba.num_phys);
 	sas_iounit_pg1 = kzalloc(sz, GFP_KERNEL);
 	if (!sas_iounit_pg1) {
 		ioc_err(ioc, "failure at %s:%d/%s()!\n",
@@ -1944,8 +1942,7 @@ _transport_phy_speed(struct sas_phy *phy, struct sas_phy_linkrates *rates)
 	/* handle hba phys */
 
 	/* sas_iounit page 1 */
-	sz = offsetof(Mpi2SasIOUnitPage1_t, PhyData) + (ioc->sas_hba.num_phys *
-	    sizeof(Mpi2SasIOUnit1PhyData_t));
+	sz = struct_size(sas_iounit_pg1, PhyData, ioc->sas_hba.num_phys);
 	sas_iounit_pg1 = kzalloc(sz, GFP_KERNEL);
 	if (!sas_iounit_pg1) {
 		ioc_err(ioc, "failure at %s:%d/%s()!\n",
diff --git a/drivers/scsi/mpt3sas/mpt3sas_warpdrive.c b/drivers/scsi/mpt3sas/mpt3sas_warpdrive.c
index cc07ba41f507..1d64e5056a8a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_warpdrive.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_warpdrive.c
@@ -141,8 +141,7 @@ mpt3sas_init_warpdrive_properties(struct MPT3SAS_ADAPTER *ioc,
 		return;
 	}
 
-	sz = offsetof(Mpi2RaidVolPage0_t, PhysDisk) + (num_pds *
-	    sizeof(Mpi2RaidVol0PhysDisk_t));
+	sz = struct_size(vol_pg0, PhysDisk, num_pds);
 	vol_pg0 = kzalloc(sz, GFP_KERNEL);
 	if (!vol_pg0) {
 		ioc_info(ioc, "WarpDrive : Direct IO is disabled Memory allocation failure for RVPG0\n");
-- 
2.39.2

