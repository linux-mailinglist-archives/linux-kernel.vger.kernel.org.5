Return-Path: <linux-kernel+bounces-79444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93F2862255
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 03:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE681F249FF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19F510A3F;
	Sat, 24 Feb 2024 02:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="JRc8AP9Q"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2135.outbound.protection.outlook.com [40.107.247.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE8810F9;
	Sat, 24 Feb 2024 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708742061; cv=fail; b=PKaT3Vbi0BJqGkncjl+fDcbSm59CMMOdMOzHZkloNO8vCTpIucNd1WDoPFt9gO5C3MvS8vrYnwhtRnlGo2Am/jGVdZlQMjBHrrUZC+R0poZFCGaMM7EhoRm8SDOoSfhQogsFK8+Ct7uc7DpBdgmFjEiebSSlHV77eyw12HeozE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708742061; c=relaxed/simple;
	bh=IrTkp5FpSWsw9dkTAfubnWErGibdMzilISx061XcrSg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sF0p9fKeIChdyeTlFom+menG+CuV9waXeuaImV2LD9wd6sZzJbu9evRcUDPG8Zv1SdLHBvgBqmcykxRXE6Zfr5yEqMqieWjLlpbHFDeqCW4jV/wA0DRivAN5dYX5NcESPbD0T0qlbN7C7yEz9sKM6jTnYLyWn9sS0p5fXkUJqJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=JRc8AP9Q; arc=fail smtp.client-ip=40.107.247.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bear15xy8jhPzCelWpuUneApOElaADKAlmbQFKmZrwZlmITfStk5Zn/WXQ3zP49kM9G4X0OK2zBE+8lqBkFDqgWzczYCaIuQuI7hLazwg0NJU7/OI4EAekvxJcv+ymXYe196vO9EbfbcpqoTgCAMbCYqEvUeQLITVabnc4s6KVnMYNa7Pvk5t9rmxjy4np7mNXqInrQcpyCcKV90UiK/yn+zyADdFO4CH+BdO1l1vg+RdDAluFjXM3kVMFeCOYlfpDkvmiaIisvbeIbBcY2Th350vwf8L4yQWRbnmzGPgN61OpAXDoDOhhIMevKU4rhDOIINshUxoM3ivD6N2DFj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZRv1VSIOE24ocfGlDfv1sU6K+G+ZyXSMGt7VmXDCYE=;
 b=gWjilfvOuUK/LLTsNYzpePa0pbgfuyyqmBdvLqoySwpIotmyxq/0oV84QIqScKohkiIaUryhQlAnzhXBfqN5J/GJZ3JQppxTf+FoDZxU5yZKqN1TIZE3TNar/cHge1HIUReeGKrmH7DM2C/WdehX/YrPIxo9z57ZZcyP06bKm58gJGm767h0/kJQUPPErreWsWku/5np59818m0X9RrgaUBy+rSAsXTMqe0pXC5obAlCeiApzUC7QPeGnuEG9DucnE/Ac83hY8cCw1vYAb7FiK1w2k6SIK8KfQ52fhdQuk2ZSAZJDuSVmMTgIacZnOLgV5tzBWEY6QhEVwoYrKEwxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZRv1VSIOE24ocfGlDfv1sU6K+G+ZyXSMGt7VmXDCYE=;
 b=JRc8AP9Qg4KTLHU4DhcJc1HsJSbz50uRLhKVyjPFr6dImVLFDbQNPv3m3nRTZzALmBsYCDxusXKQ5oCkL46f7UFI5KpeZmYf7zF88tHBh5t2hiCG7dffe+hcqBuzl0Wt1MI78rV2FyiMJAdh8Ns+W4Xy2MeZfCbWkeGxaYY9QxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM8P193MB0849.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Sat, 24 Feb
 2024 02:34:16 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::83c6:a213:7935:ae6f]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::83c6:a213:7935:ae6f%4]) with mapi id 15.20.7316.023; Sat, 24 Feb 2024
 02:34:15 +0000
Message-ID: <75642d53-9daa-4be7-8d3d-d1d86bc60b3e@kunbus.com>
Date: Sat, 24 Feb 2024 03:34:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
Content-Language: en-US
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 Alexander Steffen <Alexander.Steffen@infineon.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Sasha Levin <sashal@kernel.org>, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
 Kanth Ghatraju <kanth.ghatraju@oracle.com>, Peter Huewe <peterhuewe@gmx.de>
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
 <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
 <91f600ef-867b-4523-89be-1c0ba34f8a4c@kunbus.com>
 <8692fcf6-2e67-45b4-b809-7723f30736a2@apertussolutions.com>
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <8692fcf6-2e67-45b4-b809-7723f30736a2@apertussolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::22) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AM8P193MB0849:EE_
X-MS-Office365-Filtering-Correlation-Id: 37edcf07-85fc-4b0a-1d0e-08dc34e117bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cjmgTaEIeDZWyhucsjHj+TGcC7ADkc8+5QyH3SYFBlZVvwbOtsozSrsTo4UoFPKoPZuwNbWDZNdm5vdI/jgtWfSHh1yWEP43lIgDsj/U6qkL5HW3eJ92oM+Ip/dG/Rl8V7/Qg11aO9hEMtXzh59yFFjInaMNJojLvyiHeedlPVh1WxSjlPvEhTf3tT51/mMP6B3JsA9qAf2VwtvmJM+H73h+olkArJcZRaE2AnVQot3X6o3rtwun5wH0qlS9bFczI1rAUjU29qMvTcPh2rAt1U6vVJNdm2jz44jXXqdV7MxZcZWRZOkMRhxEPILXnIJwbDzgnGz9GkZnzStkWIMEwInVehONfPkcGMu5AtMA5PIuK1N1Rsf53hJaEgEfpvEBuUo8pdq1qzlcElL3cA0qzC+IdW5ZpGqy9HBEHOozaUC1JAFG4th25XJBTmRvdTac3SMUpptgKIWlBZH8QpmWTL0eL29PrXv8t8YloQxwzzi2k0KSK3CCQnO7YUw+Xu+i2T5AZonogHQUaptu0wvbXfzQVSytMTbPmeN0CQ8z8O4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEhhMXNVak02Q0NSRkQzQWY1L09BaGRSdklVcHQ5S2gxOWwyU2d2S2VBZy94?=
 =?utf-8?B?NFpPd2QvdWMrOHZIdzdaSllNRHZFRndOZ3lBV3ZxODhwNEJBdlcxTFcyY2dM?=
 =?utf-8?B?aTZ3cHFPeE5ML3cyS01WNEpJTk5jM1ZsenUybVZSZ2tuVFMzR1pBQ2NHNGV0?=
 =?utf-8?B?dENiQU5zaEJTeXh5M2x3L0tMWU1hWHZGWGVXdHRyTzFHZldhRGpJeEVJbGdD?=
 =?utf-8?B?RllLUUJlWWI3VHZHakJIak0rMlNXZ0VEZXVYbHFPTXNZcEhod3JUYjdCZzB2?=
 =?utf-8?B?Si9xTk1VSUxHNkZKc083cEl2RFFpVlpWQloyRzJGS1g5bmxCellwUUxyUXg5?=
 =?utf-8?B?WDNxS3o1aTZSTFY2OHNuaVBKQ240QjJTb044dGQrOVVOUnBvd1dZb2I2c2VM?=
 =?utf-8?B?L1VSeXZPclFlaEc3U0VzL2JlNmM1a0pwbE45WTBQRDc1MDNHK3QvVjNXRytv?=
 =?utf-8?B?eDNsdnpoK0E4c3JEUURrTm1mdkJxUUJRcTRsdjF6QlNiMTVJbmpmNVU5UXh4?=
 =?utf-8?B?MjZacmc1bkNqVjJnY1VsZnBPOGtaU202Q2ZJT2o2aGhRVUFQM3JWd3dBRnM3?=
 =?utf-8?B?YjA0bDZ3U2tOQjNrUWJDcS8xSWRMOEY2ZjQ5dlAvSlZwNGx6YlR4WW1ERjJL?=
 =?utf-8?B?UjdzTXJhTytKNW5zVW5RRi94Yk1mTmU0OXlkdjV4U3R5WnJyTml5YjY3Ymk2?=
 =?utf-8?B?OE91eUNlTFp2ajROSnZGb3VBdTZFaTJhWk5sd0ZHRDRuNXIrMzJaRVFVZDdh?=
 =?utf-8?B?S0VIalV1VHRZOHJtL2ZPR3R5UlV2WmFBYnBjclY5UGN4Lzg0MERndlZETG9P?=
 =?utf-8?B?Q1hBQzZ3VkFVdTIveFhVVjY2bnplSks0QTFwQi83ZDhrYnZIZUYyNWpQZ1Zy?=
 =?utf-8?B?SHE1YktOcU9oZU5LMGUvTTNYZkhkTk9aZk5ZbUpEMUZnY2NzS0x4Mm5rSzF0?=
 =?utf-8?B?ZzZZc0lXQ0NFK3VBUnA5UDRCWUNoMUdDazFrdGhudEs0eWpWUGhOUnVEVzFv?=
 =?utf-8?B?bUFoYk5zM1VPalNRMFNHejdtNmQ5dmVsbkozUlE0eHY0bmNVcklITlc5T1ZG?=
 =?utf-8?B?WVlQS0RKSkNDQksvSTNEZllobm0ySmliaXFMNXhNNHpBemJjWmxiTlJ6Q2RR?=
 =?utf-8?B?WWxqRzMxWmRCZHRycTM2S1R6bjJPR3BrU2MxdTk3c2didUZVaDd3M25xYkpN?=
 =?utf-8?B?d2xWVUwwdWVCbTFoTEhqNG5USHcxbmFZaHlyMnFZZDAxaitXK215Y1RBWFpU?=
 =?utf-8?B?UmpNVUpYRUgwc3d5Vzk4Z3NweFNJTXc0SkRab0djL2ViakFjTGg0YmV6d0lO?=
 =?utf-8?B?eUVRRmw0dXUrSy94b2tQOWYyVk9NMU9Fc0wwcFZBZnlmTUpjdmoyb2pHRzhi?=
 =?utf-8?B?blpLbExvT29pdW5ud1E4R2tRand5R05EMUdpeDFseTdzOGFvU3EzWE81MnZr?=
 =?utf-8?B?aFA1QXcrWXE0K2FLTUtQWDhnUWRONHhDVkFMRFhmMTlha2g2aFlaUjZsaUtE?=
 =?utf-8?B?elJyQjhRdXMxUkp2UERLaHl6M25KcTIwNlFtV0pDUTJuNHRObFp0a01QUFFJ?=
 =?utf-8?B?OHNqb0xIWDdWTmt1ZXB1emdjMGQ3QUpLV0hLVTFPMDR3ekxLZE9MSDc3RnhX?=
 =?utf-8?B?THNPbDFPcFhhdFZadE5CT3p1bVE0SHJxMWxzaGF0L1YrTEIyNy80Sm5ML0tN?=
 =?utf-8?B?N2VoQzhhc2pzWmh1bnMySnRzaDk0Zk9QZElyd2hMdlZ4WWwrWGpWNE1HVkxt?=
 =?utf-8?B?UTU3eU5oRXFMNGlSUFNtOVZPeU9HcXg4TVRpU3VPUXdvYzZoNGhud0hncVdk?=
 =?utf-8?B?aHdjK08zTlpiUFpYOWZzWFEwUHZVb0hJakhOUlJzY1JQUTRpcmVHaHQwdjJs?=
 =?utf-8?B?M0ZXTnJsNVhYK1VIdnlVN0lYbzZOUERKaEdvV1ZVWkQwYWRVd3RhRC81Zkxz?=
 =?utf-8?B?Wlg0SFExUjVVc0hYY0ovTVVaN3dWbUhnWEVqMkJqdjVEd3l4WHMrdTd2SmQ3?=
 =?utf-8?B?WnJEeVUzcjU3WjNEUHZ1TkRySGtFUWpTVFlkYUE0OTRJakVJMnZMWllFQUlG?=
 =?utf-8?B?NnBLVHE4WDBQeDIyR1pvcUZGT1czQnEzNnQraVBuT0JENzYzbzdEazVBM0pa?=
 =?utf-8?B?a29ZdktEMXhkSU85NjA4cm8yRVFmdlIxb3NWUFNvOWpBakhmMU1ZQXcxZk5U?=
 =?utf-8?Q?4BnXnl73VtKiDAu+zU8LO6zWXH2dOZhWHZ6YYy0UkJn0?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37edcf07-85fc-4b0a-1d0e-08dc34e117bc
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 02:34:15.2386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Og2C39X1jRqEateGjZA5Ny45JwQ9NIDyqcR3T8V79i5ydtFYh/BDBVjrDPb5blKelYqYHNTeZ/j3EEtG8KaGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB0849



On 23.02.24 02:56, Daniel P. Smith wrote:

>>
>> Will the TPM TIS CORE ever (have to) request another locality than 0? Maybe the best would
>> be to hardcode TPM_ACCESS(0) and get rid of all the locality parameters that are
>> passed from one function to another.
>> But this is rather code optimization and not really required to fix the reported bug.
> 
> Actually, doing so will break the TPM API. The function
> tpm_tis_request_locality() is registered as the locality handler,
>  int (*request_locality)(struct tpm_chip *chip, int loc), in the tis
> instance of struct tpm_class_ops{}. This is the API used by the Secure
> Launch series to open Locality2 for the measurements it must record.
> 

I dont understand this. How do you use locality 2 with the current mainline
API? Do you adjust the mainline code to use locality 2 instead of 0? This would 
at least explain how you ran into the underflow issue which from
the source code seems to be impossible when using locality 0. But then I wonder why
this has not been made clear in this discussion. And then we are talking
about fixing a bug that does not even exist in the upstream code. 


BR,
Lino

