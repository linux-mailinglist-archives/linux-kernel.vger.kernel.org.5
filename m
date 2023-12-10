Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340AC80B8A9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 04:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjLJDua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 22:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLJDu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 22:50:28 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A0DD6;
        Sat,  9 Dec 2023 19:50:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fl4BC5yoAiHjTa7uKpeNAW9X1MUZffrf8bfl2HMCd7yzIUxXUjARSOs89sxoQbnrLg6XeQUAPt2vDE3G6yavR8FETxLh+U4oLilVzbQ+dCgf0CPocF7+N/GMsx3VaDTK16NCpMK/n62Ny0a2r+hy86YLACfRQGPnB20kSOksVA9chFVloSjrCxipCv4pZVwXflbtaRcFeuCFz1e9VXBV2gXnnekn4X8c4rSHlK827umBNa6gl6CwtHpuN3P0stic08ROCq8JHFbIGHnxI5MdiKRjAtzl3pc4eOHdeLYh3qjOKQ/kLq1IJS6sp5YVvCcvtkaAebFwDoDWWab4D0g6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RR17e3x27LoTew2HslqvKJLhL9S+1Cxpu91/BSToro=;
 b=fmQwUeTZssEvivuMFo4ZkTOk7FLOwQpKOPxDNj0kdesKmzkRa6RUAiyI5WqMs04QXvTYNzXqPBXiz9Sc4u3qIwTNKaKdWJncPHbhNCeuWqTy+Kf9MxtzCZ4ShZ8YxI/bpdKkNd3u3oLHa3x5kIgSB+26oAtETa0jeDFIbh2yuuDjL8AMBgvBC8wrnStZu41COvWR52y20K9GHOcY7isTCpy2ygCSMnrLVMxdksW6Sfae5Iu1JsHhVx/uhpYy0dfrBwY5cMDOjVhHWt+uOpyD1ymRniO8q8Sc1IDR8nK+wqIFOMq49ZKAjdgWMhhNvIHXmaOWFEBXo1XiRJ1dQLoouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RR17e3x27LoTew2HslqvKJLhL9S+1Cxpu91/BSToro=;
 b=C/Hcp2wEIZ/gOksEHVAA4cuOp2+0ithhjlgKdktLBGhh8NoU9zzpyXli5Zp/PRa+1YhI5BKkCAV9H+bDUQAlIwBLR4ZNjlnBWm/eIhqaoN9AB6bzqZnI7ZMh0WezlyfoX26MiXpLLSL/vm4bPNu+fV9ajoimL2x/XN+vmalTmOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.30; Sun, 10 Dec
 2023 03:50:29 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258%4]) with mapi id 15.20.7068.030; Sun, 10 Dec 2023
 03:50:28 +0000
Message-ID: <6e25398f-9a3d-4cad-a66a-ebe43a723843@amd.com>
Date:   Sun, 10 Dec 2023 09:20:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] ASoC: SOF: amd: Compute file paths on firmware load
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
 <20231209205351.880797-10-cristian.ciocaltea@collabora.com>
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
In-Reply-To: <20231209205351.880797-10-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0199.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::9) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 45487519-768f-4fdf-67e3-08dbf93325f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6W80a7S/n+6t2sUp9AWuffKzfKemofzo+wbkwAs1i2A0PomDk2Meym1GtWJiCIfLgwzL6/BVRpk4hA59PIaBR18o9OpgyZqEbQX/Vbcqej4TCnLubXfRpa44Am/X2d5OT/NMjFDf34Py3RjWnDhSh6BE+I8NvHDkw4veXt9tTAQsHg5RcEAPraibDrPLKXpH9+z11s3/9mOsFuQUcclqTbNXzXkp2mvy0wikiXibnantuD6zCWQMXQHtzh3pQenr49Bii3rHnyG9ImT6ZDp7tEDcSMvTtuZK28arXITMG2FSb30gYesVh0YeDPu4q17yNmz3FRUulY9WSkECCet47AYUfA5vOeV0aze+P9RqPnY+289ZezarXR6O9PGTdtLDjnd8G1WNaIBN70FpxnTiq3HdyJB4XmzjiQPlwXFV4H227eX0J+TLdsQNUjYRpHmaEER6up32AaziWCuXwtEPwk3xpwLuJ1mHtGuwH/C879SDT8/2Ru0t9tlrWMGvO2TH3jaDfMovD/Q8D3x5RQV9jSIV9IdAyuxu5H7PIyk1ozTzX86t59GhiyJm3YuliTlfNT1JEXWKI19oDP6q/8CNtlybtl0GVamjFKm9hWF5z0BM5sZQtAam4bblBfACcTP3fMKITiphec63vubdUQYy/Ocghv4hzzBRwHtwOUQRy6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(6512007)(6506007)(53546011)(5660300002)(26005)(2616005)(36756003)(7416002)(6636002)(66476007)(66556008)(66946007)(6486002)(2906002)(83380400001)(31686004)(921008)(41300700001)(478600001)(86362001)(8676002)(8936002)(4326008)(31696002)(110136005)(316002)(38100700002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVRBWEwyWkYydGl6eElyZlF6WlVDQ3UzT2ROOVBIV3pMclZDeVAwUmozMmE1?=
 =?utf-8?B?TVpHRXk3QlFFelozNzNDQVlEZENHWjZzYWlvQTVKZkg5Ny9pNHhvTjduakE5?=
 =?utf-8?B?WkRRUEFkZXBhOS9Ma29uL3lGZGxJYm5IVXRkeEUxenkxZ3RIcjZUbC9kU1M5?=
 =?utf-8?B?Z0diTHFlM2xvbzdrVXZCNitjcVJWWEVUVHhYYy9MUnFleDRDOXdEODJxUy93?=
 =?utf-8?B?TWIzWXlTMXIwcTR6ZXRheXVrWnFObGtCUHNyOUh5SlhHNEt5WjNwU0pIK2du?=
 =?utf-8?B?bzllek9wRFlVZDUrV2ZBbi9KNXNJMXF2TUx5a2lnV3pVMU5Tc2xCaEpnaWdD?=
 =?utf-8?B?UFhmYjdONW1lZVlSSGExZkphajZWSjRyVWNJMjhyN2YvTy9RVmcxM3JBOHpK?=
 =?utf-8?B?M1BFeUp6TlZLUGl2Y2RlK1pkcFFRUFRTREZnb0g1Q0Z5ek9WalJQUTZ2RzNB?=
 =?utf-8?B?enhvamx1Z0NYak9sL0R2OFIrNCsvMTlSNnlNSEY1ajh3cWlVbXM3YlkzWGZq?=
 =?utf-8?B?Uk1uOFZiSFNMUVUyMEs4QnkxRllNT0pFNXcrdlZGZ2p4MXRCd0FleFcrcmRQ?=
 =?utf-8?B?Q1FmT1FRZmJFOENsM2dWSWdHK2J1VmRXNEV6c0lPT1c1ZHZDOXU3SzJ2ZVhs?=
 =?utf-8?B?V2ZWc2FhZUxieWtvQjAvYWwrL2cyRmxkNDFXdkV6QVpNa3pKbG9TMExHVUdr?=
 =?utf-8?B?NWZRdjU4dzVVSm9uSXNTRXViSVh3MVlTK2YzcFpHN0xCdDQxREdmMlZKWlVk?=
 =?utf-8?B?eVVSM0FIaGJQUzZDMmkwZ1dqSngwMVFNVmFVVUhjZEF0S0hBL2dMN3JtK2lr?=
 =?utf-8?B?bGYxOUpYa0NLRDg1R2dvRy94blZmUnIwbnFPemEwWWQwVzlHME5sdklKa3Av?=
 =?utf-8?B?MmFmSDltcFVrWWpDR20wTE02SXV6YWFPY0tPSlN4aGh6V3VRcWZMYk5mVEF5?=
 =?utf-8?B?NGwwcDM2WGx3M3BnY1l4N0U3ZHdNNVBBRncwRVdwVi9yOXJuQmIveGtwV1JU?=
 =?utf-8?B?ZjVzaERSVnhMay8zbW82QVZncHV1eWMzbjFTbkNtK2NnZmJzeGtyenltTEpM?=
 =?utf-8?B?M3lvUUtQTE96RTg4N2lOQU5Vc3Z3YS9HVklXV3dXc2dFZGUxbTdFNjVSc3hQ?=
 =?utf-8?B?NEx1M2swR1JmcUYvRExsb2o2RGV0Qlh6clU4ZHBPaHZYSHhKOXBuMXkvaWxr?=
 =?utf-8?B?S2NBU3hiZ0s1ZnUzc2FMMUkrK3RQS1RCb0dkaDVSaVJvZlloK1ZyOURmMzQx?=
 =?utf-8?B?ckFXL1RpQmxmdzVYRE5kOFkxN21rNUN0WjNBSmNjblZENWNhenB5MWNZVk5j?=
 =?utf-8?B?d1NzZDNpWlhVV0JFejVONFZicU5FMGhsUkVESTV0Y3JKczRGRXNzeml5R21n?=
 =?utf-8?B?NmhpNUtQNlgycnVPVWl1dGpvTlFIbVZUU0lWSjdjcTg5dnovdlJXTTI1N3Jy?=
 =?utf-8?B?Z0xYL0d5djY0TVc1UXprT2g3MllML0FGVERHbjR3empFR2dpWDlpQXJZOE1K?=
 =?utf-8?B?UExrY3o3NlozUnJvR05yK1Z6MUpYVkhHUFY0OVIyUnNVMTF4S3UwaE5LQm1x?=
 =?utf-8?B?OWRrR2JtbFJzTlFYd0VXR2o5UXpxY1RKUitVa3VqODV2ZGNQUWVTQjRQb3dY?=
 =?utf-8?B?VnZXd0I3Y1kwUFNwdTZVcnVKcFVhY21kUnp3dG9Hdko0WHBhamcvSEE4NDdH?=
 =?utf-8?B?c2xRVDdkdURPdGg2UVhsL1hKWjZRaWxHdHV2T29EWW5Hdm1NbzFjdWhSb1Fv?=
 =?utf-8?B?VXpTQ0pBL3dHSFl0V1A2bnJzYy9SMFk5SHpMcE5KOE5TeG1wSzh5L2ZDcXV6?=
 =?utf-8?B?OUR2YUIyeEp4TWNqMHpuZ0hiM1hmUUdob0txZDBrMDJrOGhpK0wrMlRYZVhx?=
 =?utf-8?B?RThoOFB1bHVobnJhZG4zQ05TSzBWUnZYNzZqS1BIR0lTZDc4cDZ2S3N3b25F?=
 =?utf-8?B?ZkJ2WXFkTlZ5Z1Rya1l6WExsakI1c1NjUzRCbUlBWEhLZTlrQnZmMnRZazhK?=
 =?utf-8?B?bUV0QzdBNkd2NFRsY1ZuclRpRHBjRWh5L2NSVUlUeVUzUVQvQVhhT0pITEtn?=
 =?utf-8?B?eDBsUUlGSzhJSzhjb0REc0p1dy9HWHQ5SmRmWnlqR2ZOSGhEc0s1YjVrazEz?=
 =?utf-8?Q?c5D8X4WfE+SmnxJIy+ltCzBzh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45487519-768f-4fdf-67e3-08dbf93325f0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2023 03:50:28.4996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3ktZPuE9cUde11t/nc0Ox+2seAwq3YDbzDJ3syiLKAaDerqnZDEAzLYskdGa2k1cURW3QAr55rN8Idme9Q3tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/23 02:23, Cristian Ciocaltea wrote:
> Commit 6c393ebbd74a ("ASoC: SOF: core: Implement IPC version fallback if
> firmware files are missing") changed the order of some operations and
> the firmware paths are not available anymore at snd_sof_probe() time.
>
> Precisely, fw_filename_prefix is set by sof_select_ipc_and_paths() via
>
>    plat_data->fw_filename_prefix = out_profile.fw_path;
>
> but sof_init_environment() which calls this function was moved from
> snd_sof_device_probe() to sof_probe_continue(). Moreover,
> snd_sof_probe() was moved from sof_probe_continue() to
> sof_init_environment(), but before the call to
> sof_select_ipc_and_paths().
>
> The problem here is that amd_sof_acp_probe() uses fw_filename_prefix to
> compute fw_code_bin and fw_data_bin paths, and because the field is not
> yet initialized, the paths end up containing (null):
>
> snd_sof_amd_vangogh 0000:04:00.5: Direct firmware load for (null)/sof-vangogh-code.bin failed with error -2
> snd_sof_amd_vangogh 0000:04:00.5: sof signed firmware code bin is missing
> snd_sof_amd_vangogh 0000:04:00.5: error: failed to load DSP firmware -2
> snd_sof_amd_vangogh: probe of 0000:04:00.5 failed with error -2
>
> Move usage of fw_filename_prefix right before request_firmware() calls
> in acp_sof_load_signed_firmware().
>
> Fixes: 6c393ebbd74a ("ASoC: SOF: core: Implement IPC version fallback if firmware files are missing")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>   sound/soc/sof/amd/acp-loader.c | 32 ++++++++++++++++++++++++++------
>   sound/soc/sof/amd/acp.c        |  7 ++-----
>   2 files changed, 28 insertions(+), 11 deletions(-)
>
> diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
> index e05eb7a86dd4..d2d21478399e 100644
> --- a/sound/soc/sof/amd/acp-loader.c
> +++ b/sound/soc/sof/amd/acp-loader.c
> @@ -267,29 +267,49 @@ int acp_sof_load_signed_firmware(struct snd_sof_dev *sdev)
>   {
>   	struct snd_sof_pdata *plat_data = sdev->pdata;
>   	struct acp_dev_data *adata = plat_data->hw_pdata;
> +	const char *fw_filename;
>   	int ret;
>   
> -	ret = request_firmware(&sdev->basefw.fw, adata->fw_code_bin, sdev->dev);
> +	fw_filename = kasprintf(GFP_KERNEL, "%s/%s",
> +				plat_data->fw_filename_prefix,
> +				adata->fw_code_bin);
File path already saved in adata->fw_code_bin in amd_sof_acp_probe function.
No need to get it again.
> +	if (!fw_filename)
> +		return -ENOMEM;
> +
> +	ret = request_firmware(&sdev->basefw.fw, fw_filename, sdev->dev);
>   	if (ret < 0) {
> +		kfree(fw_filename);
>   		dev_err(sdev->dev, "sof signed firmware code bin is missing\n");
>   		return ret;
>   	} else {
> -		dev_dbg(sdev->dev, "request_firmware %s successful\n", adata->fw_code_bin);
> +		dev_dbg(sdev->dev, "request_firmware %s successful\n", fw_filename);
>   	}
> +	kfree(fw_filename);
> +
>   	ret = snd_sof_dsp_block_write(sdev, SOF_FW_BLK_TYPE_IRAM, 0,
> -				      (void *)sdev->basefw.fw->data, sdev->basefw.fw->size);
> +				      (void *)sdev->basefw.fw->data,
> +				      sdev->basefw.fw->size);
> +
> +	fw_filename = kasprintf(GFP_KERNEL, "%s/%s",
> +				plat_data->fw_filename_prefix,
> +				adata->fw_data_bin);
> +	if (!fw_filename)
> +		return -ENOMEM;
>   
> -	ret = request_firmware(&adata->fw_dbin, adata->fw_data_bin, sdev->dev);
> +	ret = request_firmware(&adata->fw_dbin, fw_filename, sdev->dev);
>   	if (ret < 0) {
> +		kfree(fw_filename);
>   		dev_err(sdev->dev, "sof signed firmware data bin is missing\n");
>   		return ret;
>   
>   	} else {
> -		dev_dbg(sdev->dev, "request_firmware %s successful\n", adata->fw_data_bin);
> +		dev_dbg(sdev->dev, "request_firmware %s successful\n", fw_filename);
>   	}
> +	kfree(fw_filename);
>   
>   	ret = snd_sof_dsp_block_write(sdev, SOF_FW_BLK_TYPE_DRAM, 0,
> -				      (void *)adata->fw_dbin->data, adata->fw_dbin->size);
> +				      (void *)adata->fw_dbin->data,
> +				      adata->fw_dbin->size);
>   	return ret;
>   }
>   EXPORT_SYMBOL_NS(acp_sof_load_signed_firmware, SND_SOC_SOF_AMD_COMMON);
> diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
> index 1e9840ae8938..87c5c71eac68 100644
> --- a/sound/soc/sof/amd/acp.c
> +++ b/sound/soc/sof/amd/acp.c
> @@ -479,7 +479,6 @@ EXPORT_SYMBOL_NS(amd_sof_acp_resume, SND_SOC_SOF_AMD_COMMON);
>   int amd_sof_acp_probe(struct snd_sof_dev *sdev)
>   {
>   	struct pci_dev *pci = to_pci_dev(sdev->dev);
> -	struct snd_sof_pdata *plat_data = sdev->pdata;
>   	struct acp_dev_data *adata;
>   	const struct sof_amd_acp_desc *chip;
>   	const struct dmi_system_id *dmi_id;
> @@ -547,8 +546,7 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
>   	dmi_id = dmi_first_match(acp_sof_quirk_table);
>   	if (dmi_id && dmi_id->driver_data) {
>   		adata->fw_code_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
> -						    "%s/sof-%s-code.bin",
> -						    plat_data->fw_filename_prefix,
> +						    "sof-%s-code.bin",
>   						    chip->name);
>   		if (!adata->fw_code_bin) {
>   			ret = -ENOMEM;
> @@ -556,8 +554,7 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
>   		}
>   
>   		adata->fw_data_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
> -						    "%s/sof-%s-data.bin",
> -						    plat_data->fw_filename_prefix,
> +						    "sof-%s-data.bin",
>   						    chip->name);
>   		if (!adata->fw_data_bin) {
>   			ret = -ENOMEM;
