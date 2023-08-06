Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A9E771640
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 19:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjHFRJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 13:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjHFRJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 13:09:43 -0400
Received: from rs227.mailgun.us (rs227.mailgun.us [209.61.151.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10E41BCB
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 10:09:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1691341754; x=1691348954; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=+vpMgPndr8tHLDfj/uP9qR3t+hzWfcdZs69eLq08/jo=;
 b=g/UVj12uTj/FHErk1dYuUbspNTPeStThlEVvn0BOmB7vBcefe9UGMTbV3QmS1MzbsE/xRIoGJ+nDBYLDFxxPqbkzgLwF1U4ZXDcm3S/HGhpHX3CnDg3euwM8963loIlC/lbqp9GX1kMJX6L6VMnAAvEE0DmZHtQf+4+2eyiETrP93SbQPpgHTnr4gTfYuCWImbO9t3XZEn+GTyEXQxOLjL6Uia6bvbDdmZ2j19Yy04cD6CqMEyP62krR6td4uxQTz5cyMoohGFaHuxbD6luuMn8N6C54lkUTqwsA5MdX1+kc5Jmvog67alkhTrfNKVUNT2vV1B3a4j/HmYLrKJ0y6g==
X-Mailgun-Sending-Ip: 209.61.151.227
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 0893f9b7a9d0 with SMTP id
 64cfd3baf85b1f0c8f8a5a78 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 06 Aug 2023 17:09:14 GMT
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
Subject: [PATCH v2 12/12] scsi: mpt3sas: Replace dynamic allocations with local variables
Date:   Sun,  6 Aug 2023 10:06:04 -0700
Message-Id: <20230806170604.16143-13-james@equiv.tech>
In-Reply-To: <20230806170604.16143-1-james@equiv.tech>
References: <20230806170604.16143-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpt3sas_scsih.c:_scsih_scan_for_devices_after_reset() allocates and
fetches a MPI2_CONFIG_PAGE_RAID_VOL_0 struct (Mpi2RaidVolPage0_t) and
a MPI2_CONFIG_PAGE_RAID_VOL_1 struct (Mpi2RaidVolPage1_t), but does
not include the terminal flexible array members in the struct size
calculations, fetch those members, or otherwise use those members in
any way.

These dynamic allocations can be replaced with local variables.

Signed-off-by: James Seo <james@equiv.tech>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 37 +++++++++-------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index d5426a520a77..354341fc867f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -10370,8 +10370,8 @@ _scsih_scan_for_devices_after_reset(struct MPT3SAS_ADAPTER *ioc)
 	Mpi2ExpanderPage0_t expander_pg0;
 	Mpi2SasDevicePage0_t sas_device_pg0;
 	Mpi26PCIeDevicePage0_t pcie_device_pg0;
-	Mpi2RaidVolPage1_t *volume_pg1;
-	Mpi2RaidVolPage0_t *volume_pg0;
+	Mpi2RaidVolPage1_t volume_pg1;
+	Mpi2RaidVolPage0_t volume_pg0;
 	Mpi2RaidPhysDiskPage0_t pd_pg0;
 	Mpi2EventIrConfigElement_t element;
 	Mpi2ConfigReply_t mpi_reply;
@@ -10386,16 +10386,6 @@ _scsih_scan_for_devices_after_reset(struct MPT3SAS_ADAPTER *ioc)
 	u8 retry_count;
 	unsigned long flags;
 
-	volume_pg0 = kzalloc(sizeof(*volume_pg0), GFP_KERNEL);
-	if (!volume_pg0)
-		return;
-
-	volume_pg1 = kzalloc(sizeof(*volume_pg1), GFP_KERNEL);
-	if (!volume_pg1) {
-		kfree(volume_pg0);
-		return;
-	}
-
 	ioc_info(ioc, "scan devices: start\n");
 
 	_scsih_sas_host_refresh(ioc);
@@ -10505,7 +10495,7 @@ _scsih_scan_for_devices_after_reset(struct MPT3SAS_ADAPTER *ioc)
 	/* volumes */
 	handle = 0xFFFF;
 	while (!(mpt3sas_config_get_raid_volume_pg1(ioc, &mpi_reply,
-	    volume_pg1, MPI2_RAID_VOLUME_PGAD_FORM_GET_NEXT_HANDLE, handle))) {
+	    &volume_pg1, MPI2_RAID_VOLUME_PGAD_FORM_GET_NEXT_HANDLE, handle))) {
 		ioc_status = le16_to_cpu(mpi_reply.IOCStatus) &
 		    MPI2_IOCSTATUS_MASK;
 		if (ioc_status != MPI2_IOCSTATUS_SUCCESS) {
@@ -10513,15 +10503,15 @@ _scsih_scan_for_devices_after_reset(struct MPT3SAS_ADAPTER *ioc)
 				 ioc_status, le32_to_cpu(mpi_reply.IOCLogInfo));
 			break;
 		}
-		handle = le16_to_cpu(volume_pg1->DevHandle);
+		handle = le16_to_cpu(volume_pg1.DevHandle);
 		spin_lock_irqsave(&ioc->raid_device_lock, flags);
 		raid_device = _scsih_raid_device_find_by_wwid(ioc,
-		    le64_to_cpu(volume_pg1->WWID));
+		    le64_to_cpu(volume_pg1.WWID));
 		spin_unlock_irqrestore(&ioc->raid_device_lock, flags);
 		if (raid_device)
 			continue;
 		if (mpt3sas_config_get_raid_volume_pg0(ioc, &mpi_reply,
-		    volume_pg0, MPI2_RAID_VOLUME_PGAD_FORM_HANDLE, handle,
+		    &volume_pg0, MPI2_RAID_VOLUME_PGAD_FORM_HANDLE, handle,
 		     sizeof(Mpi2RaidVolPage0_t)))
 			continue;
 		ioc_status = le16_to_cpu(mpi_reply.IOCStatus) &
@@ -10531,17 +10521,17 @@ _scsih_scan_for_devices_after_reset(struct MPT3SAS_ADAPTER *ioc)
 				 ioc_status, le32_to_cpu(mpi_reply.IOCLogInfo));
 			break;
 		}
-		if (volume_pg0->VolumeState == MPI2_RAID_VOL_STATE_OPTIMAL ||
-		    volume_pg0->VolumeState == MPI2_RAID_VOL_STATE_ONLINE ||
-		    volume_pg0->VolumeState == MPI2_RAID_VOL_STATE_DEGRADED) {
+		if (volume_pg0.VolumeState == MPI2_RAID_VOL_STATE_OPTIMAL ||
+		    volume_pg0.VolumeState == MPI2_RAID_VOL_STATE_ONLINE ||
+		    volume_pg0.VolumeState == MPI2_RAID_VOL_STATE_DEGRADED) {
 			memset(&element, 0, sizeof(Mpi2EventIrConfigElement_t));
 			element.ReasonCode = MPI2_EVENT_IR_CHANGE_RC_ADDED;
-			element.VolDevHandle = volume_pg1->DevHandle;
+			element.VolDevHandle = volume_pg1.DevHandle;
 			ioc_info(ioc, "\tBEFORE adding volume: handle (0x%04x)\n",
-				 volume_pg1->DevHandle);
+				 volume_pg1.DevHandle);
 			_scsih_sas_volume_add(ioc, &element);
 			ioc_info(ioc, "\tAFTER adding volume: handle (0x%04x)\n",
-				 volume_pg1->DevHandle);
+				 volume_pg1.DevHandle);
 		}
 	}
 
@@ -10630,9 +10620,6 @@ _scsih_scan_for_devices_after_reset(struct MPT3SAS_ADAPTER *ioc)
 			 handle, (u64)le64_to_cpu(pcie_device_pg0.WWID));
 	}
 
-	kfree(volume_pg0);
-	kfree(volume_pg1);
-
 	ioc_info(ioc, "\tpcie devices: pcie end devices complete\n");
 	ioc_info(ioc, "scan devices: complete\n");
 }
-- 
2.39.2

