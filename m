Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7481D753FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbjGNQpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbjGNQpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:45:02 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B98230FD;
        Fri, 14 Jul 2023 09:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQVhJdswIr9tKbdD+lj8gMKLwt9ctNTVHnmU4EZ6xHuJCOVR0XnwEqt7Q5KvpDfzFLrHVyzvg8Yqcc8C0BN7IbNa1RqZZZ09pccCNKp8pHN0TmYUi/sQ48r8n4tG2ncyqTPBl7zVP/l6m9/vj1ywqs0+KPzzj9k7RAJ4icc8NwGdjUTDXujkElTsZSavKb7i8TB27aYGahHld1wrTKx3zTq4hUPiA8iE8Qvh4NNtaAqapwR7mVkT19S0v1ao+Gp2h5KNbQSoNxy6R7BjokO0RAXG98Z/KskLxU7wq78nKfDtfivV0/uZBzfr3xuM26gUbK61Zg7g/g6h2roijA2Oug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkyW7jKOE3INhzIeubNfpvgb5Dv/bfzS/nnDHfp6+GM=;
 b=jgQgw2L8UWH5YbYCavCJLiZaavXKH4EX5H9OLbs/oBclL0o+nizXELXCi1QrcRjmAY7QZ8bgFhzzBG8sYZW1wsIg/2GTNufiKmiCnXQVtFYVL94kUfDRvHlppibra9S2yTLtTZHgCBZSodCDk4rO4l9193DukxEYAuSCkSOS6jrRtJENjmT2FA5FJ8p8IEBbkfmzId/5guPMAJ2rPRPgiFm5tpfh+mPat2JA7SrokD6LJ5u+YxkdgSjSvL8qR9RNCxg0eKmpXuMND1CK1h+Pdhc4kJGghXt6A1yjr0ufzAhrkq59gSzmyke3xaWgKe0Eo0UFPiMTaBg3ke7eehRR+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkyW7jKOE3INhzIeubNfpvgb5Dv/bfzS/nnDHfp6+GM=;
 b=U6QfwDB3wf1Ge+soBW6K4jUCkrbGCatUiToEvBq48aO/9GImGm/kxU7YVP68DOR9Zp8wDh8v02qxpZKfR/TJA75Jqjwu/t31P687oceBZ3S6zQ6Y5FXifV8GV3pRRVeT99HbN8UMD7d8T2qUeAu0Nz6/tUNqI9E+RD9sq4DXZL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Fri, 14 Jul
 2023 16:44:55 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f870:5325:36eb:e741]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f870:5325:36eb:e741%2]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 16:44:55 +0000
Message-ID: <89e77440-f5da-b594-f755-d491c6c81230@amd.com>
Date:   Fri, 14 Jul 2023 11:44:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 8/8] x86/resctrl: Introduce RFTYPE_DEBUG flag
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
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
 <168564613667.527584.13233260903070279360.stgit@bmoger-ubuntu>
 <43ca50af-a58c-36de-74f7-47750faf79c5@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <43ca50af-a58c-36de-74f7-47750faf79c5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0190.namprd04.prod.outlook.com
 (2603:10b6:806:126::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b0f355-4d7c-4d00-c882-08db8489a742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ukFbudrkYM50pLQg3H5J6hbB2lZMWd/HHreLu1jpsS/oVBVq6Bl1Xd5O8tZaJ1XSkviNSLNzepo7rRpdq6vyeZbDN9zzr0dlp4sCTvkdXiqDsInTaxXEq4V0I6XwwL7POVKnmbAP81Jk3zW7loT3yU3JVYgGGTcF6Z6t8sEmPURUyZOZYvhAEIm0s6RVbL30PQ6vFBUYdzKUa1UyC+VjGCNP3pfikruag5qcax9VeX8G/sxz4/99tu/2H11wD/Ee9lkBpb3zEd8RrvCd09F98ciiXWKENmATc+bWxay2FI6HO2q5gZBplnLRyJ4CYTLmmkBS7JjxLI6DAzzwjbrO2lSXoQGPn1krt7rzRuNRCNje5o+smrq19W8P00C53GiaqsFaE46f9YVbDs3phIsl5Zz/KDvOQrgUdgQNU+L02uhPUqR18hrDCcfyvHhiBCUWngwWTZoNwccKVBnPZB37lLsRcCGIsPX+so4EE/QeWDpPBrzSgwYWxSxJeqnf//HKZEapnXWaV18yU+O7ESzYheEOZ2e6Nb220RWSXCg4WbVJ6d3bAECFiJ0wnr7hFSjeKnuwYa0+yzLzLsms1WdAB/DkZLyADkLqMLZaguF4jcuNZoCbSipbEQH5FXOf8UOq0LGN/lpIUHvomnsnXJsEsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(6506007)(4326008)(478600001)(6666004)(53546011)(2906002)(6486002)(186003)(38100700002)(8676002)(26005)(6512007)(41300700001)(66556008)(66476007)(5660300002)(7406005)(7416002)(3450700001)(66946007)(316002)(8936002)(86362001)(2616005)(83380400001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW9tQWsxbXJQTTRvWjRFV3dHaU0zbEZRdkZOamxXbUJDZkV5NDAxUWFwU01t?=
 =?utf-8?B?RGlGclVvTGNXMi9GaVh4K1pyQ055c1ZVM2pTbUszTXFITWVqQjcwV3pRbHpL?=
 =?utf-8?B?NDE1eDBucXpualByS2FNOWhDRCtIMDVTNzBpbEhBLytFR25GQlBKUjhzLzJL?=
 =?utf-8?B?bmovd1A5SFdYT1AwSTV0UWxGUWx4bHZURlhxckJSam9SaVlIOFRWL0ZlVW40?=
 =?utf-8?B?V1UwOVpzOEVkMytpUUs1VlJGS0ZHWDZ3L1pQY1hrdlVWMmNIcHJzSnlYeXpS?=
 =?utf-8?B?OGpyT1FPVkRNWEtUdSsxWEI3RGVPWmo0QVQ4MHI4NDZXWnZDOXUxQnp4Y1Np?=
 =?utf-8?B?ZmZ1SDJzTVpra2NMMTA5dE1MQTBER0V0QVZLRDRkbnNEcjk0dXJMc083S0JP?=
 =?utf-8?B?YVdEVEVFa1lieG9CQm16NUFSTFZUUjlQK0VUR3VpZ1h6THlYYjFFUXp4WDc1?=
 =?utf-8?B?Umc3NSsxVlpVMUsxRER1WXAwY0Vxb3lsbmd5UXhjandLSTlFbUFscXppQTdL?=
 =?utf-8?B?cUgreG5MNnFkeTFvR2MxRWpXbE12SjVzN0VoTW5wVmMvakRMY0JJZzFzUXo3?=
 =?utf-8?B?Qlg3Nk9ZMFE2MVM2cTRQSkhHV0pqaFdjRHNtcEd4U1cxYkFUNEZCN0owY0ZN?=
 =?utf-8?B?V1FUTkV0YWJoTlRYTGlWMnFkcFNIMW1MclUrMmVUYzVpWHZOQTU2eWNqdXc0?=
 =?utf-8?B?RzNhMXNQR1JpemxRVUp2MTc4WTNOdHQ0eWlzSGpsK1llUGtiYTBUcDNDcnQ1?=
 =?utf-8?B?bmJMckROVVlSY052dlJzWnJyUThhYnJpMk1GZUFNamlJZkZTSW9zTmJHZEkx?=
 =?utf-8?B?MnJmb0tqcnNzdkFFdi9tbW9vYlIvc2hSTXZTVlVMUnRGMVZYNThNR2h6aDVy?=
 =?utf-8?B?YTJqYmo3M0UwcDA3Vmc2RytIbnpFODJxMnFhUTBCbGpURmMxZ0Vhd0lMdzFU?=
 =?utf-8?B?RXN5TVhqU0o4SnhYZXRrWGZRTnFsYS83TG94WklOR0o2aEFJalE2Rm04dkNT?=
 =?utf-8?B?MFp3UnBlZ3dsRFVsL2hjOFZYN1RXQ0F6cklxSlRzV2c5aGJiekxmT3VnaGdC?=
 =?utf-8?B?UUlJYTcwY21UYWZvT3VEUWhwa2lhb2o2M1djYk1yb1E3OXFMaFlibTZrRGhD?=
 =?utf-8?B?QnJBK0gxdHhPZGxUVCt4WTFhRURoU0dQWk9VcHVqT20veVAwK1NZMEtKaWd1?=
 =?utf-8?B?dGZFQmJIM0d2QXVZRmFOT0VuSEd0ZVM1WHZReVQva1BpeVRnTXAvNW1PQ1U0?=
 =?utf-8?B?OVVFUm9RMEhnYWpMRjZiOWY5QTJRTFF0Z1pnMW1naUM1WWRpd3FxUmJBMW5a?=
 =?utf-8?B?YVgvNGt0a3JHWWxTMWJrS2I1RFFUZEN6MzN6bnNwNHdRTUtVbmVmQSswZW81?=
 =?utf-8?B?U3UwUjFkYmZpTUJNSEo4QVYwbTVYV1Z3OHZyT1RLMHNJUVoxNXV5YkVKM1FC?=
 =?utf-8?B?Wkx0eG5hNkxTdGxPZjBZNS8vWElKblJKV0FQMWZtVkU3QUZDQTFRMTlIOVJQ?=
 =?utf-8?B?VXVCK0RENFIyS0RUWmhxRzJwcHU3YjdZSkREaWZNSmR6N0t0SnFrc1JVaDlT?=
 =?utf-8?B?c1FFUWtIY0I5Tlk0ZTlQaSs3VGlrR25OcFNycFR5RG9lYnFLMC9QWThqWkZX?=
 =?utf-8?B?dFhKRWJXWEE3QnNsMkhubVBmaDJYVVcya0w4Y2hER2d0YTRTUE1uZEZtcmpX?=
 =?utf-8?B?TG9UU2dwTHNVUDZlVG1mb3dsMDBnaHVXZHBpcC9wR3owQ1ova2FtZXY1bDV6?=
 =?utf-8?B?VEtZWDZhQllTeUVYczh2aXV6UDlzUTJacEY1MEZMS2lVUTU0cnQzbWVEbGQ2?=
 =?utf-8?B?VjBmMmhVbTFUNjNicnZKMUpVbXVjbURwN1gxVk9kaFpXREVDb0hUbjJKRjV1?=
 =?utf-8?B?dW9BbVVaNEljQjgvbHFqOTcwRmtZMnlJZ1kzbE9TTVJ5VGpMdjBUU2g0ODhE?=
 =?utf-8?B?cEtJWDNJem1hamhTMjQ1RWM3YlNjUHFOODJpNFI2ZEZTV29YWnRPSElrRFlD?=
 =?utf-8?B?ZU8ycTRleXp6QXJVbW5xczYxRFhoMXJEQ01NK2dyWkh3dlZ1OXJGT2haQk01?=
 =?utf-8?B?VURsZzhQUjJKeTBmcWxoaFpyY0hxSHIxMW1ISDViV2VVQkVBdm9DREtSY0JW?=
 =?utf-8?Q?NWXw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b0f355-4d7c-4d00-c882-08db8489a742
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 16:44:55.6392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKcbWjWlQvAPzxoDQDD9mhP5LkCz0JK2TKJ7QEDEB1oaJkRxalkAwr9p71f1M0jJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 7/7/23 16:47, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/1/2023 12:02 PM, Babu Moger wrote:
>> Introduce RFTYPE_DEBUG flag which can be used to add files when
>> resctrl is mounted with "-o debug" option. RFTYPE_DEBUG is OR'd
>> with other RFTYPE_ flags. These other flags decide where in resctrl
>> structure these files should be created.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |    5 +++++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index c07c6517d856..5bc8d371fc3e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -294,6 +294,7 @@ struct rdtgroup {
>>  #define RFTYPE_TOP			BIT(6)
>>  #define RFTYPE_RES_CACHE		BIT(8)
>>  #define RFTYPE_RES_MB			BIT(9)
>> +#define RFTYPE_DEBUG			BIT(10)
>>  #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
>>  #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
>>  #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index e03cb01c4742..9e42ecbb9063 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1862,6 +1862,7 @@ static struct rftype res_common_files[] = {
>>  		.mode		= 0444,
>>  		.kf_ops		= &rdtgroup_kf_single_ops,
>>  		.seq_show	= rdtgroup_rmid_show,
>> +		.fflags		= RFTYPE_BASE | RFTYPE_DEBUG,
>>  	},
>>  	{
>>  		.name		= "schemata",
>> @@ -1891,6 +1892,7 @@ static struct rftype res_common_files[] = {
>>  		.mode		= 0444,
>>  		.kf_ops		= &rdtgroup_kf_single_ops,
>>  		.seq_show	= rdtgroup_closid_show,
>> +		.fflags		= RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
>>  	},
>>  
>>  };
>> @@ -1905,6 +1907,9 @@ static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
>>  
>>  	lockdep_assert_held(&rdtgroup_mutex);
>>  
>> +	if (resctrl_debug)
>> +		fflags |= RFTYPE_DEBUG;
>> +
>>  	for (rft = rfts; rft < rfts + len; rft++) {
>>  		if (rft->fflags && ((fflags & rft->fflags) == rft->fflags)) {
>>  			ret = rdtgroup_add_file(kn, rft);
>>
>>
> 
> I think that the first and last hunk of this patch can be
> squashed with patch 5. From what I can tell it would help
> the motivation of patch 5 and fit nicely with what its
> changelog aims to describe. The remaining hunks can be
> moved to patch 6.
Sure.. Will do.
Thanks
Babu Moger
