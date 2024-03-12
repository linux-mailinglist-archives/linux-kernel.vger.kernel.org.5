Return-Path: <linux-kernel+bounces-100008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC638790A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C912865AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3337CF0A;
	Tue, 12 Mar 2024 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ufzll4oc"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9F87C09D;
	Tue, 12 Mar 2024 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235070; cv=fail; b=ZGyCHQpHAzLZICK59aRIxZPaevie2D+1G3xb5T9HvXuIa7+PLGNv93Dzta43andTIrjyFeITfZstlRQ5Gvi4pZLKXtjhJFtob/dSO61XbwN/92DCoq5p47FjVKImeCZmRmClUeED8aKNbxfuShFiZzawn39aafxmH5w3dAnYGeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235070; c=relaxed/simple;
	bh=orHd5r4+ahRLMmtcIl0rWJg6cTW2Y7FhVLCdUFY7aLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BglOs3b9gq+bP2oS6c1qeQah9SF7UxRHZk+t2lrFNDiKRgOfiTJ8gH0udN+obq89+OGAOZtcbTBuAf03JWgB6EKqCP0wIURrphugye1/rAlic0olB1FNL3POs/V6D+gl4L5K7nftXNXN5hE+eed5ISXB71f4kGj+6Pz0CPHc0RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ufzll4oc; arc=fail smtp.client-ip=40.107.7.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdF+3byj7gCebrltOyq67brj83mOJISsPWOzzWgwscewq6JBs8LHUVqOZaCy7LkS9AtPOMldYqdT9Dz6NsD8cjxopSe4KLW+a1baLnwVwTwh1goKeu8sfJpnfDjVAbQcWHW3AuiGUMSTa1EJ191mLe1zsv6uvp9j8oc2L07eHhQH/H2RH/oCVB9JuMl3fJ4qfJeKMpXR7LgxfNjdhmf+/zW1qAekA0Rf5wQpXefRDRwIxOdZTepOMNr68tY38mz1kprUfWom18fmdQnAYPyXU3lULTAeBvb8hmMrs4YUVkGFbB7HhrPenqyEYN7G6C+n0ZX5NcUd4cnaBRfOsJufZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKv5jcpy5KV/AXQzkVREqyAhfz5Um2sBWFV9Pr0tDoY=;
 b=FdMjm4Gf+2xhrjxAnUkGmWeXK40ZLztf5EQiLUaoxC7hazcgCb9mDR97IlQYk3i3ZbWN6wMDd1fc2ngI54Mnt0hqvsrT3l4FeyJs8mJeG0UrntzC25JqPGvTHn8oiDfoB1pcPmgs15CdV/x8IUN7129yPh3PfmXQolWi3BQqvzwTw+1+tFftdagHxIClRIFNb4kAS1gaZAU3Ga0Z5/6rL55HlTqWb0E5c6cNeyRqYUjT5V47eDyS6S36Oj8KeppOI6U3EIuYH6PwLNl0CtQ7Q4Xw+F2EV0n+ZIZ2og794V/kWpiYGsn6HMOqtWiJdmxdpItoajf9D2fi6Hw7UfnaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKv5jcpy5KV/AXQzkVREqyAhfz5Um2sBWFV9Pr0tDoY=;
 b=Ufzll4ocXwtQW7AkZQnh+GWqpsFh2NwQ/W7FP72yhCYaPhCtAJwrfa+L7Rolv1h35RxKJkAlV7CeSg0eogVFzTVG0BRiAUK1GI6XSPgF6wpCISm21maYcmrpCAmq29UcuoiOWW8I6S/1LXpNXg2Lv/SScEeyBc+ByFXIeODrvBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 09:17:42 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 09:17:42 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org,
	conor+dt@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	peter.chen@kernel.org,
	xu.yang_2@nxp.com,
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/10] usb: chipidea: ci_hdrc_imx: align usb wakeup clock name with dt-bindings
Date: Tue, 12 Mar 2024 17:17:03 +0800
Message-Id: <20240312091703.1220649-10-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312091703.1220649-1-xu.yang_2@nxp.com>
References: <20240312091703.1220649-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d95c999-a7fc-47e4-2065-08dc42754561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A+gwXk0Hq69Ignejr6L61AIObWUVCO6LMv61NqgzBXRnWGk9JrhW9plWVEgVOCgrbv4FA9c94aIdMi3KefrIQX0Q+/3a8SzdwJQQzSFtKflVwjzkzOKyn2uazX0Ow5o+Aid9Zep/OPoAGNf755OHQ8qfII4w7OqnB/hOS6XjgUkFcCgNYf5Q+NcyZzxtf46W9/ULEIcVYwhwbEA4UubBDlQoFmxNwacTMB+cLlumqBn4aP2I3nxyBvKkYeV/8FdlMJ7Xh3F35BzavrGdlaH8JC+M6xiZxM80syZg+cQHQJSq0i/2pWoPeuGLwANKMvgbT/653WZNw6EqLSJUXEw2+5jdNXmhXXqBiq/rE1OK7fuRthk5m6ReruuIHkfB26HIzO0YQR6hJM9voIzG6FbdZdcD4c9s7AVmiU7fegHuKayf3PHM4a2RsMYIHwW5aLMokQCymswIE/rFiWL2bPpdkN+eqjoNd6sVvoRd8ftZ9dyUnBQAXaof/pJD7faLHesv0rcfdoF5VCVD18kLxpgY+ze1FIQbh1xpTNG4elmRA2NkbJRJzwxx09pe/5q8diLUxAPXjWSmuO4JI0Ltp7DqetItcPoArW6OkOQMznGWxcTPctS9uRo+/QoFHzlk/G/SnoWJddiccrZXBkirbJvl2VjrTFB8lk4fBbpcE1AtiCp5Ho2kAb5FEOVnqDy49UdFvABtnfO07hS/cGy9wtUu6rl2bcYZZn/ehWAyChZXDkQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+1AkbKlBFKixPP8NNAipQdGRGyIkf5EdXKz1BPrEi5T760EphJdFKzDt6CVV?=
 =?us-ascii?Q?DbZo2jQqUTCcsNuIHXEc6I2/KKTESi4khidre5FgKCXxA/YeruN1wPsuIkRD?=
 =?us-ascii?Q?z0b3qdAfPFKEUNk3LdywLONPMXcMydn1nlN0AcRLp8S3AMxHXI1IkAJ7pz07?=
 =?us-ascii?Q?2RtoN8s1QU4AnlXgHkmPanveJVOOiK3t/MePL/+V2knYdlAURBEBnMnqncE7?=
 =?us-ascii?Q?3xqwaIk3MhO5sLDJSzIsa7Zqdq8pzj4AhqVLet9hxreDJEhQHHqvg08ygamq?=
 =?us-ascii?Q?0UyOtjRaAGUlHOmMARtlvYKq/cK89lCcJXzqYQtLenAuOf4sHUKoOAS4Ztx7?=
 =?us-ascii?Q?vFdrwJJUleL0tQdFbAbYRXN99p+77MDA4xmBnYSJcMbfbUK4dpaefwgmmFS9?=
 =?us-ascii?Q?ZwRYcsHthpH9qfJvz2mFkXSz4YsLaWjyZ5MUZ5uBe/HGBnwkX4Omjjo0leCS?=
 =?us-ascii?Q?OVrtzsv0sCwxcA1qcxnq5/zwFUZTJXLr9NeDRIOKfYfUDt1KWFh7Ouh2gJq9?=
 =?us-ascii?Q?9C+NXZzv3YcwhUphOTHw+vH+cxvD+xw9LGYNzOiY78o5g/bCsOxcdZxCb/PA?=
 =?us-ascii?Q?hN7ZmSZgiZaVpAYyPywpe9gEQ1cN8SDUrZPcSAX0UjgtfX0ZvpqTB6/v+4to?=
 =?us-ascii?Q?nnA9kqBqnskKJhc8ejjxsjBBmb7ah6O+bG4Vin+LnaPM0pFOTl38CT8TGj8H?=
 =?us-ascii?Q?KQrMSD29DzYcXY2dLtBx8nfyitiVrnGU6Wb4yELS288E+Kn3iG8x88KgcXMi?=
 =?us-ascii?Q?MqmeBQ62mvpo7OQC/WjsJIFxp8eFFRZ7RdrVy/x5VrDz/ol7/ahHM7fJSlcV?=
 =?us-ascii?Q?6fXF6R8WxjGxSkC2FUm4ml1AsA5HLCEaDHTekOOP/Q/cjtOcQXNKrGHDVrjO?=
 =?us-ascii?Q?qE8H+QF6FeF2VvcHo+uCbTaslI+a/ZpQ5yvxpBYqVeKm8gr6INaljMUCJHG6?=
 =?us-ascii?Q?XewEiAdhWcC5c3qu7f/dlFUqoQQ+/t/I6vdpM++KRldjLDkcw3wAyZLPmyOt?=
 =?us-ascii?Q?ToFZ1zqoKo214QrzSg5ms/qT83dhi9YYEULu5ZyC3+5MD5YSWa+65SUn5cld?=
 =?us-ascii?Q?GDzGRiHwibWogsydPj4LoXcZyMq+79mAIMp7KJ7gWP1q3Q4lIBD+1HFeAYtp?=
 =?us-ascii?Q?Z6CPVuQceLeaS+2yY/NDdcjIzaZdRLGH1BtlQsGN9eRtN1/X0fMoyqKWpi8D?=
 =?us-ascii?Q?danVjucEk/s9Mi7qgblqqcOVh3hm5WAOsqXWh8o5t5GTg1SbCWOUNBO+/Vij?=
 =?us-ascii?Q?fmnwsgsPQFFDmHo5ReWQjuyQPtBfYLbLoGuyr3FpMP0+Udr1m5fCaDMbNjyY?=
 =?us-ascii?Q?mzdc2t8sFoUR0VrxviH904DKDYo7mUq9GqCVKeZnA91s1jZ+rp364Bl8/7Yg?=
 =?us-ascii?Q?f249vr4WvU4AFnoqfVKXEhlOOaDNhtK06xBgQLwuoF9Tab4kdd+e9+Vf42ML?=
 =?us-ascii?Q?A/ZURG1EJXi0oEvd2f+IKZ7hoyc6Brfp98QJ6Nn9Atw34ljnBtgb6WrwCCiO?=
 =?us-ascii?Q?vWbJ0JMI/pny6owOOvJG27mS/zDANV1OxSAvTeRXXJFTzR4GEACcnMYatcN3?=
 =?us-ascii?Q?X/bH3acJBf8fVV2FTbuS+FCE5PHEWWk/T7ooPyCL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d95c999-a7fc-47e4-2065-08dc42754561
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:17:42.5117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9ujnD5Y/NO2V9DfYm6RgQLFF6i/PWH7Py6HxxTiyGn9dgqRy23j/nbHGh5vzMjrSrsc80BgBW9KVsP8SUxKbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9676

The dt-bindings is going to use "usb_wakeup" as wakup clock name. This will
align the change with dt-bindings.

Acked-by: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v5:
 - new patch
Changes in v6:
 - add Acked-by tag
Changes in v7:
 - no changes
Changes in v8:
 - no changes
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index ae9a6a17ec6e..a17b6d619305 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -212,7 +212,7 @@ static int imx_get_clks(struct device *dev)
 		/* Get wakeup clock. Not all of the platforms need to
 		 * handle this clock. So make it optional.
 		 */
-		data->clk_wakeup = devm_clk_get_optional(dev, "usb_wakeup_clk");
+		data->clk_wakeup = devm_clk_get_optional(dev, "usb_wakeup");
 		if (IS_ERR(data->clk_wakeup))
 			ret = dev_err_probe(dev, PTR_ERR(data->clk_wakeup),
 					"Failed to get wakeup clk\n");
-- 
2.34.1


