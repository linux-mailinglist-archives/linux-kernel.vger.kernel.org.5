Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71616775E5A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjHIMDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjHIMDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:03:20 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1891C10FE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:03:20 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379Bx2eu008332;
        Wed, 9 Aug 2023 12:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Mw+vT/vprGVjVsvyLN5x9N+BUpJpZRVbJjgOxjWcfIw=;
 b=DgfUCNJ6BtsL98lstUblDe8c7wcIO+Ha5urLZZHcaWiEc5dLJWUEN1XyUqdwKSC85jOl
 uvycYvkaJt/XvZeKKDtTf0hAkmXRireTzqY9N7Qlz6bQrhuPS4fIbApz4JMYYcRSgxLD
 jd+iq3mUK62K6+QJ6FjiejohLkFHgoriTM7bmLGKeMsm0qsexRjEEiHAN7wkWpeiJTou
 NaRTL0SzmoVp4g0sHOO4U51Riu3eSeU3WTOaLhJmuB9bkvLkniD60HprtH3LNLG5wAZ5
 dedMdNPLSvOOoIvtPLYhFm0ymj/sny8ppt3EcmI5By3LmEgCOmA+NbmhQ7qYAPk4yu9y pg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scade83pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 12:02:51 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 379BodjU000403;
        Wed, 9 Aug 2023 12:02:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa28kqs39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 12:02:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 379C2hJX28967320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Aug 2023 12:02:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F80220043;
        Wed,  9 Aug 2023 12:02:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CD9B20040;
        Wed,  9 Aug 2023 12:02:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  9 Aug 2023 12:02:43 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id B3732E0331; Wed,  9 Aug 2023 14:02:42 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracing/synthetic: skip first entry for stack traces
Date:   Wed,  9 Aug 2023 14:02:32 +0200
Message-Id: <20230809120233.890987-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RAXd9mPEdADiq518uO-2OtFbhtFy3DSC
X-Proofpoint-GUID: RAXd9mPEdADiq518uO-2OtFbhtFy3DSC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_10,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090102
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
index 57beba49c888..cf5d0e352810 100644
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
 			struct trace_dynamic *data = &entry->fields[n_u64];
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

