Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D805776FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjHJGG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjHJGG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:06:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F2710FE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:06:26 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A5r8hI017531;
        Thu, 10 Aug 2023 06:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=m05c/qLPzxh89HW5MXXsDJFf1NWFW8gLAgWmwTK3mQc=;
 b=S2+6cFe8obE7x0yY/my6VE0invY06BudaPqDEt1FVofSgxhubJh4UlRA21J33+VrfPMO
 GsX2+zw9Bv1VqC8AXCRoy06QWByZMpJ4bhOB0mJDeH5QKCk2yK2ps1ainZ8YntweFt4V
 m9fpFvfSG1GKP/qPTUFUov5lnkEeT39EKCl/1iCcnNETU3x+DRMXkzBSiVnPevtXqq/s
 hHiWPVB/XJu9iVUa0hWD9ZQVT/JVBDI6BQOYtDZ4kpESW5A+CVSIOmMJMNYyuHiVOZ4q
 YZJQrDmdbRj1bXbOg3aUdIYVXgB4FfVXE0WlEURFARlbMV5NAWLGG1HkZXtE4DzwsyqX zw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sct4wg896-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 06:05:57 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37A5RjMs000373;
        Thu, 10 Aug 2023 06:05:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa28kxtqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 06:05:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37A65fNx19268186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 06:05:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DA4F20043;
        Thu, 10 Aug 2023 06:05:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EA0920040;
        Thu, 10 Aug 2023 06:05:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 10 Aug 2023 06:05:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 5786BE12DF; Thu, 10 Aug 2023 08:05:41 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] tracing/synthetic: skip first entry for stack traces
Date:   Thu, 10 Aug 2023 08:05:37 +0200
Message-Id: <20230810060538.1350348-3-svens@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810060538.1350348-1-svens@linux.ibm.com>
References: <20230810060538.1350348-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K26Y4IVIinQuEsuqEkFawNANlz__25_r
X-Proofpoint-ORIG-GUID: K26Y4IVIinQuEsuqEkFawNANlz__25_r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_04,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While debugging another issue i noticed that the stack trace output
contains the number of entries on top:

         <idle>-0       [000] d..4.   203.322502: wake_lat: pid=0 delta=2268270616 stack=STACK:
=> 0x10
=> __schedule+0xac6/0x1a98
=> schedule+0x126/0x2c0
=> schedule_timeout+0x242/0x2c0
=> __wait_for_common+0x434/0x680
=> __wait_rcu_gp+0x198/0x3e0
=> synchronize_rcu+0x112/0x138
=> ring_buffer_reset_online_cpus+0x140/0x2e0
=> tracing_reset_online_cpus+0x15c/0x1d0
=> tracing_set_clock+0x180/0x1d8
=> hist_register_trigger+0x486/0x670
=> event_hist_trigger_parse+0x494/0x1318
=> trigger_process_regex+0x1d4/0x258
=> event_trigger_write+0xb4/0x170
=> vfs_write+0x210/0xad0
=> ksys_write+0x122/0x208

Fix this by skipping the first element. Also replace the pointer
logic with an index variable which is easier to read.

Fixes: 00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kernel/trace/trace_events_synth.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 7fff8235075f..80a2a832f857 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -350,7 +350,7 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 	struct trace_seq *s = &iter->seq;
 	struct synth_trace_event *entry;
 	struct synth_event *se;
-	unsigned int i, n_u64;
+	unsigned int i, j, n_u64;
 	char print_fmt[32];
 	const char *fmt;
 
@@ -389,18 +389,13 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 			}
 		} else if (se->fields[i]->is_stack) {
-			unsigned long *p, *end;
 			union trace_synth_field *data = &entry->fields[n_u64];
-
-			p = (void *)entry + data->as_dynamic.offset;
-			end = (void *)p + data->as_dynamic.len - (sizeof(long) - 1);
+			unsigned long *p = (void *)entry + data->as_dynamic.offset;
 
 			trace_seq_printf(s, "%s=STACK:\n", se->fields[i]->name);
-
-			for (; *p && p < end; p++)
-				trace_seq_printf(s, "=> %pS\n", (void *)*p);
+			for (j = 1; j < data->as_dynamic.len / sizeof(long); j++)
+				trace_seq_printf(s, "=> %pS\n", (void *)p[j]);
 			n_u64++;
-
 		} else {
 			struct trace_print_flags __flags[] = {
 			    __def_gfpflag_names, {-1, NULL} };
@@ -490,10 +485,6 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
 			break;
 	}
 
-	/* Include the zero'd element if it fits */
-	if (len < HIST_STACKTRACE_DEPTH)
-		len++;
-
 	len *= sizeof(long);
 
 	/* Find the dynamic section to copy the stack into. */
-- 
2.39.2

