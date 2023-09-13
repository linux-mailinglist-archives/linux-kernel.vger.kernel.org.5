Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9932E79EDC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjIMP4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjIMP4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:56:53 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C7B19A0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:56:49 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DEkFlo019744
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:56:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=fiL8lHnS1pF+d9K7wzC8R+oSznDkNywF+yHkLggREm0=;
 b=YKg5UPqunQQMCv73yKxpZNQeVcUqZHPmdnuqdToBWfCd4n3HelL+sA7K2uQw0/dq84tJ
 rMfoOisluP03/wEcnQBKoa9HauizE54+A51FIEtGStBUKKwaf60cCAZV2n42hv/7viqT
 4SBy2SSsNf5dqJqi+oj/DAZDeakYd9s3iqlXBDnDkY392jBQ04Xj1xM7KOxkKDdAU8Ai
 q9xlFRSKMEtKAKU/7tgEGiwrb5EWHr8ymjUkJylpiDtuI/jr6Dvx7lLsPEXRWM+EmYrA
 RfC2/NMC+U8Nhh4u3vyevkVquyt3IJ6tBNCaaGs2ROGvsWAyHmZt7neZumbkGEOUFiEt BA== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t2y8d9a5t-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:56:48 -0700
Received: from twshared1579.04.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 13 Sep 2023 08:56:44 -0700
Received: by devvm715.rva0.facebook.com (Postfix, from userid 240176)
        id A8A382954BC63; Wed, 13 Sep 2023 08:56:40 -0700 (PDT)
From:   Michal Grzedzicki <mge@meta.com>
To:     Michal Grzedzicki <mge@meta.com>
CC:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jack Wang <jinpu.wang@ionos.com>
Subject: [PATCH 2/2] pm80xx: Avoid leaking tags when processing OPC_INB_SET_CONTROLLER_CONFIG command
Date:   Wed, 13 Sep 2023 08:56:11 -0700
Message-ID: <20230913155611.3183612-2-mge@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913155611.3183612-1-mge@meta.com>
References: <CAMGffE=kWc1rsNfn6n8d1qkYw2U8sz+n5E-GEkWB7=835j=66g@mail.gmail.com>
 <20230913155611.3183612-1-mge@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 89--Qm83UGY5nYeMNqWcB0J_T2DbMIRO
X-Proofpoint-ORIG-GUID: 89--Qm83UGY5nYeMNqWcB0J_T2DbMIRO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_10,2023-09-13_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tags allocated for OPC_INB_SET_CONTROLLER_CONFIG command need to be freed
when we receive the response.

Fixes: f5860992db55 ("[SCSI] pm80xx: Added SPCv/ve specific hardware func=
tionalities and relevant changes in common files")
Fixes: a6cb3d012b98 ("[SCSI] pm80xx: thermal, sas controller config and e=
rror handling update")
Signed-off-by: Michal Grzedzicki <mge@meta.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80x=
x_hwi.c
index 1b2c40b1381c..3afd9443c425 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3671,10 +3671,12 @@ static int mpi_set_controller_config_resp(struct =
pm8001_hba_info *pm8001_ha,
 			(struct set_ctrl_cfg_resp *)(piomb + 4);
 	u32 status =3D le32_to_cpu(pPayload->status);
 	u32 err_qlfr_pgcd =3D le32_to_cpu(pPayload->err_qlfr_pgcd);
+	u32 tag =3D le32_to_cpu(pPayload->tag);
=20
 	pm8001_dbg(pm8001_ha, MSG,
 		   "SET CONTROLLER RESP: status 0x%x qlfr_pgcd 0x%x\n",
 		   status, err_qlfr_pgcd);
+	pm8001_tag_free(pm8001_ha, tag);
=20
 	return 0;
 }
--=20
2.34.1

