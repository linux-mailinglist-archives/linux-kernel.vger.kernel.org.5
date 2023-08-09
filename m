Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46CD7753EF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjHIHPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjHIHPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:15:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29561B6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:15:07 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3797AZ2M027378;
        Wed, 9 Aug 2023 07:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=fdjIyBRAEwBgMlXsvce97DczjdvdkDJrsttKCOu5vfw=;
 b=pdyltOdlGPP0avWUpNoahQSNetDYPhk6qbsC8RxB0kxC/ZxrMlcg1m5dmF1GK3yN0eam
 Xsw9xjpfd1xOfJRr74YbcSAz7xPtqQsEdgtcA/mYl12jxtijEccGEPUBRXh8mc27t3D9
 6sjvojHAzd9Q3tDtBFlGrr/OdBngSeiyCGaCcjAV01ESDBhaYnETRgrEfpXUNDQUyxhO
 jzU0ZCTyqINtus67jcgVWuM7zYRPxqxgfRAOcF07gLcDiPga51JeR9boPx23KE9frztj
 TSnHsJ+lz3XTUSShG/EL4IRXlWk/dI4+JA3sucwzArEohrCa7thXk8+vRurdh5G5qi/l mQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sc5uc8pqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 07:15:06 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3796AFWl007543;
        Wed, 9 Aug 2023 07:15:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa14yeap8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 07:15:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3797F2Y518350720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Aug 2023 07:15:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F7342004E;
        Wed,  9 Aug 2023 07:15:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 036D520043;
        Wed,  9 Aug 2023 07:15:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  9 Aug 2023 07:15:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id B54DAE01FC; Wed,  9 Aug 2023 09:15:01 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] tracing/synthetic: use union instead of casts
Date:   Wed,  9 Aug 2023 09:14:59 +0200
Message-Id: <20230809071459.2004931-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Vm8aWQZx7JjlYGTOEKp1vbAv3oCb8y2q
X-Proofpoint-GUID: Vm8aWQZx7JjlYGTOEKp1vbAv3oCb8y2q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_05,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code uses a lot of casts to access the fields
member in struct synth_trace_events with different sizes.
This makes the code hard to read, and had already introduced
an endianness bug. Use a union and struct instead.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
Changes in v2:
- cosmetic changes
- add struct trace_dynamic_info to include/linux/trace_events.h

 include/linux/trace_events.h      | 11 ++++
 kernel/trace/trace.h              | 10 ++++
 kernel/trace/trace_events_synth.c | 87 +++++++++++++------------------
 3 files changed, 58 insertions(+), 50 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 3930e676436c..1e8bbdb8da90 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -59,6 +59,17 @@ int trace_raw_output_prep(struct trace_iterator *iter,
 extern __printf(2, 3)
 void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...);
 
+/* Used to find the offset and length of dynamic fields in trace events */
+struct trace_dynamic_info {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	u16	offset;
+	u16	len;
+#else
+	u16	len;
+	u16	offset;
+#endif
+};
+
 /*
  * The trace entry - the most basic unit of tracing. This is what
  * is printed in the end as a single line in the trace output, such as:
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index e1edc2197fc8..deca35c39bc9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1295,6 +1295,16 @@ static inline void trace_branch_disable(void)
 /* set ring buffers to default size if not already done so */
 int tracing_update_buffers(void);
 
+struct trace_dynamic {
+	union {
+		u8				as_u8;
+		u16				as_u16;
+		u32				as_u32;
+		u64				as_u64;
+		struct trace_dynamic_info	as_dynamic;
+	};
+};
+
 struct ftrace_event_field {
 	struct list_head	link;
 	const char		*name;
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index dd398afc8e25..57beba49c888 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -127,7 +127,7 @@ static bool synth_event_match(const char *system, const char *event,
 
 struct synth_trace_event {
 	struct trace_entry	ent;
-	u64			fields[];
+	struct trace_dynamic	fields[];
 };
 
 static int synth_event_define_fields(struct trace_event_call *call)
@@ -321,19 +321,19 @@ static const char *synth_field_fmt(char *type)
 
 static void print_synth_event_num_val(struct trace_seq *s,
 				      char *print_fmt, char *name,
-				      int size, u64 val, char *space)
+				      int size, struct trace_dynamic *val, char *space)
 {
 	switch (size) {
 	case 1:
-		trace_seq_printf(s, print_fmt, name, (u8)val, space);
+		trace_seq_printf(s, print_fmt, name, val->as_u8, space);
 		break;
 
 	case 2:
-		trace_seq_printf(s, print_fmt, name, (u16)val, space);
+		trace_seq_printf(s, print_fmt, name, val->as_u16, space);
 		break;
 
 	case 4:
-		trace_seq_printf(s, print_fmt, name, (u32)val, space);
+		trace_seq_printf(s, print_fmt, name, val->as_u32, space);
 		break;
 
 	default:
@@ -374,36 +374,26 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 		/* parameter values */
 		if (se->fields[i]->is_string) {
 			if (se->fields[i]->is_dynamic) {
-				u32 offset, data_offset;
-				char *str_field;
-
-				offset = (u32)entry->fields[n_u64];
-				data_offset = offset & 0xffff;
-
-				str_field = (char *)entry + data_offset;
+				struct trace_dynamic *data = &entry->fields[n_u64];
 
 				trace_seq_printf(s, print_fmt, se->fields[i]->name,
 						 STR_VAR_LEN_MAX,
-						 str_field,
+						 (char *)entry + data->as_dynamic.offset,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64++;
 			} else {
 				trace_seq_printf(s, print_fmt, se->fields[i]->name,
 						 STR_VAR_LEN_MAX,
-						 (char *)&entry->fields[n_u64],
+						 (char *)&entry->fields[n_u64].as_u64,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 			}
 		} else if (se->fields[i]->is_stack) {
-			u32 offset, data_offset, len;
 			unsigned long *p, *end;
+			struct trace_dynamic *data = &entry->fields[n_u64];
 
-			offset = (u32)entry->fields[n_u64];
-			data_offset = offset & 0xffff;
-			len = offset >> 16;
-
-			p = (void *)entry + data_offset;
-			end = (void *)p + len - (sizeof(long) - 1);
+			p = (void *)entry + data->as_dynamic.offset;
+			end = (void *)p + data->as_dynamic.len - (sizeof(long) - 1);
 
 			trace_seq_printf(s, "%s=STACK:\n", se->fields[i]->name);
 
@@ -419,13 +409,13 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 			print_synth_event_num_val(s, print_fmt,
 						  se->fields[i]->name,
 						  se->fields[i]->size,
-						  entry->fields[n_u64],
+						  &entry->fields[n_u64],
 						  space);
 
 			if (strcmp(se->fields[i]->type, "gfp_t") == 0) {
 				trace_seq_puts(s, " (");
 				trace_print_flags_seq(s, "|",
-						      entry->fields[n_u64],
+						      entry->fields[n_u64].as_u64,
 						      __flags);
 				trace_seq_putc(s, ')');
 			}
@@ -454,21 +444,16 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 	int ret;
 
 	if (is_dynamic) {
-		u32 data_offset;
+		struct trace_dynamic *data = &entry->fields[*n_u64];
 
-		data_offset = struct_size(entry, fields, event->n_u64);
-		data_offset += data_size;
-
-		len = fetch_store_strlen((unsigned long)str_val);
-
-		data_offset |= len << 16;
-		*(u32 *)&entry->fields[*n_u64] = data_offset;
+		data->as_dynamic.offset = struct_size(entry, fields, event->n_u64) + data_size;
+		data->as_dynamic.len = fetch_store_strlen((unsigned long)str_val);
 
 		ret = fetch_store_string((unsigned long)str_val, &entry->fields[*n_u64], entry);
 
 		(*n_u64)++;
 	} else {
-		str_field = (char *)&entry->fields[*n_u64];
+		str_field = (char *)&entry->fields[*n_u64].as_u64;
 
 #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 		if ((unsigned long)str_val < TASK_SIZE)
@@ -492,6 +477,7 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
 				 unsigned int data_size,
 				 unsigned int *n_u64)
 {
+	struct trace_dynamic *data = &entry->fields[*n_u64];
 	unsigned int len;
 	u32 data_offset;
 	void *data_loc;
@@ -515,8 +501,9 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
 	memcpy(data_loc, stack, len);
 
 	/* Fill in the field that holds the offset/len combo */
-	data_offset |= len << 16;
-	*(u32 *)&entry->fields[*n_u64] = data_offset;
+
+	data->as_dynamic.offset = data_offset;
+	data->as_dynamic.len = len;
 
 	(*n_u64)++;
 
@@ -592,19 +579,19 @@ static notrace void trace_event_raw_event_synth(void *__data,
 
 			switch (field->size) {
 			case 1:
-				*(u8 *)&entry->fields[n_u64] = (u8)val;
+				entry->fields[n_u64].as_u8 = (u8)val;
 				break;
 
 			case 2:
-				*(u16 *)&entry->fields[n_u64] = (u16)val;
+				entry->fields[n_u64].as_u16 = (u16)val;
 				break;
 
 			case 4:
-				*(u32 *)&entry->fields[n_u64] = (u32)val;
+				entry->fields[n_u64].as_u32 = (u32)val;
 				break;
 
 			default:
-				entry->fields[n_u64] = val;
+				entry->fields[n_u64].as_u64 = val;
 				break;
 			}
 			n_u64++;
@@ -1791,19 +1778,19 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 
 			switch (field->size) {
 			case 1:
-				*(u8 *)&state.entry->fields[n_u64] = (u8)val;
+				state.entry->fields[n_u64].as_u8 = (u8)val;
 				break;
 
 			case 2:
-				*(u16 *)&state.entry->fields[n_u64] = (u16)val;
+				state.entry->fields[n_u64].as_u16 = (u16)val;
 				break;
 
 			case 4:
-				*(u32 *)&state.entry->fields[n_u64] = (u32)val;
+				state.entry->fields[n_u64].as_u32 = (u32)val;
 				break;
 
 			default:
-				state.entry->fields[n_u64] = val;
+				state.entry->fields[n_u64].as_u64 = val;
 				break;
 			}
 			n_u64++;
@@ -1884,19 +1871,19 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 
 			switch (field->size) {
 			case 1:
-				*(u8 *)&state.entry->fields[n_u64] = (u8)val;
+				state.entry->fields[n_u64].as_u8 = (u8)val;
 				break;
 
 			case 2:
-				*(u16 *)&state.entry->fields[n_u64] = (u16)val;
+				state.entry->fields[n_u64].as_u16 = (u16)val;
 				break;
 
 			case 4:
-				*(u32 *)&state.entry->fields[n_u64] = (u32)val;
+				state.entry->fields[n_u64].as_u32 = (u32)val;
 				break;
 
 			default:
-				state.entry->fields[n_u64] = val;
+				state.entry->fields[n_u64].as_u64 = val;
 				break;
 			}
 			n_u64++;
@@ -2031,19 +2018,19 @@ static int __synth_event_add_val(const char *field_name, u64 val,
 	} else {
 		switch (field->size) {
 		case 1:
-			*(u8 *)&trace_state->entry->fields[field->offset] = (u8)val;
+			trace_state->entry->fields[field->offset].as_u8 = (u8)val;
 			break;
 
 		case 2:
-			*(u16 *)&trace_state->entry->fields[field->offset] = (u16)val;
+			trace_state->entry->fields[field->offset].as_u16 = (u16)val;
 			break;
 
 		case 4:
-			*(u32 *)&trace_state->entry->fields[field->offset] = (u32)val;
+			trace_state->entry->fields[field->offset].as_u32 = (u32)val;
 			break;
 
 		default:
-			trace_state->entry->fields[field->offset] = val;
+			trace_state->entry->fields[field->offset].as_u64 = val;
 			break;
 		}
 	}
-- 
2.39.2

