Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD1D758D82
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjGSGOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjGSGOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:14:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4AE1FEC;
        Tue, 18 Jul 2023 23:13:48 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J5mOfb028198;
        Wed, 19 Jul 2023 06:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Jo2xDyzdHzIZzDJhtsxvJ4QdOnHOBDQfyb+q4sS6Jcw=;
 b=JTtUwi7BZC5h75W2sRMwU6uZk4SaArpghdKmUhUbuQIyfONlTrcvA/Ez5hm8NAGGGDHb
 l6DgtAXKKkTFjM9eTe2GKgytNc53UzzYtajTINNECZTgScU1Jk6+odW0shrx9OWxmIDQ
 tk58QYs/BUWcLezQae3uqyfVR8kWG+iU5/1sMaVr1a0+z5EgXOoIH00+kfsmnj3ZpXiW
 ZNx/M7UXO/xL078q9m45G+UR2qOsaHp+jMnpkmZbb/17v5083/pEEx7FK7QeRsU1vn1l
 hN8McKmX/n4GyLNZwzZWm5yj6qYXARlckobg5RE9JvkPN9mBoCn6swhNtjvr6Af0ICGe MQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxa0ggm10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 06:13:40 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36J4HvQV016875;
        Wed, 19 Jul 2023 06:13:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv5srs78p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 06:13:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36J6Dbak53674274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 06:13:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35E1B2004B;
        Wed, 19 Jul 2023 06:13:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E114720040;
        Wed, 19 Jul 2023 06:13:29 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.119.126])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jul 2023 06:13:29 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, disgoel@linux.ibm.com,
        kjain@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: [PATCH v3 05/10] powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity domain via virtual processor information
Date:   Wed, 19 Jul 2023 11:42:26 +0530
Message-Id: <20230719061231.631410-6-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230719061231.631410-1-kjain@linux.ibm.com>
References: <20230719061231.631410-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8HRr56Pr0WRD7FxF3TqNjjikplBbRudV
X-Proofpoint-ORIG-GUID: 8HRr56Pr0WRD7FxF3TqNjjikplBbRudV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_02,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190056
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
AFFINITY_DOMAIN_INFORMATION_BY_VIRTUAL_PROCESSOR(0XA0), can be used to get
the system affinity domain via virtual processor information. To expose
the system affinity domain via virtual processor information, patch adds
sysfs file called "affinity_domain_via_virtual_processor" to the
"/sys/devices/hv_gpci/interface/" of hv_gpci pmu driver.

The affinity_domain_via_virtual_processor sysfs file is only available for
power10 and above platforms. Add a macro called
INTERFACE_AFFINITY_DOMAIN_VIA_VP_ATTR, which points to the index of NULL
placeholder, for affinity_domain_via_virtual_processor attribute in
interface_attrs array. Also updated the value of INTERFACE_NULL_ATTR macro
in hv-gpci.c file.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 arch/powerpc/perf/hv-gpci.c | 86 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index c74076d3c7a7..68502cb18262 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -105,17 +105,20 @@ static ssize_t cpumask_show(struct device *dev,
 /* Interface attribute array index to store system information */
 #define INTERFACE_PROCESSOR_BUS_TOPOLOGY_ATTR	6
 #define INTERFACE_PROCESSOR_CONFIG_ATTR		7
-#define INTERFACE_NULL_ATTR			8
+#define INTERFACE_AFFINITY_DOMAIN_VIA_VP_ATTR	8
+#define INTERFACE_NULL_ATTR			9
 
 /* Counter request value to retrieve system information */
 enum {
 	PROCESSOR_BUS_TOPOLOGY,
-	PROCESSOR_CONFIG
+	PROCESSOR_CONFIG,
+	AFFINITY_DOMAIN_VIA_VP, /* affinity domain via virtual processor */
 };
 
 static int sysinfo_counter_request[] = {
 	[PROCESSOR_BUS_TOPOLOGY] = 0xD0,
 	[PROCESSOR_CONFIG] = 0x90,
+	[AFFINITY_DOMAIN_VIA_VP] = 0xA0,
 };
 
 static DEFINE_PER_CPU(char, hv_gpci_reqb[HGPCI_REQ_BUFFER_SIZE]) __aligned(sizeof(uint64_t));
@@ -316,6 +319,76 @@ static ssize_t processor_config_show(struct device *dev, struct device_attribute
 	return ret;
 }
 
+static ssize_t affinity_domain_via_virtual_processor_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct hv_gpci_request_buffer *arg;
+	unsigned long ret;
+	size_t n = 0;
+
+	arg = (void *)get_cpu_var(hv_gpci_reqb);
+	memset(arg, 0, HGPCI_REQ_BUFFER_SIZE);
+
+	/*
+	 * Pass the counter request 0xA0 corresponds to request
+	 * type 'Affinity_domain_information_by_virutal_processor',
+	 * to retrieve the system affinity domain information.
+	 * starting_index value refers to the starting hardware
+	 * processor index.
+	 */
+	ret = systeminfo_gpci_request(sysinfo_counter_request[AFFINITY_DOMAIN_VIA_VP],
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
+	 * with next secondary index to retrieve additional (missing) data.
+	 * Below loop do subsequent hcalls with next secondary index and add it
+	 * to buffer util we get all the information.
+	 */
+	while (ret == H_PARAMETER) {
+		int returned_values = be16_to_cpu(arg->params.returned_values);
+		int elementsize = be16_to_cpu(arg->params.cv_element_size);
+		int last_element = (returned_values - 1) * elementsize;
+
+		/*
+		 * Since the starting index and secondary index type is part of the
+		 * counter_value buffer elements, use the starting index value in the
+		 * last array element as subsequent starting index, and use secondary index
+		 * value in the last array element plus 1 as subsequent secondary index.
+		 * For counter request '0xA0', starting index points to partition id
+		 * and secondary index points to corresponding virtual processor index.
+		 */
+		u32 starting_index = arg->bytes[last_element + 1] + (arg->bytes[last_element] << 8);
+		u16 secondary_index = arg->bytes[last_element + 3] +
+				(arg->bytes[last_element + 2] << 8) + 1;
+
+		memset(arg, 0, HGPCI_REQ_BUFFER_SIZE);
+
+		ret = systeminfo_gpci_request(sysinfo_counter_request[AFFINITY_DOMAIN_VIA_VP],
+				starting_index, secondary_index, buf, &n, arg);
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
 
@@ -342,6 +415,11 @@ static struct attribute *interface_attrs[] = {
 	 * attribute, set in init function if applicable.
 	 */
 	NULL,
+	/*
+	 * This NULL is a placeholder for the affinity_domain_via_virtual_processor
+	 * attribute, set in init function if applicable.
+	 */
+	NULL,
 	NULL,
 };
 
@@ -595,6 +673,10 @@ static struct device_attribute *sysinfo_device_attr_create(int
 			attr->attr.name = "processor_config";
 			attr->show = processor_config_show;
 		break;
+		case INTERFACE_AFFINITY_DOMAIN_VIA_VP_ATTR:
+			attr->attr.name = "affinity_domain_via_virtual_processor";
+			attr->show = affinity_domain_via_virtual_processor_show;
+		break;
 		}
 	} else
 		pr_devel("hcall failed, with error: 0x%lx\n", ret);
-- 
2.39.3

