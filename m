Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877E2777003
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjHJGKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjHJGKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:10:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA30211E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:10:46 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A67DAe022760;
        Thu, 10 Aug 2023 06:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=aHwaYRnkxa+7Cx2tcdB6vCxEkjdPaozZFSi/y5fWKic=;
 b=U6eWXaL+0W/Fz9i4tToWkZuiw8IvO5QTnErfqkjbC9rZLHz9ZfoHb1h4MsHbTIIM5b0Z
 6wzH3UAbE8WTmJLQrIo+y3n20VLxYY+T9c3dfBqL9kKANnXjEvEEu4ox0SD3i1t5Btqe
 4cZCIDKuj2DcnK2AHMK8KRE6Msu2VwiyMJH1296xQA8aQJl2KNfBfedI3UVa44I/QlSL
 X8tAy925A+BL0+tf5OyFVg6rvXJK1azbwQ+r0Kd34RvIc4x5Tta3bkZyhRKd1zKv8g/s
 kPPQgBavJlqmX1QTAOdTAhPQhuqaOvpuJYq5D5giTBZ8Gmuyq6rt4Vfl4u/Vp7cwUCl0 rg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sct4w0aed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 06:10:44 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37A65a6j015363;
        Thu, 10 Aug 2023 06:05:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sb3f38k9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 06:05:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37A65fR144695848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 06:05:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE73820043;
        Thu, 10 Aug 2023 06:05:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABAC720040;
        Thu, 10 Aug 2023 06:05:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 10 Aug 2023 06:05:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 5367DE0331; Thu, 10 Aug 2023 08:05:41 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] few fixes for synthetic trace events
Date:   Thu, 10 Aug 2023 08:05:35 +0200
Message-Id: <20230810060538.1350348-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -yOQTQqq9AHg7H0TD8l5uIkTgt2aVQtb
X-Proofpoint-ORIG-GUID: -yOQTQqq9AHg7H0TD8l5uIkTgt2aVQtb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_04,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

I'm now sending these patches in one patchset, because the second patch
has a dependeny on the union vs. cast fix.

Changes in v3:
- remove superfluous struct around union trace_synth_field

Changes in v2:
- cosmetic changes
- add struct trace_dynamic_info to include/linux/trace_events.h

Sven Schnelle (3):
  tracing/synthetic: use union instead of casts
  tracing/synthetic: skip first entry for stack traces
  tracing/synthetic: allocate one additional element for size

 include/linux/trace_events.h      |  11 ++++
 kernel/trace/trace.h              |   8 +++
 kernel/trace/trace_events_synth.c | 103 ++++++++++++------------------
 3 files changed, 60 insertions(+), 62 deletions(-)

-- 
2.39.2

