Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098FD78E3B2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 02:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344610AbjHaAED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 20:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237781AbjHaAEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:04:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987A7CDA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:03:58 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 37UN7ruj001335
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:03:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=9w64N/q3DFoDcjGEuuQm5zoxeFSu57f6UwIHrvy8DEw=;
 b=KeJ7m5v5PEYtuPM4/BRyIRx1T7FMS1IEmrlgtyc35Bl1RlouQEQR7v0lyb18mgsPviIK
 F0ru8TPs6NV1lv8pNreWa5Gt5rZI1a/dKLPbCBeRimb1sa2mj16XNLn+yJnJOKoXMp4c
 EFEcuh2QCkMWI2grHh3afWZy6vtKv6bYeZFEV/m0+l1BMkqjB+jlmv7OSRKRm82BSxAm
 Uk3JVgX9X26cGgbIoIJ0K9XeaLnTxQDxqLR2cl5/OYSbqmFJ70ez6uQ6m9Tjj26lp4wZ
 uCLeTbEU2F2f11XtFK7Rg1y3L84GW0enK4/0pjWH7cmrCh2x8jzJzTyx43HOBOuOJiTG 0Q== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3st4dn641n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:03:57 -0700
Received: from twshared6713.09.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 30 Aug 2023 17:03:57 -0700
Received: by devvm5565.lla0.facebook.com (Postfix, from userid 378941)
        id 5840BED8EAE; Wed, 30 Aug 2023 17:03:50 -0700 (PDT)
From:   Pawel Zmarzly <pzmarzly@meta.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Pawel Zmarzly <pzmarzly@meta.com>
Subject: [PATCH] ata: Disable NCQ_TRIM on Micron 1100 drives
Date:   Wed, 30 Aug 2023 17:02:22 -0700
Message-ID: <20230831000222.576254-1-pzmarzly@meta.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _wgjkYMd9z9RiZkOn1lgHLYS11qMj9Gg
X-Proofpoint-ORIG-GUID: _wgjkYMd9z9RiZkOn1lgHLYS11qMj9Gg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_19,2023-08-29_01,2023-05-22_02
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
 drivers/ata/libata-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 175b2a9dc000..d2466f2c5fea 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4564,6 +4564,8 @@ static const struct ata_blacklist_entry ata_device_=
blacklist [] =3D {
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Micron_1100_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+					ATA_HORKAGE_ZERO_AFTER_TRIM, },
=20
 	/* devices that don't properly handle TRIM commands */
 	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
--=20
2.39.3

