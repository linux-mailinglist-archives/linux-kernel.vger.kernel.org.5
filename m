Return-Path: <linux-kernel+bounces-59471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ADF84F793
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D062E1F2342B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEC582873;
	Fri,  9 Feb 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="XTwFX7yD"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2126.outbound.protection.outlook.com [40.107.247.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11BF7E59F;
	Fri,  9 Feb 2024 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489125; cv=fail; b=ImFIHSvy5F/EXm1XiXBy6zMcunL4BBPJdd3u9KTSvNnvl4q7SS01MEiTkB+68/IQpsvlUWkrs1Zh/ac1WW8U0TNjUiC76hP9mYfiftelnKBHe9b35wfHTQRhtJcWuvMZWzKpLLrXSejSjO63o30FKP5/2bi8uz1v/oVGfnyPDXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489125; c=relaxed/simple;
	bh=2RfuI0gT+WrZwWllS0se9f6Ko0XdfY2zkuChAV3iLmE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jTVuZ03psCOCtS6/gnvyAOkQHXUS7xjZ/MalM2mlXdlV0+po70lnZyFe0AKjr0elk2mVwPWM9xqGM0TIvVMAoGn1UhPnfvOY2QdmYEvimj/fRrLBmkNNZxJhmptlYlkpuryO4PExDv50clsnAg0Lk9ntjkaSMyQ3mF3SNTgYAYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=XTwFX7yD; arc=fail smtp.client-ip=40.107.247.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQogNXXcP3V3KGFI9ecfc4MIauOOC4EBJN4gFQ69Bzu8q7/rz30BSdKhaP5kWfUkboGlcmm/8uxIUrdeGN5FKWKHGHNNJiJ5Y/I1EHS0P2SUMzDvCPX4C2lGzl9ric+lCG5b1HesBfKgT0KBNlKZ5iIU6E9FF8yh5opa9XSlK+itZdrfS7KU5TUZ7iAgoCyjmsxhEe5747frf16HjPph52ceqI+xIEvnUlCeaMLPAGLDzg+56gRDTZdd4HTrD3fYHG2yHkCp9u4kRbsEyV3wYiY+kOa9iqoacf5yNAbsxBOLRfhelw0uoYytzZQYVIh+koQTSb3HuQyCafOJe7Wb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxbIO+xqmybHM2P/ZB+LGOKIq/CII1amV09Ublk62ew=;
 b=NDm21F8cBCcE11BVP2IpfRs8SPUH6nz5MKvHu0ZFo/Nj18dddluvEgCe6V7g3XEdlyaP4TnLL22HdJI8bh4CUHd4uZdX+dDJUWtIhr1NiYAF1bFhMkBbVtp3tU3uxJGx9siQyg9sIwIrzMvO/k9mI6fNCZo/TLZ6yzakjjnLYzmz+VvGcdB88HQziLl/aqEGtxx01su3it5vrVD6zHVTg0FfxKjYDUTc/RtfWA+mxgGCDofjXDjVMzM6dSitXZtE7OoiovcYnD80LjBogk4Om5kcmSI3hrcbrsuNJA2JYnw/0ATdeT8rsYGPUMZ55oRP377ZCaqePb+2JEY9VjaqDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxbIO+xqmybHM2P/ZB+LGOKIq/CII1amV09Ublk62ew=;
 b=XTwFX7yD10NlhPYHcataPRh5LglUP2bVlXLIR3yx+Je6WKbrUpxgGT3sHnDMkiyfAAvxjSI3wdoFyv0D2dl2IAgZV3Tj5vgWpQrYsDYbc/T7NEeSWyeXbgM+nC/ZJan4E4ocwEoz/21wSqMkvBgLwPXivEthUa9NH5AVT9VfFKsGflo+zvfbNN4ks/3akfwVwa1YvdRkpukgsDsLfF8arXVf1vlELk0MNHFgQHhvymSeRnOsuFiukB5aGu/P2OH8ffeOIdcy1tgep6QUMh9l8/PxfA3FSqWWpzpMdO91368bxoAesfIo08GSi2ClRAO/i52ebWXdqebWVUFkiWIOdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by DB9PR06MB7386.eurprd06.prod.outlook.com (2603:10a6:10:252::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Fri, 9 Feb
 2024 14:31:58 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::b5ae:8355:acaf:29e0]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::b5ae:8355:acaf:29e0%4]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 14:31:58 +0000
Message-ID: <465b2b4d-3c6e-4a64-b3be-f146cb237bda@vaisala.com>
Date: Fri, 9 Feb 2024 16:31:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] usb: core: Amend initial authorized_default value
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 vesa.jaaskelainen@vaisala.com, geert@linux-m68k.org
References: <20240209094651.5379-1-niko.mauno@vaisala.com>
 <2024020903-october-placidly-20cc@gregkh>
 <65582610-72ba-4644-9032-91c09f50a6bf@vaisala.com>
 <2024020911-utilize-etching-595a@gregkh>
From: Niko Mauno <niko.mauno@vaisala.com>
In-Reply-To: <2024020911-utilize-etching-595a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0119.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::20) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|DB9PR06MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fcd46b-d539-43bd-7e4b-08dc297bdf11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l9SBVbXb+fi/765JwuSEpgRd03/R004Ci4IXzQi3NcPhV44hjnKyGuAMac1o3VrTZv9l5IRfcoy43uhq4EOlE/ZjBjp6Xn6/PIwfjH4oejCGiy1n91m1p5HRI2aI6zvLLI+9Ao616hC7hBlPN+a2tpgMWkmXnyBR1ZZdUZX6XkBC5v6O5x3D3L1vaw5ojhPIhEFW0ATVox3Jx5+XvNZIiYBRp5b5RNM1YKfhDzd9Q9xCiJj20HUbxopLAfHGjCHxzQxdwvzbL/HqS4ZWHNLMyrIbwVi8shjExP5zjZOTqc+CmVkGLwYDue7Je/+YrU9a1M7kO7L0SmInjJV/srFESNvVUWE8IkGglm6srQhl+r9VpY/pE2LPsZ2Rva1ZZbQfPFJGCjFRN1rPaZEdDtXP8H34iPeAmJ0iUTqO979K3c3za5vYoC6kpQS4e9Yr/tH18AIeA6pzdp5SNMMUjHQcrjeVeMvChrg6xW5pXLyjZym+3SAn1HxXP+Dii/V4lb8IBhkMtLZcD/stuMiZBTqm651RMQ23ALIOfzaosHrhh8I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR06MB8447.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39850400004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(966005)(31686004)(2906002)(44832011)(5660300002)(316002)(41300700001)(8676002)(66476007)(66946007)(478600001)(6506007)(6512007)(6486002)(66556008)(4326008)(8936002)(6916009)(2616005)(83380400001)(38100700002)(31696002)(36756003)(86362001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVhnUGFRV3V5M0JDVE0zQTZ2U1NGVlMxU0N4YzJvQ21SbkloOEVmVEk4T0NQ?=
 =?utf-8?B?SEgwMi95eG9YYmdRRS9XNkkzaVpqTnN0ay9PYjVwNTEzK1krbzBYNXQ0Tm5q?=
 =?utf-8?B?UDVtaEtxbStjK0VMSlRFWDdnZ0ttc1dHVG1mQVp4b2hrUitaNmN1RjNxQllM?=
 =?utf-8?B?RnRiaFNHTDZWSGpkQ21iTkVRd2Y2N25zdkJmV3hLVXVUTVFwdTdRN1BWaGpo?=
 =?utf-8?B?MktpYTJwblRnTVBBcitROGJxOGQ3MzBZck9HUExrUXk2VnA1aldUQ0V0OTNW?=
 =?utf-8?B?d0JzVmZGN0VXTUFtaTZzRVVvcEF4YlhSOUVDNDBETXlHZUx2ZDA0MFJScG0z?=
 =?utf-8?B?d2RDU1hQNS9HcllockY0dG05RTJlZ2lrUWNxUEhaU2szaWEyd2xYUG96dFJF?=
 =?utf-8?B?MzR0czIzcm5UU1V6QmptRkl2NTB5OWV6RTcvRFI3R0ZIMmF3NjJzVVkzMW1Q?=
 =?utf-8?B?a0dUZHlOYTBsT1lscGwzZnpmbEtPdm51M291ZHIxSDgyZUVoMEozcXI0UVgv?=
 =?utf-8?B?MUpJUkh0L3JUU2dQejh1MXNVNm9wd3ppaTY1ckJzNXV6TGhjc21yQksxaElW?=
 =?utf-8?B?YUlodW5vSGEyaWxYZ1FkcUpjbnZFck41c1RJQ1BXbGk0U0xkU3RkemF2VEVQ?=
 =?utf-8?B?UDhRMnl2UERyMjhYWXJXVU1RcUZ1dXRmdGJ3WTRYM3JsaVVzbDhuMTVYNDlx?=
 =?utf-8?B?Q09PRGRWN3JPMFNFME4vUExmcE5TR0ZXVWdEMzd3RXZrT25PbDFPK21NeFV3?=
 =?utf-8?B?NTRMcjMyUlRSZklya3RPRjhLWVh3SXZDSStRMWxrbEpSK3F6L1NHZ3oyZS9l?=
 =?utf-8?B?UHprYUdOYUV2dmplVWlMM0pXRU14RnVDU2hoRlI2MUZDbmNXaXNocW00aDZW?=
 =?utf-8?B?cjBnZ1ppWHUrQ2dPdWlrVy9OUjBoOWsyRC9mOUdmcjZjSG0zNDZJQVRJcjh3?=
 =?utf-8?B?N04xd2ZEdlRzalVuMlFTZStDS1V5MVpHQTlrV3VLeXFrWEhVVDhka3gyMlFZ?=
 =?utf-8?B?Y0xYa0ladlBWekV4TWMxc2l6bjU4Y2VkNW0wSVRJalNxSTdqdVI2NmlaaVdX?=
 =?utf-8?B?dHZyNDhSSVkxWG5GWnVZZ1ZjR0p4UjZ4aU83bkpBR01kSXBqelVpWFVLRWxz?=
 =?utf-8?B?clBwdkNXMU4zY3kxRlh0QmhpR204aXZCQ2o5VkVONXFVN2szcjFYemMvcDRY?=
 =?utf-8?B?OTZLYzRRcFZpV1EyeHU2czRhTnBqQ2pSWG5QTVVlb3dYWGhJM1E0am00OEpu?=
 =?utf-8?B?dERKRFdaY0pkZGtsTXRJRWd6OXh2UGFHdEl2VjlVdU9FOEMvdDcrWjVqNGJp?=
 =?utf-8?B?ZzgwbElsUFN2MnkyUm1FV2RGWTZSbTBXeFdVQmU0a2NGdTlIaTFCM2llVUtC?=
 =?utf-8?B?Nk9aazlMazFSQjk5YWEvSG9FRkd0TlZKQzByMkJzSHJESzhlOVdIUUFYNHRa?=
 =?utf-8?B?UlJpbnl6UzlaYzdaUzNUbjBUZ0VYR0hMaGxDNlhiWTVWVEZMaGJuRVBIODVR?=
 =?utf-8?B?Uy9qWlRoK2E2ai9lN01ta3NZN09Yd2VYYjdMNUdidnA5MGR2NG40SzlXZ0l6?=
 =?utf-8?B?VlVRd05OOFppc0tqTWN1T2JhUThlUm1CbW1aOXFEYVMzVUd2ZStkc2FuTS9v?=
 =?utf-8?B?VTdUUFN1YU02SjJwamw4VWd0TkJWemxsS0p3d3NHSXdsUXdCQU9aVjZTTnVj?=
 =?utf-8?B?YWpIVjgvNXNuOWFxWW44NXU0UmpQZ0NuUGtNN1NhS3ZHNUw0YkwrY1dnOU04?=
 =?utf-8?B?NnYvTHl5TGZCOHZSclVXWXE0cWNWN01USEZSRU1xY1ZnQWp5MDBIa1o5a3lQ?=
 =?utf-8?B?SkY2bm9ObEZFWlp6OThzNCtoNzAwR2I5MGVCYVJYUTNFRjhYbEUyNldKVmV1?=
 =?utf-8?B?dmgrbEdtNVhRMHlVVkFCbnZraUNIeG1VK0xRR2JJdUVvUXY5YnRLZHlZOGFI?=
 =?utf-8?B?OTlKVEZwTGZDOE1vVWdrcVlhczdhWkl2Yk82bGhXdVRCRjdjODNMTzIzdDNz?=
 =?utf-8?B?QnNyMFVDbDBFdGVDSFhIMEtPZWlaaDdESXRmQlpGVUhZNDlkRW9uMnVqOHBL?=
 =?utf-8?B?bHBKUHFGVTREeUxPRFJvT3JjU05SYWhjQW9KbldLS09rMk5PR2Vpa3JhVU9r?=
 =?utf-8?B?dHhjeE9PZTJnd3UzZUNCeWF2ZzlCZWZHdmFJYUJxRU5YQ2k5ZFdyUG9tN2sz?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fcd46b-d539-43bd-7e4b-08dc297bdf11
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 14:31:58.1069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiSftkqz0VTSJaL46cA6nX+7c9niyYRx8dK8WDDJ3KvPxk7vjmynzGkJBS87PUCm/iBu4eA+KKv1d9R98gKsEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7386

On 9.2.2024 15.34, Greg KH wrote:
> On Fri, Feb 09, 2024 at 02:39:01PM +0200, Niko Mauno wrote:
>> On 9.2.2024 12.47, Greg KH wrote:
>>> On Fri, Feb 09, 2024 at 11:46:50AM +0200, niko.mauno@vaisala.com wrote:
>>>> From: Niko Mauno <niko.mauno@vaisala.com>
>>>>
>>>> Since the wireless USB implementation has been removed and since the
>>>> behavior with authorized_default values -1 and 1 is now effectively
>>>> same, change the initial value to latter in order to stop using the
>>>> leftover value. The former value can still be passed as a module
>>>> parameter to retain backwards compatibility.
>>>>
>>>> Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
>>>> ---
>>>>    drivers/usb/core/hcd.c | 6 ++----
>>>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> Isn't this series already in my tree?
>>>
>>> confused,
>>>
>>> greg k-h
>>
>> Hi Greg, apologies for any confusion I may have caused,
>>
>> Geert requested some further clarification in the new Kconfig help section,
>> please see:
>> https://marc.info/?l=linux-usb&m=170747246528305&w=2
> 
> Great, but I can't take patches that are already in my tree, right?
> 
> Please submit a new one on top of what I currently have.
> 
>> (There shouldn't be any functional change introduced between v2 and v3)
> 
> That always needs to be listed, as my bot says, otherwise we have no
> idea what is going on here.  Remember, some of us get 1000+ emails a day
> to do something with (review, apply, delete, ignore...)
> 
> thanks,
> 
> greg k-h

Thanks, submitted as new patch against usb-next.
-Niko

