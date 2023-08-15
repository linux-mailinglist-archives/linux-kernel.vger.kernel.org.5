Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1211877CF23
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbjHOP2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbjHOP2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:28:22 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB6C1980
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:28:21 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FEGDav009581;
        Tue, 15 Aug 2023 08:28:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=asH4VG1rGKa6TkvnGN1MYErwMVnT8I4Q1dhZqaGW3dU=;
 b=g2Ii2jy5x61i2oHXlwBBc9VBl7svxA5Sn1n9uRk+QvGBjwuF5l5kuFlbTaA/LMqM7y5/
 xF3n4DiQqsLkaTjVzA+NgIxyXcu8VYIQ7Skmx19YLoP8c02I9NPq/azc/qJXN9m4gK15
 +2U9AKt+MQbGNkJ6mwTGcI06/5sMdE6Lvy3Ej+RAeJDcsYt4eyzXPBdncNaj991p5WEh
 FHoV9oTBMbnbLqGrgPuIyF4BbGxsCubxnRnrEIyf2R2WGxtBOAMfk7diwvj4csKX1cV5
 Ufaj9Z6y9SAov93MXd7iOx0DdJqCiuvJuaeR7l5PdtPya+QT6fngpFp5D1WzMEwiwgmH +g== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sgaydr8ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:28:09 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 15 Aug
 2023 08:28:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 15 Aug 2023 08:28:07 -0700
Received: from localhost.localdomain (unknown [10.28.36.167])
        by maili.marvell.com (Postfix) with ESMTP id 838203F7063;
        Tue, 15 Aug 2023 08:28:04 -0700 (PDT)
From:   Amit Singh Tomar <amitsinght@marvell.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <james.morse@arm.com>, <gcherian@marvell.com>, <robh@kernel.org>,
        <peternewman@google.com>, Amit Singh Tomar <amitsinght@marvell.com>
Subject: [RFC 08/12] fs/resctrl: Schemata write only for intended resource
Date:   Tue, 15 Aug 2023 20:57:08 +0530
Message-ID: <20230815152712.1760046-9-amitsinght@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815152712.1760046-1-amitsinght@marvell.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: cKQIw9HIp8d4U9z8Dm66O8f6HbV9_9Br
X-Proofpoint-ORIG-GUID: cKQIw9HIp8d4U9z8Dm66O8f6HbV9_9Br
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_16,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, schemata write (for Cache Portion Bit Map or Memory Bandwidth
Allocation) goes through list of all the resources (supported by schemata),
and regardless of write for one resource, it attempts to write for all other
resources.

As an example, When the intended write is for only MBA resource, it
attempts (by calling resctrl_arch_update_domains) to write for CPBM
as well. Fix it, by doing schemata write based on input schemata supplied
from user.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
 fs/resctrl/ctrlmondata.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 8c8a4d09d22c..ffeb68270968 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -354,9 +354,11 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 		if (is_mba_sc(r))
 			continue;
 
-		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
-		if (ret)
-			goto out;
+		if (!strcmp(resname, s->name)) {
+			ret = resctrl_arch_update_domains(r, rdtgrp->closid);
+			if (ret)
+				goto out;
+		}
 	}
 
 	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
-- 
2.25.1

