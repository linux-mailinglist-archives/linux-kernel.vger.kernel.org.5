Return-Path: <linux-kernel+bounces-103295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB3987BDA7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B10282C60
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947856E5E1;
	Thu, 14 Mar 2024 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZHhYhe2Y"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818FE6FE22;
	Thu, 14 Mar 2024 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422851; cv=fail; b=sttfXOUgaAoTWeGmixt12hXPfEsUuuIbkcGV06uD2GGOGgoSAcY8SwKOjuGaFTHx0xTZ9C+zxFBYLCwML3mEVOo4MVB9uJsKX5x03MpztDM/rYekUjDcFBbMnoA5ZE9S/uVVUnoaQj/D1nRNH1Q+FYPcuQ2B/2R6SVVHmIhdVVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422851; c=relaxed/simple;
	bh=tH0eC01P1SodZKI50kIXMHtNzY3s86HNL4/2f2223Bs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hE/9nZiyQzabtON9jUn44qYAxyyTWVSJfykPakL+6aSsvuhA7DtuZ0anw1N7juzQAxFfVB8RsHzfWWNZaexJqMxyW1N4NqMEOmIoWb/YWjPhwtK4D0DEKbxFLGTfgstLYvBR0bNgIGP7AR3YfhT4ZaLgsL2HuRCi4m2PHIPAPKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZHhYhe2Y; arc=fail smtp.client-ip=40.107.104.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgYZpKBQR23OM0C5diJN7ncjNdRv1pPch7L3vuMYfsnwVQZRBtHCF/J2jlvmYXfj8jLUeRr0Q5Tn5H1P8oJ/xG1d8IIamEAJ4JeFtU9VBLR3L5bLMpJ2WBKciETQc/HGOXfd6/DrwMwHUWFx/tx24M2QiTDUQanLOdWzQc7p20dCF3ic+Oyj8JTVeqfcuXBh2Ro7H51gEToqxOeiCQZNin9c3kZuNSaw9te+Lg+qGAH10M+z3YwCyi5tFSK19jMSKFHEM13zrhgI0atL8OzItmpvG3civ1gKCCOPBe8z1+PuyIMjoj5RWYgDb+LVdi8j+eNvYHcaXU762Mvtk3HQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XS4cAFTg6rut/mYml6sCuuTOigzwfuxEsF8o4aFYzec=;
 b=DXsGgmpq0WSrLEJArwHscXVp+iTHUOypLBIs0eYfPjVa4Nta6PIpak2d7DjbvjtglAE3ZjkUkeDc+N7wHlfTTvAaMFCITskMUW6C350OhplfR7RDP/xxPMgwPFmQfmMozChjAj04qv51XG6qa8wktO9FoU2BEcY4+QRj4aSKCsW27rZVv6FgmR1Q8gv0p5Yte6m1t68fkTsw8hAatvBR7GPtIOcvaf63NKiFVAqINFhy5ga28uamQHZjMKfbUbWOmQl1TWzsxOM3nPfuP39oCcNdm8DhPH60RVxvxIoFP70l1bwdh0/sHNFK7ZqLKlEJ3l5Hd23qYOu6ZBFtYId84w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS4cAFTg6rut/mYml6sCuuTOigzwfuxEsF8o4aFYzec=;
 b=ZHhYhe2YpzYVO81iEhAwm5rZq6jMHIMVOPdISeIuFWVt+gB3+WQ7HxzU/lqaY8wE7gK4ndp1BiMsQbJ7GabFG2f5GILzg79A6KBAjsVVqKgVj+sL1134wdttElvhMq8+I+mTifmmy2BJt+tjBDMC2yetd/ySZcmv2kwUYWwkuHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAWPR04MB9861.eurprd04.prod.outlook.com (2603:10a6:102:381::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 13:27:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 13:27:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 14 Mar 2024 21:35:20 +0800
Subject: [PATCH v5 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-pinctrl-scmi-v5-3-b19576e557f2@nxp.com>
References: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
In-Reply-To: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksii Moisieiev <oleksii_moisieiev@epam.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710423327; l=28800;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=XZwzoonOhaJxlQjlsC99F8HeyGsNpcCXiDYSm0qP2Ws=;
 b=DRJlM0aVKmUAkoQMvJbHjPiGQNcPmGrWEemX7HoN/RQWk1CjUM9eL9Nf+PGcb/ezgVJ0+nvAT
 /JbOQdISkZ1Af6wiIOfyZQIL25PNs0W2g7jTzCBqLfF4rrIm308j+45
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0188.apcprd06.prod.outlook.com (2603:1096:4:1::20)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAWPR04MB9861:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e015a2b-42d8-4489-467f-08dc442a7c9d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AkZMWNXXrS6qnwKX+suLVKc4t3qXoMu5QC3NGJwmxe+p+U46MFzzoit+nvv/bFrvai4IPIx1/D8HsxpANqhMuj5FSUVl9CTVRvJCfHnPeabjpkZNs6nA9ULLESG4ZYjPA53x+REYMjBXiCKpN4Ooaw8gi3kuBxBY2GGDrpkeatI5v3Xj3sDBqDWN/MnO1mMIF7GMinAarG+5luXxokdhMuSRiJM6T3sOKydnwh+UK/l+eMTJgYfR0xA4BUBaf2c6T5t9/5i4Hrbcuwv/lBPvjWPEkdf2W1Q0TAWj4YbSOAfU1PhR4f6UBmQS517zo6Y2NMQ8KnXdLn1J/sIDqO7imBAi5n/zgPbOCwRfATvnd5EalgqelXRiCDYkKzzHQ6P/qty5bNw3ss2eH7Y1kEPVbkSj1ML7XSMa7pqfiUeejUVbfBZwo6oD2ZKJ3RdKSoMu/1gH5a2xyurcHA5Bz8onglhAgvhlYMo3BGjOlIMbelWKq8clBOIpJnwqqe4P0O9/T8D27EQvjtzJZCj8l4UXky260yJA2k3iQtoKcKKyBOo4FsgzVzkMhY5sR/If8ndzwxQ6zLqJq41BtlZpv7UBTg5IbheVm/H6dRCYZQMIDi/z4H2iErvnINQhfpyznfNqum4t1t5F97+BgK7Tg2RYBrVZmNHoz9rZw3FPeS8z3eA/pZ8DdH/gQhuUynAVx0E4xA5aZ4WruP6PEX/eQSFfN3rEmmnHKLZTdzbXCDmcbtY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm1tZWU3cjgxdGhrQm1ycnptbm1KKzBrR1RORUlPN0ZJVXU0QVhBbUdVMjVN?=
 =?utf-8?B?L2lUdHc0V0xoUWhMRnduTE5HaU5HS3VnYjIvNXhVVHdHdnBkN0NqejI0cXl1?=
 =?utf-8?B?ODFxTXNNWUdOSzd1K3RvUGJHZmwzRVQ0bEE0V0tzT2pmek16dUl5S1BEdUR2?=
 =?utf-8?B?T29GSWxVZmt2U2R3YUZWeDRWWHhQTnAybklJdEI0N0VCOGVqK1crQ2V2d25B?=
 =?utf-8?B?ZVp3bEhFMEg4L25HNW9jS0x1bk9ROXhWZ2pLSlIxZkNyK3JxTytWUkxsUEI0?=
 =?utf-8?B?dEdSUVdVWnp1djdpR0oxSDdKSWxyaHoxZ2o0ek45NE0vUFRrY200MUwzTmZN?=
 =?utf-8?B?NitKUUl5UTlqeGdaM2FabHZHVXhLK1phRmZNd0hJVUFyNk4rVXVWSlNZdVJU?=
 =?utf-8?B?Qm9LSHlhTTZ5YkNRS3JNaWoyb2hqZXFmanlSZU1NWDJrVWxkY0ZwS25neUIy?=
 =?utf-8?B?bm5PWTdBbkJEK0o2Wm0wTDBRUVJZVFQ5MHJvU3lPcXFaV0hVeGc0NHJCQW5G?=
 =?utf-8?B?NVFObTgrWTZrMTZUOHNZaXVQZVNNeXlyNHlzZVY4dGZ2ck84RFN2Qkg4UzVC?=
 =?utf-8?B?aTRBZFpqK3Nrc3ZXQVNMNWFkeE9GZ0QwUWtiVkpnVkF6STJOOXkvaWJpRXlo?=
 =?utf-8?B?Ukp3Z0Z3eGplS09TTHBGVmdkczN5emZYMjZBM0hrTFJCcWVnckJRUDlyME1F?=
 =?utf-8?B?RFpwcWhlUEI0ZDlUNHhiSGxHMnFpSXBDL05EV1EvQktuZi9ZbG4rVjhJbnVC?=
 =?utf-8?B?dmI0eVNhV2R1RkxTTWp4MFlQOFZOV1FDTmVZVTRSREFWZjh6Q04rbWFUZmht?=
 =?utf-8?B?UmxTTHZIcTBuakFpU0ZMcHBNTnAxT0pWQUMrcGpRUkYxK29vQWg2Z2w5SDFL?=
 =?utf-8?B?TXZuZUJBejVhTi9tN2FYdlBBUlVmRkxFWEdRMVI0TVNQQVB1cVYrcEM3RXps?=
 =?utf-8?B?SGJXME05SWtxSStUOVhZaFJ2MS9uZW1QTTl5UFU0bURXQlA1L2dJSUNVTEF2?=
 =?utf-8?B?L3Z6N0dXVnR5QjlpWWNVN09ybEZ5NDBBVGRaY1ZSUHU1QXhVLzl1Mnd5YlFh?=
 =?utf-8?B?SlVjT2ZkamNDVHFtUURSbVIrZmRBYUl3cFUzOHltMi9NN2Q5SUtQU1ZaaXNS?=
 =?utf-8?B?OVN2WHQ5Q3VzZmM0NU1GdS9NTTcrN1cvcHBVNDRGN2NaaGErT3JVYVpHMTdP?=
 =?utf-8?B?SWRLZ1VRQUpubW9TUWxzb0E0bU4zcWhjU0c1bGdEWFRxTXVHUyszTW9RRWsr?=
 =?utf-8?B?Z3VOeWw3bjZWU2VzeU0reVFBNmxsdjV5Z25xWGh0bk5PVnNqL20rOFZ1NzZi?=
 =?utf-8?B?S0RZZ2hVR1VvUkprQXp5QmM1cElsb3Fnd1BlOHlrd1F3RU5uVUNHdlJXUTIy?=
 =?utf-8?B?Njd4b0FsQnZINjlTYmhtVC84TitqL05BSDZFbGRYa0ZrMTlNdnJ0TzkraS9u?=
 =?utf-8?B?T2VEMWxTMFJublNkQ3dTQ3pJelg0Y2p2aThMYS9EZTZDb04wU3VCZ0tRb0pk?=
 =?utf-8?B?ek5NU3p2Y0hhd1RQVTNONExPdUJlQmhVT1dGMEJJMzVZRDNnYXhNYkJIT2oz?=
 =?utf-8?B?Rm9ZcWx4ZWN0YWtIUmZISEZqTlg0eVY0WFJpMks0WG0valBxZC8yWTRTS2FE?=
 =?utf-8?B?MWNvK01aV1Yya2VjWEUvWU1GYTd2c2s3ZytDaEpaS2c1L0Z5eGd2UVZKSWpp?=
 =?utf-8?B?NUw4WndBSFFGM05wcTUzWlMya0l2M2RJOFhVakR2Qzc0djJSYmdHdG5ZZEM2?=
 =?utf-8?B?akZxcmhSVktNMFhBV0pxT29OOGRtUGlKcXRsZUdpUjdVSDlMdnVnYmJ1U05p?=
 =?utf-8?B?bk9rWThuTHN1VlJoSGFUeXJTK1lUbC9COGVaQmRwdVZKNjR1ekpWZVFDTnJZ?=
 =?utf-8?B?dCtuTTh6cU1aMmtFZ0NJYmh2YlFkQnh1NjVXN2Fla2xVcUplbUNOVXlnSXhs?=
 =?utf-8?B?TW95UFl3aUZQVnNhZWFYSTZ0M0xXTStxYWJhUXUxc3FZaGpxU1dDOVVOMGl6?=
 =?utf-8?B?bVNPaW51Ylp1ek91K0oyQXFwQnN5MStFc3RkRUZzdWJoMDZER1VaN1Z4SE9i?=
 =?utf-8?B?WDJPYUJvcUlOdENnNEpkOHlOZ29jVWtIQkV0OEtCR211em9vUmZjUTZTaC8x?=
 =?utf-8?Q?kjInU+ye8hr3p0uGaheq7hGX9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e015a2b-42d8-4489-467f-08dc442a7c9d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 13:27:25.1137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijK+bBsnVFiPFIUovS/ZBEQ5Sq6qdFUgL3aVajiZKbzARX7kvsMVUp9JZN1zvHK2zJPwTjVj5BZz/HUCiClhQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9861

From: Oleksii Moisieiev <oleksii_moisieiev@epam.com>

Add basic implementation of the SCMI v3.2 pincontrol protocol.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Co-developed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/Makefile    |   1 +
 drivers/firmware/arm_scmi/driver.c    |   2 +
 drivers/firmware/arm_scmi/pinctrl.c   | 908 ++++++++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h |   1 +
 include/linux/scmi_protocol.h         |  75 +++
 5 files changed, 987 insertions(+)

diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index a7bc4796519c..8e3874ff1544 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -11,6 +11,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
+scmi-protocols-y += pinctrl.o
 scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 415e6f510057..ac2d4b19727c 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3142,6 +3142,7 @@ static int __init scmi_driver_init(void)
 	scmi_voltage_register();
 	scmi_system_register();
 	scmi_powercap_register();
+	scmi_pinctrl_register();
 
 	return platform_driver_register(&scmi_driver);
 }
@@ -3159,6 +3160,7 @@ static void __exit scmi_driver_exit(void)
 	scmi_voltage_unregister();
 	scmi_system_unregister();
 	scmi_powercap_unregister();
+	scmi_pinctrl_unregister();
 
 	scmi_transports_exit();
 
diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
new file mode 100644
index 000000000000..0fcfa4269473
--- /dev/null
+++ b/drivers/firmware/arm_scmi/pinctrl.c
@@ -0,0 +1,908 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) Pinctrl Protocol
+ *
+ * Copyright (C) 2024 EPAM
+ * Copyright 2024 NXP
+ */
+
+#include <linux/module.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+
+#include "common.h"
+#include "protocols.h"
+
+/* Updated only after ALL the mandatory features for that version are merged */
+#define SCMI_PROTOCOL_SUPPORTED_VERSION                0x0
+
+#define REG_TYPE_BITS GENMASK(9, 8)
+#define REG_CONFIG GENMASK(7, 0)
+
+#define GET_GROUPS_NR(x)	le32_get_bits((x), GENMASK(31, 16))
+#define GET_PINS_NR(x)		le32_get_bits((x), GENMASK(15, 0))
+#define GET_FUNCTIONS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
+
+#define EXT_NAME_FLAG(x)	le32_get_bits((x), BIT(31))
+#define NUM_ELEMS(x)		le32_get_bits((x), GENMASK(15, 0))
+
+#define REMAINING(x)		le32_get_bits((x), GENMASK(31, 16))
+#define RETURNED(x)		le32_get_bits((x), GENMASK(11, 0))
+
+enum scmi_pinctrl_protocol_cmd {
+	PINCTRL_ATTRIBUTES = 0x3,
+	PINCTRL_LIST_ASSOCIATIONS = 0x4,
+	PINCTRL_CONFIG_GET = 0x5,
+	PINCTRL_CONFIG_SET = 0x6,
+	PINCTRL_FUNCTION_SELECT = 0x7,
+	PINCTRL_REQUEST = 0x8,
+	PINCTRL_RELEASE = 0x9,
+	PINCTRL_NAME_GET = 0xa,
+	PINCTRL_SET_PERMISSIONS = 0xb
+};
+
+struct scmi_msg_conf_set {
+	__le32 identifier;
+	__le32 attributes;
+	__le32 configs[];
+};
+
+struct scmi_msg_conf_get {
+	__le32 identifier;
+	__le32 attributes;
+};
+
+struct scmi_resp_conf_get {
+	__le32 num_configs;
+	__le32 configs[];
+};
+
+struct scmi_msg_pinctrl_protocol_attributes {
+	__le32 attributes_low;
+	__le32 attributes_high;
+};
+
+struct scmi_msg_pinctrl_attributes {
+	__le32 identifier;
+	__le32 flags;
+};
+
+struct scmi_resp_pinctrl_attributes {
+	__le32 attributes;
+	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
+};
+
+struct scmi_msg_pinctrl_list_assoc {
+	__le32 identifier;
+	__le32 flags;
+	__le32 index;
+};
+
+struct scmi_resp_pinctrl_list_assoc {
+	__le32 flags;
+	__le16 array[];
+};
+
+struct scmi_msg_func_set {
+	__le32 identifier;
+	__le32 function_id;
+	__le32 flags;
+};
+
+struct scmi_msg_request {
+	__le32 identifier;
+	__le32 flags;
+};
+
+struct scmi_group_info {
+	char name[SCMI_MAX_STR_SIZE];
+	bool present;
+	unsigned int *group_pins;
+	unsigned int nr_pins;
+};
+
+struct scmi_function_info {
+	char name[SCMI_MAX_STR_SIZE];
+	bool present;
+	unsigned int *groups;
+	unsigned int nr_groups;
+};
+
+struct scmi_pin_info {
+	char name[SCMI_MAX_STR_SIZE];
+	bool present;
+};
+
+struct scmi_pinctrl_info {
+	u32 version;
+	int nr_groups;
+	int nr_functions;
+	int nr_pins;
+	struct scmi_group_info *groups;
+	struct scmi_function_info *functions;
+	struct scmi_pin_info *pins;
+};
+
+static int scmi_pinctrl_attributes_get(const struct scmi_protocol_handle *ph,
+				       struct scmi_pinctrl_info *pi)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_pinctrl_protocol_attributes *attr;
+
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0, sizeof(*attr),
+				      &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		pi->nr_functions = GET_FUNCTIONS_NR(attr->attributes_high);
+		pi->nr_groups = GET_GROUPS_NR(attr->attributes_low);
+		pi->nr_pins = GET_PINS_NR(attr->attributes_low);
+	}
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int scmi_pinctrl_count_get(const struct scmi_protocol_handle *ph,
+				  enum scmi_pinctrl_selector_type type)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	switch (type) {
+	case PIN_TYPE:
+		return pi->nr_pins;
+	case GROUP_TYPE:
+		return pi->nr_groups;
+	case FUNCTION_TYPE:
+		return pi->nr_functions;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int scmi_pinctrl_validate_id(const struct scmi_protocol_handle *ph,
+				    u32 identifier,
+				    enum scmi_pinctrl_selector_type type)
+{
+	int value;
+
+	value = scmi_pinctrl_count_get(ph, type);
+	if (value < 0)
+		return value;
+
+	if (identifier >= value)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph,
+				   enum scmi_pinctrl_selector_type type,
+				   u32 selector, char *name,
+				   unsigned int *n_elems)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_pinctrl_attributes *tx;
+	struct scmi_resp_pinctrl_attributes *rx;
+
+	if (!name)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, PINCTRL_ATTRIBUTES, sizeof(*tx),
+				      sizeof(*rx), &t);
+	if (ret)
+		return ret;
+
+	tx = t->tx.buf;
+	rx = t->rx.buf;
+	tx->identifier = cpu_to_le32(selector);
+	tx->flags = cpu_to_le32(type);
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		if (n_elems)
+			*n_elems = NUM_ELEMS(rx->attributes);
+
+		strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	/*
+	 * If supported overwrite short name with the extended one;
+	 * on error just carry on and use already provided short name.
+	 */
+	if (!ret && EXT_NAME_FLAG(rx->attributes))
+		ph->hops->extended_name_get(ph, PINCTRL_NAME_GET, selector,
+					    (u32 *)&type, name,
+					    SCMI_MAX_STR_SIZE);
+	return ret;
+}
+
+struct scmi_pinctrl_ipriv {
+	u32 selector;
+	enum scmi_pinctrl_selector_type type;
+	unsigned int *array;
+};
+
+static void iter_pinctrl_assoc_prepare_message(void *message,
+					       unsigned int desc_index,
+					       const void *priv)
+{
+	struct scmi_msg_pinctrl_list_assoc *msg = message;
+	const struct scmi_pinctrl_ipriv *p = priv;
+
+	msg->identifier = cpu_to_le32(p->selector);
+	msg->flags = cpu_to_le32(p->type);
+	/* Set the number of OPPs to be skipped/already read */
+	msg->index = cpu_to_le32(desc_index);
+}
+
+static int iter_pinctrl_assoc_update_state(struct scmi_iterator_state *st,
+					   const void *response, void *priv)
+{
+	const struct scmi_resp_pinctrl_list_assoc *r = response;
+
+	st->num_returned = RETURNED(r->flags);
+	st->num_remaining = REMAINING(r->flags);
+
+	return 0;
+}
+
+static int
+iter_pinctrl_assoc_process_response(const struct scmi_protocol_handle *ph,
+				    const void *response,
+				    struct scmi_iterator_state *st, void *priv)
+{
+	const struct scmi_resp_pinctrl_list_assoc *r = response;
+	struct scmi_pinctrl_ipriv *p = priv;
+
+	p->array[st->desc_index + st->loop_idx] =
+		le16_to_cpu(r->array[st->loop_idx]);
+
+	return 0;
+}
+
+static int scmi_pinctrl_list_associations(const struct scmi_protocol_handle *ph,
+					  u32 selector,
+					  enum scmi_pinctrl_selector_type type,
+					  u16 size, unsigned int *array)
+{
+	int ret;
+	void *iter;
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_pinctrl_assoc_prepare_message,
+		.update_state = iter_pinctrl_assoc_update_state,
+		.process_response = iter_pinctrl_assoc_process_response,
+	};
+	struct scmi_pinctrl_ipriv ipriv = {
+		.selector = selector,
+		.type = type,
+		.array = array,
+	};
+
+	if (!array || !size || type == PIN_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	iter = ph->hops->iter_response_init(ph, &ops, size,
+					    PINCTRL_LIST_ASSOCIATIONS,
+					    sizeof(struct scmi_msg_pinctrl_list_assoc),
+					    &ipriv);
+
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
+
+struct scmi_conf_get_ipriv {
+	u32 selector;
+	enum scmi_pinctrl_selector_type type;
+	u8 all;
+	enum scmi_pinctrl_conf_type *config_types;
+	u32 *config_values;
+};
+
+static void iter_pinctrl_conf_get_prepare_message(void *message,
+						  unsigned int desc_index,
+						  const void *priv)
+{
+	struct scmi_msg_conf_get *msg = message;
+	const struct scmi_conf_get_ipriv *p = priv;
+	u32 attributes;
+
+	attributes = FIELD_PREP(BIT(18), p->all) |
+		     FIELD_PREP(GENMASK(17, 16), p->type);
+
+	if (p->all)
+		attributes |= FIELD_PREP(GENMASK(15, 8), desc_index);
+	else
+		attributes |= FIELD_PREP(GENMASK(7, 0), p->config_types[0]);
+
+	msg->attributes = cpu_to_le32(attributes);
+	msg->identifier = cpu_to_le32(p->selector);
+}
+
+static int iter_pinctrl_conf_get_update_state(struct scmi_iterator_state *st,
+					      const void *response, void *priv)
+{
+	const struct scmi_resp_conf_get *r = response;
+	struct scmi_conf_get_ipriv *p = priv;
+
+	if (!p->all) {
+		st->num_returned = 1;
+		st->num_remaining = 0;
+	} else {
+		st->num_returned = le32_get_bits(r->num_configs, GENMASK(7, 0));
+		st->num_remaining = le32_get_bits(r->num_configs,
+						  GENMASK(31, 24));
+	}
+
+	return 0;
+}
+
+static int
+iter_pinctrl_conf_get_process_response(const struct scmi_protocol_handle *ph,
+				       const void *response,
+				       struct scmi_iterator_state *st,
+				       void *priv)
+{
+	const struct scmi_resp_conf_get *r = response;
+	struct scmi_conf_get_ipriv *p = priv;
+
+	if (!p->all) {
+		if (p->config_types[0] !=
+		    le32_get_bits(r->configs[st->loop_idx * 2], GENMASK(7, 0)))
+			return -EINVAL;
+	} else {
+		p->config_types[st->desc_index + st->loop_idx] =
+			le32_get_bits(r->configs[st->loop_idx * 2],
+				      GENMASK(7, 0));
+	}
+
+	p->config_values[st->desc_index + st->loop_idx] =
+		le32_to_cpu(r->configs[st->loop_idx * 2 + 1]);
+
+	return 0;
+}
+
+static int
+scmi_pinctrl_config_get(const struct scmi_protocol_handle *ph, u32 selector,
+			enum scmi_pinctrl_selector_type type,
+			enum scmi_pinctrl_conf_type config_type,
+			u32 *config_value)
+{
+	int ret;
+	void *iter;
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_pinctrl_conf_get_prepare_message,
+		.update_state = iter_pinctrl_conf_get_update_state,
+		.process_response = iter_pinctrl_conf_get_process_response,
+	};
+	struct scmi_conf_get_ipriv ipriv = {
+		.selector = selector,
+		.type = type,
+		.all = 0,
+		.config_types = &config_type,
+		.config_values = config_value,
+	};
+
+	if (!config_value || type == FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	iter = ph->hops->iter_response_init(ph, &ops, 1, PINCTRL_CONFIG_GET,
+					    sizeof(struct scmi_msg_conf_get),
+					    &ipriv);
+
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
+
+static int
+scmi_pinctrl_config_set(const struct scmi_protocol_handle *ph, u32 selector,
+			enum scmi_pinctrl_selector_type type,
+			unsigned int nr_configs,
+			enum scmi_pinctrl_conf_type *config_type,
+			u32 *config_value)
+{
+	struct scmi_xfer *t;
+	struct scmi_msg_conf_set *tx;
+	u32 attributes;
+	int ret, i;
+	unsigned int configs_in_chunk, conf_num = 0;
+	unsigned int chunk;
+	int max_msg_size = ph->hops->get_max_msg_size(ph);
+
+	if (!config_type || !config_value || type == FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	configs_in_chunk = (max_msg_size - sizeof(*tx)) / (sizeof(__le32) * 2);
+	while (conf_num < nr_configs) {
+		chunk = (nr_configs - conf_num > configs_in_chunk) ?
+			configs_in_chunk : nr_configs - conf_num;
+
+		ret = ph->xops->xfer_get_init(ph, PINCTRL_CONFIG_SET,
+					      sizeof(*tx) +
+					      chunk * 2 * sizeof(__le32),
+					      0, &t);
+		if (ret)
+			return ret;
+
+		tx = t->tx.buf;
+		tx->identifier = cpu_to_le32(selector);
+		attributes = FIELD_PREP(GENMASK(1, 0), type) |
+			FIELD_PREP(GENMASK(9, 2), chunk);
+		tx->attributes = cpu_to_le32(attributes);
+
+		for (i = 0; i < chunk; i++) {
+			tx->configs[i * 2] =
+				cpu_to_le32(config_type[conf_num + i]);
+			tx->configs[i * 2 + 1] =
+				cpu_to_le32(config_value[conf_num + i]);
+		}
+
+		ret = ph->xops->do_xfer(ph, t);
+
+		ph->xops->xfer_put(ph, t);
+
+		if (ret)
+			break;
+
+		conf_num += chunk;
+	}
+
+	return ret;
+}
+
+static int scmi_pinctrl_function_select(const struct scmi_protocol_handle *ph,
+					u32 identifier,
+					enum scmi_pinctrl_selector_type type,
+					u32 function_id)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_func_set *tx;
+
+	if (type == FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, identifier, type);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, PINCTRL_FUNCTION_SELECT, sizeof(*tx),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	tx = t->tx.buf;
+	tx->identifier = cpu_to_le32(identifier);
+	tx->function_id = cpu_to_le32(function_id);
+	tx->flags = cpu_to_le32(type);
+
+	ret = ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_request(const struct scmi_protocol_handle *ph,
+				u32 identifier,
+				enum scmi_pinctrl_selector_type type)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_request *tx;
+
+	if (type == FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, identifier, type);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, PINCTRL_REQUEST, sizeof(*tx), 0, &t);
+
+	tx = t->tx.buf;
+	tx->identifier = cpu_to_le32(identifier);
+	tx->flags = cpu_to_le32(type);
+
+	ret = ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_pin_request(const struct scmi_protocol_handle *ph,
+				    u32 pin)
+{
+	return scmi_pinctrl_request(ph, pin, PIN_TYPE);
+}
+
+static int scmi_pinctrl_free(const struct scmi_protocol_handle *ph,
+			     u32 identifier,
+			     enum scmi_pinctrl_selector_type type)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_request *tx;
+
+	if (type == FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, identifier, type);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, PINCTRL_RELEASE, sizeof(*tx), 0, &t);
+
+	tx = t->tx.buf;
+	tx->identifier = cpu_to_le32(identifier);
+	tx->flags = cpu_to_le32(type);
+
+	ret = ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_pin_free(const struct scmi_protocol_handle *ph, u32 pin)
+{
+	return scmi_pinctrl_free(ph, pin, PIN_TYPE);
+}
+
+static int scmi_pinctrl_get_group_info(const struct scmi_protocol_handle *ph,
+				       u32 selector,
+				       struct scmi_group_info *group)
+{
+	int ret;
+
+	if (!group)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_attributes(ph, GROUP_TYPE, selector,
+				      group->name,
+				      &group->nr_pins);
+	if (ret)
+		return ret;
+
+	if (!group->nr_pins) {
+		dev_err(ph->dev, "Group %d has 0 elements", selector);
+		return -ENODATA;
+	}
+
+	group->group_pins = kmalloc_array(group->nr_pins,
+					  sizeof(*group->group_pins),
+					  GFP_KERNEL);
+	if (!group->group_pins)
+		return -ENOMEM;
+
+	ret = scmi_pinctrl_list_associations(ph, selector, GROUP_TYPE,
+					     group->nr_pins, group->group_pins);
+	if (ret) {
+		kfree(group->group_pins);
+		return ret;
+	}
+
+	group->present = true;
+	return 0;
+}
+
+static int scmi_pinctrl_get_group_name(const struct scmi_protocol_handle *ph,
+				       u32 selector, const char **name)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!name)
+		return -EINVAL;
+
+	if (selector >= pi->nr_groups)
+		return -EINVAL;
+
+	if (!pi->groups[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_group_info(ph, selector,
+						  &pi->groups[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name = pi->groups[selector].name;
+
+	return 0;
+}
+
+static int scmi_pinctrl_group_pins_get(const struct scmi_protocol_handle *ph,
+				       u32 selector, const unsigned int **pins,
+				       unsigned int *nr_pins)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!pins || !nr_pins)
+		return -EINVAL;
+
+	if (selector >= pi->nr_groups)
+		return -EINVAL;
+
+	if (!pi->groups[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_group_info(ph, selector,
+						  &pi->groups[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*pins = pi->groups[selector].group_pins;
+	*nr_pins = pi->groups[selector].nr_pins;
+
+	return 0;
+}
+
+static int scmi_pinctrl_get_function_info(const struct scmi_protocol_handle *ph,
+					  u32 selector,
+					  struct scmi_function_info *func)
+{
+	int ret;
+
+	if (!func)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_attributes(ph, FUNCTION_TYPE, selector,
+				      func->name,
+				      &func->nr_groups);
+	if (ret)
+		return ret;
+
+	if (!func->nr_groups) {
+		dev_err(ph->dev, "Function %d has 0 elements", selector);
+		return -ENODATA;
+	}
+
+	func->groups = kmalloc_array(func->nr_groups, sizeof(*func->groups),
+				     GFP_KERNEL);
+	if (!func->groups)
+		return -ENOMEM;
+
+	ret = scmi_pinctrl_list_associations(ph, selector, FUNCTION_TYPE,
+					     func->nr_groups, func->groups);
+	if (ret) {
+		kfree(func->groups);
+		return ret;
+	}
+
+	func->present = true;
+	return 0;
+}
+
+static int scmi_pinctrl_get_function_name(const struct scmi_protocol_handle *ph,
+					  u32 selector, const char **name)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!name)
+		return -EINVAL;
+
+	if (selector >= pi->nr_functions)
+		return -EINVAL;
+
+	if (!pi->functions[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_function_info(ph, selector,
+						     &pi->functions[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name = pi->functions[selector].name;
+	return 0;
+}
+
+static int
+scmi_pinctrl_function_groups_get(const struct scmi_protocol_handle *ph,
+				 u32 selector, unsigned int *nr_groups,
+				 const unsigned int **groups)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!groups || !nr_groups)
+		return -EINVAL;
+
+	if (selector >= pi->nr_functions)
+		return -EINVAL;
+
+	if (!pi->functions[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_function_info(ph, selector,
+						     &pi->functions[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*groups = pi->functions[selector].groups;
+	*nr_groups = pi->functions[selector].nr_groups;
+
+	return 0;
+}
+
+static int scmi_pinctrl_mux_set(const struct scmi_protocol_handle *ph,
+				u32 selector, u32 group)
+{
+	return scmi_pinctrl_function_select(ph, group, GROUP_TYPE,
+					    selector);
+}
+
+static int scmi_pinctrl_get_pin_info(const struct scmi_protocol_handle *ph,
+				     u32 selector, struct scmi_pin_info *pin)
+{
+	int ret;
+
+	if (!pin)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_attributes(ph, PIN_TYPE, selector,
+				      pin->name, NULL);
+	if (ret)
+		return ret;
+
+	pin->present = true;
+	return 0;
+}
+
+static int scmi_pinctrl_get_pin_name(const struct scmi_protocol_handle *ph,
+				     u32 selector, const char **name)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!name)
+		return -EINVAL;
+
+	if (selector >= pi->nr_pins)
+		return -EINVAL;
+
+	if (!pi->pins[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_pin_info(ph, selector,
+						&pi->pins[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name = pi->pins[selector].name;
+
+	return 0;
+}
+
+static int scmi_pinctrl_name_get(const struct scmi_protocol_handle *ph,
+				 u32 selector,
+				 enum scmi_pinctrl_selector_type type,
+				 const char **name)
+{
+	switch (type) {
+	case PIN_TYPE:
+		return scmi_pinctrl_get_pin_name(ph, selector, name);
+	case GROUP_TYPE:
+		return scmi_pinctrl_get_group_name(ph, selector, name);
+	case FUNCTION_TYPE:
+		return scmi_pinctrl_get_function_name(ph, selector, name);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct scmi_pinctrl_proto_ops pinctrl_proto_ops = {
+	.count_get = scmi_pinctrl_count_get,
+	.name_get = scmi_pinctrl_name_get,
+	.group_pins_get = scmi_pinctrl_group_pins_get,
+	.function_groups_get = scmi_pinctrl_function_groups_get,
+	.mux_set = scmi_pinctrl_mux_set,
+	.config_get = scmi_pinctrl_config_get,
+	.config_set = scmi_pinctrl_config_set,
+	.pin_request = scmi_pinctrl_pin_request,
+	.pin_free = scmi_pinctrl_pin_free,
+};
+
+static int scmi_pinctrl_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	int ret;
+	u32 version;
+	struct scmi_pinctrl_info *pinfo;
+
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_dbg(ph->dev, "Pinctrl Version %d.%d\n",
+		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	pinfo = devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
+	if (!pinfo)
+		return -ENOMEM;
+
+	ret = scmi_pinctrl_attributes_get(ph, pinfo);
+	if (ret)
+		return ret;
+
+	pinfo->pins = devm_kcalloc(ph->dev, pinfo->nr_pins,
+				   sizeof(*pinfo->pins),
+				   GFP_KERNEL);
+	if (!pinfo->pins)
+		return -ENOMEM;
+
+	pinfo->groups = devm_kcalloc(ph->dev, pinfo->nr_groups,
+				     sizeof(*pinfo->groups),
+				     GFP_KERNEL);
+	if (!pinfo->groups)
+		return -ENOMEM;
+
+	pinfo->functions = devm_kcalloc(ph->dev, pinfo->nr_functions,
+					sizeof(*pinfo->functions),
+					GFP_KERNEL);
+	if (!pinfo->functions)
+		return -ENOMEM;
+
+	pinfo->version = version;
+
+	return ph->set_priv(ph, pinfo, version);
+}
+
+static int scmi_pinctrl_protocol_deinit(const struct scmi_protocol_handle *ph)
+{
+	int i;
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	for (i = 0; i < pi->nr_groups; i++) {
+		if (pi->groups[i].present) {
+			kfree(pi->groups[i].group_pins);
+			pi->groups[i].present = false;
+		}
+	}
+
+	for (i = 0; i < pi->nr_functions; i++) {
+		if (pi->functions[i].present) {
+			kfree(pi->functions[i].groups);
+			pi->functions[i].present = false;
+		}
+	}
+
+	return 0;
+}
+
+static const struct scmi_protocol scmi_pinctrl = {
+	.id = SCMI_PROTOCOL_PINCTRL,
+	.owner = THIS_MODULE,
+	.instance_init = &scmi_pinctrl_protocol_init,
+	.instance_deinit = &scmi_pinctrl_protocol_deinit,
+	.ops = &pinctrl_proto_ops,
+	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(pinctrl, scmi_pinctrl)
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 3e91536a77a3..c02cbfd2bb03 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -355,6 +355,7 @@ void __exit scmi_##name##_unregister(void)			\
 DECLARE_SCMI_REGISTER_UNREGISTER(base);
 DECLARE_SCMI_REGISTER_UNREGISTER(clock);
 DECLARE_SCMI_REGISTER_UNREGISTER(perf);
+DECLARE_SCMI_REGISTER_UNREGISTER(pinctrl);
 DECLARE_SCMI_REGISTER_UNREGISTER(power);
 DECLARE_SCMI_REGISTER_UNREGISTER(reset);
 DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index b807141acc14..fd647f805e5f 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -737,6 +737,80 @@ struct scmi_powercap_proto_ops {
 					  u32 *power_thresh_high);
 };
 
+enum scmi_pinctrl_selector_type {
+	PIN_TYPE = 0,
+	GROUP_TYPE,
+	FUNCTION_TYPE,
+};
+
+enum scmi_pinctrl_conf_type {
+	SCMI_PIN_NONE = 0x0,
+	SCMI_PIN_BIAS_BUS_HOLD = 0x1,
+	SCMI_PIN_BIAS_DISABLE = 0x2,
+	SCMI_PIN_BIAS_HIGH_IMPEDANCE = 0x3,
+	SCMI_PIN_BIAS_PULL_UP = 0x4,
+	SCMI_PIN_BIAS_PULL_DEFAULT = 0x5,
+	SCMI_PIN_BIAS_PULL_DOWN = 0x6,
+	SCMI_PIN_DRIVE_OPEN_DRAIN = 0x7,
+	SCMI_PIN_DRIVE_OPEN_SOURCE = 0x8,
+	SCMI_PIN_DRIVE_PUSH_PULL = 0x9,
+	SCMI_PIN_DRIVE_STRENGTH = 0xA,
+	SCMI_PIN_INPUT_DEBOUNCE = 0xB,
+	SCMI_PIN_INPUT_MODE = 0xC,
+	SCMI_PIN_PULL_MODE = 0xD,
+	SCMI_PIN_INPUT_VALUE = 0xE,
+	SCMI_PIN_INPUT_SCHMITT = 0xF,
+	SCMI_PIN_LOW_POWER_MODE = 0x10,
+	SCMI_PIN_OUTPUT_MODE = 0x11,
+	SCMI_PIN_OUTPUT_VALUE = 0x12,
+	SCMI_PIN_POWER_SOURCE = 0x13,
+	SCMI_PIN_SLEW_RATE = 0x20,
+	SCMI_PIN_OEM_START = 0xC0,
+	SCMI_PIN_OEM_END = 0xFF,
+};
+
+/**
+ * struct scmi_pinctrl_proto_ops - represents the various operations provided
+ * by SCMI Pinctrl Protocol
+ *
+ * @count_get: returns count of the registered elements in given type
+ * @name_get: returns name by index of given type
+ * @group_pins_get: returns the set of pins, assigned to the specified group
+ * @function_groups_get: returns the set of groups, assigned to the specified
+ *	function
+ * @mux_set: set muxing function for groups of pins
+ * @config_get: returns configuration parameter for pin or group
+ * @config_set: sets the configuration parameter for pin or group
+ * @pin_request: aquire pin before selecting mux setting
+ * @pin_free: frees pin, acquired by request_pin call
+ */
+struct scmi_pinctrl_proto_ops {
+	int (*count_get)(const struct scmi_protocol_handle *ph,
+			 enum scmi_pinctrl_selector_type type);
+	int (*name_get)(const struct scmi_protocol_handle *ph, u32 selector,
+			enum scmi_pinctrl_selector_type type,
+			const char **name);
+	int (*group_pins_get)(const struct scmi_protocol_handle *ph,
+			      u32 selector, const unsigned int **pins,
+			      unsigned int *nr_pins);
+	int (*function_groups_get)(const struct scmi_protocol_handle *ph,
+				   u32 selector, unsigned int *nr_groups,
+				   const unsigned int **groups);
+	int (*mux_set)(const struct scmi_protocol_handle *ph, u32 selector,
+		       u32 group);
+	int (*config_get)(const struct scmi_protocol_handle *ph, u32 selector,
+			  enum scmi_pinctrl_selector_type type,
+			  enum scmi_pinctrl_conf_type config_type,
+			  u32 *config_value);
+	int (*config_set)(const struct scmi_protocol_handle *ph, u32 selector,
+			  enum scmi_pinctrl_selector_type type,
+			  unsigned int nr_configs,
+			  enum scmi_pinctrl_conf_type *config_type,
+			  u32 *config_value);
+	int (*pin_request)(const struct scmi_protocol_handle *ph, u32 pin);
+	int (*pin_free)(const struct scmi_protocol_handle *ph, u32 pin);
+};
+
 /**
  * struct scmi_notify_ops  - represents notifications' operations provided by
  * SCMI core
@@ -844,6 +918,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_RESET = 0x16,
 	SCMI_PROTOCOL_VOLTAGE = 0x17,
 	SCMI_PROTOCOL_POWERCAP = 0x18,
+	SCMI_PROTOCOL_PINCTRL = 0x19,
 };
 
 enum scmi_system_events {

-- 
2.37.1


