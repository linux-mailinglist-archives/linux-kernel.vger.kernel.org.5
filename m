Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913CF77CF17
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbjHOP2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbjHOP2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:28:07 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1843F1980
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:28:06 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FAXQ1G003906;
        Tue, 15 Aug 2023 08:27:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=DETGQIxwT57vHR/twWLuXydvnHEcnwHAYSDGPy/HrsA=;
 b=PtN6IRRYyJXjS8V8V9d5ML98DddlqH04g/4SWGITiftWMJtxVm2ioR08mNlfROPU9Cgr
 T2G76CgFcflESllHcx4qt4aYiLZNBe3KOGqnZUetG8/DXyCq8PmKMtL/6BAqC2hU/Gw+
 Y6me/aGNT96tCcNHj9++Jli5QVAj1EuXx73ksuVQjGcsgN6WOatGRv5TFs7JmP+TrcVo
 aYSr/3oI1HjQ6sF4XlY/mrzRHD5Rgm85ydoIrM8JThrnT/RPNZbMZDQsE91URqU3oRFy
 Tdnxa1RjBvd/ozPcpR5b6FHjEZCgW5fGW+urMB2WJgzCpIVevUqzMafrvOiAXfaaJ3ME kw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3se9kjajup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:27:52 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 15 Aug
 2023 08:27:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 15 Aug 2023 08:27:49 -0700
Received: from localhost.localdomain (unknown [10.28.36.167])
        by maili.marvell.com (Postfix) with ESMTP id DE0043F704D;
        Tue, 15 Aug 2023 08:27:46 -0700 (PDT)
From:   Amit Singh Tomar <amitsinght@marvell.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <james.morse@arm.com>, <gcherian@marvell.com>, <robh@kernel.org>,
        <peternewman@google.com>, Amit Singh Tomar <amitsinght@marvell.com>
Subject: [RFC 03/12] arm_mpam: resctrl: Define new schemata format for priority partition
Date:   Tue, 15 Aug 2023 20:57:03 +0530
Message-ID: <20230815152712.1760046-4-amitsinght@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815152712.1760046-1-amitsinght@marvell.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: F1CvY0tOobqxZ8jV9wcP6oHBXQH31a6J
X-Proofpoint-ORIG-GUID: F1CvY0tOobqxZ8jV9wcP6oHBXQH31a6J
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

At the moment, "schemata" file contains information about cache portion
bitmap (CPBM), and memory bandwidth allocation (MBA) in the following
format.

MB:0=0100
L3:0=ffff

Lets' update the "schemata" file to accommodate information about
priority partition control that indicates downstream priority value.

For instance:

L3:0=ffff,f

CPBM is separated from downstream priority value using delimiter ",".

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
 drivers/platform/mpam/mpam_resctrl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/mpam/mpam_resctrl.c b/drivers/platform/mpam/mpam_resctrl.c
index 09618d9ceb1d..1081ceac41a8 100644
--- a/drivers/platform/mpam/mpam_resctrl.c
+++ b/drivers/platform/mpam/mpam_resctrl.c
@@ -711,7 +711,11 @@ static int mpam_resctrl_resource_init(struct mpam_resctrl_res *res)
 		r->cache.min_cbm_bits = 1;
 
 		/* TODO: kill these properties off as they are derivatives */
-		r->format_str = "%d=%0*x";
+		if (mpam_has_feature(mpam_feat_dspri_part, &class->props))
+			r->format_str = "%d=%0*x,%0*x";
+		else
+			r->format_str = "%d=%0*x";
+
 		r->fflags = RFTYPE_RES_CACHE;
 		r->default_ctrl = BIT_MASK(class->props.cpbm_wd) - 1;
 		r->data_width = (class->props.cpbm_wd + 3) / 4;
-- 
2.25.1

