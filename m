Return-Path: <linux-kernel+bounces-49680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC3C846E0F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5E6A1F2B078
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2505713BEB8;
	Fri,  2 Feb 2024 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mUkYi3il"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCCD13B7BA;
	Fri,  2 Feb 2024 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870045; cv=fail; b=bWC6uO/Ftarm/hpkQxz4hZAiZCQoREEePWHIG7qKQCTPOSLsFyV1ap2aVSOAOccS2VhUv0IHR7JB29aPRYG95usq6J/sBXY72JYzMyz9BAVltEUua7TFVJ/lRew2JlwOODG/Y5HRkhhQ3omsLgM+7sAtsF4RpWdrHENr3HKv7IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870045; c=relaxed/simple;
	bh=iOOgaNudgJ+ZYQKBe1awnsby+vEX11ExHdx7UnUZtyg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zs/SqXbZbe9k7XDLxZLC6ocXgmT3ewW9Tkf4Bc/sgPXwfZFv0Rp7Ikb+Xcjpm1zq7WOksFH+QadKlBr65VKQHfkdONmQOXTJhvI1YpH5893Y7WfdJMhZxiSabX97lOrA555vfH6DI4z4MpYC+hxDFIdYQfXNpDt7BHo9GqXnnE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mUkYi3il; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkFs9NlUb5HTpeQaKymbvmip3tLRPEsLru01xdt4RwA1Nr25jgsHqS9Iu5YOGMjv2bTcq4oZelfMmzLlZyN0t93yLTSEipHdBTM+UFl4tPGj2iSkYI95qOdFoXHOFjshO6Cra5yQydSz3fxx4mVC/34a0lsSKPqY4Y5HX4KUHQq2/0N29/t1lTWNmLBQ7ws7ipPE6nvno9CXa3EQ7k4/nFu9H5dciyPyPRk/tWYv29VGfwKHyWuG6T6owB4Xe1T4OuzCbQVFS4vBzfqy6ehrMi6wThULGgbakkLAuwLv60WW0vI8gnOiLqEjKIxCPUKq3aKQFv92WWcEZdYIdWtnCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jw2082EoGJX/XwZ1H6WYDqCSsyPZMfaq3n3Zv3gsd+8=;
 b=oY9btFuK50I87RnqGylV1207887joG8rYE3jleVyGHPw7xhlMvQ4QBgFAwiQoJXiMEymPa2nc6Q7Wbpl1s2RQ1ixnkku/ZvFM1th/UizKeb2ZWPcqVWn6sFU4peQFCmdmiSgTRbXIBqiENvgrxgn4eWnkpRUFHonLmNj/6XvrNzRQKpjiNqOcgOW30437F7V9W8xJHhbxXrHKSESmOwB2yg3JajMsarugbAIYlcMdwMtKwUo4bbmzr+oLmIhFK8GZPMg3ygOp1z/aqR0Q7Jew8orljNRs62KETb83au+kOz19MUYDPFSD9EmACa/pj9KJtM9jjQbrOrY2OGRXBfhvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jw2082EoGJX/XwZ1H6WYDqCSsyPZMfaq3n3Zv3gsd+8=;
 b=mUkYi3ilLrNvE7YdSVvMgXQf/+PpQ3ymeVWowULKRcp9XzhCrPyE0dp4XcN70wDgXbyXp+0wy9f0pbhGpKYbcX68tUzqhfD40thKrzvc7qmDv6zDO26jsWuHJ8AsyoQtIlBqlpqRjV+lj0RJvlMgK8TZntYEDyb4pjzB/5f8F4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21)
 by SA1PR12MB6701.namprd12.prod.outlook.com (2603:10b6:806:251::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Fri, 2 Feb
 2024 10:34:01 +0000
Received: from LV2PR12MB5966.namprd12.prod.outlook.com
 ([fe80::4196:178:d5af:9f2]) by LV2PR12MB5966.namprd12.prod.outlook.com
 ([fe80::4196:178:d5af:9f2%6]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 10:34:00 +0000
Message-ID: <a04b3af5-ae3a-45b9-a871-0c04d6002166@amd.com>
Date: Fri, 2 Feb 2024 16:03:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/hsmp: switch to use device_add_groups()
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 naveenkrishna.chatradhi@amd.com, LKML <linux-kernel@vger.kernel.org>,
 Carlos Bilbao <carlos.bilbao@amd.com>, platform-driver-x86@vger.kernel.org
References: <2024012822-exalted-fidgeting-f180@gregkh>
 <0d110d2a-da0c-017a-0e5a-fc6bef7b066a@linux.intel.com>
 <e73426f6-6d50-4ed7-8613-1ec42fa3f991@amd.com>
 <2024020144-duplicity-nuptials-1cd7@gregkh>
 <f48ebcb1-8f87-efee-08ed-844775c995aa@linux.intel.com>
 <2024020135-sly-theft-0594@gregkh>
 <fb66b037-eeba-45d6-be41-215478cf3ba9@redhat.com>
 <2024020122-undertone-hammock-b08d@gregkh>
From: "Hegde, Suma" <Suma.Hegde@amd.com>
In-Reply-To: <2024020122-undertone-hammock-b08d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0237.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::19) To LV2PR12MB5966.namprd12.prod.outlook.com
 (2603:10b6:408:171::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5966:EE_|SA1PR12MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4998dc-fea8-4710-4f1b-08dc23da7826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lo9NEHrGeMAEenu/bW6dU7G+r0Am1w2aIqZhcB+shBImL7vNvMGuoU/BXdppdyyH9yzIdYHPJhayApl3cdNgvtGvNr0axtYJifkT8YsDGLwWTOcNLDcS00ifnMX0vFKDweDm/F+03wqry/uZ5wiFWes85oRzZYuALAyixP7xxB7mYJ3klFUs9kK5RfEcaz96P99oiUaL/reVEBzO1SZXL2HVR/myBEGvbOcySaUkUCDroP9umB3wezoxpt0e7CI5GZogLHvGiL9EBW2NZv7RxMXdwOL+Abrhtb2I7ygQ/3b5or6XWqIPZ0HTA2AAjOKuDr7eSh7iQS97BVxyHOBzrAESvxXyuoseKEs1Nn5WEIMf5fKPlym+M2D5e2igIw1w9prgHwIuOHcnB5TtaR1SFPrT5kYYfv/XpBkqM/61UL5Y1dNdi/Cl/MBiWUqD1PzX3Uf7HIpOF08ySUQyYlZUyi1qtPi3znuZLal/I6Ejd4yTWxvNiMJnaFtD47l9YwGciP1LBAbQmrcBfW7FVWxOJQhr1sZKStcdKh5luid04PC91cvjBp6TSdkr/GxJb3X56pwWkRjWoAfp74wcM0/cNFvaIaLOaHWycZZylgIEPoSsKfaDdyPtRhdOxdalQWFsCGiPD/vcROG+RODbaqho5FzyhM0ytTV9rHdfQTx9hSN5bPZH5bSVVmGwa/rQ0LT3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5966.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(54906003)(5660300002)(478600001)(83380400001)(66476007)(2906002)(6486002)(4326008)(6506007)(6666004)(8676002)(66556008)(316002)(66574015)(26005)(6512007)(53546011)(2616005)(110136005)(66946007)(8936002)(38100700002)(41300700001)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2djNHh0VURoTzZESVB0U1RCUkN0ZU9qWWdLUEhSOGZEVFhvVnhzNlF4VXpq?=
 =?utf-8?B?T3hseWdzc29WMjQwVHBMMXlNZDJPMXAxcFpqeHVBMitHdE93d0c5TTVmOUVQ?=
 =?utf-8?B?ZStCemRNb2QrWnMwMWdHem1EcVhYRWw1NkZkZVJ4K2pqWUh3OVdMOVNuaDZN?=
 =?utf-8?B?VHBOZHduM1d5RzkxS0c1aEE3dm5yRWcwaldmVjBiajdQL1ZmWkFIZzN6NXl1?=
 =?utf-8?B?NEQzTklZZnllOUlYbzljVTRWNitYaTN5N0VWSHBrNmVHcHNGV0dZM0N2SFA3?=
 =?utf-8?B?SmhteGpZSkFtTWppSzNsWnRGenFyclhhd0ZMYlBCYzYwcGlKWnNpRWI0Nzlx?=
 =?utf-8?B?K0RrRHNEc2ZGNlNla0hKQWtRcmozN2FkQmhTdW96WTlraGpOcVZRRXh3RFI5?=
 =?utf-8?B?SEJqekVXanZMazk1bit1a2YraG0xd3VLY2xaTXRhMU9idnA0bXBQbktLMFI3?=
 =?utf-8?B?bW10SjZNaXRST2k3OUFibkpCQVlHci9yc2ZQVVZqUEdGVld5dmdFODluRjZ1?=
 =?utf-8?B?TUlUR1k1ODlWR1NvY0RrTFRPcFlKQitKWFJnY2VPVEpLT0ZzcUZ6WU01T013?=
 =?utf-8?B?bU9JY2RkN2pMOWg5dk1Nbm9raUI2Z3kzKzhYc3JiOW9zYXBPaGR3SW5pdTNn?=
 =?utf-8?B?SUk4b3JGN2lNUnFaQzYxdkR1eXVQUUVHd0FoOHpKWGUxaEFoSzhYdjdobStv?=
 =?utf-8?B?SDZBa2JyTnc5OVRBRjRnZnhYSnNhcEVjTkhBd3R1T0lnOE9oT2VkMmlNNVcw?=
 =?utf-8?B?dTIxZlVacUJ3VmR4ZEZWZzFlMDdnT3JaTlFDcUlkeGhpUFFoQW5CU2MxaGZM?=
 =?utf-8?B?VmMyK3BGYXh4Rk5xakF6MHl4a0ZuRE5HUUQ2WTFPY0tYVkZkRXZJM2lQazZp?=
 =?utf-8?B?MGxIVkdLK0p3TmlpUi9lUHQrRW1uWVU0L2NqbWJaSzJ5RExveDE3eUVuZVYw?=
 =?utf-8?B?bUpOYlM0anNTSmFRZjhVMFFZbGdoQXQ0OVM1QUd4NEMwV2Fta1l4RTBqaFh2?=
 =?utf-8?B?M1FHTDIvVXhxdkNOZUJoTTRUS3ZackxJMTlvT3VPcVkvTzNKOUFuUVNQQ0V0?=
 =?utf-8?B?WHBxbUViRHJrc0E0OGhPbGFVeTh0L0c3ZktYNVp5L1lXU2J4ZWk0MDgyemJ0?=
 =?utf-8?B?UGV2Q2dnZXR0TkQ2UVlCbGVjdS9MbE04MUhEMlNzMC9aazRjQ2xDckZDR2V1?=
 =?utf-8?B?enJWT1hXdVZ3V3V6dmFKZ1pBVmZXTVlBL1M5ZEVyRGNLb2Rady8wbEdMUkpO?=
 =?utf-8?B?STMxektMRTNILzY2YjBsNzlKakczd0xhYjNjUlY1Z2Z1RVhwK21EQUdrUytK?=
 =?utf-8?B?aU5Ta2FPalFITi9kMWt3MTN2QStxTVljMVY1Y1BjY0g3dnltZ0w4ZzZOanJV?=
 =?utf-8?B?eUJhYnZTVFY3WnlXL2VPMU4rVmNCQ2YvMVlWZEw0VHAzSHlBcmpDMmFyWmZF?=
 =?utf-8?B?YU1GZ212bWxpWk9XTjBHbmNZcWR6Zm1iL2RYUitHSkF6cGYxN3hubURYd0Ri?=
 =?utf-8?B?c3RuRWkrdHBYVUlOTVhsajlNSnNjYitJQTU3QVRUcnRhWnRFWjVtaW9qQUxl?=
 =?utf-8?B?Z2ZBams3eGhFOUZKeUI1SGE1K0hkWTFwV2N5b3VLNW8zUDJFK1ZHdzdzSkNP?=
 =?utf-8?B?SWxmc1JMc1pMeThsTU9KaVdyeGNQUFREN0o2RlV4RUlaa2VSKzZKYVdrMC9m?=
 =?utf-8?B?ZGNJZ3U3SWZ3VDlOZCtPSnUreURtaFVSc0tzaEFldTh3bXM3U2N0SVg0RTVi?=
 =?utf-8?B?cWlkWUxDLzg2Q1F0WFBXUVRBOGxXL3hKUkozVWg0MnZCY0lXWk5CZXV1em9E?=
 =?utf-8?B?MWc3ejZENnpOOVlvTGRkYTljZVM1by9sZEE5STAzTmlUc1ZMQUw1ZG05WXNR?=
 =?utf-8?B?RzNLemwrOGdUalhlT1BGVU1aVThncU1CaHpocFJVWTBKUHQ3QmZaSXRrUWdT?=
 =?utf-8?B?UHdOZkY2eFZmUlh3RlJvbGFKSGQweWJ6VXZnenEzck1lekE4QjBHcDVmQkwz?=
 =?utf-8?B?SW1Rd2ttcEQwajVUVUZyaXRMVWEwekt1VlcwZ3lnblUra0E1ODNlQmZ0UG5p?=
 =?utf-8?B?dkZ6UFh1Mzdab3J6anNkb1hZc3pva1U2bmpIbzR6bVZ0TGloYUlvYnZQZXl5?=
 =?utf-8?Q?WuKs/xbMF6aSjakdjtPK1C3Is?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4998dc-fea8-4710-4f1b-08dc23da7826
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5966.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 10:34:00.8359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jX640zqNALJ7BC/skuZwuaeIzRULjksIIqeVu/qrkn1kKosUQaV4snLvx4KwoZt32sDqTKddUTPQlwUxwbVy/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6701


On 2/1/2024 9:04 PM, Greg Kroah-Hartman wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Thu, Feb 01, 2024 at 03:50:08PM +0100, Hans de Goede wrote:
>> Hi Greg,
>>
>> On 2/1/24 15:47, Greg Kroah-Hartman wrote:
>>> On Thu, Feb 01, 2024 at 04:34:30PM +0200, Ilpo Järvinen wrote:
>>>> On Thu, 1 Feb 2024, Greg Kroah-Hartman wrote:
>>>>
>>>>> On Thu, Feb 01, 2024 at 06:50:33PM +0530, Hegde, Suma wrote:
>>>>>> On 1/29/2024 6:16 PM, Ilpo Järvinen wrote:
>>>>>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>>>>>
>>>>>>>
>>>>>>> + Cc Suma Hegde.
>>>>>>>
>>>>>>> On Sun, 28 Jan 2024, Greg Kroah-Hartman wrote:
>>>>>>>
>>>>>>>> The use of devm_*() functions works properly for when the device
>>>>>>>> structure itself is dynamic, but the hsmp driver is attempting to have a
>>>>>>>> local, static, struct device and then calls devm_() functions attaching
>>>>>>>> memory to the device that will never be freed.
>>>>>>>>
>>>>>>>> The logic of having a static struct device is almost never a wise
>>>>>>>> choice, but for now, just remove the use of devm_device_add_groups() in
>>>>>>>> this driver as it obviously is not needed.
>>>>>> Hi Greg,
>>>>>>
>>>>>> Could you please hold on merging this patch for a week? I will push a patch
>>>>>> for converting platform specific structure's memory allocation from static
>>>>>> to a dynamic
>>>>>>
>>>>>> allocation.
>>>>> Push it where?  Ususally we do "first patch wins" type stuff, why not
>>>>> just do your work on top of mine?
>>>>>
>>>>> Also, when you do make the needed changes, please remove the explicit
>>>>> call to create sysfs groups and use the default groups pointer instead,
>>>>> that will make things much simpler and avoid races in the code.
>>>> Hi Greg,
>>>>
>>>> Well, if you really want to "win" :-), please provide an updated version
>>>> which considers the changes already made in the for-next branch (the
>>>> current one won't apply).
>>> Fair enough, I don't want to "win", I just want to squash any "hold off
>>> and don't make any changes to this file because I was going to plan on
>>> doing something else here in the future" type of stuff, as that is what
>>> has been documented to take down many projects in the past.
>>>
>>> That's why we almost always take patches that people have submitted
>>> today, instead of ignoring them for potential future changes, unless of
>>> course, they are not acceptable.
>>>
>>> I'll rebase on linux-next, rejecting it for that reason is totally valid :)
>> I checked the code in linux-next and the dev passed to devm_device_add_groups()
>> now is &amd_hsmp_platdev->dev and amd_hsmp_platdev gets properly removed
>> from hsmp_plt_exit(), so I believe that keeping the devm_... call is
>> the right thing to do.
> I'm trying to delete the devm_device_add_groups() function entirely from
> the kernel, so I might disagree with you there :)
>
>> With that said this driver really could use some modernization
>> (even though it is not a very old driver):
>>
>> 1. The sysfs attribute registration should really switch to using
>> amd_hsmp_driver.driver.dev_groups rather then manually
>> calling devm_device_add_groups().
> Yes, I'm all for that, I'll look at that this afternoon.  That's my main
> goal here, to get rid of ALL manual group additions in the tree if at
> all possible.  And for those rare cases that it isn't, because they are
> dynamically created, work on a solution for those.
>
> thanks,
>
> greg k-h\

Thanks Hans for the suggestion. I will push patches addressing both 1 & 
2  on review-ilpo branch.

Regards,

Suma


