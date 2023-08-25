Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC481787F75
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbjHYF5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbjHYF5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:57:04 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F47C1BC7;
        Thu, 24 Aug 2023 22:56:59 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P5mhtc000886;
        Fri, 25 Aug 2023 05:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=fBcNg7nrqFTeiSI9dFwDO6F4qFylvBduUrHomehxa0o=;
 b=hf/EWLnjd9mN+C4jg29Mi4WXxDRdHFT2IbqHepdo4CdjG7yP4+V5SyBA/j/DB9Fjk0BX
 EruROpZkQrac2V0U1Mn8drjQBXmMqa12JiI4Lask+aC6S8KsuR0NzBgOHBWrDmtgcvpK
 UW3ykaMycMhAJeNMRbrgiXW75aLElc/2PQ9VH3lrlvOWqPWUuZqfc4L8PQNNIuubKDfh
 tUm+kRr9/dlbY45uwPyqkHWNu3nWw9UufPcvBnWxtt7v6Er6RPluc9h5APaEhBonlPF4
 ftcwrRAVEiZgiE8pC+sgnW3vkillmSce+/eI7DqVhNfCO8fJge5IenAxMc1OqOY/MIlK TQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3spp7yrfes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 05:56:49 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37P5AiPH027388;
        Fri, 25 Aug 2023 05:56:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sn20sw8e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 05:56:48 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37P5ujaw40894724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 05:56:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B473C20040;
        Fri, 25 Aug 2023 05:56:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 457192004D;
        Fri, 25 Aug 2023 05:56:37 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.34.48])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 25 Aug 2023 05:56:36 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        disgoel@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        kjain@linux.ibm.com,
        Krishan Gopal Sarawast <krishang@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf/hv-24x7: Update domain value check
Date:   Fri, 25 Aug 2023 11:26:01 +0530
Message-Id: <20230825055601.360083-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: drY0TB5CReKrbIZpSzvvpa_clyRS0WtC
X-Proofpoint-ORIG-GUID: drY0TB5CReKrbIZpSzvvpa_clyRS0WtC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_04,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1011 mlxscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valid domain value is in range 1 to HV_PERF_DOMAIN_MAX.
Current code has check for domain value greater than or
equal to HV_PERF_DOMAIN_MAX. But the check for domain value 0
is missing.
Fix this issue by adding check for domain value 0.

Fixes: ebd4a5a3ebd9 ("powerpc/perf/hv-24x7: Minor improvements")
Reported-by: Krishan Gopal Sarawast <krishang@linux.vnet.ibm.com> 
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 317175791d23..644881cc1c00 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1418,7 +1418,7 @@ static int h_24x7_event_init(struct perf_event *event)
 	}
 
 	domain = event_get_domain(event);
-	if (domain >= HV_PERF_DOMAIN_MAX) {
+	if (domain  == 0 || domain >= HV_PERF_DOMAIN_MAX) {
 		pr_devel("invalid domain %d\n", domain);
 		return -EINVAL;
 	}
-- 
2.35.3

