Return-Path: <linux-kernel+bounces-48866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB1C846282
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6CD1C22906
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB053D3BC;
	Thu,  1 Feb 2024 21:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M0AVx3B5"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A913CF4B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706822097; cv=fail; b=YvtPWLUug7aLZDRAWv7HEiWgSxs4AyYAkbYDXpHjSgJcJS33fACxheiS8sF0dRMkkthV/4WmlYKE+NSpY8V4+Zf//73eBLSIYOY1K+Sj84jBeAMTieUMEZ5blU2vLU4AoQxOs6qvjvOKrZmjhR8DlaNomIEqnZ+j6iqYo/F24rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706822097; c=relaxed/simple;
	bh=c1IKNQhr9mh+BESh0fzYcRQ1orSrNa5PkG9SF/pN6r8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LTpodrsdW2QyGHtNEX8dbCqu894/tK8JoXLdzbYFamx83S3csVv3kchztkViR9aiZYhTTSCPSO/siKx9evIk6WEBXVcy883YjF/6QY9CUX/vqqQ0oBDT2rWkN6b72KK8dSmyo6CRP6iuyuaEdIJJzAAqI4M7faigPYTqYixwf5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M0AVx3B5; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVPbQaeGzzR2IacDgnTl9j50yuEDUnurf8s1z0eKrWf+aIxARfmt61uptPiqZhhQn/ORAy9pXCCqnsB0L0XMn1jUnh2aE1984GidOJRvaCNB0ucJCOz1kpSJSkVWctqdpaz+IOhcvtGI8o+0V5kroDZ/SW0BvHbMnHwzHL5RZPgM1WJdwfuXxrCTT+np/WRArLSFr2O22+kFPbd+Sb4mjSDETMgre7IV87/ONOYndjrJ19+c6Uu4V/x5+iRq2OHIPGRc1Y+Xj42MTXarSmHlRwkioo7imWjFeEPVKVSKj1D+MYDfWtZO8mwSjuRxgM3jNgdLdjKKiAB1Rgadm7keuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6dm2ODfmbQC8OGYyZLebpzLvu0WsKYZeuWkwqZaPWU=;
 b=JcorhSvkF8auXAw4zGekqM3l+4UV8/bGVV+uDD9d0Chk3m6GYCrcfkSvcJQVu4C9rDFkiJ7n9nmdcNri9sHNWymt9MHsJ4N8hUQs2ZhLGjD4LctW7e9Tcq2ODAJL9FTmClgsygrKyLaiSUHESKldz5jjI+8jnC71+6QNGHG1SPBXOQNpEwDuQG2ZS1jOotIWtNEgaCE8bMSc0Zs6BvLNA2iaJgUXNv0EeMzzEGrDtb/soUwjSt8YIw1gJ7T4izmGhAMJv3hWhxCHh0+yMtF8DNm6LG9YnzmO0TRl7CWhk5SlsGm8boTbQh2n7j6st4SSg3gnBUbZM1QTQ0Kee2sC8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6dm2ODfmbQC8OGYyZLebpzLvu0WsKYZeuWkwqZaPWU=;
 b=M0AVx3B5mCCHNzmK+LE80XL1xxlkXYaJ+23u4ZUuclp64ca7jNCC3kTXMH1UcjaIeY5cZ1AnB1+WzI7r9xK23oYTIq2nLxL0DC7kEK8Hy13dK3Xp8Q/P4svCRJalhhNxCUEz+mlZgBRJWUjOXrxO8BFf63HtxLjYzepnIzCv7gc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM4PR12MB5279.namprd12.prod.outlook.com (2603:10b6:5:39f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Thu, 1 Feb
 2024 21:14:51 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c%4]) with mapi id 15.20.7270.009; Thu, 1 Feb 2024
 21:14:51 +0000
Message-ID: <d91b980c-b019-415d-8549-af4890a21d2f@amd.com>
Date: Thu, 1 Feb 2024 15:14:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] x86/sev: Extend the config-fs attestation support
 for an SVSM
Content-Language: en-US
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <10637f104d1ed7f21e281a4890f2c549d1e85985.1706307364.git.thomas.lendacky@amd.com>
 <CAAH4kHbjZY5J=EQsyXxvthTbpge-W9PTJc4WD-O2JaWZyZFPgA@mail.gmail.com>
 <3fca61f2-6fe0-4431-818e-9c7b96c6a391@amd.com>
 <CAAH4kHaw7Cpq713sPW2-+TTzmy41O8qHRKYsG2MO06vF1eSJaQ@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <CAAH4kHaw7Cpq713sPW2-+TTzmy41O8qHRKYsG2MO06vF1eSJaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0144.namprd13.prod.outlook.com
 (2603:10b6:806:27::29) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM4PR12MB5279:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a04cdb-bccc-498f-762a-08dc236ad448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vRJV+xT4cJmF/8wstXVmT68RT1XEP+u5po9yuxHMVLJx7kw6fu3TEsrbxKoxZxLKY4YtyeCYDCTazKemq55nVrW4jfE+MVjK7TM54ANXoqXiiSXYv9wDRdJmCac1lyQOe/1LZcGY1xApnH0rYuk71RU+W2ydmXbeLKlOQE/5VToYQw6JePAL1SSRQrtYI+7sj7kLp7jhunq+PScjTpIlHoS+WfGOK2kLA3KOikES9YlvL5wnMuv1XGEaHLaQR2x4W2XiJX04Z5byWtnbwZOGB2/JtJEjOiwQGqtPq+uI2vxNRlwgP0BeGWR4rawCRLrhl4oAMZ3jmXyzzwDwbonO00rM/hSc2BIDzkAqvzDu+M7Ldcp2NhU5itxcPSuJ6Oj9TUgl5haiKlt+i7ON2NeI7Tg+5dCXRTfT/JRZOLIbK5d+jl99LJRuHTRR9cz/K3HBGaK0HiXAUye7ySlqIZ8zVJR5R3xyNrF/Ei+MQGKFMwQXEH8y5OVsPqeX4/IbvYCeapHXpASnKYyulkQkMxJBS+G7RarheG5PPVbGw7rxxYOSKeSONQZ8croLudnGkmnOQOuflO3E/k2pNhpBcSHy4OEqn0abGgr6K+8binCaChZKknFnPSQaQOnfoU9wpty/cjw9PBPlPGui2wvtZI+ROmiVFiK7cHraSastWsvCUEH3LbcFWW5O+XG9K418rvK2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(5660300002)(7416002)(478600001)(966005)(6506007)(31696002)(6512007)(53546011)(86362001)(8676002)(8936002)(6916009)(66946007)(66476007)(66556008)(4326008)(41300700001)(54906003)(316002)(36756003)(26005)(2616005)(38100700002)(83380400001)(6486002)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEIyUHFLbVBkQmQ0RTNxZzZMRVBaeU5yNVlVZkF4RGVrU1BOUmFMN0RjaGUv?=
 =?utf-8?B?dGlZL0R5M0VSTG1HakgzSHlQYURuQUtXak9GOW1vUTVQaUk3ZmVMdkJwNEo0?=
 =?utf-8?B?Y2huNlc1Wmp5VGkybXo1N0lZVmJjOXhHd3JFVXgyMEZBRU1rZWdwRU5RN0xJ?=
 =?utf-8?B?QzZiTnJnNFJTUjB6bmEzWHJ4WnMyVzk0VTQ1WnVpbEZzRWtWMG5QdktoTHNz?=
 =?utf-8?B?ejJxVkJSRm04ZjQ2dm1XY2pRY0NxQmx1bGoyd0pTWHNQTks0bFVmMnlYSEZF?=
 =?utf-8?B?MFVQZG90SG5jR3F1SFJPZFVaTmd4MXB4empsbHFqVnFOalhONHB4VFV3UExF?=
 =?utf-8?B?M1pzdm81WEJWeTF6MzJZc3NwOXNQV2lZL0thRG9ZTXdVNWRqTmV2eVdZcnJN?=
 =?utf-8?B?cGZNaFFTNUpJaU15bHNvR3pVT0F1cVNrMzR6bXJIcEl0OEVSeXBNUkNHZmY5?=
 =?utf-8?B?Ky8vaDVHMEQ4YkR2Uno4WXE1MTBqTnlvcDJDOEx2QVNyd0N1MUQyU3YvWjBN?=
 =?utf-8?B?dTJBd0RhZU50QVNQZ3RSeTJNRDBHTjd6dExDM1NaTjRMZ25RT0U1YmdZNFdu?=
 =?utf-8?B?ZC9mZnd0aEpEQjM1MHJDUVNhdDFibDZhNGlIZWpzK2dnRWdqS3V6MHdDbXhO?=
 =?utf-8?B?bzhjNEc5czk1bmlkQkVvVmh5S0ZhRmw5MjZITTRmb2o4ZjFadDNpVzVoZFBB?=
 =?utf-8?B?VzNUandzcnBJTUtrTkp6enJmOUtqbGgxSG92NzNKYWk3YUpYNWsvb2U4NWNW?=
 =?utf-8?B?Y213NEpnKzZHZmxKYzNvNlVzeVh4aEk2NlcrWUJ1bnVrTVBHYkpwY2FaWDNj?=
 =?utf-8?B?MEJFditTK3JQdFBlMFhTMjFLT0RBeGRLVzMrcE56QnhmN2NxQWJDL0FlaWVz?=
 =?utf-8?B?YmF2MUxHcGZFaG96bnJoUzQrN1gxRXF6MFBzL0RUTmZabWRnaFJRcmZEZEFn?=
 =?utf-8?B?UEFzeVMzWGZlVFl5RGhyZXBZaHE5Z1RkajkySkliSCtQd2lyR2RuNTR2OE1D?=
 =?utf-8?B?Wm9TSGMwZlhKTGpBdGVKT3NLUldiRXY3OTJpdUZJOGVZelZ6ZERRczNheWts?=
 =?utf-8?B?N1Z6WW9OcFM0ZC9UTlNJS1FHVjh6OHVnZHBqN2cweTBrMndCWStQY2pSS1JS?=
 =?utf-8?B?Ym9GVzY5alpOalhxSlRkelUyeGt6ZnZFQW5rNkF6TC8yWUZ3cDB3Z25pVFo1?=
 =?utf-8?B?WjQ0MEhMcGx4ekNvNGJUQ2k0OG1HREN4ZjFFTkVwemdjUGNQSEhrSkREMTls?=
 =?utf-8?B?VHNzT2kzcEJHcUlYV3BVN3ZvUG1lTDF4THpFU1BoS2F5L0krM2hVemQzcUxv?=
 =?utf-8?B?cEhEekh4Y1hGYU9SL2d1b1Nub0dpdUxJTEtXbUZHK0hDRTRydXoxT3RMT1pY?=
 =?utf-8?B?Wk82MTdsQTk4SmxSUm5NWEszMEpHUzN4NEdvMGxkbURxc04vblAxVmd1SGxU?=
 =?utf-8?B?STFXZ2llM2xqczBFV2p0K2pDVERrOG1NbXYxUmpXNXdNeTZFMDk3RkE4UHlS?=
 =?utf-8?B?UlZHOGk3akx4MEdNWmRxclRiaTNRM0NkMVRaK0xxcnoxRHFtVkFVNXoyR1Vh?=
 =?utf-8?B?N0tVS0Rxb0twUmRvOEdETlJZKzBxeW0va0lLclE3TEV0U1kybGdQMVR5YjFX?=
 =?utf-8?B?NXI3UTh2NWdZQjh5NEpucnRSYWRjZGI3K0UyeE9JYkF0MjZRSjdZWXl5S3lT?=
 =?utf-8?B?Kzg0UHRBcDNHcVg0WmxWOEgyMVVQRm9QKytmektVakhsTUJ0RlNEdGJSNk0x?=
 =?utf-8?B?TXlJRStPSGlrMG9DR0kyQVcwQWlpZ1poZnhFZ2J2ajl3T2o0Nng5bzJDVUhV?=
 =?utf-8?B?NTFBcXRoNEc1TzNwOGs5YkRVMDNFM0dJcTBOSDlacnFQMEd3eG10eTQrZlM0?=
 =?utf-8?B?R1E1NzNYaTI1Z0xBMklhc3RRcE9sZGpsOGdXQUhMb1J1ZHZMNkxveW9aKzcw?=
 =?utf-8?B?dXh1RGJLQzVIb0ZzdWtXODJjekNwcGd5UUsreEZ0akVmYWtUbno3b0FCSTRq?=
 =?utf-8?B?RHFvN2xhcnVFTGdwSGxOSFNOUmVWenNLNG9JMGdaZzRFY3cwa3pWdjJNaktB?=
 =?utf-8?B?SGNlNWwxK1lkeGRzdE1sK3p2TXJtb3hjVjJPYmg0SmFGZHN5V1BUT1BHNmo3?=
 =?utf-8?Q?xpqDGMonlZABfHSggBsoBuf0C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a04cdb-bccc-498f-762a-08dc236ad448
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 21:14:51.6014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwFmgf2MEn5FxDD8Clh7PepVIZAZ8v8bMLmZmYduYceXH3sZWnYFEevF7JAJVOq4HITjbVKfbdwxmehbDGqVtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5279

On 1/29/24 14:04, Dionna Amalie Glaze wrote:
> On Mon, Jan 29, 2024 at 7:02 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 1/26/24 19:27, Dionna Amalie Glaze wrote:
>>> On Fri, Jan 26, 2024 at 2:19 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>>
>>>> When an SVSM is present, the guest can also request attestation reports
>>>> from the SVSM. These SVSM attestation reports can be used to attest the
>>>> SVSM and any services running within the SVSM.
>>>>
>>>> Extend the config-fs attestation support to allow for an SVSM attestation
>>>> report. This involves creating four (4) new config-fs attributes:
>>>>
>>>>     - 'svsm' (input)
>>>>       This attribute is used to determine whether the attestation request
>>>>       should be sent to the SVSM or to the SEV firmware.
>>>
>>> This is where I'm torn. If there's an SVSM, it's there to provide
>>> paravirtualization for unenlightened guests /or/ it's there to protect
>>
>> An SVSM is for enlightened guests. A para-visor would be for unenlightened
>> guests.
>>
>>> runtime measurement registers. I don't see there being any particular
>>> value in bifurcating the attestation report space by adding this
>>> option. If there's an SVSM present, the configfs-tsm report should
>>> return the full SVSM attestation only.
>>
>> I don't necessarily agree with that. The guest should still be able to
>> request a traditional attestation report.
>>
>> Maybe I can remove the SVSM attribute and direct the call based on
>> requested VMPL level. If VMPL0 is requested, it goes through the SVSM.
>> If VMPL1+ is requested, it goes to the ASP.
>>
>> That would mean that the privlevel_floor would need to stay at zero.
>>
>>>
>>>>
>>>>     - 'service_guid' (input)
>>>>       Used for requesting the attestation of a single service within the
>>>>       SVSM. A null GUID implies that the SVSM_ATTEST_SERVICES call should
>>>>       be used to request the attestation report. A non-null GUID implies
>>>>       that the SVSM_ATTEST_SINGLE_SERVICE call should be used.
>>>>
>>>>     - 'service_version' (input)
>>>>       Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
>>>>       represents a specific service manifest version be used for the
>>>>       attestation report.
>>>
>>> I know that this is specified for the SVSM, but I still don't know
>>> what the intended use case is such that we wouldn't simply always
>>> return the full service manifest.
>>> I can see an argument for an evidence requester not being ready for a
>>> new manifest version and wanting the older version until they can
>>> bridge the gap. I don't see that as needing configuration from the
>>> user space. We can either require new service GUIDs for new versions,
>>> require manifest ABIs to be internally versioned to be additive-only
>>> to not break verifiers that understand up to manifest byte X, or we
>>> allow breaking version changes through control plane configuration
>>> that's passed directly to the SVSM.
>>>
>>> New versions get new GUIDs allows for gradual deprecation at the
>>> expense of size. I think that is a reasonable trade-off to keep from
>>> making tsm/report vendor-specific.
>>
>> This was requested and discussed during the SVSM spec review and there
>> were no objections raised. See the this thread where this was discussed:
>>
>> https://lore.kernel.org/linux-coco/09819cb3-1938-fe86-b948-28aaffbe584e@amd.com/
>>
> 
> We also hadn't had the configfs-tsm unification point, so I think it's
> worth folding in that discussion.
> In terms of querying specific services, would you help me with a
> concrete example of where the evidence collector ought to query a
> specific version instead of the service enumeration?

Here is where the request was initially brought up:

https://lore.kernel.org/linux-coco/fbc84da05c5343c5228c5adb697d4b66f1ea6308.camel@HansenPartnership.com/

> 
>> The changes you're requesting would require a new version of the spec
>> and updates to the protocol.
>>
> 
> I think the changes I'm requesting are to just limit the exposure of
> the protocol to linux. What specifically about what I wrote requires a
> change to the spec? Is it the lack of plural handling of 'its GUID
> value' in "Each service will document its GUID value and the format of
> its manifest content."?

The spec is currently written so that a service has a single GUID. If I
understand correctly, you are asking that each version of the manifest
for a service gets a unique GUID. That would require a change to the
specification to document such a behavior and possibly a protocol
modification to somehow indicate to ignore the version field when
requesting a single service attestation or a new protocol that does not
take/use a version.

Thanks,
Tom

> 
>>>
>>>>
>>>>     - 'manifestblob' (output)
>>>>       Used to return the service manifest associated with the attestation
>>>>       report.
>>>
>>> Given the above, I think we can just append the manifest to the report
>>> since the report size is known a priori.
>>
>> We could have theoretically done the same thing with the auxblob (certs
>> data), but that is separate. I prefer the idea of having an individual
>> entry per piece of data being returned.
> 
> Fair enough, another RO blob seems okay enough.
> 
>>
>> Thanks,
>> Tom
>>
>>>

