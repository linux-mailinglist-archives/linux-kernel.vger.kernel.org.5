Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453957902B6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 22:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345140AbjIAUDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 16:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjIAUDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 16:03:05 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB4010FB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 13:03:02 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381JleLi006212
        for <linux-kernel@vger.kernel.org>; Fri, 1 Sep 2023 13:03:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=BPcApJWT4X2Kdtrx48P0NsTRU0nDKLKQN3AZc406RNY=;
 b=ZUEhtYROekL14Yri4xAcnF+7G6CofbAKAc+UYCsyZilH8nsWgunI6GzU8RM+QXB+UtK9
 DwqelI+segHbm0l49LJFXIpzWRFY4nhgv98LPUkZnrLWvv1JO2gOIecvk9o76dGNHKH0
 wBfj07LIi8RfNwYwWZBUQO1r/IQOtsUex+bTUJtPNTxrZASLpWgYwgx+JyG6IwxNgxvb
 J2IEydWzeoTtP+nKo5RBulpf534IA0araNYiDB3PM3LsFn9QvzNmYa4tJ46Ez5K5Nfij
 j9/GTrcjlXDa4+QYSsqKIypjTs0ldA8M3HrVn6ZH6Swr1Yq76RJGFwJ1uYLlmFOGLDCc XQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3suf0kd9b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 13:03:01 -0700
Received: from twshared2727.06.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 1 Sep 2023 13:03:01 -0700
Received: by devvm5565.lla0.facebook.com (Postfix, from userid 378941)
        id 4B91012907BB; Fri,  1 Sep 2023 13:02:49 -0700 (PDT)
From:   Pawel Zmarzly <pzmarzly@meta.com>
To:     <Niklas.Cassel@wdc.com>
CC:     Damien Le Moal <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Pawel Zmarzly <pzmarzly@meta.com>
Subject: [PATCH v3] ata: Disable NCQ_TRIM on Micron 1100 drives
Date:   Fri, 1 Sep 2023 13:02:21 -0700
Message-ID: <20230901200220.3891806-1-pzmarzly@meta.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <ZPIyxg+iSWa+W93Q@x1-carbon>
References: <ZPIyxg+iSWa+W93Q@x1-carbon>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nwd0JTLi8b_uUNdReQqIFZk8aExxPiHY
X-Proofpoint-GUID: nwd0JTLi8b_uUNdReQqIFZk8aExxPiHY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_16,2023-08-31_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Micron 1100 drives lock up when encountering queued TRIM command.
It is a quite old hardware series, for past years we have been
running our machines with these drives using
libata.force=3Dnoncqtrim.

Signed-off-by: Pawel Zmarzly <pzmarzly@meta.com>
---
V1 -> V2: Fixed formatting.
V2 -> V3: Added missing Signed off line. Sorry, this is my
first time upstreaming.

 drivers/ata/libata-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 175b2a9dc000..116f5fd6e3f7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4564,6 +4564,8 @@ static const struct ata_blacklist_entry ata_device_=
blacklist [] =3D {
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Micron_1100_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },

 	/* devices that don't properly handle TRIM commands */
 	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
--
2.39.3
