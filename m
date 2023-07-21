Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8091C75CA81
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjGUOsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjGUOsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:48:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CE7FC;
        Fri, 21 Jul 2023 07:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLNJ9gWez8/EBvOhiZLMubPQzy2+XFvNXXyX2oX93ze71I1lqafbCw5o4FdegZMZCVUNqhNZnSkpkaTX3bETPfEH+17bxjPJ2eUi7kiIteMLXSfQJOzc7Ok6eRC/l0fo2Nx+sgvBMZ/wUcMA7x79GheoVrG6Ewbfq5o9H7atZrD4EavqD8ruwjASXc64aeoyUjTWHNRrvMfouXwZCb/8WQkwe6mlXeguujdYqTMUoQhexOaQhG4wvmAdRbcw2yLwyB264YawcwB2i2YCMlTj2b/aQlxdki8EbOsp4exsMphE/MezeOsFTnWQvFBKapptyknBkAuz6gqQtK+dks3ooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l8ekgJkuKB9gu8Jc9/lWghReSvxudTop6hACh+0Vrk=;
 b=NWKk4w9Pi4/W94JS8ChbO9CofMoQkFm/uYntbeI/PzJxbKKK2dVXwwJX1GV3KG4Xnzf1e0yFlynTEwRMgHKdgY6XPP+OKOHS5Vgz0vdI13Ykcsmi3ejIyXFQbUn9c4BCIiW0lms0AenpZJ1Lh4yXMBap0S9nR0vR33o5tfcYrUVnYbI52Oxxgj6kkcVJy/Mn4i9ax68ebbFO9CT5UaAN/hOPQlBzTIhhcojFJlEopCbhKvqKogYLvWNoMttyOtkFTHQLSk9ogtJPfYD6e5kK0T8qZOataIlSNl/8LiYBqa/Z6l+Y0mLyM/areDYnaxkt4OoQCf/3wIBbJ0GVj3C3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l8ekgJkuKB9gu8Jc9/lWghReSvxudTop6hACh+0Vrk=;
 b=SvR5a23BS25WyLkEnpKjwsQx81DMkpz9sDgTjgv2ld+CqERjPhWtF2zQ85wgdwOIDWvmuv4lixlyvkkdY4ZAylO8Xbd3mufTWmcM8E3f8jjpbHD3iOjk51taAjbLZkK2JkzX9AuW7nYIGUqnMqaYlTNa0Adbq7J3khCbyV1iD2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Fri, 21 Jul
 2023 14:48:01 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 14:48:00 +0000
Message-ID: <bf9fbac7-995e-79da-daf6-76cdfaef0e1c@amd.com>
Date:   Fri, 21 Jul 2023 10:47:57 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        mingo@redhat.com, mchehab@kernel.org, nchatrad@amd.com,
        Muralidhara M K <muralidhara.mk@amd.com>,
        Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Subject: Re: [PATCH 6/7] EDAC/amd64: Add error instance get_err_info() to
 pvt->ops
Content-Language: en-US
To:     Muralidhara M K <muralimk@amd.com>, linux-edac@vger.kernel.org,
        x86@kernel.org
References: <20230720125425.3735538-1-muralimk@amd.com>
 <20230720125425.3735538-7-muralimk@amd.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230720125425.3735538-7-muralimk@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0486.namprd03.prod.outlook.com
 (2603:10b6:408:130::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 25aeb4b0-caf2-4064-db7e-08db89f97b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pgHlOzo90uE5PjIwcVNVqc826o4MC9E3m7oANWuWfXdM9ndO48/xut5nJ9nd1kMeB/GCNpzUD2GrEIGEpzNgRa/SB1mjxDU1nn/ruJv0Nbgzm/fq9bAwnyQwLak6XjSDKeJJj4fk5bhrhtsYUiCMbvY9Dyt5108U9P+9JuOx7VS+t3tNDCwIbWztx7CVdL02NlYC1aakkDiKlBJFWEME2pEZkwB8vLESSF9ki9uP/3qMlC1pQ6Nq0/CcVbO5F/zGS7963f3STpGsAI6C9Vwbhbv/YA64/PJBBch7ZP5AwxKAlyir/1RuQHRYs5z++Pim2SZ0vrGATXvD/0BBdPNtEv8dYfJd7prCUCQPPVPXjDRxFFyx11VRft59tMWGIaALKc58PGDuzz5j8hC4eo1d2x+FDvKLmnVYyVF2d29cC2p7x2qE90xtWzqpQmHzB0PIwix2tWpzvyKk+kdfcq5PnfTXS1KCBjVE1gqBduDu6+5t5eSw9v+EFI9f9cSal7Mfesj7o2CfA/ir69TWi68jub+VizFTmZiq107tllpIfaanzbP6DTJylmvRdxatxd8gTmfscTZlOzpGm8rUKJL/IGxENLd/oP8GLi01RX8DWOPdB5ZdxrdQfK5RILeIy5cLFk24YsLZ4OcXAmLbFat1Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(31686004)(478600001)(6666004)(6486002)(54906003)(66556008)(83380400001)(31696002)(86362001)(53546011)(6506007)(36756003)(2616005)(186003)(6512007)(5660300002)(2906002)(316002)(26005)(8936002)(66946007)(44832011)(66476007)(41300700001)(38100700002)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mmg3MXBpVWhCRHd1REJkRE5BK3Q5SlZFYzN0YmgycC9rN2xsVTNrYnlXQVB2?=
 =?utf-8?B?VE5tWlFjYUpmZ2F1aHVDZVRUSjB2dUp3SjROenJ2NWVEUUd4dzVKa3NnNTQv?=
 =?utf-8?B?UWNkVzZZZUZ5NzNWaVZ0MUpwZk5za00yYlJFVmhReEF2MzRPOC9lL3Z3bTkw?=
 =?utf-8?B?aCs2dStqTUlwejJuYytySWZXRk5SRnZNWVhTQlhNSk1GQ1BxNXoxN0c4bzB2?=
 =?utf-8?B?ZzNEOU9WQmUzUlFGNEVqZzM1d21QSHZzWk9oU3FRend1aVFTb2p0OVgwVjhZ?=
 =?utf-8?B?VkZ3RktwRm0veXF6Tkw4cWtlYjhyN3BHeWxReEJRNWxKR2k4aVpZRDVLNS82?=
 =?utf-8?B?N1hZL2hDQVVGODdua1FoaGprM2lZanZROEhvdzNWTGF4ejRaWWZhZkw2SjJm?=
 =?utf-8?B?T3VPZncraUlleUs0cFhORHNDeFk4SWxKcmU2Sm1jRDZDNmtLWkIvdnhLY1F3?=
 =?utf-8?B?OTkzSHFJY2M2bjJkb1YxMWp5SDdybzBNODFTRTFRRy9vQnJGbFczT1JCRC9s?=
 =?utf-8?B?ckZxT0VVeHNXRUFUZ25kTnluZmliR0dBdldxT2czQkVPbUc0dnp0UjlOcE9r?=
 =?utf-8?B?WkxmUk1RZG5yZmZkU3ZjMnQyd01hRHcyYjF5amNtK2tMdTRFRkIwbklYV3dz?=
 =?utf-8?B?eGJoazFHZFpwVmlxd1VaZFRnU2xyUExXTmhaNmxWWGY5WlZ5QnpHaEpVS3Ba?=
 =?utf-8?B?cG1vaUZaK2owRzRxaVQ2clNOQWJUYVJKSHN1eEFjdlMyR3l1RFIvaU85MEcz?=
 =?utf-8?B?RE1KT0tHMkpBUDBkdGpXNG5weW1RbnR4K0I4UTdEYXpRZDBtZUh0TkVjTy9q?=
 =?utf-8?B?RHpITEIzeUZMSzZzblpMblE4em5OSXFrTkRWWWF1aGNjQ2w5M2NnczFFaXM4?=
 =?utf-8?B?aHdrdUJVSWppYzAyQnhtMlAvUW5KcUFDMG1nUWNGMTBsZWF2MkxRcG9qUEh6?=
 =?utf-8?B?cmE1R1F4eE9BVUl6RlpOYTc1c1lxNnNiWkZIcVVOTW1aNFNGQ0hLNUlxTlVN?=
 =?utf-8?B?cUFGSTRhNWh4NWlBV3BKc2VzdG5sSE9uU3hodkc4dmx3akVIWmd5VW14dUNR?=
 =?utf-8?B?SmpJSythcmlOcVJJbEVIbDRZUTBLeHhKc2svV1R1blU4U3hMV1I0K1dlcmJ0?=
 =?utf-8?B?VVpQTDVRaldNVnkvdHV0NUNualJPd3NGYmZTVm0vWFI0M3YySy9rWCs4d1E4?=
 =?utf-8?B?OXQvRnR5WUx5MUg1MjkrMXZYc2djZFA3SXpmOExyV2pkZ3Y0d1h2K3NpOFlm?=
 =?utf-8?B?alBvMjJBRm9vWitVL1RVUTIvYmlIYitvRVlQblNWNGRQUXhMNkhJYUtWY0ZO?=
 =?utf-8?B?TFhIWmNDSmpyakdxY1E3NTBCVkdVVEl3ZjVJQnpGR245ZTcvOUtIbEdoRjNP?=
 =?utf-8?B?ZlhPejNkd3A5VzlqQ2M1Zmk3dUphNzZwRXRPQ1dpS3MvRU5odlZMZ0FtcHNG?=
 =?utf-8?B?bDhUOE5hYUxxbTh2bG9SRjRIdi9zRVdlcm5GOEU3VE5FVnZsaDVrZXJIOCtq?=
 =?utf-8?B?Z2Q2TjVZbHJldjJ3K3NUUC9QRkR4bU8rZlN1aFpac3E4N0FjRmdnaHlsS0F1?=
 =?utf-8?B?aFhWT2JzbC9jeDhSU21pa0VnOXk0dVVuMGdVaE1mSnRucnlCS3BCTUp2d2pB?=
 =?utf-8?B?b2I0NHBRRmZudmtxbE1LbWszaHBoZzFKMENBK25ObDdmUWJLa1o3bGJlUTFx?=
 =?utf-8?B?SU9kbld5TVZTMXZ3RS9KNjNqYVBHU1FHdUNXWVBlaWliSWtxSjdOWWlnUzN2?=
 =?utf-8?B?L2psNjBqN2hEUkhOTFJuTVRVWHhSanp5Nndvc21tdW9LUjBVTFhYU1Znb2NX?=
 =?utf-8?B?VTNVZU1PaGpmbzNockR5YW12bkh6TjkrMXc1TlZRS2xyNDJZTTFQL21TdDla?=
 =?utf-8?B?MFdYMkNaYlJwZTFCSlpQNlJ2Vk5RYVlybUlxcXpGMERLRUJMSy9aL29FY0JE?=
 =?utf-8?B?d1ludThyV3NEZzlNKzVyYXZOY0xtdFBUTW0xV01aSVR1QU9iQ09UdE0vY2NY?=
 =?utf-8?B?V3JwazNEbml3aEQ4TlpiWWFML1FzdHRGYk5GMFl4dXk3TUdHZHJsTU9lKzJK?=
 =?utf-8?B?R2dwTWlPSmxHSEhkMW4rQlcva1N1czIzc0NFV3dZUHNnbjFvY05kR29GdWFG?=
 =?utf-8?Q?vFrn/mgEUn+VRZ/A5nGXk/G19?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25aeb4b0-caf2-4064-db7e-08db89f97b0c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 14:48:00.9158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYqrAnjI1QLoB4cIUErvNiQpJSZjgeEqbwVzyipJZgXPutVYnEWAzyQIg3iii80FsAwZi0vYiSMO3Ii4+mry4g==
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
> On CPUs the data fabric ID of an instance on a CPU is equal to the
> UMC number. since the UMC number and channel are equal in CPU nodes,
> the channel can be used as the data fabric ID of the instance.
> 
> GPU node has 'X' number of PHYs and 'Y' number of channels.
> This results in 'X*Y' number of instances in the data fabric.
> Therefore the data fabric ID of an instance in GPU as below:
>    df_inst_id = 'X' * number of channels per PHY + 'Y'
> 
> Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
> Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
> ---
>   drivers/edac/amd64_edac.c | 36 +++++++++++++++++++++++++++++++++++-
>   drivers/edac/amd64_edac.h |  2 ++
>   2 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 45d8093c117a..74b2b47cc22a 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3047,6 +3047,17 @@ static inline void decode_bus_error(int node_id, struct mce *m)
>   	__log_ecc_error(mci, &err, ecc_type);
>   }
>   
> +/*
> + * On CPUs, The data fabric ID of an instance is equal to the UMC number.
> + * and since the UMC number and channel are equal in CPU nodes, the channel can be
> + * used as the data fabric ID of the instance.
> + */
> +static int umc_inst_id(struct mem_ctl_info *mci, struct amd64_pvt *pvt,
> +		       struct err_info *err)
> +{
> +	return err->channel;
> +}
> +
>   /*
>    * To find the UMC channel represented by this bank we need to match on its
>    * instance_id. The instance_id of a bank is held in the lower 32 bits of its
> @@ -3071,6 +3082,7 @@ static void decode_umc_error(int node_id, struct mce *m)
>   	struct mem_ctl_info *mci;
>   	struct amd64_pvt *pvt;
>   	struct err_info err;
> +	u8 df_inst_id;
>   	u64 sys_addr;
>   
>   	node_id = fixup_node_id(node_id, m);
> @@ -3101,8 +3113,9 @@ static void decode_umc_error(int node_id, struct mce *m)
>   	}
>   
>   	pvt->ops->get_err_info(m, &err);
> +	df_inst_id = pvt->ops->get_inst_id(mci, pvt, &err);
>   
> -	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
> +	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, df_inst_id, &sys_addr)) {
>   		err.err_code = ERR_NORM_ADDR;
>   		goto log_error;
>   	}

This patch is not useful until the address translation is updated. So 
lets drop this for now. And these changes can be included as part of the 
address translation updates.

Thanks,
Yazen

