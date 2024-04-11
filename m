Return-Path: <linux-kernel+bounces-139996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3818A0A17
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B53286EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB311474B1;
	Thu, 11 Apr 2024 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="qEHvKVVG"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2132.outbound.protection.outlook.com [40.107.244.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F1F146D5B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820960; cv=fail; b=o5W9BxBfZBR75E0bFuk6vZzEf0yf7Fz8izkomg47gJqWZPsW3b4/FHqfghiyLFPQDMQH6EfvBunKo35W5eCOrKi3ai/3BSPCeDDoclBWta7Fi4iGiCQzoaAFHjwRoRyONwprjtP5OzQyYkdWp8mdjgEddNWfbFBjwG6LoGlSLdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820960; c=relaxed/simple;
	bh=/U+qsd4g2xgEe2oV2ha4xyqKyfjWvqGe7DRHW4fCitM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=uybqETtd3tblB3DjW7H+9tasZUdZlEu4ANRM8UO5FK+mNS5dP5LElUT2qDTGD//TNKizQg9vuEzoTNYucW1CReKvhNxNftX3xdGWRLd1TfM79UYhFxmwS4Xpj1lhq3anZ2A71ldlHQu7S2c6tHD+AogbDvZ88FR/00YffptHkxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=qEHvKVVG; arc=fail smtp.client-ip=40.107.244.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGX7aDi0ewMv7rGtu/gPdg9qQqrFo6Fk/0aMv+dwVPzwaRJfbQ7FnzldvXnDoQrmnmhbHlTCn4L58yGK/AM4S1VPg7N60JaWPe2xc/W6OAFbfv1EHx+GbwV09Rh9Lou+1s02Oe47wOq0ikOixU+ZRUnVMWqP7yWDnPx6F5Cb5HLKzEIMl+/ypsXa2eGMGdQHqpAEcmQ3v7Bxf1UDixzhf9ggxhcDq5+HLDsJB58dfe0M0sL30reB/5cGXhFL/g43yrpULY8T06ntYKZjkQhhAHU5MFO54BC2NlYwu3z1yl1o/Ghg064TFZBYpgTJ4L5AhzdB66YOMs7cHdGb9jchmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsjRxTukVO31/H0pxAgtJqiJgotGfkdrQFMshdFsx7Y=;
 b=WOo2+lUf6cQbxXPvThPja2grxXTfVaoHtkulJ9IshC9czBaWk0zyaLr2hPxkvM7UeMLpDmXA4kvnzk0MIhG8lT99rjQ71zdkYfY+ldheb26CKLO+kPtVFZceuT+6VL5JWNDyd/Zz2REZbmILP56oC/cnXguuHH3VQMNIOaeQlR6+l0eXSDsLb+kvR08EfFU0MSW57ZzdoiSgwBCDD5Rx40hXYPQEW3Cc0OOjEY6/w5HuPfwgzbkEMoczfGCaiyzKITdzDTU3Lrwilw+0uh2uFDecWH4srLQFeoZhgE1owktgZJJTllDMEwU1ktpG54ZlqWPu3B5wZt4+mIqftc5P8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsjRxTukVO31/H0pxAgtJqiJgotGfkdrQFMshdFsx7Y=;
 b=qEHvKVVGKWL9VCMKTDdnzWCarnTnVa2r7cqyIyglHOCHvHYvn+cJCjSSoflHVDKeOUdYR5JSBXdnLorl+0aQGExaY/3icomezDBLZc4gKlKzMapMisbiFRknvUAjofF06gDW4Snlvm8H97htHmXesqxDUKChMlYUchMs9hBZ7Ww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL0PR01MB4226.prod.exchangelabs.com (2603:10b6:208:49::30) by
 CYYPR01MB8411.prod.exchangelabs.com (2603:10b6:930:bc::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 11 Apr 2024 07:35:55 +0000
Received: from BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26]) by BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 07:35:55 +0000
Date: Thu, 11 Apr 2024 00:35:44 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    Besar Wicaksono <bwicaksono@nvidia.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, Raag Jadav <raag.jadav@intel.com>, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_cspmu: Don't touch interrupt registers if no
 interrupt was assigned
In-Reply-To: <726d6946-6fc8-4c53-86ad-385ab24fa4c7@arm.com>
Message-ID: <ebeef2f-8326-3752-7374-7b2514fe9563@os.amperecomputing.com>
References: <20240307193104.58302-1-ilkka@os.amperecomputing.com> <042bbb32-481e-40d8-a46a-472b724ec33f@arm.com> <89d7ff41-ce2a-fd95-ebfc-4df914efd4c8@os.amperecomputing.com> <c2e3e77c-ba50-4228-9eb8-c8fbcc84edfb@arm.com> <8fdfceb2-90b3-a1a9-fa88-a45ece30c0bb@os.amperecomputing.com>
 <726d6946-6fc8-4c53-86ad-385ab24fa4c7@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:610:cc::23) To BL0PR01MB4226.prod.exchangelabs.com
 (2603:10b6:208:49::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4226:EE_|CYYPR01MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 0445d817-3157-48d6-67ed-08dc59fa059b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f5AFC97lLGglH/6Fheaubu7z41NpKxpCu6KJQRxgAzE3mASpTnW/uQ7VHzMoQpCuIBXNSrg8a/b3tVNfB2Ou9+eE1aOfANTN9AKdIOiwZO6p/l7UhZVFIar/gjOa+uS/P4fYlpy23mgR/GzwA8ZG/9JXGbJFmQN+lx2pwuZzWaUQ2U6ZWzg9pW8VIPS3gmJrdU+x9TslluHJq+HHDUhQFvGoFjtRH8s432N1DtPbe0NvMDVoNmcCspagWudZJZ1igEZypQxpSb6PyzaYhtLBxhFElkx9nmfGWL6Q6xYErT51/rKzdpI+5dKTB4pyT+eqnmoEUXhsV2VQshw7D3tIWUogqvwQR12FJr6SyMujXabfMf4aDm4ZJkw3HpE3rZFW7x1doVgILod0rbmplkIdnjeGhbOuAZbUHFHm/XLJkro/x5L67fmLXFjVHzr0D++fN+M/Ov0+Y+fW83IgVA9qb5ARs5wF00sYqHDST1Uh6O86PND7AOTFDM9LmCuK9OWtq/zy6I4sM5/wue1RH+Wcw03ineEmji4CFQy6ahbYtwXazs9vvXpMgUGacOoAdajzLP5IuE3OerzuLxu/F4nrOxaMsDjOHxBQHbiExVgGHQ+5tRueDusZSn/6oH+dhQh8zIIDSGxjou3ChfF8xoLvaGgMLLW+dou+PfmqthuOoRqtYHvziJnqF47a8ENfOiLrlwCzA57hg8pOlr4aZa0lRoskf7z5gj5pfH9jklorXmU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4226.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yizhfWjMMxSF3NjmhikizE0ibVKCDSTcrnD0YHWWtW92TNpQN6/oP6QMDs+Y?=
 =?us-ascii?Q?VbV0q5WkyU2cd4OKS5UVkVk9Iil1nBg1LfmBy2SdSXDgM2g9rtNyPRov0IB1?=
 =?us-ascii?Q?aIMSDwEUt38EAGj6gGy17s0CqlP4/nejYw66wyck/g4VjIjYBFwfG98DqmiO?=
 =?us-ascii?Q?lZgp7TlZwrgGALLtko3ak5P1wt9P3ryk9ACkxTplelLHfhVa/ckjrMzWPG7I?=
 =?us-ascii?Q?g2V8MokcsF7aL0+d8ou2Fk8Gf0fvvlqE1t8NZCmQqfytCVZUtzj1xPRo0nOq?=
 =?us-ascii?Q?4tRUkqPhemXRsQ1D8y5P9+830F0eMiFDBm7R0HiioTL1XDwlA2JOQiahgDyy?=
 =?us-ascii?Q?Mgf8d4Heu8OB5XiVpFLGc+Hwj4qXBs2L7j1AOwi08JAQ4K6MTQcShB5nGF7u?=
 =?us-ascii?Q?CRSTTIqMWFHeFcBFTGZK/dc/YJntv9qVPrOMUy4mBuerH7XvHIvnWm4fwWeY?=
 =?us-ascii?Q?MbKvf1xZUj8k6WtQ9h/escbbwknJDjKlRMl03ACY3SkBI49RJioF0fq8dcyW?=
 =?us-ascii?Q?wLoWI1ukr46uB5pg4fjXyF4Ty4oB87ppOgwueY70Yp9625Twge0Nvj8Zpa08?=
 =?us-ascii?Q?MkoK+g4Vl5m34UWT11Pb2Ev5gu7uyyD7YKY5/qnJk1JlOeaITRacltYLR37g?=
 =?us-ascii?Q?nLzSDvg/iPpWYWF/MN55GDnnl/YydTg70AkzKKo1A0EbciHVSLyeZqWRaXSG?=
 =?us-ascii?Q?WSKi0fJbvEPNlS36skmY51069hpVoQ7/rYgM9NICp/v0wonB7ccy2psCqPkd?=
 =?us-ascii?Q?wboynkXyvXBOklglDabmdGN+6rdwb8AE8qmeEEfXq4fL2KuZpkiZy5Cf9Pgd?=
 =?us-ascii?Q?fKKgzExZ0jCd0GwGYcdvN3wVsCJ+6+NXD22NLoyG9fouHa9sVsRF+WDYXwQn?=
 =?us-ascii?Q?cElODQcX9bxfbJz+YnOfGiIObEavZTtKl1p+pqXmSA5+AGk6nx2354tjkbek?=
 =?us-ascii?Q?3KMlOOHypCpT/0BVPF95gaVNrYdza7agFu2C/afQbBqW+53y44KO8KTcKMuu?=
 =?us-ascii?Q?CS19h7doZL6dOPaIJQiH73VsrGMoul3sSVjM83FjTO8ZT2anceNBqujRBMv0?=
 =?us-ascii?Q?6o5P5GhiOPu2AvVpjyMdjxsVVrQrx0p8FjKccdOCFy+07cqweEA8VnfD3Rnr?=
 =?us-ascii?Q?1tu+axvMCao0SIQqhTXstQSliQVijzIQ9N3ypPJHff0hOFa9GGd61fvIUw2k?=
 =?us-ascii?Q?iJd+EkjwUOshWuniGwhv5o+W8TjQX1vcfgHLmiMk8M4DNuVTAW+Hx2hddzCT?=
 =?us-ascii?Q?AgXAm5+MOtHlsbZXyyMmGHiIxE+EM8r0ypcvagpaNXeaVa7Yg0FgUKUP7OVz?=
 =?us-ascii?Q?uFgCYj7mxnTElrl5/z5qoxmW057bKOljlzUtyWBAATabL/Xlne6+dpUAZ6nX?=
 =?us-ascii?Q?7VgD45dZTsdORu6ddrePkTIkVrGBmBxDiqd7FoinQ1y1qD2IJI/euDhB7zxf?=
 =?us-ascii?Q?l4bkRz85CvC5NVe0BqiaVEFYz2PONojZvX4tU+33DQu1tG64C7QV0NrQLizU?=
 =?us-ascii?Q?AJoTE2225c0dKxkfMjsLcZb/d/zTHgpzy2t+WfGsU7ZCWTsOIki23C6oqcBW?=
 =?us-ascii?Q?3Itz6ks3U7X3kxZMsVaITTEbvuppX7Ip+gMuCBf79q6tBHEfD47io4CJhTOG?=
 =?us-ascii?Q?pugYBqN0eLyyag7MsPbJ480=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0445d817-3157-48d6-67ed-08dc59fa059b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4226.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 07:35:55.1945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xBj3ur0cod0l/Vym9Ku+x1qmm1H+ddG2tT1cBeL6OHnYiUBZZjUSciJnFPRsIy2bjuiRbdw5gA4jD3STONemgkweZyJQa72Kd0wz9WuCg7Zgpeic32dNbMFFIIUy74N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8411



On Tue, 9 Apr 2024, Robin Murphy wrote:
> On 09/04/2024 2:05 am, Ilkka Koskinen wrote:
>> 
>> On Mon, 8 Apr 2024, Robin Murphy wrote:
>>> On 2024-04-05 11:33 pm, Ilkka Koskinen wrote:
>>>> 
>>>> On Fri, 5 Apr 2024, Robin Murphy wrote:
>>>>> On 2024-03-07 7:31 pm, Ilkka Koskinen wrote:
>>>>>> The driver enabled and disabled interrupts even if no interrupt was
>>>>>> assigned to the device.
>>>>> 
>>>>> Why's that a concern - if the interrupt isn't routed anywhere, surely it 
>>>>> makes no difference what happens at the source end?
>>>> 
>>>> The issue is that we have two PMUs attached to the same interrupt line.
>>>> Unfortunately, I just don't seem to find time to add support for shared 
>>>> interrupts to the cspmu driver. Meanwhile, I assigned the interrupt to 
>>>> one of the PMUs while the other one has zero in the APMT table.
>>> 
>>> I suspected something like that ;)
>>> 
>>>> Without the patch, I can trigger "ghost interrupt" in the latter PMU.
>>> 
>>> An occasional spurious interrupt should be no big deal. If it ends up as a 
>>> screaming spurious interrupt because we never handle the overflow 
>>> condition on the "other" PMU, then what matters most is that we never 
>>> handle the overflow, thus the "other" PMU is still useless since you can't 
>>> assume the user is going to read it frequently enough to avoid losing 
>>> information and getting nonsense counts back. So this hack really isn't a 
>>> viable solution for anything.
>> 
>> IIRC, what happens is that kernel will disable the interrupt eventually due 
>> to unhandled spurious interrupts making the "working" PMU also useless.
>
> Indeed, but if having one inaccurate PMU is fine, having more than one is no 
> big deal either, right? The moral of the story is that hacking the firmware 
> to lie about the hardware is just not a great idea.

Depends on the use case, of course :D

>
> TBH it's always seemed a bit broken that we allow probing without an IRQ but 
> then have no accommodation for overflow if so. Fixing that would be a good 
> thing in itself, and would at least have the side-effect of allowing your 
> hack to work, however much I may disapprove of that :)
>
> FWIW it is still lingering some way down my to-do list to factor out the 
> fiddly IRQ-sharing/migration code into at least a helper library (if not 
> further into perf core itself) before it gets copy-pasted much more, and it 
> occurs to me that I could then easily factor the IRQ-substitute timer 
> approach from e.g. arm-ccn into that as well... The more I think about it the 
> more I might just convince myself that I want it for the driver I'm currently 
> working on and justify bumping it up the list, let's see...

That sounds like a great idea. Even plain helper library would keep the 
drivers a lot cleaner.

Cheers, Ilkka

