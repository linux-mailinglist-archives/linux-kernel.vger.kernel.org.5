Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7B67537E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbjGNKWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjGNKWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:22:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3994D1734;
        Fri, 14 Jul 2023 03:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QefE2OWtODSkSAHa6Tojk924qPfne75gSZcXUOrRW2873roAoN6qLM0YLKaAYeQ9Z3YX0xtvGw43IjctHnzMiaoW56krPGQ1HVPeuIOS2atfICqRcYpxIXyHtderfHKYxOTR7EJt8WLWH9Fc3hvLvAs1YtJ7BSiIct430iQ+VfcUVEdq0mfwPHE0dT2lhJNyE73OkoqDy7kn5RoWnV/SC7hix+38FQY1qfoAr0hMpuD/gRoa2Rxz9cYwGrngVcgTbnTorAc2C6OLh+wDtM2vYUrZaXV1XqDGVmGzB3mjEDj8LbiXzLHmFuURllerQr4RMqWqSuk1DqNVh0OiS8AdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzULxbxA5NgxZguzHm9m5A9l2M+OsAYyygp0uA93Bpw=;
 b=bW3kQ+s2ueern6JDl4OYC1CNMTjDEwqYBPCJJY3jgHWPsxHROcbFvIZfVxYLXcv9AjuYfNEtNenoENI8vs6aucftZiQbNkwf2G5P9w59uK20Rmac4e1JLP+TckjWgrTD1gyl2AG33QSO18v//dr3l1+qRZaEiqT540tjW4ELnOpLe2cw1ggziIW63UkXQ2zxDTTthWdJJn+a+7PMrmJMZmOJXx4OEA2i8/2yrg0DtVh4dhwUIyoN+JrgR4R4g5PdsEbZbFSwd4FVZhLkogAxXsoutBiEB5aSdrIoAYKgKfZxtNe3RAZJGqiEGdoN8ngBowMfYhFGFowQvPC17eIRkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzULxbxA5NgxZguzHm9m5A9l2M+OsAYyygp0uA93Bpw=;
 b=qozBsr7YUmVOv3nmpW2soynSsyTD0uwtkrS9QKLJUPcVsC3qARxIaZIOfURyhEDERiQKc0ptGX1KphWC9EmhTDSidhZhS0KvUimOsYsTVL8NrI4oMNd39c03veEZ2TfVfB0tuUPyqaiy7kH6W7UGV7aeHuASg8YB2OOSKCw5DC8QilVS+VNOKYqaNgTdsSQSV5YxYZRop6sXNfLrmpkIvN5Zhi99ajwHUtDxCUrRliGWSZqRmi+3mLkmmaL+zfoTOGQrdTMqikPoxAieezQO0r/bTkH3wNmEqKj94UPjrSLx/YHLKwgfXtUKSxHLyzwOA+wzoaI9m7Bd7Y1A8/YaCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.32; Fri, 14 Jul 2023 10:22:16 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::cda5:9fa2:725b:8878]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::cda5:9fa2:725b:8878%5]) with mapi id 15.20.6565.034; Fri, 14 Jul 2023
 10:22:16 +0000
Message-ID: <0cf720bf-ae4b-5780-bda4-5c9bbb2d1d67@nvidia.com>
Date:   Fri, 14 Jul 2023 11:22:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] pinctrl: tegra: Add support to display pin function
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Prathamesh Shete <pshete@nvidia.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZK7BRXa9geC8SAGs@orome> <20230713082106.838-1-pshete@nvidia.com>
 <ZLEZmX0LzwCNvf5h@orome>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <ZLEZmX0LzwCNvf5h@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS7PR12MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: f78bdf0e-e68f-4b78-64a2-08db84543251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXpVVtL4Tjmsox4A9Wg3PG2r5HkvqsLfid0zvnyzI3Pdss3MYZH+e7NHQcGALdyGK+i3KLZnRt5mW7azcpLGOGtRTEd25LtYodag6UA62a5eWLDr/DxSQrr3pRaDTKHOUvobiBfu31nEPiVZNd2cCe4xxjlKO66QDYLVLadrffxu26HXTywiVl5I17l8TuImF+NYWWNcAFnSOe1RMiPwWg4309Ko5rQ3wNmNjjJ8LNR4hz1aWUruyovbHF91OrgINwWfTfDf6O182G20EZTtS5UInqKDbFuDnk9Yfku6MWqnLaEydrf/gGMlYP0ZcpqB9dlGi6iwP72T5/vZIYAnP485ozmg6GSnXbwxo0LeLoV8qiQOp4q2V2PJh/EoJZPhEXav2oy1Gmtv4vSOTJwgRujzc/X6Zi1NEjn9w9QotDrk9mvbIeQMVY32xzaDkTamiBvfvyLa4wk7atAc6BYLlJG2g0C7WtOQff0VWEujgJLVgixUWLEuJc3heAjztOrb4R2JttsjRVXry2Psui98PS0JMj2eL46UgVxAYfk4J9KiU7caLvQnDDOch7bvkqxXwhqZyqrqGxTJ3Awu6rNQ6HVoZbkkqGPa8jJGHKWSh2Zi/267SVq0OIXDRr0bR4ph51FqmaDG8l4JljP1nr/UiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199021)(41300700001)(6486002)(38100700002)(36756003)(6512007)(6636002)(83380400001)(2906002)(4326008)(66556008)(66946007)(66476007)(6666004)(316002)(478600001)(110136005)(31696002)(86362001)(2616005)(8676002)(6506007)(8936002)(53546011)(186003)(31686004)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEZoNWFkQk5LWGh1YytNeUI5QXJEUTJYbkRoRnpxd3pQM1BSdHhGb1RrM29v?=
 =?utf-8?B?RzNncEFVd3N3UmQzZi85UHdWODFvVzdFc0x0ZU1EcW93aUk3OGJqNStTRkhl?=
 =?utf-8?B?U0FxSUYzL0dSemppdEdFWFJudHRLM0RnYWhJNmxsRnJyN2ZtZitWWkpTbkpJ?=
 =?utf-8?B?QWhPV3h6NTcxSE1tZnY1U3BUOS8rRWJMeFhRL2lsazdjRSt6bUdhNjM4bGpD?=
 =?utf-8?B?K0tHdmVtSFhlQmN2VjdVMmltYVQ2UEhabER0dG5xYnFBTDdNODFmb0dnWGU3?=
 =?utf-8?B?b0VZM01maHZUa0NCc2Q5Tk8rSmRJQnB6U0hlWGNiR2JFVXV4SUQ5YXUwZXR5?=
 =?utf-8?B?dlZJUGNPUmo3ZDViODRScGUxUHlxWlJmNUhZSW9IYzM2SVhVaG1UM0JYbjls?=
 =?utf-8?B?dkVnMktZVkpnUjAzWWN2ZVc4M0ZTa1ZBcjgvcGlMRFJGSmU1NUhQUHdpT250?=
 =?utf-8?B?WVd2enhGNjBnSm43YWhOQWhsVzZCSzZscUhyVVQ5alFpa2k3TDJ3NzJxZ0lL?=
 =?utf-8?B?KzMxTWpkeG1IOTUxVndjTDU0K1JnUEdCMGJDc0FxcUwvc1ZyMU0vUnk1dStu?=
 =?utf-8?B?Vk9uOTU0Tm1Wc251UDBNbktDRFNnVUlKTFMzczBmNWJRbUwrWFhpMVBzdmRZ?=
 =?utf-8?B?SytFZnhFNC9OdjAzeTBHK1NmTXc4OWVLYnJtdnBLUG5yMEthZ0tKZWJyTFhZ?=
 =?utf-8?B?akNFc2RDRWxrTHA5S1o5SGpJbzYyL3Ftemw5MFV1RWd5QlVKYU1XbzY3Ynkx?=
 =?utf-8?B?VWVHQjJ2bVdJaGw0RGx3Q09jYlZ6TnBaOVppVjE4TFZyTjl4cWhURnVSRnhG?=
 =?utf-8?B?VWV1akhnSUYwZEVsUEYra3hWOE1zd0ZqR0pzTkhaNlR1cTBIaW1waWY0WlpR?=
 =?utf-8?B?ZXdINzBJRDhiNFZ5d04vK1FhZGxlaWhURzNkMjBERGJPbFdCZm1XbUxQVHV4?=
 =?utf-8?B?VUgxRE4zN1Uzb0I5TTh5NExiSk9lSWNBREQ4NDgwckRIUlFXSFdwUGZ5bDFJ?=
 =?utf-8?B?T1QzNjFCMVdvems2OW5PZFdMbUV0V2ljZVhsR1llYVFBQXF4MUliZGJOUkMw?=
 =?utf-8?B?SVBUNVhWVTEwcUt6TXFjaE15Y3JTOUw3Y2ovNUhaQjVsUmtXWGVyMnJGSGRa?=
 =?utf-8?B?SThmcG9FeStma1FwYUZBR05RS3o5dGtiN3ZqRDRVejE1SmJDaGdZNjBMN244?=
 =?utf-8?B?YW5rQlBlRGRFS2lIbzNzN3BJVnN1b2VPdTAxMVYyV3g4cENNYmRRVTk0VFBX?=
 =?utf-8?B?bTBzRWxJaE10RThHMFhqbE9keDNoSnpZMzRiZXZqdGJOQWcxclpUazU4aWFn?=
 =?utf-8?B?VXN1T3B3bks4c096MXgvcUtyZXVERStxVmVZcEEzcTFTTS9mYzI2NVFLM3J5?=
 =?utf-8?B?M05yRUZPaEhrbmZ2SVdBQ0RNRlpBVytYeHQ5QzU5dVZMbmUzQU5PN0VGL0di?=
 =?utf-8?B?VWxNRDFGWjI4MmdtTkpqSEJBcDB6c2NOd3VGeGExR0JNNngrTmtSeDZYSElV?=
 =?utf-8?B?V25tVUhSazJnK2lTZ2pwL291cWhKc244TnJPN0RPQndYSXVUcVBMN29QRWJP?=
 =?utf-8?B?UTB1WWZlTWF4UUpTcUFLQ1RYUlZxcUdrSERrbU12SitrQmhSYWJPbFRrN3RC?=
 =?utf-8?B?VGVJKzg2T2xaR29xS3J3NHhRQXdEeDRRUjQ0TkNoU28xZlQzbFlQTUJkOUFj?=
 =?utf-8?B?d1oyNEZXYmh4L1RIZ0tsVVozc29HRkdiOVNZcTA3QUFlejhXKzdBbTJqdWV2?=
 =?utf-8?B?cGJPOWVUZWpUVkwyM0dPcXR1aUJvbWhPUXBwTkF0OEZZS0xxRGNXU2RVZlZI?=
 =?utf-8?B?TTlvdGJIcDNqVFdzN2x2ODFUcHYzalh1VEJPdFc0L3AxVjZaTytPdTdUS21K?=
 =?utf-8?B?Y3lxbXBMSm5nRnF2NkRQNHBkVXhteU02VjVuOExNaENGaHdSUU1KZTBIcVpN?=
 =?utf-8?B?Y1dhb2dOMUZRVi9JcUFyMTk0Nkk5U2YyZGx2bnFBVE1HajI4Vk9mR1c5WmJQ?=
 =?utf-8?B?eUdGdW82MmFoeERvWVl5ZUR6WDEvVUdYTEEvZ0x4T0w4ckVWQkVVeGsreDhl?=
 =?utf-8?B?bVd1NTJZbitNSmpkM1RPUmVTZWdISk1PdFc3TUJOYm1GcDBQdjgrM21nUlJv?=
 =?utf-8?B?NXBWd3FVa3QzSzVsTTczMUt6Zys1aFVsMFUxTEhIMXVNWnJBRHVCdWtKVVBt?=
 =?utf-8?B?MGgyTzFvZnFISUpDQU52RTVpOG4vbUs0Y3pJOG5jUFMwM2JER0FJUWNZdWM2?=
 =?utf-8?B?TVRHWUwyYjdrQS9pVEUxSzJGSjZ3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f78bdf0e-e68f-4b78-64a2-08db84543251
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 10:22:16.1470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FfcWtd+KRHDewdfulBhuoiBNEJ6WWTINm49U0Aa0m9V1b7i8jaxXDeip3rE/qJe+uFzyKZaF2u9c84hNMjbSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165
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


On 14/07/2023 10:47, Thierry Reding wrote:
> On Thu, Jul 13, 2023 at 01:51:06PM +0530, Prathamesh Shete wrote:
>> The current function for a given pin is not displayed via the debugfs.
>> Add support to display the current function that is set for each pin.
>>
>> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
>> ---
>>   drivers/pinctrl/tegra/pinctrl-tegra.c | 19 +++++++++++++++++--
>>   drivers/pinctrl/tegra/pinctrl-tegra.h |  2 ++
>>   2 files changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
>> index 4547cf66d03b..4da8873942cf 100644
>> --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
>> +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
>> @@ -96,6 +96,7 @@ static const struct cfg_param {
>>   	{"nvidia,slew-rate-falling",	TEGRA_PINCONF_PARAM_SLEW_RATE_FALLING},
>>   	{"nvidia,slew-rate-rising",	TEGRA_PINCONF_PARAM_SLEW_RATE_RISING},
>>   	{"nvidia,drive-type",		TEGRA_PINCONF_PARAM_DRIVE_TYPE},
>> +	{"nvidia,function",			TEGRA_PINCONF_PARAM_FUNCTION},
>>   };
>>   
>>   static int tegra_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
>> @@ -470,6 +471,12 @@ static int tegra_pinconf_reg(struct tegra_pmx *pmx,
>>   		*bit = g->drvtype_bit;
>>   		*width = 2;
>>   		break;
>> +	case TEGRA_PINCONF_PARAM_FUNCTION:
>> +		*bank = g->mux_bank;
>> +		*reg = g->mux_reg;
>> +		*bit = g->mux_bit;
>> +		*width = 2;
>> +		break;
>>   	default:
>>   		dev_err(pmx->dev, "Invalid config param %04x\n", param);
>>   		return -ENOTSUPP;
>> @@ -620,6 +627,7 @@ static void tegra_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
>>   	s8 bank, bit, width;
>>   	s32 reg;
>>   	u32 val;
>> +	u8 idx;
> 
> This declaration could be moved into the only conditional that uses this
> variable...
> 
>>   
>>   	g = &pmx->soc->groups[group];
>>   
>> @@ -633,8 +641,15 @@ static void tegra_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
>>   		val >>= bit;
>>   		val &= (1 << width) - 1;
>>   
>> -		seq_printf(s, "\n\t%s=%u",
>> -			   strip_prefix(cfg_params[i].property), val);
>> +		if (cfg_params[i].param == TEGRA_PINCONF_PARAM_FUNCTION) {
>> +			idx = pmx->soc->groups[group].funcs[val];
> 
> ... so that this would become:
> 
> 			u8 idx = ...;
> 
> Either way:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>


Looks good to me ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
