Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF7D773C38
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjHHQCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjHHQAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:00:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A0F6585
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:44:40 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3789Rglw020714;
        Tue, 8 Aug 2023 09:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=LASclF/q2UCpONCFOLgAFVRJKryEiKPb63o8UPv6qgM=;
 b=H3eUP2eKZYuA/TF+T8X6rHnGW6jfQq4DNFa+b7EokZVvg/+G3MobEOHzS6/+o2Kxzl2i
 dWGrsrQrhc6mfEdRjj/+DB7q4yED73EcyFRyeTSy+ZyNT+7ViyPSrTkEqZArlGia/F1E
 hTT7UXl6lQ8rEfqv4mCibc8IfgBfKrC69T2+UPhLWTtGtvsELABc1Y0OfJAtWxpUDaIu
 iN8NQU5WvVQtcxGIu6/FbeMnhtz/rWJEjMzSFyuEWIwafton5QELdlWb5i7i8VBdtTWM
 ih5obxa4r2a+u/ORz45hHSrFeB2JmJwyYPszBb/I1DnPdqAY/9knGbmxmhrxebuIwcMS Tg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbk3hrc29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 09:44:29 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3787gxWQ015347;
        Tue, 8 Aug 2023 09:44:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sb3f2px7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 09:44:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3789iQaf43975066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Aug 2023 09:44:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8BAF20043;
        Tue,  8 Aug 2023 09:44:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6C2620040;
        Tue,  8 Aug 2023 09:44:26 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  8 Aug 2023 09:44:26 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: BUG: KASAN: slab-out-of-bounds in print_synth_event+0xa68/0xa78
References: <yt9dsf8zfhw8.fsf@linux.ibm.com>
        <20230807215310.068fce2f@gandalf.local.home>
Date:   Tue, 08 Aug 2023 11:44:26 +0200
In-Reply-To: <20230807215310.068fce2f@gandalf.local.home> (Steven Rostedt's
        message of "Mon, 7 Aug 2023 21:53:10 -0400")
Message-ID: <yt9da5v1rhqd.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QqQVOXr4p3TPmhVeT2T98W-I0GMrhGE3
X-Proofpoint-GUID: QqQVOXr4p3TPmhVeT2T98W-I0GMrhGE3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_08,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Fri, 04 Aug 2023 08:20:23 +0200
> Sven Schnelle <svens@linux.ibm.com> wrote:
>
>> Hi Steven,
>> 
>> i noticed the following KASAN splat in CI (on s390):
>
> Could this actually be a bug in KASAN?
>
> The reason I ask, is because of the report.

I think the problem is that the code assigns data_offset with:

*(u32 *)&entry->fields[*n_u64] = data_offset;

but reads it with:

offset = (u32)entry->fields[n_u64];

which works on LE, but not BE.

I'm currently preparing the patch below, which also makes the code a bit
easier to read. I'm still seeing no stack traces, but at least the
random memory reads are gone and no KASAN warning anymore. I'll
continue fixing and sent a full patch as soon as everything is fixed.

From 82fc673f0d3b6031b760b4217bebdb1047119041 Mon Sep 17 00:00:00 2001
From: Sven Schnelle <svens@linux.ibm.com>
Date: Tue, 8 Aug 2023 11:35:12 +0200
Subject: [PATCH] tracing/synthetic: use union instead of casts

The current code uses a lot of casts to access the fields
member in struct synth_trace_events with different sizes.
This makes the code hard to read, and had already introduced
an endianess bug. Use a union and struct instead.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kernel/trace/trace_events_synth.c | 100 +++++++++++++++---------------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index d6a70aff2410..1f8fe7f2b5b2 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -125,9 +125,22 @@ static bool synth_event_match(const char *system, const char *event,
 		(!system || strcmp(system, SYNTH_SYSTEM) == 0);
 }
 
+struct synth_trace_data {
+	u16 len;
+	u16 offset;
+};
+
+union synth_trace_field {
+	u8 as8;
+	u16 as16;
+	u32 as32;
+	u64 as64;
+	struct synth_trace_data as_data;
+};
+
 struct synth_trace_event {
 	struct trace_entry	ent;
-	u64			fields[];
+	union synth_trace_field fields[];
 };
 
 static int synth_event_define_fields(struct trace_event_call *call)
@@ -321,19 +334,19 @@ static const char *synth_field_fmt(char *type)
 
 static void print_synth_event_num_val(struct trace_seq *s,
 				      char *print_fmt, char *name,
-				      int size, u64 val, char *space)
+				      int size, union synth_trace_field *val, char *space)
 {
 	switch (size) {
 	case 1:
-		trace_seq_printf(s, print_fmt, name, (u8)val, space);
+		trace_seq_printf(s, print_fmt, name, val->as8, space);
 		break;
 
 	case 2:
-		trace_seq_printf(s, print_fmt, name, (u16)val, space);
+		trace_seq_printf(s, print_fmt, name, val->as16, space);
 		break;
 
 	case 4:
-		trace_seq_printf(s, print_fmt, name, (u32)val, space);
+		trace_seq_printf(s, print_fmt, name, val->as32, space);
 		break;
 
 	default:
@@ -374,36 +387,26 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
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
+				struct synth_trace_data *data = &entry->fields[n_u64].as_data;
 
 				trace_seq_printf(s, print_fmt, se->fields[i]->name,
 						 STR_VAR_LEN_MAX,
-						 str_field,
+						 (char *)entry + data->offset,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64++;
 			} else {
 				trace_seq_printf(s, print_fmt, se->fields[i]->name,
 						 STR_VAR_LEN_MAX,
-						 (char *)&entry->fields[n_u64],
+						 (char *)&entry->fields[n_u64].as64,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 			}
 		} else if (se->fields[i]->is_stack) {
-			u32 offset, data_offset, len;
 			unsigned long *p, *end;
+			struct synth_trace_data *data = &entry->fields[n_u64].as_data;
 
-			offset = (u32)entry->fields[n_u64];
-			data_offset = offset & 0xffff;
-			len = offset >> 16;
-
-			p = (void *)entry + data_offset;
-			end = (void *)p + len - (sizeof(long) - 1);
+			p = (void *)entry + data->offset;
+			end = (void *)p + data->len - (sizeof(long) - 1);
 
 			trace_seq_printf(s, "%s=STACK:\n", se->fields[i]->name);
 
@@ -419,13 +422,13 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
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
+						      entry->fields[n_u64].as64,
 						      __flags);
 				trace_seq_putc(s, ')');
 			}
@@ -454,21 +457,16 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 	int ret;
 
 	if (is_dynamic) {
-		u32 data_offset;
+		struct synth_trace_data *data = &entry->fields[*n_u64].as_data;
 
-		data_offset = struct_size(entry, fields, event->n_u64);
-		data_offset += data_size;
-
-		len = fetch_store_strlen((unsigned long)str_val);
-
-		data_offset |= len << 16;
-		*(u32 *)&entry->fields[*n_u64] = data_offset;
+		data->offset = struct_size(entry, fields, event->n_u64) + data_size;
+		data->len = fetch_store_strlen((unsigned long)str_val);
 
 		ret = fetch_store_string((unsigned long)str_val, &entry->fields[*n_u64], entry);
 
 		(*n_u64)++;
 	} else {
-		str_field = (char *)&entry->fields[*n_u64];
+		str_field = (char *)&entry->fields[*n_u64].as64;
 
 #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 		if ((unsigned long)str_val < TASK_SIZE)
@@ -492,6 +490,7 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
 				 unsigned int data_size,
 				 unsigned int *n_u64)
 {
+	struct synth_trace_data *data = &entry->fields[*n_u64].as_data;
 	unsigned int len;
 	u32 data_offset;
 	void *data_loc;
@@ -515,8 +514,9 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
 	memcpy(data_loc, stack, len);
 
 	/* Fill in the field that holds the offset/len combo */
-	data_offset |= len << 16;
-	*(u32 *)&entry->fields[*n_u64] = data_offset;
+
+	data->offset = data_offset;
+	data->len = len;
 
 	(*n_u64)++;
 
@@ -592,19 +592,19 @@ static notrace void trace_event_raw_event_synth(void *__data,
 
 			switch (field->size) {
 			case 1:
-				*(u8 *)&entry->fields[n_u64] = (u8)val;
+				entry->fields[n_u64].as8 = (u8)val;
 				break;
 
 			case 2:
-				*(u16 *)&entry->fields[n_u64] = (u16)val;
+				entry->fields[n_u64].as16 = (u16)val;
 				break;
 
 			case 4:
-				*(u32 *)&entry->fields[n_u64] = (u32)val;
+				entry->fields[n_u64].as32 = (u32)val;
 				break;
 
 			default:
-				entry->fields[n_u64] = val;
+				entry->fields[n_u64].as64 = val;
 				break;
 			}
 			n_u64++;
@@ -1790,19 +1790,19 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 
 			switch (field->size) {
 			case 1:
-				*(u8 *)&state.entry->fields[n_u64] = (u8)val;
+				state.entry->fields[n_u64].as8 = (u8)val;
 				break;
 
 			case 2:
-				*(u16 *)&state.entry->fields[n_u64] = (u16)val;
+				state.entry->fields[n_u64].as16 = (u16)val;
 				break;
 
 			case 4:
-				*(u32 *)&state.entry->fields[n_u64] = (u32)val;
+				state.entry->fields[n_u64].as32 = (u32)val;
 				break;
 
 			default:
-				state.entry->fields[n_u64] = val;
+				state.entry->fields[n_u64].as64 = val;
 				break;
 			}
 			n_u64++;
@@ -1883,19 +1883,19 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 
 			switch (field->size) {
 			case 1:
-				*(u8 *)&state.entry->fields[n_u64] = (u8)val;
+				state.entry->fields[n_u64].as8 = (u8)val;
 				break;
 
 			case 2:
-				*(u16 *)&state.entry->fields[n_u64] = (u16)val;
+				state.entry->fields[n_u64].as16 = (u16)val;
 				break;
 
 			case 4:
-				*(u32 *)&state.entry->fields[n_u64] = (u32)val;
+				state.entry->fields[n_u64].as32 = (u32)val;
 				break;
 
 			default:
-				state.entry->fields[n_u64] = val;
+				state.entry->fields[n_u64].as64 = val;
 				break;
 			}
 			n_u64++;
@@ -2030,19 +2030,19 @@ static int __synth_event_add_val(const char *field_name, u64 val,
 	} else {
 		switch (field->size) {
 		case 1:
-			*(u8 *)&trace_state->entry->fields[field->offset] = (u8)val;
+			trace_state->entry->fields[field->offset].as8 = (u8)val;
 			break;
 
 		case 2:
-			*(u16 *)&trace_state->entry->fields[field->offset] = (u16)val;
+			trace_state->entry->fields[field->offset].as16 = (u16)val;
 			break;
 
 		case 4:
-			*(u32 *)&trace_state->entry->fields[field->offset] = (u32)val;
+			trace_state->entry->fields[field->offset].as32 = (u32)val;
 			break;
 
 		default:
-			trace_state->entry->fields[field->offset] = val;
+			trace_state->entry->fields[field->offset].as64 = val;
 			break;
 		}
 	}
-- 
2.39.2

