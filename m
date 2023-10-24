Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DA97D4BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjJXJRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjJXJRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:17:53 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C332D8E;
        Tue, 24 Oct 2023 02:17:50 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39O9ETbO032110;
        Tue, 24 Oct 2023 09:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=JXibhBa4y9KDybxnd7ZPC7vRWnp+48AJkXxnzC/PeTo=;
 b=GABldOpc2vcoqjRI9z9Nw3ZWJBGz/dWh5GLF2gllsg04kpwzhYwEmgsoWgSwGj/17ISu
 8eKfu0hQ6ad5+SNOZH9+Yz3+BkAuca62ah9f+FtlolNP6jwTKPLl+h64rijYlqrGUjWG
 jbft7CorJN3u0tQdyudDOyyGt003qvxF6DKydLRbWagHkZofn3y1hvmSww5x8jyQnioH
 cEOgVKS7eRbo7oEwdkuXDkoEt2ghDgxcjsivRMpsq+eOOGrYfpa9Uxeo3peF9qhVQeDM
 opI8yDTyD0YzNp93MY1M+ArI9WLxt7t0m5rtdXZSgZtTexMdOGtXRHCUrMVKNbbIXzaW sA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txb4ag3js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 09:17:46 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39O905id024381;
        Tue, 24 Oct 2023 09:17:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvu6jx262-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 09:17:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39O9Hgub16450226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 09:17:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5297C2004B;
        Tue, 24 Oct 2023 09:17:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29ABE20040;
        Tue, 24 Oct 2023 09:17:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 24 Oct 2023 09:17:42 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf report: Add s390 raw data interpretation for PAI counters
Date:   Tue, 24 Oct 2023 11:17:29 +0200
Message-Id: <20231024091729.4180034-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HCjMG11keVWICvvCuRY2_UyzZrDqE1Bw
X-Proofpoint-ORIG-GUID: HCjMG11keVWICvvCuRY2_UyzZrDqE1Bw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_07,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
---
 tools/perf/util/s390-cpumcf-kernel.h |  2 +
 tools/perf/util/s390-sample-raw.c    | 89 ++++++++++++++++++++++++++--
 2 files changed, 85 insertions(+), 6 deletions(-)

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
index 115b16edb451..f360aed3bf0a 100644
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
@@ -212,27 +215,101 @@ static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample *sample)
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
+	evsel->pmu = perf_pmus__find_by_type(evsel->core.attr.type);
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
+
+		if (offset + 0xa > len)
+			break;
+	}
+	color_fprintf(stdout, color, "\n");
+}
+
 /* S390 specific trace event function. Check for PERF_RECORD_SAMPLE events
  * and if the event was triggered by a counter set diagnostic event display
  * its raw data.
  * The function is only invoked when the dump flag -D is set.
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
+	if (evsel == NULL)
 		return;
 
 	/* Display raw data on screen */
-	if (!s390_cpumcfdg_testctr(sample)) {
-		pr_err("Invalid counter set data encountered\n");
+	if (evsel->core.attr.config == PERF_EVENT_CPUM_CF_DIAG) {
+		evsel->pmu = perf_pmus__find("cpum_cf");
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
+	if (!s390_pai_all_test(sample))
+		pr_err("Invalid %s raw data encountered\n", pai_name);
+	else
+		s390_pai_all_dump(evsel, sample);
 }
-- 
2.41.0

