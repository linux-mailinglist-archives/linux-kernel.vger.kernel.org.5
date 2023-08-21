Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8110783663
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjHUXfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjHUXf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:35:28 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CBB13E;
        Mon, 21 Aug 2023 16:34:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Koq+eVftMyTqHt6Y17zplF0o5gKhZAGCzylZsR6F2nhySuCJ1MIijXLrAT+Mrc7tVCfT7kaSNBZuow1tys/FWT3+Bvw9mJXcFZsEzxB/XlkrUtlg4YJlha9zR72GhA73NitineD3FNs7rBmMPv6ODLxE82HY3UI2X6b56MR+WbMlLVo5zigwPUaeu3WwsiPv8a3orFIU2NoY8yqzIOLyZwqGDTuvsZr5f26+me5EPo83njqThTWDXQCZwK6Mn3TOhvNLf1fa2a2EgZGUmoRn0wHUuXeT/Hlou7djh4HA19glNrgzG5503IoqxA4GbM9GPwEAKJI1s0zRNCBgxZogBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7I0/zoWeOEG2SOKll0VA+JfBkvG/Z9FYZkbAHLdxRM=;
 b=IqviyBr6RjgpeP8ZzuBnX1VCeOldXRDlnO4mvf1GH+9fcuEkGfQbO9qbYlOVtkRa1TxPsYD2eb8LfysnmuykTSVsO6221YEilkN2gro3RUZfs3CmWzuCBZXbhHj4OlB7eq/4otFAR5Mjo+k9q2hofuJ47wEDGvGwCxkEUv/6VWmEEL0dAkJLWWtyhESic63n2dJlpN14hAzltCXhUb/0Vn8XUKKArIMKkMZVssC0INhKi2Dw/iTZ85/1FVWkmzY3lcTfLrRAUuQ77fMaZ8hEH5qGKZO20bumGgY8OEjvGFqhp0guvx7uZkac7gqrPZCtsS7CF+LvOkVYaFl8gM+Upg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7I0/zoWeOEG2SOKll0VA+JfBkvG/Z9FYZkbAHLdxRM=;
 b=1pfS4z6BYWAfrk4BC3sfx5rRbvBfsgxjoO0SqE0QbiMMvyT8hHa9U3ha45F2CzYjb+m6TkuFkvCx0kNCJBRkM7WpCs0VnRqNDUU6dy7cZwZn40L04ivnOPcpXU1g7ODiBMJ8pEKqzKhiHEMbEuCK+fL3wCfciXxPWyKV8124OIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 23:33:56 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 23:33:56 +0000
Message-ID: <e608bda7-aadf-438f-bb51-2db599418634@amd.com>
Date:   Mon, 21 Aug 2023 19:33:53 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, Avadhut Naik <avadnaik@amd.com>,
        "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Avadhut Naik <avadhut.naik@amd.com>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: PHAT: Add Platform Health Assessment Table support
Content-Language: en-US
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
References: <20230810234856.2580143-1-avadhut.naik@amd.com>
 <a0ab4d07-fb73-418b-b88d-c3ad6aa4cf49@intel.com>
 <655c916e-356c-03e3-6c67-aa40886dd5e2@amd.com>
 <CAJZ5v0j0R1GK=0z+LJd_PSh4zDv9Ydw2YA7HWm1R5wjCUsbbYQ@mail.gmail.com>
 <1c579c96-5010-4e5b-aa27-afb4f4f6746a@amd.com>
 <CAJZ5v0iPRCJLH5bkKyhjUq_tmjmR6R73fhUm3JnKptcm1cn9fQ@mail.gmail.com>
 <6bc15195-aa26-4e29-b625-74fca84f7a6f@amd.com>
 <CAJZ5v0jEcD_1+jHfAk9eN0YYJFbDZN2rZ97KHyH2-w6EqRN9+g@mail.gmail.com>
 <43b65307-bc3f-4014-9bf8-a96c6ed15d9b@amd.com>
 <CAJZ5v0g+uVZwoOr-2W19Ux9u-D=WiY=-dtcQZwYU0Ov_GE5d=w@mail.gmail.com>
 <CAJZ5v0g_DyQAnSuigBc-f0UNmW0mo=0yMadES+0NhphJs_k+cw@mail.gmail.com>
 <9d491dfe-13d8-4072-a90b-5f68107fcf95@amd.com>
 <CAJZ5v0jxKwtHM3vhtw44TW5=J916XvXSeP3DyNLcJDo+eTSRHw@mail.gmail.com>
 <fbc0b21d-33e6-4c32-bc34-3fbfe5e99b1f@amd.com>
 <CAJZ5v0i-=kfBPp2oW-40mNSAFnOzTEeey0EhDUsN6qNU+QY4Ug@mail.gmail.com>
 <0c1fcac6-5497-4a0d-9038-9eebf988268e@amd.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <0c1fcac6-5497-4a0d-9038-9eebf988268e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN7PR06CA0063.namprd06.prod.outlook.com
 (2603:10b6:408:34::40) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 171ee73b-8b5b-42fd-8828-08dba29f164c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBQEpkNi8pNZDQe4S5fnVnps8An5mvJQyPlFCp+UNgBm+MiXwDcap+EQqfg3ILGqMIol6t05wikIxpIyfecxnt9T+V2ypVdaZKhH5NC2NItRc2HIrxmvf2PYLk0qb/I6GecgHkWeiAVPBc9pYh3AP6RoojQq9JwDIcWXq/aPG9mhalPm67tOncx5pDrYKUrr7fOicWX7JwnlC6wWXCUmZgjnuKzHfM6Wgaobj2xpl7eZJx/lLgK764HQZa2psJi2b9HOQx4bayaJZMV8Aq/K3JY0gj8yqLMZBhPuMi5Z7qCavZ3MeKO6RTirJOUK/VjbIFu2rhroETCdRVaBQjWTLHXE7/Nt924dbTAbXCFd4KnE+Y4/fDD5A1Yq4EnZhcJGDJyzVI8XBFR15seCNNazwp4BhArsZTxLpqogxyi17B6hdVN1gg/zUbIdo3llVDjcnhg0uH5nUZoPUXFb6UAe9pmfCX1rFl7Is8+pnxcRo9T6JZivP/5pcUeWBpEQeDu1rsQWao71wchmFxIa3EvZCwafHRaSjcCUgg5yvWqqXdwAPSxzPFnIlMKc2cHthlP/m5EHCQjv5QISr12Zun4WEy0di/4LePEbsanJhYMS/mocrAqYu/WVrWOqXfHLpS6aeRFl1gVqfgkZ00rVhQygfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(54906003)(6636002)(66476007)(37006003)(66556008)(316002)(6512007)(66946007)(8676002)(8936002)(2616005)(6862004)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(53546011)(6506007)(6486002)(83380400001)(2906002)(86362001)(31686004)(31696002)(44832011)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU00S3BLaGp4UVcvazlZSHR3SFBlZi9jN0V6eUV0RXdjSmJPMkw4T2FEaGVJ?=
 =?utf-8?B?TVA0cnlkYS90T0ttRUU4aTZqY2FmQUZtR3B4SVQvRUh3a3RFL255WlJiUWVv?=
 =?utf-8?B?ZVFvMmgrM0htSTBZSXNUNTJMWmpJMmNVSkVaRlZqS1Rmd3EwNWVKcGJDQzN0?=
 =?utf-8?B?a1VwaWU2Vmx6eCtjSUhybGMzWThqMHkxNVlva2taNS9KM0t5b0l2eERwbEJw?=
 =?utf-8?B?b0VLM1BWOWFOTEdJSHJRVDlpa0NibHdZNjdZNk0velJ4Q3dNeVIxcnMyYnBV?=
 =?utf-8?B?cjhzMTZqaHNBNEt6eThYb3djVjBDSVZMSVFISE9NRkJSUG41Y1ZKK0tQWHYz?=
 =?utf-8?B?UzhEdUxGaFFybGlOTGJoZXVtZCtlUlBBQkpJeDV2TjY0WlZYM3hqTHdMM3I1?=
 =?utf-8?B?NGVPaTZGOGo2cTMwcUNiWWxkMFdJd2ZHd2U5UEFrRXlkLzU4ZHltSXNVSWg2?=
 =?utf-8?B?cE42ODNUNjFhRDA4ck5sV2NyeEJ2RFlha1RWeUZLQkFSU2YwN0hoV0tRSUJk?=
 =?utf-8?B?WTYyUWlPUGc2a2ZaaEFTMEFZZVZ0UnRoTEVkSEMvc2JVVFhkOGlYSFNZOEc0?=
 =?utf-8?B?bmwrVkw5RGlhUjJCc2hDK1lET3dONXU3bFcrQ2hJWWo4RktQWFdRRThPalF5?=
 =?utf-8?B?Qy91V2V6NnBDUUM0QVFFTytZbWZUaFBNZmVrdnFRQW9EYSt1K2lzbWtVUjVS?=
 =?utf-8?B?TksxQk5pQ0dDYk1kT2cxV01wa1J0OGhia1J1K09uTGczZm9mdzE1VmZQeERZ?=
 =?utf-8?B?THp2MytEcFVNbzg4cExkS1I1SWRrV1hTNEVjNWd0czJjZHdFc3F0bjF4K1hs?=
 =?utf-8?B?UlRyRGQ5SURDU0ZyejNYSElpbjZhQzlBYmhWUWJzeEx3amowd20yMGthT1JV?=
 =?utf-8?B?ZW0xY2hBREl4NTJMdEZNRDR6SnhYV1o4MXVGVXQ2ZmpYSVBDTFNDeW51Szdn?=
 =?utf-8?B?b2t1N2x5REhCSUR5TG96UkJjTTJmUGFqRWtLNnVUbHJrdDB6MWkzZVIwMGZJ?=
 =?utf-8?B?ajZrTWE4OTcwbHFmMTIyc1FKYVlpMmNWT0FMeG5ia2NUM0VXcVlNbjRnQ1BQ?=
 =?utf-8?B?TnFOaVhWYlRrMnlXK3RvSFh4WGtHYnliTU1QQlpXK280clZyZmFxQ3hyd0Nj?=
 =?utf-8?B?UFdYSzBMSVpYNnk4dkhhM1M5MmF6c3JlRHQxbjI3MEJvR1BRb1NFNFhTYUxp?=
 =?utf-8?B?K1E5ZE9jZ0NFUWFQVHVqYXdCM0tIWDNLQ2Y5Z283Y0tHeHNCcFFSSHlxWEIv?=
 =?utf-8?B?RzBMOXFVbjBFRC9DS3BoUG4xREpHNWZESnM0NnM0alpobXBFL2prVnZ4VDFO?=
 =?utf-8?B?UkZoeldyeG45RERWb3NsVTN2UlQ5S1pCRElROVBCejJvcFFvNTRsVjhOd0ht?=
 =?utf-8?B?bXkxUUc2RzlsRHJlOVNDSU44cXFCeFRQcTdMRWxrNjQ0RFVPZVAwWkdxR0xE?=
 =?utf-8?B?cWJaOVYybXVlYmk0TnhnQVlnMXdGdWhlekQ2UXk4eERzcVJVNEk5T05WS2ZC?=
 =?utf-8?B?d21iVmRSUk5pRWU2VmNaTnQ3WUR0TWVjSk05M05NNXhKaEhRVWc4Q1BIZ3A2?=
 =?utf-8?B?VzNlQStxRWhBN3F0WGVxT09WbGpLMUxpNG5EZ0tWTjJEUHR1MHRXbHNzVmRP?=
 =?utf-8?B?Z0VkcHV0WE5HVHBNUllqREUvTG83d1FmSk1PZTZIMHJ0aGd1YXBESVdNblVu?=
 =?utf-8?B?dWk3MjBIZE5OZ05ZS0tuKzJaOWRqdGp0aUsrWUU3VERWUUJLQXdDWVcrdlZU?=
 =?utf-8?B?MEIvUUcyTGtmL0VGQ3hxTkJTcTdNZG02MTM4Y1pzLzRCZG4xRGpBMUNhOHBQ?=
 =?utf-8?B?Zm5MUmsvQ1ViSWc2cjZ4azlCRW5PUSt5OHNGSlM1bHJBUVZXeFRZWkdNRXJS?=
 =?utf-8?B?OVhZcnh3dkZMY2ZrTWh0aEV5Z2pMb0ZsMWduRThkcWRJcElWRmNKYUNRd1E2?=
 =?utf-8?B?R3Zwcjd3V29CTEd1a1RlT0pHLzlsaFpBSVVyOVRCNWRkR1NnMWFaMzRidEtm?=
 =?utf-8?B?RlJOa1lnNm15Z0Uway85alVUYkdaYllFT2ErYXh3bWNaSGMwNjEwK0wraHAw?=
 =?utf-8?B?K2RRU290OC9PSlVNZ3VxWTFtbWcwYUMzT09ZeHVOa1NVYUpEZVhydHk2MGpn?=
 =?utf-8?Q?U0YxYdIOmsLo2N3LGR3KYX8Y0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171ee73b-8b5b-42fd-8828-08dba29f164c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 23:33:56.4072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wn5tBmzRD2Ve2ZCoys7dtXT7L4q+lwBrdwV1QvJk8+s6dJN8UMbcH+yVw8kLQKgbpxVE7hZdIPk/hj3Sd6ZSGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/23 3:23 PM, Limonciello, Mario wrote:
> 
> 
> On 8/21/2023 2:16 PM, Rafael J. Wysocki wrote:
> <snip>
>>>>> Is there a preferred set of tools that can be updated?
>>>>
>>>> I think you need to talk to distro people about this.
>>>>
>>>>> If not, would it make sense to develop a set of common kernel tools for
>>>>> this?
>>>>
>>>> Yes, it would, but please see above in the first place.
>>>>
>>>>> In my experience, it seems many folks use tools from their vendors or
>>>>> custom tools.
>>>>
>>>> This observation matches my own experience.
>>>
>>> For the sake of discussion, and from a kernel developer's point of view,
>>> should the tools be part of a separate project? Or should the tools be
>>> part of the kernel tree like perf, etc.? Assuming that this needs to
>>> start from scratch and not extending an existing project.
>>
>> It can be both in principle, but from the practical standpoint it is
>> more likely to get all of the people to use the same set of tools if
>> they are included into the kernel source tree.
> 
> Yazen,
> 
> You generally envision tools like this to only be used when there is a problem, and not something that's run critical path on every boot right?
>

Hi Mario,

Generally, I think yes. But you summarized one issue earlier, and that
is the case where a user doesn't explicitly fetch the information and it
gets lost. This can be especially painful if the issue is difficult to
reproduce or has a long time to failure. Of course, this is new and
supplemental info, but every clue helps during debug.

Some highlights from the ACPI spec...

The PHAT is not urgent nor actionable by the OS:
"It is not expected that the OSPM would act on the data being exposed."

The info may be useful on each boot regardless of any problems:
"The Reset Reason Health Record defines a mechanism to describe the
cause of the last system reset or boot. The record will be created as a
Health Record in the PHAT table. This provides a standard way for system
firmware to inform the operating system of the cause of the last reset.
This includes both expected and unexpected events to support insights
across a fleet of systems by way of collecting the reset reason records
on each boot."

Note that it says "last reset", so it doesn't seem intended to keep a
running log to be fetched later.

> If so, how about doing it in a high level language with easily importable libraries like Python?
>

This sounds good to me. Anything that can handle binary files.

> Then the tools can still be stored "in kernel tree" and distributed with distro "kernel tools" packages but you can more easily use them on random old kernels too since the binary via /sys/firmware/acpi/tables should be widely available.

Yes, I agree. And I think we should give examples for running the tools
as services at boot. And documentation is needed, of course.

I don't exactly follow your last statement. Do you mean that new ACPI
tables will be exposed in sysfs even without explicit kernel updates?

Thanks,
Yazen
