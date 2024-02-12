Return-Path: <linux-kernel+bounces-61949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAC38518DB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64AD02828AD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01423D569;
	Mon, 12 Feb 2024 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qMxMH0Fk"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109BD3D552;
	Mon, 12 Feb 2024 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754775; cv=fail; b=QpNgpfbACbilAEZdojVovty9JsGeT+Flqy8Q8rOaYPfHKxBJ1tg9MkF0v8y3K6+QytGZz4kRYBZfBGB4g3A/RJ2ThMrztKAFwMOxBXu/kY5YlyH1va8JlmuXOMEBW4Vqtdm7FdcNgC/1y/rKVP94geyADsevjKEvnixVSao4oxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754775; c=relaxed/simple;
	bh=RVZanAIO2cvNYwqNO1H2+H1kfQCW0KHxJ3QV94uN8yE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TnH23vePvQaSH4//BwpJFB43RcrDOKROo5vSMfXtnwGZp+lQUdl9U2bCP+em2OhTRI7Ue8jSqnpT8uk18i2NAIbp39EaWyqLOW4pgMq6X3dsxfrD1Xe5GFCASWxtr4hzTp549IjNzIUUTxZ1t2lsqfSAo9ePJzEq91xNRmEfTaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qMxMH0Fk; arc=fail smtp.client-ip=40.107.6.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgAGTf6jHPeivSZd6gk/oXqAJ9m5O5NO/uH/3G4NE29/oudl8I5p1MNjetvvuSOGrmzZoje5tUa5ErEluqsJ3tUouaTKdcrIZhInLu7cfzU1nYrXW1iToJ5QBG1GYZSDRyeNulPXerJltdaK+gnApwwpjulU4wYztBx5zpeG4h7bnW1PyoWP9u/oaheezXh3C2K63w0RxZeARYiO26bK7vcV65SFhThQjyEdFF2rj0KmwQYf89d2swfQwnyn6PQssFdiEJklpi1Al7l3ItTEyZ+OnnbovalFal7YMW1dkghnZ5kbor43kg0jX/YUJKLry0nLQYzOB/m+eNzEs68ssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjv7QnKdUodCbDCtWeMa8BZzh8+qG0XKvEheQHpbLE8=;
 b=mAlVImCzFYSzuM4GDwwWMXlC5EOjiEUOpsS3Ov2vicj6K4sY5K6NGjWiizJwe8jq8NpF7muoTBIg7oDqKLjXhirMFmN7DioA4xyvuSun+AMc01+oVvqUrY4E/cEiMx/hRUHb1wLK5e88su1FdNYMGaad6b5UWey4wT+5he4wooW2NIaPyJvYTXNm4AhGiqxexVhQum9kZMNqXMrH/PcFkMMjkISFY6JnXIZHaHiHYLQcj72L42CazCGc24U5xdHH9eUh+SD8YD6L4Ls8tHzVL3/RJANgobvlcqnepp6cO/tesSpDp8PQ5kiVv3+Z0JnO7fhG3yHteAoVEDbqPU9Uqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjv7QnKdUodCbDCtWeMa8BZzh8+qG0XKvEheQHpbLE8=;
 b=qMxMH0Fk4t8T4euYIkQpIKS3HL0eStO30VZG5PfeCJqbYCpSHQe9vhxtEDh14aX0ogpy1T++c8NS0fQfwpDpdc0cbQau4f7IyDeEp/c2vcDfVn4IHWn4Z7Sdc5oDcv91ncvICQLyqAP5awNmYJhgFyijcyjY2ElSLjJINx/UHS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9049.eurprd04.prod.outlook.com (2603:10a6:10:2e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 16:19:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7270.025; Mon, 12 Feb 2024
 16:19:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 12 Feb 2024 11:19:08 -0500
Subject: [PATCH v2 2/2] usb: dwc3: apply snps,host-vbus-glitches workaround
 unconditionally
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-vbus-glitch-v2-2-d71b73a82de1@nxp.com>
References: <20240212-vbus-glitch-v2-0-d71b73a82de1@nxp.com>
In-Reply-To: <20240212-vbus-glitch-v2-0-d71b73a82de1@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707754764; l=2477;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=RVZanAIO2cvNYwqNO1H2+H1kfQCW0KHxJ3QV94uN8yE=;
 b=UDHEWzz3fU1LvjbSPirbztQdGXqjfNd3iHqO6GmfrBVppRfsEjnhT2hc3jYX53NlAmYGMNW9h
 +vnx1nUSV2lDyg9HTpsxJEoY3UkY+wjsL1LB48xPmGU9DqGtW7lA6q6
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN4PR0501CA0001.namprd05.prod.outlook.com
 (2603:10b6:803:40::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c26fc0-abe9-4f8c-b337-08dc2be66444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9MvcPLGXj1UyHo5GTB/5dhHzpG2cjs4vUQh3/K9X3DTMlQgsoEeGbuP0iW5XmJcbihgGTXCHe1ItVLS/rcsGt6L+d84VeOxrf5AORURMzqXoPYkrBSgkfufbUL3HPE9/qjKeh1pSSGkBqonmk59gZSQMDodY+Mtpc8Z11+LYf37pL1bVuY9tMvTP7X8sEi5MI9Ll3UysBYQs0xAgItkmxE+CwxyfDAXGJg3MDcu079h/Mji9S4GrZsYHE+6cXcXHn9GowPw68Al6Z50rKwf3wV8phHgc54Ijh2fkPz1jYFZGC93ZwUJ6WZaLx4n3Iari5ev8GfekAqY5D3coOAXIu2oUvI+hEzOYx7oM0/BcwuGl7MOLgpeCMhPX+CbiLFUgYXokat3cwVboyaMVlw+BWRXoVadFtTrFJOTfRazQPbzE5cs56d2xgq5HWGgLi2e5aQD5a8F0wgRp5L+oPtZSlscaD5qySlShMffoWPqbcViiNrqB4GtiFB0YRULE5pXOYp21y8MmKNoCOBQRZMLNBxM0v8t/7KctvBAWm8EWwgXR1KtPK3LcEARAcTVSncQHk+YCZAkIQ0UNLRADeGzuckUB7BhXCIz9LS2ABLIj5qzV7sK19/gg7l3Q/7wM1hu5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6512007)(478600001)(6486002)(41300700001)(8676002)(8936002)(4326008)(7416002)(5660300002)(2906002)(110136005)(38350700005)(66476007)(6506007)(6666004)(316002)(52116002)(66946007)(66556008)(83380400001)(2616005)(86362001)(26005)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXJFTWFaYmFOZTVqMSsvRm9WN040aXZzcmdxSEpManJkZjlTWFlvOEo0VEJW?=
 =?utf-8?B?a3RiUnVEYlhoZjhWbFRpZXRIOVUrdjJtNG9uWEN2SU9nZE0zVzl3eTJKSW0v?=
 =?utf-8?B?ZWdqUm1Wb2w0V2NjL1hTODJCbEJ5RW13M09ZalRvbTFxT2tzTFdKYnVQM0pW?=
 =?utf-8?B?cEZMaVd0bnFhY0JTUy8yOFd0ZXlRT3RaTStRN1JGQlhGY3NiWGlydGRuQU5x?=
 =?utf-8?B?RXIrV2U2L0QxRjUyOW9RVDNIbHFlelhOL1hmMVcwN1RQZGxUZVZCVzZSclBX?=
 =?utf-8?B?R0V2STlMZHJ2ZE5pTmE5WHZjNDBvbGxMZHI1ZkJKM2JaWmtQSG1ZY2RIdk9u?=
 =?utf-8?B?UUk4K2h5T2RPYWRkem8ydmJKR2pKc1FFK2VlRUxBYTQxc0ZMSkpMMS9taVZ4?=
 =?utf-8?B?ZytoWHczcXJ6Snk0WkZwWHVyU1VCR3NrY05jTjFISHU0MU9IQ0ppenlmR1pV?=
 =?utf-8?B?SmVjTzQrWlhCU2Z2eEtkTzViZllRR3NvM01MVjdFVDErUEFaajdYc285N2tF?=
 =?utf-8?B?dDdKRWRVYjZ1azV4NStGNzdGY2dSbDA4TzVXQ0dwZzU2OUpmYmdnTkdDcFpV?=
 =?utf-8?B?WXpZNmxjQks4NGQ3N1UrUW5NMDlXc2dvRkJSRUxQdW9zaUd0dFNsd2Z4ak1i?=
 =?utf-8?B?dzJkTUxGczV2dlY4SUpYYUxnTEdFc0JUOUZncmh0Wk1JWDJJRWhXakhOVUJK?=
 =?utf-8?B?UDRsTlZPbW1mTytTTzUybFhJUldsVDAyRGZ5NEVkT1MyTExFbzBsR1IyYWND?=
 =?utf-8?B?QVl4WFdNWmUyZzVsb0Znbkp4QTNpWmRoUjFsdkVzdXFqY290dThDcytmcDlq?=
 =?utf-8?B?M2JnUkdrdk53dmlnVTBJdkJDSWVRcWtuQzNHT0htVFVxQkw0Uk9ZNFgvRVJ4?=
 =?utf-8?B?ak9UMFN4aWROeE00dTcvNncycWVYUVp1TFZQZTgwS3JIaW5BYWh6R2hnWGg1?=
 =?utf-8?B?bklBUnVOdnpYclFHVkF0dy8zUzBTMVJGQWtnNmQvdER0Ly9CT2xtTDdvdGgv?=
 =?utf-8?B?V1YvSlYweTZ2TVFTNUFFTzlBTC80RHRUcHIrYUFqUjA5S3pUa21nZWJuNzU0?=
 =?utf-8?B?bVM5YnB3dDFsc2NtWGhINXF2NlArcXB6OGxPa3JzVVliQUl5RWtoTFNIeVJ2?=
 =?utf-8?B?VHZpTWVWYjhFWXVNSW5yVG9HdW5BckhnbmIyczlpWU12UGZxV3dXSm9hZEhL?=
 =?utf-8?B?cVlWbWtpQUZQaVlSQ0I5TE5EZXJHQVpJR3NkUzRqWm8zSW9FdmxpLzJpdE1j?=
 =?utf-8?B?QWNUZGFsSzgrL3VDZGx6aldtbHBIUS9rSkhHOEh0cVdmaGRyQjhkbS9qQWNj?=
 =?utf-8?B?VUwwaVdYOGNBaUpHcFpGYlJ2R2V2M1FzZ1FmVGVQZFVjOGVjT1k4Q3pORkxT?=
 =?utf-8?B?U2FwTnJyQURQUElMQVMwS1UzcEpSWDZCd1owc2ZGYUVGSGV4NENZcmdSRGZM?=
 =?utf-8?B?OEM2blBZNjF1S2NVSDRGeUZ0ekwxSHhCMW5CdTB3VWsxYTZrUlUyTEl6YXlW?=
 =?utf-8?B?TTh6cnM4M1F4aUM2bi85citUSDd2R0tGcktreGpTNlpjR2V5dlNhMmRqMWhH?=
 =?utf-8?B?NzZmV3FLazhCSUYxQXY1SU9mRUNHUnNHMTRGOHZwRGc0WDdWWDhNeGNRa0V1?=
 =?utf-8?B?aVRsNzNOd1ZWTm0xY3VOTUh6cXo4dGJRUjlWV2hWbW9CYVBaVkdVeitwUlN5?=
 =?utf-8?B?VUh5Y2ZmV2FKekhGQkZwS3Fxdm8yRXRPRjJBeDJhaDl4b1BON29BeklrL3Jp?=
 =?utf-8?B?Sjc2ZjJadjdWV2NKVXIrSUV6WC92YlkrOFlEZVlQZ0tmUHFYUFptUDZxR2l2?=
 =?utf-8?B?WXJ0bGFSSGtOOEE1Y3V6YkpGanM2TFhHOWROTnhyUFN6ZkhIaHdZbWJ5eWh5?=
 =?utf-8?B?YjFTTjhobElBNG45cisxT1hzUnFzYm96QWc2UXZMZEFWWlJiaDU3My9CWGY3?=
 =?utf-8?B?OU1jMzIvL010NFRNbCtnemNvemxKMnVvTXJoMXhSVkFDbGF6NnNuRDU0dTR2?=
 =?utf-8?B?NGQ4TGtQK2dnNUpHa01uTTkvMjlqVld1c0pPWDEwOTlRS2xYcEFrOTE0Wisy?=
 =?utf-8?B?Zk9LRHhGWXBtUDhVY2J6Y2k5cVFmZ3JhMitaN21BYm9pMkR2alF0ZW1GU2lO?=
 =?utf-8?Q?Gdjk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c26fc0-abe9-4f8c-b337-08dc2be66444
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 16:19:30.5521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZjJkGXhNVIGpybPBEctOi2EJrUCbA3u9IrvctqR/Uwc4qlEWa+zo/seKT8lLCTmAQpx3+TKyO1bF18mOWsTnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9049

Remove 'snps,host-vbus-glitches-quirk' and apply workaround
unconditionally.

It is safer to keep vbus disabled before handing over to xhci driver. So
needn't 'snps,host-vbus-glitches' property to enable it and apply it
unconditionally.

Remove all host_vbus_glitches variable and call
dwc3_power_off_all_roothub_ports() directly.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/dwc3/core.c | 3 ---
 drivers/usb/dwc3/core.h | 2 --
 drivers/usb/dwc3/host.c | 3 +--
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3b68e8e45b8b9..3e55838c00014 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1626,9 +1626,6 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->dis_split_quirk = device_property_read_bool(dev,
 				"snps,dis-split-quirk");
 
-	dwc->host_vbus_glitches_quirk = device_property_read_bool(dev,
-				"snps,host-vbus-glitches-quirk");
-
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index df544ec730d22..e3eea965e57bf 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1132,7 +1132,6 @@ struct dwc3_scratchpad_array {
  *	2	- No de-emphasis
  *	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
- * @host_vbus_glitches_quirk: set to avoid vbus glitch during xhci reset.
  * @dis_split_quirk: set to disable split boundary.
  * @wakeup_configured: set if the device is configured for remote wakeup.
  * @suspended: set to track suspend event due to U3/L2.
@@ -1354,7 +1353,6 @@ struct dwc3 {
 	unsigned		tx_de_emphasis:2;
 
 	unsigned		dis_metastability_quirk:1;
-	unsigned		host_vbus_glitches_quirk:1;
 
 	unsigned		dis_split_quirk:1;
 	unsigned		async_callbacks:1;
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index ae189b7a4f8b8..98964e8dea1f7 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -114,8 +114,7 @@ int dwc3_host_init(struct dwc3 *dwc)
 	 * Some platforms need to power off all Root hub ports immediately after DWC3 set to host
 	 * mode to avoid VBUS glitch happen when xhci get reset later.
 	 */
-	if (dwc->host_vbus_glitches_quirk)
-		dwc3_power_off_all_roothub_ports(dwc);
+	dwc3_power_off_all_roothub_ports(dwc);
 
 	irq = dwc3_host_get_irq(dwc);
 	if (irq < 0)

-- 
2.34.1


