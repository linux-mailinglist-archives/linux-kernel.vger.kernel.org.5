Return-Path: <linux-kernel+bounces-59896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 256A284FD0E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AF61C20C5B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088C485C56;
	Fri,  9 Feb 2024 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zq9zsywz"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CAB84FDC;
	Fri,  9 Feb 2024 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507666; cv=fail; b=BQYMyR1Zhh1/FNpD+XKWd1i7goejJQ4bVftM7l2nkLnVaZDVQF3TPonBloiu6+8SKDuR9DaPGO06nKDCU3ZACYHclkpHaHyvKD+rz8rBUG+knn4r6ugtxYt92jqz1uzQUBi82n8H2wQJFEdCJ3Dk0mOsi1GDtJkAnyfBa9elO84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507666; c=relaxed/simple;
	bh=SavUUUUu3iLx/SVskOMFPcXoBA3NTwlMLXAUi/IdMWQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h4ugenFfVpSQ5scK4NzakOtepnTG2bEOJO6Iuq8eszxF8MSJIcLsOZYOlEOmS+DdFHf/hJyhh5QwgND2SvjYsYNQOGVIYjlLr/jzh2qbOE66gOTLXxPxyjWo5kaeL0rxpvF3W5gtbQjjN9LichSDHCPYnw0/kKMgbMmBzivSgxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zq9zsywz; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaD6Tk0zLkGitzftEluvSRcaPis2trAYBeY9Zm2ORz2Xq0wAhTT3iuZX+ntnAIGWjV3L45/xv7Q1657NetKQlCn+bRcF5TK/PKB+4m3013KvDUe9Pb+5VbN65vUzzS3m/HDHeD8a2nToQzQwUXxQ7Zoy2KoWZM9CRE85BF3bV6LndmtVcQIJSJGt8ce+1SD5OIko2pjP42MnpD4P/13UXPwFZ1zx21eugRc8Be5nxg1R4vJRVt6QJB5X9i+DlwOMEXb3NrUH7X9cqI16ObOds4ajVnKq6Hos+xkM7XQ24a8OIQlgqOguN0y1xg9GOH1NOkbIRduDZt5YrvMp66ki+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZP/97DtEyJq6ns2pyIS3CFo0k9P0sYWDHdpd/+PCD0=;
 b=Bl2uW4wrIN9MbTPEwufwo6fHXBmo/fD+h/0HEO7yNX8DMFmDXQFQvSZO+lvkMNPvXAMkhYhWfLigG+BSD0Br63jsygqN6ZojQq8HdoLCRErCuU2+2SlUNLTgHtlYrC1SXHBJxcclXRKixe5CiqcgbKKHVGAMuqWETYmNlrJoPUJvspwTZEfxo4LZU448usvSsCV06fbGvRqdC0XR5TFkRyNPP9smZIwBhLm/2eHAp2GeLn3xgq5u8C0DjZGGyJeuLRS4ln3ags0rb12NmTsqhB+jfCG4Aj4/Pv3eM0z52NusknN3hBQePJBRUqgpr5aXRF4xZczuUeE/a+dXjBQgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZP/97DtEyJq6ns2pyIS3CFo0k9P0sYWDHdpd/+PCD0=;
 b=Zq9zsywzMJ690EqdAZSyVjJjcO9uv2YNSTPClvSt94+SJl6d+fxWIXV++F1eri8ysjVheofl96sS7VYxqicY1t+4AAGQOYELuIntpRooReabQJ3akotzVZwqoovCGH/taizSuOJ3tEZWjft++Z7vKm2ZGloSgi+/AQXS93RYNFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Fri, 9 Feb
 2024 19:41:00 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4%7]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 19:41:00 +0000
Message-ID: <f1aef7ce-fb0b-45cf-985d-d4b26015ed07@amd.com>
Date: Fri, 9 Feb 2024 13:40:57 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15-RFC 1/8] x86/resctrl: Split the RDT_RESOURCE_L3
 resource
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse <james.morse@arm.com>,
 Jamie Iles <quic_jiles@quicinc.com>, Randy Dunlap <rdunlap@infradead.org>,
 Drew Fustini <dfustini@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, patches@lists.linux.dev
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <20240130222034.37181-2-tony.luck@intel.com>
 <c9629380-c97c-4797-b6b3-5044d5beeb97@amd.com>
 <ZcZyqs5hnQqZ5ZV0@agluck-desk3>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZcZyqs5hnQqZ5ZV0@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0004.namprd21.prod.outlook.com
 (2603:10b6:805:106::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: 789aa6b0-2b8e-49e6-bc07-08dc29a70aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yRE4V2hqVHtz2VyA9Y6JCHNu+1hZ2HzpIShWA85Ew58icsbVChZmTTZcDCumpYqOSkTHQEjrlsiuNOcakAUjFwk4In4/+btkC7v19h9C7XAPu6pPyDCzvpsjf3WfkuByVcvGnSMgN/fkLpc6UCnVXr1BHnjrcgZPr8WISf9tt7MxGg3Uj8vmG4H8d51BJAsOqP1ZCPxbthXY/Z+oPVxR9MP8laffoBKBebpcsf36qfOYpKZtIhYI7+S2/R0LHN4wGc208cXrv9D2xB/CCfC/u5Xj1wnRDSUalXNwrKxhRZMMb1DnFQOSn7JpKQm55pT1I9HIiy38ZaFODb4SBoFHsQRWxNScIN7K2A3grr4UMxLet8wlow0L+w2l08GcTkMQ6+hO4OIYHKsBtmjn0Iq7juuimDApxgRDydgaOe3924U/rL29yOcArdaJK1CX5vTVDJ58szD5afbqp9mlXCTTOgJuMUq7LZQmS53YC2GlED8tx8Eo0gsBuXSv7A3w7CN0ssHnZ8dEcIuL5SYrw5hq8yUliIs5mDvp9pWT26v61O/qlBz5sejJd6p7N/OGnByr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(38100700002)(8936002)(8676002)(4326008)(7416002)(5660300002)(26005)(2616005)(6512007)(6916009)(83380400001)(66946007)(66556008)(66476007)(316002)(54906003)(6506007)(53546011)(6666004)(36756003)(31686004)(478600001)(6486002)(86362001)(3450700001)(31696002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0FPalpHRm8wYUE2UUN1dVVDOHljcXV5Y0lta3ZrQ2lVZWJIa3k2WnBCemc4?=
 =?utf-8?B?UmljNzJuWmc3VWhGUjFwMmNXMjhNckRTTWEzWmxaWmU3VjFKazBtV0N1bzkz?=
 =?utf-8?B?WmFGbUFrb0trYktIUTJxV3ZBSHhJSGhVNWpsclp1OFlJZ29UQVhBSXdoR2Vz?=
 =?utf-8?B?Qy91ek5oNFZqeisvanRyeVNmbkdjYms2bk1lLzd2NjZQSGx1OHp1M0tNVnpi?=
 =?utf-8?B?NC93RkpQNUNPREJKZCtxYlN3eTVFWTFpN1hwN1Q0K0NlVmQzODVJa1ZNTEN1?=
 =?utf-8?B?aWFJN0lWV2N6MVFFMWxPWThuR2psU3p6Nnh2MmtwKzMySXRablNiVENBakoz?=
 =?utf-8?B?SE00STk5eUlYU0hwQkcvMzgyOE9hemZFY1hIR3l3aEZ0TW8vVGV3YUg0Qjdp?=
 =?utf-8?B?NmcxMndmNzlqMGxSelRaUUgvV2RySnJZbWx6ZHFYbVd5QUZhYXkzWnpwSnV3?=
 =?utf-8?B?aENRMlpwTUNKMXNvMnVpRnI2WUZwcElrb2JnbUdPVkY3L2tlN3ZnTy9iSVFW?=
 =?utf-8?B?S2Y1OE8vNWR1QzVIczFFcmdha0Nibk1EbVNiSXVqQ2xtSGhIdXZMZGFEOEF0?=
 =?utf-8?B?K3V5OTFDTURoZTJhU1hYUzIvMEZDNXp2WElGNExGV2FycjVtdW1SWjg3dmc3?=
 =?utf-8?B?a0ZnVXYvZHJCRVdhU0FVcVlqSzR3Q1IrWHpCV2pFZGFBMU8vRURHT2dPeGN0?=
 =?utf-8?B?aUM4OFJsbmpMMFMydjJkNUxncU5jSXJ3WHg0U2dZaWk3cm9RZHJKUGVxVW9q?=
 =?utf-8?B?RlJsd0ttelgrNk10RDZhU1F6dkUySTdraTNpNCtlNnV5a2s2V1JjWmJjcEpQ?=
 =?utf-8?B?SWRaTHpuN0RyNTU0Tk1iNEh6QUFOcC9XcTV3cmpxeDVPVXVEbDNNWWd3Sksz?=
 =?utf-8?B?MmRwd3ByTXlrWFlqbTNZSm5IanNMdnpZeVFaa3oxQkthbHMvazdHU0tmeGww?=
 =?utf-8?B?dGp6cGJrMG0yNnBXS1dTRGVpMFlxOFU0MUxBeGtma29LTW02ekpETjRRQXpB?=
 =?utf-8?B?cVpHN1hKTEQ3cFIvTEJGN2lqWmVHeXplOEVzRmZTVnpYc3dBcHRQamhGT21k?=
 =?utf-8?B?V3NCWjdHSDdZb0R5b05YcmVEU0VsNkllUmswWkxyY0pzNnpmWFJtb0RReHB5?=
 =?utf-8?B?aHhaVVBkcjZMdDlNWEJGV0VqeVdlZ0xpYzdjcGxxczk0Q2R3MVQrSVpOMGpU?=
 =?utf-8?B?ZWl2OW9hMEhGS1pUNXpxUllYaS9tWUlJdDZNT1M1cUJscGpESGJvalhrKzFX?=
 =?utf-8?B?N2dmNnEzd2VuekpDMk1CV0wrZUVPalB5ZSs3b0lmTytDOEkxQlI2T0FyOWFh?=
 =?utf-8?B?ZkZyM3hIMUFqZVdWWFpqSEQwNzZpbGcva0ErL0JKY2pMcktlNDRnQmxFMXZh?=
 =?utf-8?B?TWp5S1puNjVOdll1V3hQNXdiK1ErNkJ4R21XR1ZZL1FXMmRZWXozYXBoZnlk?=
 =?utf-8?B?VEVucS80Umt0RjhxcDBQSWZRcVJZVnRJaE1yYlY0VUpKdUo5TnpPTU5JVGFh?=
 =?utf-8?B?N3ZGZFlWTThwZ0JSWUdxUHBzZEduaEdQSnI1aE82K1FEaU9EVWdHdi9rbGlY?=
 =?utf-8?B?b2NweTNFZUMwTmxQNG45eXQwTGVENzNqYk0vQzlBdnl4U0gwYktrM2Jtc05N?=
 =?utf-8?B?OTZkNlFxRzlIQldrb01WUkdidVVMenlVRFd1NFdSWWFpT0o4cHB1N0dKOHdh?=
 =?utf-8?B?MVY2NkwxSVIwNllmdEprTTcrbWhsaGRmNW1nMnJSWDZvWWhnQmNTQWdIU2E3?=
 =?utf-8?B?VEw5THdKTkZlS1dFVUU3cjlLcjRhWkxRYjdDT1RTUjFuSEZ0ekR6V1IrNHlO?=
 =?utf-8?B?Mlc3L1NXcUFHSmNpN2haSENueUZjTHZGNVdDbmxXYTZEdXhrcmpSbVVxdWFx?=
 =?utf-8?B?NnFwSGY4WFRSeXBNUzBEVUVlWXlVWWNESW5yT0M4R3ZPWVhEZ3RoY3ptMGw0?=
 =?utf-8?B?Z2F1cVpNU3pTdm1OMnZpTG1wNjhnL3dPcUJ5U2FaUnB6ZUJxY2JNYmRycGZ0?=
 =?utf-8?B?L1dUTnpoNmx4VXQ2dUJOK2RsVjR4ZzhGb3F0OFZaUFdYbXhlUG5HSjI4N1VQ?=
 =?utf-8?B?VDQwbE12WXcrZE1OVFRyQ0s3UFo1ZjdDUzQwUmxxcWN3MXdxMExmaE5hMWFi?=
 =?utf-8?Q?5GCDROmpIYjUskKNJ2DoLp9K+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789aa6b0-2b8e-49e6-bc07-08dc29a70aed
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 19:41:00.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mbvfJ61Ia+PyXk3ejyOyL+/XzqPrk8AkQ7dlgrY20+W2p/eHBltE38MIMKmnLYN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160



On 2/9/24 12:44, Tony Luck wrote:
> On Fri, Feb 09, 2024 at 09:28:16AM -0600, Moger, Babu wrote:
>>>  enum resctrl_res_level {
>>> +	RDT_RESOURCE_L3_MON,
>>>  	RDT_RESOURCE_L3,
>>
>> How about?
>> RDT_RESOURCE_L3,
>> RDT_RESOURCE_L3_MON,
> 
> Does the order matter? I put the L3_MON one first because historically
> cache occupancy was the first resctrl tool. But if you have a better
> argument for the order, then I can change it.

That is fine. No need to change.

> 
>>>  	RDT_RESOURCE_L2,
>>>  	RDT_RESOURCE_MBA,
>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>>> index aa9810a64258..c50f55d7790e 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>> @@ -60,6 +60,16 @@ mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
>>>  #define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.domains)
>>>  
>>>  struct rdt_hw_resource rdt_resources_all[] = {
>>> +	[RDT_RESOURCE_L3_MON] =
>>> +	{
>>> +		.r_resctrl = {
>>> +			.rid			= RDT_RESOURCE_L3_MON,
>>> +			.name			= "L3",
>>
>> L3_MON ?
> 
> That was my first choice too. But I found:
> 
> $ ls /sys/fs/resctrl/info
> L3  L3_MON_MON  last_cmd_status  MB
> 
> This would be easy to fix ... just change this code to not append
> an extra "_MON" to the directory name:
> 
>         for_each_mon_capable_rdt_resource(r) {
>                 fflags = r->fflags | RFTYPE_MON_INFO;
>                 sprintf(name, "%s_MON", r->name);
>                 ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
>                 if (ret)
>                         goto out_destroy;
>         }
> 
> But I also saw this:
> $ ls /sys/fs/resctrl/mon_data/
> mon_L3_MON_00  mon_L3_MON_01
> 
> which didn't seem to have an easy fix. So I took the easy route and left
> the ".name" field as "L3_MON".
> 

Ok. Sounds good.

-- 
Thanks
Babu Moger

