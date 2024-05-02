Return-Path: <linux-kernel+bounces-166742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C55F8B9ECC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9BB1F227EF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7257F16F90F;
	Thu,  2 May 2024 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="bkdon2rR"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2099.outbound.protection.outlook.com [40.107.7.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB57815E7EA;
	Thu,  2 May 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668193; cv=fail; b=hfE4if+s50dZOuuRAp0vJHbLQjwKk0OJ628xyIXuMKuu21y+ueeoPRti2/2yyHOKIMQLOPPYhfqM1zWwprsp1HL/GG4A2GmAF+Dq7LgDqJkys6FSe2tjr5ZzMqiWTGpF/nk0RAjqEHRDD6x67CffmMf94MWDvPAZA+T589iGsNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668193; c=relaxed/simple;
	bh=DZC2c2jmTtZf16u4qftt0bEAwzPg3KRutjfQmCTU7SU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FMvysjlK5VOEUDa0q7aDbc+OKxf609xZQI42GyN8mBUUK5jWMttHLYRviL5M9dm2DqEtOCZdSQfN7h+Je9FR/kCieTNvQSeqynK3hMZHF2UdxSuAgPgJCUaFdWEwlxkxdSnSDGvPCX460K4RvjYG+BDrVNuSeRNE/7ZQGaiXJew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=bkdon2rR; arc=fail smtp.client-ip=40.107.7.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjmzSl8aCcFbLoiuFisOL7Af5c5BjCirfz1P3ydkqm3RoMLf1pk9S+pG9paqvK7ZyRpNOaqhb6fFp0mSdbJ4aLQzFNXwBccJYg9u0bAJZXPhpc1D+Cl3hCBwUDYyhiqaVw9UlFj/QtFd/1VgK1MTUlizakfLRk2fSjbEeDZbev7+7u3+TLNv4u+0Ib8Cq9c3OjZhG/nyxpHhxcxRlm3S7O9q0Mm7y/7V0haSwe9gSHP4lJbYOS/AP98+V9CbAsrE+WcyN07XmThHz4kLBmQAovd4Vybx7r3IYsdkIJMTHbXl0Ve3pH1Ae1LZgaCl/mnIZD9jAv2LXiwT1dQyyRIQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zY0RN/t4D8OStKT0+Yc1zPDWR2/Do6ubaRCpiqkC2EY=;
 b=Ck+BnEfwsrokuWPXOM5cAodvLJDwdhXl1ha855nVYKETEZ/Y4dX1iDFRTA0b+q5/Yls8o2EAwMQA3epimVar1n8L1SyjeG4DJWd0oUYAL6ftfgWuE89UMlWOk7twiqpmZ94S0xuJB6xKgvnNu3DvPs2t04XtGlLBFzMnJO4e8Mb6QGl99iaON8EniN7Ik6Y+uhmCeVhI/4Uu9yxoASafFvK6MB49bwXnAZbbFZXQkpDyOJW+msrbNnUZh/pTxO/8oU2nVxDTIWbvo2emhuG/IbrL/6g+yyNapIESrmmXN4DNUL7NcfLMVrVbBN/Ghl8VbFQNAxfzAsi2vddL13IU+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zY0RN/t4D8OStKT0+Yc1zPDWR2/Do6ubaRCpiqkC2EY=;
 b=bkdon2rRxGnF9Jtxr2lGkaXsyumBvE8+Q+FNJ9sJw9Se7BkCxZYDT8vsC8r8eHIURFcDaUOi7ZQpfdDSWny+g87qehUeSptt0vVSs8bRgrsvlK3yRRobCZajs8cL7YovSAELXUgDvua8YaBDzgHMyEUohhuqkXuy/Ikddoy7XAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
 by AS8PR02MB10051.eurprd02.prod.outlook.com (2603:10a6:20b:639::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Thu, 2 May
 2024 16:43:03 +0000
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827]) by DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827%4]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 16:43:03 +0000
Message-ID: <00a0aa99-b33e-b3a4-594d-36685d138a05@axentia.se>
Date: Thu, 2 May 2024 18:43:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Supporting a Device with Switchable Current/Voltage Measurement
Content-Language: sv-SE
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: =?UTF-8?Q?Jo=c3=a3o_Paulo_Gon=c3=a7alves?=
 <jpaulo.silvagoncalves@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, joao.goncalves@toradex.com
References: <20240501233853.32y4ev7jvas5ahdz@joaog-nb>
 <20240502133623.0000463e@Huawei.com>
 <44f47927-52aa-5248-6ae4-21028076fd51@axentia.se>
 <ad190ae3-48d2-a5db-dd36-d52b1c4cf460@axentia.se>
 <20240502160938.00007691@Huawei.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <20240502160938.00007691@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0075.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::14) To DU0PR02MB8500.eurprd02.prod.outlook.com
 (2603:10a6:10:3e3::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB8500:EE_|AS8PR02MB10051:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c25bf5c-eb7b-448a-95d1-08dc6ac6ef62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b29kbGxGa2VFdkdqc0NOdGlaUkNOU3duRkRIYjd1c1NYYzlhSk1xakdMUXpv?=
 =?utf-8?B?TmE2MlRnZGY2S0d2Rmo0dFAxcXVDQk03Rit4cnNYdGZmRCtuUWtLeEcwamRj?=
 =?utf-8?B?R0JiU3R6RTF1b2tjTnM0RCtJR2t1TkUwa21laDBTSFM4NnpSdHB6bGs0TVYr?=
 =?utf-8?B?WXhpUnp1WkwwQVlRajZtcEtFYkNIaC9WdmZHRFRNRDRXSVIwdFhPTVBiOEla?=
 =?utf-8?B?MFFKMTdxODRVRHcrM0ZkZmx2NGppakFVaHUybEpWdTlzNFF1NHRORG43ZTAx?=
 =?utf-8?B?VHpuZm80VXNsOXU5ckJJR2F6a1FiMHNIQUlzUEpxRmtoK29teFNsakxRRUZo?=
 =?utf-8?B?MmlSTWJJbW96MkdYWUdjaUNScFVydC9UeW5FR1BieHFVRXR1R25pNFBvenBM?=
 =?utf-8?B?VHlvaGtyUlQ4WDNoTHBPMzVNbEZvU3YxU3o3ME1ybXZrbzNqNHJQT0hKVlhu?=
 =?utf-8?B?T0JnNEFIbTh2R0pDbm0vT01vbjhhNkdUWFp4L21QdmtLWEN3elkvVGw3VjlQ?=
 =?utf-8?B?c0FWckZFUTUrLzlBaGlNdFBhViswTmluQTU3WXY0ckFNcG9qaVhMYXlqSW9n?=
 =?utf-8?B?UUtoeWNjT0ZzcTUyTWVLZjBCS25QRHNhOC9GUlcvYjZTQSs0T3pHZHA4d2pz?=
 =?utf-8?B?cUZDdDBBbmtBWG1pQU1PbmdweURLcnc3UjJ1ZS9NY1VITmFQZEg4aHQzYnZT?=
 =?utf-8?B?R0Z5RlN5M2RzR3prRTJpTm9qN3kyaHl1aGVqTTlxNjNDWFRFZCtWc1A5VVVH?=
 =?utf-8?B?SEdJVkhyMndYam9XYXNtQUFTMjN5cWVHTFllcXlnZUNua2hBYUdGRHZLRGdy?=
 =?utf-8?B?NnpTNGpsRDl1YXNtMXBkVWUxUjZWUzBHdVl2NzJCV2dQSDNRV0JuUzMyZndB?=
 =?utf-8?B?NTBJM3FXc2JSbmUvZW84T0lRd29KSUpXUnl2WXY3ZGhqTTJFeVQ4bGVRaVQz?=
 =?utf-8?B?TVJ0NERqM2NrRmZZV2hQSEgyZVJvTTlQVUNvTDN1MC8yaWVQM0piWm4weHNw?=
 =?utf-8?B?TUYwWmNjRnZ6LzlIekRWOEdZL1lIOHhheGRFU2ZUdTRvQWpVM0ZjNjlFbThG?=
 =?utf-8?B?MWZsWHV6MXFzd1puRWJ3STJTTmNnZFRFVHZmbkxzb1FoakM0UGxRTk9FVjdq?=
 =?utf-8?B?UnRLU3JJWFphaDl1eEN2eWNRRGd5UW5RNElsTmlzUWhGV2t5QlVaZnAxN3FI?=
 =?utf-8?B?M08vWUlYckJQT3NsOVUrdDBNTUpQUmdCSGY1bGxmRVJjWWt6Njc4VGZzNXRj?=
 =?utf-8?B?dFhNYXdnRklwdlNtSERMYS9JUHREWU9DcXc5eXpRM1BzTGZJRXpNSzlDUUY4?=
 =?utf-8?B?VmFENlVsbG1zOVRWYmIwclduR0cyNm5TYWY4SUM0VElMMlVIVk01SGhKUEho?=
 =?utf-8?B?WGJpc2hkd3gxWmUrWGpVSkg5WWlnQkt2Z3F3b3ZiSVRJKzBXSlp4K0NPQ0Q3?=
 =?utf-8?B?b1RLN05LYWpaS2RsVzBCYVdCNWt5OXAyRUZzN3VNYnN5T3pxWDVmWUpVWksv?=
 =?utf-8?B?blh2a1pWUmlLN1Nyck53RC96UFpJeG9wYUNVcytUeXZZVWkzVlBQYS9rZ3dV?=
 =?utf-8?B?ZVliOUpZYThvSFNvWjlyWmJiT0E1VS9DVXNUUVVkNjlzNDkyS3BCTDRoMzVi?=
 =?utf-8?B?N1pZM285d3ZIR3EzYlhEK1hRWG82ZTBSUEJ5T3VaVkN2LzZVbmlBU0d6aDZi?=
 =?utf-8?B?dTFRS3RZSCtTYjVHa3NqbW4zVVZ0MnU3RjBtT3g4cnRWZ1h1TDJTYTVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB8500.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rmh4citjcXIvdkVyRGpuZHh5U2VtSG1LY3VlRFlHUW9Vbmp2RStZR0ZGKyth?=
 =?utf-8?B?NE5NOTY0T2JCZTh6UytIQStVYW01ODNVVmkyUDJBOEt2TVlvTEtUVmU0V1R4?=
 =?utf-8?B?NVlRSFFCcHBPOXFxeTQxdmhMak8wMDlBOE5IcG1uaHQzRkFoS052ZlpqdnBT?=
 =?utf-8?B?SlVXMmNHNWk2UE0xb3FOTXNGdTMybTBzVHpJQjg5MHBzcTR2YlhXc242a1Rp?=
 =?utf-8?B?MFFnZlZMSWI4UDRRZzhIcXFYdUJlR0FmRW9tbVUzT2MyNkttbEJ4SWdBZjhJ?=
 =?utf-8?B?SWYxSTR0MnZzNWdIR3oreXZVaUUralBxTUVSRFhvUm1rc0QwMmE3WVk1OEhi?=
 =?utf-8?B?MEFqbzJKTzRxY0liSVJ0Y0FLeFNWem1uN1NoNjhsTHMwVm5FeDBMbCtCbnFs?=
 =?utf-8?B?Y09veUdlTjNhbHIrMVJDUXk5OTVoQWhTdUlmU2J6eU9xS3dCTlBid1k2Ukxv?=
 =?utf-8?B?TWJLSmpYZEtkVzQzZWpBRnFmZEdrWFBpQ1Nvd0NldWtqRXNPbXBld2pJNXZI?=
 =?utf-8?B?ajhNeE12cEEvZ1VHQit3OG5jRGVWaGIvRlhSR0N2cFRuR3ArRFFyaE02aGp5?=
 =?utf-8?B?VVA3MGtnWjZKQkE5a0xSNmtMQkE0UDRhZHVnN3VvUVhJR3Y1c1Y2Uzk5dkNR?=
 =?utf-8?B?UDhJZlgwaUpuSVE1Y0VkaFFqUk1lWUJDQVRvOFpCYW14K1A4cUtTVEVIRzBp?=
 =?utf-8?B?V0h5ZlZPQXNqN0w2QVNKTHU0aG5reGUzbElJK0NRMzBUaTU3UXlkbzVGTjZZ?=
 =?utf-8?B?dWUrbVZjdzZ5NE9kT0NkRjBPYWY1azRmbmJpZWFpeVBpUlJvZW9XdmVxUUVq?=
 =?utf-8?B?MmpnRC96eEhCSzczVmdrQXZZd0ZyM1JlNnQyZE4rLyt3a0hWbG5nM1IvL0Ro?=
 =?utf-8?B?bTNGSHhTQy9QUHNReDFxdGMwcjNtRFBYcTBWalhZNGZITWFoRnZBaVp2cWYx?=
 =?utf-8?B?d3dZb3o1VlkxckQyVG9TOHMzNnRNKzRKU3NxUmJsZTVsVFNDTzdmNlp5Q0J5?=
 =?utf-8?B?UjluTHdWSWRqankzNUVLR1o4bWphMWtFaU53cjhJcmhIalkrdERncFZJbGRy?=
 =?utf-8?B?WnVnTFdvYzdwaEg4QTc4VUlYZXpmbGU3NENSb0hQb2c0WlNSVk0xT3k4SUE1?=
 =?utf-8?B?UFVEZ2ppWkhBVytSY3Z6b25Ednp3cE1xZGNJaGk3MFViVVZ0WUxYTkVqM09q?=
 =?utf-8?B?d01jTzZTc2JibzF0UDcxaTFCMTF6VHErOWtNdUZvSFFlM3JGNmtnbnpQK0ZD?=
 =?utf-8?B?L0kxU0cvVjJTZ0dXVjE2UE1BSEdvaGx5R1pJdDQxeit4cmovc09LZU9kZWpR?=
 =?utf-8?B?Mk9ISWh3cXI4QTcxbWUzQzEzWjF3ODk2NjR1dlgxdENFOWtXQ3NXN1FQRWNR?=
 =?utf-8?B?N3RJSGViNUJENklWTXJCM0pWcS94eis4VXlEOTBmcHppbDlGWVpweUx5VG5X?=
 =?utf-8?B?RzBTM1BIR0FXcUI5S0hSd0MxVUtGcU5FbExQd3pDMElTakkxUFN0Q2FxU3V1?=
 =?utf-8?B?cnJvbnJmRmhqazVzM1hreEcvU1FqRXVXS001M1Vrc2RRalY4aXVQTmc3T1Rs?=
 =?utf-8?B?Zml5S2dtbi9KbW9ocEZnY2cxTDZwSkR4Ymo5bXFONlZjU1NCZmZjY2d1YkRW?=
 =?utf-8?B?enpBeVh3YVFSVmFhSno5eVJMT3Uzay9QMkdndHJIQnJnT3N1cCtCOCtqb3hL?=
 =?utf-8?B?ZHZwaTQyQno4bFBlZUd3UGVONmIvWERjSHRMbkNrcnNIMTB3QzJJRnZvQkwr?=
 =?utf-8?B?SlJvWklTVFAzU084NWFwRlJpais4bmtmNXp0OUo0OThjYnlWV0RiYkdhb1JM?=
 =?utf-8?B?RnprbDdrN0Z3WnAwdVBNVUxyWW9USzZ5NGpPNy92MHh0Z1RVSjNydzdkTUlE?=
 =?utf-8?B?bWovR24wVXRDdFJlVnFNOGdnM3BHTExqd0RicSs2QjZMNlRLaDBXcUNjQU5V?=
 =?utf-8?B?WjZ3bFlUSzgwY0RNSUQ3MEduWFUvVVEvVFdZMmpIOVJRSU9NYTFrRFI4enA5?=
 =?utf-8?B?Tkl1aERETGRHZTRZWWJQRlZIZ05WYno4UFJ1QzR3Q1pTNitjUUIvTWpXVGhC?=
 =?utf-8?B?aDFvMmZSbzlDNzllTzNQS2JpcmNMdUNzVGRIUlNIZmJSVG9QRXorUEtvL1hC?=
 =?utf-8?Q?6rXOxeEdqGcFFrZs6ucZXaGVX?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c25bf5c-eb7b-448a-95d1-08dc6ac6ef62
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB8500.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:43:03.3702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3e0B9DO0ewCz0y03acx47Guf04t5Y8QRTUy49NOdn+8ylwhEG/gySfed43w4XjSG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB10051



2024-05-02 at 17:09, Jonathan Cameron wrote:
> On Thu, 2 May 2024 16:05:45 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> 2024-05-02 at 15:49, Peter Rosin wrote:
>>> Since you appear to need to change both the gpio pin and the io-channel, the
>>> mux isn't a perfect fit. The closest you can get with the current code is to
>>> create a gpio mux, I think. You would then use that mux twice to fan out both
>>> io-channels, but only expose the "left leg" on the first fan-out and only the
>>> "right leg" on the other. Something like this (untested, probably riddled with
>>> errors, use salt etc etc):
>>>
>>> rcs: raw-current-sense {
>>> 	compatible = "current-sense-shunt";
>>> 	io-channels = <&adc 0>;
>>> 	io-channel-name = "raw-current";
>>> 	#io-channel-cells = <1>;
>>>
>>> 	shunt-resistor-micro-ohms = <3300000>;
>>> };
>>>
>>> rvs: raw-voltage-sense {
>>> 	compatible = "voltage-divider";
>>> 	io-channels = <&adc 1>;
>>> 	io-channel-name = "raw-voltage";
>>> 	#io-channel-cells = <1>;
>>>
>>> 	output-ohms = <22>;
>>> 	full-ohms = <222>;
>>> };
>>>
>>> mux: gpio-mux {
>>> 	compatible = "gpio-mux";
>>> 	#mux-control-cells = <0>;
>>>
>>> 	gpios-mux = <&main_gpio0 29 GPIO_ACTIVE_HIGH>;
>>> };
>>>
>>> current-sense {
>>> 	compatible = "io-channel-mux";
>>> 	io-channels = <&rcs 0>;
>>> 	io-channel-names = "parent";
>>>
>>> 	mux-controls = <&mux>;
>>>
>>> 	channels = "current", "";
>>> };
>>>
>>> voltage-sense {
>>> 	compatible = "io-channel-mux";
>>> 	io-channels = <&rvs 0>;
>>> 	io-channel-names = "parent";
>>>
>>> 	mux-controls = <&mux>;
>>>
>>> 	channels = "", "voltage";
>>> };
>>>
>>> What the mux solves is exclusion, so that the gpio pin is locked while
>>> measurement is made on either current-sense or voltage-sense.
>>>
>>> However, the channels from the raw-{current,voltage}-sense nodes are exposed
>>> to user space, and it will be possible to make "raw" measurements without
>>> regard to how the gpio pin is set. That will of course not yield the desired
>>> results, but is also a user error and might not be a big problem?  
>>
>> I just realized that it's also possible to do this "the other way around". Maybe
>> that makes more sense?
> Ah, I'd failed to realize that this is about routing a single wire
> through two different analog circuits that end on 'different' ADC inputs.
> 
> Pictures would help me out btw!  Everyone loves ascii art.

Certainly! :-)

> Anyhow, I 'think' what you have here should work.

Also, on ordinary multimeters it is quite easy to blow the fuse for the current
loop. Assuming that measuring current is more sensitive, the following addition
might be in order?

@mux {
	idle-state = 1;
};

Cheers,
Peter

