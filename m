Return-Path: <linux-kernel+bounces-31578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5156283304D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73A71F23F13
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B851A58227;
	Fri, 19 Jan 2024 21:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B1p7qjem"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF3C5789B;
	Fri, 19 Jan 2024 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699910; cv=fail; b=Vrcwzi6aSiNBkke569aDnucywLPBvQSbnwqR7TcrgmRppPpohHZ85o6gub8mGMLdBivDKv2W+asN2GcC4fkhIz/H1fJ3sv/HnEPUe/G256fsiJK/APAYPs/gIOqWTAunuVlERapzUu1hZvkw8wpBI7aiNoOUeKw5/1keylYXWos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699910; c=relaxed/simple;
	bh=HraOdqhfdSQQK2n8bd3HC2Iaq09d3z8l9zFaFSY2TGk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Nx3gnYNYZMaMwcVbhXlbKAbncjqWEPDllop3jEyEhgQ7BGjITRncrBVxbvlZmv0iQ7MtGpIWuZGvFFTUQfd4YXA3/q+aQnnHieq4zG/sfB5kput1QfEcNxbRastaP/XKFomrn8oemGfSi9T3BeWFAFSRcTpObaUH7/lJuSEXXBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=B1p7qjem; arc=fail smtp.client-ip=40.107.104.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFA4/t6aPZLTp2Jk6HS2e94HcfHr5o068iYKyMUa1jjeY4X8qyTPn2K9kkipdOBkTH5HIcZwu0kgOBjCG7gYmKc54kM7SbEQLMbGPRN0sWCHHDpOOi0hPx1X4fh1QddwGTZ31IVt3YjWwMfX6yq7K7XNrvzmQRalSsbLWHM8EuHXl6F08nMWaydmvBY5Bpf6W+63o93N4ov7BRfPNL6wk+8UwRQIEtWj+7p+/1iMzseJhUX5O9bqVP8ZKS5vCeNuUFyFlWish5yzlb9E+fF1Dmu6SzBbUt8qcYL9Fev4xb1aBgRYtknv8ONoavLRWhEXKDUJmBkdxuH+9LjaxFubJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aa5Yh+YstoUqdEz5JjT88gDzczrZHiAwy+c6tvds8+0=;
 b=TJYOwvJyys8+Z41fTl3tt39/BLr2kKUSW95p2rXpdXtO4dXTy/EzSQKCyUOdlaPVH12CDILTJSnKBKICxjqoJKEFpTeezECLpXle74cM/nWo5NqYxAW1idX97OQtxdCOMUjWguTkU6BNf4lOm9dxqS7z8ys5SeAD9mXAAYw3b22u5yW3wz6geq8r0VmNdxvc+UV9gFy3ksK3EM3xn7GKN0JaP2UzZKVHQsKP05TjEn/CFbyBfg9gO6R41VkpDu4GwKKlY3q5rTRUUaEFe5mXZh1di/TA6vMR8l24YxhiB+coRxKucEwXXRf/+XRX+EB6OSSzw5z4Y4wOUh8ES8fazQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa5Yh+YstoUqdEz5JjT88gDzczrZHiAwy+c6tvds8+0=;
 b=B1p7qjem9TmReWEbk88aQJBHaxwW6IHC5ZXAFCHo0CGiJ6sZnYA2qFlLRpeikyZmRlGHeKuvgGgPw9JcmO6nK6TNWzybcRGW/twbSsc2rcOuTk1TbZqJLjU17QxERNQVd4ZTypoIAOSvHU2u0KXH3h+vPGtufURjOxpZNPBITYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8795.eurprd04.prod.outlook.com (2603:10a6:20b:40a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.27; Fri, 19 Jan
 2024 21:31:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.027; Fri, 19 Jan 2024
 21:31:46 +0000
From: Frank Li <Frank.Li@nxp.com>
To: ran.wang_1@nxp.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Felipe Balbi <balbi@kernel.org>,
	linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mark.rutland@arm.com,
	pku.leo@gmail.com,
	sergei.shtylyov@cogentembedded.com
Subject: [PATCH 1/2] dt-bindings: usb: dwc3: Add snps,host-vbus-glitches avoiding vbus glitch
Date: Fri, 19 Jan 2024 16:31:28 -0500
Message-Id: <20240119213130.3147517-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: 95461b46-c4f5-4104-3f14-08dc19360989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	asVnvgT1Ofd6TLLiA6NgpTb2D437abZV6s2rLCaTtH0DqxY2qEqmNRBkXHtxQQ81Xyfw/V0kdqyQhtTR94LC3obah+TkInPcWP9NKCfYUGrb7ATn1mMIH4kt9PIdDQ4Iv41PZHHZJpr/w75yf5d1QYihHpcCoI14hqZxfo7BpnqbRqDXI/Yo8Ii/kRx8NAckccQFKfncMFSa5TWJJJFWEufwxx0yBH6Tww/4qtt/UfwnIJNA8zt9iWP4YbnerXoQfPgdR/fb5UOMzJFbFricNIqNE8jHY6yaShBnWBrTyn5+luz7QnIGmWsbJhzgJgUjMMr2PUMhWALrAJlT9ru1V4QD9YMKnuoR0kDSVRASBq5XZYyc6z0GOOxy5xtpKqgId1pujyez96NNurjl7oDqaUy3ThuzEhDhpePYC4/N5QUCEm81rOn7p9cv8iLqc3Du5Kd9H3jetuOTrdq76jp6fqnbtvN5QkdYdQjg+pVIO4jYgxYVAB0JxSlESQ8YQDeOmbQoTEqMQ3xJSXmOMlRt58CaaC3cp9AvJPfEEClxdRB5/L9AycogkaTAK4hsgerBoOUCSH9rbSsA0g0d26HU37zc12zLEDJc4u3BgtqlxwavSs7jE8zXSI/xI3qE6qUxxiYxZjnOfv74F+Gm/sKzSQ1O6RE9gC1PFbubPmKN5Ow=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(346002)(39860400002)(230173577357003)(230922051799003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(1076003)(5660300002)(38350700005)(7416002)(26005)(4326008)(8676002)(8936002)(2906002)(86362001)(83380400001)(478600001)(6506007)(52116002)(6512007)(66476007)(6666004)(2616005)(6486002)(36756003)(66556008)(66946007)(316002)(110136005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5h4gkTXHljU05SmoEkNkkduxUJ/3Q8671mo8YfTUQvlCShEivXff7vKGUK9B?=
 =?us-ascii?Q?54zBsmDtZsmIax5iPcURkX4sjSS07oHX8wHjTpA4oEwdVx94N3AH/Ldj5vV3?=
 =?us-ascii?Q?1jIdpy5OrwbgYyf1HN7UinTStpNB09KDE+xfkuK6/guB1tikaAjr4H+BVvTh?=
 =?us-ascii?Q?lMpx+LUN7OLO92kTOYxjvzDk5aT2Ue32l17slhmevM/p0QqlD4Dn6zfid+n8?=
 =?us-ascii?Q?F/aUj8ey+fr9eEdZBwgKRjeBHpKDypyEuRM3pYZzT9ixZEwLb0OsiQdHLfD7?=
 =?us-ascii?Q?YK5aXTPOPEJxhbTFMpn7unPxhrr7Pr4eAqnx244hhj2OPv5St6BcdnJiC+hW?=
 =?us-ascii?Q?77/JAZiXQ4Fo66e1kXTuWgb0MSxdZes902tux2V7lQm2uHUAO0k4h9SCkMON?=
 =?us-ascii?Q?Hsqeg+dDB+gdrFvMIOfDlnqojTTwMvVa4NCiyXtBlT3oaas5bogAVgdiwGK3?=
 =?us-ascii?Q?WFZrtPY6tIXpGG5yGgvmWBcAQNrrl9TP0CVqW6V+SyO2ZXtJ76xlXij0iZix?=
 =?us-ascii?Q?+ziDhxFIgTuIuMTTxOQaWhXxmezxTLzmlu3+TLn5s1KCTPb1AZTEh/7m5C+v?=
 =?us-ascii?Q?sEk9ZOqs6h/CDrYL7+uDMC/Y9hBH5v3EBQETJf8BWr0a8R2XiDnTV15Qycx2?=
 =?us-ascii?Q?a/I5pySsTBRddWGOdOTHDJ/CFJWoDjiM3aUK5dKw3b5Vs/nanR+PD163+zgc?=
 =?us-ascii?Q?OhpEQjlxC9zYL+Sxx5u6+9r9M7aeuIXhi0sWo/GxcQfjffvlyhLWruxc4a0+?=
 =?us-ascii?Q?q3BVP8pFsXaJmisD8B0fo84wT4vondM+FEfhXrRc0hKCKj/Ih05pBxh+J/R3?=
 =?us-ascii?Q?FUCpbSKp0Ea/A7KiFwCPOQU5UBOHVeLUN430KoOtzxIfj2sbp9DL0yhAxpRe?=
 =?us-ascii?Q?OQeVCyN9JmZAdGBtg0EdiH11uKtWFcvtK7wcgnM+krXYUzl1bc6M7HC7/mZc?=
 =?us-ascii?Q?t8sVk1awY0BCBnHiY2JAhLkD4srZv06M46Rz9ExB7SGn4UHZnwEaCYFHH8Rw?=
 =?us-ascii?Q?vxn5+Vny7XPw/Rz0HdTjyWjXMzyWb1yrp42alRp/VjmTJUf9ACOEMPT1ypXV?=
 =?us-ascii?Q?DGqJc6ThmGe3+m1eCQOoAr7FLb+jw/BVm1crb86PjVBlEZjf+613GTgksf8y?=
 =?us-ascii?Q?kG+BvvmN6kwIG9B29B3ruvpF9TJQfyvN2CqcbfuMV6KQ+9IT083bm0BX4Ay8?=
 =?us-ascii?Q?06nYs5j1C3G98Tg8r3TpeANiLNr7mc66toeXXtdwbhAfhlMvL9JzCWVCj9oT?=
 =?us-ascii?Q?yz/JzcjFKTsBM6sDe/7OfmK0RbosestCdfy2b13A6Mw/W7L14OJUPvDQ94Am?=
 =?us-ascii?Q?474wIGDMnkqo7X3G0K38vA8uPLJWG1xG4ZhKrCTkv1uiERozhjo3KBrRnQfe?=
 =?us-ascii?Q?C/HafoQnnqy/4BrQzdANF5xoFcBBxRSXpAxqwFiO2A8kUGb+5ombtHMXKCNh?=
 =?us-ascii?Q?m3G3jqMQht3UlStM/QAbs3rfFVb0DRsFnwYSNNdPs06IlswZM34zYgnuZMP/?=
 =?us-ascii?Q?km180/vdIyrMLerrwqxCHPHdMx21ZxeeRghd6KRiutHUZc9xUHyyjmkSfkF2?=
 =?us-ascii?Q?HumaEIZiUCWh7d0IbEN6AsX6GEOgafHLuh4vkIJd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95461b46-c4f5-4104-3f14-08dc19360989
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 21:31:46.0982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CA4UQADsDnXwhvA3+No1ZO4XQDkYtLQjYOXrPdEmKThgMWsyHiDMQ8A1QMNuYFC0f/Zo5CVILBrTQGcb+ODPSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8795

From: Ran Wang <ran.wang_1@nxp.com>

When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
(or its control signal) will turn on immediately on related Root Hub
ports. Then the VBUS will be de-asserted for a little while during xhci
reset (conducted by xhci driver) for a little while and back to normal.

This VBUS glitch might cause some USB devices emuration fail if kernel
boot with them connected. One SW workaround which can fix this is to
program all PORTSC[PP] to 0 to turn off VBUS immediately after setting
host mode in DWC3 driver(per signal measurement result, it will be too
late to do it in xhci-plat.c or xhci.c).

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 203a1eb66691f..dbf272b76e0b5 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -273,6 +273,13 @@ properties:
       with an external supply.
     type: boolean
 
+  snps,host-vbus-glitches:
+    description:
+      When set, power off all Root Hub ports immediately after
+      setting host mode to avoid vbus (negative) glitch happen in later
+      xhci reset. And the vbus will back to 5V automatically when reset done.
+    type: boolean
+
   snps,is-utmi-l1-suspend:
     description:
       True when DWC3 asserts output signal utmi_l1_suspend_n, false when
-- 
2.34.1


