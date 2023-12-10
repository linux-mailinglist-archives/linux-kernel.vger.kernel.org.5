Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5FC80B88D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 04:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjLJDay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 22:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLJDaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 22:30:52 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B498CC;
        Sat,  9 Dec 2023 19:30:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9pBaV7eXst3devcb66Q3r0sJKWxTMUhxQ4GufiRR3kmjr55lKQvMvlo87zul+v8Gglgj+v2YUa32Rtp+SIHkRHO1AJPXwGABFF0rX9igZYj6EwJHwZ68STJiHw4i17Oixb0LATqNABS/aLtmfSLibs2hF5/F3AqE1HI4OR2i8EiqPx5ad88Q2qd+VrZcrTDkUGgU2nGLQVX+sYirzoVU0sjzsSCGHTxkiwPav7BCAguI+vODLGb7QBb58MqHre/02sKN0zOFdJ1Nt95eBqvQQOmmlGEfB5C53qjhwJXHkmA1QEqI5t2Pj82mQGSlTjH14YPRq7R5ccSXS1ooDVM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUcHyBzI0t09fk3BwBxrbZiVznRKbDYgYkuHtAFzW8U=;
 b=JLBhG/E3i16NDiPTUREU9LBUWVDE02ivIr+YPQITtFk0oOCCSOAXWUB5ph2QZrYdK/kItBuVrUSnz/b28p5Cbaz4qwtzUfPzM/onu0qBM57LQLUnj7DWptMoc1jL0OmG12ux0MEKpMs4+QMNjVy0XN7hr7RGVOdxNy++ROKZO4hQOFG4ZZApb+LRyt6u6qIkNr8bvtdzSRY5wadxlPxvzG/yiP1YWZ856yC8/ZFwhvs6a2sJ0k+1AhNOdadXCtx7BwMcnODT8fObdEvXbLvhdLKyaR8PvPrHgukd7TgJS6kapLO+c+w94YjRHWXKrEdroypasVr5uj8eiRKFYv0uIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUcHyBzI0t09fk3BwBxrbZiVznRKbDYgYkuHtAFzW8U=;
 b=ejyxqEXsSeyw4TtXIRUpDaJ03h3OogorR6nRLARm3iKO6nz2ZPCxRSHklRAywk24p/SBKG5RkuMfFjhp3UGEZnxzIpyIknd3R+I2xuudPBVWgxwlZHY2nMswz/z+ktx75qw2oD7PTyxYMtKeXlMhW2Rx8NmJV0h5PY5fwN9LagE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.31; Sun, 10 Dec
 2023 03:30:56 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258%4]) with mapi id 15.20.7068.030; Sun, 10 Dec 2023
 03:30:55 +0000
Message-ID: <fad8a055-eabb-4087-94d5-9e1de00933e4@amd.com>
Date:   Sun, 10 Dec 2023 09:00:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] ASoC: SOF: topology: Add new DAI type entry for
 SOF_DAI_AMD_BT
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
 <20231209205351.880797-12-cristian.ciocaltea@collabora.com>
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
In-Reply-To: <20231209205351.880797-12-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::23) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: d92e48e0-ba13-4b3f-4c6a-08dbf9306ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6STiNf1woCTv/RAmoLzc1zaeKCyTl3uvv2gzsCGRzAcmFA1V6Meo6oBZd3By80S2bPQpFBaoBt1Kf4V8qYTr5THPRUf3JNiVlK9kFrkdR1bXqzCds6t/X7SrgQR70kuyDvG/P139XKovjBpbhOKSy6nmSohkErvLVwhxjAQTtm/CepVIQ7A4IJYTkC8LTyCaeURCTGoYoYdVlK6GQ0pnf7/zT0xeANsP3YHUmlTF9hYuWR6no+X1ylZQ4X8BWee4W133o4HPZ8i8pBpugfIKsY5mVOmhYni7ESrICbDRUJ7/YOzUNFr2klm782kTC+UkOMI7DMr9h8xZGkYpMwJ+kD4/0yZtLtvY08OXRYsFgwHmIwZUBE5Mywsr/2Epkn0PdfiJ455it1yWSxHuINsczEpb+7AptpAc+Z+Usd+RstEj647BkpNFlmTUkmcKC6S3XFeYw9TsG5gcdVZwDFsHdh0XFksoiwtCPpGbDoaHTE1PA5zcfmfvZ3x6UGAX7L/+lH1WKhY9GKCW0FGbYg06qV25kVNRfMBBZqGJpXgYsQ/xxsSWZM4DtUjR0F4SURKFZ5S6JlXj0/bRizAmfys9+Dv+XMjI9GnSQGVJTav6vGt5sWA8nicbZ4g2/Bm1+IC3aQymslUV6Nf2G8UwqXe1AEYatDDlgEEGnkagzRlSDFg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(7416002)(2906002)(41300700001)(38100700002)(110136005)(36756003)(86362001)(31696002)(2616005)(6512007)(26005)(478600001)(6666004)(53546011)(6506007)(6486002)(4326008)(5660300002)(6636002)(316002)(921008)(66556008)(66476007)(66946007)(8936002)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzdMN0FLdGJmcjVPb1RaRXdXbUVGTU8ySkhTN1lMZ1IwRHFxSXF3ZnJ0Nm1V?=
 =?utf-8?B?ZG94Z1BNWkwxRElOUG8rL3JhWWlMTzBGVklmaFhOQ2dzVENzUFArajd2RDJr?=
 =?utf-8?B?LzNVVVIyQlhoMFE5QVBmZExLSWRjbzg3YUd6eWFJemlvTWhJbjAza1hhUzJu?=
 =?utf-8?B?S2xRTFpqRjgva2QrdGNrQ3h2SlV4am9Wb0dhMWF1SWdCOGtDcHJEWjE3ajlO?=
 =?utf-8?B?SjRmc2orNW1QNGl4aFpsaEhWSU1OK0RqdFpBWWFhNnc2cE52TXdHVzhOUzZv?=
 =?utf-8?B?b2RjaHg5L0hyb1BJejIwdS9GYitkOHE2QWo3V0RIMy9jUDA4T09QdDdlL1Vz?=
 =?utf-8?B?TkZRRUJpZytJbVJRa2hnL0txWEFNajNMc1UvTEtOR3dUZ0tzbHhCbmxNaXBE?=
 =?utf-8?B?K0dsS0RTMmozVzVWcjEzaFZRVFBNZWdxMURhRHNnWWpyVzRSdzZEMlNVL0g5?=
 =?utf-8?B?eUhrWVExMXBtTVN0VXRLWU1ScGJhRUVDVnl5cVhTZFJDRmIzVzFCc3pHL0Fs?=
 =?utf-8?B?dStMTFVqN2pmYVI4N2RJdFJPZjBPWjJJYXREVlBrM3ZDbnFacUVsM3NMWjZr?=
 =?utf-8?B?N0R1M1VkdVB3MEp0ZFBQVVo0NlQ3bjI3OWZvK3M2R1ZIbmwrRktENllXWmFp?=
 =?utf-8?B?Wk1ZZGJSM0x5M29UZCs3M0JGS010SWFkOGZ2OGpnSWVNeXo5L0k5UTVSZUJI?=
 =?utf-8?B?dTdxbldFT3VkVE1qS21qSDNtYkZ4aDVpOVNqOU5wNDEyTGtXRVF0Q3k3Y0ND?=
 =?utf-8?B?Zm5GNUhjZkFqdTRBQk40VWhIUS9WOWhuazRIOExqR0MzWkdzYml1encvYThV?=
 =?utf-8?B?UlNjcTJsMUQrNTNBRXJMTFVXTThwbk1ta3FzN0dJa0NzK0pHWHhxRGZiT0V4?=
 =?utf-8?B?NGtXVHA1Mk5ReXpLZ01pTVp6RHU3OVNWeFFRdFNHN1g2Ty9LckEyTE1wNURi?=
 =?utf-8?B?enJCQ2paNUNrQjFxZmxhb25DbmR5WTJQaitETzdub2c5R2wvUDE4cHpvVjIv?=
 =?utf-8?B?WGk5eHdZRDBUeE94bWRtQm41dTFjd29ROUY3Nm0vOTUyUUdtYVJobGxBTFVQ?=
 =?utf-8?B?eHVOaVgwTjJRNi9SS2M0QVV0ZnVPZmxicjJwSVJPWFRVUTc4SHFkUm5hbkJp?=
 =?utf-8?B?MlhrazRlcnBGbmJ1c3l6cEcwSi9xMy95UTBvOHI1U01ITjhVWFpUWGMyOHRo?=
 =?utf-8?B?Nk1HdEZndFJ1dExpWnR2ZFpTU2RUYlVjelM5bE1lOGpMQ3BtTTc2TVdxbHlk?=
 =?utf-8?B?YXNwMDRtWGxTVWJ6cjVTUHVEeWE1dzYxd2xYbk44dVdGKzd3d2VrN1hxMlZJ?=
 =?utf-8?B?R1k3eXRNR0RUbnBJRHpUUmQ0TmF5a05uNEoyN1dSK2l1MnpqbVYrTkFlUDVT?=
 =?utf-8?B?dlRQM254OEluZWkxYU1TUmlUMlV2dVI5ZG0yQ3VxdW5BVUFXSnRlTkJVR0Ru?=
 =?utf-8?B?dTQvTytFRXBEYkFxRUk5L0MzMEJuMFVUT1pRZ3VKcTFQU1JXRGZ2L3pPUGNE?=
 =?utf-8?B?dU9DVGVla2xsUlptOHJkS1UwVEZseFlkaWlwSTZsLzBMRFM3QWYwd2NlUFVB?=
 =?utf-8?B?RGxWWS92MjZqSFY0K2JRYXc2T1ZtaTNYL2sxQ0lCMmY0bHBNV0FqZUFKZ1Q2?=
 =?utf-8?B?aWJPd1kxRWt1TTU2dm9SMHFDdHcxTjNxNHltamJGV25PQnIxdkFoSGFYTUgr?=
 =?utf-8?B?Z2RZUlUxSXZJV3pNNGNrcUtTK0QvRE5FSEJEUHVIbDJoSHd3eThWSE9iY2dT?=
 =?utf-8?B?WTNNZitUa1JyV1p5V0VTenRwTWo3Q01YUTM5SGcrQVYrQ2FSUFlyOXI1MHoy?=
 =?utf-8?B?MUI0MDQ4bHdmUFp2dU9VY05TanBvYlZzdmJUb0hGUDRabWhOQUl0QmFIQ3kz?=
 =?utf-8?B?RkRDNUFiTklTbUYzbVE2QVRQVDQ3enAxWUJLNGREa0tOVzlLdHpjT3lYVk55?=
 =?utf-8?B?N3hLYUY2L3hFbW1pWUV2RlpOY2FHSEFpaUE0ckF0RFRkQ0lPOXFqVUJPeVBT?=
 =?utf-8?B?eTV0ay9Ic2ZLakVtMm1tVTZMVm5oR0JzeFhnd0YyeXFTYUZwMnFVc1ZQWXBJ?=
 =?utf-8?B?NVdsdE00c3FyOUlpWTJmbXZWNEh5QmFrek1ZNHdaeG9OSXVOazB1VHEzb0hp?=
 =?utf-8?Q?Z41TevgyNiwifc3nngrAebxyq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92e48e0-ba13-4b3f-4c6a-08dbf9306ab7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2023 03:30:55.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yAhkwoA+/PDQYSWd3jdAxcW92XLeaiY064JkqL9xqOwyUja13AwyNPygiXuhf2KKSi5PirpnkOQZhQ9P8pT8A==
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
> Commit efb931cdc4b9 ("ASoC: SOF: topology: Add support for AMD ACP
> DAIs") registered "ACP" name for SOF_DAI_AMD_BT DAI type.  However, some
> boards, i.e. Steam Deck OLED, seem to require "ACPBT" for the same type:
>
> [  467.489680] snd_sof_amd_vangogh 0000:04:00.5: ipc tx error for 0x30030000 (msg/reply size: 16/0): -22
> [  467.492775] snd_sof_amd_vangogh 0000:04:00.5: sof_ipc3_route_setup: route ACPBT2.IN -> BUF5.0 failed
> [  467.495839] snd_sof_amd_vangogh 0000:04:00.5: sof_ipc3_set_up_all_pipelines: route set up failed
> [  467.499128] snd_sof_amd_vangogh 0000:04:00.5: error: tplg component load failed -22
> [  467.502210] snd_sof_amd_vangogh 0000:04:00.5: error: failed to load DSP topology -22
> [  467.505289] snd_sof_amd_vangogh 0000:04:00.5: ASoC: error at snd_soc_component_probe on 0000:04:00.5: -22
> [  467.508430] sof_mach nau8821-max: ASoC: failed to instantiate card -22
> [  467.511725] sof_mach nau8821-max: error -EINVAL: Failed to register card(sof-nau8821-max)
> [  467.514861] sof_mach: probe of nau8821-max failed with error -22
>
> Add "ACPBT" alias for "ACP" SOF DAI type.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>   sound/soc/sof/topology.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
> index e3e7fbe40fa6..73bf791e7520 100644
> --- a/sound/soc/sof/topology.c
> +++ b/sound/soc/sof/topology.c
> @@ -290,6 +290,7 @@ static const struct sof_dai_types sof_dais[] = {
>   	{"SAI", SOF_DAI_IMX_SAI},
>   	{"ESAI", SOF_DAI_IMX_ESAI},
>   	{"ACP", SOF_DAI_AMD_BT},
> +	{"ACPBT", SOF_DAI_AMD_BT},
No need to create the alias name, we can directly modify ACP to ACPBT as 
ACP is not using anywhere.
>   	{"ACPSP", SOF_DAI_AMD_SP},
>   	{"ACPDMIC", SOF_DAI_AMD_DMIC},
>   	{"ACPHS", SOF_DAI_AMD_HS},
