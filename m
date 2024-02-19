Return-Path: <linux-kernel+bounces-71231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9C185A23D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D86B1F2463A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F40A2D79D;
	Mon, 19 Feb 2024 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2crYCenU"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1D62C6B2
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342892; cv=fail; b=WZd+9PIgb2CFNeHAalHND21E73QeUIqFbVNjMp5KyPdfcAJ+ywbJLSwCu60oFNGIGpasWVplcJNtUmfcGOX2J6TpljWA6CKQ8qsNA2ovqWCpxbciRFKDTfwxuvozT/R5U7Ydrtq9DrFBhO/MqGSpet2RqeLF6dFyMlzSF3uP0QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342892; c=relaxed/simple;
	bh=TYt+/f8r2uzbBO6xAOI9BPUGvI6n1tXuOxSre4T5eik=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PqgIr9CrCWSkeE4NnXD5ZdqL4qWeQHlPdNFf1wwJ2RYPtsUfEOsRCkIqFISp7D7lkNwxoSX/slqIwpZHi7EJTGTHQE3fNpxurgUBpMNZHWcZdb9tezh1na16lJgHVxzPZUe9vIwZt3VsghZ26yqvC0LEslZ72aULRmiW1G9CKec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2crYCenU; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM2dn9g459tmiEM/PWWQO2j9YCbhEKqveFtJKpHOkrCgGOdbZSeCLJ2Tihf4Ssw0CkDpWMCW3RFpM0LqbeZ3dpnViNveEkQxmx7LAuCUWQIDk2NrzdOW67vxGbLXcOzDItmcRUOLqprxaUcqs6GiEWxBwJ0zr3GEllZHr7NStNL27Z8GZK8/sjP/SfDaCuHuOHO9QtFTxU2DUe+biYpA8cNwEfi6LiBDSUe4zlfBWTk3L0Rxuvxii9a8h38XsjX/akinLQd7ozBXktqQxx7zPRzC9uUrHmLyj4JbQGu+xchJjWJwfJW+h2WqtalBO8Cn3ODN9o9uFaV7/Tu6d/A2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+pEWXW1rK2Q53zCwHVBMu8sVBF8rb9cL20HpcdB5Q0=;
 b=fUAYwBEH2sF4WzXYDto5j9E7tXHN/ffuftp8OhTFXjALZ6ItS1nMj2ImLo9NdbASN/xARDxMq+LbV6QFpxGS4FleMUjXj/1beD32s+IehIwcXVmP82gTmFkGwm/Up+RwrDX+JKxt4za58Ode6UNBYzSSDvM5qWhgO0hbq3ANyF0eEQNS88/sR2t2agy9k2RAmFbQgNIfUsqB4CU70ep6eeP8miPvpxA81C1TPW4bNk9mxd1OVbiBaX+/kkMkeKnwt0omebHTxlsKXfGpui+Yrizp62ZvZ0wFt9Cp4rXYBTSQnBDoCmf5/WfGaUBoHfVoJRd73PbGPboTnlW6tReF7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+pEWXW1rK2Q53zCwHVBMu8sVBF8rb9cL20HpcdB5Q0=;
 b=2crYCenU02twjJt6rs63g8bocwk9wLMjGSNbU88S/oRgTg6gdKvzQvevA5PDxRVtWpSnBSbZuyrbcBoIalSK+RNsbm4zrz6BOhSID1eygXtj9LlRgfNs5GCc6WVb+kFJSIqYtURi+vtRYMeucFAzAKCHtJrhe30BqpGC2RD17dA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.17; Mon, 19 Feb
 2024 11:41:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 11:41:26 +0000
Message-ID: <a293460f-6a40-427f-b5d2-2e701d1af229@amd.com>
Date: Mon, 19 Feb 2024 12:41:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tests/drm_buddy: avoid 64-bit calculation
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
 Arnd Bergmann <arnd@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 David Gow <davidgow@google.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Matthew Auld <matthew.auld@intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240216202442.2493031-1-arnd@kernel.org>
 <745e156e-c3ec-427f-98ad-bfc7d3cfd846@infradead.org>
 <4cdc5b58-11c1-490d-8c3b-6352d8f1b8cb@amd.com>
 <fbd0426c-fdd2-4b7f-a13e-072ed5f973de@app.fastmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <fbd0426c-fdd2-4b7f-a13e-072ed5f973de@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f261ee6-0847-40ae-80a2-08dc313fb4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yIoHc5+t0O3dSfKvXFFOhQiPg0heoSaZ25wa0TBW1wjOMKbrtICrczDJ3askVMo454oQtlx3uVaKaDgLqFRJDsJJHgFySErvHiXfZe3Q6YDHJwC1b8TWGqiiL5ZZuzFNzskSmHBaLYZSqijyK76TP8RWLQxfs/cdrXFBII2UjA+Ho+520rEnAEl3VvwAoBjd6yL7zmXp7t57nUp/6EFkdkzspvcNn1H+1XMj5BFDEkPQ6zuNF1InouwG5g2tvb3JMcjzX0DCquXvPedKx05CJ4Kw86yBWi8+Qa4xnUmui3cb+6aIhtilBGszSClta/853/bDt5UCuMfWOkeOt+910Qf3XzVcZ4OFs7+qbSbof7E8aDBoJMdVXMF3VOuC2SgE0AM6CxfFxhpGDoOEG2qDd6+hiVTTPuSxtXs1W5Y/juCv+0jzw58yyI1vfdRJwbAF5NoE0DQYypeK9O8q69SYTFN+yBoIpPfBbrjWd9A66Olaavg/NCCF4Q5f6RY6K64gLCxDjCnUCAXd5FZfSC/0H5ZwSPiVioUF0e4FktiNgCE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3ZyTk5EeXR4TmxNaWRWaW1pQVFjUUFjT245SEt0VjJ0a25qVG9FZGREVzRa?=
 =?utf-8?B?U0FWSE9jWGFmYWNUaWJ0UGtkQTVkMlNCNFdyakNBYnhrSy8wQU9MNVkwMXla?=
 =?utf-8?B?V0RPSUVvWnZHQlRPZ3F3dnFCUGtMVFZ6RGNKbk81SlhwTWhpUUdwQmJyVlJY?=
 =?utf-8?B?RmhoQ2lieUVaU1hXUU1nNXZHZFZNSnJXb0NKSlE4a0tSbHYxOG9ib2tmb2Rt?=
 =?utf-8?B?QXNZQ20yK3ZtZEFvWXI3eW9PSDl2eHhVZzd2bDVVV09hMlZkV2FQVWNJdHN4?=
 =?utf-8?B?WGQvM2FENVIydWc3TndmZUgvankzSjJWL2s2M0pEeWZhUVZoaVpKeW5CRThL?=
 =?utf-8?B?VXVvT1Q3d3c4RVUzNVBIN2M3Yk41R29VTEhUTVFZWlU1Si9saUQ0SjJyYVhr?=
 =?utf-8?B?YjN6alkwSzMvUEFVTXRwZ1E3WWd3bWpaWHkydVBxZ0JJOU5kQnVreWl3RlVw?=
 =?utf-8?B?akMyUmdZS0NFc0d0d09LMi90bmFKWkpoakpDYzNQYTcxNU5NYmR1WFdtdE4v?=
 =?utf-8?B?K1R6dzBXYmVURFhhY2Nkc0JtaUdxRTg0MDJ5THJYbk9ob0lNWGFiU3JDUzhu?=
 =?utf-8?B?c1Q1WkFvZUhobzk5M1RmYUpZS0NYWjZ2SFFNQWd0ZGNpQTFJWjdpMlNDeFdo?=
 =?utf-8?B?RmEvN3cwbGpYaU1yZE51UmEwY1h2SjQ1TDY5d1BFaDFsWExXaHdVUGVBZldl?=
 =?utf-8?B?NkRkYjF2Njd5Y0xuZlRaWU5BUTZna052VFNvSzc5aGE5aWE0VlpmaHdOSEhK?=
 =?utf-8?B?SDJ3b2ZENE9ESjBlMGVEUTJmd1oydDFUbU1udUlMRFhBNVFOUmlhUldJTlBM?=
 =?utf-8?B?d3JTNWdXbkdjTFA2czZqZ1YzdEhvTTFMazM4VmpSdVA2dWJNUENkMWFaVm94?=
 =?utf-8?B?cDkyOWgrU3lML0JhMWRkU2lTSGpqSDZTanpFL3pTRFdNL1Q1MTdwQUEzdmdh?=
 =?utf-8?B?RzFvOTMyNVVHb1MrcTVYUDFXRXVBMFlrUnl1RW9SWU12ZGN5bk1YN0pWU0Mx?=
 =?utf-8?B?a2pYV2lIeTRPb1hiL0JpNitwVXBzZUV5NUNEd0FjZ1N5aTVhbjQ2OVB1MkUr?=
 =?utf-8?B?Q3YzWHVFVkROZjFDVTR5cTBqd0pMYXA3RnpKQU5Ha2JZckRhMmRWNUJEQTdQ?=
 =?utf-8?B?YjZ1QjJxdGJrWEY2cUV0OW1aSkNVejIyVFpubCtPUGNQWklQMVh5d2tGNVJR?=
 =?utf-8?B?UFlMZldYQ3JVb2FZeWlvNGx0c2tDTjQzRzcyZUZFRlJ0Z0tMbHh1ZlVoN2FO?=
 =?utf-8?B?K2dwajZKZkVxeGFBeVVzWm5vYml3K29MMW5zamtnVXJsK1dLN09yOWNQTll3?=
 =?utf-8?B?Q3FweGZ1NEJFUUp5eEkwZ3Yva2s5Y09HT1VqbjhPRHVFTUlQbmJGNU1UUDl1?=
 =?utf-8?B?NFZVVHRZYVFhRG1QaTZVUVk3UmFaVk5VSHdEaEFXMUlpSkFOemxqdFQ1aEdV?=
 =?utf-8?B?dXhJTm9MUkRXUDhHRjVZelF1UTU0c21QQk1qT28rcW1iTVVpc0hSbllwQUE0?=
 =?utf-8?B?UHI0MG1VdU0zeFJjT3RaK3Vjb2tPVmt6bm84ejAweUJVaW92a0xLdFJTdTdo?=
 =?utf-8?B?dUVRbVhiUjM1MDNiZUNLbDU2RVMwRlhFUVM0K0UzS1ZISFlqS2tiaFRmVWN3?=
 =?utf-8?B?ZnZNaEY4M0RQckhLQ0NVRWd1ODQzTXNuZ0t0SkkxZEovMjN5VlVqSk9rUW9l?=
 =?utf-8?B?UXRPZWlaNXlKMVZJL0hVakU2ZGlaTnBQKzl1NVljZEZZTG15UkJNS3NFOG4x?=
 =?utf-8?B?Zjk3RjVqYU5YWjJBQ2RFbkdsQTd2cmlualZrUlBtTFBuQTZYWEdKSjI2ZjZI?=
 =?utf-8?B?SWVjYmhSUlRldEROV2R3STRFb3BYeDNlc01CdWpBd055L2hNREF3Qk1ES29o?=
 =?utf-8?B?V3lwcktpVXdaSnRiUjdONHl4N09nV3pad0dSVU9JckR1MlVoTGM5TnpDYVNt?=
 =?utf-8?B?S0hEY3JyQStHbi9JK0Q5QzlUc0NSVnIwbjRyRE52OEdNWHdCRGF0VmdiYmpp?=
 =?utf-8?B?SGw2TTFabHFZeVNldzgyMHlLSEJXNW5CaFFwK2VaNDc0SkJod1I1NDV6ejU1?=
 =?utf-8?B?cFMxOUhQcWtsSzVJR2gzeWNVTGthcy9aOVpXVktBcXRiSnFYN1cxWDVBbnIr?=
 =?utf-8?Q?T7yXT/oNIJpfFVcfFR6O265AS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f261ee6-0847-40ae-80a2-08dc313fb4b3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 11:41:26.5296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E90u0laMipFVJGm3TsX3rddHCXXxNwGMHwa0kGUPie3SJox9n2VTbStN/THLjDg9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272

Am 19.02.24 um 12:29 schrieb Arnd Bergmann:
> On Mon, Feb 19, 2024, at 12:22, Christian König wrote:
>> Am 17.02.24 um 02:31 schrieb Randy Dunlap:
>>> On 2/16/24 12:24, Arnd Bergmann wrote:
>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>
>>>> The newly added drm_test_buddy_alloc_contiguous() test fails to link on
>>>> 32-bit targets because of inadvertent 64-bit calculations:
>>>>
>>>> ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/tests/drm_buddy_test.ko] undefined!
>>>> ERROR: modpost: "__aeabi_ldivmod" [drivers/gpu/drm/tests/drm_buddy_test.ko] undefined!
>>>>
>>>> >From what I can tell, the numbers cannot possibly overflow a 32-bit size,
>>>> so use different types for these.
>>>>
>>>> I noticed that the function has another possible flaw in that is mixes
>>>> what it calls pages with 4KB units. This is a big confusing at best,
>>>> or possibly broken when built on machines with larger pages.
>>>>
>>>> Fixes: a64056bb5a32 ("drm/tests/drm_buddy: add alloc_contiguous test")
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>> I've just pushed a similar patch Mathew came up a bit earlier to
>> drm-misc-fixes.
>>
>> Sorry for the noise, I have to catch up on picking up patches for
>> misc-fixes and misc-next.
> Ok, thanks.
>
> Have you looked at how this code works for larger values of PAGE_SIZE?
> Is there any need to change other things or will this work with the
> hardcoded 4KB chunks?

I haven't looked into the details, but I've pointed out before that 
using PAGE_SIZE in the buddy or its test cases would be incorrect.

Background is that the buddy allocator is for devices and those work 
independent of the CPU PAGE_SIZE. So it can be that on a CPU with 64k 
pages the buddy still needs to work with 4k.

Could be that this is work, but could as well be that this is completely 
broken. Arun and Mathew needs to answer this, I haven't tested it nor 
reviewed the code.

Regards,
Christian.

>
>       Arnd


