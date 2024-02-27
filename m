Return-Path: <linux-kernel+bounces-82712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4993C86887B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82141F25FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682EE52F83;
	Tue, 27 Feb 2024 05:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r1oJn0+a"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105DEF4EB;
	Tue, 27 Feb 2024 05:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709010285; cv=fail; b=VQNHSaaZNXAFzATF/36uD7Ww71Z4486N1FMAJJgUtabbpqVYCPWRZ0Qd0a5kYXbZmXtBb/hdN+hPX/wecEjyQggaicPSEj79IB5gvlj14j7GuuEXDT85OjfixMUk/MKUWtXlVb2Q+RqfkVxIgPOiFHe1SweDaACQSfVkGnCdZMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709010285; c=relaxed/simple;
	bh=Za0JswK3JYFqoPRfSCFq2UNs1IyAP3CYnh6uyrE8bT4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KnNwPqF8zSGRjj7Fzu7ZgpKWcWek5lpj64dBrtrry7he9JPIgcl0FIbRcDH1Vlv1Dp4+CYNvo49haM8m1Hs2/g1QrBoxexPCR3qxVMwmK4lHN1lYDfc2i2g6DjwvJwM6mzlIutzKlHqSwTouyQNDZm+3fublQ0jHzbAfiyQW3Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r1oJn0+a; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVtCLAwUMsN2NeABAWNVabuf831BR98oFyfa3ZDUnjAa/vnWPQfh+qnL5MwQAhOE+s17oOpLjcnbL+tg7iPkfYKpLU+tDsE1cFJA1E8OgAEI09WA8C0rKHEBT52Tpo36kFUMfmPU4wnn6QZScBJt5NgVbLzo9r4FXSStclHmj+bRsePtLmlHkEXzWFUfedofxrrQCH4Ai1iqQYChI15Xdd6+qsK7zhVGJsWpaQWc9eiMAayVVmIL50aib6SmaMD32T1UJspu2nUl5ZYcEm9SSz7LQ1Hk/4MdDmDPJuQFgeTRQ4Jhs1GouWvUUsETL3nzzxHy0vMvEYq0/0AhnErfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoQVxdiWsN0ybx8DgFFiSQ3YIW2uZ783XFUp5RHz5pg=;
 b=hVjwULY1SISgtgjbw0W66JmJ8DiIbixBw9g4xaKLd2o/XAHsNmzzvA8uDZoyzNXm0GznsHyyZbOPyhVNxjzUlo6QRFmdNwbcFf/Sf0qd520gdoP9pA4Rb/+Qz654xDqipiCsA8YhZ0PmdV8LtW9Ocqtcaa8rnE9m1wr/S4xXvkXEUtER8knozTzGPLO8cUHaj6zZinSJhypWFMYHdC5cjUrYfWNqRqxNiLtMRrDs9y3O8on/OMlJPNJFwdauXBlENK1v009DgoShFvScHNbHB5wSY3LoPgqHacJlRQAOuh5MBelA6jIq5vK6AWgnI1JCbMTfN67riROAdoZqEKGA5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoQVxdiWsN0ybx8DgFFiSQ3YIW2uZ783XFUp5RHz5pg=;
 b=r1oJn0+a119NgRnly85JWrCdEpRX8ETVz5ddFtEgIc9MXs2M+QXhcz3JudJM+7BNCjqKw9WpNkBD39A2KMpiTALDWzOiHeMGDqnQqDUksTHGY6sU1qcSaaP11GMu1miIEfgGLoSxITaPKsE4ouBQatNSnNxcDO1flChq/Qe7fGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by PH0PR12MB7837.namprd12.prod.outlook.com (2603:10b6:510:282::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 05:04:41 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::b440:9a95:dbfa:ae67]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::b440:9a95:dbfa:ae67%5]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 05:04:40 +0000
Message-ID: <9a314461-3097-41a6-a264-1b109f30d3ec@amd.com>
Date: Tue, 27 Feb 2024 10:34:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/4] net: macb: Enable queue disable and WOL
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux@armlinux.org.uk, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240222153848.2374782-1-vineeth.karumanchi@amd.com>
 <20240222153848.2374782-4-vineeth.karumanchi@amd.com>
 <024fd8e1-8d1c-4073-99ff-ae8c5d123baa@lunn.ch>
 <78730bb7-4588-4038-9336-eec6e2635a75@amd.com>
 <8c0efb9a-d92c-4b9b-be75-498d460f67bd@lunn.ch>
From: "Karumanchi, Vineeth" <vineeth.karumanchi@amd.com>
In-Reply-To: <8c0efb9a-d92c-4b9b-be75-498d460f67bd@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::9) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|PH0PR12MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff61490-057e-4597-998e-08dc37519a98
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DRFoWBmJCsTcwjRGgrTPAnxlx/TwML0Ei8NcNM0MIoh+XLoW3y5EOSSxQLbCNrmePz+ndv0sDwy7FvorDjarq3v09XibB/NvxvzTBfXqsdZ+kHSB0FFJwxxuVZGci8oVZknjm8druJsMD7vPacshl5tN1Q2RS8jRnoYUHWv1M5o1ttCYqNcJwrDfrXBPo03M2yVmX6xxEErtD4tLl2utZIoU5u8FfV+dDbCdKXucRuU0W+uWHoTKZ3eobJPlGNBbT6pvQrHBfuaGVYJX+ft/9m/Fn5ngCvaXdTpad6n3mNb/7vzpJBaV8ttFenjIVsJnrUWe9+EsetSO6Xk3iYHhqmU5gJFTB02EHvYacqYs7PfCDky8RzxXcC4wlkLll357Ya2HQ7Y2M02pj8jIAAPP9q4l5ZB42kRzBD/+x6+k4M1Jyaod1Ry4JUUzsxxyQFM+z+xeiOYpmMYYxZR1B1dVRFRxH48SnVqp1wK2I2zTg9c7jnbaX3yb9TPbSYtO8HbGgMdAds6wbMNZg2/T/ae85HPPW2McFKiT0/iCYZ8SffoYN6c9Dd5givP3h31WGEF5LgMum7M9IQt/nk0OoYrtlT5zWFk0BEbCSe+oiZxo01jN5yzmQRs/5ha0VLhEQR9X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OW1oRTF1bVhLQnN4UUYveStuMkgyMlg3MCt6OHdBY1Rua1V5ekFBSmVNby9j?=
 =?utf-8?B?RVNqbFlGaExlL3I1ZEZGbkVMeVB4OFhvRVduWWs3ZFlSTGRSNW8wNnhhMHpE?=
 =?utf-8?B?c0FkOFdwVG1Tb0xkaFNjMlRFNmVOblNrakRQeGpDa085YWM4UXZwdng1Tm1W?=
 =?utf-8?B?MnpubHBBMkV2a25vN252OGY0S05lK2JneGVmNGZLNGhrNStJd1RsRzdRZmVi?=
 =?utf-8?B?eTBKanB1ZUJCTEcyampJZElWa2tRYjRETC84NmxOZnVqNDUrTE5LZkkxYmVN?=
 =?utf-8?B?WWNVSFdneHVuQStucHhqd3Jsc3RWalpyaVppWE9LUmJUd202cmU2VW5YNUpt?=
 =?utf-8?B?aDhCeW9uMS9NTU9WYVl0MUsyeTNIM3FQa3g1L3RpeWNvZk1NaDNQd29ELzc2?=
 =?utf-8?B?ZnZPQ0NDb3BPTVZuU2o3bk5nRk11azMxWnYvNXhzWDYwVjRjY2xzL0tjd2dt?=
 =?utf-8?B?bEhjOVNmZXRONE01SzdVRkJOQk5KZC8rZEVSRDlhdi95VnBkU3hlUC9JemZt?=
 =?utf-8?B?SDh4V0hXOGJtbHVXUWdlZENRa2gvMHk1Tmd0SzZUWS9rUU9pZE94MmtXWGto?=
 =?utf-8?B?TU9mWjZyWU4zYUxJMXJ5cFViTzBnb01SVitXTUw4WHJjdmNxc2YyNWpRd1NJ?=
 =?utf-8?B?SDcrOG1hTWlCY0hyOWJyTU5qNmNaeXdTT0VqOWdiQk9pN3U4STR3ZXY1Z0Js?=
 =?utf-8?B?N0RRclhJZStBU2VUaGMrd21zSEhFekFUemlxSUp1WU11TE10SS9CaVpycHdo?=
 =?utf-8?B?NWJ5TG82M3NURWUxYWlXVSt2T0Q1M04yN3g3ZjkyQmg0WWk4Z3puWFFxQ25a?=
 =?utf-8?B?UFF0TW5Lb09YQmRHVW9oNGRPT2RBeWgwVlcvYnZSNlA4UkRUSnNjcE5ETnFT?=
 =?utf-8?B?Q0k0b3JkT2hXamU1OGRDYmQxbEJtaGRUTzVaUGt3WFBjY0RNTU9FT0lYS0Jx?=
 =?utf-8?B?RVB5WS9xT3BEQjBQbEpjeWRBRjdrczlDYWRNeVhZRkVHeXlNWEN0dDdGbGxq?=
 =?utf-8?B?dmdTb0p5Rzg0aWEwWmdEbUNtM2JtQnlPWmtIWmlTbTd6cDRaY0o3T0xwQkJH?=
 =?utf-8?B?VHAyQ01KYlpQaDJUUUpBUmVkWlF2QzhTS3RGSjhrM01xQytFTHc3OHN2elZh?=
 =?utf-8?B?aXd2YklwdFQ4NUVaTFhLRm5MakxOMXk5ZTFQNSt1cWpVRXNoVnEwUmxGamlV?=
 =?utf-8?B?ZlJGcHM2WWxCbGx3REpTUVRiNklaU0t0bFdTMWpNenVvbWMvZkU4Z3N6R0ZC?=
 =?utf-8?B?cmkyeDF4VjBkUFpVcU5WK0toSVB5UDdRUDA4dll6WG5GeFJwOWQ4WXAzbUhZ?=
 =?utf-8?B?bmdXR3crZ1ovakN0N0hGcHZjb1NoZGxTVWZvUnhocHgxMmR6UWJ0TWdZemFW?=
 =?utf-8?B?MzVaK1R6bUplOVgyWDR6dnQyV0Vyd0Y4cDJPTUVHeFBlYXZXUFBJOUVQVVFk?=
 =?utf-8?B?dzQ5NXB1TmxuZ01jZ29mWmVqSUYyNnQyRExIZ0RudlhCQ2hQeTU3MExWRlFY?=
 =?utf-8?B?Sm9jREY2bmtZMGE2TGZIOXROZWRqckNLSEhOZ09oNURLNGlJRjhITDIyQXpG?=
 =?utf-8?B?MytOTTA2R1RWVWNtdTBsZTJLWE81NkRENUpld1lYK0Ztc0hmbkllUFpRWFdv?=
 =?utf-8?B?UE5tRUxsVG9YWU9DdDYyQmhSMHl2QnQyRUdVd3hNNG4yM0JoQnhQVWw4ZG1t?=
 =?utf-8?B?STdaSXVDbXRsbzEvektQWDNYRkpNeXFRWDNOSkJBVldrTFlOR29veW56MTl3?=
 =?utf-8?B?M1RXU3BjVmJtYm1NY3hxNmZDa3hoM3BmNDVybzU4RTNrSjRJS1l2VDZEOTkr?=
 =?utf-8?B?WmNNbm9VWnVhVVBmYUR3NWZiM1lrMlJlWVBGeU1SR2NGeGp0NkpoQXRoM0pu?=
 =?utf-8?B?enZGdzQwU2tOY253ZDN6U0lVUjFpbk9tWGVrTW1hZ2hYQjI4cmtyRlJGNnhG?=
 =?utf-8?B?S3Njd1R6cG0ydWFjL0YvUzg0TEJTOC9iRkNrRGo2V0hWb0Q0Um16eENJNXk0?=
 =?utf-8?B?K0FrSnk4Z1FkVHVodHZNUnR2Z0NxdEE2cUFQTlJMMis5VEhyalNUa20wZHgw?=
 =?utf-8?B?QUthNHpUTVpiRlhvYzVjV0tBZHZ5OFZMVkM4N1ordnlwRkVJb1VJVlJsbzdX?=
 =?utf-8?Q?IWJZ0VvblF90n9AtNjOL6npG7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff61490-057e-4597-998e-08dc37519a98
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 05:04:40.8646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WIlAhSmOehbrZ33f1bIPgXPk3+z9Z5csNHDSoKLwm2yjgtrkDmLe1sGNQuNUTie
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7837

Hi Andrew,

On 2/23/2024 6:56 PM, Andrew Lunn wrote:
>> It is not specific to AMD versions. All Cadence GEM IP versions have the
>> capability, but specific vendors might enable or disable it as per their
>> requirements.
> 
> Do you mean it is an option to synthesizer it or not? So although the
> basic IP licensed from Cadence has it, a silicon vendor could remove
> it?
> 

Regarding that, we are unsure. However, based on observation from all 
previous cadence IP's in AMD Soc's, this feature was available.

>> WOL was previously enabled via the device-tree attribute. Some users might
>> not leverage it.
> 
> This is not typical. If the hardware supports it, we let the end user
> decided if they want to use it or not.
> 
> So if all silicon should have it, enable it everywhere. If there is an
> option to save some gates and leave it out of the silicon, then we do
> need some per device knowledge, or a register which tells us what the
> synthesis options where.
> 

I have looked into all config_debug* registers of multiple versions 
available with us and there is no mention of WOL. I think we can add 
MACB_WOL_CAPS to default_config and advertise in ethtool by default.

Please let me know your suggestions/thoughts.
-- 
🙏 vineeth

