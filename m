Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1EF7C04BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343957AbjJJTgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343892AbjJJTgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:36:39 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7358A93;
        Tue, 10 Oct 2023 12:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WS0UABy++OvA27+cpagYWdWWMhbLud+HMJLCTFyYjTkkmi/zMc+W5qDR/jKX3BZS3frMVyJqfob4/zA49FapNuu4NvPQm53fK5RMlgEF2STKC6ALfZhfjCwphLuOWs69sW6X/q3O89tZC9R3vbiKHXygo08TpvCP8agy61IXtxvFfRn1TGgwQd/ZcfsYCut/4roVbRXVpxmIEzZgBC6ay2pE/57ol6anWe3anv3tCVUWDlcvdpCraJeVmwEjwecr9si4Jy1UqqQpFiy8U7JIQ/EAXhJ4u2nwKV9T2gisXmQrMuycTpWMlfoz1rw+ZsEqnQSli6hUkk8aj/wfWBt+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iBbhc5XZGiZvErvFECEn1G5jaU0Ypb67jI/pG1Pis0=;
 b=I4RmUX0t8jH2lszpeWeEqrjSQX6mO3/PCcnMMqRYUpS+MUTfXelXlbzOoZNt+SOG6J8mImSpmNekmqbjqP5374A2T728lEMMlB6ssnEajO8vJygnVEes7SIsfTThqFpkLxAIv6v5ugiHQM+bpVztDIJF0mhr7Q0XOWCEGkoQGRVVfmeDGpoXnwHXGey2f4bj+nSVb51yjz3iyClouyO2urVsw3mAfoWWcCgoGSC56t4GmBbkX2BxueNKEWgluWKONVhhDuQ02jWMHiw6rSmxyxKO2+lZlskIUlVJRiDW0rIqDa/d52bIUhWubUW7dUnB6WL9KbJJUQLF9SdCZGP8cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iBbhc5XZGiZvErvFECEn1G5jaU0Ypb67jI/pG1Pis0=;
 b=tVqyThWC1MtXRz9A8EFKHSurOEMFBKjtxwS1BDgPFQYzKGLzn29o3P8X51sxLKOOXe8lkRwzYxJAOL0mQPeQdk9qUJEFUVqGIkqEUmzYPsmOoyUBlpx3aeIfKaHEsogCXH2KZSZy3B1hQq/fCiau+wgcKEMar4MtSwoDNMYGX1LIZskEDN52OKf1YabfARYjNsk6J/mltyfCZMfQnADlkmHRqxz9213U5wAszv7FStRCkEU9wH+GdA3a8nqyf1pu750aVPcVHyrppGNjIYEqyih3VOwAA+huUTs/LKYU74Mf3q8Z+9Cpz0G15+XLQZmaD5D5UCRuPd3/tOhaw17NaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 19:36:34 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 19:36:34 +0000
Message-ID: <0db37cd0-9cb9-41bc-c2aa-0a01c0295ed0@nvidia.com>
Date:   Tue, 10 Oct 2023 12:36:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v1 4/4] hte: tegra194: Switch to LATE_SIMPLE_DEV_PM_OPS()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        timestamp@lists.linux.dev, linux-tegra@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
References: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
 <20231010151709.4104747-5-andriy.shevchenko@linux.intel.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20231010151709.4104747-5-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 8552ffe6-e341-4c89-35ea-08dbc9c8364a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O/2oe5jaUBBzc/OeMviWrB53qpqF9H2pxkEokKZRo1QjgmnUtoyssRZdVBdyr/1KTp9hLp8h5vigPppeZW5QWt74VgQwRXFT++7tDU1XT857eQCuzCU6Z1wzF8GoNd4Dpbmpnhkc0ulRblY+Pqal6N15ZeGsSNQPW6huV4VsrcVr77WP4Or2koCRtP1irk4BpTY+UpSBg6Gt/FS2ghO+Zfv252DAUMDhJUD2eF3iYSyJKffRqrc0DFeRSVf0GmLejSmMiNEEIPGKRJb2paZfndRJpKLzOMLqmDfDxapfsVhADakZZQPTRB5QfKymYbrOvANVidBjqQ2VMM39IxMcd55VkSzMAYBZSG4OLQMq0ie7VA2PShO/8JqV7KQ8VLggiSCSa9Inq/mcZR6y0UKDefyBFVjVroihNJromVugHkbBhW7Om1yA+Bd+7Bl/iXbuo2Y/DVSJR4undEd3/PvtPA4iQrcJkIlLzbNiMN8K/wHc7bV4DkITh5/5PjsL+ofJVfMFicjlVIKrT+bLI7M7e9W36yP5PYi3vzNVLgKfRNionjYSZiSjye+jIPMirO9XQy0uIlEfBBWcwEH/aE907Y7K+S8MP4WseUKSGnRbaNVFXhlc2ydVezzHwSM/IL73S4Za64OGBNlx8VdbKcUJEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(376002)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(107886003)(26005)(36756003)(53546011)(6512007)(2616005)(83380400001)(2906002)(86362001)(38100700002)(478600001)(6486002)(6666004)(6506007)(31686004)(110136005)(66946007)(316002)(66476007)(54906003)(66556008)(8936002)(4326008)(8676002)(41300700001)(5660300002)(7416002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHpXVEcyQlpzcnBrbVlBcjRSaGt6dmhJV2d1bWsyTmgyNTZhM0R4SUZ0bXl2?=
 =?utf-8?B?RnpqNzc1Nll2aWdkNzRUZ1ZFVWpwaDN5Z0tPZExvZjljMGhGL0pDcGNRT3dB?=
 =?utf-8?B?RVZGUnVLM0VsT1dzbzE4VUwzQWQ3aWt0TFRiZk5BWjk1OUZ0ZVJVWW1jZVAy?=
 =?utf-8?B?OXRFUGNIbFdlYlJLZG9YeDdMWDlJWTErY0Z5WW9ieW5Hc25hYTZ1NDdtbWx3?=
 =?utf-8?B?WkJIQ0w2eWl6dEIrV3NMTWJ3RC9GOWgrUHJqZlVGMFg5YjdtWi9zMlYyNDc4?=
 =?utf-8?B?ZUNSaDZndnVWMzN0RlBqOUE3QWxSbUU3MjJQSmFnUGZDK0NUcVNya1RwMENw?=
 =?utf-8?B?WjA4SjFucDBmaEVJc21VcEpKNlczMU45Njl0MFg5TUpxZ1RnOTg0TEtBKzho?=
 =?utf-8?B?dDRRQUlGU0pnN2laUzB3d0pxSmppN3lvdVlKR3M5bkJUM083U3ZWd2JUbGdD?=
 =?utf-8?B?Vng0MEtRdDErWUtGZEVnZHlWQ2xqSUhKQjAvbGVkeWtpYUdVeGpNdmV4VFRs?=
 =?utf-8?B?bkJObm9HMEo2dlRVVnczelo3THhJVTJzVkI0dmZFYWFqVHFFRURRVXpybWNB?=
 =?utf-8?B?cGZUQ0hHYVdxS1A2ampEY2ZmOVJJYk9hRi91WmtQZEszbjJTUzZBQk1zQ2ll?=
 =?utf-8?B?UzltY1k2OHE3K1pDMWVJRUFRbktKd2dTenF6aVVta3ArUzNRS3BQblRyN1c1?=
 =?utf-8?B?REFpNG1Beko1RktNOC9SSGNjRG9CT1ZPbFN3bHE2YVliUG9GQzNqZDMwRUhC?=
 =?utf-8?B?R1JkV3g0V1doWFpqUjIwcGNaQ3EwbERJUnBiQ0JSWks3NkxrQUV0dHBWWGVT?=
 =?utf-8?B?UXhuNU9VTHROYUpua0doRHZnU3hXWkxCTmRrcFpqSkpVeDVOaEczVExlcGVq?=
 =?utf-8?B?TUpGa3VISGxLR0ozN0FmNWxKRjVINElqMldFQ3NWQnE2VDNYZ1lnWkJVRkpD?=
 =?utf-8?B?L3ppWEZNWDZLcFFySTZFYXFVbUVKaGVQVURJeDZlblJEbUhONzhBSUZMOEx3?=
 =?utf-8?B?TkdQTFpPczVvb3d3MktXZ3oycmdONDRzZDYrSHRzeHk0OEl0a28waEFoY3M1?=
 =?utf-8?B?REFhWFBSUXFZdXlkRjcybGdGR0piWVBYRGlkbm1UL05QWGNZSGVRZkphOWdR?=
 =?utf-8?B?K0hTbXFTM2NSV0tJS1hybFptRm1sS0xmai9RNDhEK0htSWVpN0FTRGF3NEhz?=
 =?utf-8?B?Q045dnZvTWNNN3BweVlQaHZrWWpiK3VqTWluV3NVYmZjQXpNN1ZrUy9VQzN6?=
 =?utf-8?B?eU9uVkhpbDk0UHhSRnkrWEIxY1haTEVacklTNWZ6KzBqZVFRSm9FdDhIc2Ju?=
 =?utf-8?B?TC9KMXZ2WXN2aVI4a1N1YkZxR0E2dzR1UmFmVEZJSThSUDJwdUx0WE9EMEZV?=
 =?utf-8?B?eW1WM0lnRTFkL3BZUDMySGlRY3ZqcXM1Lzdib2k0MDRhMjhTZUgzbFkwYmNC?=
 =?utf-8?B?Yk9jam9aZDYxdGZVN1NFRzc5NFRaaDNyekpxbWs0YU5HMEMzOG03cFl1WW5h?=
 =?utf-8?B?ZWRMQzhET0RXYUNDSkRmSm1lUGE0WlgzM1ZyQlZyajNJcXJ2eE8xYzVsM1FQ?=
 =?utf-8?B?aHlNbmkvYVFJWlV3K0tMSG5CSGtsd3BLWGl2ekl1ZUQ1M0hUcUlmRVJMVEEx?=
 =?utf-8?B?bUVzT3FyN1JzOXloM0hZdzVlZDB2RG9ZaDFqSGdyR0NRODMyQjdmcnV3NDk4?=
 =?utf-8?B?K3RQalVjK1Y1d0lnYXZUK1h4TE1kNkV3OUd1c0loZkxjMUUxcld2QWJnSDFl?=
 =?utf-8?B?SmVXejZ6OFo1bWo3QUtVa1NxR0RLNVM5MjZwcEFjQjlCY002UUhMYmZDRDNC?=
 =?utf-8?B?STdNSVNrNmxNR3lYdS8ycThwTmQ4VHRPOUNndmFUaXdKeEc2OUlrRjNUSGdS?=
 =?utf-8?B?aFBlc3hFWmFaMnZMdHdIam8xYmFoM081bG1ENTRuYnZiK21UeW16OUpFb3I4?=
 =?utf-8?B?eW5EV0w2R1o4dWhKck9FbklaVkorTS9EVlBJWjBnZzl1amVJUzU1WlQ5TCsr?=
 =?utf-8?B?cUFPdVgzR2p3N0JkdE14c0tQSXd3OWNLU2lHME5IaXpGTzhUekFaUHpHbUlD?=
 =?utf-8?B?NVRncjJUcE11eERTWGQyNDQzcUI1eWVxVXc0RndJUGxkb0lqMzdPczF3NCtN?=
 =?utf-8?Q?rpSDGaFcB8Fna6AFig2X6agmf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8552ffe6-e341-4c89-35ea-08dbc9c8364a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 19:36:34.6174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3Y+Uu5leruoJuBj4v3OaM2LMICERVJ588ECJpG0/xKQpNzkgwLmeCpsC3mu6yg8A+o9zRW+NigJQ5uODsUswg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 8:17 AM, Andy Shevchenko wrote:
> SET_LATE_SYSTEM_SLEEP_PM_OPS is deprecated, replace it with
> LATE_SYSTEM_SLEEP_PM_OPS() and use pm_sleep_ptr() for setting
> the driver's pm routines. We can now remove the __maybe_unused
> qualifier in the suspend and resume functions.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hte/hte-tegra194.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
> index 30ef1750a9fa..30fa7c0a555e 100644
> --- a/drivers/hte/hte-tegra194.c
> +++ b/drivers/hte/hte-tegra194.c
> @@ -815,7 +815,7 @@ static int tegra_hte_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int __maybe_unused tegra_hte_resume_early(struct device *dev)
> +static int tegra_hte_resume_early(struct device *dev)
>  {
>  	u32 i;
>  	struct tegra_hte_soc *gs = dev_get_drvdata(dev);
> @@ -836,7 +836,7 @@ static int __maybe_unused tegra_hte_resume_early(struct device *dev)
>  	return 0;
>  }
>  
> -static int __maybe_unused tegra_hte_suspend_late(struct device *dev)
> +static int tegra_hte_suspend_late(struct device *dev)
>  {
>  	u32 i;
>  	struct tegra_hte_soc *gs = dev_get_drvdata(dev);
> @@ -856,15 +856,14 @@ static int __maybe_unused tegra_hte_suspend_late(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops tegra_hte_pm = {
> -	SET_LATE_SYSTEM_SLEEP_PM_OPS(tegra_hte_suspend_late,
> -				     tegra_hte_resume_early)
> +	LATE_SYSTEM_SLEEP_PM_OPS(tegra_hte_suspend_late, tegra_hte_resume_early)
>  };
>  
>  static struct platform_driver tegra_hte_driver = {
>  	.probe = tegra_hte_probe,
>  	.driver = {
>  		.name = "tegra_hte",
> -		.pm = &tegra_hte_pm,
> +		.pm = pm_slee_ptr(&tegra_hte_pm),

typo, pm_sleep_ptr instead?

>  		.of_match_table = tegra_hte_of_match,
>  	},
>  };

