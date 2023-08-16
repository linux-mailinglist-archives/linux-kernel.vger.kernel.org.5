Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90DA77E889
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345268AbjHPSRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345491AbjHPSRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:17:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2342724;
        Wed, 16 Aug 2023 11:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2WV3TD1HUR2vinL3aQ96+/PvNE67sWjMdPSY0yduaBdqL+6w0G1FxjWPHRS0mC3c6AlPtCoNJMSHfm2nlZSRAZU06vv1AUGnhDVhPh9PLgwxkFmNYFngAuDPJJYTttOAnh+RoOh8o5i4TNF7FNbhZpYPdp4uP9el5/m9abPS2f4XlclpormaWg50Fh6O3U06a5xUpwzFgxcEJcGV2Dl5OatpaGKUt27yhT7w3gq7C/2jL0E+loxLES1ZUNaP1QliGJCem0gD5b7EYXyRaYbr7rAADzHU4IsBVv2mr79nnLg0jDDgTnVmlAuGEZY4PDxgNI70jZNIyJQKmrmCSSC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+DJuUvVJ55cb01h6gg8s5wHkAQeNXQ1sqa82L3SV2s=;
 b=KZrZ7n82AG37bBuBCAHUmh+mUTS3JIk7jB71LhpErNK9z9vk3jjl0GN13n3toJASSQPmvSf+sefj+tjKAwRYE+F/agFV9CE1pC3nstfbVOcXuYUH8TWbZOVZL0r+D/rCRaKHmYlYYdBCtmqL8SvCLAxsM8zoeX1rNRO6XpKgjti5/PO7XzqJVqN7W39coAULvAbZopSqjdfMxo71wWe9QvSih4H5UHDBub9DoPWImmWg1LNdgFw6FJCBNLVZZvAfwH+nG4NPqDA1sqvjlRx0s6E888n8LZfenmMGaB1k4I7yQJM4aoQsrjSoKejzSnEEx7gRB0u1TZ63HvAeFXY0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+DJuUvVJ55cb01h6gg8s5wHkAQeNXQ1sqa82L3SV2s=;
 b=PVYhHMF2i+CWiSvPBYI0dyteLPO0ueUaikkRy85EHCopz5f2ljX8UuArQutGzMErzAKYG8yy0W8TfuC7ac3GP677Ltdwbbg4CVt9XXSleVXE4Ui6PFlmtjrxdTqswZKfbqlIaJh9KCppuQUhVfcSyKZnGEg11HPm1cpYRypUD8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Wed, 16 Aug
 2023 18:17:14 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 18:17:14 +0000
Message-ID: <1178bf68-f355-1509-0849-b740d2906bae@amd.com>
Date:   Wed, 16 Aug 2023 13:17:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 5/8] x86/resctrl: Unwind the errors inside
 rdt_enable_ctx()
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
 <169178459367.1147205.14975628669652538089.stgit@bmoger-ubuntu>
 <42d034d1-1fed-8d3f-a2aa-b9dcc5ea1243@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <42d034d1-1fed-8d3f-a2aa-b9dcc5ea1243@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0009.namprd05.prod.outlook.com
 (2603:10b6:803:40::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: e514b0f6-87c3-432b-f3bc-08db9e850424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pwAVNXz0iN6AxsJkBYJfPeFwWxo7kgKvIWshMzngrGnwmfnhYj6N+s+CplwWpEHimQcf2DY+qF8dG8ucuKbkjXcgjHw4cSgyNWEwm1pmYHrStQXjyuxyWzW6w8CtRzGkFMLCsi21ttwkCx+0xhemU4GAaGmfYH7+g5ySPs5IqfnG4jkbyquQYiJ3OjwWePATKAW+boa14pw2c09Uj4+6BfFQRo2P79MsUkPrXghd5V0IwoEXXGvexytpZaoJv9NOfywEx04pjoEGKyujz+Ra/wI3UcshBNXnsrD1Xec99kJaXIQ3LdTNz9kjGGoIb1938pSq9QT4Hnp5YmAKas132bP8Lo6cX1r34/gQ5yJEPoWEgIXI/vb3UnOkb7oQfuME/9tny9ddyhr2RnVRIoaSn0/vODiSCBb+0ypv4fBzJnHCmUKw04uLO2DME42E7i+MNzWVnRpayd+CGTtfqBGz7mE6e38axgi7ojPN2PFXtxbmju4WN3NkcE7yU5N5Rs14iXQH/h64JB0YpmMoIC6oA/1MrZNphh5EOABoGq/MZzqGGjL6ek4lTUPWSgv6IzflPyapS3V01qdWjyu2SC1akJHx6FWc3bxDIO++j9dQ4tQQD9fkS9yfL0Vco0griDHwm29ZHcFy5/qNI8zzYn16Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199024)(1800799009)(186009)(316002)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(83380400001)(3450700001)(26005)(478600001)(7406005)(7416002)(86362001)(6512007)(53546011)(31696002)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzBhSVh2MWs0TjUvMEFlb0tMYUZoZGdmZjF2UXQ5Z2lIODZZbVgyMVVzRjlJ?=
 =?utf-8?B?MVBFVHpMclkwczRaQThpUUlucnpFVjB1RERoa3UzaFVUT05KUWNUdGJKbGV4?=
 =?utf-8?B?VC9vT0ZOVEVYMnRhaEZiZEl6eTdSYm80WE14UUNuRG50N2lwam1uSTQ4aVBs?=
 =?utf-8?B?SkFZOGVkMk1ySnI1T0MvQzRUNjlCUXdRSFd3YXh6SS9WRWZ6Zk51Q2JQaXQy?=
 =?utf-8?B?SjJpTXpXZk4rQzdVNFRZa2pST050M3h2MkI1bmpWdUpwdVpnWWlpdnhaVkFq?=
 =?utf-8?B?dndvOTZNSmlGV09HekJWYktLU3pKcVAwZkp2aVVmMXZyZVQrNTBPL2dEMXR1?=
 =?utf-8?B?OTluTXpCK1NlS3BKTnEzUXNCbjFCTXpuQ2J5djVoRmpEVzJUYjY3N3cxOVdK?=
 =?utf-8?B?UE10eHg5ZFQ0eDBmV3Y1MUhmRHJYY1lqVGJuazZHWkFlMGx5YmQ3VXd2TW5y?=
 =?utf-8?B?TGFQYkRlWER2U0pCWDFzbEw0eEZKZXhGak04QU1QT04rTUpqNituMjNISHNV?=
 =?utf-8?B?ZEJiUGZoMURGUkhMRnNVVHlrN3NNSEZuSnhvb3E4MERqemE4RlFIK1RpOTg1?=
 =?utf-8?B?UEZtVEVrVmQ2NmhMQW42cVN3b3RWM3ZNOGxJOFI1VGRkcFQrcHFyd1JrNm4y?=
 =?utf-8?B?dktUN3YxQ3RYM3VCckR3OHpSQ0RENFk0cHZTRmFYM1NGeDltYzcvbS9wWUli?=
 =?utf-8?B?cWkrTFhQM0ZtMlpaZ0d3V3Bla3FKZUR3amVVQTQrWlAzb1d2WjV2SG5kY1or?=
 =?utf-8?B?bHVuWk5VZHhVSkZTOWhibVV2TGgxMzdSNGh3TVJZaWk0TUQwL2Q5Mi8zQWlm?=
 =?utf-8?B?ZkpzbytQUnJNUnAwWGlCYjF3dFEyaGlFUkFET2llNUduckx2SkFOMzlHMWNw?=
 =?utf-8?B?U0NxNTlINWIwWG5SUXVYdGEzcTllWE5kTDFEM1dSV0RUSnRSUkkxZklwYjZX?=
 =?utf-8?B?TkVISVl1ZC8ySW9rcGpleXZhUEFpWXRpNnYzdHVKcXhVdm9PRFVkcVVqSG0r?=
 =?utf-8?B?dFN6T1h1Mkg4a3lkZmVKSlVrTk03WU5CZXZHbEs2elg5c2dCTWpkMGE3THZZ?=
 =?utf-8?B?RzFNODdHZEVxeDJoa1BkZ3dhL0NOS2VFMzh0aXNxSUQxM1FkQjZtYVJ4NTFO?=
 =?utf-8?B?VXZZN2xKVERpK1Bxd01sMDlYZVYvNXd1ZVpkZ05oS3RmdXptM0VpWHFndmd2?=
 =?utf-8?B?RXNsRUVwVk9XZSszZFlLNW8rTmg3ZndxU1FJSEpqOVJVWkJ6em9jdEF2T0Fv?=
 =?utf-8?B?MUhXSEZTbjdwZkpZOXBvMGFsMmdMdHY2aVRyMENyTDZPU2hJN0dXenJ4Q3I3?=
 =?utf-8?B?a01ITFA1dkE1Wld2QmFaRTIzUHBoOWJMMkFnZE8wbnFVYWNqSFRiMGsyZGg3?=
 =?utf-8?B?RVl0R01LSEZDZXl0dTd1LytCYWhaak9qajBxUWJKRjBPczluNFJOTG5TbDJH?=
 =?utf-8?B?VlFZWlgwaExQeC8rNWJyaEx2K2lRcGVSNHA2eW9aZ1diSmwvNW1CYThJTmZq?=
 =?utf-8?B?bXN0MldmMmdRR2RhTjR0S1FGc3ZIYm1ZS2tKc2x5Y0tsN0YxazZPN0lVTWFG?=
 =?utf-8?B?cW1HV1FDTlgwditNVzJiUHErM1FYSExaSVdNNkhhTGFmVms3bVBBaXBxLzJw?=
 =?utf-8?B?bVZYdjk0N3pydHNPb1NMWWEzanJwTy9qaENDaDUzK0VwT1hVVEJIbzJQcTVL?=
 =?utf-8?B?dFpLQTFTcGtibDgxZVFqRnhKMEw4OWRUNjRkS2NXOERReUVJKzJxTFB4T0t3?=
 =?utf-8?B?LzUzK0RxV2RDZDJIUGJ4a1VLUm1mVXV6b0dmaVkwU0x5S0JwTTJEQW8yRklL?=
 =?utf-8?B?TnJlK3RPWm84Mys2TTJlYmx4Wkg3eXpQN3dEZWpDdktzdGpObmVCdUwvYTMx?=
 =?utf-8?B?c3R2WXRmQnpiNElBV1JqNThDUVhUcmFnMWVDWENaTEVTWFlURXVLSng1eito?=
 =?utf-8?B?WmV5VU5IdHpkT1dIVVpabGI0dEtweWNDRG5IQTBhRDFyaXBjMFJrZEgrTSt0?=
 =?utf-8?B?OU14SXdHYWpIcS9VUUlZUHNUbjhad1ZPNmZXRlQ3UEgyVFFUaGFtdUIwSDNa?=
 =?utf-8?B?NG9NaGtDRzhkcmdZam9LL0NNUE9hMkUra1B3dGViZ2lJNVdLQnc5OFMxS1Zv?=
 =?utf-8?Q?o+DY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e514b0f6-87c3-432b-f3bc-08db9e850424
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 18:17:14.3096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dwG6tiQQ/bMuBVX7E5aILHkBZ1rkRaZZ3kscD/vQfVnXJu20ocvRBhwDW4TXRZq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,


On 8/15/23 17:47, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/11/2023 1:09 PM, Babu Moger wrote:
>> rdt_enable_ctx() enables the features provided during resctrl mount.
>>
>> Additions to rdt_enable_ctx() are required to also modify error paths
>> of rdt_enable_ctx() callers to ensure correct unwinding if errors
>> are encountered after calling rdt_enable_ctx(). This is error prone.
>>
>> Introduce rdt_disable_ctx() to refactor the error unwinding of
>> rdt_enable_ctx() to simplify future additions.
>>
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   44 ++++++++++++++++++++++++--------
>>  1 file changed, 33 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 3010e3a1394d..0805fac04401 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2377,19 +2377,44 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
>>  			     struct rdtgroup *prgrp,
>>  			     struct kernfs_node **mon_data_kn);
>>  
>> +static void rdt_disable_ctx(struct rdt_fs_context *ctx)
>> +{
>> +	if (ctx->enable_cdpl2)
>> +		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
>> +
>> +	if (ctx->enable_cdpl3)
>> +		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
>> +
>> +	if (ctx->enable_mba_mbps)
>> +		set_mba_sc(false);
>> +}
> 
> I am not sure if rdt_disable_ctx() should depend on the
> fs context (more later).
> 
>> +
>>  static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>>  {
>>  	int ret = 0;
>>  
>> -	if (ctx->enable_cdpl2)
>> +	if (ctx->enable_cdpl2) {
>>  		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);
>> +		if (ret)
>> +			goto out_disable;
>> +	}
>>  
>> -	if (!ret && ctx->enable_cdpl3)
>> +	if (ctx->enable_cdpl3) {
>>  		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, true);
>> +		if (ret)
>> +			goto out_disable;
>> +	}
>>  
>> -	if (!ret && ctx->enable_mba_mbps)
>> +	if (ctx->enable_mba_mbps) {
>>  		ret = set_mba_sc(true);
>> +		if (ret)
>> +			goto out_disable;
>> +	}
>> +
>> +	return 0;
>>  
>> +out_disable:
>> +	rdt_disable_ctx(ctx);
>>  	return ret;
> 
> This is not the exit pattern we usually follow. Also note
> that it could lead to incorrect behavior if there is an early failure
> in this function but all unwinding would end up being done in
> rdt_disable_ctx() because error unwinding is done based on whether
> a feature _should_ be enabled not whether it was enabled.

Yes. That is correct.

> Could you please instead have direct error handling by only undoing
> what was already done at the time of the error?

Sure.

> 
>>  }
>>  
>> @@ -2497,13 +2522,13 @@ static int rdt_get_tree(struct fs_context *fc)
>>  	}
>>  
>>  	ret = rdt_enable_ctx(ctx);
>> -	if (ret < 0)
>> -		goto out_cdp;
>> +	if (ret)
>> +		goto out;
>>  
>>  	ret = schemata_list_create();
>>  	if (ret) {
>>  		schemata_list_destroy();
>> -		goto out_mba;
>> +		goto out_ctx;
>>  	}
>>  
>>  	closid_init();
>> @@ -2562,11 +2587,8 @@ static int rdt_get_tree(struct fs_context *fc)
>>  	kernfs_remove(kn_info);
>>  out_schemata_free:
>>  	schemata_list_destroy();
>> -out_mba:
>> -	if (ctx->enable_mba_mbps)
>> -		set_mba_sc(false);
>> -out_cdp:
>> -	cdp_disable_all();
>> +out_ctx:
>> +	rdt_disable_ctx(ctx);
>>  out:
>>  	rdt_last_cmd_clear();
>>  	mutex_unlock(&rdtgroup_mutex);
>>
>>
> 
> rdt_enable_ctx() is called in rdt_get_tree() and thus its work should
> also be cleaned up in rdt_kill_sb(). Note how the cleanup you replace
> here is also duplicated in rdt_kill_sb(), meaning the unwinding continues
> to be open coded and patch #7 propagates this. 
> Could rdt_kill_sb() not also call rdt_disable_ctx()? This brings me
> back to the earlier comment about it depending on the fs context. I
> do not know if the context will be valid at this time. I do not
> think that the context is required though it could have no parameters
> and do cleanup as is done at the moment.

At rdt_kill_sb() the fs context is already freed. But, we can call
rdt_disable_ctx() with no parameter. We will have to depend on other
parameters to free the enabled features. We can use the same call both in
rdt_get_tree() (the failure path above)  and in rdt_kill_sb().

The function rdt_disable_ctx will look like this.

+static void rdt_disable_ctx(void)
+{
+       if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
+               resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
+
+       if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
+               resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
+
+       if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
+               set_mba_sc(false);
+}


-- 
Thanks
Babu Moger
