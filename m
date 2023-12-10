Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB0280B88F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 04:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjLJDeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 22:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLJDd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 22:33:59 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64FDCC;
        Sat,  9 Dec 2023 19:34:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVHdf6jz5uPozaOI8emBo6S60a6prZeBNie70uKJvj4n1sHOFdLAWCYGWumTOQCPFkDj4pg3dKsao2HDqyKMvhOMga+2z6G3AdXobZMliCxuT4oRE2QjXciVRY8McLvM6zne71YOXmDx9dRyqOT/WjMhQ+WkZI/NqCh4tbikJw7mjog5zBq58x/mEeY0wms/sTXhbC6USmSkwScEWeoFSUPC9V6qH9EjuiDu+QcFqZrV1rBoacTy/KhNLJIo20EtPGUyHmOpDK3/1E2qafj4SRh7mS1acAPcLjZNGNsn6o2nWuwzQ7DQswZuCBFT6Y47VW2bKD2ZCKz5nJp/r79Pzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5I12+B4lkGNYhHWzweJKtLf/IviAw8Uc0DJF5Js2/o=;
 b=lIJvZ6n2HMVeY/U0AVGhvw7KCU7CEy21knxiRyRiGn4qzPJutL1jGQwW88ssPbZcG9wSLNUz3NIshH4h16MwKnM3+mE1ZOJOJ9UgGVCEpBWjAer1Sm4qgPyPTiqzoBrb0umwU+MRb4wjrMijvhaTGzNooZK/6nGfzxCXiFLExgKrwllw0/IzICXAjQ1Z8FV9PLqyt5Gc8/GT9irJ0wV0g1wMd9CM5hrGEqRoaGP7cia0v1zrjJTJdq2zHFwAAYbUARaNpAvdtnlA+VM9+MWydTtGXYaU77dURF8HX8Gq2EKVCs1032x/HHSWfew7T/Ht6epCiw/QPWGyYylbkcp56A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5I12+B4lkGNYhHWzweJKtLf/IviAw8Uc0DJF5Js2/o=;
 b=o/mzRe0DXxstrpYHfKTuRXfCkUyXdIamiuAnb4k9iIh5HZamqGsyaNys4USr0c5DsCLG0E8KSKHMEYpvDiaWf/KyxShtYqCMoGZhd1/r1v3KHh1wKfEU/XOB/VPnD/eOncSCbORbf2Eg9Omk/8QC6pG2+nSpglhJtrYUP//eHdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.31; Sun, 10 Dec
 2023 03:34:03 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258%4]) with mapi id 15.20.7068.030; Sun, 10 Dec 2023
 03:34:03 +0000
Message-ID: <c3a3995b-8fae-495f-9701-62b095692b9c@amd.com>
Date:   Sun, 10 Dec 2023 09:03:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] ASoC: SOF: amd: Optimize quirk for Valve Galileo
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marian Postevca <posteuca@mutex.one>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
References: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
 <20231209205351.880797-7-cristian.ciocaltea@collabora.com>
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
In-Reply-To: <20231209205351.880797-7-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::11) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 4614fb05-83c6-426f-368b-08dbf930daff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQtoHwtOJkl3Lsb1aTZ9rh0LeriPeuCCS/8Dy6434sDxIuaQhuTJhk2+o27dCEp4uxQDCh8ruzfT2WtfGj5F/d5XmMnY5pnTlmIznfcvcqWp1hS6RUs/vPRch51I19weKtvoW9AgBHgmqWKpqCzrJwS+lVbE69xk+BV/yUhXSKyU+xv+eA/m+/TKUO9CDnKP0g8TXxMELVVQYnayJQaygXc4eTWRaN5fC0bzTUPPfymDwLhiddY5aa0wkYG0s12atbrgvLMK1F0NcSPu3xTQfitrMSWxApkNQz3a4RTaplZlZ9PhORl5+Uh3WRumarRUlCxnNntgmWhpioi9sD3DN2iH5QHZL4erNM3FcKsmn4P/8l+mj5U4yjC8oe0PCpCZ2Ttu62qwBY9Ci6+H3V6iZ8Jw/jfjhGYka/5PFoC6EV+raI10teHtAELFdOKm37ZAjWwXXNC2Csbc1Kx1OP0kxIGnuKkc7zSjm2HXLM8jgOrDfsO8CPOvPwYFyViwt7rR9mtC9JGcxdv6lQUuPsG0KU/JUhmxBbGTP/s8lLUbzoDO/YqEfG5/cLVBWxTSTpRQsMKaLnrR9ysAZxuWb6GThvxysqC8nBQbDYdiOk0Sceaqhe0iOgxuHcLQYqJwpD2EVAlMeVoyaWNrFQpKrgeG7DK2BmsK41rj5CcDdQtW0h0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(7416002)(2906002)(41300700001)(38100700002)(110136005)(36756003)(86362001)(31696002)(2616005)(6512007)(26005)(478600001)(6666004)(53546011)(6506007)(6486002)(83380400001)(4326008)(5660300002)(6636002)(316002)(921008)(66556008)(66476007)(66946007)(8936002)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OENQd0ZDR1NkdEl6UWg5OVNWU3BJVWdkemdDcVVFcGNkVHpTUisydHBDSlZn?=
 =?utf-8?B?Tzc4K2xCcVgvQlpLc00zQkVQNlNRakV3ZUF0VWJsbm9ob1JMZUhJRkxMZXN0?=
 =?utf-8?B?L3phUWhnRnRjVWhabjl3bFpJbmszTWJoNHNsai9FT0I1SU04NlhlM090Uzcr?=
 =?utf-8?B?WmswMWp6QUMvMjFCSkd0REFJczd3d0dnenFFSjhVTG11Z0Y1aWQ0RmdMa3oy?=
 =?utf-8?B?VENUcVR4UkI5YkN2OVNtQzlaamVjSEprb2c3Z0hHSVYxV2IwTFRVeWN0dGdM?=
 =?utf-8?B?NlJjRjBCV3c0UXkrOTJYY3RLcFdpREtrQXVkYTAxd0M3UFdBM0NaOUJONmlm?=
 =?utf-8?B?WDA5TVh0TXhGOXNZVUI4TzIxN2ZyWE1yVFFwQW9RVUl1T1lGRnZmcTJmcEFX?=
 =?utf-8?B?cVdHYkZmeFVGc29BM3FITnoyTmVOTmNwS0FZNDdSQ09jK1Rkb0xPWmI5V0Ex?=
 =?utf-8?B?Q2czR3ArQkVlaWZKd0h4czZYOW9tOWVTMzdWT2RDSFdIbzFHSkFGazdtOEdJ?=
 =?utf-8?B?MlNxbHNCajhnM3VsYkw1ZjJKYW90cjMzUDhOOXlFczN4bDZ0K3BiTE5rWUhH?=
 =?utf-8?B?T1I0UmFBcUZQRnVzbUkwNkVmQzdGajFGUm5NejArWktrekpKRmRhMkdBbjRV?=
 =?utf-8?B?R1FGRThVVG80N1JzU0NQZGczQUZ5eGhiQ3NDWXovcWpYMzl4TTlTaEFoMHdN?=
 =?utf-8?B?R2ZkbVIyNjJKNzZIbGt4VEMrdkRZT0Vyc3lSOVgvSE8wd2xHQXRFSE5WTHh0?=
 =?utf-8?B?cmJhT0FYZVo5cVVuYkdaS2FQK0lqV2JxV2svQnFmbjVZK29za0s1UDBZcEpF?=
 =?utf-8?B?SUtGL3MrTTJCZzREZXZmVGlNNXV4NENHMWgyRTZUZUlsM3J2VjkzMGI5MGtn?=
 =?utf-8?B?SlZJL3BKbjJHay9Kb2hqZHVJSklYRzhhRWlKbURpeTdFQWlBYUFwZHZ0S09U?=
 =?utf-8?B?ZWRrSG9PRUYyNXVqS1QzK09INjZLOEZDbkFnTFRYVnNGMUN6V0xzc3lvY0sx?=
 =?utf-8?B?bmp6WTBNbWtNQTFvMVJqVTZpSkZrRjViZXZEclhmTFJLVWRTaWJwTzl5cnFL?=
 =?utf-8?B?Q2oxS1R2SW1GcGVkcnpid1JaYkRlc1FRVDdJV3k3UmUwQjZiSFZ5TWxCWlFU?=
 =?utf-8?B?N3Uvb0xublgyeTVOdGFBWTFCUEdQaHQydFU4bUUxci9VenpiNGlTUjB5WDlq?=
 =?utf-8?B?VU9ibURyZkRtMW1oV1UvSk9nMFg1Ylc1ZjFydmZPcW9OZ3lGVUl5SmwwMXdn?=
 =?utf-8?B?ZmdKYVVWYitEVHg5RUxtZWpyZVRIZlhkLy9sNEFtYi9rMDBnV1ZtOHhHNVlB?=
 =?utf-8?B?MW9oemVZU2MyeWpNWDAyVXdWTU1iWEYzekRQRzZZdm1vb0tteDhka0tGcTFo?=
 =?utf-8?B?WStVZnNLTW5qNlpycXpCKzVpUzZqczgva3c3dC90ZGVYZDdNSHVydHMvRzFy?=
 =?utf-8?B?NHg5eC9nZVdxOFBCaW1IVlFaNGx1TkxLUGowWS9SaXpycmF6MXo3TnZXVjVy?=
 =?utf-8?B?WHg0VkpDK0E0eUFyZ3ppMFpnSEtUdFRTcWczZmNQeUtLVCtWWGZuTHk5eW90?=
 =?utf-8?B?WCtVa2ZGVzNObFJHY1RhQ3c3YXBNRHRLYm9ya2JoN0ltUFJVVmFyZU9Vd1A5?=
 =?utf-8?B?RVMreEV3TlFrK3RhOWpqbHorVXdPelhCeS9uNjQrVllhMi8yQ0lWc0VXeWhj?=
 =?utf-8?B?Mkw2bnhzNTdGMEk1S0hmT0NiR3V2Yy9mamRPdVduU1A0NWZTbENTaEg3THRk?=
 =?utf-8?B?bkxoWjVubTNNWUhtcHBSUC81WHJzYlFFWGRzUzlKb1JLbDFXWTFvR2xaL3N6?=
 =?utf-8?B?cVhIRERtMGdJV1cwZGNBaVRYRUIwV2lKT3RmVjlJb2ZOVXBNOXJHVnZDMkw2?=
 =?utf-8?B?Nkh2Nlh0WXdxT0M5VHBLZ0F4clVHQVBXTmtEOVpMclFBbGxxYVpKazJzdXRE?=
 =?utf-8?B?dVAwWDl4b0lITGh3bmtyTmlPSFlmMGF4TmZsMGJRMm1odUsrOHU1bDRndnhz?=
 =?utf-8?B?bWx1YW1vVnpqem9sQ3dPRk1xK1l5SmNWd1ZCUENGa0t3OHdiY1g1enFLVnZi?=
 =?utf-8?B?eDJVNmMxbXBNSFc3ekdzUHVzaU1JZVJaUWRCVGdHQ2FhQ25RbkNETDR5VU1F?=
 =?utf-8?Q?DrRK6f59FGeOLikhX40wM+ZAc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4614fb05-83c6-426f-368b-08dbf930daff
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2023 03:34:03.4842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAtZz+hZa0yH7EiVLMkm5GjIr1vK0jC1hgiCCyOC6G0idgwklNVuoxtCUfIx7gUrQLQVcS2gutS3Y9mpxWoEtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/23 02:23, Cristian Ciocaltea wrote:
> Valve's Steam Deck OLED is uniquely identified by vendor and product
> name (Galileo) DMI fields.
>
> Simplify the quirk by removing the unnecessary match on product family.
>
> Additionally, fix the related comment as it points to the old product
> variant.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>   sound/soc/sof/amd/acp.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
> index c6f637f29847..1e9840ae8938 100644
> --- a/sound/soc/sof/amd/acp.c
> +++ b/sound/soc/sof/amd/acp.c
> @@ -28,11 +28,10 @@ MODULE_PARM_DESC(enable_fw_debug, "Enable Firmware debug");
>   
>   const struct dmi_system_id acp_sof_quirk_table[] = {
>   	{
> -		/* Valve Jupiter device */
> +		/* Steam Deck OLED device */
If any changes in SOF drivers, first need to create a PR in SOF github.
>   		.matches = {
>   			DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
>   			DMI_MATCH(DMI_PRODUCT_NAME, "Galileo"),
> -			DMI_MATCH(DMI_PRODUCT_FAMILY, "Sephiroth"),
>   		},
>   		.driver_data = (void *)SECURED_FIRMWARE,
>   	},
