Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A07813043
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573081AbjLNMg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573063AbjLNMgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:36:25 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ACD118;
        Thu, 14 Dec 2023 04:36:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3aRKZIXWqHFPRrt4uWBofxJCJB0PftxAbU2bm54J/7r2oXGiULGmWxBJTzInH4r4jN7036Z1aNa8/wMQI7lpxFb8k3viQKPVJK1FUnMh4q2FWhZv6rGwTkMJb5S1ckrd+OEIsxgF8HCp/ORMtIv9CoXFtOu9oNwi+zRLgXqwcc5AD2odw+d8MMhJx9Coj7d6t0ZJ6mjz3//Shrqve3QzbFVbvpZ0F0f/JCNg4bFaMKDbXue2Ll4Yz/Pp0N/+1n7RfGHtO8pTQrhfD2tMLwEpPhGFlUz1397dB6gVOcMCN4Ynl3+uylUJNV85/WQuxdLTqdaQ4SVbt8oB3Czc1HfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnHU1xjT7uPJU2ht56qiH91nbfq7y90jFXaJ0YozpuI=;
 b=kdpKP2BJMyXUWKmmickT6FnEJvJratLP3FRDJV0RQML4/mUJ+an0Ae7SjFoOv29ZM27gjpebLUcqMZL1lUd/6PHF1jSp8ipLaEeyqaVG9zxsb4G8kAyp8/QUf86joLsW59ZS9aMAeyMLXY5yE6+mEGbzBjO5WDqRATX+Tw1PIkTM8rK+ND1YLzM4OlF3rk3jHYrIIfpOEotVwYmwOD993uooz03Nb5BxFSiHu0bGeFRnJnXjC/AWUEpeT958sHCCoBNCpKiD3pUo6nCfvp/frlCCldQoNutR7VK1pEgun0UqgOKR7D+EB5PPBImp8yMXQwRY0a4mMn7cPB6mkYObGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnHU1xjT7uPJU2ht56qiH91nbfq7y90jFXaJ0YozpuI=;
 b=aEJ6n7SeZuHJhDQLZHYR2hPF3Yvr08xVyvC4oO30+0/+empAc92758om69sJEewmJIkmOE6umFTJ2yT35fym6JArCopJESnuiPSzVyNB5Y2F4MtBEbEyZAxwfynSeka7zSaPSh0js8ZtIXJIDxYci4sHpDdvnPRO/XG/DcIfkjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 12:36:27 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 12:36:27 +0000
Message-ID: <6e9bbea9-bd9b-4c98-a3da-73ccd8826872@amd.com>
Date:   Thu, 14 Dec 2023 18:06:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] ASoC: SOF: topology: Add new DAI type entry for
 SOF_DAI_AMD_BT
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
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
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>
References: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
 <20231209205351.880797-12-cristian.ciocaltea@collabora.com>
 <fad8a055-eabb-4087-94d5-9e1de00933e4@amd.com>
 <aa830670-e544-43a2-9ba9-a64f1964a9f5@collabora.com>
 <318470ce-1631-4c46-b425-755c877dda65@amd.com>
 <421128f7-6a17-4be9-a72b-272ea4017fbd@collabora.com>
 <ZXXEsyBUCrBULNgk@finisterre.sirena.org.uk>
 <5095ce7b-13bd-4805-b81e-f7565ab41b67@collabora.com>
 <dea5fb18-5fdc-4be4-9981-a6876cf531eb@amd.com>
 <ca828ee1-93f7-432e-b95d-e67c35cdcdb5@collabora.com>
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
In-Reply-To: <ca828ee1-93f7-432e-b95d-e67c35cdcdb5@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::30) To DS7PR12MB5960.namprd12.prod.outlook.com
 (2603:10b6:8:7f::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: bd13ee88-9a96-44d4-d55e-08dbfca1495b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q21f6zWSJYA/saNQ+UdtdSKbPMf24SKSp4q3D175qBiImOTsunURQlwUYKBhGdyx7XxBer/76xXHDpqQhIfrzxpNQFO0mIKIRgZy1vLGth1CqyKyESawReisPwrQIck4Yz2rrthjHn+6Fcxpobq8nJU5/sPNn3GXdabNtUrW3iQhIsxavRgz4ItTROMKGzZ+JXeyM+4r7Xm7zM9iPoOpQkjqmwDN1vb8zK4MHwKT4o4u7bxSZm0YEO5zcq+cxJyZjbBMWJiDpdrEiVCrC1KgdyZBBAkf/W0Vi45u7ojf/61L/UDw7d4Y/BtS25TZUi501fyjhAyQ8b3g9pixG/hLDdnDJ+gqxsR7XuVIWv6TSsTMOacipUg87tc70MX2HXce9it6wE5XMJg644cIKS+YjGsMY57kYX7BaXC2fCC1claLMCZ2Okfjm/DUkZkzPIhxL5w0Dq+1Jov+P1tkOeDkMA5LsYh11fcBE2QLpIZWB5GZ6CeVXyl/IfIKG/yccErq+0JVGF/kklQqmrVmabr/hqgK7CS3H/l0wB3W7tqqA7q81Z3oSjV9HCMHIojSUZoJR3jQpb/IT50offlSqN0G8nlKkVbGPijNpzsrudT6oWnRetpaUyBrOA3qGFPO6shBbhuToc7SgPR/3r+AlXv8Pcfg5idDIb4SXQeeNDg9BexGA/4WeeKVNGIVPP0D84k8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(83380400001)(41300700001)(2906002)(7416002)(966005)(6486002)(478600001)(5660300002)(31696002)(53546011)(6506007)(6666004)(6512007)(66556008)(66476007)(54906003)(316002)(66946007)(110136005)(31686004)(36756003)(8676002)(8936002)(4326008)(2616005)(26005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGJNVDhvS0lhWFgyNnIyNncrR2RES1VzMUNsSi91RUJtRWNOMnJOaTRwTHdT?=
 =?utf-8?B?SFdDanNIZUxEdjNxSGVtc3MvNmh1TzJnTERZQWlERHZ2QTAzS1oxN0xyTSto?=
 =?utf-8?B?SE9VdEtnc2Y5a0FqTkFMMFpyUE5aS2NwUG5PalFGUVM3b3ZpOEVLSkYvT010?=
 =?utf-8?B?bVpoVDFjbUIrWjZ0ZU40SEFsT2N2THhJZ2lwNUxmNTYrVnRVd09scE5qdjhr?=
 =?utf-8?B?aHloaURaVzh2T2xyajBqZmFJS29CRTNla1VBendBQU8xbmdoL0RhdEhpYi9S?=
 =?utf-8?B?S1lmc2NhV05wbnVueGdDUUlhT0FuN2ZmempkUE5sd08rc211TDNtS2htRXZk?=
 =?utf-8?B?N2xob1BjS0FRb05BYzZycCtNM3lKQjJUYzZOODJXTjFSbmpyU1ZtclBoUDNR?=
 =?utf-8?B?UHRnUTJvaHBNU2dTdTRDQlhGeVYySkhaVzRDT2lLNDdTT0drS08vUEJvNlQz?=
 =?utf-8?B?bFZFMzlFMjh5WlJBMWdEM05TcU04Y0daYVpKSm9IU0s5M2p0OGlJckg5S09B?=
 =?utf-8?B?M3ltcGV1S29CVWNQYUhpZ0t6VmVnNWpmc1RFU2N3Y3NwVnQzNm5pRCs2cGJx?=
 =?utf-8?B?SHFMRUFQV0Vab2oyTGNPa0RjMnlYNkxOU3lmTWYrTi9HQjl3eko1N05PLzU4?=
 =?utf-8?B?dExmbnBKT3FXTThOY1hoNDI2V1pQNmR1ODluRllmdWZzMlZZbzY5enhjSHg1?=
 =?utf-8?B?OEJ0azhVbUZFRG95ditPL0QxdFJnNnVuTGpyMnRVT0M1TFBULzlTSmQ0WTc5?=
 =?utf-8?B?TWxoMGhOWFZYRC9rK0kxVlNtaElRazV5YnhCbEN2Y2gyb1ozWGJ4bGEvdUZw?=
 =?utf-8?B?ZHJHemxkVXVUc2UwZXFHVTd4OVhHU09UMjYrdWYvNXo0dWpHaWZFS1grdTJZ?=
 =?utf-8?B?cy9NNWo0R0ViTmYvMjVJVkl3TDl2VVFQZFJGQ3c1VjNSYWM0TG93SVVqdi9L?=
 =?utf-8?B?eWtsVm91cXdpdE9qY2lkYkMrRGR6QUFCOVhMckFYRGNkQkcxZ1IvQlVja3Bh?=
 =?utf-8?B?L0YwRVpIZnpYcVRLbEh5UkVCbXAyMC9OYkpVcTJEK0tybHU4Mk53REZHUXBz?=
 =?utf-8?B?dnJXQ3Z5Qm45SS9UbzNJdVpSVlZOVFVFL0owSjhyd0x2TldNdnpjLzVBZEdT?=
 =?utf-8?B?YWRyZElYVmNJeVNjanZxQTVQQStaSEdXY1V4L2lLVVp5bUduZW9jUUJEcnNj?=
 =?utf-8?B?STVRQzRnQ0c0NzB4ak5oRmFGaHBkcXFZZ05NV1UvUm5VeFZQSUdHMXl1UWtv?=
 =?utf-8?B?ZVYrVGVjNHA3TjN1eVdGdTVROW05MkNyQWV2cy9sNWEvYndudlhhQzNHQ2gx?=
 =?utf-8?B?cDZhZ1BBVWEvT0xxWS81OWdIaTkyY3FncEVRVU4vU0lzVEliN3dVSlNHRFlp?=
 =?utf-8?B?Q0UzekYwanhjcUVoRXlJajlDeUZBM3JHUEp6YlZzei9LZ0k3R2l6Ylk1blhu?=
 =?utf-8?B?eVVkYkVLc1ROc0tBQ29pbGhwSUx1YWZlNGdpVE1IQ0g5OFRtWjB5NVIwcU4r?=
 =?utf-8?B?NjRYR1lVUFBWU2lzdXNuMlovU3ZCU1RrdkppWVJpMWZXZGVnNnJtbGt1VjZv?=
 =?utf-8?B?MHpCQnoyc2d6WUs1NWR3NUtnUEoyQWxFQjJWU2o1SzVQQmtQSWZodmVoUW9y?=
 =?utf-8?B?Ym1NSHVpaXo3Z2JWeEloMDZqczNPUi9SWjN3TVpnd3lBWlFGNThvY1hkOVBh?=
 =?utf-8?B?dDJ4bEJ5dzJCTE1uRUFRR2tUalBONkZWbWUxS1ZqQWFSUFB2Mm9lK0J4cDFZ?=
 =?utf-8?B?Mm9LM3A2KzdlUjNxdWk3M1VYM3E3dlNaM0U3ODNDRDcwUktDNFhNbFNQeDlt?=
 =?utf-8?B?aGVMNUR5YVNsdW1JY1hHOHlOZXcwbitPWFBKTmNjcWNrR01hZ2NCZjVPbi9r?=
 =?utf-8?B?L3B0d3FOZXR3UUVDejFEUGRJcGE5Vm1KK3pDNnNZNmh6c3RSaXF2NW16M24z?=
 =?utf-8?B?c0Q4YnNmZy9xL3VhdkJWc04xZ1pLQjM0ZERDTGhDckZud2ZxSU5xbFAxOU1J?=
 =?utf-8?B?OW1pak5BSzFTZGlWTytXOUt3Z3lJRTB6cnB3MXJkdXpLNm5DTDQ2V1ErZ3JR?=
 =?utf-8?B?NWNPRURoNFMvczIyWk1RZkJtVytIOVVNZVhwTE5xN3EvUHIrTDg0eE1aNzZN?=
 =?utf-8?Q?GDQ31XGr90aTKsbl2lN+/ycxd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd13ee88-9a96-44d4-d55e-08dbfca1495b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5960.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 12:36:27.0054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBxUu9NVRgetaaJVKwTrRAHvZ6Fhid7j52SMvfO8oI49WPVwxFD1rmtpqItEYD3B8NpIbVIebk3kLsH8/0loTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/14/23 17:53, Cristian Ciocaltea wrote:
> On 12/11/23 07:58, Venkata Prasad Potturu wrote:
>> On 12/10/23 21:20, Cristian Ciocaltea wrote:
>>> On 12/10/23 16:01, Mark Brown wrote:
>>>> On Sun, Dec 10, 2023 at 12:12:53PM +0200, Cristian Ciocaltea wrote:
>>>>> On 12/10/23 11:51, Venkata Prasad Potturu wrote:
>>>>>> This should send to SOF git repo for rewiew, once SOF reviewers
>>>>>> approved
>>>>>> this, again need to send to broonie git.
>>>>>> All the changes in sound/soc/sof/ path should go to SOF git.
>>>>> Unfortunately I'm not familiar with the SOF dev workflow. So it's not
>>>>> enough to have this patch cc-ed to
>>>>> sound-open-firmware@alsa-project.org?
>>>> The SOF people basically do their own thing in github at
>>>>
>>>>      https://github.com/thesofproject/linux
>>>>
>>>> with a github workflow and submit their patches upstream in batches a
>>>> few times a release, however my understanding is that their workflow can
>>>> cope with things going in directly upstream as well.
>>> Thanks for clarifying, Mark!  That would greatly simplify and speedup
>>> the whole process, at least for trivial patches like this one.
>> Hi Cristian,
>>
>> We have created a Pull request in SOF git hub for I2S BT support.
>> please hold v2 version SOF patches till below PR get's merged.
>> PR:- https://github.com/thesofproject/linux/pull/4742
> Hi Venkata,
>
> If this is going to be handled via the github workflow, this patch
> should be removed from the series.  Since there is no dependency on it,
> I cannot see a reason to put v2 on hold.
>
> Do I miss something?
Yes, need to drop this patch.

And it's better to follow the github workflow by creating a Pull request 
in SOF github

  for all sof driver related patches, rather than sending patches to 
broonie git directly.

>
> Thanks,
> Cristian
