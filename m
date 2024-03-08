Return-Path: <linux-kernel+bounces-97655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B7A876D2F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0F31C219D2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AFE3613C;
	Fri,  8 Mar 2024 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TSnI3pTh"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2750015AF;
	Fri,  8 Mar 2024 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937317; cv=fail; b=knG0s9qmix3Pf+u/NyI81pW8Mq1C+yTvYq9nyc4u+2UorNDPM14tMXwBYWQOaG7tJi4JdXpGGcFreXW+Jn7IpdkcxYJdSpY2Jh7/1rbEUAzO6vZRUGBNSJ0MFOjAJJddEWzcEyhr2S+hGi6IRDgCGqwD3eg1YN4mQyctWy/ZuWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937317; c=relaxed/simple;
	bh=5N3zDJi0CboX7wY2vG/1skbjWTUJrLaM5AnyBAdZZEM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=ZvLXe2cDg7IRegsJvoQ7z2IMTg1nJlNSDnrlu+U9L8Z4UxIkfYRdukA0yI7KAtxdokSGWEaqQNVqGdvhOIhQ/GryZ2Pz9HQ7m7FkLcbBdmzpzr/t4RVjBRhZFAWFXy4f4wy7mneu3rPyBuU2gLUYk6BTEzn0exPpnPcIHpCib44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TSnI3pTh; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCxkTRG97TDSBKrY0GThuwXIABlpI4qZsjqY35WYVRG7d4lhmQZnrCEPxVUfEPj1RdeLamY6nnsVprG3x56oyf1XkEO0wF4UGw7rRiuTdPc0O5uY4hnlVzw8PzppdjtDB+fg0cg9MVd0PXJ3AAVVcNpBzNcfmnCwK9sYOxEKwWL3Y4GC9PODVbm9WSHL9LN0lVBgudzvMAmfRj38IW00O5y5Xu9VsdKwQ/uhyvNyURv8QPXrbot8ffoj33ZE+82pFIElu2OoAstSfIDg1dFz/3Q9WRIkSd6DmWO97JcI0uxMqG1ipD4pDcwswi9EE/gQcVGKJqF/YaRJ4L1cIt5zPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBAbvkyFEZCSHALqZi4y9RxDoKyc/o3csqdSNOeX8s0=;
 b=WM2cALviSs0C16uu21Q/2qCZXDotNftuMsDJunps/43BO+is4QzK5etLdPasgWqbPAvY52bLlH/P59vJBAUJPVGDPbQHzqv+AKQ34JV52VRQMNg7EqyLki5jKit9K6p/QI1m5c4KKtJOgUuNHK/8uSYH4OvJ3oTKgHbou4HpW3GKhtrSTUhkjR0gOVSKpRJdSbimst7GYt71sXDTrJ8jNf1Jz/ivft2gvNd+WhAsMc8h9RgDbbBj12wKW76N1gftULIEXp/J0qPc9zleMJChBEbVu5d8ukFZI8IVPy0KjrIJQkqaNsJR0u/9+CSPo6ORdMUrqTNG/zSa9Tg+kB/osQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBAbvkyFEZCSHALqZi4y9RxDoKyc/o3csqdSNOeX8s0=;
 b=TSnI3pThsJ4SuF5juSuYOpRdcVB27t2eZA0DhjVLz0lYsXswOzQDdKkwTjtnzp7E3fqZ8j1jKk0FEzl0K9HbydGgrmEKOwmLCLpfuM9VE9IsRe+LeNgtg9qPvWU4TWLVktOvuunSLJAmzri2NYRNJ4YMuDnw/BOWUkgc6KUFjICUlSwoLed6DEbV9xyJ6aUjWcpvXKuBHX25kXARF+Us1P8ilmJ2y1yVar0VVhk13jSuKGQ/KJOsWCzBMgORL1AXP+rfxhBNDjomXsVDED2k+nYdWpwRf73oCn2hPKjBFo9OtNu91YCTJcmy2GynL9q4VXav2EwnOV/yWAzqObIUjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 22:35:11 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 22:35:11 +0000
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240223192658.45893-2-rrameshbabu@nvidia.com>
 <abbff26c-c626-42ce-82a9-4dc983372de3@intel.com>
 <875xyex10q.fsf@nvidia.com>
 <a84df9ec-475d-4ffc-a975-a0911a57901e@intel.com>
 <87il2evhtk.fsf@nvidia.com>
 <ec969f62-a1bb-4287-a4eb-083201134bae@intel.com>
 <87le6tvpq8.fsf@nvidia.com>
 <d030d02d-150d-4337-a063-69da28049548@intel.com>
 <87edcljnp0.fsf@nvidia.com>
 <b2862eca-bff1-4def-9ac2-2ee426d3c6dd@intel.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Saeed Mahameed <saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan  Corbet <corbet@lwn.net>, Richard Cochran
 <richardcochran@gmail.com>, Tariq  Toukan <tariqt@nvidia.com>, Gal
 Pressman <gal@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Ahmed Zaki
 <ahmed.zaki@intel.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Paul  Greenwalt
 <paul.greenwalt@intel.com>, Justin Stitt <justinstitt@google.com>, Randy
 Dunlap <rdunlap@infradead.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Jiri Pirko <jiri@resnulli.us>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Dragos  Tatulea <dtatulea@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC net-next v1 1/6] ethtool: add interface to read Tx
 hardware timestamping statistics
Date: Fri, 08 Mar 2024 14:30:24 -0800
In-reply-to: <b2862eca-bff1-4def-9ac2-2ee426d3c6dd@intel.com>
Message-ID: <877cice4ip.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::28) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4a5e08-fc92-4b66-ea38-08dc3fc00405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RIfANj589rT0hjmpLkPdByx49TVWFVc586YbqFIdbsoerBymfmZIb802OWU71KohZsbKkSh3UGl+plo70xEu+tK+x1jDnLUxkC660V43JuwASKtHdAobznHzz90oBpw74++4tIfQf6ggoNbNVlWti/041FCgQgL4KoFBO6wJkCN6Jeej7BiaqHCI5EllTEE7aMh90TiqPQ3sb7C/d4HOAfo2GfZdQqIs/XtvdFph7ysnQgQDitiLfSJYbvuzKmlkmpam9jPyllurWhKz+4gX4jkLX5pc5kDdZ4uiXGYIq4nJuBolM7DdUYXivv76nDcfsRZtqr5CizhGRjqD9F5eY49yC7yWp7pwaOzSROurHOCfGYKtw2FcPWaj0vrgZvgBR2f/8boBm62a+/oU0dKTUDpQuhL51A1ZTVUVPWZ8sPddOv+v024a5h9T7od5fHMNM/K/8MhaE6RkSJxzd/IQJowdBu04Ua7ugvbEio20bBhy+faJjZubzshVYaVMzyb3qHFEUC8DhCNTSFcycRRvmmFzQzIwx26lbXhTfta1/jE1qPFaOpeJvTXfaebjkroOaGkmIV8D6wgK2U9isSEVvbXFBpxX5Ho0X9okjpHS9zsoFsz+jcrXZ346i7BveXUVV/SpSRzYDxf6po0TzzHd5RpdiJ07OfhG05SNeBiQIcU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xHkv6e6SRrtONUR3zU4O5/tzNL37AMSTQjzv46iAbue1wolXdxnE1RP/AgbE?=
 =?us-ascii?Q?ND4CQ97146hft06EDpKnK3yir04AM/Cgo4xiutkjvOgdbhtl7qv4lVDig92d?=
 =?us-ascii?Q?GVybhWdK4s1rZJTK/FFg1LIMiqt6ZCRt1goBw1e0bgCXq2Grw6jSZYWakTPL?=
 =?us-ascii?Q?3RTDVTw0z0y82+haTiSYdog6GztWPjbKMXdjQDnP3D0YVwc51+JYbnMhXPgo?=
 =?us-ascii?Q?HoDVfSELUCCGQ1UY7n8Zr0Rtx7XquzhLkbQojnyPoEZ1vFUuK0Qgvtm7XDFq?=
 =?us-ascii?Q?4TsXrgudZ91+Oto288jjR/+DPriqIo92y6mJIytxsP+XbLR7AQveH1ufHDBl?=
 =?us-ascii?Q?tHc11UPpvXix/sRrKyhDvtbNYJNJcmlouLl2VCh3v4Qu9oaCT1cPll666ASA?=
 =?us-ascii?Q?Fj2PE759cGqXHF89ZeQlLKgxrSsnOHcEcbSl8cODKl+0BIcAKV4sGkIPhviY?=
 =?us-ascii?Q?1mZC39VOMuuTQcHROkPB4kiatVRuZ3CLh9EItH+o+L25o5Xyz4YxGou5BjGC?=
 =?us-ascii?Q?jYzuJ0xgS9/fvUbHgnmaKc2fS/T0zQL7k+tTzRYZeageDX39mjkRao8phhNL?=
 =?us-ascii?Q?K74yaPUuiZZi734VIy8a/754vP5KJeHpq7R9RhT2GETeFfsNqGXk0VFjjqBd?=
 =?us-ascii?Q?UlduJ2ZM2A9z9l9SIkyZJIUcMVjqbQhfTK+vrXghyo7b75j6fTrM9NNGUocX?=
 =?us-ascii?Q?4CsDEgO801U8sVpUJf/JWro4ggpLPqpXeuEeK4UE3dl+4Qv9tT7UxJxx0knk?=
 =?us-ascii?Q?MAu6oMuhN7oPUOb9pvUP/70fo08NY9uHosnOBdXtsSFJNZjf/h9GvlqovMFx?=
 =?us-ascii?Q?NPh4EcyH9Ib1ajl8v+/8JZwlm/pguNs1w2HMttQYjMZEfUMkb59lG69vQi1u?=
 =?us-ascii?Q?+dC4A/ztmLIPuSWcqUErqLwVpAmXE/jFsvwIsbHAT47gN53ryta0E/Hja787?=
 =?us-ascii?Q?30UY26L8rskIkFLEGEQ/QYrtqGEyTLWXwuzhNx7eKjT42IETTosO35vYyZos?=
 =?us-ascii?Q?D+KaYZwPyfb8pBP3xwOHgePXE7a4pxLo3MIWNsDvSdnkISXnhW3lPVUGCorb?=
 =?us-ascii?Q?Z4aqiT71PRP9ve2ndXiW5ERm1TX3fGtS7JYZZhAg4lP206M15sZLs5kuNT1f?=
 =?us-ascii?Q?WOW8sdAzTgeSUP5NOWN6JAV9vDOX1HRCilrMyBDT6hDRvGCQCKVwZ7szPgc/?=
 =?us-ascii?Q?DJWUadmNoF9bjtPbf849nZYSNDzKNbERULHbQ+FmbgGg159vUwJIlmumZPE+?=
 =?us-ascii?Q?PIEVYJW6nigMvyekcNvCGbg1yX1bwu+zQF/F0/8PO4Cj2Pg+qJ3HxLLRoZVF?=
 =?us-ascii?Q?1wml4sDRzfhQ5Rx4izdGEiz6TfmwzLTUBWmjIvVOM9Nz7zIKw78ktzuRBxjT?=
 =?us-ascii?Q?cruhKg5yqsGlBqbL3JQX3Fza1vSAbo7LSsHOk00WI0Ul/FZMbkUwo2MlGzOM?=
 =?us-ascii?Q?622z/KwapBeDY0EzEj3eOqL57I2c14WGyrMDY7PBcrElBS6HBDjYBHcWAZ87?=
 =?us-ascii?Q?k/hHwbJN5oj0dPNigN9ayyr36yre8L2bYBrKFBaGjGHC6l28shYtt2eS9CbV?=
 =?us-ascii?Q?wyHwRXj7sXGnSqE4hdKg8sSqtIibYbrIZBdrfBmz2uEUY+lhOCuJN+UE5cWO?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4a5e08-fc92-4b66-ea38-08dc3fc00405
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 22:35:11.4992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+gpGFbrohkRJxwj0X5+ndxVXFxzZ8uOkYb+su4xe7hMVl6CMNSUdekBIy7/sBxcRa6WKNMEZxh5z7M9tod1jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871


On Fri, 08 Mar, 2024 14:28:01 -0800 Jacob Keller <jacob.e.keller@intel.com> wrote:
> On 3/7/2024 9:09 PM, Rahul Rameshbabu wrote:
>> 
>> On Thu, 07 Mar, 2024 19:29:08 -0800 Jacob Keller <jacob.e.keller@intel.com> wrote:
>>> On 3/7/2024 10:47 AM, Rahul Rameshbabu wrote:
>>>> Hi Jacob,
>>>>
>>>> On Mon, 26 Feb, 2024 11:54:49 -0800 Jacob Keller <jacob.e.keller@intel.com> wrote:
>>>>> On 2/23/2024 3:43 PM, Rahul Rameshbabu wrote:
>>>>>>
>>>>>> On Fri, 23 Feb, 2024 14:48:51 -0800 Jacob Keller <jacob.e.keller@intel.com>
>>>>>> wrote:
>>>>>>> On 2/23/2024 2:21 PM, Rahul Rameshbabu wrote:
>>>>>>>> Do you have any example of a case of skipping timestamp information that
>>>>>>>> is not related to lack of delivery over time? I am wondering if this
>>>>>>>> case is more like a hardware error or not. Or is it more like something
>>>>>>>> along the lines of being busy/would impact line rate of timestamp
>>>>>>>> information must be recorded?
>>>>>>>>
>>>>>>>
>>>>>>> The main example for skipped is the event where all our slots are full
>>>>>>> at point of timestamp request.
>>>>>>
>>>>>> This is what I was guessing as the main (if not only reason). For this
>>>>>> specific reason, I think a general "busy" stats counter makes sense.
>>>>>> mlx5 does not need this counter, but I can see a lot of other hw
>>>>>> implementations needing this. (The skipped counter name obviously should
>>>>>> be left only in the ice driver. Just felt "busy" was easy to understand
>>>>>> for generalized counters.)
>>>>>
>>>>> Yea, I don't expect this would be required for all hardware but it seems
>>>>> like a common approach if you have limited slots for Tx timestamps
>>>>> available.
>>>>>
>>>> Sorry to bump this thread once more, but I had a question regarding the
>>>> Intel driver in regards to this. Instead of having a busy case when all
>>>> the slots are full, would it make sense to stop the netdev queues in
>>>> this case, we actually do this in mlx5 (though keep in mind that we have
>>>> a dedicated queue just for port/phy timestamping that we start/stop).
>>>>
>>>> Maybe in your case, you can have a mix of HW timestamping and non-HW
>>>> timestamping in the same queue, which is why you have a busy case?
>>>>
>>>
>>> We don't use a dedicated queue. The issue isn't queue capacity so much
>>> as it is the number of slots in the PHY for where it can save the
>>> timestamp data.
>> 
>> In mlx5, we use a dedicated queue just for the purpose of HW
>> timestamping because we actually do have a similar slot mechanism. We
>> call it metadata. We have a limit of 256 entries. We steer PTP traffic
>> specifically (though we will be changing this to any HW timestamped
>> traffic with the work Kory is doing) to this queue by matching against
>> the protocol and port. All other traffic goes to the normal queues that
>> cannot consume the timestamping slots. When all the slots are occupied,
>> we stop the timestamping queue rather than throwing some busy error.
>> 
>>>
>>> In practice the most common application (ptp4l) synchronously waits for
>>> timestamps, and only has one outstanding at a time. Likely due to
>>> limitations with original hardware that only supported one outstanding
>>> Tx timestamp.
>>>
>>>> Wanted to inquire about this before sending out a RFC v2.
>>>
>>> That's actually an interesting approach to change to a dedicated queue
>>> which we could lock and start/stop it when the indexes are full. How
>>> does that interact with the stack UDP and Ethernet stacks? Presumably
>>> when you go to transmit, you'd need to pick a queue and if its stopped
>>> you'd have to drop or tell the stack?
>> 
>> Let me share a pointer in mlx5 for how we do the queue selection. Like I
>> mentioned, we steer ptp traffic specifically, but we can change this to
>> just steer any skb that indicates hw timestamping.
>> 
>> *
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h?id=3aaa8ce7a3350d95b241046ae2401103a4384ba2#n71
>> 
>> Then, here is how we manage stopping and waking the queue (we tell the
>> core stack about this so we do not have to drop traffic due to some kind
>> of busy state because our metadata/slots are all consumed).
>> 
>
> Makes sense.
>
>> *
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c?id=3aaa8ce7a3350d95b241046ae2401103a4384ba2#n775
>> *
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c?id=3aaa8ce7a3350d95b241046ae2401103a4384ba2#n257
>> *
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c?id=3aaa8ce7a3350d95b241046ae2401103a4384ba2#n397
>> 
>>>
>>> I think I remember someone experimenting with returning NETDEV_TX_BUSY
>>> when the slots were full, but in practice this caused a lot of issues.
>>> None of the other devices we have with only a single slot (one set of
>>> registers, ixgbe, i40e, igb, e1000) did that either.
>> 
>> So we experimented that even with a single slot (we had reasons for
>> testing this), the dedicated queue for timestamping worked out nicely. I
>> really would suggest investigating this model since I think it might
>> play out nicely for the Intel family.
>> 
>>>
>>> If this queue model behaves in a sane way (or if we can communicate
>>> something similar by reporting back up the stack without needing a
>>> dedicated queue?) that could be better than the current situation.
>> 
>> I personally really like the dedicated queue in the device drivers, but
>> if we want to instead model this slot management work in the core netdev
>> stack, I do not think that is a bad endeavor either (when slots are
>> full, hw timestamping traffic is held back till they become available).
>> I do think the netif_tx_wake_queue/netif_tx_stop_queue + dedicated HW
>> timestamping queue does work out nicely.
>
> Ok so if I understand this right, .ndo_select_queue has the stack pick a
> queue, and we'd implement this to use the SKB flag. Then whenever the
> slots for the queue are full we issue netif_tx_stop_queue, and whenever
> the slots are released and we have slots open again we issue
> netif_tx_wake_queue..

Your summary here is correct.

>
> While the queue is stopped, the stack basically just buffers requests
> and doesn't try to call the ndo_do_xmit routine for that queue until the
> queue is ready again?

Yes, that's right. Because of this, you can avoid needing to report a
busy state and just let the stack buffer till the device backpressure
for timestamping resources is released (timestamp information is
retrieved from the device, making the slots available).

>
> Using a dedicated queue has some other advantages in that it could be
> programmed with different priority both from the hardware side (prefer
> packets waiting in the timestamp queue) and from the software side
> (prioritize CPUs running the threads for processing it). That could be
> useful in some applications too...
>
>> 
>> Let me know your thoughts on this. If you think it's an interesting idea
>> to explore, lets not add the busy counter now in this series. I already
>> dropped the late counter. We can add the busy counter later on if you
>> feel this model I have shared is not viable for Intel. I wanted to avoid
>> introducing too many counters pre-emptively that might not actually be
>> consumed widely. I had a thought that what you presented with slots is
>> very similar to what we have with metadata in mlx5, so I thought that
>> maybe handling the management of these slots in a different way with
>> something like a dedicated queue for HW timestamping could make the
>> design cleaner.
>> 
>
> I think I agree with the queue model, though I'm not sure when I could
> get to working on implementing this. I'm fine with dropping the busy
> counter from this series.

No worries. If you are interested in further discussion or any kind of
RFC review, I am open to this. If you feel this model is not
satisfactory in the future, we can discuss this and then look at adding
the busy counter.

--
Thanks,

Rahul Rameshbabu

