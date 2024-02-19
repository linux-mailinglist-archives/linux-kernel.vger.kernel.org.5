Return-Path: <linux-kernel+bounces-71505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB80C85A656
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5311C21DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0724374C4;
	Mon, 19 Feb 2024 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="mYwDm3GL"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2138.outbound.protection.outlook.com [40.107.13.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E369F1DDF6;
	Mon, 19 Feb 2024 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354139; cv=fail; b=eAsgCKrTMoCJXJqSbX6qBGksA0Q2vE564w1LTTx8SLKb12M1vfZnxMRN0aJwQS7xnkEe9k9hU4lrv/Tak6deSAt9QKDXbrPnI5xNDB58qKr9dRkAo2XhVeg1Zqyzu7jTF2K/dwBUNz8QtMKiBIgbYyhmQTQz39rawa89zc6xvuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354139; c=relaxed/simple;
	bh=lEDL9vlOJSc2JEcBOvkbaJ6iVKFdQnFqm+r8O2i9DlY=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=HD6pkNmkxE7D/QOvPdSGubP12ya8m9B1l4jrYOQ9SMI0ROVScBDHSC3r3kdSBiBs/E1eJslMui8RS7Q4+u2uYbsGMXsD4wcvKMnjzR5hOyQjEA99zcQ7Q1EVTMB3Ds5+8SkeQ/EOYUrIkgy+6W4zrS4r3Cfp5ikjedP96NeEhHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=mYwDm3GL; arc=fail smtp.client-ip=40.107.13.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvogXusldR/HNQ1BcNp9oz1tdHIZqT2DRMz1+cssO35lixvI40DCUG0WIIQrl72nWlhNndz6G27iHmVVaCVmk34iItnwNgnXfmJGJJP4g4FOr3uZJO+dKfo0i0XprUzS7uUCKppsRhx1+fwqCcyad+UeHFcWR3uQqnjdBhc3T1IpP5XHPWnBf+sQD9E0MIg/QY6GjJ4qAby9qKZ1V9pvAGSgmezDk9NOLnH06JFEiKBDntZqSXK8f5F0Mo8fmtz7cZUauKr+dBhY9/9KooiDiUncwx29UPbp+tZPf2iWCegBBAunt8J+yanJRNx4nmyJQ07v/JCIg72kL0g3LGj6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CeSHhF5nwCtiTmhXPjYum94UaMO3HnI/L2j00FpiCI=;
 b=d05fF7vJYxvkRQDZ/RM9dyYJNgWi1yPKDegZP0kIP6tYkksW1bVImVG0eGNTpiNSjKM6KUEtSWGPqyUkFPRKpSLFDeSHZ6RfOlCmkUhaJ+BEB2s7ZAcqpWn8nWSUveOB238k2LbdxXvl37OOuHAF9UlLbShKqv5kP3Knf7APn3IJzhsG6VKdfNyzgHClRWPF22Py/os9MpyPPc+JYu1560YVGsE2BpP3h9uS5TwUmJFMSjRy0XWNBWqwIOkPNcbcQUiKl+JtZ6qqrJsBa0ui5dYIF8AIjhDBvRhC/OYG0Nw3GMs1rT3+aEZcT5XcjMe5z0q9Wg+/xefsUQ05HPA8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CeSHhF5nwCtiTmhXPjYum94UaMO3HnI/L2j00FpiCI=;
 b=mYwDm3GLYx/CrKVzLZ+V/Ro+p1ZHLUa1HA72R3X7EtN1fcQfAGd6jaVxb+2E6BivU3wVyFj3SDuet67e5sQO0tPQht5kFv62P3Q9RLgi+L1slfke8MvJpDNcJtx3sOqY75iJW5Ucszl+ryqxKxxUYn9PlAqukuwVSOvPmq8AYqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by GVXPR04MB9902.eurprd04.prod.outlook.com (2603:10a6:150:116::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Mon, 19 Feb
 2024 14:48:53 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 14:48:52 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 19 Feb 2024 15:48:21 +0100
Subject: [PATCH v7] dt-bindings: iio: humidity: hdc20x0: add optional
 interrupts property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-iio-hdc20x0-interrupt-binding-v7-1-c8ffb39c3768@solid-run.com>
X-B4-Tracking: v=1; b=H4sIADRq02UC/6XNSw6DIBSF4a0Yxr0NImrpqPtoOpBH9SYVDCixM
 e69aNIVMPzP4DsbCcajCeRebMSbiAGdTdFeCqKGzvYGUKcmjDJOWSkA0cGgFaMrBbSz8X6ZZpB
 oNdoeOKtoK1sphKxJMiZv3rie/vOVesAwO/8972J5rH+ZQac1dGPDIbgRYgMUZC2Mlkyqm6oew
 X1Qg1/sVbmRHFhkuUCVC/BcoM4Fmhxg3/cfE6LR2AICAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Eugene Zaikonnikov <ez@norophonic.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|GVXPR04MB9902:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b5640f-4f38-4e8e-11c1-08dc3159e402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7mX3n8cfHiDG0Wl4lB+ZWxf6pA9X5IPfQKCiSNrOjvYSgt2aOxHbqNFgxAE7bT9EOiTBaza+mUFjb2l4Yguj3N9enaevPDL7E4i/xWVdDNpx/1ljJerf5L4UD1HFknKkLA8QLLIo1a9r0LzqELn/heA5sRJy2fr9ULxRG+HUUiA0Kqvn0WFIoda1k6dSJ69hg1LkEghBatN8nldXDJc50Xu+Yc5X6CDBvc6p9tTOYrYsnefd7CoNKnNWw5wT04W5685wmYUimTdfwLMxr183kE79S+hjzEb5CDh1OpVJAicWO0l1DhAw8Lja9G6zXyVuepkQgcAS+97h7jVa21Ia/eG8ZH9qF7LG7A43Y1vNbrsJMvLUhG8IV35S33Ziua9ANtBXLHodw3QyfQ3BqgF3QBwk0rY4RoWDB8WW5qrYevYiOAZxxfs8f5UpDPFEzjXy+Lq+yOGJbJnffvrZY5MsfLr5FYvzMyki70CFVJYqFFFCaoc1d+E2AZ2mBURizXWad4pMhNVdEQIgg8nN5KtoBknlCiZxZRTDnC1eNYdQJ+Mw4EaoCZL8QOwUvNn72bK6WdSuENf8lIkMj5omXSe9DSthc/WbEyK3zGRI+bqLxMU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3VQeUlSM1ZDS1pBeDErM0RUbVBmOFVMWUQrWnNNNFB5R0tWY09GM0ZIR3Jh?=
 =?utf-8?B?ZFNLem1XVVpZTXFKTkFTb1ZnQUlaUThobG5pZlpzdUFyeHNzb1FqUWZrdnJM?=
 =?utf-8?B?R2NKdFJDL21aOEZaQ0Z6SnBxd0JlZTNtZkNqMmZIZVFISmpvNDBNbVVBa2lN?=
 =?utf-8?B?VEVwWm93dGp6VTZSelhwaThpdFJ1SGIraEtEMmlMamtyY0JIL3kvZEp4eGNZ?=
 =?utf-8?B?bUJPWkVQM0ZQRjk2YjZuYWFQakVwOU9CbzAydXFtUitMTFZvcHBKZXdtcE8v?=
 =?utf-8?B?OG9wL0RzclFCUnVEcVlRMlJCZFZWYzJmZmZDOU5YYit5bDhVbzJmYnFZeFhG?=
 =?utf-8?B?NjlJa3pRSDR2N1RYV2NXUWFhZW1KUzZ0Qm5IMU9wQXdwNWRvSDBvcll4bUFZ?=
 =?utf-8?B?V0oxbjFaVkpPR2N5cGliMVlFQjJ3cTdVaVhzYU5PeTlmZ25tN0FaSkx3aHZQ?=
 =?utf-8?B?aEhOM0hPMlk4blFYZjJ0M2FienpUQ0pDY0I1ZFZZZTUvQkdKdFJFT0VTU1hj?=
 =?utf-8?B?TWhWMVRER2VSUThjdnJqZGRmdXFwUFRNZVJkQjNNZkx2ckN2VzZBU1p3K3Y1?=
 =?utf-8?B?R3hqZUFVTDhaNXh2WUN5eXhPWE5ucFU0OFc3MmRHcEJJNzNqb1JlQ3V5Rjl3?=
 =?utf-8?B?Mm0wRFVLY0lwWUZNNk9ER1V0Zm92TFZCWEs2dnZJUmRIdkZURVhROHhQSEww?=
 =?utf-8?B?Z0NCUGlBUU95Z3ZISUppNHRFVWpNdTdIa2pJNEFwd1RLWm5PMTZvc3dkZ0Uz?=
 =?utf-8?B?MzBqNk5yV3NWZmQzNE5UWkFSdlVTcXlXOTNlRlZRNjlZQVFRWnoyNnBNK2lj?=
 =?utf-8?B?Vm9iWkFraXlIUzFJaWdGaU5ldjJFUVFYb3QwZ20vczJPVGRCc1lYTjdkanMx?=
 =?utf-8?B?TjFSRlFlQUZzeDhwOE40MlhweVVVNjRaZ2lQUEVMUXdRZ2xXOUJuZy9ydzlv?=
 =?utf-8?B?YWJNSFRweHFEa3RwTml0RzlOL1J1cTRyTWF3eitlOTRBRFJETHJKbkhuQnNP?=
 =?utf-8?B?QzhVNG1DYlk1RDBSeGttS0hZZ0RRNWZiM0VTS3RPT0o0a3ZYTGxlZVZLb0Ez?=
 =?utf-8?B?OHhtTXY0WDJaNklhUjFqZDI3OXdnWG8zSE4xWnZlUnA2VVp1Q2ZQdVdpdE1P?=
 =?utf-8?B?MGg1RHNJZEJDZUMrbEUxRDBxbkd1eGVZckJnSldJYmIxL1B0alp3ck5idGxG?=
 =?utf-8?B?UURydDl4NjhvUG15U083Wmh6RVBnUFlrK0RVdko2VS8rV0tSb0x0Z0huZWY2?=
 =?utf-8?B?TW5MMlN0R2xiU2hjUmxLdzIzdzdKd0lqd1dSUTA5dzlJd2NtK2g5dzU3Mmll?=
 =?utf-8?B?VDVEMVFBWTZRS1Ryc1lvNkxnL1BGWkRyRHRoWWpSTTZRZkxHYU9saFlVNWJR?=
 =?utf-8?B?bjZTQ3FwZGxzWEFZSmxwZ1k1dGZLTTdWZDU3ZVg2UkV5UHowempvSjZrbjhw?=
 =?utf-8?B?ck52UXJhNm1ieWRpdWx2Sk40eUg4cHJWVTNiR0lha2wveXl6djlIMmQ5UEky?=
 =?utf-8?B?WmRSY2U0VXBzWEd6a3dZMUEvbGxpMlgzZEpoVUVRQkJzTTY2akxkNmRFV3Fw?=
 =?utf-8?B?eHozSzFFRWpMeERGYStuNWMwRWZzc3ZsUm5GK3BSVTZIRGVvb2MrYzRtTFFG?=
 =?utf-8?B?N1lEcjhlWWljNHYyQ1luc0VMM2Nkc0Q3SWozdWtTR0Z4QUU0ZGNLU3NlUXZU?=
 =?utf-8?B?amIvRnNOWFJ2UDQ1ejhlQ2x4cHpRbU9hK2pFbDRvdFlpQ1NKdTd2bnJ0b1lZ?=
 =?utf-8?B?c2Mrb1FONGJLNTlLWVpLdHlMaW5JOGoyWjhDd0twY3J3bkdiSFI5bFNGQTJl?=
 =?utf-8?B?azFzbW9sK2RSQkMyUXdZbHU4S3BaYXIyWVpFZk1xYW5kUFUyZDh0ek9TM3Jy?=
 =?utf-8?B?cTBQUysxRExIYkE2ZGw1TDVGMDV4MW45eFBUdmUzcHVNSEV2WWhGbklSVDQ2?=
 =?utf-8?B?cnVLZFJNaEFUT1p3ZjNaTWJtdHhJQ2ttVGdCQVdxNk5EMklCdzFJRjlBTzl3?=
 =?utf-8?B?aWY4dzBHUllRS1JRRHk1TmJXb1RhMkEvUzltZ0pEeWpqQ3U3Ly83TkJwYUVw?=
 =?utf-8?B?YlROZWRxTlJ5TDRrZlQveXkwTThjc2ljRzl4cmtxRzU1aGd3TTVUdDlZSm02?=
 =?utf-8?Q?EiZ3Kxqiz0Kw7LhtKWp7B+Pop?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b5640f-4f38-4e8e-11c1-08dc3159e402
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 14:48:52.7718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZmYI5dSuGisGcW9MWyTbcIFV2kq3G7FB/QK0BLdRMolceWZj6NGyAMOVOTPTK5UPJdsyOsbD165wd6NzyU8FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9902

HDC2010 and HDC2080 humidity sensors both have an interrupt / data-ready
signal which can be used for signaling to the host.

Add binding for "interrupts" property so that boards wiring this signal
may describe the connection.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v7:
- split out of original patchset because it should go via iio tree
- collected acked-by Rob Herring from v6
- Link to v6: https://lore.kernel.org/r/20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com
---
 Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
index 79e75a8675cb..e3eca8917517 100644
--- a/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
+++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
@@ -27,6 +27,9 @@ properties:
   reg:
     maxItems: 1
 
+  interrupts:
+    maxItems: 1
+
 required:
   - compatible
   - reg

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240219-iio-hdc20x0-interrupt-binding-42307b7b99b5

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


