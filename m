Return-Path: <linux-kernel+bounces-127279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3206E894929
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959BF1F22D7A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1B5DDB3;
	Tue,  2 Apr 2024 02:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="rfi1Z4FE"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2121.outbound.protection.outlook.com [40.107.6.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFCDDDA8;
	Tue,  2 Apr 2024 02:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024031; cv=fail; b=YNqiqWONLlY2HODUWZvXTNvIPNSNVFP9J0VtP8mPeKddX/O2/SNEGS8uBVaXye0Us9ZOOcJ8b1RSOU3hXs0FtY4B4bKqhESHmBkrA06USRd/rdWuxAgwq7oMq3gLPuV49XjDqGne38wVmVIgkR1Gr6y3arTVaA+Jn2LXdO0tEsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024031; c=relaxed/simple;
	bh=HfNo5fKxw0lnUKu7+kFL4Y8qi2PQvlpi8EmhQAgd8t0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NzNUCKKlp3KMEc5WSuHx26mqi9eCeRZeO7hi7Ps/sPk/tjITjIEse4StPlReMac31MDJJadYKr0xJ0RkqOeaE3YKvmgxr620GOS+6tp/+Gs+qko5MyStPjq9QoQMtZBS1ocXgaT++UTV6ifO2l4yBOVWEcPEVqxsktPvOPFPBos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=rfi1Z4FE; arc=fail smtp.client-ip=40.107.6.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyyfZS+YPRD4/KOClh8q/F6I6xQYiWTQpPgwJ1lWCTNrEZnZBF+w0kIPVvPV2nPvniBrdEGNHyAzvEecVA86Pek+9VH+jinKav1eDjE6l/QV/WTFHXqBsyKzeYsFOz7RB/kGacPJAzJATw06ZauZQeaFbOk7aFPgXipeu/TzTFISI/OWgIzT1Tame44qi0GibwEiMrNpwVD1uha+o0j8y1HoPOIbtW3g3afMwAw/TvVLCcte/FVzJWG2QK4I7owaVWMMC6x+VaJirpnQ6AJqVOpg3uweHhgWlV/ghOXPp88icj2902kdRY58sDJes5m7ejZ47zw7H8fpwqGv3mfVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tzz22RwLv4WPL2XJilbAtJKcc73kv1J/et/8iWqfaMc=;
 b=lwv5W8VWf09hzV7LxIZtd+jmFyDPAthVYTHbKx4qQBHNymMh5LLI8yqpB3bOGVFwyNnbW6TISEf6OOAgmBVkvIXbLNAzJKrdk5FTTcXDfFc+A8o1GOFZqGe+pWaZ3UT/C5spMqYHr5geqpbBrp61Vb2aYeMdJpMfc7A6ZfJjDlJ8KkR+tQqANpI7M4fidsqZJL0ytpsNBodKDPujf9A4KzEPB09ba44tQhUlv3rqmjp0+cUmG9eRBe0ZWcljN/zBpDAfHFH4YP0AQcnJOGLXTEAuDcbMDWnX3+Q1TI40KnP9KTvYTykdfAUPCSAuhkffhugFOaQMH2VoL91NOR/wMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tzz22RwLv4WPL2XJilbAtJKcc73kv1J/et/8iWqfaMc=;
 b=rfi1Z4FErdVvonQCmPGxCyrpIVTdCT1fHiB4DVk+U4vAFm3Fir19ivktlz/fOd7suy4Ttx2wwi5RZAEgvn9mkHvqO+k9sznnj6amLYIlGr+VdgQJAdMOmmUA+T9lINylUad/OYg5DRbLbZwlacbDBLHxfFEvoC4gXqB5cMw8kgQ=
Received: from VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14) by DU0PR02MB8426.eurprd02.prod.outlook.com
 (2603:10a6:10:3c9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 02:13:47 +0000
Received: from VI0PR02MB10536.eurprd02.prod.outlook.com
 ([fe80::8baf:bcd1:cc88:2e09]) by VI0PR02MB10536.eurprd02.prod.outlook.com
 ([fe80::8baf:bcd1:cc88:2e09%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 02:13:47 +0000
Message-ID: <379e258c-6ac1-ad6e-c0eb-bfdd86a2a3c6@axis.com>
Date: Tue, 2 Apr 2024 10:13:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] power: supply: bq27xxx: Divide the reg cache to each
 register
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Hermes Zhang <Hermes.Zhang@axis.com>
Cc: kernel@axis.com, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Davis <afd@ti.com>
References: <20240306100904.1914263-1-Hermes.Zhang@axis.com>
 <c4u27576oazfrlcp5avy3ect3i4jlsmdvi7nlun5qvez3ipti2@ue5jxbydmevs>
From: Hermes Zhang <chenhuiz@axis.com>
In-Reply-To: <c4u27576oazfrlcp5avy3ect3i4jlsmdvi7nlun5qvez3ipti2@ue5jxbydmevs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR02MB10536:EE_|DU0PR02MB8426:EE_
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ezBlxig3TDVA25H7BmFK4praAzcAcGcCzYzNyYHTrUltOU1AO+zL7Ol09aR4bV8rPehv46VBMPa4nWlMwDkPrt/xyYgkErTL6gJGkDbVxtvI7ABBun16C7Mz06/bu+eulU9v5TL46qA8jxbGn8iumkXVFBQHJbiPjcuKoLVqbMIeYPcFUgGx+H7pg1+cvJUndzcaQDjwicUmPMayEOyNFxs5mQ7PJ3p/nHAWy1lOVEqdNIGeXI62MSgBSNsMC5D1f8u6PJYsWnI+g8LjK6m7ItFliMH14bwh627fA+1qe6U2RqLMY2cCOFemMfYXzp5VxmqC5n02aVkfc5REfg/zatIDvIdp9xbiFb/FExEvOBM8iq3SvyFEdf+kG9iIeJa/xeg5nZbueh5VWDD+dAnn0N5yqtAEcQuQgSIzBjeE6cgVlIIMeg5vJYILqICyGbQrbelqb0A722qC7tiL1iha4P6JTXf0B+nu25tsoiT1r/eH1B6irjos1rOIZLwEcuj91dGCZEYAkSYz5EiV5OvXWel5ngPKkKBsQt4ExUYwdBW+lgVDZM0LssQXb8rni2sabSom2XeI0AvjPz3PQ8lHwI1Uoak/0lhhRQs0ZbzJc/anKnwfxsmH5yGyU5OxSADExFpLIHGCc/Wrm4IQdFS7RQX1jt9uHff3BpZbrr0s5do=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR02MB10536.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjFBVkRPOU4yMnRtRTFsdkJPbjUwZkZBeEpXcXFJbTVZZDVtOHNJd0FDU2gr?=
 =?utf-8?B?cmgvNlBCOVFnYlowSWxSQ3p4bkhJSlRJZllFUlptM09CS2hmYmozZHJ0R3l1?=
 =?utf-8?B?bk80TWhXbndBK01nWUNQemFaVHBIV3pMTU4zNGVaaUowZUpxTFo2WHpycWtN?=
 =?utf-8?B?dmZEK0t3bjRpWUhCaWw3TlA5N0dIU3dnQ0taa1RpMTFCS1g3Z1VmeTVuS2Q3?=
 =?utf-8?B?YzJac3I3Qk5LQ3BFQ3ZHYUdicjh1aG1vRGpvMlVzWlk0WGVJcFVLQ0dGQUZF?=
 =?utf-8?B?Zk43Znh6bUVvTDRCVldYWHFzemRlWkhmTUd3S0VBbkdWMXNpTk1ncHN5bmwz?=
 =?utf-8?B?TGk5L1E1YTA5U1FJVzVRL2pvWm91VHhndWZYYjN2bFVxSGRsQkZBTUtkSytX?=
 =?utf-8?B?VXQzLzR2bkxyVDBOYW84TUxwMnlRanV1RVRUUHM5REFjNC9UbTFhb1FzQ3R5?=
 =?utf-8?B?NzVYNkoyUkhVYUlicklRVlU3djhqVXRwM0JWVktDUkFLMFNadnlFMVF5MEdy?=
 =?utf-8?B?YUo1aUt6M0hkVXpsT3JGVkp3UmsxS2xZNjZVQ0gxVWtCZGVxc3R0VVVncTZQ?=
 =?utf-8?B?MUFxc0Q4Lzc4NHZCMERvTHJNM3ZVMzVjS1UvOHJrVjIwbnRDVit3MWd3VG83?=
 =?utf-8?B?MGN3YmJwWDRzVisvNGdBV1FZalRZZVZKTHdRWHVYMUQrSXJ0THlORzZaaFFl?=
 =?utf-8?B?MXY0c0FtbTE3YllvK2doUG9vbjZQK0QydWIzaUxBZ0JmY21FQmVHZWRxeWdU?=
 =?utf-8?B?VDNvektIVld6bk4wVFVCNzR5M3o5aWRicHFpTXVVaFdzM2RHZkJJVy9GK0JQ?=
 =?utf-8?B?S0ljazZsNkpzMkVROFlNMERBVEJNUEovMVV3NkJ1S00wOUNqc01xV1JPdGND?=
 =?utf-8?B?aTJNZ2dINDVtUTl5VENYT1hRd0NHc0NqMUpYVjlaQ2pwTnFTU0RZVmgyV2lN?=
 =?utf-8?B?ZjFHSVpGKzlmS1l0L002QWdaVnRSRytUOHZJYVhESGZDNUxZYXFORDY2R3NB?=
 =?utf-8?B?aU1KZm83ZVJZay8xUnZoVGg1S3JJSndrVThVeVJjQkRtbk40MXhSMmw0RjZn?=
 =?utf-8?B?YlJoclp2QVZoa0NWUFNsS2xrWFlDOW0waHEza1VyUGxzTXNVamE3bVZZNHBI?=
 =?utf-8?B?K1JUeVhlNUFWeVhZaHYrRXI5YmZPd2R2UDdWQXFBOUJlK2oxMGxGbXJYK1p4?=
 =?utf-8?B?NDJJZDRUODdhSGZNWEpqcVdXUmcrYVJFbkNBMVIxOXVEcDZMd01yZWFGZTl3?=
 =?utf-8?B?NUwwVmpvL0krWUkybngxbGoxUnFPQzJ3QjBXY3RZOXJRcTRSNnFMSCtYMXJF?=
 =?utf-8?B?UlNpZ0RBamlmWUtzQlBaN3l4bkpSUE9LWVZ4VFR1L3JqcG1kN29CSE96c3Q3?=
 =?utf-8?B?UlpsRnVPNjZ4KzY4YjRWUmV2SXROSjBUS00ydTRrekxkbFBaczZveUhiQnNx?=
 =?utf-8?B?R2hBdDI0RG5NY1diMldkT1NTS2tsbkMzWDgycmVjZDNmSnpRcjJZNnhmUUZX?=
 =?utf-8?B?eGdFaW1vWUdzSThONXZFS1ZJY1dNa3FySTAvQ0g0bThETnBzeE1vSlJmbHRa?=
 =?utf-8?B?WC9UUTNlbUlrRmJneUxEUTU4OEYvWFRSTzZnbjB6WnpsRFd4bmd3ZGdzZGdu?=
 =?utf-8?B?ZnRUeUE0QzhxZFNHSGViU1MyVXZyeHhEQ0F0bnNJaEVmUWtkWVhCMW13VkVG?=
 =?utf-8?B?Vkx6UjVjd21JNndUMm9TeGY4NXhQKzZ1K1QxYitaRThSWjNtaXU3SU1yUEZl?=
 =?utf-8?B?QkZBekhVaXBSVkU1ak1vdWZQaGQ3YktFUVRieHBncXoya1BRcVRweVVsV3g1?=
 =?utf-8?B?emdyYUtBT0dnUVdVajNRMkZUV0V2b1ZmQytraFZObEJmaW1ybDlEdHk3blhp?=
 =?utf-8?B?NjA4TDd6SVQybENMc3RVdy9DYm9UQnNLRTQ1TFpscStRTllFRHNVY0dybGkz?=
 =?utf-8?B?YktWS2dwWEREeVhadjBtTWRTdWJOUGNVOGZGOE42eXhyaThadzZNZ1FIbnJX?=
 =?utf-8?B?cGw3RlhIZXVFdFM5VjY1VWhrMXduUHhyaW54Ujg2SWQyclY1OExPOTF0VTUy?=
 =?utf-8?B?ZWJmS21seXFFUVJvUWdCdDFVVXhLSWQxcDBseHBJd3h6eXl4OWVKWWpmUWk4?=
 =?utf-8?B?b1ovZzVaUkJQSkNIL2NOTmF4T2RUZ1B4MElSaGhvQ2I5SHI0Nmo1WHNiSjlJ?=
 =?utf-8?Q?IoXivUntx09sKQwdpDbyGUlkGV0hMjFP7bt+BsNLhlnt?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f69ebf5-7938-484f-7009-08dc52ba8742
X-MS-Exchange-CrossTenant-AuthSource: VI0PR02MB10536.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 02:13:46.9580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THoKMroyLr8ajnjizlkQTum/pl/guY7lGI8Ah0Dhp4uRqGvJ8C1IpnjkH6Cpjtiz+P2VtRP4aE1KRlJhhwP1fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8426

On 2024/4/1 21:15, Sebastian Reichel wrote:
> [+cc Andrew Davis]
>
> Hello Hermes,
>
> Sorry for the delay. This arrived too close to the 6.9 merge window.
> I had a look now and while the patch looks fine to me on a conceptual
> level, it did not apply. It looks like you used a pre-2024 kernel tree
> to generate the patch against. Please always use something recent base
> tree (and ideally use git's --base option to document the used
> parent commit).

Ack.

> Other than that I just applied a series from Andrew, which cleans up
> the register caching in bq27xxx and removed most registers from the
> cache. That's something I did not consider earlier, since I thought
> the cache was introduced to fix a different issue. But that was
> apparently sbs-battery and not bq27xxx.
>
> Anyways, there is only two registers left in the cache now. I'm fine
> with having a per-register cache for them, if that is still needed
> to further reduce I2C traffic on your device.
>
> And... re-reading your problem description, I wonder if we need to
> reintroduce the caching for all registers (on a per register basis)
> to avoid userspace being able to do a denial of service by quickly
> polling the battery information.
>
> Any thoughts?

Great. Now I think I can drop my patch since the current code is almost 
same as we expected and still keep simple. Thanks for the latest info.


Best Regards,

Hermes



