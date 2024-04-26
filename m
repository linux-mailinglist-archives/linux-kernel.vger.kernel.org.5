Return-Path: <linux-kernel+bounces-160461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95E88B3DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F56B225FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7D116ABC6;
	Fri, 26 Apr 2024 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="jS0OZP25"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2099.outbound.protection.outlook.com [40.107.94.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317015EFB4;
	Fri, 26 Apr 2024 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152136; cv=fail; b=EQEerb9TI0tNd7iWsWbSuBCh+88Bzg1YGzaq7VEn5y17tBJlXFeBakryDRhkLbXHPdroReGkPIDOHyt0zvgXBCHuZCiAluszq/tnVccok+vDlX4/kdgsZuzgbjM0J8smiVWnSAcowslDC7TPthEvsVVPlQw0strPac29fU2/Ghc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152136; c=relaxed/simple;
	bh=F3ozCbVwXHBOoZSwRUzNg0YTwoA5Vc+rMYfDQuGr1wI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=A0Uv5TwGVK1EfP9esnxrEP0OaE1oeWtCUpUFEbUiLuCA2WWVzdFMVbqcZywQBq3V8DvSpLX/SXACH4CUHxL/8EKUSb0VlGGgv17dzjakCeB1KP4DfBs/6vrtfw06IL2qUjpjY0Eh1V9xi65suY4loCkMC2YC7WH/h3jKXalKtd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=jS0OZP25; arc=fail smtp.client-ip=40.107.94.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8B2D5y+OA1py7apq1lA18+L444yrf/3lfP0YsW/9sB58WZIzIV9JdOrVvvt8kiDgq2fTrTSoWQMZgyaKXRPRypF9ff4BohVKE+UNR++zUyl6eC2Qfyy2blC+iTnx0H5pw18XRIHVyh6kFKhgU6plRh1+iCUQBwsf/DWG/ZeMADOJg5FOdi3rPR8nCx+a4DOtMoEIne8az7afdAMCTAAh7rUdroPkLcyCw+DYxNBNmBPMa2PmrK+4tQHE0YfiGF2taqDza6iajeOzGzzeJNaRb096Z67CvN340GlLKqheTw6aUVtS1/cvVPUGDg5FbVrNeBgVrm8cNkrCQ5jaDGo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCzmlbFUOmb03yYK4a2zB+kNtnvgWW0Wj8D7fozn9y0=;
 b=PLZujgm4oY1J6fQ7A7Qhx+lr8YVn0amkomF2uQccPDDNoxjzskA50mRBNC0tjlhBH5wlnfcBDYTdXsPKQTL/DckSE7uOSCsmpnI7pib5pjVC5XLKTHvUgp7FChcRWdCY84bj99kKzOa18O2ma7ZnmOPbIzh9EDP8bgb1LShZ2MqFdJD3lFRrieXpMbv7Ugeb0MiWSnZMOxGWXnFs2Q1s8uGJW1T/fOWstuFUHh58BQScppRxTDLgyi4dDa+7DzfLM1PlOAhRdzws21Ax41KAKKXD3TA4qlasvfDsWoeY22Vh2CmpHVkByoJXKaMe6LFayi4JVzHssUuwe5y/rsuNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCzmlbFUOmb03yYK4a2zB+kNtnvgWW0Wj8D7fozn9y0=;
 b=jS0OZP25xJp3OrlwrhGoHi0H/AHSuSvqr20GTS8BULqDyE7pQrMXoekaRl1pBpmeIeGBqU8tiqDtgFRzWoAMYqe/gqIjQYiIQgyLIR6c/pQ45V/fqdqixF+dip5CaIsHziDumpzS3G5nqVMSluOsMpkrMvn2tP/vSpiChhdier8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by SN7PR22MB3786.namprd22.prod.outlook.com (2603:10b6:806:354::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 17:22:06 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f%7]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 17:22:06 +0000
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
Subject: [PATCH 1/2] dt-bindings: Convert lp873x.txt to json-schema
Date: Fri, 26 Apr 2024 10:21:54 -0700
Message-Id: <20240426172155.10860-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::14) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|SN7PR22MB3786:EE_
X-MS-Office365-Filtering-Correlation-Id: af5e4389-849a-4998-26b9-08dc6615653e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6AwMxTJRTkJwMFPBMCOAf0I4GvDIPBAYJznnlq7HQRg09zqLX5dYLyMLrt/7?=
 =?us-ascii?Q?Dk6WZBOeZHHtNZU3Byh1JUWKgYzAzzoKtw0577VHdAbjyPRc+KLH2u7Zifg8?=
 =?us-ascii?Q?tg20sd8sTzuBWjC2NVEML4X3wjiVARHKdx8nz3KplSe1mQfvzwwwfzMBLBJ7?=
 =?us-ascii?Q?RNbWt7o5f+BtjwCe+KfJkA9xV+hmAtJ+z0hxjzryyEuee/R3tR+nsFPD16RL?=
 =?us-ascii?Q?AVL2hUr4jofClyFBEGuZVVDVVBp7wGF4CS2IXga1udfSn9L7Pl3TQbf/2c1+?=
 =?us-ascii?Q?DP7WVT99assmD6oruTDsWzxd59HvW+F7tOpkwW/QzNhO+0lavhlsmczKTPsR?=
 =?us-ascii?Q?+6ScPrwEO+iZa+6ebPEIUHLEZ+N+K+l6j7j3OB/t0MQeg2TYUCig7r4RsPYH?=
 =?us-ascii?Q?MurWb4NfT7TqDntlNDFcvRhztzMaazXjVVYjzslID5o1CnPmzIp5edXXCntl?=
 =?us-ascii?Q?EKZj+/LUexClcfO3x2U21Iw2pHwp519VY4oAtD8Otsgr215qRQiaHEha5loa?=
 =?us-ascii?Q?sAgBRJ+6rG/cHW8sAvecy86Y3Vusv7Wambmynqoe8wWp1k5i20lzV5phAjYC?=
 =?us-ascii?Q?9MIIg0OAfupEehLJ9lnovT55QV92Bzjoa2mnyzN/3+H1cSZnNQ/tS8aKY2mY?=
 =?us-ascii?Q?fRfAU/Qra2l6ve+Ds92Nan62rLk4hBTo+fzIs0HV/Fr6I2K5rUIDc/X2gPAW?=
 =?us-ascii?Q?SIW5TXEKN5R37OXjsT3pfDqgG9EVxckyxQi/E4G078rZ60tkcvY8JDDUWTKL?=
 =?us-ascii?Q?lOD7RyLlDez8cgamNH8KhQiVWAUfCOKuEhROYC47OkAdiZcGPQ+Qx8Rdf9R8?=
 =?us-ascii?Q?IXU3pZFB/XzoR684gW6SJO9UIH1LrAh2ZAVwE3lQCEG0jh93jkOfZeBOoVoE?=
 =?us-ascii?Q?2zPQ85zQuOFzN9aBhBWerRkw99sd38g18URIZUaCnBoDUit7x0IlN8UzciVE?=
 =?us-ascii?Q?UnRlcO/XWEJ+u3Y/feVv3as83lF30eiCXCsHvZxyy1lxU8AR6HDPQmJLOLJK?=
 =?us-ascii?Q?vbwz8IPdVWdYHGQbGt6j+LqRG0rup96wJa9SU/ib6yfrgBxCoYXvNhbgis1o?=
 =?us-ascii?Q?Gc/9xInb1TzWMalw3xnGgceCpd24kwjt1IBl1iJIF5U68A3gR3Uki3NTQA6n?=
 =?us-ascii?Q?eja0Sea8I2XXFqbwaSKBy55efH55sJgorIBHeyDBRH0q2G257MBeD7oqnVdz?=
 =?us-ascii?Q?AuBX24bWNAMJED7ZNu5+AIF4QnQCGiBrfMjIgr54ZWLbZolWD7AiWKkTO53E?=
 =?us-ascii?Q?Wf5u91MqRn2JTxGSpGY5ZTXsEsKZdPaZKFsR3rnQZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IfbxfZOZYqfCzwXWgSytx6e8v5irJzL1ulYcyyMhD2wLygIbtPgUkkj6hs2q?=
 =?us-ascii?Q?7YL8QwYmTzv93mES+NHqy0rWCAuLZNx32g5Sdgw9L+PC3+EE8X+2uLsfr05Z?=
 =?us-ascii?Q?a+qtntgP7Cqse0w+riP/onS0iKje0s0KscgP/cDzTim4Z5/eTQYoPsBp4fKi?=
 =?us-ascii?Q?d8Mg2MHGwuLp/xVYG8j1j047T0wjAdQFzbqLfk9nBMW1Huoh8U3przGUYnqs?=
 =?us-ascii?Q?5R8cwV25ix5BLCOWVL119rWHr1S8OXwDzU5B3ia4B6VYYW1F8vqVezWqL1ag?=
 =?us-ascii?Q?S9N8XtBgXt9ct7XoAN7MQ+M0Nwwd3BkKGmYRfK/DxYDnUGsrWuFcjlSCpjh7?=
 =?us-ascii?Q?9dQBvfj2mAYGuqWuMlCxiiLXLyL1SIbgFz4T19v93FbEanqDaRR4bYRqqQG1?=
 =?us-ascii?Q?4ZfsCfEKTwE9MyjsHh3ed0xThlk76cMA0uh542QCDyATuS5HRCCWane+yFdv?=
 =?us-ascii?Q?bb6q3CmuSGFbVDLb4kLAdDxiCICRVADlKxcDtXX29LFcahlqYMpmFmnhVAZ0?=
 =?us-ascii?Q?gAiN83fB8r+q6xFtdgIzj0ZiTo2H5bJChgLxS9BQw8dfKDvfl+XFbO0pMR33?=
 =?us-ascii?Q?pH53IFWRB8vfXleUe90AcqWmsi5fINaAFexqVngvb6X60QljaC9BwFSG7sJ/?=
 =?us-ascii?Q?Y2OfbTbkNbqzP2bhIqfXc5ZwZS1uYa0A3AVgoVECBQn/qYbrmIPEfGXieK9d?=
 =?us-ascii?Q?A52fv0javkGdZC6epJhZ4iWtrOiaZcU/321AaZY/pOK7SVAyLSOiN7HYWgha?=
 =?us-ascii?Q?tXxyTL4psUA4+wvBey23bGG4fewgYJBIlmVUlYL6XHVyH572aGpzzpvLe1gx?=
 =?us-ascii?Q?BVOMkl/Om5lsWl0LeUOE0T4+7a6tk/t7JuJvpxZMaw86Z1KNWQvuG8Q3i0n2?=
 =?us-ascii?Q?Ve7Yr099i2GH4ckKLnyzW88DhMziia1UKrHuuiz9LGFxzqNXY2pq4uGNXnaz?=
 =?us-ascii?Q?lEVchksWBg46ZKiYlqEU8Qmi9RsizEQYeqThe2Xvz6fHNyTW/PiplDItlzq+?=
 =?us-ascii?Q?UJ2wTgCa8zflCPqanv1qP4N0ZQo4YSpaTOFmSX3Egpj0jfgKGh2/E/rVJGiC?=
 =?us-ascii?Q?J5i6PuInM/2ylApWmaGd/1JS46cP0/OzwUjn/KpjRMibFSkYHnqJhrMdZiXq?=
 =?us-ascii?Q?wIARmP5vVuicEdkHKSvFUtMsw7omITE2w88/2LIxidEugL3Cy3G7K1Sybr3b?=
 =?us-ascii?Q?TLPRYbpNMsHord+hCmIKEwjTg3DcWU+XQg0ac+4GSccMuqaCFriVGFmNR1uC?=
 =?us-ascii?Q?HPORPVUVtKGB/3UqUCmPZ3XJkvli+Z4M2lk7UExBkObWoTZscwYaJg/aAMsS?=
 =?us-ascii?Q?aaIfaQagTEOS60JjsBx/OfgU7hoJfofnZjOZseIbPZMBz8dmOCP9tI7KxSzD?=
 =?us-ascii?Q?ACXT1aQS0OadiMHol7tCoBzuPTG9jYVG0n/aliuSwoL/zxwPLPLEEPkaBrKu?=
 =?us-ascii?Q?HsDnpa4eAeivfGAhYW1LbQV0f/88gXlNmscj/JaG0NZIdLD8650lxgb4K2pG?=
 =?us-ascii?Q?aeOo51DkCifV/kxiko+QIs2/t6v73bZnCOEvFeMTGQALxMt+9nmoGGkSCi9J?=
 =?us-ascii?Q?gwnkYSEwlFV3d2sDKHiJsPOg3oTzTNGGcTEa7uWl?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5e4389-849a-4998-26b9-08dc6615653e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 17:22:06.0417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQ5xxyuG8g3P4CbAfNU0yBUOFjxZJBcdJna9/l2pV1KOPmstkfXdQCR8g+UjzJFMITtqsadiu4NXEHArkT5EuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR22MB3786

Convert the lp873x binding to DT schema format. Converted with
minimal corrections.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 .../devicetree/bindings/mfd/lp873x.txt        |  67 ----------
 .../devicetree/bindings/mfd/lp873x.yaml       | 114 ++++++++++++++++++
 2 files changed, 114 insertions(+), 67 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/lp873x.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/lp873x.yaml

diff --git a/Documentation/devicetree/bindings/mfd/lp873x.txt b/Documentation/devicetree/bindings/mfd/lp873x.txt
deleted file mode 100644
index ae9cf39bd101..000000000000
--- a/Documentation/devicetree/bindings/mfd/lp873x.txt
+++ /dev/null
@@ -1,67 +0,0 @@
-TI LP873X PMIC MFD driver
-
-Required properties:
-  - compatible:	"ti,lp8732", "ti,lp8733"
-  - reg:		I2C slave address.
-  - gpio-controller:	Marks the device node as a GPIO Controller.
-  - #gpio-cells:	Should be two.  The first cell is the pin number and
-			the second cell is used to specify flags.
-			See ../gpio/gpio.txt for more information.
-  - xxx-in-supply:	Phandle to parent supply node of each regulator
-			populated under regulators node. xxx can be
-			buck0, buck1, ldo0 or ldo1.
-  - regulators:	List of child nodes that specify the regulator
-			initialization data.
-Example:
-
-pmic: lp8733@60 {
-	compatible = "ti,lp8733";
-	reg = <0x60>;
-	gpio-controller;
-	#gpio-cells = <2>;
-
-	buck0-in-supply = <&vsys_3v3>;
-	buck1-in-supply = <&vsys_3v3>;
-	ldo0-in-supply = <&vsys_3v3>;
-	ldo1-in-supply = <&vsys_3v3>;
-
-	regulators {
-		lp8733_buck0: buck0 {
-			regulator-name = "lp8733-buck0";
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <1400000>;
-			regulator-min-microamp = <1500000>;
-			regulator-max-microamp = <4000000>;
-			regulator-ramp-delay = <10000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		lp8733_buck1: buck1 {
-			regulator-name = "lp8733-buck1";
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <1400000>;
-			regulator-min-microamp = <1500000>;
-			regulator-max-microamp = <4000000>;
-			regulator-ramp-delay = <10000>;
-			regulator-boot-on;
-			regulator-always-on;
-		};
-
-		lp8733_ldo0: ldo0 {
-			regulator-name = "lp8733-ldo0";
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <3000000>;
-			regulator-boot-on;
-			regulator-always-on;
-		};
-
-		lp8733_ldo1: ldo1 {
-			regulator-name = "lp8733-ldo1";
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <3000000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/mfd/lp873x.yaml b/Documentation/devicetree/bindings/mfd/lp873x.yaml
new file mode 100644
index 000000000000..87fefdc3126b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/lp873x.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/lp873x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI LP873X PMIC MFD drivers
+
+maintainers:
+  - J Keerthy <j-keerthy@ti.com>
+
+description: |
+  PMIC with two high-current buck converters and two linear regulators.
+
+properties:
+  compatible:
+    enum:
+      - ti,lp8732
+      - ti,lp8733
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  regulators:
+    description:
+      List of child nodes that specify the regulator initialization data.
+    type: object
+    patternProperties:
+      "^buck[01]|ldo[01]$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+    additionalProperties: false
+
+patternProperties:
+  '^(buck[01]|ldo[01])-in-supply$':
+    description: Phandle to parent supply of each regulator populated under regulators node.
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        i2c@0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <0>;
+
+            pmic: lp8733@60 {
+                compatible = "ti,lp8733";
+                reg = <0x60>;
+                gpio-controller;
+                #gpio-cells = <2>;
+
+                buck0-in-supply = <&vsys_3v3>;
+                buck1-in-supply = <&vsys_3v3>;
+                ldo0-in-supply = <&vsys_3v3>;
+                ldo1-in-supply = <&vsys_3v3>;
+
+                regulators {
+                    lp8733_buck0: buck0 {
+                        regulator-name = "lp8733-buck0";
+                        regulator-min-microvolt = <800000>;
+                        regulator-max-microvolt = <1400000>;
+                        regulator-min-microamp = <1500000>;
+                        regulator-max-microamp = <4000000>;
+                        regulator-ramp-delay = <10000>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                    };
+
+                    lp8733_buck1: buck1 {
+                        regulator-name = "lp8733-buck1";
+                        regulator-min-microvolt = <800000>;
+                        regulator-max-microvolt = <1400000>;
+                        regulator-min-microamp = <1500000>;
+                        regulator-max-microamp = <4000000>;
+                        regulator-ramp-delay = <10000>;
+                        regulator-boot-on;
+                        regulator-always-on;
+                    };
+
+                    lp8733_ldo0: ldo0 {
+                        regulator-name = "lp8733-ldo0";
+                        regulator-min-microvolt = <800000>;
+                        regulator-max-microvolt = <3000000>;
+                        regulator-boot-on;
+                        regulator-always-on;
+                    };
+
+                    lp8733_ldo1: ldo1 {
+                        regulator-name = "lp8733-ldo1";
+                        regulator-min-microvolt = <800000>;
+                        regulator-max-microvolt = <3000000>;
+                        regulator-always-on;
+                        regulator-boot-on;
+                    };
+                };
+            };
+        };
+    };
-- 
2.25.1


