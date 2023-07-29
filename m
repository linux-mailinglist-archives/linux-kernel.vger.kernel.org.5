Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A241E767D2C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 10:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjG2IhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 04:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjG2IhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 04:37:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BFB448D;
        Sat, 29 Jul 2023 01:37:12 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36T8XdcF010886;
        Sat, 29 Jul 2023 08:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XeK4Sf5juNaQH99VDRhIaB3pMmMFubU2ytlj8MSnGig=;
 b=k5F8lY8gleFrWSw+4yFnHuA1Cn+roFCc6botNgplIUJj7561MPH84ayLKHGAG4W4tarQ
 r3IAVOMs9CGG6XJtVgZFGz896WjKhBQbg71YphdWnmHNSNbBL5bl/D8Kvb8gQcMfieOs
 9WIg+AzfnIaYjiUQhq1yU22+LIQHmwRmTKSpysZci15VeOgB0Hi0FRgTgBFlY9MYh3Je
 jK6B/dWKoJd13cXl4fj4lmrvRddw4RRYAEcHkz3EXbvHPkztellztF8YsPVDmMeDZXMO
 nXU52/ZgaF8QOkkwU2rfGQ0JN+UTgG4SarnOngaOhyAKIP4vvS3RfcnD/3Ah4YFFwPmb Zw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s4xpt8t6u-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Jul 2023 08:36:50 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36T5m1ho002278;
        Sat, 29 Jul 2023 07:35:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0unkcbtw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Jul 2023 07:35:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36T7ZXTD20841122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jul 2023 07:35:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7F7620040;
        Sat, 29 Jul 2023 07:35:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A944520043;
        Sat, 29 Jul 2023 07:35:30 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.171.60.192])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 29 Jul 2023 07:35:30 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, disgoel@linux.ibm.com,
        kjain@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: [PATCH v4 07/10] powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity domain via domain information
Date:   Sat, 29 Jul 2023 13:04:52 +0530
Message-Id: <20230729073455.7918-8-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230729073455.7918-1-kjain@linux.ibm.com>
References: <20230729073455.7918-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gJdRYkVTtnigIZOHx0glgf-Nyoap21h2
X-Proofpoint-GUID: gJdRYkVTtnigIZOHx0glgf-Nyoap21h2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307290078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hcall H_GET_PERF_COUNTER_INFO with counter request value as
AFFINITY_DOMAIN_INFORMATION_BY_DOMAIN(0XB0), can be used to get
the system affinity domain via domain information. To expose the system
affinity domain via domain information, patch adds sysfs file called
"affinity_domain_via_domain" to the "/sys/devices/hv_gpci/interface/"
of hv_gpci pmu driver.

Add new entry for AFFINITY_DOMAIN_VIA_DOM in sysinfo_counter_request
array, which points to the counter request value
"affinity_domain_via_domain" in hv-gpci.c file.

The affinity_domain_via_domain sysfs file is only available for power10
and above platforms. Add a macro called
INTERFACE_AFFINITY_DOMAIN_VIA_DOM_ATTR, which points to the index of NULL
placeholder, for affinity_domain_via_domain attribute in interface_attrs
array. Also updated the value of INTERFACE_NULL_ATTR macro in hv-gpci.c
file.

Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 arch/powerpc/perf/hv-gpci.c | 80 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 68502cb18262..326b758df7c8 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -106,19 +106,22 @@ static ssize_t cpumask_show(struct device *dev,
 #define INTERFACE_PROCESSOR_BUS_TOPOLOGY_ATTR	6
 #define INTERFACE_PROCESSOR_CONFIG_ATTR		7
 #define INTERFACE_AFFINITY_DOMAIN_VIA_VP_ATTR	8
-#define INTERFACE_NULL_ATTR			9
+#define INTERFACE_AFFINITY_DOMAIN_VIA_DOM_ATTR	9
+#define INTERFACE_NULL_ATTR			10
 
 /* Counter request value to retrieve system information */
 enum {
 	PROCESSOR_BUS_TOPOLOGY,
 	PROCESSOR_CONFIG,
 	AFFINITY_DOMAIN_VIA_VP, /* affinity domain via virtual processor */
+	AFFINITY_DOMAIN_VIA_DOM, /* affinity domain via domain */
 };
 
 static int sysinfo_counter_request[] = {
 	[PROCESSOR_BUS_TOPOLOGY] = 0xD0,
 	[PROCESSOR_CONFIG] = 0x90,
 	[AFFINITY_DOMAIN_VIA_VP] = 0xA0,
+	[AFFINITY_DOMAIN_VIA_DOM] = 0xB0,
 };
 
 static DEFINE_PER_CPU(char, hv_gpci_reqb[HGPCI_REQ_BUFFER_SIZE]) __aligned(sizeof(uint64_t));
@@ -389,6 +392,72 @@ static ssize_t affinity_domain_via_virtual_processor_show(struct device *dev,
 	return ret;
 }
 
+static ssize_t affinity_domain_via_domain_show(struct device *dev, struct device_attribute *attr,
+						char *buf)
+{
+	struct hv_gpci_request_buffer *arg;
+	unsigned long ret;
+	size_t n = 0;
+
+	arg = (void *)get_cpu_var(hv_gpci_reqb);
+	memset(arg, 0, HGPCI_REQ_BUFFER_SIZE);
+
+	/*
+	 * Pass the counter request 0xB0 corresponds to request
+	 * type 'Affinity_domain_information_by_domain',
+	 * to retrieve the system affinity domain information.
+	 * starting_index value refers to the starting hardware
+	 * processor index.
+	 */
+	ret = systeminfo_gpci_request(sysinfo_counter_request[AFFINITY_DOMAIN_VIA_DOM],
+			0, 0, buf, &n, arg);
+
+	if (!ret)
+		return n;
+
+	if (ret != H_PARAMETER)
+		goto out;
+
+	/*
+	 * ret value as 'H_PARAMETER' corresponds to 'GEN_BUF_TOO_SMALL', which
+	 * implies that buffer can't accommodate all information, and a partial buffer
+	 * returned. To handle that, we need to take subsequent requests
+	 * with next starting index to retrieve additional (missing) data.
+	 * Below loop do subsequent hcalls with next starting index and add it
+	 * to buffer util we get all the information.
+	 */
+	while (ret == H_PARAMETER) {
+		int returned_values = be16_to_cpu(arg->params.returned_values);
+		int elementsize = be16_to_cpu(arg->params.cv_element_size);
+		int last_element = (returned_values - 1) * elementsize;
+
+		/*
+		 * Since the starting index value is part of counter_value
+		 * buffer elements, use the starting index value in the last
+		 * element and add 1 to make subsequent hcalls.
+		 */
+		u32 starting_index = arg->bytes[last_element + 1] +
+			(arg->bytes[last_element] << 8) + 1;
+
+		memset(arg, 0, HGPCI_REQ_BUFFER_SIZE);
+
+		ret = systeminfo_gpci_request(sysinfo_counter_request[AFFINITY_DOMAIN_VIA_DOM],
+					starting_index, 0, buf, &n, arg);
+
+		if (!ret)
+			return n;
+
+		if (ret != H_PARAMETER)
+			goto out;
+	}
+
+	return n;
+
+out:
+	put_cpu_var(hv_gpci_reqb);
+	return ret;
+}
+
 static DEVICE_ATTR_RO(kernel_version);
 static DEVICE_ATTR_RO(cpumask);
 
@@ -420,6 +489,11 @@ static struct attribute *interface_attrs[] = {
 	 * attribute, set in init function if applicable.
 	 */
 	NULL,
+	/*
+	 * This NULL is a placeholder for the affinity_domain_via_domain
+	 * attribute, set in init function if applicable.
+	 */
+	NULL,
 	NULL,
 };
 
@@ -677,6 +751,10 @@ static struct device_attribute *sysinfo_device_attr_create(int
 			attr->attr.name = "affinity_domain_via_virtual_processor";
 			attr->show = affinity_domain_via_virtual_processor_show;
 		break;
+		case INTERFACE_AFFINITY_DOMAIN_VIA_DOM_ATTR:
+			attr->attr.name = "affinity_domain_via_domain";
+			attr->show = affinity_domain_via_domain_show;
+		break;
 		}
 	} else
 		pr_devel("hcall failed, with error: 0x%lx\n", ret);
-- 
2.39.3

