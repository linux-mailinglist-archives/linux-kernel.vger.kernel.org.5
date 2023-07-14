Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7AA7536CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbjGNJk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbjGNJkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:40:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7749A12C;
        Fri, 14 Jul 2023 02:40:52 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E9eXDZ007302;
        Fri, 14 Jul 2023 09:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=EOladUREwXyQgtzOGYpQ18+lQ8itlhY+pxWpN7ftXHI=;
 b=myTritGK/+205UC+9wiWjYE+DFefUvx3FbXQMaWHHy/8z4NWS1ne8UYWr/mwjEs09yIY
 VVJ1GDe+qcaxSNOUNFIec+jjiveeFXDuMAht5q++ntYVfRtQcYqsnVRK/pGAErnAMH0x
 fr3Dh3UNV10WR4LdnLrhvsLjkp2HPyRLRZSxOkVQFjM+uLuJFlFOwnVpYCKj8Za6/7DC
 /BL9GkZjqk0z0SsWMwWPABD+VJaIe25NpVUBgeoIsmBRxrcW38i30aD/npcT45W8Fuyb
 JyxdPnibI+r9DlPHCEBVbBVsvvIj2tG30QhAyGTCAfSbO8XxyljRAirMaG2A0POFPcew lg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru3ke8hep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 09:40:42 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36E7dc6A031282;
        Fri, 14 Jul 2023 09:40:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rtpvu10j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 09:40:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36E9edEK16581218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 09:40:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE68320043;
        Fri, 14 Jul 2023 09:40:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9C2220040;
        Fri, 14 Jul 2023 09:40:35 +0000 (GMT)
Received: from li-a1f1b24c-1ef0-11b2-a85c-b2994f3f6269.ibm.com.com (unknown [9.171.52.229])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jul 2023 09:40:35 +0000 (GMT)
From:   Likhitha Korrapati <likhitha@linux.ibm.com>
To:     shuah@kernel.org, trenn@suse.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ricklind@linux.vnet.ibm.com, latha@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com,
        Likhitha Korrapati <likhitha@linux.ibm.com>,
        Pavithra Prakash <pavrampu@linux.vnet.ibm.com>
Subject: [PATCH v3] cpupower: Fix cpuidle_set to accept only numeric values for idle-set operation.
Date:   Fri, 14 Jul 2023 15:10:21 +0530
Message-Id: <20230714094021.199611-1-likhitha@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7joR9lVc48FTlhKUdxduHbEMtPZn2-zI
X-Proofpoint-ORIG-GUID: 7joR9lVc48FTlhKUdxduHbEMtPZn2-zI
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_04,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For both the d and e options in 'cpupower idle_set' command, an
atoi() conversion is done without checking if the input argument
is all numeric. So, an atoi conversion is done on any character
provided as input and the CPU idle_set operation continues with
that integer value, which may not be what is intended or entirely
correct.

The output of cpuidle-set before patch is as follows:

[root@xxx cpupower]# cpupower idle-set -e 1$
Idlestate 1 enabled on CPU 0
[snip]
Idlestate 1 enabled on CPU 47

[root@xxx cpupower]# cpupower idle-set -e 11
Idlestate 11 not available on CPU 0
[snip]
Idlestate 11 not available on CPU 47

[root@xxx cpupower]# cpupower idle-set -d 12
Idlestate 12 not available on CPU 0
[snip]
Idlestate 12 not available on CPU 47

[root@xxx cpupower]# cpupower idle-set -d qw
Idlestate 0 disabled on CPU 0
[snip]
Idlestate 0 disabled on CPU 47

This patch adds a check for both d and e options in cpuidle-set.c
to see that the idle_set value is all numeric before doing a
string-to-int conversion using strtol().

The output of cpuidle-set after the patch is as below:

[root@xxx cpupower]# ./cpupower idle-set -e 1$
Bad idle_set value: 1$. Integer expected

[root@xxx cpupower]# ./cpupower idle-set -e 11
Idlestate 11 not available on CPU 0
[snip]
Idlestate 11 not available on CPU 47

[root@xxx cpupower]# ./cpupower idle-set -d 12
Idlestate 12 not available on CPU 0
[snip]
Idlestate 12 not available on CPU 47

[root@xxx cpupower]# ./cpupower idle-set -d qw
Bad idle_set value: qw. Integer expected

Signed-off-by: Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
Signed-off-by: Likhitha Korrapati <likhitha@linux.ibm.com>
Tested-by: Pavithra Prakash <pavrampu@linux.vnet.ibm.com>
Reviewed-by: Rick Lindsley <ricklind@linux.vnet.ibm.com>
---

** changes since v1 [1] **

- Addressed reviewed comments from v1.
- Slightly reworded the commit for clarity.

** changes since v2 [2] **

- Addressed reviewed comments from v2.

[1] https://lore.kernel.org/all/20210105122452.8687-1-latha@linux.vnet.ibm.com/
[2] https://lore.kernel.org/all/20230410121054.61622-1-likhitha@linux.ibm.com/

 tools/power/cpupower/utils/cpuidle-set.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/power/cpupower/utils/cpuidle-set.c b/tools/power/cpupower/utils/cpuidle-set.c
index 46158928f9ad..a551d1d4ac51 100644
--- a/tools/power/cpupower/utils/cpuidle-set.c
+++ b/tools/power/cpupower/utils/cpuidle-set.c
@@ -41,14 +41,6 @@ int cmd_idle_set(int argc, char **argv)
 			cont = 0;
 			break;
 		case 'd':
-			if (param) {
-				param = -1;
-				cont = 0;
-				break;
-			}
-			param = ret;
-			idlestate = atoi(optarg);
-			break;
 		case 'e':
 			if (param) {
 				param = -1;
@@ -56,7 +48,13 @@ int cmd_idle_set(int argc, char **argv)
 				break;
 			}
 			param = ret;
-			idlestate = atoi(optarg);
+			strtol(optarg, &endptr, 10);
+			if (*endptr != '\0') {
+				printf(_("Bad value: %s, Integer expected\n"), optarg);
+				exit(EXIT_FAILURE);
+			} else {
+				idlestate = atoi(optarg);
+			}
 			break;
 		case 'D':
 			if (param) {
-- 
2.31.1

