Return-Path: <linux-kernel+bounces-153270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0AE8ACBBE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553751F23DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75619146A6A;
	Mon, 22 Apr 2024 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QNYkCh1K"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC818146595
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784372; cv=fail; b=PHlhxRclLqwQ9+2mf0ItTFhm8HMosqrHMT4WMwRTOJKN0hVAoeAz6kLFytIqjRXLqDwT7zG1BmyhoHrKuCbZ+dPhrhRm3o1rxJR1cfmeQIiFVqE9mEi5p6nzy8gtVXbQwkhmPkgVJymYReD+rgCHDNkGQyOFKtauxuR9D2Lrxww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784372; c=relaxed/simple;
	bh=gKtX1IeuDHkUs08IB7Ewt9AJUTvLIE4UY3ph5MAc45A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IZyWMxVYsKyusQAgz+8nyEWiK6MVIDoCykig/8Pk2ycwovubkgXTZulB0oM/qnRPmXmozwD6Q8VPR5lAnaakOeKH72Wdv4A44XXAwz8ZkeP/+Umd0VadZ7Xnft4TBEvs1r+UBiLtsL4UxJfsYNFUTbOlghdDxhMdtkP3TyMA2Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QNYkCh1K; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJBXBpg1goIAEhpZwh5Jgbe3MbDXH3WetYOj+9Xhhuqm/gbs0x5oIUKNreEHOIOlsp3M7AxkYaUKgMjLVWLrvbCgGFWHtqx5o3LLeZE4VqYSd6hQ/RBLIx85znBcoqe44f0lOg682lbCvA0UvFWB0ZqGPYTXrIWeXH6YLf+Ls5G9B9LLtMs/clznXef26dxq3Lx38NHpDQjY0a//otYX8gpGEnGWNxA9Keb6kMU3EyfEqnVUVHoFbfnGFo3gAgO/Ft+qZM6CqFebIxMJP+q1B9wvIrEp8O1uiG8oallxi1n3L2PNMGXKpnFc02tzPLQmNvhYiL3RW9UHYoVmLuzQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MTvp06jxtzi1WRyS3xoZptryBmNi49z7+otECgqVqc=;
 b=Z/U2f8QzceDLPZHBJ0AdnKMWkONH/hvCg/JQH8StoAUadgOjHLnSW6FBuId/CeqyHsQ+Isbhgod9zH+I1p2qBsJi3Dt6mGXqe4ekRN31n2zOM7cro8rvBIAP8XMXCTM+WRG1xPihNY7nodvssxwaylgXQRQ/r6farKyOfC+6tHdg78rIqPo2D5/wRdval+zFIV32Jj5Kc1AzLDx3OLtz+L3jT88F7ItwfpVVAik57Nv9fhR98blXMsHrLPAcdW7yob2oCIOOA4V7RdyKDMndCYYPZ9VWkWXq6isfP2hhuX7aomGIl/ZahA9+xH7fsa76NvX67HEv1SGKz1JlLJrVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MTvp06jxtzi1WRyS3xoZptryBmNi49z7+otECgqVqc=;
 b=QNYkCh1KGwml+4dO8hcUUt/EqAWWKTuk4R5G0UOLoeJmB0TbAsq8l3OOdqR/tlo7x0yn9u1RmgpOSQbQqZkx0jFBipX+h80vr4my7SP5nP3VPA3kHb8ALuWWf4Eb58hXoiWjpPfdq9uGkO1Q9ooUSsr3odl2eN2ipPqLwKaZleI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 11:12:48 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::66b:8d4f:3f1c:6454]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::66b:8d4f:3f1c:6454%3]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 11:12:48 +0000
Message-ID: <68372695-78d9-4036-8d59-fbf1d1261470@amd.com>
Date: Mon, 22 Apr 2024 16:42:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] Fix lb_imbalance reporting in /proc/schedstat
To: linux-kernel@vger.kernel.org, mingo@redhat.com
Cc: peterz@infradead.org, torvalds@linux-foundation.org,
 juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 vincent.guittot@linaro.org, gautham.shenoy@amd.com, sshegde@linux.ibm.com,
 kprateek.nayak@amd.com
References: <20240318092433.1791798-1-swapnil.sapkal@amd.com>
Content-Language: en-US
From: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <20240318092433.1791798-1-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::16) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6433f8-8801-43e7-5004-08dc62bd2456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzRFQWZ5TEczblhVRkJjZXdYWXF4ZWQ3QVBMSHg4cmxTUDZqR0FTZ1BUNmZw?=
 =?utf-8?B?bGVRSDRWa0VCRlBKQk1leitKdy9zamJqVlNaYzM0ZVN0clFoM3A3eUZMaFNW?=
 =?utf-8?B?TUM4N2djZkJxb1pEekJLanJ4RkoxNHRVclZDR2J5YUZsYmRFWmVmN1VwSG1s?=
 =?utf-8?B?c1M4VFlSTlp1NVhTWmtWR25aWkFCT09UQWo4K3hZcU13bWJ1UFlsQ0ZZdkN0?=
 =?utf-8?B?VEMzTUxWQ3RaUWRLWFUybFNQMlQwSUxKQlJTbFk1bzdVY3BFUUlMYnZOWmRs?=
 =?utf-8?B?MnRPRGFwMEZNSXNaTTI1Y0w0SEx0TmRWeFhuRzV1bGpvUjE1bWhyMFdtdFh4?=
 =?utf-8?B?MnlycCtDTzc2eVU1U1NhaGVSNUJLeVJnV0ZrWHBFbkRYY3VUVEY4YzczWEZB?=
 =?utf-8?B?NkFSb2JXT0x6SDdMVU8yb2w0eTRMNnQ0MDUxYUdDSlpxYWRMeHh0YitUM0Fl?=
 =?utf-8?B?THpzVm9haVdLZmdybmUwVnNrb0JFcFBSdGJXZHRtVmVSQjdyM0hjVmUyM0Vs?=
 =?utf-8?B?UENPZzFjdHpNcCtickJBTWpuM0pwcHZuYmVaRXIzS1pQR003UnJHVGc4Z0kv?=
 =?utf-8?B?TDhjMHJsYTZobmRVMGxGei9QTUwwVUoxMjVxR3h0R3JtelNlWlRiMkMxbXdm?=
 =?utf-8?B?Y0svTkRFU01pOWlIcFBsbGIrRHRoSHpZMllvN05reUhoZzRBbWN6UyttWVJh?=
 =?utf-8?B?NWF5UHJ0Rmh6bERlQnVXMnhtQzlORnB3M2RQeVpLZjZFSmhJSVRHUU1UZnZr?=
 =?utf-8?B?SXhmNUllTFhSS3JuVzh2QmgxS29YLzMyeUt4aWpaNnh1UTlwNTBUMWFheFdq?=
 =?utf-8?B?Vll2Vjd3N0lmR1kwby9pSHJONDNUK0JEVVNiNWo0bE9YNURySEhYV3RNQTh6?=
 =?utf-8?B?TTVhNEd3MU9PWmliWi9UM2ZKalZHUVFrMkQxL3hGREpIdUlIcUszYXB2K0tV?=
 =?utf-8?B?dDM2NDVHV3U0SE10bXpibTZZSkF2SnRxRUJHYVZ0SitlWmRmMXUxYXIzd1dS?=
 =?utf-8?B?bFVraXhlVWc3V3RHSUcrQ0FjR284YjBZVWpJOTVXZUlkRmcxTkpUMmtaRlAr?=
 =?utf-8?B?aTNVajM3cy9ONWEwT01GRXI4RUI5SEQ5Nkh1OWtwZEFpWTY3QThjVjEydEdi?=
 =?utf-8?B?WldJajROVk00aVF3Uy8yOWpYdm5ESk9qN0hkT1NJc2dwdTlGSmFxMnV2MmlY?=
 =?utf-8?B?VUZWQWtoRFUvK3lBaVlUcDZYSHJWSjhLSURQMUFqVmpVUHplVmlWRGtpR0VR?=
 =?utf-8?B?N2JiTEdBQWZNWS8xekUxVGs2SlFIS1ZnUFNwQjRZL3p3YWRPem00S2lUWlEx?=
 =?utf-8?B?MkFMWHRadU11MEF1N0F0eTFtL0p0aitCaTN5K2thd1Z5SGoyYTBjVzZvZkYz?=
 =?utf-8?B?RTljaFpLbnQwRTJEK0tjMVoyRFMzQ2E2RGp2SFgzR2NvUVc5TW9ndllZa0xk?=
 =?utf-8?B?NkNERE9GcjZiS1VQRVl0MEdwYlZyaklwMXFlM2E5aHF3cmNiU3lTS0xIbHFV?=
 =?utf-8?B?VDg4K3BiNGV4cmxtWnNpSFJFcVNmVWpOYVlTN2pSUmtId1pZenZzbmRvcnNi?=
 =?utf-8?B?enpCMXpIL2hsRzdSZ2VqUDM3eDNSSjdoWmhpYWw1d29PQWZaaVo1WFhPbFhi?=
 =?utf-8?B?aTdsZm9BbTd4NmpYWGNiWE1mQktoSWt2WEl3UFRETmZsV09xTWcyZjg4QjNG?=
 =?utf-8?B?bE5pK3pyUVJlTkVaTG53ZThab1hPV2dyUGQ1WGJDdUMxZVp3bWdnRnVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K05JMkdZRTBVV1BsS2F1c2o4TUJ0bjdnaEJrZ24rTGVHeWRNVjNPM2FROEU2?=
 =?utf-8?B?NVRtQkdOT2FaNFBacE1EcnNVNi8zemZVOGR1RVl6dHE3SnZJWTc0ak9jT3I2?=
 =?utf-8?B?NkVMUWFNR2F6M3g3cUJtUnllemF4dFhRME9zUkpyVEEyTzBobm1qKzNjYmJX?=
 =?utf-8?B?UEtTTVYzYmE1aDFHMDlvZ2dlczNBRnZRSitoWnZ6ZjAzTG1QR0NwbDhSbDdt?=
 =?utf-8?B?MHBzTlptZWR3OE8zZG1zMytjY0NsSDM0MmRFMXdkeFpqLzRsTUtzdSt1ZVRQ?=
 =?utf-8?B?RkorV2lvV1N6QUp1UmNXNldobmlyMHdQTUI4aG5BRmo4V3pyb1VFMVBFTktX?=
 =?utf-8?B?Y0JhVjVTSWFWTUZncFphb0l0WXdzZkdPc3pMd3drK1cwaENaalVsWjFLNDIw?=
 =?utf-8?B?SXNVS083Vi9PZUZjRVVNNFdHQjlGVW9DQjZrOW5lSlM1UUE3Qm1nYjlnSEFU?=
 =?utf-8?B?ekpPalY1S0Z6endGekRNQ3ZtNHZ2SjJzdFFQK0lpNzd3RDJzeUtnSEZ0bS9F?=
 =?utf-8?B?dkN6dFlTaDBtUDRId3o0bUhSNEFKL1l3STRCRTFJTUs2dlc2ZjRud2JQWk9i?=
 =?utf-8?B?TllIQWt2UjVVVHV5cGxuQ21zMkphUytjZHJjNlpaa2F5eGdrVDNUaGV2dGdv?=
 =?utf-8?B?V1hTY2NPRW8yZXh3M01NMWpDUEp3ZTRIWTE0SkNrYWZRVTExU0hQV3Fqd2hU?=
 =?utf-8?B?bzl3NDR1cENxaWdVTmkzZDFxdFZWc1p5ZzR0cTRkZDdVK2R4S1JQMFpvdDNV?=
 =?utf-8?B?MHJMbFhLOCtjVFJhblo3Vis1SWdhSHZ5aW41T2tjQ2QvamV5cjUxSmFkTWg3?=
 =?utf-8?B?dFZEZndMNENSYTVEeEg3RHRqbVc1NXh3MWMxTW1ISEFXT0ZKbHdzNXRzaXdT?=
 =?utf-8?B?S3RORDlkMlpaUFgrdDFGYUY0K2kzOVJFV0dpZ2xpaWdsRE5oMkxLdXRWdWJR?=
 =?utf-8?B?V29WUlRIOEVyVm1zQ01wQ2RjWjdyUjhTTFJWNnlCVWZCZERrbFhzRzVSOHR4?=
 =?utf-8?B?VnV3cldtaS8yY1YxdlVsSURtU0I1b0dHOElhZWtmWkFqTHBOb25oeUJNbDBN?=
 =?utf-8?B?TjdESFIrTnZRZUdOTDdzTUNaVzBZdDhkRlE4ZlRVNlZhNmpxUFBpT3VmZ2s0?=
 =?utf-8?B?NXowZDc4VVB4Wmd6OFJZK3ZYRE9zM0RmSFBIL2FQR0Q3WWlLOGNTRUxBZW5T?=
 =?utf-8?B?aktwbFlObWZhT0o3UTBjZWNGanYwYzJXMlV3aERGZTZKdXgrOEFvYnlLS083?=
 =?utf-8?B?VFlaSWtmSEcrM2QyK3N5OGJQOWlxVnEybnE1WDFlVndqa3lvdXBNNzRIYzkv?=
 =?utf-8?B?enljWHJJOEJQRERRK3NmMmgzQUNaMHBaWlB6NFVpVnhuYnBncXVabktObnBv?=
 =?utf-8?B?RnluNUFuRWdEdDkxaUVJTHl5WjZmdkFpWHIrQUV6Wk95Wk5yamIxT05QeUxj?=
 =?utf-8?B?T2VPN0NsaVRiVHNKaUJpWDlGMmhOQWxML3Q4bHU3ditEVU42NGcwalNJUU9Q?=
 =?utf-8?B?bk1XclN4VWcxT2p0NUFXTG4rUGFEN1FwNjNQN2JBenV0RHNTRURUeUl3Z3ZZ?=
 =?utf-8?B?SE8zVmpxSXovN3ZrUFYycldwcmVYQVlJT01jUjBla0dVajBuNnlZM1QvV3FL?=
 =?utf-8?B?TjFkU2d0MFRoQ3pzYXhBQ1ZhZTFHMUdLdS92TEswcEc1dXBjRkpmUzBieGdW?=
 =?utf-8?B?Z1daN1VHZWRqRGZwajNLaXcrNW1rUzVFWDBKZ1llRjErZkVjUWdNUDVLcUJW?=
 =?utf-8?B?TnJyTjBhMFNicmszaUZ6MUFHTERjYmc3dHJNMVVVQVNNb1grSkxCSjV1cmtG?=
 =?utf-8?B?ajZneUFqVzhRREhiNTNOSnQ4M3FFaGZBMFNxcE5KaC9QOWJ1aVZVVWNvdmJt?=
 =?utf-8?B?OUpBOVp6enFaelBrem9iYWF1NE5jdlBsS3hxMTJ2d3JmYk92bTBZaytSNzlx?=
 =?utf-8?B?RnBhR0thTDg1RWZIVjNqdm1WMTd0NVlZOVA0bXpVcVY0eERqTTB3M1l1aFNj?=
 =?utf-8?B?bUNzeUlmZGdNNU5iWUtqc3VOUWlLSWxCTXVJS0NCL3dpK0hCYlF2N1JKT2ZX?=
 =?utf-8?B?OWNwQ2RmWm5OQkRhbldUY1VEOEQvbjhmLyszMm9LdVczekxRd1NNU2ZaaTE2?=
 =?utf-8?Q?ttzsiKFx8gnh5CGMuFOj454II?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6433f8-8801-43e7-5004-08dc62bd2456
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 11:12:48.2255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VzC0W75pXwU49oVNRZ3HbkY+e3Dse7K1sICzf0MlWFLMkIjIXPHoiOtn3DgXoBn9KKB7oeQaqJz1apn3uJl0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978

Hello Ingo,

On 3/18/2024 2:54 PM, Swapnil Sapkal wrote:
> This patch adds new fields to /proc/schdstat. First version of
> the patch is sent here [1]. This patch goes on top of the
> commit d72cf62438d6 ("sched/balancing: Fix a couple of outdated function names in comments")
> from tip/sched/core. This change is intended to be a part of v16 of
> /proc/schedstat.
> 
> v2 --> v3 change:
>    - Incorporated review comment by Shrikanth Hegde
>    - Added reviewed by.
> 
> v1 --> v2 change:
>    - Added links to previous schedstat documentation
>    - Incorporated review comments by Shrikanth Hegde
> 
> Motivation:
> 
> In /proc/schedstat, lb_imbalance reports the sum of imbalances
> discovered in sched domains with each call to sched_balance_rq(), which is
> not very useful because lb_imbalance does not mention whether the imbalance
> is due to load, utilization, nr_tasks or misfit_tasks. Remove this field
> from /proc/schedstat.
> 
> Currently there is no field in /proc/schedstat to report different types
> of imbalances. Introduce new fields in /proc/schedstat to report the
> total imbalances in load, utilization, nr_tasks or misfit_tasks.
> 
> [1] https://lore.kernel.org/lkml/66f1e42c-9035-4f9b-8c77-976ab50638bd@amd.com/
> 
> Swapnil Sapkal (1):
>    sched: Report the different kinds of imbalances in /proc/schedstat
> 
>   Documentation/scheduler/sched-stats.rst | 121 ++++++++++++++----------
>   include/linux/sched/topology.h          |   5 +-
>   kernel/sched/fair.c                     |  21 +++-
>   kernel/sched/stats.c                    |   7 +-
>   4 files changed, 99 insertions(+), 55 deletions(-)
> 
Gentle ping. Can you please consider this for v6.10? If anything needs to be changed please let me know.

Thanks and Regards,
Swapnil

