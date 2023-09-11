Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C954479BDA9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359578AbjIKWRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243293AbjIKRD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:03:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A89C121
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:03:53 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BGBJ1I013538
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:03:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=V3jmQO6lm/Fik2gbNmDLJuXzSPZHZ8U9ZHR6J/IYPsk=;
 b=W5faw5A/XAF2wiYgzjERaokzBiqIBkPSszG4K8s8IdXSqNeR3ld19iet1Su9UfSC0keZ
 Xm0VSLzeQCuKsLZfLo99sYjuCpxySLDgoDIEtTsBNdP1TaIZbTNoBL/BE0FjF26WHt8D
 7FKNqwTbzo0ApuljFhrN7kU0DOrfua8Pq9JkuVo3BGW/1sirJbKx2apFKumhBRGJAJ7w
 izYng4ZtJ4fSTKBda3/kwlVzPQSVqeSJ2AAubPWTIJR/Onv3rE6vybgv2Nat/uXMgXPj
 NQ9ekI/ZMOgRqGXIZb9X5N2xYTPGAawr1frvJ6mTxUKR47QO5NOQmq7BA3dt+bfmErJY Pw== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t21ju33qv-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:03:52 -0700
Received: from twshared2388.07.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 11 Sep 2023 10:03:51 -0700
Received: by devvm715.rva0.facebook.com (Postfix, from userid 240176)
        id 04794292AEF84; Mon, 11 Sep 2023 10:03:48 -0700 (PDT)
From:   Michal Grzedzicki <mge@meta.com>
To:     Michal Grzedzicki <mge@meta.com>
CC:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] pm80xx: Avoid leaking tags when processing OPC_INB_SET_CONTROLLER_CONFIG command
Date:   Mon, 11 Sep 2023 10:03:40 -0700
Message-ID: <20230911170340.699533-2-mge@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911170340.699533-1-mge@meta.com>
References: <20230911170340.699533-1-mge@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: md94_JSwGiNtkxP8FFUFTH9DMzlN7Bc1
X-Proofpoint-GUID: md94_JSwGiNtkxP8FFUFTH9DMzlN7Bc1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_12,2023-09-05_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tags allocated for OPC_INB_SET_CONTROLLER_CONFIG command need to be freed
when we receive the response.

Signed-off-by: Michal Grzedzicki <mge@meta.com>
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

