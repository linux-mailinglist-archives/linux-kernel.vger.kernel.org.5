Return-Path: <linux-kernel+bounces-49938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816648471C9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3CF1F26F35
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E96144612;
	Fri,  2 Feb 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="byME35MD"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2105.outbound.protection.outlook.com [40.107.22.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39A3145337;
	Fri,  2 Feb 2024 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883747; cv=fail; b=gbACtmNXXD883ukjeInFJJ4ixFn8o5M79zIsgVuDlh9ZZAK27E3eax9kMQvdcWYP2Y8FBgCBuPN55JrL+r/5t2qgytAa7HtohhMUavfjjD0E8uF6dPe217Uitvc805UXAWk6KxBJpsBfQm4Zw7etpdiPFoVV6FASnV2EUr+87dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883747; c=relaxed/simple;
	bh=/AFhwce9jy00uSMBqBN1uM60wnY3CtRqra+U5vm2Qik=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tUA04xvign9QgHSstjtkt5GXS1v/kI1oHIHSdQhb+PD58H17E5VhBB+VoUaO9dI3/qHocWgE5rJpkDIuV+2SUV2FsLSZd6pbdXUYcfmV7KzszSaAcAzswROnhf8NVBzdPB/+N0iPZpd6tTby8cPRGZl5ymWpeCcXqDSx1ygLBec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=byME35MD; arc=fail smtp.client-ip=40.107.22.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaSeZ0ATlYcsEz2Yb3HkrKN/F1wxngzxyEEyWEJWjTEzcGj/r7z38nQQ4B3YKoNL0aA+h0UllDUQRys9lPFPLsklm33s9R2BvW37SFYVAzTfQDnrYgvUzUfa9PEDe9kY6xvKeziRf83lxI3k/FGy4rTUS4YCA0Spt29haohChpekVz88WCm7PNCcNqvKTDhamZBHqLTasrVCEmCRoOuprDUpigO7w1T5w2YoOnml5XqFZY6pkhYJ9z5dcARcFmsMVai9SEkapfkezLALdTdbXGnMxjA3AJa1nf32AO9U26Djzu65Sq/khlwsxwI3/qE1yu+VoOU2C5J8GCPQSjkJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xhAhy9Ne3mpZiRcpteoPWTmLUCCCBx9qs/C00AWeT8=;
 b=npnmbXZ69v7LfKO+TXl6PAHeFPvCg2WC8DjMVMgyrid24hPSLCMya9NiiyTgi2x1CNYvcIK3WAwtYrK5mafhHx5H7H1U/IG+NVLGY7Iw8WoUJTTIS4hWjX1N/qEhCIsocKPU80Un+WFz89DAp+xNuMD8W66e2wH973BOMPXA7U6s2FYrdILdpfcZHfu994RS3O7sQIapF6trWbGNy/Hm2hsznPBMVrEDQ4tWwUvw6+le4q4RAWOayFW1RsDrjF2qf7UDA13hLf4g9E4y2V00YgQHsR1ev1zcDmk/2XKlcL0+X5FA5muUsEMqf7D2mvUtG6dCgtvLEaQq0Iw1HC2b+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xhAhy9Ne3mpZiRcpteoPWTmLUCCCBx9qs/C00AWeT8=;
 b=byME35MDtuM3b6k4oLXj/VsiXbqKztChpm4QF7C7WU+vSl23Ah05UMTbRUPyyqYw5QVEsxGYm7cwr+fO6kP4ubfDf/vGiV/CYvgVN9b8ZcP+YZ+PzcbuM7fKZYpSPcWaQfhxjASjgVjUFrp+Sccc7Z4tP7mYGP0ACYtvZ8PJN6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PAXPR04MB9007.eurprd04.prod.outlook.com (2603:10a6:102:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 14:22:22 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 14:22:22 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 02 Feb 2024 15:22:17 +0100
Subject: [PATCH v3 1/5] dt-bindings: arm: ti: Add bindings for SolidRun
 AM642 HummingBoard-T
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-add-am64-som-v3-1-2f44023d50e9@solid-run.com>
References: <20240202-add-am64-som-v3-0-2f44023d50e9@solid-run.com>
In-Reply-To: <20240202-add-am64-som-v3-0-2f44023d50e9@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|PAXPR04MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb484fd-922d-4fb8-bed7-08dc23fa5f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3pDaJqtdCgjxEHMuiROxkTYq9Qs89dzoNuTPIQTB8KabHMH2Na8wf+gFmn3HjZSOj/ZgSXkVg+/hLfCBz5yaUlX2fbA+5MHBW5trsZaut+0mtsZxRtuZTzdf7xsRLWRIi2lRNL8kL4/xdwSOCV2FPeP00B7ishN05I3KAhSXJfw8cHHDv7GsiLTiZeozuY2c11JTezbWG94AHr575ijnHOHM7bSLKLYF1CB1iAwsBmmiPGumKoDcFTI5S0DQO+PqZxg5FZFJyvXawD2b5UylZbIXe5AKDu6OHbIC/2H/aPDm5UdQLhOi/68RvU3R5BeQH7+GJHp8hSbUlKRxRkEykKp+tIyP2q2FYKE29X6uiVqtcA8WxEDZ7KwP4pNhx0Ae4NDNHXqcD3QO+2x4+QaUAAhM+nYMK6KWzNEsRLdUlNmrXOOg1+P7tLFGHJo01ihP/ZonZQiN9QbEMxuAfgDve1PngZACJDTC+6Qy6G77u20yXWOiTjGfbR53iDVdbgIagC2B5+QrsUng+ox+fS0rFlPErr10ojyTSpgf1YTJdG25xCWswb0c8RNcBNTqiD6LwUqcn/KSJJQCOshoXW60LotMBWs8ZTErb63xLdoPOBXlrludWRkFTXVpr6VWwQ7B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39840400004)(396003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(26005)(6512007)(38100700002)(7416002)(41300700001)(316002)(66476007)(6666004)(478600001)(6486002)(54906003)(66946007)(66556008)(52116002)(110136005)(6506007)(2616005)(4326008)(86362001)(8936002)(8676002)(4744005)(38350700005)(36756003)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0J2a3l5WHRtaUR5TGdLRlFTYlNIL3h5VG9qeHZGL3pFWTZRYSs3c0krUlVB?=
 =?utf-8?B?OENIQkJiS2tGZHNtbTRMSzFPYm1COEpYZFd3L094SzZCa1hZZXN3OXozK0JL?=
 =?utf-8?B?Zm42UXI0ZXZJeTF1NU5wTnVnQmxwcHcyVVRLdTYzVXZvN200WmQzUkpUOUdk?=
 =?utf-8?B?c09hVVdSeXJadm84MWVLY2pFczB3VklpK05Vcmo1cWlJMTVhYkNrN0JKY2xS?=
 =?utf-8?B?d3R4anFnc2YwOVErMXFsckY0MVhHRlRrb1hSU1NFcEcrdXlOUTh1K2psSUFR?=
 =?utf-8?B?UHBucEg0YllUT0xlZlNRMWY4UWZTNDFmTDZGZ1Zmb0NFc0xMaXFQbDFiZFVB?=
 =?utf-8?B?dk0xL2MyeUh4V1VKWVIrTktHdFJ4RlNyVlNpN2lXQnpnenVnM3h1cWRwWXVi?=
 =?utf-8?B?WmZDWjQrVHRqREVyaTNIaEV4Z1NFREZmcVpWR0Y3V0gzNURuWU9ab2dFWm1h?=
 =?utf-8?B?VFRyejc5RVArNkYwWjlNTVBpcXBDSVliWk95S3NUemlPNEdXWFdKVER3aEpC?=
 =?utf-8?B?UHBlUFkyUTVYemxlbjFOVXh3bkFKMlNuNjY5TkRtbS9iTFRLKzcwbjE1dFgz?=
 =?utf-8?B?cHBZTk1SODl3MExnNHBLMlVxc2ttNlJwaHBNaHNSeW8vWFNnNmp2VGlWV2NX?=
 =?utf-8?B?cmpWUEg3MExMa0hGVDl3MlBDRlBVS0E5Z282VjBQUGVTRzkrcXplOHBydzhT?=
 =?utf-8?B?ZFh0dzJlWDcra3J4dzFFZXBFZFNTM2N0Y1VTV2xnQXhYWVVMbnNoWmRaMVlD?=
 =?utf-8?B?alR2eDgxencwNmFlRDFRd08ySEpZK0ZVTkFaMFY1bzJDdDRqbjZFTGN2MU5Z?=
 =?utf-8?B?SVk0SmpwRWpKbXVha2xmQkxocmRlcWc1NVRLK3BCbEFBa1ZnVXFBeHJHaXRj?=
 =?utf-8?B?Ymw5LytPL1VZRHVuRzF4bmdPZFYrV0JWd0M1a24rRm9WcUJncjZ2ZHFxWHN1?=
 =?utf-8?B?S0Rtd1B0T28wVVc2NHRrSjZvWVhXZ0tKaXJYTW9QbTRrOVdyTVprYW5oMm5N?=
 =?utf-8?B?dndWQUowdGtzV2MwR09FWEY3amFnOWc3ck5JL1Y1M1gwTWlEQ3J0MEN3VG1E?=
 =?utf-8?B?V0xkY0VUUk00b0pQRTFUOThVUFhJU1k4S3FCQXF0bWxXNmJIUy96VEpUd1ll?=
 =?utf-8?B?aXM4cUx1WWwzWFRqZFRybkdGUU5jUTdVeURZRkk5MjFPR2JnR25oQ3BSd0lN?=
 =?utf-8?B?cFU0akhhNW1tVkJHOFJPMlZjV0oxMmRlUUNJN0RuYkN3UXdNNStOdm1NQTVB?=
 =?utf-8?B?U0RBcU1sMVVPTWdQRUl0bm9iczNCclErd2s2QW1TaGVJNGdlc3c4MkIxMmFl?=
 =?utf-8?B?Q3B0OWdIa2JzNjVQa29HMGJLYmJ3Z015RlZNWnkvYklQaGM5Y1lCQUwybVJv?=
 =?utf-8?B?WXV5VVVrSjZxbDJqSHFqQnZVY3VrWUtHVHhZeHpBczZkbFZ3QXYrS0pwbGV5?=
 =?utf-8?B?VUdhaktQSUZzSitvUG40R2pFUVhLeGtPcURsVmlYVWxWTVViYkpUWTZoMms1?=
 =?utf-8?B?NEQ0bTQ5YnQ5QW94M2F2YnUyWmZlcmxRcXVrR0grdk9mTm1XWUhpeFdWRnFN?=
 =?utf-8?B?RkMxSHlZdTFLQlRFKzZjbVlaNXo4ZUZKTE9BUnR6WWJOZmZDaVA2enNaYS8v?=
 =?utf-8?B?R2VJWlc3RGJXUnFSTkNjQ0NlTzVYR2NTQUsvR1pSVnpOTjNXRGZVWk55bzdH?=
 =?utf-8?B?dVlYNExvN0RYUWU0Nk9tSHdiTlN1a3F0MktTUFY3L2RFcFpWSTNXdjdJY1M2?=
 =?utf-8?B?S3BmWkFnWExyOW1NYUV1cDBHUDRVUUh4T005MlU3Y2Irai9JTDJBQytGS1Zv?=
 =?utf-8?B?dmMzaVJQY0lyU1JUb2tIaWZsNC84aENaRU9BWXhLUW9IdTNZbVRRTlpaZjl2?=
 =?utf-8?B?L1JxeXNzMnZhUDNlWFVMQUVBYi9PYUJpWGtpTEV5cTc5VmFpYUZnUTdxd1Jh?=
 =?utf-8?B?Z096QkQ1R2M0VXFiSUJpODVuajBOamFLbXdqN1JncnMwc0trMmt5SHBMUU5M?=
 =?utf-8?B?aTVRSis5WmhmMTRmZVEyY1JUNVg1aHkzVFdPSEExYXBqQytaUHlwUlNqeWJp?=
 =?utf-8?B?eDh0bm01R0dMYU4xQXk1Rk9EZCt4TkE0REhuKzRsc2MxcVdDWWdwWkd3S2FJ?=
 =?utf-8?Q?vUvfY+38GSSEIcvcPNpnhVOwg?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb484fd-922d-4fb8-bed7-08dc23fa5f3f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 14:22:22.7551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64rZufpBhLT+1X/ky/ehZknojQ+ByPkpF/xvv2kL7ZardCCgZQDttet42b+4PcM02ca6LK9Kz0cfWtPzxS1Bog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9007

Add bindings for SolidRun AM642 HummingBoard-T Board, which is the
evaluation board for SolidRun AM642 SoM.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 03d2a0d79fb0..b9f2a8d36874 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -85,6 +85,13 @@ properties:
           - const: tq,am642-tqma6442l
           - const: ti,am642
 
+      - description: K3 AM642 SoC SolidRun SoM based boards
+        items:
+          - enum:
+              - solidrun,am642-hummingboard-t
+          - const: solidrun,am642-sr-som
+          - const: ti,am642
+
       - description: K3 AM654 SoC
         items:
           - enum:

-- 
2.35.3


