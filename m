Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B9D8039A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344461AbjLDQGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjLDQGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:06:41 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39C495
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:06:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BukLNpoy5YW8v02ZVfDcK7ukvxuZ+UQtsN/gOwWrgzTeYfTLlT9cpFe2DZzSk+3INpimCXF0ReS+L+w2NsR40VJa1bNgYdNXrwz6ZP9MVmcfajZ0qon5kL65fyb5basuZt3kDVHQILZFvi3h10+bCLyLF29tLaikmFqM+vX3DPwB8FnGZ3W3A8FMNxa+T7xZEGXmEJHuzy8L6Vx7wg3ONUAs6Y/KHIwSmCn/Ugwin8a1eRQ0+oqC4falFeSXHd+Op2CQSh6m0+2NmSu1r+5bKcki184GbUz3NLliIzyUpHRugEJ1miBkDRNc0Oh1Du2+q7vuh2lLGvtSqxWq9mivDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kE+fAeFfgP313C98/sGElbuUuefvw4HvqekCUqpyZc=;
 b=QZEUu3ObUwoutjfMbPa8HX91/jfQ8Fsczyl5hsbLMF7Yy3XGdKju1cZHF2gQwSDxpdvqjYUJAP4ypCTAXz9aBDD4NYo/DOcMMdiB3ddJsDKG9alrM3I/q4icLLl20kQ6Vzaj7QCiI6ddHEsTaMgSRnW8PO15KojlwfTdqxHEc+pmYraJZ/K1xY4EoCq7+Fvcy1jSpkXz1rD3FszaFS85+owdMNVwFOk9XawrJLYdx3Aqy3KZ8SRJgvLDzYhb92D6hyrDCI03SLCniV8ZHihbFmkJSb3zh9KhrfdY2LMf3TUgEkTyCUk/a4x3gcVveotcKfG7vq1NbWnQfdUVTztflA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kE+fAeFfgP313C98/sGElbuUuefvw4HvqekCUqpyZc=;
 b=sq2k5+/1pFT/KIkf4Ril/aLqptF97fMdEF0iZwPaLR1kIHEvtIrsLe3P9TsRwF0AhxDJppgfm/OlRfH3kDTeOl0NzV0/cthSaJXxN7Jr6zUiM2nH3E2p/vfsBYTguKEBcXfVyMyT3extUEK5WdL3BXKt44RRLemGTZ/zWCf8at4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 16:06:44 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 16:06:44 +0000
Message-ID: <1726d92e-2574-40dc-8991-eed0184f957e@amd.com>
Date:   Mon, 4 Dec 2023 10:06:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Do the C-bit verification only on the BSP
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, LKML <linux-kernel@vger.kernel.org>
References: <20231130132601.10317-1-bp@alien8.de>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 1NhFSLKvfA==
In-Reply-To: <20231130132601.10317-1-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:806:122::15) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH7PR12MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1b9c77-35ee-453b-038e-08dbf4e302b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ev120Y7u0N7i9tk1yWvQFgjI+orXGRtyEL+IxCBmuBT2rcvfuUJtCBuniL8fmMa3J4hFY618YImQnk7QWy5kdMMj8WjIbgDGyOFnUA9a6E/Lj2qNJRar2NuRCB8JN57ACzrcwcBRMvzWPrJPYGEFqxBjssHpdS05YHzIz1NS2UGDBcXW9NTnh64ujrs5+iMOmmghaqYiu+Bg/Bn2iSb2ahjVKghkEXMzMK7yRAkJNl2NeuOpcrWvqpnO62GjyKMjU+haj+4VuxB1l/Q32kgQQJyrDZ4dMYv8mt0k7Z9vqfni508ze7vG0+AXxJd8pBuXHfAoGFarKdSgt/QcUfdJvzjel2QLiZC+cMENdJC/lgDsihld+r8kJ9JPc77Tt5i/5kzi68SKZ7D1JNWVvIzxO7QD+FbQBi8/deaDTzCC1Yu1UAaLsVpM4WyFdf8IpC/vHHxER8rUC7Vo9hTpRns1/vJicSLKtv62G3W7b5TEqy8Fa9hoSINUCbghfrPHt+DYt8B+mOPLhpFUKMHfK25FPEw5jf3cY5a/+LZSnipVxHC8IPSpyxGquuijisxmtcYWzbf8mM7FK6MLqm7dt4ibDJPs6aAB0gSHpsMXlqgD2l0kASo9h3zRaJxKrVsaOpnpObHwrFU0EEdri9ILldwlSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31696002)(5660300002)(86362001)(4326008)(8676002)(8936002)(2906002)(15650500001)(41300700001)(36756003)(6512007)(6506007)(53546011)(2616005)(83380400001)(6486002)(478600001)(26005)(38100700002)(31686004)(110136005)(316002)(54906003)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGtNUEhnRHM2YUZpNVBBNWtwRFVUaldsM1BCaGozMDFJUFlkNExkRHZSUndF?=
 =?utf-8?B?My9OSkI0WnN1bitjanJGZ3JkeCs4Q1BCdGg1Vk4xUmppSWVRL3dCd3k1T2Uz?=
 =?utf-8?B?SThIdmc2RVhOREtTNnU3S0FBdXZWdHVrbTVnOXlGYkdaNUc1c2xZQ0FwaE5N?=
 =?utf-8?B?Y3ZKdjRxVlFvWmRmVjg2SDdGOHIwUGFPWDZSbVBlQVlJdzlVMUFxcVA4UGV0?=
 =?utf-8?B?UUJZcTdOMFBnOVBZNW51QjFHVlBYdDJBSEFUTGF6NkZJS2o3dE5pYVR1L0o0?=
 =?utf-8?B?T1FRMVdOY3JXOEQvWVl6UHFqaTBva1huenNKZHJVeks4N21IdlA5cmRxSGpN?=
 =?utf-8?B?VllZTllqSXdBVGwwaHZydDZWS1lNamw5NmZqOWVwVTlSWTNzZmNmUzNDSFZ3?=
 =?utf-8?B?TlIrdEpTMWRRTUlLeFRURThBSDJjYzloZ3BqTlkwemE3aXhEUzFwZS9ON1Ir?=
 =?utf-8?B?UWk1bUhHL0dnK2JrTHpjbjVScG1md1RhbFNVUVB1Z2RZbFJtRTlRQTVQUm4v?=
 =?utf-8?B?L1FtTVc3K0tkaEZuZTFOZE5Seis5Q3RuWU5WVWcxdS93VWVhanV6d2VKN2Jx?=
 =?utf-8?B?ZkFTS0ZveXhET0htc0hTRE1lMlFFcWNYcC9MVVVueml4ZFlXT1RHVVYzdm81?=
 =?utf-8?B?Y2NjdSs1TTJxRWhXUFZpcmJzLzY3azBsM0VpampNaGZQbnd1VnpsNFZUK0pX?=
 =?utf-8?B?K1k3RktLRUVMMUtSSjFsN0thNkNQY1JUcmtpaHdkSW40TWRZR0s2SmRaMlIw?=
 =?utf-8?B?MkYvRlVPQmFUMGRZZ3hqOXRiMjRjMzZYWnV0Ymk0Wldpd1UzUEJVVnJLdStq?=
 =?utf-8?B?TENlVGR3bWFzTnVWbnMvZmlkcFJHSUxVcmRtWVZGc0NVSkVMSnY2MWFWVUNu?=
 =?utf-8?B?d2dXdkxvVjBuUGEwTzRkYitqTEtWc0pQVUxidDFhVmsrQzZXbGg4VVdCcTlK?=
 =?utf-8?B?TkNCa251by9EYjRkUWtKK05nS1VTR1diaWptMlE1VjBmK2pacnY5RkVBbHBS?=
 =?utf-8?B?RnUzRE9oL0FxM2p3V2w4UE1DdE5QTU5FS1h5dmF0cmlWMjFXTVNydDlkZkFy?=
 =?utf-8?B?aHdWMXJTS24rYVo1c2xKdCtlVGpMdGJ1YUlaalJBVm5zd0c3bmxvVHhtT2RR?=
 =?utf-8?B?bGVTaWdQeUp0amxGWStsTjg5d1JJY2hiaVRueCthTHZXUXluKzdoU1YycFRs?=
 =?utf-8?B?NERONWlxM01JajNBcUl2UkhJekx5aWdjQjVLODAyK2o2VjNqbWdtS1NkNHZr?=
 =?utf-8?B?ZGR2eUtJRTlyWU9vOWRiUlMwRTRVQ1pNdDhsUnFUMy9EOGlFVHJBUmYwK0xp?=
 =?utf-8?B?dVJnalBvMWF4aWgwOExtVms0QWFDS3VSbnhZUXNKUVY3bDBLdUw4dms0eU9G?=
 =?utf-8?B?OG10OHkzakZ3WUdwTnJxSWQ2d3dXU2lvajgrRUduc25LejMyUE9WL2d0N09R?=
 =?utf-8?B?ekhybmNPSW1wRk5SOHFlUkd1OWp6ejBvNklQSjhyOXVHZmZUS0NrOTcxbHdl?=
 =?utf-8?B?TVZiYU9rOU95UVVhS0VaMjRrWjR1cDJyRkV5YmZ2M0hzcWtHNHEzZExQSUxw?=
 =?utf-8?B?Q296TlZHdnBtSVpFUzVlcitsWTVjQjhNdENDWVFmUzBJOW53RXlYN0J5Wm5h?=
 =?utf-8?B?R2V6L3ZibXhRK3IrMHl0aTA5aFVXaFk0eDFCSldicFhWbzRiTVpkWmx3d2lr?=
 =?utf-8?B?OGNyZHRaakQ2dFYwalNFUmFSRVlpMUtSbjFEMVVpdkNoZjZ3SDFxSlpwdHAz?=
 =?utf-8?B?Z2pQMEljQnhjVHNDb2hZeWRVSkF6aVkrNDVsam4yUE1rT1hYcEVZcEpjL0FM?=
 =?utf-8?B?MUVmQXZZb3phY1ZUT2ZoTWdqWXczZXZ5S3B2c2RaYjRncElBY0s3TytqZjZ1?=
 =?utf-8?B?YU5jZ2tDaENMYWs2bERROFF3VjloK05sVGFtMXYzbDNTcHZzTlozK1kyc1Vz?=
 =?utf-8?B?Yy85eGVoem5hR0xuNGExZEZNQVNWOHF1YWpuTmhubFZnMkxJeDdMYnNFYTc5?=
 =?utf-8?B?UW81aXBRcXdOZFVMTlNuYzVPLzZrVENiSWp1dDBHU3lEZUlrMjR2eHRyeHBy?=
 =?utf-8?B?SzR2c1lCSUFnZTZ1ejlkK1hZSWsyTldLT2VSdTUyNDZ6Ui9OUitLZkxOWVdi?=
 =?utf-8?Q?mkcTC7AWnstp3S00jeBrNwxjq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1b9c77-35ee-453b-038e-08dbf4e302b1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:06:44.7742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ELBK9GlrDAlZm64vw+XgglExZo9Svkq3VHWf3npkulnPM34e8+1uBoaN60f7O78odOIHBju7enkXrj0J5mjFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/23 07:26, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> There's no need to do it on every AP.
> 
> The C-bit value read on the BSP and also verified there, is used
> everywhere from now on.
> 
> There should be no functional changes resulting from this patch - just
> a bit faster booting APs.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

One minor question below, but otherwise

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   arch/x86/kernel/head_64.S | 31 ++++++++++++++++++++++---------
>   1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 3dcabbc49149..af40d8eb4dca 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -114,6 +114,28 @@ SYM_CODE_START_NOALIGN(startup_64)
>   
>   	/* Form the CR3 value being sure to include the CR3 modifier */
>   	addq	$(early_top_pgt - __START_KERNEL_map), %rax
> +
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	mov	%rax, %rdi
> +	mov	%rax, %r14
> +
> +	addq	phys_base(%rip), %rdi
> +
> +	/*
> +	 * For SEV guests: Verify that the C-bit is correct. A malicious
> +	 * hypervisor could lie about the C-bit position to perform a ROP
> +	 * attack on the guest by writing to the unencrypted stack and wait for
> +	 * the next RET instruction.
> +	 */
> +	call	sev_verify_cbit
> +
> +	/*
> +	 * Restore CR3 value without the phys_base which will be added
> +	 * below, before writing %cr3.
> +	 */
> +	 mov	%r14, %rax

You're ignoring RAX now on return, so you can probably just make 
sev_verify_cbit() a void function now. You would still need to save RAX 
because of the calling convention, though, so it doesn't make this code 
any cleaner (other than the comment could then just say restore CR3 
value). You're call, I'm good either way.

Thanks,
Tom

> +#endif
> +
>   	jmp 1f
>   SYM_CODE_END(startup_64)
>   
> @@ -192,15 +214,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>   	/* Setup early boot stage 4-/5-level pagetables. */
>   	addq	phys_base(%rip), %rax
>   
> -	/*
> -	 * For SEV guests: Verify that the C-bit is correct. A malicious
> -	 * hypervisor could lie about the C-bit position to perform a ROP
> -	 * attack on the guest by writing to the unencrypted stack and wait for
> -	 * the next RET instruction.
> -	 */
> -	movq	%rax, %rdi
> -	call	sev_verify_cbit
> -
>   	/*
>   	 * Switch to new page-table
>   	 *
