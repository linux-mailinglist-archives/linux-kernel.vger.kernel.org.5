Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24F87BA94F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjJESlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjJESls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:41:48 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF79F90
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KubZwKuIRpySnqJznDtRe9m/Pa8l1ei+WGqUmPScuVUo2WAuZKyUmdzu4OWiZoBY+OhErXreZbeTb8EH6nsDlcqoeFSwdYvBPPql1W8gF6UWlKlWeG6FlRQxoPdKDjgKFOf0Zsf9EztK5C6/KYq0dqxnx8IWOuIXD2aXGSBJ1khc91xHBg6eDVV5QpQtB/kN+18OMWrl3Yxrl+zAITJ5L8SM/6wnGwEaUCvbD1JMK5VOhg4MQQ1FRW8N1o8NuNSozS1j3jh4WnVyqDN6aLF7ZChtH1OqDlxFr2g8uKXsfrkAypyz/lk68LsLGeW4yrkhbyNuyCauHYP+MJAXeXijBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPIVgnCO3V+CzyzKmbYwoMHCsIkFLCJMdPPDjVpmWbE=;
 b=Q0nWQr8H9rBZ3tlzQh3TKynJZb5LjfbBZYgMXWD/y9v0XiewHu68iZO875NyVNym8krqZIHym7xKz8BX0MMZUlDsSvDO/ThB9/qVPH7joYQQD5LUXq0U3/3c4U0dzG6cUJCFU49mevP1pzsqQ8HuufSrzXOyKrjTR1/k1NP5s2JdEXe9z7ytHMXq1lNrGlfVZ33SW+6CAKO5NSOhv0HzS4PYfEyIypVdy+o2VhcgbbmX//NN3ToXEeGIjjhjAxqoPcNy36Hf3bH3JjzkSAsCeUdD+s4s5TDfSBRa3QlDyZe/NR6drHLJVs7I/K050mzpvDPe1Vo5P13H22tVvorEOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPIVgnCO3V+CzyzKmbYwoMHCsIkFLCJMdPPDjVpmWbE=;
 b=jksKzU/yk/eyE7Steu0myNNyHwWGyHixzXM8C8u1m4IHouc6TouU+zLQzILzncBPSEZc4A+/dP4lW4heOluZr2vd2d9HIIReOCwZyj34jJeySV1vnXxS1ZWXaHM5kl25GWeyt9P3sYr2Vgo6S4s55zmrPTX3iDw0i2RKaNQhj5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Thu, 5 Oct
 2023 18:41:41 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::6ac8:eb30:6faf:32b2]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::6ac8:eb30:6faf:32b2%5]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 18:41:41 +0000
Message-ID: <8d0e4e71-0614-618a-0f84-55eeb6d27a6d@amd.com>
Date:   Thu, 5 Oct 2023 13:41:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 10/13] x86/tdx: Convert shared memory back to private on
 kexec
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
From:   "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0077.namprd06.prod.outlook.com
 (2603:10b6:5:336::10) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 19df3610-54d5-4d4a-7640-08dbc5d2b782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4YVHsCJ2pyh3fg9DfYGC/h+MIDxIoXaFOWCIn7FOJvrnZsW/fZR3CjXRtz501FoTPuyjK22IQZEjst51Jb2SGmQZY0SnG7Kgh5VaRYKRuNze2gNtamdcPidADW5XqYExqTLSMDhEFHCo3vELQOXwu4AVa63lMB1wVLyW09nYXTPuqjLr7LvcPrizi0W/viq0ov2XQGaPOxGgVBoBaiaH3SIGMAKITewn1h/JXLowMs2DkDUVnge7uqzr1rq01NXj3bU450KZJmPrUt2VaRCJ5MkpzuG2/QDXAokNZ2NP+ZpYHYmGbb7EPWbAy4qXeIUyZ238TYhvQVGDF1CMlakOY4csFQ322BrxFQuAknde/2BvcGV4Don58nGhulKqvi1BhRM3hAtutoDj2NF98cow7znzXodVKukrpueqm9up1aMW/ZDdUUdJSv0bI7IyITiMX3CLnguWkF3X4rfRgZRUtCXm5xDaBtY5ZE2yOrzDnavHQPV2OTMIP6LdjIkl14HRtCJXm4DOw8wTXEm760WIdMZ/wDdSiOuFHowQQjqVbauXDWNh627rGoNdZuKYX/qwA8iGRCHEBLY8KOHEUgfzAUHFJAdJ52c0NVJVMPfBd/qqkqdoCoZTEcAq9xmkQu7kREi3hR42MVWD8ltvKcOEYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6486002)(6512007)(53546011)(2616005)(6506007)(478600001)(6666004)(83380400001)(26005)(2906002)(7416002)(316002)(5660300002)(66476007)(110136005)(66556008)(54906003)(4326008)(8676002)(8936002)(41300700001)(66946007)(36756003)(38100700002)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnVOOXUzMG8vWVYzcFMwQzR4V1YrOHVHZVlOdFlFUDJBTWordEtoTnBPekZY?=
 =?utf-8?B?SE9LclhOUXZOd1dUWXB0RTZxOXFMd2NUY2k2SXVseklBV0R2NjlSR2pKdkZH?=
 =?utf-8?B?K1ZWQWI1QUpYUzZGZ0Fzbk1CNFowNzZrbk1yajBmeGVZakIrTktjbXVFNFRH?=
 =?utf-8?B?emNFSFVKcEdzZVBrai8yS3Y2UWthZ0NuTmRpV0FIVlQ2dm5kK1d1bCtxamYr?=
 =?utf-8?B?L1hDaE1Kc2F3V1ZPejJsWDAwVXh0RTV3NUx2Z2R6VjN1czUwaUtvUVBSbU12?=
 =?utf-8?B?Nzltc2pIalc2YWdEMzBJSVZGNjVOdE1lN3NxaXFRZnJSRFFDdHlTcnF2Vk5W?=
 =?utf-8?B?dnlZa2d1MEdsdEVzUUJYa0RQcHFIUkpXQnZDYzBVMnRubnh4eHlHbTdSQzRT?=
 =?utf-8?B?UlVrTGJhYTBzeDhLeW03YjNCRHB5STBDcHpKbFJBRDFuY3pVSTg0TktXekJM?=
 =?utf-8?B?ZVlNOHlUdUd6M214YWsrZnkrc2tZMDhDWDdYTGRSNzljK29nMWp6aTFEUGVC?=
 =?utf-8?B?KytyeEUydjMweEdITlNmNU1GaVlUa1c2eVZzemZTL09WT2Zma1B6MW1sLzds?=
 =?utf-8?B?aHVGZlFvU1AzU3k1bkRTcW1lcms2aWFIR3lOb1VNODdtVk0xQ0FrYjZuZzFI?=
 =?utf-8?B?MkswSk50SHp3RDBkODFPT2JCRTVxT0ZTdE1vV2ltS2JlWXlsK0N5djJJMVY1?=
 =?utf-8?B?QmY2UkxvNFY5Q2NHdDZPNVBnMEtIRUZ0bVVNcEgxWjdVU2s4akM1K1c1Y292?=
 =?utf-8?B?djBuMDk4bVh5a3BBMGwwbXlLdlB0MnRZSUwxRTB5U3o2TVlWd3p2amRkZFd6?=
 =?utf-8?B?Mkw0WEVKcmJObGs1ZlE5QmNKRDIvVGFEMkQxUjRCbHZwWkY3UWZ5dUtSLzcy?=
 =?utf-8?B?M2gwRFBoN1hVVlh3S3AwckdRcXpQdU1RNFIvOHNXK2VWcFJPcUZIL3VRZGw5?=
 =?utf-8?B?L3JOTktFNGhSYWVzdkN5eDRNNjBYZVRMckRvaDgrQzAyTlRwNUZJMEptQXpu?=
 =?utf-8?B?blh0RGl3TDlVaDF6WDlUY1hWVm9DQUNEdVRxSEwzZFJ1UzFhWEJDY3RnVzlP?=
 =?utf-8?B?dnMxTjhOaVlKQXV1WGc2YmhtMFRSMXFLZytoQ01MaExRWFh5OHprb1FXL0Uw?=
 =?utf-8?B?bUpLaVMzUVFnZTNLSXBxVytRSHdnMGtIY3JwUFNQREhWeXpNUkFUQk9pRHlU?=
 =?utf-8?B?MTVDbE5UYmZtQnVyVFFYQ1N1Z2lYaUxDWWtVeDdIVzRlSFE5S3A2ckhjMVhl?=
 =?utf-8?B?bm1iSWgyUW5STFZwVXZxbmJmT3pDSXBrbWQvTWhBZUF5S1JhMHh0enRqeFlv?=
 =?utf-8?B?aGRidUw3bjA1MFI1aVRSVkZpRE1ZaDUzdml2UDdOSElBUUR5NUZMVVBKb2lB?=
 =?utf-8?B?Y0dERnZ3TUV5VVhUMGhHWmRGS09Dbi81SkpNRFZ5b2lublU5VGZQVzlEV3FV?=
 =?utf-8?B?dVhVQWZlZVIyc0Rha25UN1ZFSzd6QkFpV0VGRWVoRGtOVHplUkJZQlFaSlNV?=
 =?utf-8?B?dE1LMkhxa0UzUWlkSHhMUmFid09JNFl3TXhZdldreEhHQ2dYYnFPMVpQREhk?=
 =?utf-8?B?RE1SYkdXQWZZSTNXbWZkbFRkbHJmQnRSKzQwSkZ1MTE3V1QyeENpd0dRQjBU?=
 =?utf-8?B?Zit5TmF4UkRaWWZPUk5sWWxKK1NPTisrajdUa1lVT2ZhV3RuNnh0VlIyV3kz?=
 =?utf-8?B?c1B2TXBnUE9sTFQ5ajYvMHIwRU5ISlZXWi9TQzg1M3lYaXQ5VS9idUttcnZo?=
 =?utf-8?B?K3JsdkVtNTNPQlNyQ2I2cXV1VXhieGdGakJ0Wm10bENKQnNudjZERUVWdGZz?=
 =?utf-8?B?aWM2elJEaHVqbnpvK1BLK1ZWaUE1M2N1Z29oS0lDZjRFd1ZRMi9QTkRBK000?=
 =?utf-8?B?V0R0cmFHb2wxSTVIbHBFNmFaRk5sWUxrcVpIUS9YakFhcS9zYVorc0x0YzYw?=
 =?utf-8?B?c1oxRTdtRmh6Z01XV1VDWG5WT0xtNXdwS1lxakI0dGtDYmVMUGdjMFRFcVBF?=
 =?utf-8?B?R3QyUVhaYWlyODVVdTJMb1lkUWZUQXMyeEdCWGVKVTZHUlQ2eDA3MkNVdUlB?=
 =?utf-8?B?bXB1K0h2VGluUDVGMHRTZkFqU0R1cFgyQ0F5alpGSW1na1Y0YkF4SHZFc3JG?=
 =?utf-8?Q?arvSqDJ44mXZSVUjGTSo/DCPq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19df3610-54d5-4d4a-7640-08dbc5d2b782
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:41:41.6995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLXM/+VZJz5dB0ep3BOoi0w5VnsPXFibA3KUXlkQF+CdyXROiT0v9H53dLlKqWo2SFwdRIvel0kF+TKPp09BBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kirill,

On 10/5/2023 8:13 AM, Kirill A. Shutemov wrote:
> TDX guests allocate shared buffers to perform I/O. It is done by
> allocating pages normally from the buddy allocator and converting them
> to shared with set_memory_decrypted().
> 
> The target kernel has no idea what memory is converted this way. It only
> sees E820_TYPE_RAM.
> 
> Accessing shared memory via private mapping is fatal. It leads to
> unrecoverable TD exit.
> 
> On TD shutdown (also covers kexec), walk direct mapping and convert all
> shared memory back to private. It makes all RAM private again and target
> kernel may use it normally.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   arch/x86/Kconfig          |   1 +
>   arch/x86/coco/tdx/kexec.c |   0
>   arch/x86/coco/tdx/tdx.c   | 137 +++++++++++++++++++++++++++++++++++++-
>   3 files changed, 136 insertions(+), 2 deletions(-)
>   create mode 100644 arch/x86/coco/tdx/kexec.c
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7368d254d01f..b5acf9fb4c70 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -884,6 +884,7 @@ config INTEL_TDX_GUEST
>   	select X86_MEM_ENCRYPT
>   	select X86_MCE
>   	select UNACCEPTED_MEMORY
> +	select EMERGENCY_VIRT_CALLBACK
>   	help
>   	  Support running as a guest under Intel TDX.  Without this support,
>   	  the guest kernel can not boot or run under TDX.
> diff --git a/arch/x86/coco/tdx/kexec.c b/arch/x86/coco/tdx/kexec.c
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 56e152126f20..ac0745303983 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -6,6 +6,7 @@
>   
>   #include <linux/cpufeature.h>
>   #include <linux/debugfs.h>
> +#include <linux/delay.h>
>   #include <linux/export.h>
>   #include <linux/io.h>
>   #include <asm/coco.h>
> @@ -14,6 +15,8 @@
>   #include <asm/insn.h>
>   #include <asm/insn-eval.h>
>   #include <asm/pgtable.h>
> +#include <asm/reboot.h>
> +#include <asm/set_memory.h>
>   
>   /* MMIO direction */
>   #define EPT_READ	0
> @@ -40,6 +43,9 @@
>   
>   static atomic_long_t nr_shared;
>   
> +static atomic_t conversions_in_progress;
> +static bool conversion_allowed = true;
> +
>   static inline bool pte_decrypted(pte_t pte)
>   {
>   	return cc_mkdec(pte_val(pte)) == pte_val(pte);
> @@ -704,6 +710,14 @@ static bool tdx_tlb_flush_required(bool private)
>   
>   static bool tdx_cache_flush_required(void)
>   {
> +	/*
> +	 * Avoid issuing CLFLUSH on set_memory_decrypted() if conversions
> +	 * stopped. Otherwise it can race with unshare_all_memory() and trigger
> +	 * implicit conversion to shared.
> +	 */
> +	if (!conversion_allowed)
> +		return false;
> +
>   	/*
>   	 * AMD SME/SEV can avoid cache flushing if HW enforces cache coherence.
>   	 * TDX doesn't have such capability.
> @@ -787,12 +801,25 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
>   static int tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
>   					 bool enc)
>   {
> +	atomic_inc(&conversions_in_progress);
> +
> +	/*
> +	 * Check after bumping conversions_in_progress to serialize
> +	 * against tdx_shutdown().
> +	 */
> +	if (!conversion_allowed) {
> +		atomic_dec(&conversions_in_progress);
> +		return -EBUSY;
> +	}
> +
>   	/*
>   	 * Only handle shared->private conversion here.
>   	 * See the comment in tdx_early_init().
>   	 */
> -	if (enc && !tdx_enc_status_changed(vaddr, numpages, enc))
> +	if (enc && !tdx_enc_status_changed(vaddr, numpages, enc)) {
> +		atomic_dec(&conversions_in_progress);
>   		return -EIO;
> +	}
>   
>   	return 0;
>   }
> @@ -804,17 +831,115 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
>   	 * Only handle private->shared conversion here.
>   	 * See the comment in tdx_early_init().
>   	 */
> -	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
> +	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc)) {
> +		atomic_dec(&conversions_in_progress);
>   		return -EIO;
> +	}
>   
>   	if (enc)
>   		atomic_long_sub(numpages, &nr_shared);
>   	else
>   		atomic_long_add(numpages, &nr_shared);
>   
> +	atomic_dec(&conversions_in_progress);
> +
>   	return 0;
>   }
>   
> +static void unshare_all_memory(bool unmap)
> +{
> +	unsigned long addr, end;
> +	long found = 0, shared;
> +
> +	/*
> +	 * Walk direct mapping and convert all shared memory back to private,
> +	 */
> +
> +	addr = PAGE_OFFSET;
> +	end  = PAGE_OFFSET + get_max_mapped();
> +
> +	while (addr < end) {
> +		unsigned long size;
> +		unsigned int level;
> +		pte_t *pte;
> +
> +		pte = lookup_address(addr, &level);

IIRC, you were earlier walking the direct mapping using 
walk_page_range_novma(), any particular reason to use lookup_address() 
instead ?

> +		size = page_level_size(level);
> +
> +		if (pte && pte_decrypted(*pte)) {

Additionally need to add check for pte_none() here to handle physical 
memory holes in direct mapping.

> +			int pages = size / PAGE_SIZE;
> +
> +			/*
> +			 * Touching memory with shared bit set triggers implicit
> +			 * conversion to shared.
> +			 *
> +			 * Make sure nobody touches the shared range from
> +			 * now on.
> +			 *
> +			 * Bypass unmapping for crash scenario. Unmapping
> +			 * requires sleepable context, but in crash case kernel
> +			 * hits the code path with interrupts disabled.

In case of SNP we will need to temporarily enable interrupts during this 
unsharing as we invoke set_memory_encrypted() which then hits a BUG_ON() 
in cpa_flush() if interrupts are disabled.

Thanks,
Ashish

> +			 * It shouldn't be a problem as all secondary CPUs are
> +			 * down and kernel runs with interrupts disabled, so
> +			 * there is no room for race.
> +			 */
> +			if (unmap)
> +				set_memory_np(addr, pages);
> +
> +			if (!tdx_enc_status_changed(addr, pages, true)) {
> +				pr_err("Failed to unshare range %#lx-%#lx\n",
> +				       addr, addr + size);
> +			}
> +
> +			found += pages;
> +		}
> +
> +		addr += size;
> +	}
> +
> +	shared = atomic_long_read(&nr_shared);
> +	if (shared != found) {
> +		pr_err("shared page accounting is off\n");
> +		pr_err("nr_shared = %ld, nr_found = %ld\n", shared, found);
> +	}
> +}
> +
> +static void tdx_shutdown(void)
> +{
> +	unsigned long timeout;
> +
> +	/*
> +	 * Stop new private<->shared conversions and wait for in-flight
> +	 * conversions to complete.
> +	 *
> +	 * Do not wait more than 30 seconds.
> +	 */
> +	timeout = 30 * USEC_PER_SEC;
> +	conversion_allowed = false;
> +	while (atomic_read(&conversions_in_progress) && timeout--)
> +		udelay(1);
> +
> +	if (!timeout)
> +		pr_warn("Failed to finish shared<->private conversions\n");
> +
> +	unshare_all_memory(true);
> +
> +	native_machine_shutdown();
> +}
> +
> +static void tdx_crash_shutdown(void)
> +{
> +	/*
> +	 * Crash can race with private<->shared conversion.
> +	 *
> +	 * There's no clean way out: report and proceed.
> +	 */
> +	if (atomic_read(&conversions_in_progress))
> +		pr_warn("Failed to finish shared<->private conversions\n");
> +
> +	unshare_all_memory(false);
> +}
> +
>   void __init tdx_early_init(void)
>   {
>   	struct tdx_module_args args = {
> @@ -882,6 +1007,14 @@ void __init tdx_early_init(void)
>   	 */
>   	x86_cpuinit.parallel_bringup = false;
>   
> +	machine_ops.shutdown = tdx_shutdown;
> +
> +	/*
> +	 * KVM overrides machine_ops.crash_shutdown, use emergency
> +	 * virt callback instead.
> +	 */
> +	cpu_emergency_register_virt_callback(tdx_crash_shutdown);
> +
>   	pr_info("Guest detected\n");
>   }
>   
> 
