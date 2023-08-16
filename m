Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DB477EDF9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 01:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347232AbjHPXsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 19:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347254AbjHPXsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 19:48:11 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F92272B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 16:48:09 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GNfhfJ023635;
        Wed, 16 Aug 2023 16:47:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PPS06212021; bh=WVU2u
        zKddnXlCad+ANAGfo3SuoARuRz7UHij1ZIKRUM=; b=pvzn10MqvW87VWv1UyoIR
        4G99mGvVbqQ1fH7cy63RzF3R5SjTGpqZyrnDANWrpYDRfScKYiWetIC6Zl407HiG
        74F69+iHKoBrgwFS8IToosZKnU1xj758ynHXZyUE3g0qb2ZVZsyGP6ux07QcdGP5
        Ps3XBcjN2pEJ6iSxNLKoSZjz5fWy4i07IEEQ4s4xxaAKAO/cQBUZk4v7fg6MQMeW
        pin7CQGfd65gRPORHZu6n/75e8yIALUdD34I+I+JTuHWPCN9KuLte+4KlntFa1Fz
        Gp3JkENGuxyaGZlj0UHQ89BzTSsgj+9KJHeW3OR+8CVgvNMSU6QlaVAFR55ULjHT
        g==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3se5byc9yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Aug 2023 16:47:48 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 16:47:46 -0700
Received: from pek-lpd-ccm5.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 16:47:45 -0700
From:   Yun Zhou <yun.zhou@windriver.com>
To:     <pmladek@suse.com>, <senozhatsky@chromium.org>,
        <rostedt@goodmis.org>, <john.ogness@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] printk: fix the check on modifying printk_devkmsg
Date:   Thu, 17 Aug 2023 07:47:45 +0800
Message-ID: <20230816234745.2856989-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: S1zsWk9kFgbPTxjuIUphhA9z9JVyB0M6
X-Proofpoint-ORIG-GUID: S1zsWk9kFgbPTxjuIUphhA9z9JVyB0M6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_21,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=789 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308160211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we use 'echo' to write a string to printk_devkmsg, it writes '\0' at
the end. It means lenp is larger then the length of string 1. However,
sometimes we write data with string length by other way, e.g
    write(fd, string, strlen(string));
In this case, the writing will fail.

Comparing err with string length is able to handle all scenarios.

Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 357a4d18f6387..992872f7b7747 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -229,7 +229,7 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 		 * Do not accept an unknown string OR a known string with
 		 * trailing crap...
 		 */
-		if (err < 0 || (err + 1 != *lenp)) {
+		if (err != strlen(devkmsg_log_str)) {
 
 			/* ... and restore old setting. */
 			devkmsg_log = old;
-- 
2.27.0

