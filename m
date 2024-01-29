Return-Path: <linux-kernel+bounces-43192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F18840F72
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E61BB25CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12B43F9CC;
	Mon, 29 Jan 2024 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ziwJHBQJ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954AA1649C9;
	Mon, 29 Jan 2024 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548441; cv=fail; b=IcPvkGdaqQRogWPxxMuIhTe3j/QLlLEVoEa1i/tGuZ46rWaONFUWsvoHJeWXSA2TDKYuROoxGKtmfU0Aq7HakDIzRg6zz1cD23WCkh5gGHHlxOL5MQOmn5K6OsMk9NF/V3mgIXQQ/q1hIKUxA3Xdj+bykl6yi/Gs1xdb1YFIep0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548441; c=relaxed/simple;
	bh=RAp6HXN3lIQZ1iIAFub3LldQrPVulkfpePLorcW2vII=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o8rI1n4pOKOROiL2ZmfJ0H0bpmR8Vw/QACLsDrrZVqT5LZOaGu0/ynVIgIDEOnUYLIBoKe0L9S/6QrpFsTlHw303Qb1SGUhVSBw0QQ8VugxZa4MzHfpuGzJctIU6FvdVw9K0HJnjxwcIhYC/4/8fCJ7ipQX8Ah3mBqUuFRQs+B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ziwJHBQJ; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LT87LFQgMRxwdm/RylKk5mK0kuFo0nLGPd3Q+x8jMObrKFkztGIIYdGvDjs6AYlEEeUbDTQEbkvNMKQH+3nRV6I/ODQh/wX+/uuvK9M+F04UhmndRwYKpSjaKOefnLG7ALzN3j3la6n3Z+FqflHc20vvxX+bjYkmH8NyMDfgkKsaKuGyvpjelfTNcL+ePkrJ2bdTXdNlIxYCb2gS/nreUQyrRES5CgXTumGZ6XoJIVRJx0hfsDBkG1Y1lGWF3s+69ybxLFQS6gwLnF/KpI84DeNQcirAQx1lKQumYxpNeRb0FLv3HjaLDQKIMaVeGWdPfLyX6WFJhQgPioo+qe92Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LH9b+Qkm89Ewcz4+c+33xohIGJycmL1N/hfR8Ko0MWY=;
 b=jXxL5aIM+qD9pW1TBHz3lFjqwX50o9dApuIL/KVNxVtIkErjxugeRVpeTuGZYYSg6O5F/E/2B/RIHjwQU7mUrrFjCGedm6MecJ2JN8ZCTI/c31wJBJChs5lkPWyhlr/qhPeHLCJvGVY6mukXqrJnj9voqlXgf/vzJA7o6uHtIE8iKkoZHaBbEoigbJGZu1tM25+h1vCVYrZ6eAZR6c4DVNnsGVXEBs/8nfUGv1uhAdKDVBfq/vD9XPwbZ97nGiqjljXC/TkFLIx1/BlMMuKK6JlXh/FqjbPpbx2xj842zMxCh3XKFuAaDn77EPoQMp/mcv9C3YiK0xZQ7ZjZGDwTuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LH9b+Qkm89Ewcz4+c+33xohIGJycmL1N/hfR8Ko0MWY=;
 b=ziwJHBQJQHpSPt35swavjolDpjKGtb0D/6aIR88mHR0F0N4EtpO+caqZvSqR6xPDeX9FLuqm9ZU0HRQ089IQ6ydFcvxA/fh/5vIyFjsamaQ+hq7OF0RUxdWFgIHngc77OMqAZmvmAfrmzGIXPERH7/x/IwuC0Bc8i8TuyZi8Hek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by BL1PR12MB5377.namprd12.prod.outlook.com (2603:10b6:208:31f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 17:13:56 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 17:13:56 +0000
Message-ID: <261b8a96-cbdf-4c50-9aee-a70d04d99644@amd.com>
Date: Mon, 29 Jan 2024 09:13:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] octeontx2-af: Initialize bitmap arrays.
Content-Language: en-US
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, pabeni@redhat.com, sbhatta@marvell.com,
 gakula@marvell.com, hkelam@marvell.com, sumang@marvell.com
References: <20240129052319.4093083-1-rkannoth@marvell.com>
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240129052319.4093083-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0216.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::11) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|BL1PR12MB5377:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e110d9-a970-4710-cd2b-08dc20edad31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o3xsz6vQzxq2pQLpJtkzDuvVra2rpcDzddtxaHFDVw2pUaF+MMKmzTyFXobwemth53NBCnHiji0ScszytN0Tcs9N3y5eTb2Npjyh+6Ac+mbyDs8xY2BdyAElWU4lhuFakbcy6eaUa2rYxvUiWvjzP8Yg+wu4kg/E2zIs5WWau1p9ex50b4+rjlb7zYZN17B3fY1cV1N9p5eev2M16ElhQwK+hkRAMSTdYzbJHb1ksAD7RlhiiVXMtuvf6OQmvkRhwHxj+OKBqTWUs2kO1qnoDXry7hQRpp63Ji6qYCkzq3XRscPMog4tzXcPai0t76HdPuy2911pPk+ze8aBnGyqHO1ThQZ/WFhtRh6BwEzNM9/7JmCwBtZPBNApNcld1TDjlRPwBdkjCQJtPV93kQdt4mAgIAXx44Hxd1pnnRhsN4xufmOHjAuMW/GKmL2SrLUa0NRvvY1t4TP3jI9wNiYYu5HTeZtzYbRxG/6G6zm9xj8ZQHyOXhxsW6W/ucVQneN/sM+dMuHnw0fl9fRg7mzTeq9rRUQrkfr+NxJkhfskcR2NtLd10HJEwmf/vMGq0j6Y5R6ZTAVFK/n1ExdOOjDtPQLLRHj+/BHl5cd74a0rI1vciMZJLP+ciy7hxO1BKmomxT3r/prAdIpLbFowyg+RjeoyKo+Gm3nOfZSnoSwTSH47kr15lwuD0LfzmQVRc5DS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(346002)(366004)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799012)(64100799003)(451199024)(31686004)(2906002)(6512007)(6506007)(5660300002)(7416002)(53546011)(6666004)(66946007)(26005)(66556008)(4326008)(2616005)(316002)(66476007)(8676002)(83380400001)(6486002)(478600001)(38100700002)(41300700001)(31696002)(8936002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUpidk5QdlF5aHQzeXdMRWloRHA4M3VoWFFsYjBVRXk4b3hZejlNQWVwRjlX?=
 =?utf-8?B?V3FDNWhHd0lOc3dPRzVsdGpvOTJVSWhIalhMNThEZmljckFqY1V6MDk4REZv?=
 =?utf-8?B?N0ZZazNvSHRZY1BJWGQ2eThrYmVTQzVwU0owV2E5SXlDeXVWYTVXUGhkanJ2?=
 =?utf-8?B?b2pjWlN0MmNPQ0hCaUdEUk8vUDNlbjBkZTlPaHJFM3AxZUJqbFladWRHeGdO?=
 =?utf-8?B?US9oL1UwQnNVbS9FUnErbUVRa201UXI4aDB3Uk56U3VKMkVHZkdzUUFWS0Qv?=
 =?utf-8?B?cmJET0RrZ3Q3YW1zbUdWc0NoblNoa0VEWStuSVBOUWV0RUw3OTUxMlMySHFt?=
 =?utf-8?B?N1dibG8yUXdMQUk3dXUwRUtIVjRQMlJJMHNLbjgwcjFGSzBHdWthaDJaWXhG?=
 =?utf-8?B?L081K3MyTzkzb3ZGeFMveFlKYWY3RjJqTUp2VG50dEpuN2JpWGdPSWIzTzZa?=
 =?utf-8?B?b0hZanQrRWRDUDZxbU1zRjdiU0RKUW0rWlFQS2NNUmY3eWJvN1k3NUZrM2Zz?=
 =?utf-8?B?WVlKQ2VxSEJwVHp2LzlON2dmNzB6ZXdJaVVOaEtTcE1mVjlxaTBxdyswUDRE?=
 =?utf-8?B?a1BOOFNUR3oxQUxHeHllalFaV0VUcTd6dk14Z0h6N1dIcXNzT09QdGljZkhQ?=
 =?utf-8?B?YzJmUEw2WHBLZGk0d05XRXRrN2NzZnpIbGRBOWdKMnJJN1I1NTFhdUFNS1JN?=
 =?utf-8?B?eXZuLzdyT2hkTUMyYW1HUnRhS2RZRkdwUVVMdWJhcUpwTTBLTFgxWEgxNDlu?=
 =?utf-8?B?aGxMUVZQVEtQczR6ajNUeTYxa1JFRlZrWWNTMDJ4bmpubEVjVHFxaTVyZEl5?=
 =?utf-8?B?aW5sK29qWkkrN21GOEEvVzV0WWkrTjc5VTRsU1Z5bEJmNVk4NnowaFY3MWwv?=
 =?utf-8?B?aXc0cXNOOThqZm5FTm5hSk9RdWxoUU5USS83cGhHKy9kVjcyVEo5WHFyWWps?=
 =?utf-8?B?ZE9uZzJmRmtpSjg5L3J5V1FlTzU5aDJTcmI4akxmMU1hcGtEZXB1SlVNQ255?=
 =?utf-8?B?emZpMFYxbUtId211S1UyWkg1NWRwS3Q3YWFkamxqLzUxbDNoODZVRDYrTmYx?=
 =?utf-8?B?a3BZV3pXOUd6a1lBQVJmSEdhU2FBTjYydFB3NlkvSk1ESnd5S3pZVzV1TWVz?=
 =?utf-8?B?cFhTa3VoWjdxYWEvendycXhqSm9EWlJvRWVRcXNjVVJBa3RlOVZYK1NvV3d2?=
 =?utf-8?B?Q1RpMmZsUkVEVko0M0V0S3llcEkyTUcyK0xBY3BEYjBYVSs3TktEbENEdUtF?=
 =?utf-8?B?dzJ2L0lpVGtEMkJBQjRnbUR0NkY2RW1LNTJnbjEwbWM0V0lncVllVDJuK2lY?=
 =?utf-8?B?a2pHaFI3V0VSdWc2c3Q1VXJYQzJPS3pZRmx6T2w3cUh6ZEVwQXB2Q3F0b1BJ?=
 =?utf-8?B?dzlBTVpmOHhhNE9kbUxsQm9BU3ZRQnFYSTREcnVsNFVTNHJNT3dnVTFPcjg2?=
 =?utf-8?B?T3J2NlIwSWNTZnVVTlRaRDJYUjcxOG84T3VEc3l2WTFyTFRXa1NHZ2tRZndw?=
 =?utf-8?B?R2tsWjJobTdxbkV5NVBic1dncTdMcWtpTkpzUWdOcythMkRyRFdPUTFrbjdO?=
 =?utf-8?B?Ym4rakRoWkVTekZQaFNTTHdaS3NpMmo0WkhHUHhGUkU0TzYvNGh5SXkxek5Y?=
 =?utf-8?B?dVNsNlNMWFNVSzB2ekFNYzVLOFhlZFJzZTZycUJWQWlhMkpMRlFOeUZyU0ZP?=
 =?utf-8?B?aFVmRkZXcW8zMFNEQUxpZE5YWUFDMFdCU001KzlBKzlRbUlheFh5KytBSHVy?=
 =?utf-8?B?ZTRiOE1FUGR6cWZ1VFRUSElQNmVEWFhNTE16c0ErZHJPaEhJbnQ4YVBhY28x?=
 =?utf-8?B?dHBTQlRHblFDa2J0MldHUDVTT1M5L0JiRS9nNm5LM0tObkNRb3Y1clgwVWdh?=
 =?utf-8?B?M2M1Rlpkem8xbkw1YUxvbUU3QUhYcDlsNmdZRW9JVzlEM2dYL0V1YXF1dzBZ?=
 =?utf-8?B?ekV2V2hRamZZSVRjM2hqRUk3ZklncGlSUnhUUkh0bVMvL2lkQkVYVGt5dEdH?=
 =?utf-8?B?MmIvQ3JGWGRRTFZtaUpDL21aWUJTUXBuNUVJS1VLVERLeGtINlRsT3hEajQ3?=
 =?utf-8?B?cWhqcDhtUmxLQXN4WVcxMC9TQ3AvL1M1V090TURmbUtudzBoaFhJdGhsUHYx?=
 =?utf-8?Q?SAdOpX903HAFDh9EITIh6PA2o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e110d9-a970-4710-cd2b-08dc20edad31
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 17:13:56.6222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nt6Xzr5ZLR8FFixHN0nbXv+IPv8l0zGYouFuWGt2YXnEBvRioOfrLqMISewjnZKKaANP3Q2znTc5ebGRoYM6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5377



On 1/28/2024 9:23 PM, Ratheesh Kannoth wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> kmalloc_array() without __GFP_ZERO flag does not initialize
> memory to zero. This causes issues with bitmap.
> Use bitmap_zalloc() API to fix this issue.
> 
> Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ChangeLogs:
> v1 -> v2: Used bitmap_zalloc() API.
> v0 -> v1: Removed devm_kcalloc()._
> ---
>   .../net/ethernet/marvell/octeontx2/af/rvu.h   | 10 ++--
>   .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 48 ++++++++-----------
>   2 files changed, 26 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> index 43be37dd1f32..679bd6e87066 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> @@ -184,11 +184,11 @@ struct npc_mcam {
>          unsigned long   *bmap_reverse;  /* Reverse bitmap, bmap_entries => 0 */
>          u16     bmap_entries;   /* Number of unreserved MCAM entries */
>          u16     bmap_fcnt;      /* MCAM entries free count */
> -       u16     *entry2pfvf_map;
> -       u16     *entry2cntr_map;
> -       u16     *cntr2pfvf_map;
> -       u16     *cntr_refcnt;
> -       u16     *entry2target_pffunc;
> +       unsigned long   *entry2pfvf_map;
> +       unsigned long   *entry2cntr_map;
> +       unsigned long   *cntr2pfvf_map;
> +       unsigned long   *cntr_refcnt;
> +       unsigned long   *entry2target_pffunc;

I'm not sure you want all of these at bitmaps? It was recommended to use 
bitmap_zalloc, but that was specifically for the bitmaps.

>          u8      keysize;        /* MCAM keysize 112/224/448 bits */
>          u8      banks;          /* Number of MCAM banks */
>          u8      banks_per_entry;/* Number of keywords in key */
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index 167145bdcb75..367f842e365d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -1850,13 +1850,13 @@ void npc_mcam_rsrcs_deinit(struct rvu *rvu)
>   {
>          struct npc_mcam *mcam = &rvu->hw->mcam;
> 
> -       kfree(mcam->bmap);
> -       kfree(mcam->bmap_reverse);
> -       kfree(mcam->entry2pfvf_map);
> -       kfree(mcam->cntr2pfvf_map);
> -       kfree(mcam->entry2cntr_map);
> -       kfree(mcam->cntr_refcnt);
> -       kfree(mcam->entry2target_pffunc);
> +       bitmap_free(mcam->bmap);
> +       bitmap_free(mcam->bmap_reverse);
> +       bitmap_free(mcam->entry2pfvf_map);
> +       bitmap_free(mcam->cntr2pfvf_map);
> +       bitmap_free(mcam->entry2cntr_map);
> +       bitmap_free(mcam->cntr_refcnt);
> +       bitmap_free(mcam->entry2target_pffunc);
>          kfree(mcam->counters.bmap);
>   }
> 
> @@ -1904,21 +1904,18 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
>          mcam->pf_offset = mcam->nixlf_offset + nixlf_count;
> 
>          /* Allocate bitmaps for managing MCAM entries */
> -       mcam->bmap = kmalloc_array(BITS_TO_LONGS(mcam->bmap_entries),
> -                                  sizeof(long), GFP_KERNEL);
> +       mcam->bmap = bitmap_zalloc(mcam->bmap_entries, GFP_KERNEL) >          if (!mcam->bmap)
>                  return -ENOMEM;
> 
> -       mcam->bmap_reverse = kmalloc_array(BITS_TO_LONGS(mcam->bmap_entries),
> -                                          sizeof(long), GFP_KERNEL);
> +       mcam->bmap_reverse = bitmap_zalloc(mcam->bmap_entries, GFP_KERNEL);
>          if (!mcam->bmap_reverse)
>                  goto free_bmap;
> 
>          mcam->bmap_fcnt = mcam->bmap_entries;
> 
>          /* Alloc memory for saving entry to RVU PFFUNC allocation mapping */
> -       mcam->entry2pfvf_map = kmalloc_array(mcam->bmap_entries,
> -                                            sizeof(u16), GFP_KERNEL);
> +       mcam->entry2pfvf_map = bitmap_zalloc(mcam->bmap_entries, GFP_KERNEL);

Are you sure you want to use bitmap_zalloc() here?

>          if (!mcam->entry2pfvf_map)
>                  goto free_bmap_reverse;
> 
> @@ -1941,27 +1938,24 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
>          if (err)
>                  goto free_entry_map;
> 
> -       mcam->cntr2pfvf_map = kmalloc_array(mcam->counters.max,
> -                                           sizeof(u16), GFP_KERNEL);
> +       mcam->cntr2pfvf_map = bitmap_zalloc(mcam->counters.max, GFP_KERNEL);
>          if (!mcam->cntr2pfvf_map)
>                  goto free_cntr_bmap;
> 
>          /* Alloc memory for MCAM entry to counter mapping and for tracking
>           * counter's reference count.
>           */
> -       mcam->entry2cntr_map = kmalloc_array(mcam->bmap_entries,
> -                                            sizeof(u16), GFP_KERNEL);
> +       mcam->entry2cntr_map = bitmap_zalloc(mcam->bmap_entries, GFP_KERNEL);

Are you sure you want to use bitmap_zalloc() here?

>          if (!mcam->entry2cntr_map)
>                  goto free_cntr_map;
> 
> -       mcam->cntr_refcnt = kmalloc_array(mcam->counters.max,
> -                                         sizeof(u16), GFP_KERNEL);
> +       mcam->cntr_refcnt = bitmap_zalloc(mcam->counters.max, GFP_KERNEL);

Are you sure you want to use bitmap_zalloc() here?


>          if (!mcam->cntr_refcnt)
>                  goto free_entry_cntr_map;
> 
>          /* Alloc memory for saving target device of mcam rule */
> -       mcam->entry2target_pffunc = kmalloc_array(mcam->total_entries,
> -                                                 sizeof(u16), GFP_KERNEL);
> +       mcam->entry2target_pffunc = bitmap_zalloc(mcam->total_entries,
> +                                                 GFP_KERNEL);

Are you sure you want to use bitmap_zalloc() here?

>          if (!mcam->entry2target_pffunc)
>                  goto free_cntr_refcnt;
> 
> @@ -1978,19 +1972,19 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
>          return 0;
> 
>   free_cntr_refcnt:
> -       kfree(mcam->cntr_refcnt);
> +       bitmap_free(mcam->cntr_refcnt);
>   free_entry_cntr_map:
> -       kfree(mcam->entry2cntr_map);
> +       bitmap_free(mcam->entry2cntr_map);
>   free_cntr_map:
> -       kfree(mcam->cntr2pfvf_map);
> +       bitmap_free(mcam->cntr2pfvf_map);
>   free_cntr_bmap:
>          kfree(mcam->counters.bmap);
>   free_entry_map:
> -       kfree(mcam->entry2pfvf_map);
> +       bitmap_free(mcam->entry2pfvf_map);
>   free_bmap_reverse:
> -       kfree(mcam->bmap_reverse);
> +       bitmap_free(mcam->bmap_reverse);
>   free_bmap:
> -       kfree(mcam->bmap);
> +       bitmap_free(mcam->bmap);
> 
>          return -ENOMEM;
>   }
> --
> 2.25.1
> 

