Return-Path: <linux-kernel+bounces-73824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D10185CC08
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB713284608
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19750154BF0;
	Tue, 20 Feb 2024 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="smpGhrLa"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2132.outbound.protection.outlook.com [40.107.13.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4868C1552E1;
	Tue, 20 Feb 2024 23:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471578; cv=fail; b=DLU0Fvq2ZXbuzeC9ubWLkcEk1f/gRG6gtGPjiOh9YQZocNQjp6V01tXAmHycg4L7tbp6EfKTMbaSXNDcq5xtfCAbuL2lVqMugEeClDjB7PeJTRnhzn9hwt2w98VjSznybDrcogy40ThmazZWDykCyFPHooTRbL0+HZS/taYV9D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471578; c=relaxed/simple;
	bh=9RVUhLhrG1LwBR3Ln6AYSmE6qYMHQASBQvCpIrGJtnA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Un4rGdYxIJTY9pthpVqCD2pueECbeuGybJRsbh8bBAem2vPpX0s83fcvWy2g0wD7WHQ6e8OTzkFcSOhVFROSoFNf0L9/SFdUll/KISVYXmGPJDW2QdbjFk5dZQoE3X7TB5HmjHF/ng3DGUgh319LA4lBU6NurO/6iNnwqeHgAsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=smpGhrLa; arc=fail smtp.client-ip=40.107.13.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGC3CACeHKFy42iTNAI4d8Lq5Blz+7MFmMeKK40CdpTJP26pTz0qHfg2b5xaU9gdh95CRgBonUt8H9/EhXOIDlZCrwNYE96l9b9SVcK8YRcZ6x5GdGVwsumkyrQ+WjwP+U+Skedqt2bUOo78X2IKwUnrwLoQIYl8AGize4/dNbvLDoQtNTCFl0blUrUlKyIGcZ9H9vtfWm2qoy2+8Ljq6YLpIJQ6PN1mrZxXrm05bw4OyskHR+ajLJ67/5LD6cSrX7jXsOaKEHwo3UU9olG8IJUg+Oc7LMnNt+2cuRR1HOSgwGqFb8UR+0rXu5a/L49WrYFGTiBdKqg4XPY9oa6jnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMqgGuWdkrHqtGMKVqwoEcA1ncJJ654mL4bpHC/H8Yw=;
 b=KO2XmP5qLI8KCFWz5RfmgLqRz7Fo3kKcON/SxzifQR+kjRYYgKYGOVR1y1fA02aJ5ijs8nDnjiPKCxNbL220D/8o+E194qFQn62KTDKxco8s+qF8Y0FuQ4/OehbWjytJT2I+ItSoJ6sc6jSbZQXCkO6YU6B6hHguOmPftOVFqltDmA/kXEZ9RUa+Fa1zTTRt9s+os3G5XquPMc3d+smgldCYscI1m2IMhgtEh7s4NsnJRUkaYjnd91M1nZ2R8IvTcEwHPyMgvQbfPkx37ItwaPCI7o6p/PVX3+aRxVWRKEr4G0auw0fKibgIGds1R25W77naLIjY4GA0NK4joqpPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMqgGuWdkrHqtGMKVqwoEcA1ncJJ654mL4bpHC/H8Yw=;
 b=smpGhrLaJXAp/ZXl8bHcOcAVwlOK96kRzBvFMtVrmkFLKYlPHQ4QFJqyF1GO6PooSqIkY8FD58JYF25M5iqCeiWu3byYriLj3UVGJhFpXAh5tG8F/VhWZSUeA9oeNrdlQsVrfgfGBBI/CFvVQDlykQZWG9YLRN6f0/OHo4+wT6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PR3P193MB0880.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Tue, 20 Feb
 2024 23:26:12 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::83c6:a213:7935:ae6f]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::83c6:a213:7935:ae6f%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 23:26:10 +0000
Message-ID: <9da1855b-eca2-4c11-a69d-e01494c985d1@kunbus.com>
Date: Wed, 21 Feb 2024 00:26:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>,
 Alexander Steffen <Alexander.Steffen@infineon.com>,
 "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Sasha Levin <sashal@kernel.org>,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
 Kanth Ghatraju <kanth.ghatraju@oracle.com>, Peter Huewe <peterhuewe@gmx.de>
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
 <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
 <91f600ef-867b-4523-89be-1c0ba34f8a4c@kunbus.com>
 <CZA9CM3PDILC.82JMLUWMB6B7@seitikki> <CZA9GMC718HA.1JFHTTWV563IE@seitikki>
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <CZA9GMC718HA.1JFHTTWV563IE@seitikki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0444.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::6) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|PR3P193MB0880:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca50ca8-2a6a-4487-981e-08dc326b5255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pEgf/qbC3BtepSHY4OauhLZ5UA3GA1GltbfMWXxBC4kNh57EO5snCvOkJt6mFp9T8KD9i2VCqHychF8Nx/zw+hnwVsmTmyipJCXMmh8EJh1DNQVGPdOXPeoNW52aUFhBFWCeVsTrBeagGIIP9obAYwrZjkfXzJ1VnKuhHWkuWh1zz4waIT7Vnj0vPOTWc2ABIAFDUauUI8EOsVXpx7yE4m3/RUDR432oSJmDhEObTvfwJeCg7tgOEQRFQJejvQIrgtQBEP1qjBte675dvfJABfab7+Y3v4y9eXIjD/M/DhdUj/0GAZ2NcoxW/MMyV7Ld+N4i9GIg5CxoqyZD9x4fN8FSXaw8DXdSWyRlYNcBlHZNr+HXf20Ec6OHwnofBw+++OGLQueXnxrQYTfjN+WV7+2feDKGLT6a0aDsawTNoIojTvAjMU2IeOoSzmixpJLAHKzFEiXa7Fh+awe7lzNch5mYau/mmeabxutJUIKncuCmqM6MUw/ukNlRMtlN/qgSWip+LU6L/4wq1BOrCfYBqy6PRRUae7plWIB0evzyyczOiczFuG2aukB7J9QUrI1w
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXE3MWc3b1p1dVNGRXRSMWEvNUFaM1NaZStjaDNmUUkyazZvNVhsOEJrVW9F?=
 =?utf-8?B?T3BwcE1EbEFlSFlTZ3JxL3A1SmRUYWxZNlJxNDMrcDZpc1cwZE1pT0I2VHdI?=
 =?utf-8?B?cGJhSUh2VThFOXJaV0M5MmNIVWhZR2VVRWY1MVViaHRsUWJiNUJqMkdpakNy?=
 =?utf-8?B?WlM4N2Z6Znc0S1BjZUxuMXVDZjVaa0xMdVhqNVcwYkVPd3V4ZHRCSWxpWVBJ?=
 =?utf-8?B?aXVJSW5Mc3VRS3k4OWNWS1BQWXEwWHloZkE3R3NQYk1UOWNBWVBBOHk5UEVQ?=
 =?utf-8?B?UWlnaTRqWi82b21lQkJ2Z2lVc3M5L0dsS3kvYmlTZUNzTXgyNGRBQmxPVVRH?=
 =?utf-8?B?Mk5FeUpCRHJyNU5uT1AyRXRMcGkvcC9PRVZpbFZQWEoxcVVCY0xzRk92VkJj?=
 =?utf-8?B?a09Fa0dneUpkMFZTVmhhYWV4TUYwSjBNdnlvaGgxaDdwSHRENHBtNSt0aUlU?=
 =?utf-8?B?elhBWjN5U3pMd04wRzZOc1NwcjJFcm1qNHpObDB3T05jZmo5L29Ddnp3eWhR?=
 =?utf-8?B?WTVST0pJVTJpRTNYa003bXFpVlN0YkVyeU1jb3gyL1lwSm16ckNhV0hlMmN3?=
 =?utf-8?B?amh5U2NlbXNMREIzZ2U3N25jeG1qNWpoMGVHbFZ4U0FWRzNZUlRXS05qVEkx?=
 =?utf-8?B?R1h3NXVHUGVXa3dHODRxSEdaaUFwVnBMaVV0dDd2VndsWnFHWE5EYTl3d2Zs?=
 =?utf-8?B?TlZhM1VGdjhtU0Zac3BWcWt4TThmNENGMXN1LzNLdnRZUjgwSndtbERDOTVI?=
 =?utf-8?B?RkNJU2dsME4rSDJEdk9UR3RvZStEeVZ6VEZXbXQ5aURvdUJJc2w5VkEwR3pZ?=
 =?utf-8?B?Tm1ZbkZJMmxvdTU0L3NSUmU3ZUgyY3J6end0WjhWOW1QZWpBYmtjaTYvY1p4?=
 =?utf-8?B?SHliWnJvc3pHVDhtYnFHMEkrTDRlKy80Wk4xMkZMbVVLSmRSbU0yU29UYS9T?=
 =?utf-8?B?MXNnbk1UT1Q4cDhZQUpwbUpRS3NmSEdJRnNBaWNrRWNKUENKbm5FZ3Z0bGlP?=
 =?utf-8?B?V2plTWxJd1hKQ2FGYUpIZXpmQVBIWUhLbGVXSkd3MDlOQWcwUlhITkloOTRu?=
 =?utf-8?B?NHBtczd2anpVRGlKc0MwOUZRWDVmMXZjWmxNZy9PVFFDUTl6WEhlUUtVblY3?=
 =?utf-8?B?ZXMrZEpTeUk2LzdkSWxSR1NCT2Qyd0FiNlFOSWFyVU1oUmhmd0JjaTJHVm4r?=
 =?utf-8?B?STRsRFAvWkhSZlJOZGtndG90K204aFNjVmcwanpWZzRrZkJIc09wMmtDTGxO?=
 =?utf-8?B?R0ZZSTlGZjNGMXcvSk1pY1NYMjRTNlJjbGFLS2dPUFU2YnJJUlpzUDF2MDBi?=
 =?utf-8?B?T0NlaEgxcUQ5alhaTUpTWVNCRFVFaVY0dFJlZXBhVUU0ZEoyczlRNFJqQkVS?=
 =?utf-8?B?UHI4dDBTbERQUGlpQmpmVlhmMGlHQlZCc3B5QkR1VzZsODdJVmh3VHpoMHlp?=
 =?utf-8?B?Q0F3Tml5dStiNlZFci9Na1E5YkpDYytLRlIwMkxXRXdBOWJ1dmZWTnV6ZUJE?=
 =?utf-8?B?aUt4RGFzUCt0azA2MnNDR3QvYzhGbW42VnczSy9HNFA2SlhyV1pWbm53bks3?=
 =?utf-8?B?Ukx4S01xWWliZ21PSGdFMWQ5ZnVZYWlMQmtZdXlmL2RLVnFSd3ZWREIzM1hG?=
 =?utf-8?B?MURTYlVneHZrQU1xaFgweG1wVXFUTnIxQXhUdENPZkxSdktaUmZUNEUwS3lq?=
 =?utf-8?B?TW95ZWNpWS80c3BNbFA0WmxpQU81M2d2cjFNa0xhcFU0cjdnVG1zRmRxdGhy?=
 =?utf-8?B?bGRseUtJWk5EK1ErNS84bG9mZWkzOTZOcTJvZVdQR20wNHpBVWpCUEFNOGdH?=
 =?utf-8?B?L2R5Y0tmaFRzV0VicEdXSXBCWDhQTlFxbjR1Q1JxME5ka3o2eTI0T3UxSFRN?=
 =?utf-8?B?UEN4THZGSTNMYlhQbENEVmlQWXNicjVFN3JRaDVlTHJwekZibnRTaWhZRVYv?=
 =?utf-8?B?VzRyU1Ywb2U2Zk9yVHlQM0M2UmNEOURjRDlFMUdXaStVZ3NGVWNXUXdUSDVw?=
 =?utf-8?B?MytqMmNKeXZqSk04R0Q0ZWZoZUI0VkwxbUNUNDdyb0hnYWlmUU8rSU9Rdk5q?=
 =?utf-8?B?WGhZOGZZQTJnd1ZkRFNvaTBXYXhUMWNtbngwN1dkM3ZIbzM1NHRXeVczUW5y?=
 =?utf-8?B?ZlZiQUpBV0ZoNDViMEVNWUtTMDlVbzcwVUZ0S1lNY0x2b3U5d01ndkF1Q2ox?=
 =?utf-8?B?MVNqRU1BVEFCYzM4QURqd3NOdWVnTG1GaFFCV3o0L0JCdm02L3gveGlUMndu?=
 =?utf-8?B?aUF2d1RWbXprbEhMajR4SWJBREF3PT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca50ca8-2a6a-4487-981e-08dc326b5255
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 23:26:10.6333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1gXgltUkOKhtY5XWK9bJ4FmKyW8DblLXVifJPyC7zw/m9xH2mcLah/xnfdjgkYq1haeNPiG23bnwB8HYitg0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0880



On 20.02.24 23:31, Jarkko Sakkinen wrote:
> ATTENTION: This e-mail is from an external sender. Please check attachments and links before opening e.g. with mouseover.
> 
> 
> On Tue Feb 20, 2024 at 10:26 PM UTC, Jarkko Sakkinen wrote:
>> On Tue Feb 20, 2024 at 8:54 PM UTC, Lino Sanfilippo wrote:
>>> for (i = 0; i <= MAX_LOCALITY; i++)
>>>     __tpm_tis_relinquish_locality(priv, i);
>>
>> I'm pretty unfamiliar with Intel TXT so asking a dummy question:
>> if Intel TXT uses locality 2 I suppose we should not try to
>> relinquish it, or?
>>
>> AFAIK, we don't have a symbol called MAX_LOCALITY.
> 
> OK it was called TPM_MAX_LOCALITY :-) I had the patch set applied
> in one branch but looked up with wrong symbol name.
> 

Sorry for the confusion. The code was just meant to sketch a solution, it was 
written out of my head and I just remembered that Daniels patch set introduced
some define for the max number of the localities. I did not look up the correct
name though.

