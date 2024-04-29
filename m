Return-Path: <linux-kernel+bounces-162981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8159A8B6301
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111CF1F224BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DACD1419A2;
	Mon, 29 Apr 2024 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="Iw5RU2Bs"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2131.outbound.protection.outlook.com [40.107.101.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339861411DD;
	Mon, 29 Apr 2024 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420731; cv=fail; b=X1QYU4zUl/WJwOpF9tsOtl/Qf3vc5Px0lwUEGND5yOgYEpoB8jsqLurqjT4+jP864ZWuFXeZ0ve1jkrp8twWAS5wYIyhGcRmrkjdzePnPgqDh30j+snd7P1I6rlTdnP6HDUbsV2jyloaIDXlHCc7NrAs5gOdl1kPDxPCV6FHZgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420731; c=relaxed/simple;
	bh=vlz5GJsEUYOjqlVQF6fN/XpGNkb6zvg0+pwFU6gmOho=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=f0zaw40QaRaW2OPWvTq4yz2O9u2MILjfYCU/NUoPFtqVc4Z9YHI1vs5wRWoRvUQdRDhc7w3Cix9Fhf0IzXTdr2ySMdKmiWfdtje0RreBY0OvAUrGykdCztmwl5FAIePcU8Cksp6qY3e62GwjArsWVwtC6X3n01CZhLIbVED2bFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=Iw5RU2Bs; arc=fail smtp.client-ip=40.107.101.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbscEK4qr+ZzsIvOGobymVUU247LInHjdTXBm7nCNaoKLxP2S9N8dQMCoWDKudMwH1ieqz+pEyCGHGzMCBd/tIJ/IkipCoas36SOh7apQMWABXSCwbM4/eyvOvImM2bS2i5tqNP+R9UsfO2lsQjK87wRiU6J3Ue/b/s+SSmNFTEEwtjt7RN+q6y1t3fqnqzIAY5RYgEluwKCGgLpAWXy3JAdsyTjlso/k5NI/ByzY5/QlC5rXa4Fca40qpX9UWC1OquC+7QEhH7pBD+LlVy2AN3rRePMwgDPmmiMKXeExv1GUN5rpPdhnEaOJY3hBVbSliRaYyBS5hqky6SDsQpcug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgpKZcVHRw+lWtWey3gnvC6lBU9RyCAkIkL9WQef9u8=;
 b=jU97y+Bx9nL7FvH9CJ681rlz/jZqxSDX70n4+P59pygMZmX/pYxPootfXASDgXBtq/DDOXG0/h4BFOUbBRHqH/OjekOFs7wZcUusreqxbVY5HTjrNUz494G6IqSaPLYpb1KWL5H0sQUdxBb0v8f2f5Jmy8y3Phx7tPlnoNzc96s9A8CVqBbGKKbzIIxf/C7ZEjrhav5ec1UF1JZEjVaqzFhN+9H7noXE/LdF6uJYQxmDVZhkpsMfCBcD56i8IayZxeR+3wlBf1RsHcw80BaVViWDI4G8R0TF3KWbBHfRhyjUyVUKfrpNiRKWJGqzQyaGgKhdm36DWc48+vK/wjCj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgpKZcVHRw+lWtWey3gnvC6lBU9RyCAkIkL9WQef9u8=;
 b=Iw5RU2BsZ8JZ1jjeW4ho9HGkDypMRQrYQC5DVkhTNiXwKOCRY/WnknzFAHQQk0Cij4GFVEs+c4HzdHE8sc4ASsS+KJFyHubcESi33r6IVx2KAtP/nuYed0l50CQgTDbEkUqojgC7TTbX1LHvsUPp9BcVw+RPiV6cKzNqQgLkIgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by PH7PR22MB3962.namprd22.prod.outlook.com (2603:10b6:510:2bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 19:58:43 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 19:58:43 +0000
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
Subject: [PATCH v2 1/2] dt-bindings: mfd: Convert lp873x.txt to json-schema
Date: Mon, 29 Apr 2024 12:58:29 -0700
Message-Id: <20240429195830.4027250-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: de1431a7-3ec0-465f-e9bd-08dc6886c5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WtLkWAkatMhipEAMmPgDb1vNqc6WELXIvMgPrj/jGLoW3uXUpLy/baB2yhVQ?=
 =?us-ascii?Q?09s2Yo4FoS68G2SQO6UfzMluR28MeTiPQfKZYbjOuIxaPWkfc28BGgefmoJ+?=
 =?us-ascii?Q?OLdYBa6us6D8J+TS923PcdAc9yh5yvnFr55wuA4JiiokKKLwfSySIEZ9YKft?=
 =?us-ascii?Q?DiA0Kdj+baMdDkZG67oxH15Mgzq2x14N0gpc9+R+jknDanci6PgC2GZNv6Gy?=
 =?us-ascii?Q?I91oatGLHKX0SDjyjv5ZHdY+y5zHKWLYccXNYn958KU1L6AYaemTT+iwM+3P?=
 =?us-ascii?Q?9Li9HBfGdLp97mMTivregWAqJKi8msrQgFGVzx80h1NIpuR1H2NQLU1pP9OA?=
 =?us-ascii?Q?kFZoMxQ6lEkrBzbZmYprVm/k6NR6560roH5C6Ipy/0WadSzxMAnDZZMwQcvO?=
 =?us-ascii?Q?inq0lowzuwXwq4MEtHa8A0MhKIrfKnIYiPhlcRXIJxNtPsrVkmOq4Fo+xIIq?=
 =?us-ascii?Q?e5vpKMah0bMvGzIX7QvHkAH2CbdeZZruh79onGvFcUJNKe4fy1WwEj9AOKzE?=
 =?us-ascii?Q?hJzE+f6w7aW/2saYBfI1QrIZW7vB2OIRep4w9LS0piZr6iFC6X+DuLkVouSc?=
 =?us-ascii?Q?Sy3kQ+fmVKt23tlEcX0My/U18tYnr9gIE0xNXYVVMTp5k6vtfPCrj+0fwJyG?=
 =?us-ascii?Q?N6xsKmBuYQDTcPmcxuukwyMcEUPLOv94o1QBETAsCQJIhN8sTODzY0ObvdnP?=
 =?us-ascii?Q?3HqsDJUi1+VAoDES0kV9wOs7OBlrmaF42mhlogv1oEo5tJP9wBrPk3tDVC1e?=
 =?us-ascii?Q?eE533KpydYMGamIzmJGz9oQBSPouGeLdGQHYj01ebRSZeoftxA3uoQ9l5xNb?=
 =?us-ascii?Q?DJFeSAGQSclPZTqWnmwu+BSuOtgjCaArkbXCQEECBcKQESbyWkexHVzGY4Xv?=
 =?us-ascii?Q?dltHEHMg2OFGn0k7GneylbVBCl7FDSKVueZITe7WbPqipww01ZL98ddFNgmt?=
 =?us-ascii?Q?Up1/8NrIQDb8jvSlEfwVK/xTQ9Uf7qpp9vbCkjvyJpDM5Bho29IvcneLIUcB?=
 =?us-ascii?Q?rHfsu9ID5qA2KYT7MfIgPc4VU4CB9iDXIk8QCSa3CNd6KW+X9zLcwRYp5gi5?=
 =?us-ascii?Q?yCjeYGDezqvb3qKd1qZj9Rgx5RTwgdFZyG3k78CViF6O+7va6TWd6qGfvIYl?=
 =?us-ascii?Q?uUu7ooLsW9rUkvItFr9etjztlQDxBRG6szu3+aqvG6pp6uEI/tO1tHXMMnUS?=
 =?us-ascii?Q?f/ldj+pFZ2U77uVXA8a83CtIQ+eLC4WG7SRloHmuDliTNTOYYMb9vJz/7CXf?=
 =?us-ascii?Q?5r9QT9RqccsR+pcDoKLvZXxLDdn7v/PzkYelAwwk52D90vHGbQfB8FvyB7TX?=
 =?us-ascii?Q?1Ks=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rN3UNMBTno4P23L/2xcFRMVPnFO1X7d9gnfQcX1QX5Y0H1G2Gu+cJazHcp4s?=
 =?us-ascii?Q?Uz7TEf8UC5jcm6KaC9vm/3ErHOafVVAaHeXo1S0RixQ4RjKZl8gTjgiUdwQM?=
 =?us-ascii?Q?eS/V+FT8FoDnnmhmFsQcONv9dXg4X43QEx8uw61P9/BWrcf9hNbb4MNCoQGZ?=
 =?us-ascii?Q?MfnEx6s6PeqLP9/1PRZ1isw1ugriOTvWghzYnInUiApSwLv7Ma/Cs7qRZNUZ?=
 =?us-ascii?Q?Ao3F6rTmvj6xOI0B7Kec80S4efGvJAEPnnU5lqlXjngXYxAzaSFetwb8plit?=
 =?us-ascii?Q?St10cNM1PmjSnzuMX7Uj16eILmk1hfxAGNCfrOs6PqyupY6RCG1rbHxrVAr3?=
 =?us-ascii?Q?aIJGwbjoGQN3FoWpep1Ynq9nw61vh2WjgdnAfQPmhDUR2CqCldEXdfx1kKcc?=
 =?us-ascii?Q?OqUxhhplDwXScsUOT8nmRjD1422hTbHAJJfoH9eZgXUcRcidjO/jCDuP9dP3?=
 =?us-ascii?Q?sADW4DlAytdefATJQmwmcRXhc1ZjV2o4ijc/NzWYJUYbHlt80ots9X54f7o/?=
 =?us-ascii?Q?LbRwNDcJvpmCD+CR/WriNDlw0wSNgv61c3sGOaa3xLktuYy3Eoqb1yMIhivI?=
 =?us-ascii?Q?q+NNbhnZAAFOkBWv77ZNd2dJlSfcg84s1qvomtMF9d4qfHTV4tewIef2WkwE?=
 =?us-ascii?Q?DndcdILtyuiqnUZEPde/whehd3eq/r4GQPPP9aqnMdYZrLrap4GRvftEij75?=
 =?us-ascii?Q?Z3Qax0WozTimKF0T3pWN/8MzBv+aK7q59OEjLuXAjIoyORL7M3nMCjr+KxxC?=
 =?us-ascii?Q?fRcWM0Ifr6auIj5vweqqDEZjCbGqNI0EVahru7TzFGqSGMO0x5HfkktuCRdM?=
 =?us-ascii?Q?/FDTFvGNG6ISDIfvEOog4mVsGr1B7G/zB3CtT+SXr02i1G0MX5muiLFyJQfA?=
 =?us-ascii?Q?mEbfAYJYcg6oFxrnBkjf11pSQT3Lza7LpruWovo6WYujE6/wN+J+NYuwym2H?=
 =?us-ascii?Q?UDyuaWEY5FqBVU3nXMZsyt6pINEFcRW75How3VirmI68/4lve2gi4aOAnGRo?=
 =?us-ascii?Q?upkU0qHchGoyTGZeKIrmEI/tb6IW/PG+d1DTNPcHDcawKlBzAjwI/E/3qrCY?=
 =?us-ascii?Q?9aQM8DKVF550BWKB7VRqsNxn3WO9hwbZeiG2xdZ+LGIpgThobqtIuzGYZok4?=
 =?us-ascii?Q?Xx6K7GmBGADbMARl7J/p//xvvqzKIr9xDf5HHRu8ZJ2wA1sGwHp8heLCTrS+?=
 =?us-ascii?Q?sD9lp/sEqz6n7m98Mpa+DmuOh39Cg0SGeOI6A2u00dQ+gd9UIK5N2ulEkz8x?=
 =?us-ascii?Q?TYlkNWXkubpmJSgt01lpVKPoP2HWXOSS/T8wZ4NDIWzibf3cTylLw7flYkwk?=
 =?us-ascii?Q?y2VMdDAe9keWCrJdJyRJok6PzNS6dPkbY3/QtLLO+X+twnwnWRtWHnPSFYY5?=
 =?us-ascii?Q?caZWy+XoNXmlNDTFwwbcZAw7ayUcgp3dnm7Q7mhnAyDCd4TV2hcBOaeEzleW?=
 =?us-ascii?Q?oZ3UHxiH8ewsxtv5eFIXGHFJ5zFEjslJh0Va9c7C0ueFNdbYzKKPbboJk2SR?=
 =?us-ascii?Q?J7ZYLVf7emHuGfwyV1pYOGVxZlB5MDxMFglLjklsL4LIYQEndAwHPtT/EsAe?=
 =?us-ascii?Q?2aLslQEYF+7d20kdi7HjyDYYCG1RquwNyuu1v9Bh?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1431a7-3ec0-465f-e9bd-08dc6886c5ab
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 19:58:43.2987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+GtzQvgYGS5xpJ4bpQcBCT7y0y8I7yL8gmmhvRJRP7DpNTlk1+kDSCEQPoYBPOBY9DqJXoMcuTH86zFo4I4hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB3962

Convert the lp873x binding to DT schema format. The gpio-controller
and #gpio-cells properties were removed from required because using
the device as a GPIO controller is optional.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
v2:
  - Added "mfd:" to subject prefix
  - Added vendor TI to file name
  - Updated title to match hardware
  - Removed | where we do not need to preserve formatting
  - Added *-in-supply back to required properties, they should not have been removed
  - Added explanation for why gpio properties were removed from required
  - Updated the example to be more generic and got rid of unnecessary i2c node

 .../devicetree/bindings/mfd/lp873x.txt        |  67 -----------
 .../devicetree/bindings/mfd/ti,lp8732.yaml    | 112 ++++++++++++++++++
 2 files changed, 112 insertions(+), 67 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/lp873x.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp8732.yaml

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
diff --git a/Documentation/devicetree/bindings/mfd/ti,lp8732.yaml b/Documentation/devicetree/bindings/mfd/ti,lp8732.yaml
new file mode 100644
index 000000000000..9a90cee2b545
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,lp8732.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,lp8732.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI LP873X Power Management Integrated Circuit
+
+maintainers:
+  - J Keerthy <j-keerthy@ti.com>
+
+description:
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
+  - buck0-in-supply
+  - buck1-in-supply
+  - ldo0-in-supply
+  - ldo1-in-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic: pmic@60 {
+            compatible = "ti,lp8733";
+            reg = <0x60>;
+            gpio-controller;
+            #gpio-cells = <2>;
+
+            buck0-in-supply = <&vsys_3v3>;
+            buck1-in-supply = <&vsys_3v3>;
+            ldo0-in-supply = <&vsys_3v3>;
+            ldo1-in-supply = <&vsys_3v3>;
+
+            regulators {
+                buck0: buck0 {
+                    regulator-name = "buck0";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <1400000>;
+                    regulator-min-microamp = <1500000>;
+                    regulator-max-microamp = <4000000>;
+                    regulator-ramp-delay = <10000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                };
+
+                buck1: buck1 {
+                    regulator-name = "buck1";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <1400000>;
+                    regulator-min-microamp = <1500000>;
+                    regulator-max-microamp = <4000000>;
+                    regulator-ramp-delay = <10000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                ldo0: ldo0 {
+                    regulator-name = "ldo0";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <3000000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
+
+                ldo1: ldo1 {
+                    regulator-name = "ldo1";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <3000000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                };
+            };
+        };
+    };
-- 
2.25.1


