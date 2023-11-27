Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDC07FAD1E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbjK0WNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjK0WMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:12:31 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B692D7F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:10:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhsNjGRYEAjc+I94pz140+jslhliZue0KzFfuH6xDpW8u4MtPzxF2gittT5Y0LdwdLEhL0MKryErC8mhabRG94iRdual+j42wqhdA4qAxSAf46qJOGHEROtBAMJKsPkPSZ55RXKLwuM+Y2T3DxGYSwKjXz1U06KwVn6QoMIKEUHo4EjLYJFLfYx1xediHMS1kwvTTjqhiH9rk57vjBcKFYsjvPRLNWo7slJ9Bqwk+oNkGAPrIMKIoDfzxnWx1MglqGnFtmMRRR7sQ/RMrgZfyoe479kdLzloasmmMygWw8UiOGklaL32mpfaoHc56mxMiOC0KEyLY97RhuwDsTyVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bsr2an4yewF/AkVhHydkbFTAVLwC13Y+6pIjwp7WsCc=;
 b=Ow7OMyvClE3lreReWNuY6G8el1XONLUMSE1EEFH+Ym97myfKSDfP1tZ7l2pszr0vxdt4iu/OVc//XrMJN3nnAMbv+hRwW1vjw+YwLM8arHEnxohriu+kmWK7m1nLYqnHBLwbTkiVnLcN63am06+1uHoJGsoLXo6k5UBHHTO2RpfG4RPJqdBENVTHe+LT3JQol8x2x5fYYAbU/FSuKU5vpTsuFRFEqJ0QNeukCupjETDIjVZCvmPDhUUKT/+0BLcaqM7WHJufRj2qDra3b+xoTwJiyUVp4HjdqVmyr2JeHIDOZG5hIDhtdgXVRiD3g4NldMosPXPXeoIeFlKXJRTT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bsr2an4yewF/AkVhHydkbFTAVLwC13Y+6pIjwp7WsCc=;
 b=5HKRd1KAUVHaLJ7756QdqIPx5s8PhEIUzwuNDwPmFYyBVtPMTbf9h4Uba2P5HxhqJda8hUHY0ovwVbTbb+UBLt9XzdxhYlMRPOLp4hX3JhSfRFS8A6dLTUorGRBdoTGiua83qxXP25sqhFwpXDPGEA/Pti3zEY/A2MTBPdKS82Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 22:10:36 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 22:10:36 +0000
Message-ID: <4219d88f-5c09-408f-b72d-1685367072f0@amd.com>
Date:   Mon, 27 Nov 2023 16:10:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Update ghcb_version only once
To:     Ashwin Dayanand Kamat <kashwindayan@vmware.com>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jroedel@suse.de, brijesh.singh@amd.com, ganb@vmware.com,
        tkundu@vmware.com, vsirnapalli@vmware.com, akaher@vmware.com,
        amakhalov@vmware.com
References: <1699252361-1286-1-git-send-email-kashwindayan@vmware.com>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 1NhFSLKvfA==
In-Reply-To: <1699252361-1286-1-git-send-email-kashwindayan@vmware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:806:f3::7) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM6PR12MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: 0449f29d-588b-463a-b438-08dbef95aee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pP62Vv2ZfvANuTm40Q8S0Bhh8fjPzE/6KTa8L9yq7fiiOUezI2pbeHSeyNgggUurmze56ppPBBc4jzm39d0YyaiTim+7NgUum6kqYp6/PptK35NZHpOQq6YYIMUl8cpOhvWSBEJsu+5cpDzdH7aB3yYXAHu8MIaNQ3t5XtJBGbyGbM/vXadFKyCK5FH0ixrsy5SWd3mPFsFWW/mEa3nHkxhLnPPkPvmvBBW2cH3WwZUjcG+6ohqxTxi2uc8ZoX9Ubv/jkaMOUcfNtBTwXgizbNghgxfdPv7K257nbiS6jM5OhSJEDnM8imspIjvOu1aAwPbjOAAWMofymDcWZn9ppppHsf7oYk5S2UhBAv2ioQ88wMoWfHCX3nTHu6ngR8leERVzE09+4w260MIoVS8jri+/tlBkacD1fhKibB80D5Ejpt7mw3zQt2zBbhWArl+0ZjRjxnIxyoaknFOnPPKrCrCgz1E6Dim5zvSP65L8YbLY4vZ9OHuNAioBEMDVUpGwhLNlFFo6DHu/4+tUMDId3sT5ZDGXJpqcCAhHbyaB2BR2gTEz4cLQSN/zra7eVwmC33YsJ+eYbFoYBKvVPt21oQK6qtDz/YYS9vcbuGlmnYBk6E+3/9afuiSgnkQOrZ9M4Ygp27bopAr/SkqgHaGLSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38100700002)(66899024)(36756003)(86362001)(31696002)(53546011)(6512007)(6486002)(6506007)(478600001)(31686004)(7416002)(4326008)(8936002)(8676002)(5660300002)(66476007)(15650500001)(66556008)(316002)(66946007)(41300700001)(2906002)(26005)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlFJVHZWcHY1Rm9MdUlGNGxFUlFONWtpQXBNRTlNcGNudVZUZ0c4RVc0V3hN?=
 =?utf-8?B?SUYzMzY0NzhlbVcyLzJ0K0ZEU2FKUTJ5amRrcXUyTnVzOXpoZHdtTGxTbkFi?=
 =?utf-8?B?a1gxcFdwbnV5RUgzL0tXVzQzTEUrWmExMFNaSzJERnUyb2pVbGxWQlZWZXN1?=
 =?utf-8?B?SVY5UVpxZ0VwWkFTVnJzc3MyQVBSZ3JCd0lrVEJZbTBIWk5vRnFpSG5HWGJp?=
 =?utf-8?B?NEVBVndCd3g4eUNMU29UZHErL3Z2bDhnNlpkRU5LRHdPWTA2TWc2cnNlcE1z?=
 =?utf-8?B?OWlaMGZCcTBDTjlTMnJVZElGZTRSY2hTcU9ZU2pDVnZlTi9xc1A3Q3dHR0ha?=
 =?utf-8?B?R3dyUGR2ZU82ZkxyeFBRSXU4SE94T3FiaU5hOS9zdHhkdWZ6RE50SExXNGxO?=
 =?utf-8?B?TEYyRVhVQ2gxR1AweWZRYU5oSkdGczVwZG5XRXRsSVF6Y1UwQzFURG5aTnRs?=
 =?utf-8?B?cEM3bklmTW9qVWppRzk0bmVaQ1FlUUtzd0drYWpNQ0t0N3ZtT29pMkx5bkwv?=
 =?utf-8?B?US94UE1tTk1FUDVScE9NSjBaVjBpZUJVNi9qbUtJd2lkWitlbmpDSk5xY2oz?=
 =?utf-8?B?a0ZhWlRCdnhMOCtTb1hlNmRsQVc3bXM4eU9lWHZsait5UndVaWFkYkhoUHln?=
 =?utf-8?B?bG1QYUYrUjBwem4zUDZkVFRIdm1McU1LRFBvSGgzeUNHSk1LUHlIM3V2MWJx?=
 =?utf-8?B?K2s3MnZhcWV4em1GbWYyTE1DQmh2QUlkcjdBTTgwSTBJcTFLQmkyd0xJenZz?=
 =?utf-8?B?NDBoSkNNMEg0SEZiQ09vVElqUDgzUDY5WWZMOEg3UkU5V2J3T3V1K1EzUFpk?=
 =?utf-8?B?c3lsL09lNXlkaGwxeVNWbnNtZ1dHZytYYVBsMCtaTjhMRFpwRFJDNkNzQzhi?=
 =?utf-8?B?L1BIV3VNL09uendhM0dtMzE5dnV2V3dmUkNlcFcyQ1E0K0FDTldCb1ZGckRk?=
 =?utf-8?B?Vm1UQWJSUVBxc2ZkWDJzR0R5dDhkTVBBbXFBTUM3dU00WEhJKy9ueWN3QWdt?=
 =?utf-8?B?R0VWRXovS1FFd3RoSjQ2NVlmQTl1UWF6VnJiRk5adDQ1SFkzM2dzdXRTcGFS?=
 =?utf-8?B?UTBvSDVFbWgzQlNZa2JDVklUYXI4R3FwWTcrT3hHejhpeHRjSG1uSTNHMk1D?=
 =?utf-8?B?ejROYmZrUDMybEtkT2xzT09pWmFCaENybmxTcjZGaVllNXlYWWNGYjAvMWZ0?=
 =?utf-8?B?ejZQRTd5V2lNSE5XUHpCWWl6UytCcXAyU0taUGdxMEpWRlJwcHZvcHB0VlE1?=
 =?utf-8?B?S1lxeXBteWtSRUg5cnhrNDVzWUxHVW1DWStocFp1TlJkNWFXTW54dCs5Mk5w?=
 =?utf-8?B?NzVFelNVQzF3a01aNjV5SGxQRm5yK2tWSURTNEI1WjdUNWZsUDRHN3ptOWI3?=
 =?utf-8?B?ek5VaElGcHpBQ0dZMHNrRThtWUYxa3RpUVNUYjBwdkMzNVJCSXRUb1QwS2kv?=
 =?utf-8?B?bkRpVHhqVlEya05seGRIU2hrVE1aaHNhcUZXRnVlenN0RkNPcWl3clgzak5o?=
 =?utf-8?B?a2Q5K2Q3TGcyZk1za2NBWWlrQjFaY2RQc3Fyd2tKV2NxSExyeG9IcnpXZ3dR?=
 =?utf-8?B?ekhKK2xaTElXUjJFSGZ0TnhGem9lVHJERzI1STg0NU9IdFJ5dFFtcnVNdmNj?=
 =?utf-8?B?QURkazFWOUtpM3NQdExUVW50ellYdE9EQnBWTlVkMEg4akplbjg0UCt5NjVz?=
 =?utf-8?B?VmRvbVB0dVZDc2xZS1hzVGhsL0RKMTdWRitjYTYwSjNvcWJ1SjVLSk1jc093?=
 =?utf-8?B?dlFaODkzMlgrdGJXR2oxZ3AxbUptMTQ0RnVMaUJxb0UvUEFGOEpOZE83RE5Y?=
 =?utf-8?B?SzRYL08zcVdUUkNTcElLZGtYd0RnSU1ISTFsaXZLM2NGanEvOUFRc25lSk1N?=
 =?utf-8?B?L0VvRDhUQjgzMXM1VkxSOG0vRWtrTUluaVZpcmh4SFEvV1VGSTl5TkEreVRW?=
 =?utf-8?B?STF1TThuQ1dJZEprUmhaTkVVb1BMTkFvZWhDK2s4OVhKaXFmN29pUGp4elZL?=
 =?utf-8?B?MDJGdDJ3ZmRsVlVrMU5zK1h6WGxvcnlPR3llbzlOTkhOdERnKzV1MTZ0TjM1?=
 =?utf-8?B?dTdPTDU5NndWaGxHeFFNSFAxVTZWZEVlUEh0SHlHWTZFL0NXNjlkRE5Cc3gz?=
 =?utf-8?Q?M/knN4geEa5jfB/OzPl4LXaJk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0449f29d-588b-463a-b438-08dbef95aee4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 22:10:36.8687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqRmeH/j+bmqrnAJsxEOYAOPdFc2TfVaRBkCX0MMcDI/iNG6c4tXRQTM2c9/42qtAXPCwWXR9Pi0RNOt/gKsLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 00:32, Ashwin Dayanand Kamat wrote:
> kernel crash was observed because of page fault, while running
> cpuhotplug ltp testcases on SEV-ES enabled systems. The crash was
> observed during hotplug after the CPU was offlined and the process
> was migrated to different cpu. setup_ghcb() is called again which
> tries to update ghcb_version in sev_es_negotiate_protocol(). Ideally this
> is a read_only variable which is initialised during booting.
> This results in pagefault.
> 
>  From logs,
> [  256.447466] BUG: unable to handle page fault for address: ffffffffba556e70
> [  256.447476] #PF: supervisor write access in kernel mode
> [  256.447478] #PF: error_code(0x0003) - permissions violation
> [  256.447479] PGD 8000667c0f067 P4D 8000667c0f067 PUD 8000667c10063 PMD 80080006674001e1
> [  256.447483] Oops: 0003 [#1] PREEMPT SMP NOPTI
> [  256.447487] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.1.45-8.ph5 #1-photon
> .
> .
> .
> .
> .
> [  256.447511] CR2: ffffffffba556e70 CR3: 0008000667c0a004 CR4: 0000000000770ee0
> [  256.447514] PKRU: 55555554
> [  256.447515] Call Trace:
> [  256.447516]  <TASK>
> [  256.447519]  ? __die_body.cold+0x1a/0x1f
> [  256.447526]  ? __die+0x2a/0x35
> [  256.447528]  ? page_fault_oops+0x10c/0x270
> [  256.447531]  ? setup_ghcb+0x71/0x100
> [  256.447533]  ? __x86_return_thunk+0x5/0x6
> [  256.447537]  ? search_exception_tables+0x60/0x70
> [  256.447541]  ? __x86_return_thunk+0x5/0x6
> [  256.447543]  ? fixup_exception+0x27/0x320
> [  256.447546]  ? kernelmode_fixup_or_oops+0xa2/0x120
> [  256.447549]  ? __bad_area_nosemaphore+0x16a/0x1b0
> [  256.447551]  ? kernel_exc_vmm_communication+0x60/0xb0
> [  256.447556]  ? bad_area_nosemaphore+0x16/0x20
> [  256.447558]  ? do_kern_addr_fault+0x7a/0x90
> [  256.447560]  ? exc_page_fault+0xbd/0x160
> [  256.447563]  ? asm_exc_page_fault+0x27/0x30
> [  256.447570]  ? setup_ghcb+0x71/0x100
> [  256.447572]  ? setup_ghcb+0xe/0x100
> [  256.447574]  cpu_init_exception_handling+0x1b9/0x1f0
> 
> Fix is to avoid updating the variable after it has been initialised during booting.

The call to sev_es_negotiate_protocol() could be moved down to after the 
initial_vc_handler if-check in setup_ghcb(). That would then put the call 
to sev_es_negotiate_protocol() only in the BSP boot phase (and it only 
needs be done once). Does doing that prevent the #PF for you?

> 
> Fixes: 95d33bfaa3e1 ("x86/sev: Register GHCB memory when SEV-SNP is active")
> Signed-off-by: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
> Co-developed-by: Bo Gan <ganb@vmware.com>

This tag needs to be moved above your Signed-off-by: and it needs a 
Signed-off-by: for the co-developer.

Thanks,
Tom

> ---
>   arch/x86/kernel/sev-shared.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index ccb0915e84e1..a447908f2b4d 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -144,6 +144,9 @@ static bool sev_es_negotiate_protocol(void)
>   {
>   	u64 val;
>   
> +	if (ghcb_version)
> +		return true;
> +
>   	/* Do the GHCB protocol version negotiation */
>   	sev_es_wr_ghcb_msr(GHCB_MSR_SEV_INFO_REQ);
>   	VMGEXIT();
