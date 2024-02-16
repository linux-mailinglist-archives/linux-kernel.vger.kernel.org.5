Return-Path: <linux-kernel+bounces-69261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677C3858656
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C146728319D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10075137C48;
	Fri, 16 Feb 2024 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hNjALUKE"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA03131E5C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 19:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112809; cv=fail; b=MwQ6kZZ5ZDt47w1yTe9gWzBK+NOG0s2TaGJ+2Soxv/jnuW/lPqWyI4hCttt+bwQwFrEjAsfiMIPO5DFGjrUmDHnBhikLPR1c3YSdgCCuTcpvb3lI+0cKgPCaOtHfi0wFRxZ/HeZmEstwWbXsRNttfi6S6msBH29t75zU2OAC8+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112809; c=relaxed/simple;
	bh=uFRXNPHir2rxFMHnucZnd3hxNlqwHvz76eHnx5odsI8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qDZh5bYnpH/Hhu/aLYGKKtKhMBHu2RjhALCZQW+jVtClE6nhbSzaAP/lRh1UXEf1o5Ebhp0SaT8s889IrfULf1w0BGzd/LxQetc6TILbMs+cuwEhK4y+ZGnuR1nJB7Q9ZEPmEjVw1X0v7GMWsycTtZLP41yG9JAQwKZOeFicxQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hNjALUKE; arc=fail smtp.client-ip=40.107.95.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGArxMGoBoUSqd65sSclil2GETiepS0NHv7HJ3tEu0Jhgt6O7r9qo8u4MK7A9kSSKa5WBBbIm1XDpcwGo/nxvrirSBqn5XYFYE74LkSddCwZESugQw5G8y+e01k5oMp20x0lqZ11Vbd7Cp/oXXoHgpy2F3sIxCRn5ExsDaL7CvZvJypQkxE/FoV+eF8nRcmrL67pez7Vov9hHzjtaGevI2Np9iEZ7DYBchvrriJ9yanOLA4qqoK/zfTdRmof2j9t+ysuzR4U4mXwxjJtuQx7Zo4iou4QRTRs1xVvP8LI1/olr42L1l1LKn11ZnrUAG2zXSrPY5WMRLDJiKYtJHenFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkTmHO2noBMuDWCLaB6yNmDz4Lg2AnR28L3vChl6IWg=;
 b=abB2yaRJ5nHrq4CBO12NO3OwEcbd+XYPKc62IeQiDDB8pHH24f92nFgwiVY9N4Ib+3oMaRV45VD99cQgp0ny/gud+H7JBYancAi1Jzkt2acV39SewaDG8EW8q7UaN3DRw2SQmA1uqleh4zbS/0mz/ThV1BLrwBJ47P+/sg2qQct0GqcnHo/AjO0SREy2gkLyoR3FJ33UJcGDembMbk2rHhLablwd6erhj16Ye4j4u543UuwfurOP0KaFOgIJFabWQknMlaP38O3V+FdfDM1ElwQBAw1bIf5Xt3Cslfr9p61MrvB2Ce2QsSudPr3CXQV0PKc2IltLwrTA8imgruVhdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkTmHO2noBMuDWCLaB6yNmDz4Lg2AnR28L3vChl6IWg=;
 b=hNjALUKEENsgSePQ7FOxP3lV3ZBJJ1MZSs0Y9IISiKiihJy+9WrSReNOKfB4J4m5XUoLyG5HwrIeGk1t3DpUVZ27MKGyUbnBJPcQmJdXl5r93lQco5HwZ+41pq5eEVGiQ5PevECfW8B9Op5oo9wsjdNVyJQKF02f0peIlm+MYxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Fri, 16 Feb
 2024 19:46:44 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::e164:6d6:c04c:ff59]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::e164:6d6:c04c:ff59%6]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 19:46:44 +0000
Message-ID: <447b491f-ae1a-85db-a862-0a2b999cd0d4@amd.com>
Date: Fri, 16 Feb 2024 13:46:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 00/11] Provide SEV-SNP support for running under an SVSM
Content-Language: en-US
To: "Reshetova, Elena" <elena.reshetova@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 "Shutemov, Kirill" <kirill.shutemov@intel.com>,
 "Dong, Eddie" <eddie.dong@intel.com>,
 Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <DM8PR11MB575087DCCB069C723BBE1B47E7482@DM8PR11MB5750.namprd11.prod.outlook.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <DM8PR11MB575087DCCB069C723BBE1B47E7482@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0078.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::25) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: af71e00f-cefc-44dc-c23d-08dc2f280131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rNX3TmXwnbnzmTN8mpcZiiaFFLzqsFOgrLAoWiD/db121fN4OLyQSrrHXH+WmzGydyR8QEakMl62C7ax0mzLQTy3dq+iN9Mge3odg5rN2475lVYjLIZNtL0zvoao8/hg7kSl8TfQxZfaJ6/AMNNYP9rV3F6dyJWD7PfNVYxjOT5YAqOCDPH4nsMQpE2j+OvImRM4iF3/I5WPRZWVOb9pJ3yEstpdHLSESzVmTTSLFLl4WSzoRpAr+uZWrgueurHaF45YCy3lBh2xnEiMfaVOTBFLFd6tXenQlI55K/kNIxYlXFkrv0QiEP47g8d2szUUdYpXpmBLAv6BZztF1lL7H9Mtw6jO+dKITNmWmxmxVynxmmEdoNS5vyHE629GNEBJYd9OJglRUkDtwk0ePqP8mWS746jF1d+qVIJ0vScVfXWrllPl6sCx6HDDsXBUKORJt2ErI6rCoS1rvT35MA3Qu+ozOWLCiwTTNU0B/b6pulCD8JIztqpLf0qs5/esfHHtrJNgehEcewGfiIw3TSCo177e8ChCPDTcekKvdDcs44qiJurr8dwMH6QT5ouphEHY7BFWbLYJdWDPO/YW7XMMyg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(7416002)(26005)(6486002)(53546011)(36756003)(6512007)(6506007)(478600001)(2616005)(38100700002)(966005)(6666004)(86362001)(8936002)(5660300002)(66946007)(66476007)(66556008)(4326008)(8676002)(31696002)(83380400001)(54906003)(316002)(110136005)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTBBemMzVmwwMUNraHFqN3FMZnpoS1JuQ3VhMDVvVFpOM0RkbjFkSjBMTDRQ?=
 =?utf-8?B?RkdEaGE1R2xCS2lWVzFzSFVCb1VDbHN6bS8wWm52RlRGcHN6Q3VjcUQyQ01u?=
 =?utf-8?B?UWNQai8yM2FzTTRoLzFYVzM2Y083bTFzenEySm5zc0N3Mm5STks1SkIvK1Zv?=
 =?utf-8?B?eWhVaGNpTU9LcHVTYTcvL2NFYUxyNmZ2b2wxQ3Y1ZXBPS3VGNDd6WXVjZHg4?=
 =?utf-8?B?ZloyRWUvNVlxMEZKMVZmVHNWaGlHUzBhdzdrbG9ZTWhuUHVVUXBjYVR4Ym90?=
 =?utf-8?B?S00yMmx0T1NYcjdLc0tUY1VlcnhVMy9MQS9XcEMxNloyYUwxSW1KTitYN0tk?=
 =?utf-8?B?aXJtZ21xekZIMDBKL2xRc0FteTFLdFhYNXBicEFiYTAwSlJvVmh1eWpnUVNI?=
 =?utf-8?B?ekZxUlVTUXgzb0w0a3d5MUtrLzQ1TndyRWYxZlpCcnErYXdZSEpUMmYxOENm?=
 =?utf-8?B?VHA1d1BSZXhhK0Z4YVZ1L1BZeldaZzNqanFoRWs5Sk85QXN5SjJ2TGFyV0pM?=
 =?utf-8?B?TEtubysvYkdjVDNxeE5Md0ZweXM2YWJpSjUrTWhLZ1p5MUtUV0R0a2VjMlc2?=
 =?utf-8?B?UXN1VmVrRzFVWDB2cDF0Vmhod2JBY3laRkdWbnNDbm5KcVAyRzNzS05kWklG?=
 =?utf-8?B?SkhnVFpueFIyMWhDVmhSR1BxSHpLMHh3TkhHS2dqSVJEcEZobGJkWUdqM01m?=
 =?utf-8?B?SGV5Q0RvUjlaakd2TVlVcmptS0FBTlBUVWlFL2xnOHNzSWVzdUxXaUFONXMy?=
 =?utf-8?B?T0JuS2tRdjNncmNudHVGZE1jSzVBUVA2b05yTm1KT0svWUdZWXZTbVdaQkNJ?=
 =?utf-8?B?Rzg0c3RNa0hnZ2hpdFRKaEdzQi83bXY1bm1YRWsxbzNDUVNCNzMxSmZqYVJU?=
 =?utf-8?B?ZFVSTkZmNDZjNlpNWGYzTDNGb1JFM2N6dDZ0VVdTZGZMZ2Q3eGtTck1BVG9p?=
 =?utf-8?B?dEpvUUpKVVM1WmM1dDgzNmFrM3UvTTVuRkx6d2dtQ0ZMMjFDZnpCY1EwQ1dC?=
 =?utf-8?B?NGN1U2lmaGRaV2NTL0xLakw5eUJXY2dYNFZCd2ZaZURnZThQMWx6a1pvUVZy?=
 =?utf-8?B?YlJ4cFdIYTgvM2xLcnFUNGs4NTZFeXZNelh3SGcwN0Jpd2RCZjJoT2Fzb1h6?=
 =?utf-8?B?Z09sajNDZlhRWGhKMEd5bURBVGRrL0xrN2RjOEorcWV4QVJla3NQNE5iQmht?=
 =?utf-8?B?WGVWaGx4dStEelNjUkpObm9mT0haSGxYQjU4eFNya3FhZXNXbmFZZ2tpcjVI?=
 =?utf-8?B?U1Vud0loSjY4eTNpdHVDaTYrTjhRNG9wdEpBbUhTREh2aEFaTmdhYXFwbDNi?=
 =?utf-8?B?cE1QKzIvaFB0VEduSDVBTlFFa2tyd2ZlblRvclFheEpKeW5jSDY0MUx4Vk5v?=
 =?utf-8?B?dVFzUXROSFVjSmVwMWltUGcrQzlzSWl6L2hyTHBTQ2p6RVlkblNIbkh1Q0h2?=
 =?utf-8?B?V3QvSFAxdFhtOFFmNUQ5NnIwZ0NlalVnOFZqV0VKT1VOZTE5Y2lFcDJ5WDZn?=
 =?utf-8?B?WFZueTdqSHFCZHdYTWw3TFJzdFI0SVNRcHFpbDBsb3kyM09XczlpR1MyOXNL?=
 =?utf-8?B?VHhnamNSWXpLazNOd1NLbjl6d0x4R3pJYk8vWmFkMjhhd3ZwSnAwQ3hoMlU2?=
 =?utf-8?B?WTlOUE83TUY3V1ZwUC83ZmN6VEVTaW1pWklYZzRmZHhlR1AzUFdFLzMvek9H?=
 =?utf-8?B?OGlUTnNhL2oyZW40aFJSa1lSMlgzaVhRMlJZRFdvb3R5eDl0NUVxdExnKzdv?=
 =?utf-8?B?Zmt5MjZzSzZoaDVueDFicXJDSDBKR25tdjBmblBlcDR5TVg3R054NjFKeW93?=
 =?utf-8?B?L0dLdStnV3NwbE1MOE1EdTVUZ2lmVzRVUTEyVVREa3d6N2QzZFpoaVdqNXM3?=
 =?utf-8?B?QTM5NjM2VmkrTVA2ZjNmOVhGL0gzVDJScno1V1F5RFBDSHdDM21QYnRqSWFs?=
 =?utf-8?B?cXh3a2R0N2Vpb2hnRXYzcC9LR2o1ZGtRNEk4UVhhRW1XdjNPZ0RVVnRqMm0w?=
 =?utf-8?B?Tm9hbHJZd3dBV01VeDN2SlFiMnJoeUYweVZpSVBkU3lHWWYrRGFWd2FXS3NC?=
 =?utf-8?B?NVVucWFUZVp0VHBWWWZhZmYzVFVGT1F6YklSUnE0MFJBODhrK1lmL0pJQVN5?=
 =?utf-8?Q?+9O4cmaDt8tT3pFleqLZgJ/7B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af71e00f-cefc-44dc-c23d-08dc2f280131
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 19:46:44.6252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EE4E9WMWgUvRSiWznfFdrqxmkAd0DijzAtbZQo3uE++QKEYrT78q+Kh7ybVq7H960OWVBy0+I9Baagr3dUAIoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720

On 2/12/24 04:40, Reshetova, Elena wrote:
>> This series adds SEV-SNP support for running Linux under an Secure VM
>> Service Module (SVSM) at a less privileged VM Privilege Level (VMPL).
>> By running at a less priviledged VMPL, the SVSM can be used to provide
>> services, e.g. a virtual TPM, for Linux within the SEV-SNP confidential
>> VM (CVM) rather than trust such services from the hypervisor.
>>
>> Currently, a Linux guest expects to run at the highest VMPL, VMPL0, and
>> there are certain SNP related operations that require that VMPL level.
>> Specifically, the PVALIDATE instruction and the RMPADJUST instruction
>> when setting the VMSA attribute of a page (used when starting APs).
>>
>> If Linux is to run at a less privileged VMPL, e.g. VMPL2, then it must
>> use an SVSM (which is running at VMPL0) to perform the operations that
>> it is no longer able to perform.
>>
>> How Linux interacts with and uses the SVSM is documented in the SVSM
>> specification [1] and the GHCB specification [2].
>>
>> This series introduces support to run Linux under an SVSM. It consists
>> of:
>>    - Detecting the presence of an SVSM
>>    - When not running at VMPL0, invoking the SVSM for page validation and
>>      VMSA page creation/deletion
>>    - Adding a sysfs entry that specifies the Linux VMPL
>>    - Modifying the sev-guest driver to use the VMPCK key associated with
>>      the Linux VMPL
>>    - Expanding the config-fs TSM support to request attestation reports
>>      from the SVSM
>>    - Detecting and allowing Linux to run in a VMPL other than 0 when an
>>      SVSM is present
> 
> Hi Tom and everyone,
> 
> This patch set imo is a good opportunity to start a wider discussion on
> SVSM-style confidential guests that we actually wanted to start anyhow
> because TDX will need smth similar in the future.
> So let me explain our thinking and try to align together here.
> 
> In addition to an existing notion of a Confidential Computing (CoCo) guest
> both Intel and AMD define a concept that a CoCo guest can be further
> subdivided/partitioned into different SW layers running with different
> privileges. In the AMD Secure Encrypted Virtualization with Secure Nested
> Paging (SEV-SNP) architecture this is called VM Permission Levels (VMPLs)
> and in the Intel Trust Domain Extensions (TDX) architecture it is called
> TDX Partitioning. The most privileged part of a CoCo guest is referred as
> running at VMPL0 for AMD SEV-SNP and as L1 for Intel TDX Partitioning.
> This privilege level has full control over the other components running
> inside a CoCo guest, as well as some operations are only allowed to be
> executed by the SW running at this privilege level. The assumption is that
> this level is used for a Virtual Machine Monitor (VMM)/Hypervisor like KVM
> and others or a lightweight Service Manager (SM) like coconut-SVSM [3].

I'm not sure what you mean about the level being used for a 
VMM/hypervisor, since they are running in the host. Coconut-SVSM is 
correct, since it is running within the guest context.

> The actual workload VM (together with its OS) is expected to be run in a
> different privilege level (!VMPL0 in AMD case and L2 layer in Intel case).
> Both architectures in our current understanding (please correct if this is
> not true for AMD) allow for different workload VM options starting from
> a fully unmodified legacy OS to a fully enabled/enlightened AMD SEV-SNP/
> Intel TDX guest and anything in between. However, each workload guest

I'm not sure about the "anything in between" aspect. I would think that if 
the guest is enlightened it would be fully enlightened or not at all. It 
would be difficult to try to decide what operations should be sent to the 
SVSM to handle, and how that would occur if the guest OS is unaware of the 
SVSM protocol to use. If it is aware of the protocol, then it would just 
use it.

For the unenlighted guest, it sounds like more of a para-visor approach 
being used where the guest wouldn't know that control was ever transferred 
to the para-visor to handle the event. With SNP, that would be done 
through a feature called Reflect-VC. But that means it is an all or 
nothing action.

> option requires a different level of implementation support from the most
> privileged VMPL0/L1 layer as well as from the workload OS itself (running
> at !VMPL0/L2) and also has different effects on overall performance and
> other factors. Linux as being one of the workload OSes currently doesn’t
> define a common notion or interfaces for such special type of CoCo guests
> and there is a risk that each vendor can duplicate a lot of common concepts
> inside ADM SEV-SNP or Intel TDX specific code. This is not the approach
> Linux usually prefers and the vendor agnostic solution should be explored first.
> 
> So this is an attempt to start a joint discussion on how/what/if we can unify
> in this space and following the recent lkml thread [1], it seems we need
> to first clarify how we see this special  !VMPL0/L2 guest and whenever we
> can or need to define a common notion for it.
> The following options are *theoretically* possible:
> 
> 1. Keep the !VMPL0/L2 guest as unmodified AMD SEV-SNP/Intel TDX guest
> and hide all complexity inside VMPL0/L1 VMM and/or respected Intel/AMD
> architecture internal components. This likely creates additional complexity
> in the implementation of VMPL0/L1 layer compared to other options below.
> This option also doesn’t allow service providers to unify their interfaces
> between AMD/Intel solutions, but requires their VMPL0/L1 layer to handle
> differences between these guests. On a plus side this option requires no
> changes in existing AMD SEV-SNP/Intel TDX Linux guest code to support
> !VMPL0/L2 guest. The big open question we have here to AMD folks is
> whenever it is architecturally feasible for you to support this case?

It is architecturally feasible to support this, but it would come with a 
performance penalty. For SNP, all #VC exceptions would be routed back to 
the HV, into the SVSM/para-visor to be processed, back to the HV and 
finally back the guest. While we would expect some operations, such as 
PVALIDATE, to have to make this kind of exchange, operations such as CPUID 
or MSR accesses would suffer.

> 
> 2. Keep it as Intel TDX/AMD SEV-SNP guest with some Linux guest internal
> code logic to handle whenever it runs in L1 vs L2/VMPL0 vs !VMPL0.
> This is essentially what this patch series is doing for AMD.
> This option potentially creates many if statements inside respected Linux
> implementation of these technologies to handle the differences, complicates
> the code, and doesn’t allow service providers to unify their L1/VMPL0 code.
> This option was also previously proposed for Intel TDX in this lkml thread [1]
> and got a negative initial reception.

I think the difference here is that the guest would still be identified as 
an SNP guest and still use all of the memory encryption and #VC handling 
it does today. It is just specific VMPL0-only operations that would need 
to performed by the SVSM instead of by the guest.

> 
> 3. Keep it as a legacy non-CoCo guest. This option is very bad from
> performance point of view since all I/O must be done via VMPL0/L1 layer
> and it is considered infeasible/unacceptable by service providers
> (performance of networking and disk is horrible).  It also requires an
> extensive implementation in VMPL0/L1 layer to support emulation of all devices.
> 
> 4. Define a new guest abstraction/guest type that would be used for
> !VMPL0/L2 guest. This allows in the future to define a unified L2 <-> L1/VMPL!0
> <-> VMPL0 communication interface that underneath would use Intel
> TDX/AMD SEV-SNP specified communication primitives. Out of existing Linux code,
> this approach is followed to some initial degree by MSFT Hyper-V implementation [2].
> It defines a new type of virtualized guest with its own initialization path and callbacks in
>   x86_platform.guest/hyper.*. However, in our understanding noone has yet
> attempted to define a unified abstraction for such guest, as well as unified interface.
> AMD SEV-SNP has defined in [4] a VMPL0 <--> !VMPL0 communication interface
>   which is AMD specific.

Can TDX create a new protocol within the SVSM that it could use?

Thanks,
Tom

> 
> 5. Anything else is missing?
> 
> References:
> 
> [1] https://lkml.org/lkml/2023/11/22/1089
> 
> [2] MSFT hyper-v implementation of AMD SEV-SNP !VMPL0 guest and TDX L2
> partitioning guest:
> https://elixir.bootlin.com/linux/latest/source/arch/x86/hyperv/ivm.c#L575
> 
> [3] https://github.com/coconut-svsm/svsm
> 
> [4] https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> 
> 

