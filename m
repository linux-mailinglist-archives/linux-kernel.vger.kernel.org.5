Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5AB7D84C1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345265AbjJZObS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345244AbjJZObN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:31:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D327D1B2;
        Thu, 26 Oct 2023 07:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBXPT7VBirFsBTAMyCX3NANTnftM1ESwTyb2rl2GE/bdCMq5WciK0xViLfFK1cJYSH/iZQcCI+NpaemymVUyE431emuTrov5N4tPcT2/mfRfK0r/+AmDrOmBmcf8SbNx3QvwKIZErNafLT6Y9yzpW7gMBO6FqbjxG063wOxLfUEfiDOJaBJZgmRrMunxYIkzfzuI9TORdZHME2xd2W6ng5Jo3w3Lj7JzLKQNCOgnCSrDe1W0Zsb1wVIikXu/sUGMa/Q+WiaD0eyovMee85ZZRWW0snGSMkDoVTeGExSOAJq1oYjp3n79/Byax8g6Iy7xouOBH4zyY0z1BGynTIKfhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHj9VT8qqDU71zzW3/KgGH/x0PvGnERDikf2Wjmel7c=;
 b=MZrr6ovMhKtnmOG4mzcge4vLe6pNEMRBGndj68ppPeH471pmAkBz7M1f75jMu3mWpyOCwmdEu/hK9CqnkSVJXLeIGdLu3sIGRRBjdvDVOzanoeVayXfLU9QFdDpKyFjyQJqBQpjiUSqqe2WvPPsaIUDF3aOS0ShT+guilM6okU3FPH37UyxynmmwRb3rj/6nvCC1O0IB8xLjY42qs7oZzKsAaCtWGAk8hYp1cZGhvE+/8W+I8+VbJIrUTcJVa+svdqkbnBLy2EUE5JQHfUEkts2+t4DF1OI4/6LKAdSU21b8/GdADVVa7uJMJd/JPbGAfw1AqzwoqP25a3y3HOb/5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHj9VT8qqDU71zzW3/KgGH/x0PvGnERDikf2Wjmel7c=;
 b=HEFTzNY9RVil+dsIHHVFv/BIgXc9oNPD0U/Nf40XUfVWTIWty1a1skafe5G+FWb45ManJYJAVUdUA1GwTPnKhUcIBFJG1GddirkjoACCDdN57qnFKRl5svij2TEZJ4RpXM1MkeYu43IgMkWIxEKUYKeGuYkwRhnxaRhgdfiTGZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 14:31:07 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9799:80fa:a7de:cbb1]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9799:80fa:a7de:cbb1%4]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 14:31:07 +0000
Message-ID: <f9e2d199-1813-4b4a-83fd-bf93919a3411@amd.com>
Date:   Thu, 26 Oct 2023 10:31:04 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        mchehab@kernel.org, Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH 7/7] EDAC/amd64: RAS: platform/x86/amd: Identify all
 physical pages in row
Content-Language: en-US
To:     Muralidhara M K <muralimk@amd.com>, linux-edac@vger.kernel.org,
        x86@kernel.org
References: <20231025073339.630093-1-muralimk@amd.com>
 <20231025073339.630093-8-muralimk@amd.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20231025073339.630093-8-muralimk@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:408:ac::32) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SJ0PR12MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 321acce6-5b41-402d-5a01-08dbd63030bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K602QA2jUIDVW691LZeg1AvUxn1NeI5yn1ZyRvWT0eYSDFuQimnBpxmI4EeDgm4h+pCcWSqg9c8fJPmVyWv/ViEpljzVzFHu9pFDazK94u34hcckkR6wjTFoMYfkQdme8a2agjyxNEGQeRMAqsLwGuJWlfdSFPjCi8axfe2kO/IzbjeIoohf+A9sM3YODIj/yRu7SlcQ+cBYBdy2drC+8TLqnX/EBAbG6K8FXoWgr/s4gxV0vRmjLeORtOmUzjCm/dQCMiZ3HIXHi7cgDJkMTqRRXW56aM3Bv1exoRnB5zxk2qJwol0Gc8cKogVDwqMxheoAVk31XyOJtNg/PESwD3BmNavUChBGUWcxU6HaCgDMBWAcRdkbiTabxssB6OjfJ4+F/73zZhHU/R1yRDyJ7lTq4SHsHhDHROlWOnxuwhHC+W5auW3+kaNl+Oseoxr+hCwPMLftKszP8oYX8PnEhRo0uTRLNx4SwwGAsO/WF/UTpoir4+6f2K/H4xeRb7TjmpBM+ET87Dlb0ttCNlpy17FgRffo0dPFBELF72gPk2gosM8+s7QbckwV1K47AEGOTDDI52n8ja7gvx7aVZppOlAM+ary7cmIrA/BAbk1olQ4jpfZjrL2Qkp605j+mdcBVX4tLCisvBPbOdk6Az2voA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(31696002)(41300700001)(5660300002)(44832011)(66476007)(66946007)(66556008)(316002)(8936002)(4326008)(8676002)(36756003)(2906002)(86362001)(83380400001)(38100700002)(26005)(2616005)(31686004)(6486002)(478600001)(6512007)(6666004)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFpaSzhkck1DM2Q3a2xKVjBhNnRpMUI2bnBsUWwzVlo2YTFoVE5TYnZFV2ZW?=
 =?utf-8?B?MnpXekJ3VVZpV2ZrZDJiRDI5MFphY0o2eUZ3OGM4cmljSzRCSnpLaWVRa1dT?=
 =?utf-8?B?M2p0MktQZjBvdjVFdnI0ZVRCYjk4QmptVnJLZ2pFT2FTTTBvRW9NUmwrS0lU?=
 =?utf-8?B?N05ob2FQaXY1bzhSWDgzMWRrUTZyMlFQcUR4RXFNUnFKdjhZNkN3bzgxc0la?=
 =?utf-8?B?S1ZERkF4ZEVBVlF4ZUg5amVqeTV1YWdxSldxODhwaE9RT1g1dHVoN2Qxazd5?=
 =?utf-8?B?M3JhYlFmWlJuNkh6ZzBNTVg2MEJDdndZWDE2UnlqMVhpTUVJb0QvY0FLNnJP?=
 =?utf-8?B?dVZNNEJ5YW5ON3JOZTVnbFJrZmhzRU80QWtYQlk5MVVNN1ZSU09OckUrSWNI?=
 =?utf-8?B?QlhULy9KL2R4eXFUSkhKcVdoTkZlN3FBVnVJRENGeitpQjIvS081VUlxaW9m?=
 =?utf-8?B?WlBjdG9sU1Q1dkEyclNiZzhJNTg3N0lJb0RCdjFjWEk5T29zQ0lXOStzYUNN?=
 =?utf-8?B?eG04akgxYjJUU0hEeHVMeGw5L09DL0M2a0EwYlBqaDkvb0JkSHo0RWFQVytp?=
 =?utf-8?B?NmJuNllweWtqWkpWQ2pvK0hmOWdJekJEbUxCUi9FTWRId1hSWmZ3R1VMK1R2?=
 =?utf-8?B?N1dFL1l5Mk1paTl1QzRaUDRTWEh1MmZDSWd3OXpNa2xlclEyd05hZ0hBTmJS?=
 =?utf-8?B?UVU2Y0tPS2xxaTRoSjlGdG5RcjMrNWFtOGs2M1VZOGJYbk9NcEtwUTZSU2Ir?=
 =?utf-8?B?M2l5NVZiZG5hWGxHaUlvNlBVUU1tdHh2ZjFjZ2NvRzJEQXA0OHd0aWRvaUlz?=
 =?utf-8?B?T1VZV0ppdFpnbkNDVjZQWHVNNFdmWnBOZUZJU0l1T3BMSjRJS01MbFdoMEdG?=
 =?utf-8?B?V1hXUnlEY2JNTGJMSk5Cc1d3OUtvTUMzUVdJY2crcnJZZjY0d1JnTUlaM2JR?=
 =?utf-8?B?blE5R2hvRDcyc0lmRW1ZVVFCRGIwSkFjTmtuQWJhVFVnekg3Sm43eGduM0dY?=
 =?utf-8?B?V2wrWFJDcVhNK05rWmozM0VUOVBzRDRyTXBxcWJqaFJhbldHTU42WVg3c2FI?=
 =?utf-8?B?VENQUEZqZWFCOVRPREZ2RzZZTU40VGVVL2Z6S0t6WWNncDlobUhoNW41cmdI?=
 =?utf-8?B?QWlhcmEySSt2VEllUGlmN2lIOGtOaDU2cUUxZzRxMzc5dzM5MWh5ekVXeHJ6?=
 =?utf-8?B?MEdpM0xzWnlsYVA3dEhvOWZseUVOM2dXYk5GMER0ZTVkNEpsZE1BaTVtandv?=
 =?utf-8?B?WnpWcWlzUE1jdkJPWW9tNHFwRTJrd1pMT3crMm9MNFMyTnBKdldyalBzN3FF?=
 =?utf-8?B?QjdYQzBLUTF3cGwwSzZWK3p3SUhjZTZoNjBETHFuUzhTbm9vSHpWTEFPbWNn?=
 =?utf-8?B?ZFhUVnZlQmpxaFN3aUpnSlJTMDBBMkxoeGE0YyttQ09DaEgxZHJzZ3JlQWFV?=
 =?utf-8?B?cmpVbkIzWUVxZXEyRm4wZmtlRjh5OFVHcnNmYy9HN2kzQmg2NGNkZVFPTDZS?=
 =?utf-8?B?dFdNM0RNTk53RUpBd2xTRjgzalUxenlMRDAxS1prUE1lMEt0L05DOUVOSVgz?=
 =?utf-8?B?V2ZkRGJXSTgveG9FV1FBQXVuVVQyMlFEdHdKNFpkZGRFNkhtaWhxNGRPcTBv?=
 =?utf-8?B?Tk5sMVFQT0lXdzk5RGh6WjBhWTVoT0JRTGExdUN5ckdzalQyZXY5V0F2VGlx?=
 =?utf-8?B?a3VkdS9uc0xjTitMVVBtUHI1OHozSTJiSDV4aUJLR05XRWZKVjF0NFpXN3Zk?=
 =?utf-8?B?dWVXMHNLSm15SGMrMG1MbGNXcDBhaWo2QVRCSHpuMzAybnZZdEhWTmVpc213?=
 =?utf-8?B?SUFVcFlsYktGZFdoWUx5Nk96bW8rYm1Ub3JqU2ZHbWdaMXZGd3dSR2FvR0tt?=
 =?utf-8?B?NFk0TUFMNDhxT0I5TlkxMEFvMDRDQkt5YkVDUjBoVDRnWGE0VlN1VG5WL1Av?=
 =?utf-8?B?eTkvYzNIbWhLVTVRRXZMeHJBMVJ4QTBHOEthK1JWM1VBK0RpbGp1VFJ3M1lF?=
 =?utf-8?B?bElsTHVjUHMzWXRLNUNrd2ZMNFFTejV5UnJ0clhqaTJZQTRHWC96RUVNWURE?=
 =?utf-8?B?T0o4b3A1bXc1SU1JaVQ3Q1NvSUd6a25hc05YZ2pGRjNjcEFTaWNPbFV3WTlL?=
 =?utf-8?Q?TCQGJ8RZDYE59IWpiIaMJFurh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321acce6-5b41-402d-5a01-08dbd63030bf
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:31:06.9759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKlJNI8EZfakjtmzVCl+y2V5vrdABrJqJTp1lYQXfArjPI5flH1HAVRsj1mAdrA488tgs46ni7cycaSA6tdooQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2023 3:33 AM, Muralidhara M K wrote:
> From: Muralidhara M K <muralidhara.mk@amd.com>


The $SUBJECT needs to be updated.

> 
> AMD systems have HBM memory embedded with the chips, The entire memory
> is managed by host OS. Error containment needs to be reliable, because
> HBM memory cannot be replaced.
> 
> Persist all UMC DRAM ECC errors, the OS can make the bad or poisoned page
> state persistent so that it will not use the memory upon the next boot.
> 

There is nothing in this patch regarding persistence. It finds all 
system physical addresses covering a DRAM row and request their pages to 
be retired.

> The reported MCA error address in HBM in the format PC/SID/Bank/ROW/COL
> For example, In MI300A C1/C0 (column bits 1-0) is at SPA bit 6-5. Assuming
> PFN only looks at SPA bit 12 or higher, column bits 1-0 could be skipped.
> For PFN, SPA bits higher or equal than 12 matters. So column bits c2, c3
> and c4 gives 8 possible combination of addresses in a row.
> 
> So, Identify all physical pages in a HBM row and retire all the pages
> to get rid of intermittent or recurrent memory errors.
> 

There are a number of grammatical errors in the commit message. Please 
fix them.

> Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
> ---
>   drivers/edac/amd64_edac.c |   5 ++
>   drivers/ras/amd/atl/umc.c | 103 ++++++++++++++++++++++++++++++++++++++
>   include/linux/amd-atl.h   |   2 +
>   3 files changed, 110 insertions(+)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 79c6c552ee14..d0db11e19a46 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -2838,6 +2838,11 @@ static void decode_umc_error(int node_id, struct mce *m)
>   
>   	error_address_to_page_and_offset(sys_addr, &err);
>   
> +	if (pvt->fam == 0x19 && (pvt->model >= 0x90 && pvt->model <= 0x9f)) {
> +		if (identify_poison_pages_retire_row(m))
> +			return;

EDAC can still log the original error. So why return early here?

> +	}
> +
>   log_error:
>   	__log_ecc_error(mci, &err, ecc_type);
>   }
> diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
> index 52247a7949fb..d31ad7680ff1 100644
> --- a/drivers/ras/amd/atl/umc.c
> +++ b/drivers/ras/amd/atl/umc.c
> @@ -255,3 +255,106 @@ int umc_mca_addr_to_sys_addr(struct mce *m, u64 *sys_addr)
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(umc_mca_addr_to_sys_addr);
> +
> +/*
> + * High Bandwidth Memory (HBM v3) has fixed number of columns in a
> + * row (8 columns in one HBM row).
> + * Extract column bits to find all the combination of masks to retire
> + * all the poison pages in a row.
> + */
> +#define MAX_COLUMNS_IN_HBM_ROW	8

Is this true in general? Or is it specific to a product?

> +
> +/* The C2 bit in CH NA address */
> +#define UMC_NA_C2_BIT	BIT(8)
> +/* The C3 bit in CH NA address */
> +#define UMC_NA_C3_BIT	BIT(9)
> +/* The C4 bit in CH NA address */
> +#define UMC_NA_C4_BIT	BIT(14)
> +

C2/C3/C4 is unclear in the comments. Please expand these to be more 
explicit, like Column 2 bit, etc.

> +/* masks to get all possible combinations of column addresses */
> +#define C_1_1_1_MASK	(UMC_NA_C4_BIT | UMC_NA_C3_BIT | UMC_NA_C2_BIT)
> +#define C_1_1_0_MASK	(UMC_NA_C4_BIT | UMC_NA_C3_BIT)
> +#define C_1_0_1_MASK	(UMC_NA_C4_BIT | UMC_NA_C2_BIT)
> +#define C_1_0_0_MASK	(UMC_NA_C4_BIT)
> +#define C_0_1_1_MASK	(UMC_NA_C3_BIT | UMC_NA_C2_BIT)
> +#define C_0_1_0_MASK	(UMC_NA_C3_BIT)
> +#define C_0_0_1_MASK	(UMC_NA_C2_BIT)
> +#define C_0_0_0_MASK	~C_1_1_1_MASK
> +
> +/* Identify all combination of column address physical pages in a row */

This comment is not clear to me.

> +static int amd_umc_identify_pages_in_row(struct mce *m, u64 *spa_addr)

Also, this function does not identify pages. It identifies system 
physical addresses.

Additionally, this function seems very much specific to this 
implementation of HBM3. So the function name should indicate this.

> +{
> +	u8 cs_inst_id = get_cs_inst_id(m);
> +	u8 socket_id = get_socket_id(m);
> +	u64 norm_addr = get_norm_addr(m);
> +	u8 die_id = get_die_id(m);
> +	u16 df_acc_id = get_df_acc_id(m);
> +
> +	u64 retire_addr, column;
> +	u64 column_masks[] = { 0, C_0_0_1_MASK, C_0_1_0_MASK, C_0_1_1_MASK,
> +			C_1_0_0_MASK, C_1_0_1_MASK, C_1_1_0_MASK, C_1_1_1_MASK };
> +
> +	/* clear and loop for all possibilities of [c4 c3 c2] */
> +	norm_addr &= C_0_0_0_MASK;
> +
> +	for (column = 0; column < ARRAY_SIZE(column_masks); column++) {
> +		retire_addr = norm_addr | column_masks[column];
> +
> +		if (norm_to_sys_addr(df_acc_id, socket_id, die_id, cs_inst_id, &retire_addr))
> +			return -EINVAL;

Why return if a single translation fails? What if the other seven can 
succeed? Wouldn't it be better to find and offline 7/8 possible bad 
addresses than 0/8?

> +		*(spa_addr + column) = retire_addr;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Find any duplicate addresses in all combination of column address */
> +static void amd_umc_find_duplicate_spa(u64 arr[], int *size)
> +{
> +	int i, j, k;
> +
> +	/* use nested for loop to find the duplicate elements in array */
> +	for (i = 0; i < *size; i++) {
> +		for (j = i + 1; j < *size; j++) {
> +			/* check duplicate element */
> +			if (arr[i] == arr[j]) {
> +				/* delete the current position of the duplicate element */
> +				for (k = j; k < (*size - 1); k++)
> +					arr[k] = arr[k + 1];
> +
> +			/* decrease the size of array after removing duplicate element */
> +				(*size)--;
> +
> +			/* if the position of the elements is changes, don't increase index j */
> +				j--;
> +			}
> +		}
> +	}
> +}

Is it really necessary to de-duplicate this array?

This data is discarded after the page retirement step. So checking for 
duplicates can be done there.

> +
> +int identify_poison_pages_retire_row(struct mce *m)
> +{
> +	int i, ret, addr_range;
> +	unsigned long pfn;
> +	u64 col[MAX_COLUMNS_IN_HBM_ROW];
> +	u64 *spa_addr = col;
> +

Just use "col[]"; *spa_addr is not needed.

Also, please order variable declarations from longest to shortest by 
line length.

> +	/* Identify all pages in a row */

Comment is not needed.

> +	pr_info("Identify all physical Pages in a row for MCE addr:0x%llx\n", m->addr);
> +	ret = amd_umc_identify_pages_in_row(m, spa_addr);
> +	if (!ret) {

If this succeeds, then you print info. And if it fails, then you don't 
print, but continue to process information. This doesn't seem correct.

> +		for (i = 0; i < MAX_COLUMNS_IN_HBM_ROW; i++)
> +			pr_info("col[%d]_addr:0x%llx ", i, spa_addr[i]);
> +	}
> +	/* Find duplicate entries from all 8 physical addresses in a row */
> +	addr_range = ARRAY_SIZE(col);

You already know the array size; you defined it above.

> +	amd_umc_find_duplicate_spa(spa_addr, &addr_range);
> +	/* do page retirement on all system physical addresses */
> +	for (i = 0; i < addr_range; i++) {

You can check for duplicates here. If a value is a duplicate, then 
continue the loop.

> +		pfn = PHYS_PFN(spa_addr[i]);
> +		memory_failure(pfn, 0);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(identify_poison_pages_retire_row);

A namespace prefix is needed for exported functions, i.e. amd_atl_* or 
similar.

Thanks,
Yazen
