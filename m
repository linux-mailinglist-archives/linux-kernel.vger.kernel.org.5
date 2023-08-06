Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868E877162C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 19:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjHFRHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 13:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjHFRHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 13:07:22 -0400
Received: from so254-32.mailgun.net (so254-32.mailgun.net [198.61.254.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC941725
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 10:07:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1691341636; x=1691348836; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=wWlGOvPCGJZh1ZdIna6th6AI6IfqnflRJ+h2lSLYbN8=;
 b=KxyRYwVVuxi2ef8IpBGoyC0sOGSADvabXjclGQijGUPHNdY1rVELfiLA6DL38K4DFG058AxHNIhmrieo2v/qI1O08dNtkHcmuTZOLiGrowmsL+3I3BKOwYauYdSKERiCH6b6CkQhpclqU/vf+vmCjb0BQo4fw5gP2jJfduYbA2p/BKQag+cnnLZtqW+OvTD3SU7q+e/fdi94a6Rp7bj2173zDP0MTUjt6MYay4sm8/Ffh4EmDF5jYenjQ+1nQ81uOn1F43r11KTUGDDtN733dizS7Kgx6yZGDzQhlF392J9T816p00yu39aYChX7d/ZMm2uXadk8YNJzQ0HlfI44AQ==
X-Mailgun-Sending-Ip: 198.61.254.32
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 23c02243ea3c with SMTP id
 64cfd34489833227aa73d2c8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 06 Aug 2023 17:07:16 GMT
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
Subject: [PATCH v2 01/12] scsi: mpt3sas: Use flexible arrays when obviously possible
Date:   Sun,  6 Aug 2023 10:05:53 -0700
Message-Id: <20230806170604.16143-2-james@equiv.tech>
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

These terminal 1-length variable arrays can be directly converted
into C99 flexible array members without any binary changes.

In most cases, they belong to unused structs, or to structs used only
by unused code. The remaining few coincidentally have their sizes
calculated in roundabout ways that do not depend on the sizeof()
their structs.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: James Seo <james@equiv.tech>
---
 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h  | 181 ++++++++------------------
 drivers/scsi/mpt3sas/mpi/mpi2_image.h |  32 ++---
 drivers/scsi/mpt3sas/mpi/mpi2_ioc.h   |  27 ++--
 3 files changed, 75 insertions(+), 165 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
index 4d0be5ab98c1..42d820159c44 100644
--- a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
+++ b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
@@ -643,18 +643,14 @@ typedef struct _MPI2_CHIP_REVISION_ID {
 /*Manufacturing Page 2 */
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check Header.PageLength at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check Header.PageLength at
+ *runtime before using HwSettings[].
  */
-#ifndef MPI2_MAN_PAGE_2_HW_SETTINGS_WORDS
-#define MPI2_MAN_PAGE_2_HW_SETTINGS_WORDS   (1)
-#endif
 
 typedef struct _MPI2_CONFIG_PAGE_MAN_2 {
 	MPI2_CONFIG_PAGE_HEADER Header;                     /*0x00 */
 	MPI2_CHIP_REVISION_ID   ChipId;                     /*0x04 */
-	U32
-		HwSettings[MPI2_MAN_PAGE_2_HW_SETTINGS_WORDS];/*0x08 */
+	U32                     HwSettings[];               /*0x08 */
 } MPI2_CONFIG_PAGE_MAN_2,
 	*PTR_MPI2_CONFIG_PAGE_MAN_2,
 	Mpi2ManufacturingPage2_t,
@@ -666,18 +662,14 @@ typedef struct _MPI2_CONFIG_PAGE_MAN_2 {
 /*Manufacturing Page 3 */
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check Header.PageLength at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check Header.PageLength at
+ *runtime before using Info[].
  */
-#ifndef MPI2_MAN_PAGE_3_INFO_WORDS
-#define MPI2_MAN_PAGE_3_INFO_WORDS          (1)
-#endif
 
 typedef struct _MPI2_CONFIG_PAGE_MAN_3 {
 	MPI2_CONFIG_PAGE_HEADER             Header;         /*0x00 */
 	MPI2_CHIP_REVISION_ID               ChipId;         /*0x04 */
-	U32
-		Info[MPI2_MAN_PAGE_3_INFO_WORDS];/*0x08 */
+	U32                                 Info[];         /*0x08 */
 } MPI2_CONFIG_PAGE_MAN_3,
 	*PTR_MPI2_CONFIG_PAGE_MAN_3,
 	Mpi2ManufacturingPage3_t,
@@ -765,12 +757,9 @@ typedef struct _MPI2_CONFIG_PAGE_MAN_4 {
 /*Manufacturing Page 5 */
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check the value returned for NumPhys at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check the value returned
+ *for NumPhys at runtime before using Phy[].
  */
-#ifndef MPI2_MAN_PAGE_5_PHY_ENTRIES
-#define MPI2_MAN_PAGE_5_PHY_ENTRIES         (1)
-#endif
 
 typedef struct _MPI2_MANUFACTURING5_ENTRY {
 	U64                                 WWID;           /*0x00 */
@@ -787,8 +776,7 @@ typedef struct _MPI2_CONFIG_PAGE_MAN_5 {
 	U16                                 Reserved2;      /*0x06 */
 	U32                                 Reserved3;      /*0x08 */
 	U32                                 Reserved4;      /*0x0C */
-	MPI2_MANUFACTURING5_ENTRY
-		Phy[MPI2_MAN_PAGE_5_PHY_ENTRIES];/*0x08 */
+	MPI2_MANUFACTURING5_ENTRY           Phy[];          /*0x10 */
 } MPI2_CONFIG_PAGE_MAN_5,
 	*PTR_MPI2_CONFIG_PAGE_MAN_5,
 	Mpi2ManufacturingPage5_t,
@@ -864,12 +852,9 @@ typedef struct _MPI2_MANPAGE7_CONNECTOR_INFO {
 #define MPI2_MANPAGE7_SLOT_UNKNOWN                      (0xFFFF)
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check the value returned for NumPhys at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check the value returned
+ *for NumPhys at runtime before using ConnectorInfo[].
  */
-#ifndef MPI2_MANPAGE7_CONNECTOR_INFO_MAX
-#define MPI2_MANPAGE7_CONNECTOR_INFO_MAX  (1)
-#endif
 
 typedef struct _MPI2_CONFIG_PAGE_MAN_7 {
 	MPI2_CONFIG_PAGE_HEADER         Header;             /*0x00 */
@@ -880,8 +865,7 @@ typedef struct _MPI2_CONFIG_PAGE_MAN_7 {
 	U8                              NumPhys;            /*0x20 */
 	U8                              Reserved3;          /*0x21 */
 	U16                             Reserved4;          /*0x22 */
-	MPI2_MANPAGE7_CONNECTOR_INFO
-	ConnectorInfo[MPI2_MANPAGE7_CONNECTOR_INFO_MAX]; /*0x24 */
+	MPI2_MANPAGE7_CONNECTOR_INFO    ConnectorInfo[];    /*0x24 */
 } MPI2_CONFIG_PAGE_MAN_7,
 	*PTR_MPI2_CONFIG_PAGE_MAN_7,
 	Mpi2ManufacturingPage7_t,
@@ -1019,12 +1003,9 @@ typedef struct _MPI2_CONFIG_PAGE_IO_UNIT_3 {
 /*IO Unit Page 5 */
 
 /*
- *Upper layer code (drivers, utilities, etc.) should leave this define set to
- *one and check the value returned for NumDmaEngines at runtime.
+ *Upper layer code (drivers, utilities, etc.) should check the value returned
+ *for NumDmaEngines at runtime before using DmaEngineCapabilities[].
  */
-#ifndef MPI2_IOUNITPAGE5_DMAENGINE_ENTRIES
-#define MPI2_IOUNITPAGE5_DMAENGINE_ENTRIES      (1)
-#endif
 
 typedef struct _MPI2_CONFIG_PAGE_IO_UNIT_5 {
 	MPI2_CONFIG_PAGE_HEADER Header;                     /*0x00 */
@@ -1042,7 +1023,7 @@ typedef struct _MPI2_CONFIG_PAGE_IO_UNIT_5 {
 	U32                     Reserved2;                  /*0x24 */
 	U32                     Reserved3;                  /*0x28 */
 	U32
-	DmaEngineCapabilities[MPI2_IOUNITPAGE5_DMAENGINE_ENTRIES]; /*0x2C */
+		DmaEngineCapabilities[];                    /*0x2C */
 } MPI2_CONFIG_PAGE_IO_UNIT_5,
 	*PTR_MPI2_CONFIG_PAGE_IO_UNIT_5,
 	Mpi2IOUnitPage5_t, *pMpi2IOUnitPage5_t;
@@ -1259,12 +1240,9 @@ typedef struct _MPI2_IOUNIT9_SENSOR {
 #define MPI2_IOUNIT9_SENSOR_FLAGS_TEMP_VALID        (0x01)
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check the value returned for NumSensors at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check the value returned
+ *for NumSensors at runtime before using Sensor[].
  */
-#ifndef MPI2_IOUNITPAGE9_SENSOR_ENTRIES
-#define MPI2_IOUNITPAGE9_SENSOR_ENTRIES     (1)
-#endif
 
 typedef struct _MPI2_CONFIG_PAGE_IO_UNIT_9 {
 	MPI2_CONFIG_PAGE_HEADER Header;                 /*0x00 */
@@ -1273,8 +1251,7 @@ typedef struct _MPI2_CONFIG_PAGE_IO_UNIT_9 {
 	U8                      NumSensors;             /*0x0C */
 	U8                      Reserved4;              /*0x0D */
 	U16                     Reserved3;              /*0x0E */
-	MPI2_IOUNIT9_SENSOR
-		Sensor[MPI2_IOUNITPAGE9_SENSOR_ENTRIES];/*0x10 */
+	MPI2_IOUNIT9_SENSOR     Sensor[];               /*0x10 */
 } MPI2_CONFIG_PAGE_IO_UNIT_9,
 	*PTR_MPI2_CONFIG_PAGE_IO_UNIT_9,
 	Mpi2IOUnitPage9_t, *pMpi2IOUnitPage9_t;
@@ -1294,12 +1271,9 @@ typedef struct _MPI2_IOUNIT10_FUNCTION {
 	*pMpi2IOUnit10Function_t;
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check the value returned for NumFunctions at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check the value returned
+ *for NumFunctions at runtime before using Function[].
  */
-#ifndef MPI2_IOUNITPAGE10_FUNCTION_ENTRIES
-#define MPI2_IOUNITPAGE10_FUNCTION_ENTRIES      (1)
-#endif
 
 typedef struct _MPI2_CONFIG_PAGE_IO_UNIT_10 {
 	MPI2_CONFIG_PAGE_HEADER Header;                      /*0x00 */
@@ -1308,8 +1282,7 @@ typedef struct _MPI2_CONFIG_PAGE_IO_UNIT_10 {
 	U16                     Reserved2;                   /*0x06 */
 	U32                     Reserved3;                   /*0x08 */
 	U32                     Reserved4;                   /*0x0C */
-	MPI2_IOUNIT10_FUNCTION
-		Function[MPI2_IOUNITPAGE10_FUNCTION_ENTRIES];/*0x10 */
+	MPI2_IOUNIT10_FUNCTION  Function[];                  /*0x10 */
 } MPI2_CONFIG_PAGE_IO_UNIT_10,
 	*PTR_MPI2_CONFIG_PAGE_IO_UNIT_10,
 	Mpi2IOUnitPage10_t, *pMpi2IOUnitPage10_t;
@@ -1764,12 +1737,9 @@ typedef struct _MPI2_CONFIG_PAGE_BIOS_3 {
 /*BIOS Page 4 */
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check the value returned for NumPhys at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check the value returned
+ *for NumPhys at runtime before using Phy[].
  */
-#ifndef MPI2_BIOS_PAGE_4_PHY_ENTRIES
-#define MPI2_BIOS_PAGE_4_PHY_ENTRIES        (1)
-#endif
 
 typedef struct _MPI2_BIOS4_ENTRY {
 	U64                     ReassignmentWWID;       /*0x00 */
@@ -1782,8 +1752,7 @@ typedef struct _MPI2_CONFIG_PAGE_BIOS_4 {
 	U8                      NumPhys;            /*0x04 */
 	U8                      Reserved1;          /*0x05 */
 	U16                     Reserved2;          /*0x06 */
-	MPI2_BIOS4_ENTRY
-		Phy[MPI2_BIOS_PAGE_4_PHY_ENTRIES];  /*0x08 */
+	MPI2_BIOS4_ENTRY        Phy[];              /*0x08 */
 } MPI2_CONFIG_PAGE_BIOS_4, *PTR_MPI2_CONFIG_PAGE_BIOS_4,
 	Mpi2BiosPage4_t, *pMpi2BiosPage4_t;
 
@@ -2045,12 +2014,9 @@ typedef struct _MPI2_CONFIG_PAGE_RD_PDISK_0 {
 /*RAID Physical Disk Page 1 */
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check the value returned for NumPhysDiskPaths at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check the value returned
+ *for NumPhysDiskPaths at runtime before using PhysicalDiskPath[].
  */
-#ifndef MPI2_RAID_PHYS_DISK1_PATH_MAX
-#define MPI2_RAID_PHYS_DISK1_PATH_MAX   (1)
-#endif
 
 typedef struct _MPI2_RAIDPHYSDISK1_PATH {
 	U16             DevHandle;          /*0x00 */
@@ -2075,8 +2041,7 @@ typedef struct _MPI2_CONFIG_PAGE_RD_PDISK_1 {
 	U8                              PhysDiskNum;        /*0x05 */
 	U16                             Reserved1;          /*0x06 */
 	U32                             Reserved2;          /*0x08 */
-	MPI2_RAIDPHYSDISK1_PATH
-		PhysicalDiskPath[MPI2_RAID_PHYS_DISK1_PATH_MAX];/*0x0C */
+	MPI2_RAIDPHYSDISK1_PATH         PhysicalDiskPath[]; /*0x0C */
 } MPI2_CONFIG_PAGE_RD_PDISK_1,
 	*PTR_MPI2_CONFIG_PAGE_RD_PDISK_1,
 	Mpi2RaidPhysDiskPage1_t,
@@ -2502,12 +2467,9 @@ typedef struct _MPI2_SAS_IO_UNIT5_PHY_PM_SETTINGS {
 #define MPI2_SASIOUNIT5_ITE_ONE_MICROSECOND             (0)
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check the value returned for NumPhys at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check the value returned
+ *for NumPhys at runtime before using SASPhyPowerManagementSettings[].
  */
-#ifndef MPI2_SAS_IOUNIT5_PHY_MAX
-#define MPI2_SAS_IOUNIT5_PHY_MAX        (1)
-#endif
 
 typedef struct _MPI2_CONFIG_PAGE_SASIOUNIT_5 {
 	MPI2_CONFIG_EXTENDED_PAGE_HEADER    Header;   /*0x00 */
@@ -2516,7 +2478,7 @@ typedef struct _MPI2_CONFIG_PAGE_SASIOUNIT_5 {
 	U16                                 Reserved2;/*0x0A */
 	U32                                 Reserved3;/*0x0C */
 	MPI2_SAS_IO_UNIT5_PHY_PM_SETTINGS
-	SASPhyPowerManagementSettings[MPI2_SAS_IOUNIT5_PHY_MAX];/*0x10 */
+		SASPhyPowerManagementSettings[];      /*0x10 */
 } MPI2_CONFIG_PAGE_SASIOUNIT_5,
 	*PTR_MPI2_CONFIG_PAGE_SASIOUNIT_5,
 	Mpi2SasIOUnitPage5_t, *pMpi2SasIOUnitPage5_t;
@@ -2554,12 +2516,9 @@ typedef struct _MPI2_SAS_IO_UNIT6_PORT_WIDTH_MOD_GROUP_STATUS {
 #define MPI2_SASIOUNIT6_MODULATION_100_PERCENT                  (0x03)
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check the value returned for NumGroups at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check the value returned
+ *for NumGroups at runtime before using PortWidthModulationGroupStatus[].
  */
-#ifndef MPI2_SAS_IOUNIT6_GROUP_MAX
-#define MPI2_SAS_IOUNIT6_GROUP_MAX      (1)
-#endif
 
 typedef struct _MPI2_CONFIG_PAGE_SASIOUNIT_6 {
 	MPI2_CONFIG_EXTENDED_PAGE_HEADER    Header;                 /*0x00 */
@@ -2569,7 +2528,7 @@ typedef struct _MPI2_CONFIG_PAGE_SASIOUNIT_6 {
 	U8                                  Reserved3;              /*0x11 */
 	U16                                 Reserved4;              /*0x12 */
 	MPI2_SAS_IO_UNIT6_PORT_WIDTH_MOD_GROUP_STATUS
-	PortWidthModulationGroupStatus[MPI2_SAS_IOUNIT6_GROUP_MAX]; /*0x14 */
+		PortWidthModulationGroupStatus[];                   /*0x14 */
 } MPI2_CONFIG_PAGE_SASIOUNIT_6,
 	*PTR_MPI2_CONFIG_PAGE_SASIOUNIT_6,
 	Mpi2SasIOUnitPage6_t, *pMpi2SasIOUnitPage6_t;
@@ -2597,12 +2556,9 @@ typedef struct _MPI2_SAS_IO_UNIT7_PORT_WIDTH_MOD_GROUP_SETTINGS {
 
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check the value returned for NumGroups at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check the value returned
+ *for NumGroups at runtime before using PortWidthModulationGroupSettings[].
  */
-#ifndef MPI2_SAS_IOUNIT7_GROUP_MAX
-#define MPI2_SAS_IOUNIT7_GROUP_MAX      (1)
-#endif
 
 typedef struct _MPI2_CONFIG_PAGE_SASIOUNIT_7 {
 	MPI2_CONFIG_EXTENDED_PAGE_HEADER Header;             /*0x00 */
@@ -2615,7 +2571,7 @@ typedef struct _MPI2_CONFIG_PAGE_SASIOUNIT_7 {
 	U8                               Reserved4;          /*0x15 */
 	U16                              Reserved5;          /*0x16 */
 	MPI2_SAS_IO_UNIT7_PORT_WIDTH_MOD_GROUP_SETTINGS
-	PortWidthModulationGroupSettings[MPI2_SAS_IOUNIT7_GROUP_MAX];/*0x18 */
+		PortWidthModulationGroupSettings[];          /*0x18 */
 } MPI2_CONFIG_PAGE_SASIOUNIT_7,
 	*PTR_MPI2_CONFIG_PAGE_SASIOUNIT_7,
 	Mpi2SasIOUnitPage7_t, *pMpi2SasIOUnitPage7_t;
@@ -3086,12 +3042,9 @@ typedef struct _MPI2_SASPHY2_PHY_EVENT {
 
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check the value returned for NumPhyEvents at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check the value returned
+ *for NumPhyEvents at runtime before using PhyEvent[].
  */
-#ifndef MPI2_SASPHY2_PHY_EVENT_MAX
-#define MPI2_SASPHY2_PHY_EVENT_MAX      (1)
-#endif
 
 typedef struct _MPI2_CONFIG_PAGE_SAS_PHY_2 {
 	MPI2_CONFIG_EXTENDED_PAGE_HEADER
@@ -3105,7 +3058,7 @@ typedef struct _MPI2_CONFIG_PAGE_SAS_PHY_2 {
 	U16
 		Reserved3;                  /*0x0E */
 	MPI2_SASPHY2_PHY_EVENT
-		PhyEvent[MPI2_SASPHY2_PHY_EVENT_MAX]; /*0x10 */
+		PhyEvent[];                 /*0x10 */
 } MPI2_CONFIG_PAGE_SAS_PHY_2,
 	*PTR_MPI2_CONFIG_PAGE_SAS_PHY_2,
 	Mpi2SasPhyPage2_t,
@@ -3200,12 +3153,9 @@ typedef struct _MPI2_SASPHY3_PHY_EVENT_CONFIG {
 #define MPI2_SASPHY3_TFLAGS_EVENT_NOTIFY                    (0x0001)
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check the value returned for NumPhyEvents at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check the value returned
+ *for NumPhyEvents at runtime before using PhyEventConfig[].
  */
-#ifndef MPI2_SASPHY3_PHY_EVENT_MAX
-#define MPI2_SASPHY3_PHY_EVENT_MAX      (1)
-#endif
 
 typedef struct _MPI2_CONFIG_PAGE_SAS_PHY_3 {
 	MPI2_CONFIG_EXTENDED_PAGE_HEADER
@@ -3219,7 +3169,7 @@ typedef struct _MPI2_CONFIG_PAGE_SAS_PHY_3 {
 	U16
 		Reserved3;                  /*0x0E */
 	MPI2_SASPHY3_PHY_EVENT_CONFIG
-		PhyEventConfig[MPI2_SASPHY3_PHY_EVENT_MAX]; /*0x10 */
+		PhyEventConfig[];           /*0x10 */
 } MPI2_CONFIG_PAGE_SAS_PHY_3,
 	*PTR_MPI2_CONFIG_PAGE_SAS_PHY_3,
 	Mpi2SasPhyPage3_t, *pMpi2SasPhyPage3_t;
@@ -3358,12 +3308,9 @@ typedef struct _MPI2_CONFIG_PAGE_SAS_ENCLOSURE_0 {
 /*Log Page 0 */
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check the value returned for NumLogEntries at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check the value returned
+ *for NumLogEntries at runtime before using LogEntry[].
  */
-#ifndef MPI2_LOG_0_NUM_LOG_ENTRIES
-#define MPI2_LOG_0_NUM_LOG_ENTRIES          (1)
-#endif
 
 #define MPI2_LOG_0_LOG_DATA_LENGTH          (0x1C)
 
@@ -3393,8 +3340,7 @@ typedef struct _MPI2_CONFIG_PAGE_LOG_0 {
 	U32                                 Reserved2;    /*0x0C */
 	U16                                 NumLogEntries;/*0x10 */
 	U16                                 Reserved3;    /*0x12 */
-	MPI2_LOG_0_ENTRY
-		LogEntry[MPI2_LOG_0_NUM_LOG_ENTRIES]; /*0x14 */
+	MPI2_LOG_0_ENTRY                    LogEntry[];   /*0x14 */
 } MPI2_CONFIG_PAGE_LOG_0, *PTR_MPI2_CONFIG_PAGE_LOG_0,
 	Mpi2LogPage0_t, *pMpi2LogPage0_t;
 
@@ -3408,12 +3354,9 @@ typedef struct _MPI2_CONFIG_PAGE_LOG_0 {
 /*RAID Page 0 */
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check the value returned for NumElements at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check the value returned
+ *for NumElements at runtime before using ConfigElement[].
  */
-#ifndef MPI2_RAIDCONFIG0_MAX_ELEMENTS
-#define MPI2_RAIDCONFIG0_MAX_ELEMENTS       (1)
-#endif
 
 typedef struct _MPI2_RAIDCONFIG0_CONFIG_ELEMENT {
 	U16                     ElementFlags;             /*0x00 */
@@ -3446,8 +3389,7 @@ typedef struct _MPI2_CONFIG_PAGE_RAID_CONFIGURATION_0 {
 	U8                                  NumElements;    /*0x2C */
 	U8                                  Reserved2;      /*0x2D */
 	U16                                 Reserved3;      /*0x2E */
-	MPI2_RAIDCONFIG0_CONFIG_ELEMENT
-		ConfigElement[MPI2_RAIDCONFIG0_MAX_ELEMENTS]; /*0x30 */
+	MPI2_RAIDCONFIG0_CONFIG_ELEMENT     ConfigElement[];/*0x30 */
 } MPI2_CONFIG_PAGE_RAID_CONFIGURATION_0,
 	*PTR_MPI2_CONFIG_PAGE_RAID_CONFIGURATION_0,
 	Mpi2RaidConfigurationPage0_t,
@@ -3687,12 +3629,9 @@ typedef struct _MPI26_PCIE_IO_UNIT0_PHY_DATA {
 	Mpi26PCIeIOUnit0PhyData_t, *pMpi26PCIeIOUnit0PhyData_t;
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check the value returned for NumPhys at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check the value returned
+ *for NumPhys at runtime before using PhyData[].
  */
-#ifndef MPI26_PCIE_IOUNIT0_PHY_MAX
-#define MPI26_PCIE_IOUNIT0_PHY_MAX      (1)
-#endif
 
 typedef struct _MPI26_CONFIG_PAGE_PIOUNIT_0 {
 	MPI2_CONFIG_EXTENDED_PAGE_HEADER	Header; /*0x00 */
@@ -3701,7 +3640,7 @@ typedef struct _MPI26_CONFIG_PAGE_PIOUNIT_0 {
 	U8	InitStatus;                             /*0x0D */
 	U16	Reserved3;                              /*0x0E */
 	MPI26_PCIE_IO_UNIT0_PHY_DATA
-		PhyData[MPI26_PCIE_IOUNIT0_PHY_MAX];    /*0x10 */
+		PhyData[];                              /*0x10 */
 } MPI26_CONFIG_PAGE_PIOUNIT_0,
 	*PTR_MPI26_CONFIG_PAGE_PIOUNIT_0,
 	Mpi26PCIeIOUnitPage0_t, *pMpi26PCIeIOUnitPage0_t;
@@ -3993,12 +3932,9 @@ typedef struct _MPI26_PCIELINK2_LINK_EVENT {
 
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check the value returned for NumLinkEvents at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check the value returned
+ *for NumLinkEvents at runtime before using LinkEvent[].
  */
-#ifndef MPI26_PCIELINK2_LINK_EVENT_MAX
-#define MPI26_PCIELINK2_LINK_EVENT_MAX      (1)
-#endif
 
 typedef struct _MPI26_CONFIG_PAGE_PCIELINK_2 {
 	MPI2_CONFIG_EXTENDED_PAGE_HEADER	Header;	/*0x00 */
@@ -4009,7 +3945,7 @@ typedef struct _MPI26_CONFIG_PAGE_PCIELINK_2 {
 	U8	Reserved3;                  /*0x0D */
 	U16	Reserved4;                  /*0x0E */
 	MPI26_PCIELINK2_LINK_EVENT
-		LinkEvent[MPI26_PCIELINK2_LINK_EVENT_MAX];	/*0x10 */
+		LinkEvent[];                /*0x10 */
 } MPI26_CONFIG_PAGE_PCIELINK_2, *PTR_MPI26_CONFIG_PAGE_PCIELINK_2,
 	Mpi26PcieLinkPage2_t, *pMpi26PcieLinkPage2_t;
 
@@ -4067,12 +4003,9 @@ typedef struct _MPI26_PCIELINK3_LINK_EVENT_CONFIG {
 #define MPI26_PCIELINK3_TFLAGS_EVENT_NOTIFY                 (0x0001)
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check the value returned for NumLinkEvents at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check the value returned
+ *for NumLinkEvents at runtime before using LinkEventConfig[].
  */
-#ifndef MPI26_PCIELINK3_LINK_EVENT_MAX
-#define MPI26_PCIELINK3_LINK_EVENT_MAX      (1)
-#endif
 
 typedef struct _MPI26_CONFIG_PAGE_PCIELINK_3 {
 	MPI2_CONFIG_EXTENDED_PAGE_HEADER	Header;	/*0x00 */
@@ -4083,7 +4016,7 @@ typedef struct _MPI26_CONFIG_PAGE_PCIELINK_3 {
 	U8	Reserved3;                  /*0x0D */
 	U16	Reserved4;                  /*0x0E */
 	MPI26_PCIELINK3_LINK_EVENT_CONFIG
-		LinkEventConfig[MPI26_PCIELINK3_LINK_EVENT_MAX]; /*0x10 */
+		LinkEventConfig[];          /*0x10 */
 } MPI26_CONFIG_PAGE_PCIELINK_3, *PTR_MPI26_CONFIG_PAGE_PCIELINK_3,
 	Mpi26PcieLinkPage3_t, *pMpi26PcieLinkPage3_t;
 
diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_image.h b/drivers/scsi/mpt3sas/mpi/mpi2_image.h
index 33b9c3a6fd40..798ab6e33eb9 100644
--- a/drivers/scsi/mpt3sas/mpi/mpi2_image.h
+++ b/drivers/scsi/mpt3sas/mpi/mpi2_image.h
@@ -295,20 +295,9 @@ typedef struct _MPI2_EXT_IMAGE_HEADER {
 /*FLASH Layout Extended Image Data */
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check RegionsPerLayout at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check NumberOfLayouts and
+ *RegionsPerLayout at runtime before using Layout[] and Region[].
  */
-#ifndef MPI2_FLASH_NUMBER_OF_REGIONS
-#define MPI2_FLASH_NUMBER_OF_REGIONS        (1)
-#endif
-
-/*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check NumberOfLayouts at runtime.
- */
-#ifndef MPI2_FLASH_NUMBER_OF_LAYOUTS
-#define MPI2_FLASH_NUMBER_OF_LAYOUTS        (1)
-#endif
 
 typedef struct _MPI2_FLASH_REGION {
 	U8 RegionType;		/*0x00 */
@@ -325,7 +314,7 @@ typedef struct _MPI2_FLASH_LAYOUT {
 	U32 Reserved1;		/*0x04 */
 	U32 Reserved2;		/*0x08 */
 	U32 Reserved3;		/*0x0C */
-	MPI2_FLASH_REGION Region[MPI2_FLASH_NUMBER_OF_REGIONS];	/*0x10 */
+	MPI2_FLASH_REGION Region[];	/*0x10 */
 } MPI2_FLASH_LAYOUT, *PTR_MPI2_FLASH_LAYOUT,
 	Mpi2FlashLayout_t, *pMpi2FlashLayout_t;
 
@@ -339,7 +328,7 @@ typedef struct _MPI2_FLASH_LAYOUT_DATA {
 	U16 MinimumSectorAlignment;	/*0x08 */
 	U16 Reserved3;		/*0x0A */
 	U32 Reserved4;		/*0x0C */
-	MPI2_FLASH_LAYOUT Layout[MPI2_FLASH_NUMBER_OF_LAYOUTS];	/*0x10 */
+	MPI2_FLASH_LAYOUT Layout[];	/*0x10 */
 } MPI2_FLASH_LAYOUT_DATA, *PTR_MPI2_FLASH_LAYOUT_DATA,
 	Mpi2FlashLayoutData_t, *pMpi2FlashLayoutData_t;
 
@@ -373,12 +362,9 @@ typedef struct _MPI2_FLASH_LAYOUT_DATA {
 /*Supported Devices Extended Image Data */
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check NumberOfDevices at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check NumberOfDevices at
+ *runtime before using SupportedDevice[].
  */
-#ifndef MPI2_SUPPORTED_DEVICES_IMAGE_NUM_DEVICES
-#define MPI2_SUPPORTED_DEVICES_IMAGE_NUM_DEVICES    (1)
-#endif
 
 typedef struct _MPI2_SUPPORTED_DEVICE {
 	U16 DeviceID;		/*0x00 */
@@ -399,7 +385,7 @@ typedef struct _MPI2_SUPPORTED_DEVICES_DATA {
 	U8 Reserved2;		/*0x03 */
 	U32 Reserved3;		/*0x04 */
 	MPI2_SUPPORTED_DEVICE
-	SupportedDevice[MPI2_SUPPORTED_DEVICES_IMAGE_NUM_DEVICES];/*0x08 */
+	SupportedDevice[];	/*0x08 */
 } MPI2_SUPPORTED_DEVICES_DATA, *PTR_MPI2_SUPPORTED_DEVICES_DATA,
 	Mpi2SupportedDevicesData_t, *pMpi2SupportedDevicesData_t;
 
@@ -464,7 +450,7 @@ typedef struct _MPI25_ENCRYPTED_HASH_ENTRY {
 	U8		EncryptionAlgorithm;	/*0x02 */
 	U8		Reserved1;		/*0x03 */
 	U32		Reserved2;		/*0x04 */
-	U32		EncryptedHash[1];	/*0x08 */ /* variable length */
+	U32		EncryptedHash[];	/*0x08 */
 } MPI25_ENCRYPTED_HASH_ENTRY, *PTR_MPI25_ENCRYPTED_HASH_ENTRY,
 Mpi25EncryptedHashEntry_t, *pMpi25EncryptedHashEntry_t;
 
@@ -508,7 +494,7 @@ typedef struct _MPI25_ENCRYPTED_HASH_DATA {
 	U8				NumHash;		/*0x01 */
 	U16				Reserved1;		/*0x02 */
 	U32				Reserved2;		/*0x04 */
-	MPI25_ENCRYPTED_HASH_ENTRY	EncryptedHashEntry[1];  /*0x08 */
+	MPI25_ENCRYPTED_HASH_ENTRY	EncryptedHashEntry[];	/*0x08 */
 } MPI25_ENCRYPTED_HASH_DATA, *PTR_MPI25_ENCRYPTED_HASH_DATA,
 Mpi25EncryptedHashData_t, *pMpi25EncryptedHashData_t;
 
diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_ioc.h b/drivers/scsi/mpt3sas/mpi/mpi2_ioc.h
index 2c57115172cf..d92852591134 100644
--- a/drivers/scsi/mpt3sas/mpi/mpi2_ioc.h
+++ b/drivers/scsi/mpt3sas/mpi/mpi2_ioc.h
@@ -808,12 +808,9 @@ typedef struct _MPI2_EVENT_DATA_IR_PHYSICAL_DISK {
 /*Integrated RAID Configuration Change List Event data */
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check NumElements at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check NumElements at
+ *runtime before using ConfigElement[].
  */
-#ifndef MPI2_EVENT_IR_CONFIG_ELEMENT_COUNT
-#define MPI2_EVENT_IR_CONFIG_ELEMENT_COUNT          (1)
-#endif
 
 typedef struct _MPI2_EVENT_IR_CONFIG_ELEMENT {
 	U16 ElementFlags;	/*0x00 */
@@ -848,7 +845,7 @@ typedef struct _MPI2_EVENT_DATA_IR_CONFIG_CHANGE_LIST {
 	U8 ConfigNum;		/*0x03 */
 	U32 Flags;		/*0x04 */
 	MPI2_EVENT_IR_CONFIG_ELEMENT
-		ConfigElement[MPI2_EVENT_IR_CONFIG_ELEMENT_COUNT];/*0x08 */
+		ConfigElement[];/*0x08 */
 } MPI2_EVENT_DATA_IR_CONFIG_CHANGE_LIST,
 	*PTR_MPI2_EVENT_DATA_IR_CONFIG_CHANGE_LIST,
 	Mpi2EventDataIrConfigChangeList_t,
@@ -969,12 +966,9 @@ typedef struct _MPI2_EVENT_DATA_SAS_INIT_TABLE_OVERFLOW {
 /*SAS Topology Change List Event data */
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check NumEntries at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check NumEntries at
+ *runtime before using PHY[].
  */
-#ifndef MPI2_EVENT_SAS_TOPO_PHY_COUNT
-#define MPI2_EVENT_SAS_TOPO_PHY_COUNT           (1)
-#endif
 
 typedef struct _MPI2_EVENT_SAS_TOPO_PHY_ENTRY {
 	U16 AttachedDevHandle;	/*0x00 */
@@ -994,7 +988,7 @@ typedef struct _MPI2_EVENT_DATA_SAS_TOPOLOGY_CHANGE_LIST {
 	U8 ExpStatus;		/*0x0A */
 	U8 PhysicalPort;	/*0x0B */
 	MPI2_EVENT_SAS_TOPO_PHY_ENTRY
-	PHY[MPI2_EVENT_SAS_TOPO_PHY_COUNT];	/*0x0C */
+	PHY[];			/*0x0C */
 } MPI2_EVENT_DATA_SAS_TOPOLOGY_CHANGE_LIST,
 	*PTR_MPI2_EVENT_DATA_SAS_TOPOLOGY_CHANGE_LIST,
 	Mpi2EventDataSasTopologyChangeList_t,
@@ -1229,12 +1223,9 @@ typedef struct _MPI26_EVENT_DATA_PCIE_ENUMERATION {
 /*PCIe Topology Change List Event data (MPI v2.6 and later) */
 
 /*
- *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
- *one and check NumEntries at runtime.
+ *Host code (drivers, BIOS, utilities, etc.) should check NumEntries at
+ *runtime before using PortEntry[].
  */
-#ifndef MPI26_EVENT_PCIE_TOPO_PORT_COUNT
-#define MPI26_EVENT_PCIE_TOPO_PORT_COUNT        (1)
-#endif
 
 typedef struct _MPI26_EVENT_PCIE_TOPO_PORT_ENTRY {
 	U16	AttachedDevHandle;      /*0x00 */
@@ -1286,7 +1277,7 @@ typedef struct _MPI26_EVENT_DATA_PCIE_TOPOLOGY_CHANGE_LIST {
 	U8	SwitchStatus;           /*0x0A */
 	U8	PhysicalPort;           /*0x0B */
 	MPI26_EVENT_PCIE_TOPO_PORT_ENTRY
-		PortEntry[MPI26_EVENT_PCIE_TOPO_PORT_COUNT]; /*0x0C */
+		PortEntry[];            /*0x0C */
 } MPI26_EVENT_DATA_PCIE_TOPOLOGY_CHANGE_LIST,
 	*PTR_MPI26_EVENT_DATA_PCIE_TOPOLOGY_CHANGE_LIST,
 	Mpi26EventDataPCIeTopologyChangeList_t,
-- 
2.39.2

