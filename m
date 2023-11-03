Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA0B7E0189
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347620AbjKCKAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347613AbjKCKAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:00:30 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C59AD4E;
        Fri,  3 Nov 2023 03:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ukggu+FO8i9fpYCG2w07uL++t8EbYeIm0uXOiAw1DMx8dug3YMTxl0eL4VBHS62mnfFmJuEaRCAtjZzfvR8vXRx5cKwBUMGuVRZwFFHsiSwqf35O1+ECgiJI5/DSoxGvuAZOOnuH3HEzuPi/qSv4nqBPlQpHk5uCqpqLSqmdtInWnKnpfcIlRbcMNbQEKhW5RnTrWnTHa1MWGdhI2oyl5OLdGHjeBQyPHWlW8N8rQGqAdkw0cye9Yd3Z/8EDR0dySrtWzsJX4awR1nwBw+6/WV9/T47yBf5tlHMZ/60HNX5dtRlREarVHr6MqGluOM3a4VCBCUC3ijMHwlUposLEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vs8KNNa7JvbN9X54m/HLuW1fC0ZQiI5qAB+PG9WGsqg=;
 b=CAGzvofARNp0jIYp7M5eOM/RIHDyg66MGX9RgoZOcJ+lffo0VSJZ6MOSX0tystNzOJs+sW8S+pusZQR7bR5hKSC6FvTFLkI+KzPm7JGCEDc/DuT5Nkt5hYWUOddvSzggHr8UNFMzLpx/tvWXFdMfpYs5G9V0BbysdesI3AQAD4pV5xOi2zT5Aa8MA8bWcFhBYyVm/jh0F/YNcizB3iAovkncE7K7FhJU0jwf5fgGnSpSXi1EKqjQ9YvqF9rysVbq7nl4EG525Dp0z2URvSY53TbDsUIUGRA38GyLHkQf+bBR02jY/3q7rCEUbH2fW2xerWKVM13sigmXFW25NEz6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vs8KNNa7JvbN9X54m/HLuW1fC0ZQiI5qAB+PG9WGsqg=;
 b=ikboYp//+joqk9Mrg1gAy+hHETJLWSsRZvO6pSFV6he7qwIVOZGPq6Hh1+VbEhURWhEuUS+FfbHcN1oBzt5IjlhWRYFbiBU190BBM/RE/5XOvWb6s6M5EYXD+LnOnaEy1WxCX1lzd8Zgden3MSSrcFUCdNFPiYd83PLEsS+qm+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 10:00:21 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::87d4:680b:51ef:181]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::87d4:680b:51ef:181%7]) with mapi id 15.20.6933.029; Fri, 3 Nov 2023
 10:00:20 +0000
Date:   Fri, 3 Nov 2023 17:59:58 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Jain, Ayush" <Ayush.Jain3@amd.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] amd-pstate: Only print supported epp values for
 performance governor
Message-ID: <ZUTEnneqNcosb/1R@amd.com>
References: <20231103094815.16141-1-ayush.jain3@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103094815.16141-1-ayush.jain3@amd.com>
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b68d36-4c94-4b7f-a634-08dbdc53af56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGIBS5JcACnQWW4zIxGwIgfnCjp+Xbl7K4KMuHz6g4nu6Pgt1t08mUsK4GH0xI+AGZMjrlEU84Ke+WJ2/L9Cov7DPcl7Knkxrr7f/Ox8NNQXLm30QPC8/D1vLNVK1WZL/Jq6C+bcIzW/DBow8ziamVhvV6kd+05mHXTB8WGKPJ4YWR95iOkhGurXakoKN0LAvs0VxnjFNbLIevMxIRflODevXFTmOni5Efy8q2Wie3BXKSbtR7WnUxORJXTXsqm8Kziv1E1bHTPKnY/l9pd5h2wfZs4r0ZF86ry/5mxEHBfzTA877go8l4b872PXJW4H1h6huvTePRUt9f1Z0RjDOEqoruI/BKJKkMyWTgRU/qHCbVJI1bJ4ZRoJP2NSh6dB3Gpd8R77Bv+edldiSFSaWWHrNc2apgkx83/hgYUt14RU8uE5Fej+28hSWXOLNVLfYSj6ohHTJyLmvO+y629DhV9n/pb1qhLpEmxRn/z/8CmZ6KOVTfWp+u9+xBmJHJkpwRpbMiqP1i20/i6rCd10VmO/rXJQ9gvIIuuYeKnrdPQmwTKkepLQiPEdHO52LiPR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(2616005)(6512007)(8676002)(8936002)(54906003)(6862004)(66946007)(66476007)(66556008)(37006003)(4326008)(41300700001)(86362001)(5660300002)(83380400001)(2906002)(6486002)(6636002)(316002)(478600001)(36756003)(38100700002)(26005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vjAA2hMZ+0nUblTqxuD+mhGvb3AWbrxgMJ+88OxpEo4OuTLCtAlV80sajIsd?=
 =?us-ascii?Q?Ro+bHNT9D7GJU+jvp/eUjwcQHps3M9jIF9g1y6/jJhHdTUUTbNA2tyMDXgFD?=
 =?us-ascii?Q?S3BFPB45sMulnfEd7AYoTTe/npoKHk59Al2I/kr/JS82Xs9qhQeFNjRQyHF6?=
 =?us-ascii?Q?7KxSPKNkxcIrko1YwLcYQ80LVuacfpnt/JN9+gEvv6T04OXP1C5wc3esHi06?=
 =?us-ascii?Q?TfPGhpqzggJ9H47b+1IL2pdX0b0h8FDWqMMKZ6DL1UZn6O5WYBo+QNIbfX+m?=
 =?us-ascii?Q?1LtV4Sa9Y9RPj6HR0rv7QmbzCMWLUjz1FDHoaS2PCj9U0BLaCnbT5hHMy4Al?=
 =?us-ascii?Q?cg1q+XtpbtP3aCLdvkk2ktBGo0EzWt0BoJwYX6RmA/VHLuniNBn+9b+dV9du?=
 =?us-ascii?Q?Gk3K6x5lntARr71xMQhrpdHPfznFmrp3wqVlcoR9162zg/1aX/ShbN0dgX00?=
 =?us-ascii?Q?xbfhQahd5J8B8sZwmGV4WLDV3lhiE1ZC8EN6H7F634qEcvRmfIVza/o8SO17?=
 =?us-ascii?Q?nTZEXUJSWx/I9hLsA/98RsSh4voikTsfdY1BxjDS9Uxj52e9QBg1RdwxRTXa?=
 =?us-ascii?Q?uHLNz6t7+rRd9vY08Tt4dZVH/xfKBpFskRP37NkDDs1GOFcTJs3Oe7ODaGpB?=
 =?us-ascii?Q?m1NikH5n86V4sPd4mSYy7Ox2S6Cvcr5xIzPStzEYuzauqyjD7egI4o4pesP6?=
 =?us-ascii?Q?aN2fx8cvFpRP7rNz0w++Toxr4odfMuj+6vwKJQI00f0i6T59cApTZziG1947?=
 =?us-ascii?Q?X9XavBlBjP9qOka3MuM1vZQ4Vw/q7vA7nd+ZnYyhdzZL17MaaaKFjfsCBIN/?=
 =?us-ascii?Q?9FxtLyrmg35O9pUQBs88Iz0qpD8KLuzMJusQuYTxCCagkzvXPKKZIF/nT4W8?=
 =?us-ascii?Q?L7DwfnvPkccRaBRPCInDAkHSEEGobIeSnDmpHw9XaGbvCohumI9zKGaRuj2S?=
 =?us-ascii?Q?O43PKXeET4m/ZIWo67/h6gQ9VW6Q+MYV0UeffA8yRNxuLgqs59rJ0P51bHeD?=
 =?us-ascii?Q?EAFFhzxbmEfwlsyzoKU40+n7v15zHbqoUsIPAkjWO2BHrTZcXgLXTC2L3bGw?=
 =?us-ascii?Q?sMfHeoygnDQ1m+inP59AgK8pnDkI1tI86nMmek7BMwnOjft33nEmWmXLltf1?=
 =?us-ascii?Q?uv7dx+6RauXMqhqKlb2neUHjTPb3rjbBGeEmRFcSIhSFAl77/LlwDVvbVW4m?=
 =?us-ascii?Q?kCr8Zc1Ao2c9rmnajh8AaTz451oSX3F+rqT0JW4MXb8nObc7xWlvEACGUov/?=
 =?us-ascii?Q?u8jlYwJh5biuf4oRLXBlLxSS8IFZ6JmGhdnPGZAtFmyv9HjftvC7CFIx5sqd?=
 =?us-ascii?Q?EmvzemtwdBJBGJg3OWaEwS9yBxTFm1LRwZdNgCLy8Ghx0mftUdur8g+oAkeb?=
 =?us-ascii?Q?UCKYzYiU1zgicrDBpKL6XQeJR9W6/5zvzJ+SpzCO+mPz9tA/599yHY8gYPQT?=
 =?us-ascii?Q?JekhNH5oW7eWN2t4YipJxvlxXA7BnveTjpChRT5ay5oWYzz3Zp4aYEXXT5+z?=
 =?us-ascii?Q?pTqK85yCP2yHT7ROv2k02qTrVGMHW6Mh1keHQRH88SeQtoZLJAJxNDHmub4K?=
 =?us-ascii?Q?hzCC9pmh+pwKColyLD1VvgVoQGMFSQbQghII679j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b68d36-4c94-4b7f-a634-08dbdc53af56
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 10:00:18.6464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYoBIBB5O7FqNS1kvtEdBI22iReq75ZR/0GUChCCiyg9HyBoULZaJ5UE75NnE3npDqa4bWNfHyg5NNiFfNt+lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 05:48:15PM +0800, Jain, Ayush wrote:
> show_energy_performance_available_preferences() to show only supported
> values which is performance in performance governor policy.
> 
> -------Before--------
> $ cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_driver
> amd-pstate-epp
> $ cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
> performance
> $ cat /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_preference
> performance
> $ cat /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_available_preferences
> default performance balance_performance balance_power power
> 
> -------After--------
> $ cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_driver
> amd-pstate-epp
> $ cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
> performance
> $ cat /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_preference
> performance
> $ cat /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_available_preferences
> performance
> 
> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> 
> Suggested-by: Wyes Karny <wyes.karny@amd.com>
> Signed-off-by: Ayush Jain <ayush.jain3@amd.com>
> Reviewed-by: Wyes Karny <wyes.karny@amd.com>

Nice catch, thanks for the fix.

Acked-by: Huang Rui <ray.huang@amd.com>

> 
> ---
>  drivers/cpufreq/amd-pstate.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9a1e194d5cf8..e6c5a57662e4 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -850,11 +850,16 @@ static ssize_t show_energy_performance_available_preferences(
>  {
>  	int i = 0;
>  	int offset = 0;
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> +		return sysfs_emit_at(buf, offset, "%s\n",
> +				energy_perf_strings[EPP_INDEX_PERFORMANCE]);
>  
>  	while (energy_perf_strings[i] != NULL)
>  		offset += sysfs_emit_at(buf, offset, "%s ", energy_perf_strings[i++]);
>  
> -	sysfs_emit_at(buf, offset, "\n");
> +	offset += sysfs_emit_at(buf, offset, "\n");
>  
>  	return offset;
>  }
> -- 
> 2.34.1
> 
