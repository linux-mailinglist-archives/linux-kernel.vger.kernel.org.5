Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480AC77CF16
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbjHOP2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbjHOP2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:28:06 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49FDE5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:28:05 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FAH7rf003857;
        Tue, 15 Aug 2023 08:27:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=p/OcC2JAIbZW0kg2Ug7j+/hs6aTTsB0s76/sSxAMZqM=;
 b=ZWZsCyi2lyn/kqnHQfCov/v8UFejV/8GF9jhgrxEndYn96R63U3DOMXmzDABUv4hJ0bn
 P3HF6MrX5zQfHXzujUcRWGS6zJEXL32xEMxRLn0T6RRcTrwMjxtLypKMIUJBT0uZYoTJ
 DVCupRSYJ3y1Bn5/ZdNSa4eet4651ezGgXh92VX+1q65IYKfOKLU0HrSdnhJngdpddD1
 N6FsCdXoRaR+TThfS2ja6QcnqGGZNnfIpxOL6Tk6z405d/g7aUHBSoIq6Rean4nC+GwY
 qYSgGqaqP+zXC/RCyWG9rvMHgASqodvef1KsVDj74cnXBxYeHCwsxhKYNPox92/WLfvX mA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3se9kjajuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:27:55 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 15 Aug
 2023 08:27:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 15 Aug 2023 08:27:53 -0700
Received: from localhost.localdomain (unknown [10.28.36.167])
        by maili.marvell.com (Postfix) with ESMTP id 6FF1A3F703F;
        Tue, 15 Aug 2023 08:27:50 -0700 (PDT)
From:   Amit Singh Tomar <amitsinght@marvell.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <james.morse@arm.com>, <gcherian@marvell.com>, <robh@kernel.org>,
        <peternewman@google.com>, Amit Singh Tomar <amitsinght@marvell.com>
Subject: [RFC 04/12] fs/resctrl: Obtain CPBM upon priority partition presence
Date:   Tue, 15 Aug 2023 20:57:04 +0530
Message-ID: <20230815152712.1760046-5-amitsinght@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815152712.1760046-1-amitsinght@marvell.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 1_wlpT1GBG-hMikF_Phai7NmtANMrjKb
X-Proofpoint-ORIG-GUID: 1_wlpT1GBG-hMikF_Phai7NmtANMrjKb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_16,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resource control group's "schemata" file represents the cache portion
bit map (XXXX), parsed from buffer with "L3:0=XXXX" format. Now, with
the introduction of priority control, "schemata" file format has changed
to "L3:0=XXXX,X", where cpbm (XXXX) is split from priority mask(X) using
using delimiter ",".

With this change, CPBM is properly fetched from schemata file when priority
partition support is present.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
 fs/resctrl/ctrlmondata.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 27d8bc25a4cb..b19ac2509e38 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -108,6 +108,9 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 	unsigned int cbm_len = r->cache.cbm_len;
 	int ret;
 
+	if (r->priority_cap)
+		buf = strsep(&buf, ",");
+
 	ret = kstrtoul(buf, 16, &val);
 	if (ret) {
 		rdt_last_cmd_printf("Non-hex character in the mask %s\n", buf);
-- 
2.25.1

