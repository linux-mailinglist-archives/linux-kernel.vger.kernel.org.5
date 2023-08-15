Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0527C77CF26
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbjHOP27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237985AbjHOP2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:28:33 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B349C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:28:32 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FAGTxV003830;
        Tue, 15 Aug 2023 08:28:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=X52rhhnaJfUS4+lgw3taAm1Dv6OGkopQSygQ6G+3g7A=;
 b=U9FGU4MrrqYv7Ylal7lGTPOFV7E2EAA/VYrZoEDxE6rE6BPA51lZBq4KGDj0p9Fe2Lb8
 fOd+d8ibJYpCQpgXkLJVTqjxHYoMZAMgu1aAPIjlX+zBesm0uW0zzFSlW5vzRsuAGisz
 Am9MeDUu4I6ZzkAff2d0xLmPN5EgXnKB1YHC+tvfjMIANH30Oe/LaPIw2ata2EZmVAHh
 6mMxjaX0F2EZoPa25Isn6Ng0fSvjkwiS7qjETCqy448u7D4p7jsSbSLKrEG7SBVgMnh6
 5Z/jHKV3wUKNFHI47TJifho5cMvogvqKNGhgXrDS3hbaJCWWwWXgn4tVmBLJwjI4hJds ZA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3se9kjajwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:28:22 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 15 Aug
 2023 08:28:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 15 Aug 2023 08:28:20 -0700
Received: from localhost.localdomain (unknown [10.28.36.167])
        by maili.marvell.com (Postfix) with ESMTP id 1ACD83F7063;
        Tue, 15 Aug 2023 08:28:14 -0700 (PDT)
From:   Amit Singh Tomar <amitsinght@marvell.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <james.morse@arm.com>, <gcherian@marvell.com>, <robh@kernel.org>,
        <peternewman@google.com>, Amit Singh Tomar <amitsinght@marvell.com>
Subject: [RFC 11/12] arm_mpam: Fix Downstream priority mask
Date:   Tue, 15 Aug 2023 20:57:11 +0530
Message-ID: <20230815152712.1760046-12-amitsinght@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815152712.1760046-1-amitsinght@marvell.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Ca4QYOtQNqaA5F5wu-J3VSMVewF57DdI
X-Proofpoint-ORIG-GUID: Ca4QYOtQNqaA5F5wu-J3VSMVewF57DdI
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

MPAMF_PRI_IDR_NS[DSPRI_WD] determines the number of implemented bits in
the downstream priority field (MPAMCFG_PRI_NS). For instance, if the value
of DSPRI_WD is 4, then the maximum value for dspri is 0xf, and mask should
be GENMASK(3,0).

But with current implementation, it turned out to be GENMASK(4,0) .i.e.
0x1f instead of 0xf.

u16 dspri = GENMASK(rprops->dspri_wd, 0);

Let's fix it, by subtracting 1 from DSPRI_WD value.

Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
---
 drivers/platform/mpam/mpam_devices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/mpam/mpam_devices.c b/drivers/platform/mpam/mpam_devices.c
index c0c83c04c77c..59022e42920c 100644
--- a/drivers/platform/mpam/mpam_devices.c
+++ b/drivers/platform/mpam/mpam_devices.c
@@ -1099,7 +1099,7 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 	struct mpam_msc *msc = ris->msc;
 	u16 bwa_fract = MPAMCFG_MBW_MAX_MAX;
 	struct mpam_props *rprops = &ris->props;
-	u16 dspri = GENMASK(rprops->dspri_wd, 0);
+	u16 dspri = GENMASK((rprops->dspri_wd-1), 0);
 	u16 intpri = GENMASK(rprops->intpri_wd, 0);
 
 	lockdep_assert_held(&msc->lock);
-- 
2.25.1

