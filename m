Return-Path: <linux-kernel+bounces-71498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D6285A63B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D447B22B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B318837163;
	Mon, 19 Feb 2024 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="mAlqYg2s"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2103.outbound.protection.outlook.com [40.107.8.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2758420319;
	Mon, 19 Feb 2024 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353722; cv=fail; b=arvW7bGDInznN4svXtHiwuLRSpvbuPTqAOw10iSzbYg8xbMS4VRxUOQM3/ifBupCwJ7XtKnSzp8OEJmAF2w13tPUzWQaV6aD0WjqY/oZQi+Z6Q0lXv38I6dCykR40nHxMe3tCQx/dJClRKLJXlEPpqWLLsoxP2AJbin6KG40IxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353722; c=relaxed/simple;
	bh=iIoIiMys9ZhjWOXInnCFQuiaNVz438Z9LfkTyU8f1hk=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=jNZevzMtwR8iLJWXE14PVVgcoobx2uMSy4Dun1kw6PHsLTvoncPGg/7WWX1PDcWHIGsLyJJHSQRmBDGHj0V47zAuOB93i5Wxx+Vj36PS66ppQCNBEP+4t9YllsJ/mlrifF2XTkmFa545n8C/iaaZKxyslAwyBVUWQbfx32h4qMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=mAlqYg2s; arc=fail smtp.client-ip=40.107.8.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oa4Lm/IoAb60E4HcMHICyC+WHLOoItTRZDFJXbaNHFoKvyz7cy0XryyNgtGNmUpmx3IUZRkZyHVmXXcF1iWzw52p2Jr9jjD4V9yNLK9PPzEx9lDG2g4hnC5DhiYLxj4T5HDfNZNAXIO+hYVYKcc90LgENMJdGQsQ3LHjB1xXA1kRVGs4PcgX1G74wseDk9wG0WEAqw1t3MkrGZ25GwAeYlYrc+cOy1kXxRWNeIFmYwimC2AL/IuunU86OZPBotKefPd8kG8irrD1ii6jpE3xNrxsOmVbi8ARdgQrHXsVvlNGmlg5QRuNjXMCO7zcTGs9vOf1VjKc2+IHUbDVRsi+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iysi81QcxMkh7xwJQNcvfrcaX9e9U+OBz60Rrl6hZVo=;
 b=Oe+t7aKG+cc82sPW/yGsTfVLcDTaNLxl7Qxnz1KpTbXpIQZ2SHtk57LMdAWPePR1Jx2UDMPnqsVBaGncwxgUvx4xnuGDbObf8XfTUNc6z281Vz7HrNwLjfFGOEs4+SORlC4hSXTTaf0pNvBR4GLIadxd7L3dODHJNg3GYM+T8BK1om7N37FmcH6KvotMhSFyn0gLKOZUEBfhhwYNOvth7EUoLJsd16r/wCzMLsTkFLD6kQr8uW3WZuwp7rg/AMPo9esZcTzjbDkolcVOM+8QOPuMNvjAYSpJ2yO7GP/tI+boueySy8hTX/L8RiqfRzlO89AdQNSpaoGoXTYQBE/nCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iysi81QcxMkh7xwJQNcvfrcaX9e9U+OBz60Rrl6hZVo=;
 b=mAlqYg2s/0XVgJWPx04i05/Eu9W3sgtl8Z/l0kLKZApCQRMQB+zlais+9mxEsi6jt83VBcAT/lYiTB4tGSfsZAe+X4w0LgkPbsiQjZWVpJ1uaH7cBVK+m08RVY1PxBCr4JNkdE6PQadAeB3KCjFTU3+Dl+iDZfBDhdLcud4p8YU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DBBPR04MB7563.eurprd04.prod.outlook.com (2603:10a6:10:206::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Mon, 19 Feb
 2024 14:41:57 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 14:41:56 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 19 Feb 2024 15:41:19 +0100
Subject: [PATCH v7] dt-bindings: mtd: spi-nor: add optional interrupts
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-mtd-flash-interrupt-binding-v7-1-206e30a656fa@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAI5o02UC/6XNSw6DIBSF4a0Yxr2NIqJ21H00HchDvYmAATVtj
 HsvmnQFDP8z+M5OgvaoA3lkO/F6w4DOxqhvGZFjZwcNqGITmlOW06IFsyjopy6MgHbR3q/zAgK
 tQjsAZ3VfN6qgpRQkCrPXPX4u/fWOPWJYnP9eZ1txrn+XQqcUdIYzCM7AxiEHUbVaCSpkI8tnc
 BMq8Ku9S2fIiW00FShTAZYKVKkATwGO4/gBmwz+ZQACAAA=
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DBBPR04MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e30da8-4442-48d0-3c64-08dc3158ec15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jlcB379X/WnwCbusxLWSEZEuXZG1M3elDtTGZ6S5fXOX1Ig8EJI+O/NJLY7s6VXCrbZ/8T3chLzQjIgZXGb/8bgVQE6q5D2XTveKaN4DLLqvszk7lILzbTeSFa3vUqvZjQxj0xhTDAzNzjQ6FPowLe14VOGHHiZo+oXmPte6R+iY264hXVAr0488kApI0IFL+L4CNAb2FBI1DwHLGX0rkpV7rChka9kpGhxTHdDtV8/zNPTR0fAwcIefz/ZiCRbNmRQQGzcXShP5EGcwdTrsCQoDv8oH4HeKQkU1Y4wXFAr6M5Gw8q9j46o+fFliZyj7n65k9IsxwUqRLhW/EYZMO6VDw5ORmH0hXnhJh74QtIi1JkKGHcdkieKJFIypaSBrd6FwOqIndDng12psZi7Vo8bhhwa6XSxhl4udnUOk75mR77/fxaFDIaPLvGEAo7LPhe7WdmpxovnNphJxL7IkiPNzgHm+pM30Ljo+JUR1FQ7NOxPYJN9hCKRcyvtqd+FpiR6xmFDGbrk3EpjZK2GVb+Fc5icX23TJzsmj5QfK2BwOlndSK6ffo+ofP9eAfzh3K3t10Vbj54zofiIVpOiAHbh7j8bC4wZ5zyvcfZEEze+HtarBu8MsbtHV+8lpAJvf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHhYaWwzNy8xcGhpWlYxV3pDQzlJNVBkc2c1MGlCbFpaY3dIbU16MnBUNWhr?=
 =?utf-8?B?Rm1kN1d3RDFYd09mYXNSdlE5TkdrRURlNUtsd2Z2aHRiMkpHeWE0d0EwdjNq?=
 =?utf-8?B?cWJDWFlldTBHcS9yS1RtRnJzeDhtOCtZYjNuc3JJU2h6cjVYeEVsMlVxTm9Y?=
 =?utf-8?B?Y24yODFLOVVZSjQ4MU5mL3FZWjNTMVo1eDJ1dGJoT1BFWGU4bno3enBybkZ3?=
 =?utf-8?B?U2hVT093ajh0YjdZMWRCNC9XK2lvNWwzU3hNQ3VEaFNub2FOTC9VRytFeFVx?=
 =?utf-8?B?QlJFZVVtaG91c202VUZsNFdVNDdUQVhVbFF5SjlyajM5SzcySnMzeHpHWlN2?=
 =?utf-8?B?ZzRYUXFDTlV4eU5Gd2tKUm9tY0U1N0dwTHphR2g2TlFucEVDKzdNOEdRSU1o?=
 =?utf-8?B?bmNNdXlJYnl3Si85MHNDZmwyb2hBa0s1T2ZqVXpUNWRud0ZZZFVGQ0hRdDdD?=
 =?utf-8?B?aThsazhIbkVobUNYTDM1NjREQXRoZXVFMFY5bEpOV2FWWFB0TDU2a1JUOFdM?=
 =?utf-8?B?YnFITkJOSUQ0cTgyL3lIUDlnQ0RVby91VVJ6SloyT2p1K3A4SzhtZmZEZ1R3?=
 =?utf-8?B?VzNFbjVjWjJrT0Z6SC80UTlzTERwamp0RVRjV045dUI0Q1ZEdDBxalpEbDNr?=
 =?utf-8?B?YmJiNzdqRkJaYW5IckUveGpNYWRjb000S01LUzNJUkR1UWZNQ3FGYTJ2ZUht?=
 =?utf-8?B?WlFwOHRhTzI5SzdIZjl2aXZvYTJNY2dOeU5ZTDJDTUFxdk9ZZzVzcHpFWlo5?=
 =?utf-8?B?ZENRWUVqQmg2QXRkdU5lU1hIdWtFUVQxNFB5RXBsUTByMFJSN21jRmdlTzl3?=
 =?utf-8?B?WHdkMnJYR0dDRUU5WWVBMFc0Z2JmVGxLeFk3V2Y0WVIzZFdlZnEvN09QL3gz?=
 =?utf-8?B?RlZ0cTJEZDZsNStESVR3OURpcjJsRlJqbVVWbUNlU1F2aEZuRFlON1dtM2Uz?=
 =?utf-8?B?dHdVTnc3U00zWmZpNGFMQzJuRkMrcVF4UVgxSVlCOTRjVWQ3MnRNZ0Vpc0VC?=
 =?utf-8?B?TUZRSmx5K2hSMFl1RmFUcERwd2YwN1dUaHlHR2FFSzRjcDQwNjBQQXJSUVc3?=
 =?utf-8?B?SVNiQWZHL1hNY0ZHZVA0RXZkc3hBamlhY3RidDF3c0d5Rnh2QklVVGovRlBN?=
 =?utf-8?B?RzdxbjBCeFFiYmk3WHgxSzl6QlFmd3pIWWZkcEJJZUlxcGZabTlMS3ozZ0VS?=
 =?utf-8?B?aHhLdi9zVVNlZWh3QWpUTEUzVnRKRzRUUHRicmI4UjA2UDgzdjZiQ1dmcis2?=
 =?utf-8?B?NFlob0crc0U3OWR3MmE4ZHVkbmh3MVRMWXdZWitPUUp3S1B1WWo4QVJNSFk2?=
 =?utf-8?B?MHk4RXVpbUlwSlRwTE9ycG5mRzl3cjhFNVR6MTh5WWprbEtqaWdYd29UODlJ?=
 =?utf-8?B?ZDFlOCtZU1gxQU93MU5Jall2aVV5T3Fjb0Vhckd4MlZYSTE3SndzRDlpeis4?=
 =?utf-8?B?eEEyUHFrTlRacDQyQWVWczFVd3JGZ2hmY3JuWjZvRHlQRDlyQjBsNWFzTkpw?=
 =?utf-8?B?TXgxQ0ZqQlo3bEE0YTU0cWFJSHAxTEMvVHQ1WC9kVm5HOHNGM0I5UDN1SVZH?=
 =?utf-8?B?TlRzTDFSV0xjSnFaLzFRUlRGUndJejV5bTRNN21nd1RkNU5HSXU5TGIzMlI2?=
 =?utf-8?B?MW90SHlSOXJDN0VRbnJYYjlSY0Z3V292V2NVMXdMQ21QcmwrZWtzOVdHZUZ2?=
 =?utf-8?B?Q09xNGRVa3piV3BJQTRlRTJFcnVKUUpnemdiN3Y4TmpnMldBd0NaR1RMSnJO?=
 =?utf-8?B?Z1U1UXE2U3NzRGxlRGZ3K0VXVDZTdFltUHFaTjJFLzc2cWRjYzJlN1pobGpm?=
 =?utf-8?B?L0hPY1FDT29lUjZ3TThZVXVxTWZzWHkyc3RKeU1hdUVUS1V4VEMvLzI2WHRE?=
 =?utf-8?B?bkE2OHg3OU5hVTJWSTJzazQ3bjFXOEFzVUNyeU9ZcUdUSXBXOGVNZXdDWXIv?=
 =?utf-8?B?eUExc2QvRVJLTFplV2ZNWEdaRDVHR3FBVk5VbHk2ck9vemc2cGZUbmhKMlJT?=
 =?utf-8?B?OTlrdjZMYnNERnFWVU5yQmIxbk45RkdEY3FyOEVXaElHM2tUbkZ3cEcxWXdw?=
 =?utf-8?B?SkhSTkFtQ0Z3ek9sZjZ1OFRFcUErN1JSRkUxSUQzd0JlTkJUK0tLdW1rRmFQ?=
 =?utf-8?Q?mHhtjTxEaNxdUwncC77iv8hSF?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e30da8-4442-48d0-3c64-08dc3158ec15
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 14:41:56.8401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGyA5cowRf073hvvNRbRUJ8uPdHXzCcRNGeWYROpitb7tMnMW2a5WF3G6hz+yyflOGnZgRhh8UdzTk8eYKpJjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7563

Some spi flash memories have an interrupt signal which can be used for
signalling on-chip events such as busy status or ecc errors to the host.

Add binding for "interrupts" property so that boards wiring this signal
may describe the connection.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v7:
- split out of original patchset because it should go via mtd tree
- collected acked-by Rob Herring from v6
- Link to v6: https://lore.kernel.org/r/20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com
---
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 58f0cea160ef..6e3afb42926e 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -52,6 +52,9 @@ properties:
     minItems: 1
     maxItems: 2
 
+  interrupts:
+    maxItems: 1
+
   m25p,fast-read:
     type: boolean
     description:

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240219-mtd-flash-interrupt-binding-647f78d123cb

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


