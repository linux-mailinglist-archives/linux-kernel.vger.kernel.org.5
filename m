Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A2777CF28
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbjHOP3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237986AbjHOP2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:28:35 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9DA9C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:28:34 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FEFUMn008839;
        Tue, 15 Aug 2023 08:28:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=xtVORT7UOszKxIDuVayi97n1+3u19XMryXAicFeBbxc=;
 b=OU+qmQNq/LUsnrlCLeQEAgFrTqChaBlQc9synke3UQr3GiIXtGfgaiVrLmHEbYWBDjCp
 yMqcgOr77esXnSkWfe3ueZSxuGGi+6iGAz8bXTgRl/MjEnKaMy2G0HU3OWDrlYEYvG33
 qkuHVtbuAeYscNtI3a91cZYuHqQ8naI+wBRR6AtZTHr0DhycuzL9eS78fW+u35CBTpdB
 CHWkgtL4e4IOIX43hbdHGMZnsyhcIWbTGZ6UflhG/Bera3iQpeSYL6qOaEpusLIHNsb/
 HdypEORdP+V9fZRPqEg2QS/70y9p8RxvDSNhhF7CKMpCOV1kN9paWuvFHMLW5kXf6CW6 Gg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sgaydr8bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:28:23 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 15 Aug
 2023 08:28:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 15 Aug 2023 08:28:21 -0700
Received: from localhost.localdomain (unknown [10.28.36.167])
        by maili.marvell.com (Postfix) with ESMTP id A05013F7069;
        Tue, 15 Aug 2023 08:28:18 -0700 (PDT)
From:   Amit Singh Tomar <amitsinght@marvell.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <james.morse@arm.com>, <gcherian@marvell.com>, <robh@kernel.org>,
        <peternewman@google.com>, Amit Singh Tomar <amitsinght@marvell.com>
Subject: [RFC 12/12] arm_mpam: Program Downstream priority value
Date:   Tue, 15 Aug 2023 20:57:12 +0530
Message-ID: <20230815152712.1760046-13-amitsinght@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815152712.1760046-1-amitsinght@marvell.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YwdFVKD8zCPk4BzDY7B-Nps8cy0E9OfM
X-Proofpoint-ORIG-GUID: YwdFVKD8zCPk4BzDY7B-Nps8cy0E9OfM
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

Now that Downstream priorities values can be passed from resource control
schemata file, let's program it into memory mapped Priority Partition
Configuration Register.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
TODO:
	* Invert Priority value based on DSPRI_0_IS_LOW, suggested
          by James. 
---
 drivers/platform/mpam/mpam_devices.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/mpam/mpam_devices.c b/drivers/platform/mpam/mpam_devices.c
index 59022e42920c..8af6424bb27b 100644
--- a/drivers/platform/mpam/mpam_devices.c
+++ b/drivers/platform/mpam/mpam_devices.c
@@ -1153,8 +1153,12 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 
 		if (mpam_has_feature(mpam_feat_intpri_part, rprops))
 			pri_val |= FIELD_PREP(MPAMCFG_PRI_INTPRI, intpri);
-		if (mpam_has_feature(mpam_feat_dspri_part, rprops))
-			pri_val |= FIELD_PREP(MPAMCFG_PRI_DSPRI, dspri);
+		if (mpam_has_feature(mpam_feat_dspri_part, rprops)) {
+			if (mpam_has_feature(mpam_feat_dspri_part, cfg)) {
+				pri_val |= FIELD_PREP(MPAMCFG_PRI_DSPRI, cfg->dspri & dspri);
+			} else
+				pri_val |= FIELD_PREP(MPAMCFG_PRI_DSPRI, dspri);
+		}
 
 		mpam_write_partsel_reg(msc, PRI, pri_val);
 	}
-- 
2.25.1

