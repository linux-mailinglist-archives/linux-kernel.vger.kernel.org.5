Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEFA7E816A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbjKJS1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346015AbjKJSZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:25:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD2A2B7AF;
        Fri, 10 Nov 2023 03:09:22 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAAgve8029049;
        Fri, 10 Nov 2023 11:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=y1Bsfkel8W3lC6YtmqwhR4UW9ZqgUzbACQGFct4ivts=;
 b=iQkgyNv7kVPPYBnem12fpSs1sOXATBDaV9hH2tE4Q+ySM+9t0uM3YrKhQRPMmyCYe8lS
 fcGq/s8ooVrbdHJ00AS9iSXuDKe/HDSY7Q97Pg8qganEp8hSM/L2LMZzjbwH6j5u2/vK
 zvKK0MMZyZTPDBlMhDYUpv7qd2fV5RGckN1Kw/pdY+ceujF8+2bjlkCIXjJfWOLiOWqF
 S7oCX78oS2EggvotqgNEwtsKthyWHYfCwO2TO7kX6C0kZ7SAzhFubPKpT068USIgxe0q
 SoQ5CXkxtYvfEvn2jabSYuR50ZDtMJQf3UoaFtRdTOKIfXcmuiuE9wi5t9Mo4wL406x7 yA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9k0nrmvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 11:09:20 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAAJtcj004132;
        Fri, 10 Nov 2023 11:09:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w21ack9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 11:09:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AAB9G5o55968240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 11:09:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55DE72004B;
        Fri, 10 Nov 2023 11:09:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14B4020040;
        Fri, 10 Nov 2023 11:09:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Nov 2023 11:09:16 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v3] perf report: Add s390 raw data interpretation for PAI counters
Date:   Fri, 10 Nov 2023 12:09:08 +0100
Message-Id: <20231110110908.2312308-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 84UcwRC6R8hxl-nDP6fdmQ3RdDoF6a02
X-Proofpoint-GUID: 84UcwRC6R8hxl-nDP6fdmQ3RdDoF6a02
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_07,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1bf54f32f525 ("s390/pai: Add support for cryptography counters")
added support for Processor Activity Instrumentation Facility (PAI)
counters.  These counters values are added as raw data with the perf
sample during perf record.
Now add support to display these counters in perf report command.
The counter number, its assigned name and value is now printed in
addition to the hexadecimal output.

Output before:
 # perf report -D

 6 514766399626050 0x7b058 [0x48]: PERF_RECORD_SAMPLE(IP, 0x1):
				303977/303977: 0 period: 1 addr: 0
 ... thread: paitest:303977
 ...... dso: <not found>

 0x7b0a0@/root/perf.data.paicrypto [0x48]: event: 9
 .
 . ... raw event: size 72 bytes
 . 0000:  00 00 00 09 00 01 00 48 00 00 00 00 00 00 00 00  .......H........
 . 0010:  00 04 a3 69 00 04 a3 69 00 01 d4 2d 76 de a0 bb  ...i...i...-v...
 . 0020:  00 00 00 00 00 01 5c 53 00 00 00 06 00 00 00 00  ......\S........
 . 0030:  00 00 00 00 00 00 00 01 00 00 00 0c 00 07 00 00  ................
 . 0040:  00 00 00 53 96 af 00 00                          ...S....

Output after:
 # perf report -D

 6 514766399626050 0x7b058 [0x48]: PERF_RECORD_SAMPLE(IP, 0x1):
				303977/303977: 0 period: 1 addr: 0
 ... thread: paitest:303977
 ...... dso: <not found>

 0x7b0a0@/root/perf.data.paicrypto [0x48]: event: 9
 .
 . ... raw event: size 72 bytes
 . 0000:  00 00 00 09 00 01 00 48 00 00 00 00 00 00 00 00  .......H........
 . 0010:  00 04 a3 69 00 04 a3 69 00 01 d4 2d 76 de a0 bb  ...i...i...-v...
 . 0020:  00 00 00 00 00 01 5c 53 00 00 00 06 00 00 00 00  ......\S........
 . 0030:  00 00 00 00 00 00 00 01 00 00 00 0c 00 07 00 00  ................
 . 0040:  00 00 00 53 96 af 00 00                          ...S....

        Counter:007 km_aes_128 Value:0x00000000005396af     <--- new

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 tools/perf/util/s390-cpumcf-kernel.h |   2 +
 tools/perf/util/s390-sample-raw.c    | 104 ++++++++++++++++++++++++---
 2 files changed, 98 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/s390-cpumcf-kernel.h b/tools/perf/util/s390-cpumcf-kernel.h
index f55ca07f3ca1..74b36644e384 100644
--- a/tools/perf/util/s390-cpumcf-kernel.h
+++ b/tools/perf/util/s390-cpumcf-kernel.h
@@ -12,6 +12,8 @@
 #define	S390_CPUMCF_DIAG_DEF	0xfeef	/* Counter diagnostic entry ID */
 #define	PERF_EVENT_CPUM_CF_DIAG	0xBC000	/* Event: Counter sets */
 #define PERF_EVENT_CPUM_SF_DIAG	0xBD000 /* Event: Combined-sampling */
+#define PERF_EVENT_PAI_CRYPTO_ALL	0x1000 /* Event: CRYPTO_ALL */
+#define PERF_EVENT_PAI_NNPA_ALL	0x1800 /* Event: NNPA_ALL */
 
 struct cf_ctrset_entry {	/* CPU-M CF counter set entry (8 byte) */
 	unsigned int def:16;	/* 0-15  Data Entry Format */
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 115b16edb451..d4dc84aa889a 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -125,6 +125,9 @@ static int get_counterset_start(int setnr)
 		return 128;
 	case CPUMF_CTR_SET_MT_DIAG:		/* Diagnostic counter set */
 		return 448;
+	case PERF_EVENT_PAI_NNPA_ALL:		/* PAI NNPA counter set */
+	case PERF_EVENT_PAI_CRYPTO_ALL:		/* PAI CRYPTO counter set */
+		return setnr;
 	default:
 		return -1;
 	}
@@ -212,27 +215,112 @@ static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample *sample)
 	}
 }
 
+/*
+ * Check for consistency of PAI_CRYPTO/PAI_NNPA raw data.
+ */
+struct pai_data {		/* Event number and value */
+	u16 event_nr;
+	u64 event_val;
+} __packed;
+
+/*
+ * Test for valid raw data. At least one PAI event should be in the raw
+ * data section.
+ */
+static bool s390_pai_all_test(struct perf_sample *sample)
+{
+	unsigned char *buf = sample->raw_data;
+	size_t len = sample->raw_size;
+
+	if (len < 0xa || !buf)
+		return false;
+	return true;
+}
+
+static void s390_pai_all_dump(struct evsel *evsel, struct perf_sample *sample)
+{
+	size_t len = sample->raw_size, offset = 0;
+	unsigned char *p = sample->raw_data;
+	const char *color = PERF_COLOR_BLUE;
+	struct pai_data pai_data;
+	char *ev_name;
+
+	while (offset < len) {
+		memcpy(&pai_data.event_nr, p, sizeof(pai_data.event_nr));
+		pai_data.event_nr = be16_to_cpu(pai_data.event_nr);
+		p += sizeof(pai_data.event_nr);
+		offset += sizeof(pai_data.event_nr);
+
+		memcpy(&pai_data.event_val, p, sizeof(pai_data.event_val));
+		pai_data.event_val = be64_to_cpu(pai_data.event_val);
+		p += sizeof(pai_data.event_val);
+		offset += sizeof(pai_data.event_val);
+
+		ev_name = get_counter_name(evsel->core.attr.config,
+					   pai_data.event_nr, evsel->pmu);
+		color_fprintf(stdout, color, "\tCounter:%03d %s Value:%#018lx\n",
+			      pai_data.event_nr, ev_name ?: "<unknown>",
+			      pai_data.event_val);
+		free(ev_name);
+
+		if (offset + 0xa > len)
+			break;
+	}
+	color_fprintf(stdout, color, "\n");
+}
+
 /* S390 specific trace event function. Check for PERF_RECORD_SAMPLE events
- * and if the event was triggered by a counter set diagnostic event display
- * its raw data.
+ * and if the event was triggered by a
+ * - counter set diagnostic event
+ * - processor activity assist (PAI) crypto counter event
+ * - processor activity assist (PAI) neural network processor assist (NNPA)
+ *   counter event
+ * display its raw data.
  * The function is only invoked when the dump flag -D is set.
+ *
+ * Function evlist__s390_sample_raw() is defined as call back after it has
+ * been verified that the perf.data file was created on s390 platform.
  */
-void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event, struct perf_sample *sample)
+void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
+			     struct perf_sample *sample)
 {
+	const char *pai_name;
 	struct evsel *evsel;
 
 	if (event->header.type != PERF_RECORD_SAMPLE)
 		return;
 
 	evsel = evlist__event2evsel(evlist, event);
-	if (evsel == NULL ||
-	    evsel->core.attr.config != PERF_EVENT_CPUM_CF_DIAG)
+	if (!evsel)
 		return;
 
 	/* Display raw data on screen */
-	if (!s390_cpumcfdg_testctr(sample)) {
-		pr_err("Invalid counter set data encountered\n");
+	if (evsel->core.attr.config == PERF_EVENT_CPUM_CF_DIAG) {
+		if (!evsel->pmu)
+			evsel->pmu = perf_pmus__find("cpum_cf");
+		if (!s390_cpumcfdg_testctr(sample))
+			pr_err("Invalid counter set data encountered\n");
+		else
+			s390_cpumcfdg_dump(evsel->pmu, sample);
 		return;
 	}
-	s390_cpumcfdg_dump(evsel->pmu, sample);
+
+	switch (evsel->core.attr.config) {
+	case PERF_EVENT_PAI_NNPA_ALL:
+		pai_name = "NNPA_ALL";
+		break;
+	case PERF_EVENT_PAI_CRYPTO_ALL:
+		pai_name = "CRYPTO_ALL";
+		break;
+	default:
+		return;
+	}
+
+	if (!s390_pai_all_test(sample)) {
+		pr_err("Invalid %s raw data encountered\n", pai_name);
+	} else {
+		if (!evsel->pmu)
+			evsel->pmu = perf_pmus__find_by_type(evsel->core.attr.type);
+		s390_pai_all_dump(evsel, sample);
+	}
 }
-- 
2.41.0

