Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495AC7DC1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjJ3VcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjJ3VcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:32:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CD611B;
        Mon, 30 Oct 2023 14:32:12 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39ULVuEv016684;
        Mon, 30 Oct 2023 21:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=JLBYQvouHm+ivITtAnS//CALxj6F/tmmVd/NsTeTqyE=;
 b=mVQM5zRRDwJHiF79Hfq3oWk9idm/OLvnuVYDkVPlTWw6y+PfNvgPgWXm6XsffpYJaOK6
 j1XeQb2lu5agLaQkNcbTx0yQTJM3HsfIybqzGDpXcacTdUpbaPoPYsq86y+l8JTuh/Y5
 JCeLQE/Vo7cpgVeNo3nf1WdvbrXIGOhyIRLj55S0cL6JWv6dfvQz7EnY57c/SGb4MVFW
 z9yS3yyX6enaRdoonfI938zpFTtyorkVZKZSVcv5r11x6qYKYfOnxqSJXg14cVVCfPt7
 YOdvsBKxbRCuZ5EoIN9IsD1nST2eJt1IEbss98TU9IgwLA+C/TURfqUoeJAcpzgGhCrj Gg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2chyh7rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 21:31:56 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39ULVubm011305
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 21:31:56 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 30 Oct 2023 14:31:55 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
Date:   Mon, 30 Oct 2023 14:31:34 -0700
Subject: [PATCH RFC 2/2] firmware: psci: Read and use vendor reset types
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231030-arm-psci-system_reset2-vendor-reboots-v1-2-dcdd63352ad1@quicinc.com>
References: <20231030-arm-psci-system_reset2-vendor-reboots-v1-0-dcdd63352ad1@quicinc.com>
In-Reply-To: <20231030-arm-psci-system_reset2-vendor-reboots-v1-0-dcdd63352ad1@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Elliot Berman <quic_eberman@quicinc.com>
X-Mailer: b4 0.13-dev
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nPoM-AxfQC_BuKVQzcAwanO9tqVyCc2T
X-Proofpoint-GUID: nPoM-AxfQC_BuKVQzcAwanO9tqVyCc2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoC vendors have different types of resets and are controlled through
various registers. For instance, Qualcomm chipsets can reboot to a
"download mode" that allows a RAM dump to be collected. Another example
is they also support writing a cookie that can be read by bootloader
during next boot. PSCI offers a mechanism, SYSTEM_RESET2, for these
vendor reset types to be implemented without requiring drivers for every
register/cookie.

Add support in PSCI to statically map reboot mode commands from
userspace to a vendor reset and cookie value using the device tree.

Reboot mode framework is close but doesn't quite fit with the
design and requirements for PSCI SYSTEM_RESET2. Some of these issues can
be solved but doesn't seem reasonable in sum:
 1. reboot mode registers against the reboot_notifier_list, which is too
    early to call SYSTEM_RESET2. PSCI would need to remember the reset
    type from the reboot-mode framework callback and use it
    psci_sys_reset.
 2. reboot mode assumes only one cookie/parameter is described in the
    device tree. SYSTEM_RESET2 uses 2: one for the type and one for
    cookie.
 3. psci cpuidle driver already registers a driver against the
    arm,psci-1.0 compatible. Refactoring would be needed to have both a
    cpuidle and reboot-mode driver.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/firmware/psci/psci.c | 87 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index d9629ff87861..93914b48a950 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -29,6 +29,8 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 
+#define REBOOT_PREFIX "reboot-mode-"
+
 /*
  * While a 64-bit OS can make calls with SMC32 calling conventions, for some
  * calls it is necessary to use SMC64 to pass or return 64-bit values.
@@ -79,6 +81,14 @@ struct psci_0_1_function_ids get_psci_0_1_function_ids(void)
 static u32 psci_cpu_suspend_feature;
 static bool psci_system_reset2_supported;
 
+struct psci_reset_param {
+	const char *mode;
+	u32 reset_type;
+	u32 cookie;
+};
+static struct psci_reset_param *psci_reset_params;
+static size_t num_psci_reset_params;
+
 static inline bool psci_has_ext_power_state(void)
 {
 	return psci_cpu_suspend_feature &
@@ -305,11 +315,29 @@ static int get_set_conduit_method(const struct device_node *np)
 	return 0;
 }
 
+static void psci_vendor_sys_reset2(unsigned long action, void *data)
+{
+	const char *cmd = data;
+	size_t i;
+
+	for (i = 0; i < num_psci_reset_params; i++) {
+		if (!strcmp(psci_reset_params[i].mode, cmd)) {
+			invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
+				       psci_reset_params[i].reset_type,
+				       psci_reset_params[i].cookie, 0);
+			break;
+		}
+	}
+}
+
 static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
 			  void *data)
 {
+	if (psci_system_reset2_supported && num_psci_reset_params)
+		psci_vendor_sys_reset2(action, data);
+
 	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
-	    psci_system_reset2_supported) {
+		 psci_system_reset2_supported) {
 		/*
 		 * reset_type[31] = 0 (architectural)
 		 * reset_type[30:0] = 0 (SYSTEM_WARM_RESET)
@@ -748,6 +776,63 @@ static const struct of_device_id psci_of_match[] __initconst = {
 	{},
 };
 
+static int __init psci_init_system_reset2_modes(void)
+{
+	const size_t len = strlen(REBOOT_PREFIX);
+	struct psci_reset_param *param;
+	struct device_node *np;
+	struct property *prop;
+	size_t count = 0;
+	u32 magic[2];
+	int ret;
+
+	if (!psci_system_reset2_supported)
+		return 0;
+
+	np = of_find_matching_node(NULL, psci_of_match);
+	if (!np)
+		return 0;
+
+	for_each_property_of_node(np, prop) {
+		if (strncmp(prop->name, REBOOT_PREFIX, len))
+			continue;
+		ret = of_property_count_elems_of_size(np, prop->name, sizeof(magic[0]));
+		if (ret != 1 && ret != 2)
+			continue;
+
+		count++;
+	}
+
+	param = psci_reset_params = kcalloc(count, sizeof(*psci_reset_params), GFP_KERNEL);
+	if (!psci_reset_params)
+		return -ENOMEM;
+
+	for_each_property_of_node(np, prop) {
+		if (strncmp(prop->name, REBOOT_PREFIX, len))
+			continue;
+
+		param->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
+		if (!param->mode)
+			continue;
+
+		ret = of_property_read_variable_u32_array(np, prop->name, magic, 1, 2);
+		if (ret < 0) {
+			pr_warn("Failed to parse vendor reboot mode %s\n", param->mode);
+			kfree(param->mode);
+			continue;
+		}
+
+		/* Force reset type to be in vendor space */
+		param->reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | magic[0];
+		param->cookie = ret == 2 ? magic[1] : 0;
+		param++;
+		num_psci_reset_params++;
+	}
+
+	return 0;
+}
+arch_initcall(psci_init_system_reset2_modes);
+
 int __init psci_dt_init(void)
 {
 	struct device_node *np;

-- 
2.41.0

