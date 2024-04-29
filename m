Return-Path: <linux-kernel+bounces-162980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFB08B62FF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D381C210AF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55951411E7;
	Mon, 29 Apr 2024 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="KY90fIfE"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2131.outbound.protection.outlook.com [40.107.101.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E1113C3D3;
	Mon, 29 Apr 2024 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420729; cv=fail; b=FY+1QLwpyJFy5f3+00lP3S+CUdgfbe5KPNh1Op1/kaaJhsiCSPzwAgbj7fKLZ/qD3m5JUGvoMY+ucz1HqUFnQaK21zLo7D22xFxg2MIIiB04SAuFpU7TLYYL06V8Coajzo6c6oiod4BURH1+oAteNCRhAL0mXHh1D8nuKFM6COg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420729; c=relaxed/simple;
	bh=eDYoVr+XP357sZ07CwDDXTv1cyNxxJ+ZTgw78nRQSe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HukZ+2nMWBaD+eZ+Igw35euEZZjiF6+XGCwmpSz9oLjqNf+3smsBc8Qilu5Xje1Kirl0xUKFRrzCxKkVvmErjA9STGJM3/r7asQW7E6SMQuTT/ZNlPdNhYMfOQmQdM1sALXmtpPJ5TZJEvsifTZn3mSu/bcX7Ou+DAExzlM2qYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=KY90fIfE; arc=fail smtp.client-ip=40.107.101.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmX0+0pk9Ac5DiXuwCgSNCysf0t+Y7YrW4KV9+B8jtdP5DNurcuiafmJDlMPBk1RSkWTBWakZU++h8Uq3gMQOZLPVRm7C7VTJXGt3h1UeEynDPIDT9YrpxmeOsYWYQ+jvAUkbHCcVf/GeGq04z+x+7EItiFw7od3M5LbYFO/K8aR5nJ8Jwj3eJq4i0O6AkRIiFMCzTIsNdsR+QtYpE81Qpzk260uzvkyYKSEnymrXoFca/ByXWEVuIIYaUynasAwaIIn2/q7r0irBQJ3Jz5QPLIZwt/qas6WGcB4kt8MCUs7VYtaNOypVvY1zMUynzqaOneNdsTAtAWSPrjfDKqHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X54Xa1eKAVIDD9PaUZZqbbT3IyZpuTp5cidwzcrjnrA=;
 b=a2aiRxlzER8E4uPbbZDLXiiWE/xif42ICArBc7CyaWBKc/Ld1eXUhxqqqjGSefkbc6PWpWJRuK9jvj67NH2YxdbzjXv7jeHDh0owUwLzVaXErYXWzZ6jvFDhLmBv2mWt889qaXIS5wc/Ogfkp8jBvnNJlcnqFeBaKeFms8xpi3rc/Y4ikhuq5S4Kig3eAJmBDLq6DTE4NhMqxQ0h5XK+YBC62g8xba8kNrBY4spLlZhAPS9dJeHtlhsToY2kqWAFeRFGo9qYtpW4iNdghSAX2Xzq2TxNw/rgFQCykQZ3HfR6yO97MMupRillhCQ5CNOqYnLb2zuNNW0afIj/NninbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X54Xa1eKAVIDD9PaUZZqbbT3IyZpuTp5cidwzcrjnrA=;
 b=KY90fIfEaG2P9j2yztfK3XMPXSUmh/i2Dzc5dPC9MOEgP0/NLZVLIV4FVYfoHZCMQZzqtCykBBDrTer6YF6EGFhcEHHCIQI15CHdxPTVMz2SE5d4xoih2VSkdn065QWAxj89T7uI+oqDlKGJUwN97Z2Lbb3jj9KQNl9lQsejXFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by PH7PR22MB3962.namprd22.prod.outlook.com (2603:10b6:510:2bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 19:58:45 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 19:58:45 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	j-keerthy@ti.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH v2 2/2] arm64: dts: ti: phycore-am64: Add PMIC
Date: Mon, 29 Apr 2024 12:58:30 -0700
Message-Id: <20240429195830.4027250-2-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240429195830.4027250-1-nmorrisson@phytec.com>
References: <20240429195830.4027250-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0428.namprd03.prod.outlook.com
 (2603:10b6:610:10e::23) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|PH7PR22MB3962:EE_
X-MS-Office365-Filtering-Correlation-Id: 288faad5-0dc5-475a-6809-08dc6886c6c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lM7oRIowq1sP2j3CuvpNNxciZGIVB9lT74velMa0kjiN0++pe2SiSNQU2a9f?=
 =?us-ascii?Q?kXtKKN2yu4RU5TqExyDM90GS1Qpj7JCgs0CDhSujGFUupNxN2FDS3CojzOQ/?=
 =?us-ascii?Q?+xuR+TezLbObdcZ0CQTkyng44ODjM1VDDOERJNTZPLtykCseZ8g0LE+ebX/1?=
 =?us-ascii?Q?tgHTJ3x6An3AphCTOvr+W+ImIOIah2Y4yKMC8onemm9teZfY3nQ8/MLjATlA?=
 =?us-ascii?Q?udfvXVmDvhTiJhnzI/FAwvnAP4857k0Egh4K3VBaQ0Lx6F3XdkqlRtTc43td?=
 =?us-ascii?Q?QAewpi18/dlwk9+/PVjZDKfwOi+5P083iyb7O+4Mv2MWXe9lI5909mQpFlEn?=
 =?us-ascii?Q?DY4ySLY0h1juFv2BI2rEvKTL2DaYMfVHWja4ggMJDG9cSit4UN/Rmp1ozjC3?=
 =?us-ascii?Q?hI5DIIFUyp/o/sCnm/olnYPZ4Sl78gjMZemxsskt+7loqlg1e5Hkt0U3t1Ey?=
 =?us-ascii?Q?hMJEq17P4p2yGw1WvG5Q/Dka3eb8aOUIFbxyqeJ5yXqJOIMd7cKhr6wFf3kD?=
 =?us-ascii?Q?rD0S1NWTkUpU5IF8eio1/OPYMedoFTV0LSA4v8iNY1FSQuWk4oDUiegs/78D?=
 =?us-ascii?Q?pKqnzo+RsJJ77uA2DtSX1DtpRRO4oHdXwcOiIxPO9VYtJMpe+HZMcdw3xwOa?=
 =?us-ascii?Q?LhjUzQY6xuueKOMuV4wCf/u5G/0xC1IEPlBg1w4Ngr57kyIXvG9XYDhhfDYl?=
 =?us-ascii?Q?vPslQPUJfn0phxH8FpkBL5W1dopf7B2gm28s/yZUoWox2TBTr9kR5C/qtZDB?=
 =?us-ascii?Q?c/gyo/cNnLBy5QjFmTb17G9KOmM6K640XYGnAtXU6VjKma0O6j+R0j87XMRW?=
 =?us-ascii?Q?2+XBnQUSOylAlTnaWg5KmI136jf7oPlok0I/+vbe6JS0cmY6N+/HCm5xtiZH?=
 =?us-ascii?Q?bZj1titfe0VHVgsncuHvbBkXccNtp2aIQJGoF7CfDNmkVfpYzfGdwYvYXh7m?=
 =?us-ascii?Q?9CegJIcNB/kwc2qQyDpwFL5ofZLqUhRMUEX52UJtUAPjvCcdKeKFp10E9sty?=
 =?us-ascii?Q?pv3kD+DaEQ5w9/UyDLiA4Q8GWqxY+CiLuEM0niqsQU1UfRaE5iUx3TmzgTUO?=
 =?us-ascii?Q?9UmG8qy2zOpn3IUYFNmfg9PtSFnWFmUq1W+vNCh1pMOEWTZQuViRyRs9gkY+?=
 =?us-ascii?Q?IWPEZGt9cGkjivR6f4eLr23d6MzDtBvS947avd/WbpKjiWMOdfzkSMQIPxDG?=
 =?us-ascii?Q?LgewPMTG+OANdP2pHyCfqJiCMJ4I20lAS66gkfvB0ktW596i2lDor/n5qWeh?=
 =?us-ascii?Q?beei8qAzJ3xQeSwi2IB8uO2Z27E5v4mH7rJvpV0gkP13ELKapWWs3fdu0as2?=
 =?us-ascii?Q?2p/s1DzdjAKTwroaqISb78jnbDBVxGjuWJg0Jg/jtTNOlw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9mB91L/o+hQNaV+s8GUz3ROnipsbEIMzlqSPeeDkHaTaHRw76An8vmlATO+4?=
 =?us-ascii?Q?AGIiPYZM5Ut02l+cI/PHb5peS81uGiXf166Q0dlujl+nkhjycSh/Hod8c9s+?=
 =?us-ascii?Q?JGf3XjWZeJSzPXfs4MUD8mnMmKGCXXZ5P+chBgSshft00Vr4+BLn4KyTpR2B?=
 =?us-ascii?Q?MmF4rznRi9zu2yoqy53edFR2V7vPw9cLdaHA7KQcY1U9X4Z4nEnXF51Hb7dz?=
 =?us-ascii?Q?qkE/vJc6hSWVRAEcVccZhnuo4h8otBVtIBZcY2+g433GehxrmUQVQ3sLxE2/?=
 =?us-ascii?Q?B4LhGUptjLHOTeiJLhPq7/7P5kAcjiY4RLgTO1gi6C55+2Vsq092mLoL2DCx?=
 =?us-ascii?Q?YKJFjFEowDptdJzHL9xnmPke9tXROtFGvXWg+vcjmojytlwNGVSrtp0d+zxF?=
 =?us-ascii?Q?89jmo3+1oCxRGBJr8xRUCgXGNkLlU/EKmnlcjjGozSW2cAV1oHhzjXwyo8nz?=
 =?us-ascii?Q?VgEB2ah6JPQCz4YKnj93lFTLIuQKaN0ztJDyfyfGtJ/q88oEgPsgZDGLFYLK?=
 =?us-ascii?Q?eLZo5czr+BsaByGQya6UtR8I0GPARZST3R+nGaoVSyoG4YtzBWp2e8u+Ah5f?=
 =?us-ascii?Q?mAH7IRdCIya0wJF6iYP/D9bBRQ/T1fhGH8gQ2SLsCHi2fGEhFWDPqRiGLvSK?=
 =?us-ascii?Q?Q8K9/DZjsMDj7gBZ202pZgu5uEsqQLeRvHqXGNkc2s2ExKWSauvIZISZgd0G?=
 =?us-ascii?Q?bQ6RMn6rLw/AFYAcYP0hEpjqvdoL7eBEuDKFe9OVXOWSHeelDeiBQb5O5YlY?=
 =?us-ascii?Q?9sAoIAfAiLef4Ah0yoZq5XIKoQkdPtuXKP+4vSuPCAM5nR6oErTSq8R5CC7+?=
 =?us-ascii?Q?MaHLnPrSdJx7VXe35Xw03GiQroe1DbGC4vtNvjnNm++rIhwGZHldNfu2fWnd?=
 =?us-ascii?Q?l0d0bDPz1NzkHUzrYf/n6l1QoTdSZV+Gl//cj8/fEiAREPKUVwx0vsCHZbEQ?=
 =?us-ascii?Q?+3KhxqBUiR4YcI9YREg20cYmDWY+KS4fx0iobx1na6fJ7JA0bhc58bxH5IcL?=
 =?us-ascii?Q?0vHYLkxUORhE+mvF1kfsZ5dZEaK2gvaMxmMAkfM965W7dtbRf8VT4wMmyrw1?=
 =?us-ascii?Q?bVbwl1GGJYfm/1yOM+CsPQ4f2ClvvwAipaLWZyFam/5/iDC12xsMCHkcnuoz?=
 =?us-ascii?Q?OF2A+kZ3tsTOvvdG1tOFPE4qvY5t7og4EyUdSCKagjagIoZc0H5EduoP64/6?=
 =?us-ascii?Q?YJmLGTECmmJ/jUgJwxwBXkaQzLm41HpjuiVMgCVL1RooT2NyBIkb0q6/JbdS?=
 =?us-ascii?Q?DlH1wdQXJhbV1sOyH2SubrZQCICJRDFjHXC9wpFyxtlKgHosTnd5Q5/6poGe?=
 =?us-ascii?Q?8YUUeuqDZYLQnNbV1fpEw0u0rFlydwz1NaVSANY1lRgdcwMmxuSRPs+S15X3?=
 =?us-ascii?Q?Svtijg+JO8KHVW2uU1YMp7Ac8nmqJout10g58zSS+qWqI8tapAw9fX1f377D?=
 =?us-ascii?Q?Y5ksuMx5qgRB83UJdwTIHYpBmvfcXa5WwtAw1/ygd0rcmMXXKoJJQngDnx7u?=
 =?us-ascii?Q?DWANjhDrs9kxr5v3haCCB4r16ujINzWBM86lDYmcishv2t5AC8VLOrTtrREP?=
 =?us-ascii?Q?PXaxFlmYDnExIkd8tpbhVbDtoX/16D8FzNQQkiqp?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288faad5-0dc5-475a-6809-08dc6886c6c3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 19:58:45.1104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ccthxb8jOu/m9Rd1lzJd90R3uyfJg6peyDCpuLCBHlO1wvKHxnseyRrqxvDu8h1ldkBY05l0XfZv+ZdoJQ+KTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB3962

Add a PMIC node to the phycore-am64 device tree.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
v2: No change

 .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 125e507966fb..2c3b20ddfb8b 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -265,6 +265,50 @@ i2c_som_rtc: rtc@52 {
 		interrupts = <70 IRQ_TYPE_EDGE_FALLING>;
 		wakeup-source;
 	};
+
+	pmic@61 {
+		compatible = "ti,lp8733";
+		reg = <0x61>;
+
+		buck0-in-supply = <&vcc_5v0_som>;
+		buck1-in-supply = <&vcc_5v0_som>;
+		ldo0-in-supply = <&vdd_3v3>;
+		ldo1-in-supply = <&vdd_3v3>;
+
+		regulators {
+			vdd_core: buck0 {
+				regulator-name = "VDD_CORE";
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vdd_3v3: buck1 {
+				regulator-name = "VDD_3V3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vdd_1v8_ldo0: ldo0 {
+				regulator-name = "VDD_1V8_LDO0";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vdda_1v8: ldo1 {
+				regulator-name = "VDDA_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+	};
 };
 
 &main_r5fss0_core0 {
-- 
2.25.1


