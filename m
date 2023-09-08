Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57DC798B86
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 19:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244712AbjIHRgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 13:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjIHRgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 13:36:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64E61FC7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 10:36:45 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388GFXvQ003153;
        Fri, 8 Sep 2023 17:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=cykCh2nJtUncEWPDUHjA72bGPfdhWaIHDMBg+oQoI90=;
 b=MHFZh7ZDMdfnDyBeKkexO66JP33rSt3Z9MJGK6vaBBCQgR6499g/1AXJMVhgeTQMPfOg
 dzKpVOOZXZ+FMbhsUk3ugzcBHEU4aUN3+AQDc0tLkrSFGzMv8Yimej4IVAHGvWwzt8fh
 Ir0o6Ey5g8TKoX8iWATuLYHEoZryg6t1emy5hf3sogwXltHWZTD2wTX9KbI+f2ltXfgA
 /xbfKe6BtEiMa8/mgzBOjPO2oTz+t7S4pj74IALyryHmc+uIvi43g5qrTr4ppfocjmLa
 cckzpiWx+wpK/saFuAMS/dZGieD7AXHCnPmemQC+sS2thrgyxVYC3oJua0WnfSQHCLPp 0A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t06yh86yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 17:35:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 388GSeOb025349;
        Fri, 8 Sep 2023 17:35:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug9effp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 17:35:56 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 388HZtG4013827;
        Fri, 8 Sep 2023 17:35:56 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3suug9efek-1;
        Fri, 08 Sep 2023 17:35:55 +0000
From:   Vijayendra Suman <vijayendra.suman@oracle.com>
To:     avagin@google.com
Cc:     avagin@gmail.com, brauner@kernel.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        mingo@redhat.com, peterz@infradead.org, posk@google.com,
        tycho@tycho.pizza, vincent.guittot@linaro.org, wad@chromium.org,
        yu.c.chen@intel.com, Vijayendra Suman <vijayendra.suman@oracle.com>
Subject: [PATCH] perf/benchmark: Fix ifdef in header file uapi/asm/unistd_32.h
Date:   Fri,  8 Sep 2023 10:35:32 -0700
Message-ID: <20230908173532.1055882-1-vijayendra.suman@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230308073201.3102738-7-avagin@google.com>
References: <20230308073201.3102738-7-avagin@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080161
X-Proofpoint-GUID: A0Kq4ilS2KufzI-K6GNk_hw2Cd7l1Sf3
X-Proofpoint-ORIG-GUID: A0Kq4ilS2KufzI-K6GNk_hw2Cd7l1Sf3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typo error for __NR_seccomp

ifdef -> ifndef

Signed-off-by: Vijayendra Suman <vijayendra.suman@oracle.com>
---
 tools/arch/x86/include/uapi/asm/unistd_32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
index 4798f9d18fe8..9de35df1afc3 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_32.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
@@ -26,6 +26,6 @@
 #ifndef __NR_setns
 #define __NR_setns 346
 #endif
-#ifdef __NR_seccomp
+#ifndef __NR_seccomp
 #define __NR_seccomp 354
 #endif
-- 
2.41.0

