Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4F675CA89
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjGUOt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGUOty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:49:54 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5519CFC;
        Fri, 21 Jul 2023 07:49:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y06iItPmRBcG8nqlf7F3hlyL5rV1pyIcrNflPHeCDM0uBFCClC1tlq78LsCHJWsKDJK6Z9VF7iqixvW+zQVXQB9msarUP6qKYz4f++gcUxYyZE6HJSlLi6lGR7eh2zCCXdjbzmczOIAWG0y9EHPDmClxoYNnNM4I2XcyHQzY2Dt17s9IVIxidCxoQgtAtHjLS2/eM89oa3Uf0zyOETuD7VBUPT43fMqS461Mt7fasD17R5cIFBTBF81uAKl0B5IzQF6RLsgxR2sCeYLYeQVkJB4n+rM6OcoINtDhMkiSJF88EUItuehs86bKf1cwufx/UGE8SNMKYFGsNSAb+yeS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elWGIDPSKBxgVixqTX2C9GLU82+a0lez0o/TG9N6gx4=;
 b=m3TJliFEx77CY9HQZ4dsTfEgxOKoNyghaSUvTRr+aLbEXP3ISpBXhhGHz059SK0pojJdI9R+WNiwwT+/LyCdl2hWxFfuzS1NzPgfz9P+f6E7v8Xw4BY0TbQeJOLeIl0tLCYx9oPuh5vlPKXU6w/zs5pKYECqmyZM6O9/SGrVfsLrkLq9hv4F0enFJSbw6iMrJQU9AoKehzOHYU1KEV5fKrelNvJfm+OLwrmk1jiOqd+VyQl9GpyHhmHkPuvj99Qz07r0FmijBdwHxhiOF9rlnMTW8VXiEs4/YvjCyEMegd6nqtBGDQDpJASDCVMJTyoPWoFC9shgG1KpXVvq5ti4mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elWGIDPSKBxgVixqTX2C9GLU82+a0lez0o/TG9N6gx4=;
 b=po7tUZGco+hbkdPJ0E2+SM0XulB58zlSFrkT+go+ogPazmb0qu4LZshRT3fq8xaL+rSfOywL977MM0WwaYwkAnBGly7/hNNR2MmV2DDFN/G9bo9mHfmbNBhEblpzqtREcg9Jk1UiYZG5WBbwMm0W9577lSqM1kr8FnOtN7BZlqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Fri, 21 Jul
 2023 14:49:45 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 14:49:45 +0000
Message-ID: <013c3631-2cb0-9a5e-1d65-6d085725b3ea@amd.com>
Date:   Fri, 21 Jul 2023 10:49:43 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        mingo@redhat.com, mchehab@kernel.org, nchatrad@amd.com,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH 7/7] EDAC/amd64: Add Error address conversion for UMC
Content-Language: en-US
To:     Muralidhara M K <muralimk@amd.com>, linux-edac@vger.kernel.org,
        x86@kernel.org
References: <20230720125425.3735538-1-muralimk@amd.com>
 <20230720125425.3735538-8-muralimk@amd.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230720125425.3735538-8-muralimk@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0930.namprd03.prod.outlook.com
 (2603:10b6:408:107::35) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: f083a090-64d1-4f1d-0a2a-08db89f9b99f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQRxgB9nTJN7qxYzuT/pGCpYyApmCloY7oHLWKw1nGgovNj23tEwSW5KVuAig1q1yx76VE6SwQJ2wJPuaszhQ7oQrKLXPKA+vuB+FGNM1IPsTk3huFmY12u/rsj0W/jjx+YgCiYosb5AekxcWW6J/YI2X3f7MxBSPqn5eegBdlSUx1dplT9gErJJGvxcTgnXodudYtbPHPTosFFuYDsLy2W3FhrM5VyDR988TEjeF9zVfADrnl9Khfyabsn8FWiCHcJJvKIz/4iJbZHhMzhF5lIhS8KQMBFZmpmrDu6troNqqRZRpeaCQRWvcv3FwZQWriigZelkHlfJcNTQ01U/vMSSnhg419PcF0d9xoiVSB8+MmUiJTuYfOGMDvNQqyM+GZmw55vd0rW0KV7pQ+7QVBapDix/anfWCve1qYeKsVfqoQni+VYsv0Y4foy6gkmFOtii9Pl9Yprf4F4Wg0FvvwxYzGfzIPnou+/x61kq3dMsWWD4G07Zxopq5LCcOGC40chzRAicXYt1ewmSRYSF34wFMhsqx2dOKIvwcseH+vKZ3QBh8xBr5l3vtrbrTSlIsUzFb5YSJ5+HiBhiMkcCHvwP6T4nXfDjX/HZzLKhL2o8gQqtNQ9D6ZV0Iq7TpCb+J+pAzfBaypAskRUTTtHGSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(31686004)(478600001)(6486002)(66556008)(83380400001)(31696002)(86362001)(53546011)(6506007)(36756003)(2616005)(186003)(6512007)(5660300002)(2906002)(316002)(26005)(8936002)(66946007)(44832011)(66476007)(41300700001)(38100700002)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXZHNCtWcE1uMGFBSlBYSU9WM2d6VGpLOVNjclF1eDJyUlBkWWZPQWZ1VVNr?=
 =?utf-8?B?QjlXWm5sL1oxZ3pOZmN2TEdrQ3ZzN1hGRzBaZ2JZTjFNd1YzWng1bGh0ck5S?=
 =?utf-8?B?MDIvSkJLa0V1NFVLZHQzWXJwdzhUMjNRZDFkbWF4Ti9xUEhwbG5ac3dwVE5X?=
 =?utf-8?B?NE9EWlduWThxYVlqcEZGNXIreTNIRTZYS0lsRjlVWkp4b2FYRXQ3azdQZDNr?=
 =?utf-8?B?Z3B6U2ZXRVd3elFvaEZKRUovbHRXU0ZOQmo1a3lSU0pmZHBMQWViZ3J5QnhF?=
 =?utf-8?B?UXNmQ3RBSVlBSXBWQkFQZDREc2wzUE0wa2ZTYmJMRFNONmdqbE1SUWFvazIx?=
 =?utf-8?B?dzc0STBKVFlQMnMyeVN6S3FpdTRSNE1CVjRCWEN3dWtyeWZmUy9mZHUzKzE4?=
 =?utf-8?B?Z0RRWGI1eGdLa1J6UlJpMENCUnlaMVgxWWxqcURQNnFaeEY4SkNQZjY1dU9v?=
 =?utf-8?B?dEVUYWo2cnJneUhSOU02ZkErV2Z3K1NabDlBazQrWjAyc2ozYW9KcTk5YUQ5?=
 =?utf-8?B?V3ZaUUJLQ2Nlb0RmK0ExVWF0Sld6L1N5UVJXVmQwdDkxUHpkbHZmT2htWUpO?=
 =?utf-8?B?QVV2UEZ3ZDRvZ3RIU1AyTVNKSEM3UzE3WGtvQUM1UUFXN0hvcTgrWUJ6b0p6?=
 =?utf-8?B?bmdydnc5MjZWeWdyS1FUSnU3MmptZDFxOWd3YjFrKy9LeGdhVCs2L2ovMG9J?=
 =?utf-8?B?aU9wSkJ0UC8vY041K1RCR3V4Y3J0ZlZEcTVXSnFzMlRwTEQ2R2tvTVh3N3Q5?=
 =?utf-8?B?WEtNbEsxWUpia0lsK0kxbW5mUExiK2V4bkxKTWZhSmFSUG5UZDBTLzFCME1w?=
 =?utf-8?B?NllMamZNK1phdE1zS1d1LzJESU4xVG96R0t6S3puYjZCRVlneTltZmNSVkwv?=
 =?utf-8?B?MXBHd0lWeHo0V0FrSWE2NStuSUlFYkJpRElOMnlldDlEWnZpMHlpWThqdUZx?=
 =?utf-8?B?bGpSS2YrK2FhQ2FVdFJqSkphK3Y1dThlQXpWSG5OOURsMm4raUJlcS9WcXhQ?=
 =?utf-8?B?ME8rb0IwbHBpTjQvNDA1Q0NwUGlSR01yM2JvSDJsdDZsczc5Q05HKzcxcU44?=
 =?utf-8?B?c1ZUQVUyekRhZk9tOStrOGRrNkhjVm1aWUFKcVFudVhDV3o5dmU5aCtCRGNN?=
 =?utf-8?B?WGVRb2ZURk01K3lNTnptd3ZsSkZqRkIyczJ5eEcvY01GYTdxbzJZRmhNMEFV?=
 =?utf-8?B?QXNHT2ZwaDhGaG95L2hNYm9Pa1VkbHFPOWJ0NWh6a1hWZjFnVlZody9UYzk3?=
 =?utf-8?B?RTFVdUxIdHplaXdjcGZ5YTdmMDk4NGZaZE84RDdHL0xoK0U5bGd4UVBYMDVX?=
 =?utf-8?B?ZmZBYVZia1dQZXhsTTNoV2EwL0R3dEhQU2hDT1k5K3l5SEJqQ2VlRlpENHMy?=
 =?utf-8?B?WnpVL3NEVEVWdUNwWEh1OUVPTm5FZjhKdUJFMmJsZ3lKc2YxQ1hCRlNROWI4?=
 =?utf-8?B?MFlFSkY0VW11Kzc5WisycEp3MkZBY1g3clRkZVB2ZWR1bWVZZm54N2NDQUpM?=
 =?utf-8?B?aEdmS0Z0TWE4ZUlKMnloNmZIdGVraDY5a0RxbFRFRmhaK0dEaHowZm1lelJU?=
 =?utf-8?B?dG1jckgvUCs2QVVCOUo1S2R0d3d4S0NWNkgzSDIvbEtZTHluUjdwdy80U0ha?=
 =?utf-8?B?dG5zV3pFRzRTd05BSnJpYWZveGVhRTdzbE12dW9XSnM3OGxaV0VPNG9vcjJu?=
 =?utf-8?B?QS85WkdPcGlGOXdEN0YrMlliWW5HdC9kT1RET0VXWisxT1pSWldKTVZrRTBQ?=
 =?utf-8?B?d2xySXBtR1Ztb0JVZTJrZ1NzVEY5dERPT2xpeFJnaTJsWVNEZnRjVWFrR1Vj?=
 =?utf-8?B?NWI5RjhuaExYZzhDTFNsblh5V0kxL1diVEozZk11eUxjdmprbWlPSk96anZV?=
 =?utf-8?B?WU5ySW9FbytJYWVaVXJHb3R5dFFxb2IxNFY2OFk5VVo4Q2xJcGpJUk1UbW1S?=
 =?utf-8?B?dU9DRUIvYjIxRE5FVFBxdnB1WkJ4dzlPZDlHOVc3UFk2dnVINDI0eWdCcUcz?=
 =?utf-8?B?VFFQbG1wUnpLOStHQ016NmRqK1gyK0FXYmljZkNFNXhXdGVDYzN2UVN0Mmp6?=
 =?utf-8?B?UWhxNkhRY1pqQVpiRUFBN1ZOL1BNaWQxYVZlc2Iyd1U0eFpQNkZKcFpUeEZN?=
 =?utf-8?Q?JnxNX6Jrv0nj4Vy/YgSuuXnNr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f083a090-64d1-4f1d-0a2a-08db89f9b99f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 14:49:45.8129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9dn4Zmdk2mDk4i3sYxHZ1IbtBk6Cv/5DGqiYHeAS5JL0XwopIDPJnzu15VKaeWSd8sJaPSi2Fwyz9ASpd6hKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/2023 8:54 AM, Muralidhara M K wrote:
> From: Muralidhara M K <muralidhara.mk@amd.com>
> 
> Reported MCA address is DRAM address which needs to be converted
> to normalized address before Data fabric address translation.
> 
> Some AMD systems have on-chip memory capable of OnDie ECC support.
> OnDie-ECC error address to MCA is a DRAM decoded address reported with
> a DRAM address (PC/SID/Bank/ROW/COL) instead of normalized address
> unlike MI200’s UMC ECC, as the implementation difference between
> HBM3 ODECC and HBM2 host ECC.
> Because OnDie-ECC address reporting is done in the back-end of UMC and
> it no longer has normalized address at that point.
> So software needs to convert the reported MCA Error Address back to
> normalized address.
> 
> Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
> ---
>   drivers/edac/amd64_edac.c | 160 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 160 insertions(+)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 74b2b47cc22a..304d104c25d8 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3076,6 +3076,159 @@ static void umc_get_err_info(struct mce *m, struct err_info *err)
>   	err->csrow = m->synd & 0x7;
>   }
>   
> +static bool internal_bit_wise_xor(u32 inp)
> +{
> +	bool tmp = 0;
> +
> +	for (int i = 0; i < 32; i++)
> +		tmp = tmp ^ ((inp >> i) & 0x1);
> +
> +	return tmp;
> +}
> +
> +/* mapping of MCA error address to normalized address */
> +static const u8 umc_mca2na_mapping[] = {
> +	0,  5,  6,  8,  9,  14, 12, 13,
> +	10, 11, 15, 16, 17, 18, 19, 20,
> +	21, 22, 23, 24, 25, 26, 27, 28,
> +	7,  29, 30,
> +};
> +
> +/*
> + * Read AMD PPR UMC::AddrHashBank and
> + * UMC::CH::AddrHashPC/PC2 register fields
> + */
> +static struct {
> +	u32 xor_enable	:1;
> +	u32 col_xor	:13;
> +	u32 row_xor	:18;
> +} addr_hash_pc, addr_hash_bank[4];
> +
> +static struct {
> +	u32 bank_xor	:6;
> +} addr_hash_pc2;
> +
> +/*
> + * The location of bank, column and row are fixed.
> + * location of column bit must be NA[5].
> + * Row bits are always placed in a contiguous stretch of NA above the
> + * column and bank bits.
> + * Bits below the row bits can be either column or bank in any order,
> + * with the exception that NA[5] must be a column bit.
> + * Stack ID(SID) bits are placed in the MSB position of the NA.
> + */
> +static int umc_ondie_addr_to_normaddr(u64 mca_addr, u16 nid)
> +{
> +	u32 bank[4], bank_hash[4], pc_hash;
> +	u32 col, row, rawbank = 0, pc;
> +	int i, temp = 0;
> +	u64 mca2na;
> +
> +	u32 gpu_umc_base = 0x90000;
> +
> +	/*
> +	 * the below calculation, trying to maps ondie error address
> +	 * to normalized address. logged ondie MCA address format is
> +	 * BEQ_MCA_RdDatAddr[27:0] =
> +	 *	{SID[1:0],PC[0],row[14:0],bank[3:0],col[4:0],1'b0}
> +	 * The conversion mappings are:
> +	 *
> +	 * Normalized location	  ondie MCA error Address
> +	 * ===================	  ======================
> +	 * NA[4]		  = 1'b0
> +	 * NA[5]	= col[0]  = BEQ_MCA_RdDatAddr[1]
> +	 * NA[6]	= col[1]  = BEQ_MCA_RdDatAddr[2]
> +	 * NA[8]	= col[2]  = BEQ_MCA_RdDatAddr[3]
> +	 * NA[9]	= col[3]  = BEQ_MCA_RdDatAddr[4]
> +	 * NA[14]	= col[4]  = BEQ_MCA_RdDatAddr[5]
> +	 * NA[12]	= bank[0] = BEQ_MCA_RdDatAddr[5]
> +	 * NA[13]	= bank[1] = BEQ_MCA_RdDatAddr[6]
> +	 * NA[10]	= bank[2] = BEQ_MCA_RdDatAddr[7]
> +	 * NA[11]	= bank[3] = BEQ_MCA_RdDatAddr[8]
> +	 *
> +	 * row low is 12 bit locations, low lsb bit starts from 10
> +	 * NA[15..26] = row[0..11]  = BEQ_MCA_RdDatAddr[10..21]
> +	 *
> +	 * row high is 2 bit locations, high lsb bit starts from 22
> +	 * NA[27..28] = row[12..13] = BEQ_MCA_RdDatAddr[22..23]
> +	 *
> +	 * NA[7]	= PC[0]   = BEQ_MCA_RdDatAddr[25]
> +	 * NA[29]	= sid[0]  = bank[4] = BEQ_MCA_RdDatAddr[26]
> +	 * NA[30]	= sid[1]  = bank[5] = BEQ_MCA_RdDatAddr[27]
> +	 * Basically, it calculates a locations to fit as shown in
> +	 * table umc_mca2na_mapping[].
> +	 *
> +	 * XORs need to be applied based on the hash settings below.
> +	 */
> +
> +	/* Calculate column and row */
> +	col = FIELD_GET(GENMASK(5, 1), mca_addr);
> +	row = FIELD_GET(GENMASK(23, 10), mca_addr);
> +
> +	/* Apply hashing on below banks for bank calculation */
> +	for (i = 0; i < 4; i++)
> +		bank_hash[i] = (mca_addr >> (6 + i)) & 0x1;
> +
> +	/* bank hash algorithm */
> +	for (i = 0; i < 4; i++) {
> +		/* Read AMD PPR UMC::AddrHashBank register*/
> +		if (!amd_smn_read(nid, gpu_umc_base + 0xC8 + (i * 4), &temp)) {
> +			addr_hash_bank[i].xor_enable = temp & 1;
> +			addr_hash_bank[i].col_xor = FIELD_GET(GENMASK(13, 1), temp);
> +			addr_hash_bank[i].row_xor = FIELD_GET(GENMASK(31, 14), temp);
> +			/* bank hash selection */
> +			bank[i] = bank_hash[i] ^ (addr_hash_bank[i].xor_enable &
> +				  (internal_bit_wise_xor(col & addr_hash_bank[i].col_xor) ^
> +				  internal_bit_wise_xor(row & addr_hash_bank[i].row_xor)));
> +		}
> +	}
> +
> +	/* To apply hash on pc bit */
> +	pc_hash = (mca_addr >> 25) & 0x1;
> +
> +	/* Read AMD PPR UMC::CH::AddrHashPC register */
> +	if (!amd_smn_read(nid, gpu_umc_base + 0xE0, &temp)) {
> +		addr_hash_pc.xor_enable = temp & 1;
> +		addr_hash_pc.col_xor = FIELD_GET(GENMASK(13, 1), temp);
> +		addr_hash_pc.row_xor = FIELD_GET(GENMASK(31, 14), temp);
> +	}
> +	/* Read AMD PPR UMC::CH::AddrHashPC2 register*/
> +	if (!amd_smn_read(nid, gpu_umc_base + 0xE4, &temp))
> +		addr_hash_pc2.bank_xor = FIELD_GET(GENMASK(5, 0), temp);
> +
> +	/* Calculate bank value from bank[0..3], bank[4] and bank[5] */
> +	for (i = 0; i < 4; i++)
> +		rawbank |= (bank[i] & 1) << i;
> +
> +	rawbank |= (mca_addr >> 22) & 0x30;
> +
> +	/* pseudochannel(pc) hash selection */
> +	pc = pc_hash ^ (addr_hash_pc.xor_enable &
> +		(internal_bit_wise_xor(col & addr_hash_pc.col_xor) ^
> +		internal_bit_wise_xor(row & addr_hash_pc.row_xor) ^
> +		internal_bit_wise_xor(rawbank & addr_hash_pc2.bank_xor)));
> +
> +	/* Mask b'25(pc_bit) and b'[9:6](bank) */
> +	mca_addr &= ~0x20003c0ULL;
> +
> +	for (i = 0; i < 4; i++)
> +		mca_addr |= (bank[i] << (6 + i));
> +
> +	 mca_addr |= (pc << 25);
> +
> +	/* NA[4..0] is fixed */
> +	mca2na = 0x0;
> +	/* convert mca error address to normalized address */
> +	for (i = 1; i < ARRAY_SIZE(umc_mca2na_mapping); i++)
> +		mca2na |= ((mca_addr >> i) & 0x1) << umc_mca2na_mapping[i];
> +
> +	mca_addr = mca2na;
> +	pr_emerg(HW_ERR "Error Addr: 0x%016llx\n", mca_addr);
> +	pr_emerg(HW_ERR "Error hit on Bank: %d Row: %d Column: %d\n", rawbank, row, col);
> +
> +	return mca_addr;
> +}
> +
>   static void decode_umc_error(int node_id, struct mce *m)
>   {
>   	u8 ecc_type = (m->status >> 45) & 0x3;
> @@ -3115,6 +3268,13 @@ static void decode_umc_error(int node_id, struct mce *m)
>   	pvt->ops->get_err_info(m, &err);
>   	df_inst_id = pvt->ops->get_inst_id(mci, pvt, &err);
>   
> +	/*
> +	 * The reported MCA address(Error Addr) is DRAM decoded address which needs to be
> +	 * converted to normalized address before DF address translation.
> +	 */
> +	if (pvt->fam == 0x19 && (pvt->model >= 0x90 && pvt->model <= 0x9f))
> +		m->addr = umc_ondie_addr_to_normaddr(m->addr, pvt->mc_node_id);
> +
>   	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, df_inst_id, &sys_addr)) {
>   		err.err_code = ERR_NORM_ADDR;
>   		goto log_error;

Same comment as previous patch. Leave this until address translation 
updates.

Furthermore, I'm not sure if overwriting m->addr is still a good idea, 
since we'd like to keep the original error information for other uses.

Thanks,
Yazen
