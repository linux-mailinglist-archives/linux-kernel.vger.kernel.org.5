Return-Path: <linux-kernel+bounces-166456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 843448B9AED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7B51F21554
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5761F8004E;
	Thu,  2 May 2024 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="NZoZBOkV"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2124.outbound.protection.outlook.com [40.107.20.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF27384DF2;
	Thu,  2 May 2024 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714653149; cv=fail; b=Pd0scpBFc0YhuehaLfp5f3n6Tfpetcy+vZ+8kJv3S2SZUFKB9uP1SHrwToOZ27homXekMHV56Ih7Vf/ZK+ZKa1KGK9SRev4Exx6CdIV0fbg4mQyo6qCasseJQzL5huYGMb7DnBMuMjdI+yI0b6OD2z8zUiUZ6a5woO6aMxsufv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714653149; c=relaxed/simple;
	bh=D08Brbe6/eB3+6D8Kg4Npi6oDPwU/HNJ1DVXMTI77FA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dUSABHfy1laT9gg9fybcKsSoApfBdoVQaq89zFMFcfhBIGBuQyyiKc5UenyA6PxpGxXAmEBUxF0ybweuGAtsHqRJ2bT0o+666GiAZBIyHyoUWw+b2iofRGIQuMorAHyWQyu/xmonlxpTTOFlr2GOALE2eWLQbbZEhB5j/LNp0sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=NZoZBOkV; arc=fail smtp.client-ip=40.107.20.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvDfcbw/p4jUkjSDXZ4DJUjF55Zu6KCGooL0YsmYkcoE02aLhUv4xHQP4yW3dTYIqctYdQpEAt3berC9dTOfTco716UiOgQTe98oenLvBtwsX9Li5bkEas1HobrtNBxR5F1B9cFuSEqtwcMUkIMk9QwZe9FGkWQlTyInj4tOpTtYB+W305iIAtCXz+u2gLl6OWzmKfkanH3mS/SAs4VPrzFwdkkiwhbm1Rq7YZ4nDZemt41pu7DSL2wUAY1wiaU3qDhjY98YfEu5dG/mt6LjKvCFzUE0C+H4I+yFRtp1+PcBBG35+3EzdCa6O6XtBwlpPKSm72hlHNLbm7P79YW73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vo5BGbWiFZAiTCPdzisQWFKPxsJtR4IjKCUlGVn58CE=;
 b=WxB9I6nkbJFhcPfQTwkuAFBwOJlOaQtWG9BfYiHlHlBIOlnjlvWfZEQAtWudxZ0mJBi+UC24ZsAiIPOQ1zGRV3Kc3UD1Yec1h3yPSLqbAaaku5CJFETizO0QefNRSixrPqbySsJIbrlkSa6GAmTGsOsMED5m7deQm5G0dTVGOt1MVw2RD6OfNre9MNR7gxs+fGLZvHQoBaSzpxHUh4aDCjIeWSzWIQE1b9EmzI4FzMuiPk0yspTh62xCLuHyxrONEjnY/JUi4HRMk9DZT5nBrmOefT7CDp4DKuPHHWqU3wGnMVjVM8/EufrmfpQ4T3qHQwkHkYNPoxWDpF08OMJ6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vo5BGbWiFZAiTCPdzisQWFKPxsJtR4IjKCUlGVn58CE=;
 b=NZoZBOkVInwQLtC+e/rDoifu/kYKZ7jFAEAw08Z/U70MR6utMBUsdlT9m0i5wCFuhwOkGhs0oE+waJ+1z7bssJYNmY9/b2yMdWiK8wGZfAlZ5TBU2OFo6BtTeLoEpuAl6o07otkxKCsDCZ0qV7HxijM1iSCkboO5VLpGuXOqExQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DBBPR04MB7900.eurprd04.prod.outlook.com (2603:10a6:10:1e8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 12:32:18 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 12:32:18 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 02 May 2024 14:32:17 +0200
Subject: [PATCH v4 3/4] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-cn9130-som-v4-3-0a2e2f1c70d8@solid-run.com>
References: <20240502-cn9130-som-v4-0-0a2e2f1c70d8@solid-run.com>
In-Reply-To: <20240502-cn9130-som-v4-0-0a2e2f1c70d8@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::11) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DBBPR04MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f98df6-57f2-4660-6b52-08dc6aa3e7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|52116005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0hBQmErSlBvWGVRNUpHY2srMUtTdFk4eFFOTjFtRTVOOWFaQ2NidTFPZ3Qz?=
 =?utf-8?B?a04zSHUydytDMmQ0WEFaakxLS04xM2QzeHJjTkRLQTJhNlQ4TzJpa1E3RlND?=
 =?utf-8?B?ZVp3OHkzT09ad09RMHZuV29tRGt1bWhJTWFrVWc1c1RJS0pja1I1cnhrUHlZ?=
 =?utf-8?B?T1BYSnZORW1rMzhKOE9mcmlJWlhYOHl0eElnUk5GdTEvWXlNZktycWdRSFQ3?=
 =?utf-8?B?dTgzMDFpeWd6dWE1cy91Q1F6ZTI4dHNRa21iUVcwem4vVG5DL0wzcmlxZ2VQ?=
 =?utf-8?B?OFVyK2ZneWM3Zkl6THcvOTl1b2x3alpZMnFSUVU2V2lmNWRPVzhCMVFvLzNR?=
 =?utf-8?B?MjQrU0xReDV6UitFekpNM1dMVmVrSmd5UTRBejNIVEpFMmRXSDVuK3M0OUV5?=
 =?utf-8?B?TmhCeUd0cUs2WXV6eXdwQjEzUnZ5YzhvRGNxNURmYUpzWUcxdDVqVTNnTWht?=
 =?utf-8?B?alJvbzJSbDJZQjVKdEt0dkh6ZndJeW9XTFVPbHY2YTFzVGNtNlU2TU91djJ6?=
 =?utf-8?B?bEd4eVhRU1JhUkdZZzJyN25zbWR0eHVpWEJyWi9lcWNOWjVJRHFoZzZ0Rmdp?=
 =?utf-8?B?c3hvZjZhV2RsWGN4cVA2RVZzeG1nUWJBVjgxaHdocWN4dHNwVjZyTHYyWGQx?=
 =?utf-8?B?R0krWHc4ODExMlZRUTJUbE5BQlIyRGMrYXVpZVRWN3hKOW1oWkhRQWxJanNM?=
 =?utf-8?B?bkFnSHlna2cxZnpZTGIyQUEwTllUY0NUdDMyNlFWT2drdGpveFRUUzlKTzhr?=
 =?utf-8?B?dURFSWtZdUlPYVptQ25xcjhHTlpQTEFmSXUzQWQ3S2tCUkNMenBEcUxlOHZY?=
 =?utf-8?B?Sk9CcnVUOEtleDY1MUFaMUZPWjBOTEErZ3dUa1Z0emphZHBqM2I2WTFoUjYr?=
 =?utf-8?B?b3hub0srQjFXQ2xnK3FQdU0xMTlncDg5R3lYaGhtRWV5aHppaXpjYkRJajBo?=
 =?utf-8?B?L1VxVkZ3a1A4MjBoOGtiek1zK0RDcDVzZitPeGp6MXpvWUQ1dHVSaFVGU0l4?=
 =?utf-8?B?eUszT3dGa3BHbFRocFhiNzJjc3FQZ1dnNkRyeVVvYjg4bzhBeWtBR2VNUXFE?=
 =?utf-8?B?ZmdMRTdrYnIrbzRtRm5SZHdHY1pQK1FLdi80dGdrQStxMStYd1VwQ2gvS3lZ?=
 =?utf-8?B?RDFOSEpUS1RaNElIL2lkMlo4a1Iyd252SDVaaGtrUUxNOVRqazZqUDNtdHJC?=
 =?utf-8?B?N1c2alNGMnhXOEVIRXE4Sm1FRzR2MTlkSmJiMWY3V1hVdnJzb0VJcU5RUHRk?=
 =?utf-8?B?VW8vOXFDNEV4MjR0MWN2TWFaNHlZRW5vd1lycXlVVml5MWNHUVFPNnMvMVJN?=
 =?utf-8?B?K1EvS1YyQmZyaEx1RUdoUUhQR1p6QVVURVVJSjZGM3lOUTZteW5NdU1sQXZt?=
 =?utf-8?B?WVI1aUpLeldyWlV2a3JVYmQzd0VDeFVVSVdIUmkzalR2ZXdOeVBQVGFQTGZI?=
 =?utf-8?B?Yk4rTG9KdnNYRlBvdmY3Si92SzNEOTNPa0dFZ2gydlhrbkRqVmUxZ3MvZjJS?=
 =?utf-8?B?YXluS1RnZjQybWxzL1Y2WHU5UCt1cXJxRENDRXd0ZWxmOFM4NmJlbUYvc2xo?=
 =?utf-8?B?enMrOGJMQ3licmplZzNoV1VBMFp5em84U2ZTSytNbXk1aUsybnp5ZU5TL1V6?=
 =?utf-8?B?MTl3VDZlVWI0L01sQTVXRW9jbCtMZmdUWlZaTWRBWDhsNEVGQWZSRlJmTU5T?=
 =?utf-8?B?Y3UxdHMvd2xCMzZja3pObmNVN1JSaklHNCt5VDlwc2EyQUExa1ZWMHh0ejFH?=
 =?utf-8?B?RXVLbDRwR3ZubWZtV0ZLUDFhRCswR1pOb2ZkbWpzOXE1S0crSjQ2VVlpYU5N?=
 =?utf-8?B?VG00K243OEN5Sjh0dEt6UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDlJNldSSEUzTGFaMFlSakpuWUhCKzQ0dnhUaFhGWmkvUjdNTmhwODViSnVP?=
 =?utf-8?B?WXpCMlJRTml2cUExb29jaDV2dTV5eEVaNWtmdUdVOVlwZ0J4NnMvODVtQ01k?=
 =?utf-8?B?cVAxZ0NqN0VNL0VRTWxKd05WMytqRWFlUHU1MmFadGF3NWNISlEwWUNtYUVq?=
 =?utf-8?B?R1dnYWNvTTRJenBOa0hJN1dwRTQvd1RJL0RWVFVyQ09ZU1ptczFMUjdVVElM?=
 =?utf-8?B?OHZVYkpSb3BlUlU2eDNaenNhVy9CVlRjY0dwNlFoR2s3M0grcmVXTWxueWJV?=
 =?utf-8?B?VllDc1crL3IrZlYvMDdjdHE4RmpCZ2s3SnJtdXZwS3NFWkxBMkoxRnljS0ww?=
 =?utf-8?B?dXpEMjFueTlrSkhNeGtLRlU3c2tqdEd3RDlZdVlHKzlxUTdPc2pRZnBBQTli?=
 =?utf-8?B?MUNOeDlzY3EwRUJLeTM0NTB1OENJKzRybmE4Y2VhRGM2Y1Vld2tRdWVOWXpp?=
 =?utf-8?B?QTh2YmQ2RlhCbWhtSi9NMWhCTGJTYkRxenl1c3psbi9acERRYmlXVzNmY3c4?=
 =?utf-8?B?d1h1MndEUEtiV0NZejd6MnNMNVVTZTh4c0tWN2piaUNCTjlPUXp5ODRHckMz?=
 =?utf-8?B?UHFncWY3WXBTWEsxUFBpd1czRmQxclZzVDFFVHNFRDNJOXJVZGF3RzU5am5p?=
 =?utf-8?B?ZnlFUWdweFhmb2h0blAxWGlWV0ZTM1RScjQ2T04wS3NsSTNTYkh6YVN3TzRq?=
 =?utf-8?B?cTY4bUllaEpQeDd0QkR1WHMwdDBzZ1laLzhIeGFqSlFjeDNwYm13dWJ3V3Nk?=
 =?utf-8?B?NWhZSng2cTBNSDlkd0ZkYnZGU2VQTy9mZklQTlpwM2xsMks1dHlJbmNya3hG?=
 =?utf-8?B?UW1jbDMzTUZwTjVyRC8wQjBrR0dyZXNWSENQdnlVbnJlOFVzdjVqUkNTd0k1?=
 =?utf-8?B?aGVUSG5WcERudEZ2VjFBUlo1NHBpMXdNRlI2RFZPaCtwYXhiWmpiUnBvQU9h?=
 =?utf-8?B?RVBRa1RCS0NLUURuTTNrYkxkVS8xOVRGeXNLaUt1VWRPT3MzbXZiaHkrNk5o?=
 =?utf-8?B?M1JDOUszcEdOc0ljOVNPRWREWUJLYzZ2d3dHSEhDTjI4RHdZa0ZLbXVnaklB?=
 =?utf-8?B?dXJkVnZYNlJPNzRQTlRBZTBzT0RoK1lJZDFYckNHMnZ1cWdCMWdROEZzdjhF?=
 =?utf-8?B?SW1KZThKUUtxNWJnK2tQYlRNL3NuR2NpSkZycVc4TWhoWjJmT0NNNTIyaHl0?=
 =?utf-8?B?VFdBVFB5YzhoYTYwcEUyNGxUWXRDbmo1VTdONlRkR1pxeVp1Qmo1Vm4rdDBo?=
 =?utf-8?B?YWkzcVppVWVRWWZCRWx1ajVYS3hzRmFYZ3k2S29Pek5oSDlWSEpuaHZ4MHJh?=
 =?utf-8?B?WkhpV3gzaFg1ZkoyY2tkdDhFYTMvRnNUN0xPR3V3MFdMeEgvZmlRQklZME43?=
 =?utf-8?B?MjlMeXg3TS9uZ0JtNzJzR2lNWGRMMFZPeGluY3g5UmdQUVdneEVDTElCZEda?=
 =?utf-8?B?SXFkdHFrWm5xSmJnSzJ1aTZCbXRCUkN4c2Y4a1RpcXVMeDFpREJ3OGwzUmE2?=
 =?utf-8?B?a2ZPNC8zbUlFYVNsYWdFeHNnU3FJbTQ0UTFhOHpsb2lobjBSOHZPMjY5bDI5?=
 =?utf-8?B?NWFSUnNDUlQ1NXBSSFg2cmdLMDViL3JlRnhSMERsTHdpanRIY1U4YnVxVjJw?=
 =?utf-8?B?T2pYNC9zZzZrM0cwVC80eVVXeDBmbUlSVG5qRU5JWEJoZ2M3UHNvVWtXZDlE?=
 =?utf-8?B?WlMxUTdRSm1BcHRCbmtxcS9yeFBQSENiZjFBK1pJRURzdExPbzFyYi9KS1ZR?=
 =?utf-8?B?TXJmZGJ5S1Q4TWtsR09XdDFOWUZKZGRGZURnRURUWTdmYm1TdHk1OVNndjl2?=
 =?utf-8?B?ZjJ3V1dRMks2SXhnWFBheHM0LzhtUGp2T3ZDVWRuTi9ISytpTTdKOVJsaTV1?=
 =?utf-8?B?c1ZIQklIRnVHdmptZUZsNjd0TDkzUEJIMVZTMHZRWXF5UjgxY1R1aUhkcUNN?=
 =?utf-8?B?VzNjdjNOd0dCZVpQaGFKeXZLV2ZFMWlDbzMrUkNIalZpRUxySWdGY09Vampt?=
 =?utf-8?B?bllGVUJ1NTV1MFlES2xzR2hvQ0lDWXA0SThGL2JqODFxYUUydGMrZk5POGtl?=
 =?utf-8?B?ZVFTRUZMRVBIdUMxMkJmbW9rS0NrMFlsZ0ZEcFZ3bllHQm9jV2p5c296T2J2?=
 =?utf-8?Q?EJycAuXJWAP8eeQwNu6699ED6?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f98df6-57f2-4660-6b52-08dc6aa3e7f7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 12:32:18.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFemjved0OWqGSZs+KTGo3FxU7sKf0mfjZeI0F4JFcf0Z5kOCS2xbef0NVghvOhAVHpmdCtiLsx6Bg7cT5PLDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7900

Add description for the SolidRun CN9130 SoM, and Clearfog Base / Pro
reference boards.

The SoM has been designed as a pin-compatible replacement for the older
Armada 388 based SoM. Therefore it supports the same boards and a
similar feature set.

Most notable upgrades:
- 4x Cortex-A72
- 10Gbps SFP
- Both eMMC and SD supported at the same time

The developer first supporting this product at SolidRun decided to use
different filenames for the DTBs: Armada 388 uses the full
"clearfog" string while cn9130 uses the abbreviation "cf".
This name is already hard-coded in pre-installed vendor u-boot and can
not be changed easily.

NOTICE IN CASE ANYBODY WANTS TO SELF-UPGRADE:
CN9130 SoM has a different footprint from Armada 388 SoM.
Components on the carrier board below the SoM may collide causing
damage, such as on Clearfog Base.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm64/boot/dts/marvell/Makefile           |   2 +
 arch/arm64/boot/dts/marvell/cn9130-cf-base.dts | 178 ++++++++++++
 arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts  | 375 +++++++++++++++++++++++++
 arch/arm64/boot/dts/marvell/cn9130-cf.dtsi     | 197 +++++++++++++
 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi | 160 +++++++++++
 5 files changed, 912 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 99b8cb3c49e1..019f2251d696 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -28,3 +28,5 @@ dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-A.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-B.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += ac5x-rd-carrier-cn9131.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += ac5-98dx35xx-rd.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-base.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-pro.dtb
diff --git a/arch/arm64/boot/dts/marvell/cn9130-cf-base.dts b/arch/arm64/boot/dts/marvell/cn9130-cf-base.dts
new file mode 100644
index 000000000000..788a5c302b17
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-cf-base.dts
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun CN9130 Clearfog Base.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+#include "cn9130.dtsi"
+#include "cn9130-sr-som.dtsi"
+#include "cn9130-cf.dtsi"
+
+/ {
+	model = "SolidRun CN9130 Clearfog Base";
+	compatible = "solidrun,cn9130-clearfog-base",
+		     "solidrun,cn9130-sr-som", "marvell,cn9130";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&rear_button_pins>;
+		pinctrl-names = "default";
+
+		button-0 {
+			/* The rear SW3 button */
+			label = "Rear Button";
+			gpios = <&cp0_gpio1 31 GPIO_ACTIVE_LOW>;
+			linux,can-disable;
+			linux,code = <BTN_0>;
+		};
+	};
+
+	rfkill-m2-gnss {
+		compatible = "rfkill-gpio";
+		label = "m.2 GNSS";
+		radio-type = "gps";
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&expander0 9 GPIO_ACTIVE_HIGH>;
+	};
+
+	/* M.2 is B-keyed, so w-disable is for WWAN */
+	rfkill-m2-wwan {
+		compatible = "rfkill-gpio";
+		label = "m.2 WWAN";
+		radio-type = "wwan";
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&expander0 8 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+/* SRDS #3 - SGMII 1GE */
+&cp0_eth1 {
+	phy = <&phy1>;
+	phys = <&cp0_comphy3 1>;
+	phy-mode = "sgmii";
+	status = "okay";
+};
+
+&cp0_eth2_phy {
+	/*
+	 * Configure LEDs default behaviour:
+	 * - LED[0]: link/activity: On/blink (green)
+	 * - LED[1]: link is 100/1000Mbps: On (yellow)
+	 * - LED[2]: high impedance (floating)
+	 */
+	marvell,reg-init = <3 16 0xf000 0x0a61>;
+
+	leds {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			reg = <0>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WAN;
+			default-state = "keep";
+		};
+
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_WAN;
+			default-state = "keep";
+		};
+	};
+};
+
+&cp0_gpio1 {
+	sim-select-hog {
+		gpio-hog;
+		gpios = <27 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "sim-select";
+	};
+};
+
+&cp0_mdio {
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+		/*
+		 * Configure LEDs default behaviour:
+		 * - LED[0]: link/activity: On/blink (green)
+		 * - LED[1]: link is 100/1000Mbps: On (yellow)
+		 * - LED[2]: high impedance (floating)
+		 *
+		 * Configure LEDs electrical polarity
+		 * - on-state: low
+		 * - off-state: high (not hi-z, to avoid residual glow)
+		 */
+		marvell,reg-init = <3 16 0xf000 0x0a61>,
+				   <3 17 0x003f 0x000a>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+};
+
+&cp0_pinctrl {
+	pinctrl-0 = <&sim_select_pins>;
+	pintrl-names = "default";
+
+	rear_button_pins: cp0-rear-button-pins {
+		marvell,pins = "mpp31";
+		marvell,function = "gpio";
+	};
+
+	sim_select_pins: cp0-sim-select-pins {
+		marvell,pins = "mpp27";
+		marvell,function = "gpio";
+	};
+};
+
+/*
+ * SRDS #4 - USB 3.0 host on M.2 connector
+ * USB-2.0 Host on Type-A connector
+ */
+&cp0_usb3_1 {
+	phys = <&cp0_comphy4 1>, <&cp0_utmi1>;
+	phy-names = "comphy", "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&expander0 {
+	m2-full-card-power-off-hog {
+		gpio-hog;
+		gpios = <2 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+
+	m2-reset-hog {
+		gpio-hog;
+		gpios = <10 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-reset";
+	};
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts b/arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts
new file mode 100644
index 000000000000..a27fe0042867
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun CN9130 Clearfog Pro.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+#include "cn9130.dtsi"
+#include "cn9130-sr-som.dtsi"
+#include "cn9130-cf.dtsi"
+
+/ {
+	model = "SolidRun CN9130 Clearfog Pro";
+	compatible = "solidrun,cn9130-clearfog-pro",
+		     "solidrun,cn9130-sr-som", "marvell,cn9130";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&rear_button_pins>;
+		pinctrl-names = "default";
+
+		button-0 {
+			/* The rear SW3 button */
+			label = "Rear Button";
+			gpios = <&cp0_gpio2 0 GPIO_ACTIVE_LOW>;
+			linux,can-disable;
+			linux,code = <BTN_0>;
+		};
+	};
+};
+
+/* SRDS #3 - SGMII 1GE to L2 switch */
+&cp0_eth1 {
+	phys = <&cp0_comphy3 1>;
+	phy-mode = "sgmii";
+	status = "okay";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+&cp0_eth2_phy {
+	/*
+	 * Configure LEDs default behaviour similar to switch ports:
+	 * - LED[0]: link/activity: On/blink (green)
+	 * - LED[1]: link is 100/1000Mbps: On (red)
+	 * - LED[2]: high impedance (floating)
+	 *
+	 * Switch port defaults:
+	 * - LED0: link/activity: On/blink (green)
+	 * - LED1: link is 1000Mbps: On (red)
+	 *
+	 * Identical configuration is impossible with hardware offload.
+	 */
+	marvell,reg-init = <3 16 0xf000 0x0a61>;
+
+	leds {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			reg = <0>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WAN;
+			label = "LED2";
+			default-state = "keep";
+		};
+
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_WAN;
+			label = "LED1";
+			default-state = "keep";
+		};
+	};
+};
+
+&cp0_mdio {
+	ethernet-switch@4 {
+		compatible = "marvell,mv88e6085";
+		reg = <4>;
+		pinctrl-0 = <&dsa_clk_pins &dsa_pins>;
+		pinctrl-names = "default";
+		reset-gpios = <&cp0_gpio1 27 GPIO_ACTIVE_LOW>;
+		interrupt-parent = <&cp0_gpio1>;
+		interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ethernet-port@0 {
+				reg = <0>;
+				label = "lan5";
+				phy = <&switch0phy0>;
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						label = "LED12";
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_RED>;
+						function = LED_FUNCTION_LAN;
+						label = "LED11";
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@1 {
+				reg = <1>;
+				label = "lan4";
+				phy = <&switch0phy1>;
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						label = "LED10";
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_RED>;
+						function = LED_FUNCTION_LAN;
+						label = "LED9";
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@2 {
+				reg = <2>;
+				label = "lan3";
+				phy = <&switch0phy2>;
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						label = "LED8";
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_RED>;
+						function = LED_FUNCTION_LAN;
+						label = "LED7";
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@3 {
+				reg = <3>;
+				label = "lan2";
+				phy = <&switch0phy3>;
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						label = "LED6";
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_RED>;
+						function = LED_FUNCTION_LAN;
+						label = "LED5";
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@4 {
+				reg = <4>;
+				label = "lan1";
+				phy = <&switch0phy4>;
+
+				leds {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					led@0 {
+						reg = <0>;
+						color = <LED_COLOR_ID_GREEN>;
+						function = LED_FUNCTION_LAN;
+						label = "LED4";
+						default-state = "keep";
+					};
+
+					led@1 {
+						reg = <1>;
+						color = <LED_COLOR_ID_RED>;
+						function = LED_FUNCTION_LAN;
+						label = "LED3";
+						default-state = "keep";
+					};
+				};
+			};
+
+			ethernet-port@5 {
+				reg = <5>;
+				label = "cpu";
+				ethernet = <&cp0_eth1>;
+				phy-mode = "sgmii";
+
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+
+			ethernet-port@6 {
+				reg = <6>;
+				label = "lan6";
+				phy-mode = "rgmii";
+
+				/*
+				 * Because of mdio address conflict the
+				 * external phy is not readable.
+				 * Force a fixed link instead.
+				 */
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+		};
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			switch0phy0: ethernet-phy@0 {
+				reg = <0x0>;
+			};
+
+			switch0phy1: ethernet-phy@1 {
+				reg = <0x1>;
+				/*
+				 * Indirectly configure default behaviour
+				 * for port lan6 leds behind external phy.
+				 * Internal PHYs are not using page 3,
+				 * therefore writing to it is safe.
+				 */
+				marvell,reg-init = <3 16 0xf000 0x0a61>;
+			};
+
+			switch0phy2: ethernet-phy@2 {
+				reg = <0x2>;
+			};
+
+			switch0phy3: ethernet-phy@3 {
+				reg = <0x3>;
+			};
+
+			switch0phy4: ethernet-phy@4 {
+				reg = <0x4>;
+			};
+		};
+
+		/*
+		 * There is an external phy on the switch mdio bus.
+		 * Because its mdio address collides with internal phys,
+		 * it is not readable.
+		 *
+		 * mdio-external {
+		 *	compatible = "marvell,mv88e6xxx-mdio-external";
+		 *	#address-cells = <1>;
+		 *	#size-cells = <0>;
+		 *
+		 *	ethernet-phy@1 {
+		 *		reg = <0x1>;
+		 *	};
+		 * };
+		 */
+	};
+};
+
+/* SRDS #4 - miniPCIe (CON2) */
+&cp0_pcie1 {
+	num-lanes = <1>;
+	phys = <&cp0_comphy4 1>;
+	/* dw-pcie inverts internally */
+	reset-gpios = <&expander0 2 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&cp0_pinctrl {
+	dsa_clk_pins: cp0-dsa-clk-pins {
+		marvell,pins = "mpp40";
+		marvell,function = "synce1";
+	};
+
+	dsa_pins: cp0-dsa-pins {
+		marvell,pins = "mpp27", "mpp29";
+		marvell,function = "gpio";
+	};
+
+	rear_button_pins: cp0-rear-button-pins {
+		marvell,pins = "mpp32";
+		marvell,function = "gpio";
+	};
+
+	cp0_spi1_cs1_pins: cp0-spi1-cs1-pins {
+		marvell,pins = "mpp12";
+		marvell,function = "spi1";
+	};
+};
+
+&cp0_spi1 {
+	/* add pin for chip-select 1 on mikrobus */
+	pinctrl-0 = <&cp0_spi1_pins &cp0_spi1_cs1_pins>;
+};
+
+/* USB-2.0 Host on Type-A connector */
+&cp0_usb3_1 {
+	phys = <&cp0_utmi1>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&expander0 {
+	/* CON2 */
+	pcie1-0-clkreq-hog {
+		gpio-hog;
+		gpios = <4 GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "pcie1.0-clkreq";
+	};
+
+	/* CON2 */
+	pcie1-0-w-disable-hog {
+		gpio-hog;
+		gpios = <7 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "pcie1.0-w-disable";
+	};
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi b/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
new file mode 100644
index 000000000000..0a0ba2fce537
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for common base of SolidRun CN9130 Clearfog Base and Pro.
+ *
+ */
+
+/ {
+	aliases {
+		/* label nics same order as armada 388 clearfog */
+		ethernet0 = &cp0_eth2;
+		ethernet1 = &cp0_eth1;
+		ethernet2 = &cp0_eth0;
+		i2c1 = &cp0_i2c1;
+		mmc1 = &cp0_sdhci0;
+	};
+
+	reg_usb3_vbus0: regulator-usb3-vbus0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&expander0 6 GPIO_ACTIVE_LOW>;
+	};
+
+	sfp: sfp {
+		compatible = "sff,sfp";
+		i2c-bus = <&cp0_i2c1>;
+		los-gpios = <&expander0 12 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&expander0 15 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&expander0 14 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&expander0 13 GPIO_ACTIVE_HIGH>;
+		maximum-power-milliwatt = <2000>;
+	};
+};
+
+/* SRDS #2 - SFP+ 10GE */
+&cp0_eth0 {
+	managed = "in-band-status";
+	phys = <&cp0_comphy2 0>;
+	phy-mode = "10gbase-r";
+	sfp = <&sfp>;
+	status = "okay";
+};
+
+&cp0_i2c0 {
+	expander0: gpio-expander@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		pinctrl-0 = <&expander0_pins>;
+		pinctrl-names = "default";
+		interrupt-parent = <&cp0_gpio1>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+
+		/* CON3 */
+		pcie2-0-clkreq-hog {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "pcie2.0-clkreq";
+		};
+
+		/* CON3 */
+		pcie2-0-w-disable-hog {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "pcie2.0-w-disable";
+		};
+
+		usb3-ilimit-hog {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "usb3-current-limit";
+		};
+
+		m2-devslp-hog {
+			gpio-hog;
+			gpios = <11 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "m.2 devslp";
+		};
+	};
+
+	/* The MCP3021 supports standard and fast modes */
+	adc@4c {
+		compatible = "microchip,mcp3021";
+		reg = <0x4c>;
+	};
+
+	carrier_eeprom: eeprom@52 {
+		compatible = "atmel,24c02";
+		reg = <0x52>;
+		pagesize = <8>;
+	};
+};
+
+&cp0_i2c1 {
+	/*
+	 * Routed to SFP, M.2, mikrobus, and miniPCIe
+	 * SFP limits this to 100kHz, and requires an AT24C01A/02/04 with
+	 *  address pins tied low, which takes addresses 0x50 and 0x51.
+	 * Mikrobus doesn't specify beyond an I2C bus being present.
+	 * PCIe uses ARP to assign addresses, or 0x63-0x64.
+	 */
+	clock-frequency = <100000>;
+	pinctrl-0 = <&cp0_i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+/* SRDS #5 - miniPCIe (CON3) */
+&cp0_pcie2 {
+	num-lanes = <1>;
+	phys = <&cp0_comphy5 2>;
+	/* dw-pcie inverts internally */
+	reset-gpios = <&expander0 1 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&cp0_pinctrl {
+	cp0_i2c1_pins: cp0-i2c1-pins {
+		marvell,pins = "mpp35", "mpp36";
+		marvell,function = "i2c1";
+	};
+
+	cp0_mmc0_pins: cp0-mmc0-pins {
+		marvell,pins = "mpp43", "mpp56", "mpp57", "mpp58",
+			       "mpp59", "mpp60", "mpp61";
+		marvell,function = "sdio";
+	};
+
+	mikro_spi_pins: cp0-spi1-cs1-pins {
+		marvell,pins = "mpp12";
+		marvell,function = "spi1";
+	};
+
+	mikro_uart_pins: cp0-uart-pins {
+		marvell,pins = "mpp2", "mpp3";
+		marvell,function = "uart1";
+	};
+
+	expander0_pins: cp0-expander0-pins {
+		marvell,pins = "mpp4";
+		marvell,function = "gpio";
+	};
+};
+
+/* SRDS #0 - SATA on M.2 connector */
+&cp0_sata0 {
+	phys = <&cp0_comphy0 1>;
+	status = "okay";
+
+	/* only port 1 is available */
+	/delete-node/ sata-port@0;
+};
+
+/* microSD */
+&cp0_sdhci0 {
+	pinctrl-0 = <&cp0_mmc0_pins>;
+	pinctrl-names = "default";
+	bus-width = <4>;
+	no-1-8-v;
+	status = "okay";
+};
+
+&cp0_spi1 {
+	/* CS1 for mikrobus */
+	pinctrl-0 = <&cp0_spi1_pins &mikro_spi_pins>;
+};
+
+/*
+ * SRDS #1 - USB-3.0 Host on Type-A connector
+ * USB-2.0 Host on mPCI-e connector (CON3)
+ */
+&cp0_usb3_0 {
+	phys = <&cp0_comphy1 0>, <&cp0_utmi0>;
+	phy-names = "comphy", "utmi";
+	vbus-supply = <&reg_usb3_vbus0>;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp0_utmi {
+	status = "okay";
+};
+
+/* mikrobus uart */
+&cp0_uart0 {
+	pinctrl-0 = <&mikro_uart_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi b/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
new file mode 100644
index 000000000000..8f0238a45a58
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "SolidRun CN9130 SoM";
+	compatible = "solidrun,cn9130-sr-som", "marvell,cn9130";
+
+	aliases {
+		ethernet0 = &cp0_eth0;
+		ethernet1 = &cp0_eth1;
+		ethernet2 = &cp0_eth2;
+		i2c0 = &cp0_i2c0;
+		mmc0 = &ap_sdhci0;
+		rtc0 = &cp0_rtc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	v_1_8: regulator-1-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	/* requires assembly of R9307 */
+	vhv: regulator-vhv-1-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vhv-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		pinctrl-0 = <&cp0_reg_vhv_pins>;
+		pinctrl-names = "default";
+		gpio = <&cp0_gpio2 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&ap_pinctrl {
+	ap_mmc0_pins: ap-mmc0-pins {
+		marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3", "mpp4", "mpp5",
+					   "mpp6", "mpp7", "mpp8", "mpp9", "mpp10", "mpp12";
+		marvell,function = "sdio";
+		/*
+		 * mpp12 is emmc reset, function should be sdio (hw_rst),
+		 * but pinctrl-mvebu does not support this.
+		 *
+		 * From pinctrl-mvebu.h:
+		 * "The name will be used to switch to this setting in DT description, e.g.
+		 * marvell,function = "uart2". subname is only for debugging purposes."
+		 */
+	};
+};
+
+&ap_sdhci0 {
+	bus-width = <8>;
+	pinctrl-0 = <&ap_mmc0_pins>;
+	pinctrl-names = "default";
+	vqmmc-supply = <&v_1_8>;
+	status = "okay";
+};
+
+&cp0_ethernet {
+	status = "okay";
+};
+
+/* for assembly with phy */
+&cp0_eth2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_eth2_pins>;
+	phy-mode = "rgmii-id";
+	phy = <&cp0_eth2_phy>;
+	status = "okay";
+};
+
+&cp0_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_i2c0_pins>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	som_eeprom: eeprom@53 {
+		compatible = "atmel,24c02";
+		reg = <0x53>;
+		pagesize = <8>;
+	};
+};
+
+&cp0_mdio {
+	pinctrl-0 = <&cp0_mdio_pins>;
+	status = "okay";
+
+	/* assembly option */
+	cp0_eth2_phy: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&cp0_spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cp0_spi1_pins>;
+	/* max speed limited by a mux */
+	spi-max-frequency = <1800000000>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		/* read command supports max. 50MHz */
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&cp0_syscon0 {
+	cp0_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+
+		cp0_eth2_pins: cp0-ge2-rgmii-pins {
+			marvell,pins = "mpp44", "mpp45", "mpp46", "mpp47",
+				       "mpp48", "mpp49", "mpp50", "mpp51",
+				       "mpp52", "mpp53", "mpp54", "mpp55";
+			/* docs call it "ge2", but cp110-pinctrl "ge1" */
+			marvell,function = "ge1";
+		};
+
+		cp0_i2c0_pins: cp0-i2c0-pins {
+			marvell,pins = "mpp37", "mpp38";
+			marvell,function = "i2c0";
+		};
+
+		cp0_mdio_pins: cp0-mdio-pins {
+			marvell,pins = "mpp40", "mpp41";
+			marvell,function = "ge";
+		};
+
+		cp0_spi1_pins: cp0-spi1-pins {
+			marvell,pins = "mpp13", "mpp14", "mpp15", "mpp16";
+			marvell,function = "spi1";
+		};
+
+		cp0_reg_vhv_pins: cp0-reg-vhv-pins {
+			marvell,pins = "mpp41";
+			marvell,function = "gpio";
+		};
+	};
+};
+
+/* AP default console */
+&uart0 {
+	pinctrl-0 = <&uart0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};

-- 
2.35.3


