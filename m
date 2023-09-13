Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AF079EDC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjIMP4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjIMP4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:56:35 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FD119BB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:56:31 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DEk1Z4030010
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:56:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=22ok7B2PvqkfYpwpJ7o1ydqnVK288ID8TPWPyMwUpkc=;
 b=WQtwkF0oDXlT2fcSv0kWupviemeqjGr5Y331rfPJy0R6pXn0fq0WGzeA2ixvDemcRsbI
 M5zKkDXvCsU7QpBiz2EI3S9F4H6aUfsFN0EZfzw4tEKV9BTg1JNeN5uuiSzG/A3+RlGC
 juAMWbnogCYOidIsFujVpUuoMVFWDL42ac7a0suW5ED/JqzZya2cbT/hXfoTLoaQSC2U
 a0omo5uy9tdbp/NS44CVrWTwG710J02HgxgBxvochxqg8q8s+4INHb/o18wTdCM9oLTa
 tSrBqavmB4X0T5ThBQktj3cuM+ixjUXNka47sVP+j+9Fp+3T5jCGbc6kwgOpJyBWPRY3 uQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t2y8thcpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:56:30 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 13 Sep 2023 08:56:29 -0700
Received: by devvm715.rva0.facebook.com (Postfix, from userid 240176)
        id 7EDD52954BBFD; Wed, 13 Sep 2023 08:56:27 -0700 (PDT)
From:   Michal Grzedzicki <mge@meta.com>
To:     Michal Grzedzicki <mge@meta.com>
CC:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jack Wang <jinpu.wang@ionos.com>
Subject: [PATCH v2 1/2] pm80xx: Use phy specific sas address when sending PHY_START command
Date:   Wed, 13 Sep 2023 08:56:10 -0700
Message-ID: <20230913155611.3183612-1-mge@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAMGffE=kWc1rsNfn6n8d1qkYw2U8sz+n5E-GEkWB7=835j=66g@mail.gmail.com>
References: <CAMGffE=kWc1rsNfn6n8d1qkYw2U8sz+n5E-GEkWB7=835j=66g@mail.gmail.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: k8CN-VpHXw8kupVN6c3fDidXT3m3rIuQ
X-Proofpoint-ORIG-GUID: k8CN-VpHXw8kupVN6c3fDidXT3m3rIuQ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_10,2023-09-13_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cards have more than one sas addresses. Using incorrect
address causes communication issues with some devices like expanders.

Closes: https://lore.kernel.org/linux-kernel/A57AEA84-5CA0-403E-8053-106033=
C73C70@fb.com/
Signed-off-by: Michal Grzedzicki <mge@meta.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
---
Changes in v2: add Closes tag

 drivers/scsi/pm8001/pm8001_hwi.c | 2 +-
 drivers/scsi/pm8001/pm80xx_hwi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_=
hwi.c
index 33053db5a713..90069c7b1642 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -4180,7 +4180,7 @@ pm8001_chip_phy_start_req(struct pm8001_hba_info *pm8=
001_ha, u8 phy_id)
 	payload.sas_identify.dev_type =3D SAS_END_DEVICE;
 	payload.sas_identify.initiator_bits =3D SAS_PROTOCOL_ALL;
 	memcpy(payload.sas_identify.sas_addr,
-		pm8001_ha->sas_addr, SAS_ADDR_SIZE);
+		&pm8001_ha->phy[phy_id].dev_sas_addr, SAS_ADDR_SIZE);
 	payload.sas_identify.phy_id =3D phy_id;
=20
 	return pm8001_mpi_build_cmd(pm8001_ha, 0, opcode, &payload,
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_=
hwi.c
index f6857632dc7c..1b2c40b1381c 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -4671,7 +4671,7 @@ pm80xx_chip_phy_start_req(struct pm8001_hba_info *pm8=
001_ha, u8 phy_id)
 	payload.sas_identify.dev_type =3D SAS_END_DEVICE;
 	payload.sas_identify.initiator_bits =3D SAS_PROTOCOL_ALL;
 	memcpy(payload.sas_identify.sas_addr,
-	  &pm8001_ha->sas_addr, SAS_ADDR_SIZE);
+		&pm8001_ha->phy[phy_id].dev_sas_addr, SAS_ADDR_SIZE);
 	payload.sas_identify.phy_id =3D phy_id;
=20
 	return pm8001_mpi_build_cmd(pm8001_ha, 0, opcode, &payload,
--=20
2.34.1

