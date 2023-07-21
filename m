Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA85E75C78E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjGUNT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjGUNTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:19:25 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABB335B1;
        Fri, 21 Jul 2023 06:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkgqfPsSG/kMzWyyQyCcdW1jvt5gZ0S4iN7S1a8n4KlmAexf8PZ/qp1Mxk0ntOy4atSOBsxOhO+dsAX1jZYkiyHvGMICOheYpzLVqJEovC6GhRKaRLFLrXOZsZjSBx6nCHz9EYYdy1dwqoDwL5z0gzFqoaDzy9ab93Cj7EIb6EGIF8QFKA+Qjk3psAdc/IiTNO0ml+lAqohQZc6D4JCiWfOEPlABFkEQC4WNFn6klqujwVV9G7Xd4gFBAZDccxgwjZmSZerTLCL68XFVuQkG6nhIwhcvbSMWh+tsp0ocCeJCp224ai4bPsfGoa1w3vi+cR+XJobXcEvj68T/LmrgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QysEKlw668b5p85Fumbw63VMwEgP691djzaMPIHITPU=;
 b=arm7t7bP23QYvkEK9Ch1zp3nFl6s0f+WG8eF9mJm/YruPbRBkyl4K2yL4JoU6aNCqPfj3N6cj791fl0QkoTtr99oqQR1HsX9Aft+KLwFpPZKtPcCxDn0WWZZd9vQH/F3WAcwkdRqnxtSACBO9CS4HbuEKkevwNghXmvpnHJkU6/QAjbXjg1WMCVCe2jaJpmp7NvRBn1Ds5WpQVYF76BzooM0dPctBsT/q1dcLnV9OpqrCCWrWW3aF3dI/YhYgmKOSrM8r/xQw1ZRgfUFfpPfNbhk7XjFbmBfsnHKggcoxBTBPCVIhNK8gbegCJR9nUz6VWLIEHFrNN0iIffxwKby8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QysEKlw668b5p85Fumbw63VMwEgP691djzaMPIHITPU=;
 b=GAXLyxvFaKI+RgffDIELISF1jsAQoB583nZcTTGeMGwR+oI6jsBMKzQgceI3gaznPRk5G8NDHDKDH+ngqnzQZPUZ72Q5gU3E8boEqe6dFqtipp0UUA9tJfQpcH/Soxv0cJh/XBj+w2AF9Z74WRjvYHj9u8n4PG7W3P3M1LKsFSvum/XnujdFLNmpo0OI8Qz9DtvOkYts0TdDUAaNM0ZoO0yrGacJEkNGUdGHnU1xPGX5M9O+DZYFSvT3UV++m5veWpUHlXbGR/iSwaQ6dXa0IEdSgVCVYubK3eLC6Ew/XWfaORTEDipJ/JJMynZLVDZKpxKANdVdhCQCGv+qzCYqxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS0PR12MB7801.namprd12.prod.outlook.com (2603:10b6:8:140::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.28; Fri, 21 Jul 2023 13:19:07 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ab4c:b09f:b445:be6e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ab4c:b09f:b445:be6e%6]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 13:19:07 +0000
Message-ID: <fdcf25f6-c84a-a46f-dc4d-2d822abfab63@nvidia.com>
Date:   Fri, 21 Jul 2023 14:19:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] module: Ignore RISC-V mapping symbols too
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>, mcgrof@kernel.org,
        rdunlap@infradead.org, thomas@t-8ch.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20230707160051.2305-2-palmer@rivosinc.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230707160051.2305-2-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0297.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::21) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS0PR12MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ef1397-d4d3-4597-eef2-08db89ed0fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uavEASFXMr4zylN4/XNLBcVg3oh5QB2uH7z2IKTEqgdKQRmfsKKic5VcCP6rUyca4zZJIjpUsGit/ZHJYv21vO+Me/Rds3G6Fui4gyUO74WXvuc1oQi5QhEASohUOPjjmNMY3pjtFMOLiCbatcreBWrlcrkTcZq0kVVuStBdwx1nBI0j0H5j8Y9GUVaTmIt/x4fEpAMWpXccj/tkgLuAnurVOP75J201k0XYuLupQScj/GlyINh7mXc8fqkSGP95f0xgCyxQz+78b+mAvn+PPEHwk18RYzCl8vej+VC8VbjwGb5O685jQmZKhYAmFFvSyFMrc4M80ekqFFoaguTcs6VV5vlY890U3ujqXYovRqammPMYe9ix6UWtA/4WVSLZ+W2JeZvYDwk2yNgpW1T9Y+V1BOmZk1dhTuYyudxCCQL+D8bl3DE4uTzTMAeZxKXVkevQ5d3sqvcZsYSkdMvla4RB2RkFaIs466xFitC5OE1bfUmiBqNPigFZnMzbSnzrtj9Yu3uYQYzuBqlu8F96C1Tp/H1J0t+ocg/QsVQ96RMNQFaMSuvsXjz/5FJGM2BNk8PFQk/ZE+itYo0Hj0a64pRzLsXJg8OHXuOfeK4ujP3TcUT9rr48mDF0s9APYUisFtH8XTj09uUyv3oOZiJ+FG1ylRyxoqkXc34nA428THcONq0chmFr4qxPCfaTq9/L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(5660300002)(31686004)(2616005)(41300700001)(83380400001)(53546011)(8936002)(8676002)(6506007)(186003)(4326008)(316002)(66476007)(66556008)(66946007)(86362001)(31696002)(6486002)(6512007)(6666004)(966005)(38100700002)(36756003)(2906002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1pIVzh4cFgzOTZZdCs3Nm9rYlVQdk1UbmR0dEhFT0lhNU5zbjFGc1AyTURh?=
 =?utf-8?B?a0ZQRGQyNnVIZG1TV3pYQ1R1ajVEVEZoNk5BMElsZEZpWTMxRG5jQkdFcDMy?=
 =?utf-8?B?R2JqalRBRVM1SEFWRWlrd01Ha1RjRzVKdmhOR1RTSU5rdW8wTjZHR1pyZGFI?=
 =?utf-8?B?STNUUFlsb3I0aEJ1N05CemkzSGJHcDB5bHA3MjVsajg0VUNqN2VlQitMV3JH?=
 =?utf-8?B?L2Rha2dRZGprTWZoRGI0UU1leCtjaUExWFBaVVJjdVM2YktaT2JLMGpVaVNx?=
 =?utf-8?B?U1pzTnFab2lJQ2o4dUNTS3hFZy9wUU9YeHVqK1JnYWkwbDhSanp6bjg4N0dN?=
 =?utf-8?B?bWNqRkdOdmtZU2dBU0RJTXJFZHhKQjVmVUVuUkRhbFdlTUl1cmI4ajIvR3ZJ?=
 =?utf-8?B?bFBJMnd1WTVNTzhYcUdZK1dFa2NzMXdjRHlUT0dwQ3ZvNW1rREFseGdkbmpo?=
 =?utf-8?B?V054TCs1a25DMmszS1NWWnFBcUdaSmpQNHkrZDRrQUJ0bDVab1BkbDhvcEtt?=
 =?utf-8?B?YVRaUVQyeFJQYmtZUmIyekxqMktJQmZVYWs3SVFoZkJCelp6MGxvT281RmRT?=
 =?utf-8?B?eXRNczdkM3BEUkZ2enFIUWZNZFhWU0lhYlkyS2YzN1ptR20rcVphM1VNUjZG?=
 =?utf-8?B?c3EvcWc4b0ZOYnpkSTlJME9DcURJWkdQTjVhckxMc2JDUzdwY0tUSmNCOWx1?=
 =?utf-8?B?Zklud04xMmkxdlRqMlBBVUJXd0gzV0s1QlpKbERJSUVnaTdMNk1zWkEwaUpN?=
 =?utf-8?B?d0lzNFhPaU1PWnd0RlFEdVl6SVkwTmVPUjFOdFlZR2tEQ1ViTjlBYzQ3MUYy?=
 =?utf-8?B?TzFSbHNuOFdnT1VpSTFtdnBGeVNEc3YxNWtoV3VLem5ucmUxM29yZ3RtbE1V?=
 =?utf-8?B?SEU4dXBNaWd2c0p4SGVIQlgxVkdrbUVMK2JmRk1Bc2ZWNHo2YkNIaElFOWUr?=
 =?utf-8?B?UXFhdHg2S0VrTmEzM0xGaXdReTBzSWVnRzNPREl0ZERmMTkwMElsWkdsRmY2?=
 =?utf-8?B?SlZBZkhJUmdiYU5ab0tGZ3o5NGJQL1lTYW9DbXJ6ZUtON1R3bnRteVpZZS8x?=
 =?utf-8?B?VUh5WWxNbk1PbytwMFZXUjA1OWlvVnhBR2kwM2ttd2x5RVhybGhRU3NzckVq?=
 =?utf-8?B?c1l4MUJkK0NFQVdJMmRjcUVuWG5xeitVZzNwRjBUNWhQSUk3STBhUjJ6TEpY?=
 =?utf-8?B?ZlZkTFB6WFNUVk1OSXM0Zkg4MGgvVUhRL3ppVThvWms2emErZXRVWnVPZFN4?=
 =?utf-8?B?R283MzNHTUdMSHdMLy85Y3ViUjlUNldpNVdPUWpRSlNhd1g5NDRNRWphL09j?=
 =?utf-8?B?blNvaGxtbkIwM1hsVzhBUFhwQWJKNVBtU3NtNVhsMXZPQUcrZ09RUVFMd3Mw?=
 =?utf-8?B?Nitnb0Fzc1JZckxiZGZ3ZmdKL2kra0RVb2lQdFhzMTVKdlVFcWRTZXVLT0NB?=
 =?utf-8?B?cUtieEhtdDF5enRpZXZkS1pRaE1Jd1pzZmFwbXBYcjVVS3ExTEFxMU5YMjM2?=
 =?utf-8?B?MjVuVDc4d0N1S0JrTzNwNjQ1SG5zSlNoYVlFckNHMHZCQWxxSkVSK09ZakRG?=
 =?utf-8?B?RCtWdXp5VDI2a2ZoMjVPV01zZmU2dUtuQ3Joc0ZHRXZtZWRDL052L25sZlA4?=
 =?utf-8?B?ZXRHcVVWUi9yOXR5c2JxeVNRM01TMWtGQVpTcVNGbmVGTGVac3dLRWNqdkRl?=
 =?utf-8?B?TGJhbTdqUlBIQTM1LzNBYldSbloyUmZUc0VGWHJsWmFCZit0QXN5ODk3Wmk0?=
 =?utf-8?B?SkdybWdSTk94SzhNZkF5UzF3OG9PMkpPbTFGbXl3ZW1MZ3hCRnAyQ3pxaUZS?=
 =?utf-8?B?TGVGcDV1dndCYk52cEVJZEZyOTlFakc2MU1uQ214WjVVUGNkNUY3V0NkMGNQ?=
 =?utf-8?B?UWRXdTFZdnhXS0JMZUJEeSszT1RZQ2xzeENrU2RVTmJ5SExJRnJoYzEzc1VF?=
 =?utf-8?B?RGJwaGpYZkluQVd0ckxXTTRHWEl6NHhQMm9FQnY3YVNheWJiNDlKQ1dBajZ1?=
 =?utf-8?B?bEMvcHQ3QVNpaFhtK2pjeEM4ckV2ZjJ1cWpjQTVMQVZ2WWZYN1VnSzNveEJL?=
 =?utf-8?B?djZOcWF3RFdIQTM0V29DRk9NN1k0UDhFK0ljdDQzeHJMMU1uTmRzNlBBRXI4?=
 =?utf-8?B?K0RNSFVtY2FlWU1EQjhwM2hDbjc2OG5UaC9TNUkrY29rOGFwZk5kWHFHT1g0?=
 =?utf-8?B?d1I2aHNuczVqbW5reHIvOXhkRFJNOElUZTg0TGdRN0lkVEliQW5VTjE5VVFx?=
 =?utf-8?B?WlVCek1UOTE0cDloQlZiVEN0cXRBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ef1397-d4d3-4597-eef2-08db89ed0fd4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 13:19:07.0347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smysserbrLDPfeka/NskuUkQYE4WWgyrqm7eHOgc+KupvcISrW9KBieMFsXkzpTQYtxPT1Nb+jYVSU8CpOIB8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7801
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 07/07/2023 17:00, Palmer Dabbelt wrote:
> RISC-V has an extended form of mapping symbols that we use to encode
> the ISA when it changes in the middle of an ELF.  This trips up modpost
> as a build failure, I haven't yet verified it yet but I believe the
> kallsyms difference should result in stacks looking sane again.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/all/9d9e2902-5489-4bf0-d9cb-556c8e5d71c2@infradead.org/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> Changes since v1 <20230707054007.32591-1-palmer@rivosinc.com/>:
> 
> * Drop the unnecessary IS_RISCV define and just inline it.
> ---
>   include/linux/module_symbol.h | 12 +++++++++++-
>   kernel/module/kallsyms.c      |  2 +-
>   scripts/mod/modpost.c         |  2 +-
>   3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
> index 7ace7ba30203..5b799942b243 100644
> --- a/include/linux/module_symbol.h
> +++ b/include/linux/module_symbol.h
> @@ -3,12 +3,22 @@
>   #define _LINUX_MODULE_SYMBOL_H
>   
>   /* This ignores the intensely annoying "mapping symbols" found in ELF files. */
> -static inline int is_mapping_symbol(const char *str)
> +static inline int is_mapping_symbol(const char *str, int is_riscv)
>   {
>   	if (str[0] == '.' && str[1] == 'L')
>   		return true;
>   	if (str[0] == 'L' && str[1] == '0')
>   		return true;
> +	/*
> +	 * RISC-V defines various special symbols that start with "$".  The
> +	 * mapping symbols, which exist to differentiate between incompatible
> +	 * instruction encodings when disassembling, show up all over the place
> +	 * and are generally not meant to be treated like other symbols.  So
> +	 * just ignore any of the special symbols.
> +	 */
> +	if (is_riscv)
> +		return str[0] == '$';
> +
>   	return str[0] == '$' &&
>   	       (str[1] == 'a' || str[1] == 'd' || str[1] == 't' || str[1] == 'x')
>   	       && (str[2] == '\0' || str[2] == '.');
> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index ef73ae7c8909..78a1ffc399d9 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -289,7 +289,7 @@ static const char *find_kallsyms_symbol(struct module *mod,
>   		 * and inserted at a whim.
>   		 */
>   		if (*kallsyms_symbol_name(kallsyms, i) == '\0' ||
> -		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
> +		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i), IS_ENABLED(CONFIG_RISCV)))
>   			continue;
>   
>   		if (thisval <= addr && thisval > bestval) {
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index b29b29707f10..7c71429d6502 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1052,7 +1052,7 @@ static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
>   
>   	if (!name || !strlen(name))
>   		return 0;
> -	return !is_mapping_symbol(name);
> +	return !is_mapping_symbol(name, elf->hdr->e_machine == EM_RISCV);
>   }
>   
>   /* Look up the nearest symbol based on the section and the address */


Since this commit was added, our builders are failing with the following 
error ...

kernel/scripts/mod/modpost.c: In function ‘is_valid_name’:
kernel/scripts/mod/modpost.c:1055:57: error: ‘EM_RISCV’ undeclared 
(first use in this function)
   return !is_mapping_symbol(name, elf->hdr->e_machine == EM_RISCV);
                                                          ^

We have had some cases of this before [0] and was fixed by ensuring this 
is defined if it is not.

Thanks
Jon

[0] 
https://patchwork.kernel.org/project/linux-mm/patch/20210924224338.8vuOlQPWr%25akpm@linux-foundation.org/

-- 
nvpublic
