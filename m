Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A641812DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443782AbjLNK6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443752AbjLNK6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:58:49 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5501BD;
        Thu, 14 Dec 2023 02:58:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpVqwSiGcdzj9YaTpWSYKPD5Nuava0RHpfNNmF6v8wrRzMTyUkgD02knbCZZ0XpHkJD6xPQmslHRXzeWHS/u6EEMWPgKJBuj0RwP5hUMTCTVmBGYK5VZQV6mtR/mOiCaq9AgnW7S9RDmXE/nFrQFwHJaRY4cIW3PqlSPNG/nC+tex0002fDAbOb7baIp7BTuOSqbwwpBJcxBlk4TbjTwiqjrwq7aSqpZ+lMecRs0YOK+2QX56pP5dXp/auKoHuTNsfs25xplMoFIfD7LqSuidlLYyQD0cx5sBkA0UGGCuA5tqexD1OW0tHm9cJ1CF2V50rgv7UO5tbmnK4J5m1XL5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ri9RP+cM18P3fCz+8/OM5aQ2K5L88HV1MH9leTeqsg=;
 b=QCrTj1sskXrFtR0PCoOxnj84faJ9fwmGsZmHGBerAS6llJ+dMelO+W+l7PdT/mFHCBmKtVIawSpizbQP1xE8rezlJj5ogye6m6Gm0JedNenzEYwDqPc/LT3+msVjpKBZ35SRrRwgadU9lgo6nKeH9vfu1fMJe4hINe5KJKQXlhu9CA8FZnJ0DZL/XAA+U0KsYUrFsT8RjxaHSLZmeiGg9MxIusiNb/2AGcGtRRPWeIIkm8uZGHwEG6i9Mf7XvsEbeH5SkYl40RuG7rMpatz1VgMdWRyvzy9Eq786SUawCt08efx5H9tC/BOIMcNRXqQbvdc/3D4365+ZRTyDSDeevg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ri9RP+cM18P3fCz+8/OM5aQ2K5L88HV1MH9leTeqsg=;
 b=e+bCqXYVoiBGsNKIqb2aoScrvt1hoc/hS8iSLf87xQCeQyIENgqlQi3i45U80ZX6NBQ9tbw4N3z4t+QoTXrlOHhtgzzxtxtT63odJQcXPOFwMYhEPZbjf5LYi6+nmruY5cXvaSjbWZik2ef02ZorIQIzyGgjGPerabxJuU9jZvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) by
 CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.28; Thu, 14 Dec 2023 10:58:52 +0000
Received: from DS7PR12MB5960.namprd12.prod.outlook.com
 ([fe80::5cb8:1066:63e7:d843]) by DS7PR12MB5960.namprd12.prod.outlook.com
 ([fe80::5cb8:1066:63e7:d843%4]) with mapi id 15.20.7068.038; Thu, 14 Dec 2023
 10:58:52 +0000
Message-ID: <d4cc684c-e4ad-4c73-8ce2-1091b2a733ab@amd.com>
Date:   Thu, 14 Dec 2023 16:28:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] ASoC: SOF: core: Skip firmware test for undefined
 fw_name
Content-Language: en-US
To:     =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
References: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
 <20231209205351.880797-8-cristian.ciocaltea@collabora.com>
 <6e52c5a2-24d5-422a-9a40-a0053729c98e@linux.intel.com>
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
In-Reply-To: <6e52c5a2-24d5-422a-9a40-a0053729c98e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::19) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5960:EE_|CYXPR12MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: da175ed0-7493-4c65-483c-08dbfc93a7f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EqjqGRoznjzqtWjFEPcmHxrcH2aySKTRgvlmmyo6t/SJ7kos45JfNhvGR8qt9x6BLCIYAFUty7TmmD3DBxKdF3vV4k5BsniAzGRZajvqynsZfZhy72ZoSVlJ2EOPiAQc5J+WYun4pFH9RAPpnl3Et+ZIqHC0bFtXTaJVs/E33CK+UIGI08TRRyxjC9v3ubO+YbFmMTOkfvjx03VvjTojjuTYkIHRJdh11HYM9+H2JVYzYLKYdrbEnzrrNlk+OqN9dgM3yYsH/lkKNByQjHtuWbUrgqa1OmStYA81V34FhSci2cqNydMSWAPJvt9mutfb2jxuaKVBCHwrWhkN7gomtVId7eXIvIYEV1FdKk5rruKSjpKBADbFVB5zxRIWi4iX15PV/BuMPnA724Z15Eb4JMM1vgMfp2pCAv4zjPxW1Kq9IvnweYMayouiBoIy7dFlXgYZciOUCu62YHZXE8Gk4m9XPWnzmIoy+kcwMMEZwCzqaZ1bUjmnV3LdoUFKxN/G92HIDzhOA1ZxJIS47gQZXm7dJCF1G6snwrDKbpywOzOVVMyMcTK75ubt9C+Z+otbiyWqZ3C3h4ZxSZD50mZ437xNu1fDm9688DcuhYLaMs+wQBkd91SVsszKxKAhLqxKGjeid0/l4BaR6Ua2DBDnD5+P71mBN1F2UYTvcRwFcp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5960.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(41300700001)(83380400001)(6636002)(7416002)(5660300002)(8676002)(66946007)(8936002)(2906002)(66574015)(36756003)(921008)(86362001)(26005)(31696002)(31686004)(53546011)(6506007)(6512007)(6486002)(110136005)(66476007)(66556008)(4326008)(6666004)(316002)(478600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFUvMGt2VkNoMW5EaG9haDhhSjc0V2V6VWZHNGRnWU1EY2hoZ3lBMFZrem1S?=
 =?utf-8?B?Rm01dUdvSkxpZHJDOG5LelZQMjZOMWp4L0oyNnVwdExDemtZeFhZWEpaZ2ZK?=
 =?utf-8?B?aWFQUjl4cHVxZDU0RDdCak94blgvdkJWWnpDS1VSZjlhUzRHcTNmOHZvMDJt?=
 =?utf-8?B?dVJxbFhtNGNMaTlMUEpKZVhpTnRNVmRRaVpTd2Nia1ViSWkyVzB6WGJRYVVS?=
 =?utf-8?B?MjRWUTFQaGg4SHFSTmVMOTB1bEV0a1IxNjk2UWtDeVJ0eVZRUlRBNFpoRGJm?=
 =?utf-8?B?aTdoeDZpa2txNis0STQ1cEhBY2ljc0puR054ZFJHMHVBcnZoS0d1MTkrTTk3?=
 =?utf-8?B?cXV6SlVTK1NnbWtJSWlZWkpZVTRtY2doWFM2SWJ2WWxqc1ZLMHFVc1g3U1k5?=
 =?utf-8?B?emw5OTBLQjQyaHhBcVJWdXZuK08vTE10dkxFdWZjZ0tkeHJvRVk2NExYRUQ5?=
 =?utf-8?B?blRYdWVEOXZqZXIrUHdmVHR4TlZOTFlNcmZiSm5VTFEyNEZpVkxjMjlmaGxp?=
 =?utf-8?B?TUlYUVpKMlNMUDJMQi9nbndoeFlFQlRhWURMenlaQ3pISlhRK09zbVhWN24v?=
 =?utf-8?B?bVFNT0dpNDZVVUZoWUpGNDVmWHFITnFQL0QxRTN5NVRjNXFzdCtYdFptR2Jl?=
 =?utf-8?B?bzZnRW5VdjFPU3IrUjN2a3pDMEpTWEphb3d0VXFUV0xXcGVYeFI5bm45elFq?=
 =?utf-8?B?VUtnbjltdmJralJaeDFMWEpleEtkRkh0VjFEQjJyN2tLSTNpcUEvbkR4a25Y?=
 =?utf-8?B?RU1MY1FiM1E5d1dUNjRVdWtkVjNRWXdZSUVMeGlKaFd5cGgzVnF2TU1kT2xX?=
 =?utf-8?B?UzB6STVEYWp2Wmo2dFFHY3ptRmRmYkZJb21hN25aa0V0Z2IrUmRabnhHWDFV?=
 =?utf-8?B?RFJiSGhaUE1zTEd2em5LVTF2ak9lazdBTFRqcFpJK291VTFLQzMzOGhVUTFO?=
 =?utf-8?B?YW1haHIrNVc5b1QzZEpEcVJ4c1ovRjd2cXJnVDU0T3p4TVlHSEtqaGtIYkJW?=
 =?utf-8?B?ajB6cmNZYTlFWmpjTUI2UVNEYlRBY2tyYjU2cEp0eHFKMC8wUUhrdHdrRzFT?=
 =?utf-8?B?VzBHMzByMVJYdlgyaGVOMCtOSkd3V0tDNm5NVEdHei9nRXE0QTNiV090TDQz?=
 =?utf-8?B?NWhCblYrUW1wcWZGRzZqRWpRQ0Q1NzFYaG4rZHYyelIwZXpLTy96S1M0YkRr?=
 =?utf-8?B?T1hMNUszbm1HZmc4eTNEbFExdUNwMnhWV3oxWGQraTBIbTdla1l0VWE0cGVI?=
 =?utf-8?B?Z2IxSlEwQThtRW9DUXcvaTN4MVo0RmNEZWlQOStVRU5WVnZhYVlqWUNwYVZP?=
 =?utf-8?B?eDZCOGlndTFVQ1RTcDRLVEdFb0VFOXU1TXJpWkNGaUxSZHR6L0wzNkszWXRo?=
 =?utf-8?B?MWQ4MHh6ck1KeXZ2ZTlTdDEydUk0S1Vva01Sd0NDM0FrZkdtUHJhTm05VXJt?=
 =?utf-8?B?UUxRRUJlZEdiZDUyUzREWmhNOXdpcURYQmRNWnQ1NndhR24xY3VGRHZVL1d6?=
 =?utf-8?B?ak03NDZ4bndxSExmQTg2TE9uS0FYK2wwc2xIejU1NXF6NitaSkZXb3FwOEYx?=
 =?utf-8?B?OEdvMkZ2c0tnTWh1cXhxL0VjeTA4aFp4RkhTVkRsSlpFaFpNVFNibXRRSDkv?=
 =?utf-8?B?ZjVxdWFqTzlUTmRlVEFQblEyTzFMb1g3YmJkMHF6Wkswa3FuUit6Y2JyVGVh?=
 =?utf-8?B?c3hNNkNYN0x2TCtNU2xuWjJmbjlscDVJd0R2eUd2TnI2cnFia1ZJdWJ5T3Y2?=
 =?utf-8?B?TWl3OEJKYjRGZXhnVEhQZU5CV1BUWlNkMDNxQTQ5VGczRllYMkhxeU5TaDFj?=
 =?utf-8?B?K3NsZllhNEhCdnAwOW5xMDZLV0pKK1d0amljd2ppQ3luNW4zYmE4emdITzJN?=
 =?utf-8?B?eitEMFpoMUxNTnNpMFZ5VVYwNG9qcHB3QUxhd2tWY2pLVDZnQ0tLV3pvMFBq?=
 =?utf-8?B?dm1sN3ZOMFhCSzVSVFRwMGtVYVRTby9aeWE3V2VUdFN4cjZkREQ1bTZJRUdX?=
 =?utf-8?B?ajlLaEtNd0hMU0Y4amYyeSsrNEpwdmdaSmlGb1oya3BtQXYyaUlCKzYyekVq?=
 =?utf-8?B?SGZUdzJaeFNESE02TVp4enFHakxVSG1oYWZmLzU0ZVhCZFNvSTIxaHpaMWNI?=
 =?utf-8?Q?gFmxUEPnxyAs9tgPTFP0saj92?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da175ed0-7493-4c65-483c-08dbfc93a7f2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 10:58:52.6354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 216p7278Gm5yAbNScRBGpH7+cxou7cnud+pjSUtXVpaNH2gQieAV2EnqeaSX0wDSo3cU0P/+Sdj5yr/2R5CrgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/14/23 16:18, Péter Ujfalusi wrote:
Thanks for your time Peter!
>
> On 09/12/2023 22:53, Cristian Ciocaltea wrote:
>> Some SOF drivers like AMD ACP do not always rely on a single static
>> firmware file, but may require multiple files having their names
>> dynamically computed on probe time, e.g. based on chip name.
> I see, AMD vangogh needs two binary files to be loaded sometimes, it is not using the default name as it hints via the sof_dev_desc ("sof-vangogh.ri").
>
> The constructed names for the two files are just using different pattern:
> sof-%PLAT%.ri
> vs
> sof-%PLAT%-code.bin
> sof-%PLAT%-data.bin
>
> iow, instead of the combined .ri file which includes the code and data segment it has 'raw' bin files and cannot use the core for loading the firmware.
>
> What is the reason for this? an .ri file can have two 'modules' one to be written to IRAM the other to DRAM.
> sof_ipc3_load_fw_to_dsp()

For AMD Vangogh platform devices signed firmware image is required, so 
split .ri image into code and data images.

Only Code.bin will be signed and loaded into corresponding IRAM location.

>
>> In those cases, providing an invalid default_fw_filename in their
>> sof_dev_desc struct will prevent probing due to 'SOF firmware
>> and/or topology file not found' error.
>   
>> Fix the issue by allowing drivers to omit initialization for this member
>> (or alternatively provide a dynamic override via ipc_file_profile_base)
>> and update sof_test_firmware_file() to verify the given profile data and
>> skip firmware testing if either fw_path or fw_name is not defined.
>>
>> Fixes: 6c393ebbd74a ("ASoC: SOF: core: Implement IPC version fallback if firmware files are missing")
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>   sound/soc/sof/fw-file-profile.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/sound/soc/sof/fw-file-profile.c b/sound/soc/sof/fw-file-profile.c
>> index 138a1ca2c4a8..e63700234df0 100644
>> --- a/sound/soc/sof/fw-file-profile.c
>> +++ b/sound/soc/sof/fw-file-profile.c
>> @@ -21,6 +21,9 @@ static int sof_test_firmware_file(struct device *dev,
>>   	const u32 *magic;
>>   	int ret;
>>   
>> +	if (!profile->fw_path || !profile->fw_name || !*profile->fw_name)
>> +		return 0;
> I would rather make the firmware file skipping based on custom loader use and print a dev_dbg() alongside:
>
> diff --git a/sound/soc/sof/fw-file-profile.c b/sound/soc/sof/fw-file-profile.c
> index 138a1ca2c4a8..7b91c9551ada 100644
> --- a/sound/soc/sof/fw-file-profile.c
> +++ b/sound/soc/sof/fw-file-profile.c
> @@ -89,6 +89,15 @@ static int sof_test_topology_file(struct device *dev,
>   	return ret;
>   }
>   
> +static bool sof_platform_uses_generic_loader(struct snd_sof_dev *sdev)
> +{
> +	if (sdev->pdata->desc->ops->load_firmware == snd_sof_load_firmware_raw ||
> +	    sdev->pdata->desc->ops->load_firmware == snd_sof_load_firmware_memcpy)
> +		return true;
> +
> +	return false;
> +}
> +
>   static int
>   sof_file_profile_for_ipc_type(struct snd_sof_dev *sdev,
>   			      enum sof_ipc_type ipc_type,
> @@ -130,7 +139,8 @@ sof_file_profile_for_ipc_type(struct snd_sof_dev *sdev,
>   	 * For default path and firmware name do a verification before
>   	 * continuing further.
>   	 */
> -	if (base_profile->fw_path || base_profile->fw_name) {
> +	if ((base_profile->fw_path || base_profile->fw_name) &&
> +	    sof_platform_uses_generic_loader(sdev)) {
>   		ret = sof_test_firmware_file(dev, out_profile, &ipc_type);
>   		if (ret)
>   			return ret;
> @@ -181,7 +191,8 @@ sof_file_profile_for_ipc_type(struct snd_sof_dev *sdev,
>   	out_profile->ipc_type = ipc_type;
>   
>   	/* Test only default firmware file */
> -	if (!base_profile->fw_path && !base_profile->fw_name)
> +	if ((!base_profile->fw_path && !base_profile->fw_name) &&
> +	    sof_platform_uses_generic_loader(sdev))
>   		ret = sof_test_firmware_file(dev, out_profile, NULL);
>   
>   	if (!ret)
> @@ -265,7 +276,9 @@ static void sof_print_profile_info(struct snd_sof_dev *sdev,
>   			 "Using fallback IPC type %d (requested type was %d)\n",
>   			 profile->ipc_type, ipc_type);
>   
> -	dev_info(dev, "Firmware paths/files for ipc type %d:\n", profile->ipc_type);
> +	/* The firmware path only valid when generic loader is used */
> +	if (sof_platform_uses_generic_loader(sdev))
> +		dev_info(dev, "Firmware paths/files for ipc type %d:\n", profile->ipc_type);
>   
>   	dev_info(dev, " Firmware file:     %s/%s\n", profile->fw_path, profile->fw_name);
>   	if (profile->fw_lib_path)
>
>> +
>>   	fw_filename = kasprintf(GFP_KERNEL, "%s/%s", profile->fw_path,
>>   				profile->fw_name);
>>   	if (!fw_filename)
> checking for custom loader allows you to drop the next patch.
> I would also skip the fw path printing in case of a custom loader.
>
