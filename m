Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF287813198
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573315AbjLNN2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573251AbjLNN2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:28:53 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D59818A;
        Thu, 14 Dec 2023 05:28:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Feziq4a0aN+YIFwCpvtbt+B9bMWms0MN6jg9fPtO8z1AZNL21zsmEKaeMAZlmxHzgSiNY33K6IImf6yTSwERAfgKePQlC8EKFCzo/g97KHVbPBriDTKVFY0bwTFLQdSllQpG/km+2x3+1W0C9c9GwZzoNp0cGOzIHNrcFKpYI8mqIQV6pyORDIgNh+qFSwN1Ed/UKOL6Ue8GtjkD5b1A/PfYGsWx9h3xQcMAm/F2DmJPgmksYyx14goYdR60y/kf45usTVRMnPODrLWHt/fI5Huqfk3SvY4zOCn1YsJKLdkIrDYUgbtj4jGqQkctp7PtozOk+Nph5lXJV2ZQfXn6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3CdtVzdNpklzmmqx12eiANSaj7hAb4Gr6ocHcwcQi0=;
 b=jRgcYgOcfLyl7j9GPBcf+79ronrVcJb4Ff5lkQO1BLcGORy+d8bd9rmSSVBBYf6FWO0LqpFh/8NGjhhf0UKtvIeA/d1htlagaq+mGn8EDffuKZNWgHF/QhvEmoBvBpSxpvxuizg37SS995/zc8dHY/Y/uwzmHz1ILPMZ7QVCJO+oCIMdpABjXFC9WXUNqF6Pf1xPtrEQ6O4K8xIiNL/kTR2nEmpR3D3F1xn+eGgS590yj0fSm4q6A8Y0q3yaN4pmWP/wHBQpk7MWY7Q7ER4EML7QWrbRFy6vdzwX3+rEyGlpS+rxfxhODyJaf7pd2ryote8d1WTlLzdK0xUbacO/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3CdtVzdNpklzmmqx12eiANSaj7hAb4Gr6ocHcwcQi0=;
 b=kGpdFvdaB936sFLNZ+i4Toao8iw6HQdQjkX+IPLRQusNQs+8lzZlSzQrRIUqAOBLBVPWtKlHd9g/5tii2ss1OPyec8e0/rHltxtV8rwILlQoI8olC6cARUiOg9Ejo9IZ7+r6hsLVTIRk2/E63QCTPCsH4YCNmCHg6rcT7ptIXc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:28:41 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:28:41 +0000
Message-ID: <97d68467-5580-4faf-b94e-7efd030d0a73@amd.com>
Date:   Thu, 14 Dec 2023 18:58:28 +0530
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
 <d4cc684c-e4ad-4c73-8ce2-1091b2a733ab@amd.com>
 <2c09e01b-777b-48ac-adf9-63d61e1a36fc@linux.intel.com>
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
In-Reply-To: <2c09e01b-777b-48ac-adf9-63d61e1a36fc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::8) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd68444-fcec-45d9-7a74-08dbfca89678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FF6Y5coEED84XzXLM+gdRDOn81bjhxGSwdryLugzomzFs1sLClMTD9SMHqKrlakjmUcwCrNXb6+Q4x7eICG5wfcBKLbS4wySFKyybXzpo0ab2BXEWCR5j39eiviKfjFXfk7GVD9QILafhh0JrkobF4fv4nbAy4zGG4RfjomPvVw3Zd1h5wNqVl5rmuJxazpjVAWwS0WTjYRiU78rbYsReWF3fETy7wxL+L46Tua3NbN+MJ1EPVD5p/B+utHGEAf7X8ZqvJGaI1yJ38n++74CgwyUjilAuEw4+AC9Z+G0iuACPl52f+HVNUqiW8k++5nIayYEr34B++EPEtDfPXhvTd8qg9xNjkxmWQCcL+vs7QqDEiPLRKnZ52l6QlDQKUNjfzpleTILrfQhK/O8nOc5JGX2wuorSMxly76KxfiIwDEujrpR4bkBvjYLVLm52uRBiMmUJvv5uApg+8CIPhjLSlpApskoXK6T4tDME8t2NOno7PFkT+87vWUpSvFpozbSTE8P/VY73Rr5qKsMTvkfQMGglZP4/fEttS+ZPtNk2OkkZyoxubEFgoly2dqo8id8O7PvtoPqdfLNAmu7qN1LXOJ5kKoeva2/DGmSKizAgVIqODcdKQzbKPWCGTxlfamDvsDkIG2iBIjrsOEehU8b2zGzHZFIEtEhh4v/VwPQvOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(478600001)(6486002)(6506007)(7416002)(5660300002)(2616005)(26005)(110136005)(66574015)(66556008)(66476007)(66946007)(6666004)(6512007)(53546011)(31686004)(316002)(6636002)(83380400001)(8676002)(8936002)(4326008)(2906002)(921008)(86362001)(31696002)(41300700001)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHdsdnlGZzByaWxGWi8zUlZ0enpKN1BDWVZGTHFiRjFDUW95amNWYmd3cEtD?=
 =?utf-8?B?V3N4TlpyNEJvbFJYeXZxZVlhSnB4WE9VQlVzcktGLzJOdEhqb2hlVHVXNzNi?=
 =?utf-8?B?SHlFbmZ3Vi93cy9HNWthcW93cDdlR2xnNy91dWtMLzBxYWZEemQ1aHZOWC90?=
 =?utf-8?B?TzZwYTVTVlFEM3RlODk5b3Ayb3R0MlRCU2pNZG9FRlR5ejBjMHVucWh5cXhC?=
 =?utf-8?B?SitKRGVzK0RlWng2WGVpVGdqdEpmSGdKUmJpUXhhcTFjcWh5eW0vamFSZmQ4?=
 =?utf-8?B?bjNvS2NnZ1M0cnJIdk51N2hXaGdzTU84Ylp5K0hiczlLcEF6Q0J2akk4RTlX?=
 =?utf-8?B?bHQ2L0c0UnlFNjBKUTdKR3FpQkF5dThqN0t1ZWQxcDBtMlJFK3FMOG9GRHAv?=
 =?utf-8?B?aFVzWEEzeWtna05EVDFhdGhUU0Y4eUliWDdaMUx1NXVWSzNwK1RzQzFOZTRM?=
 =?utf-8?B?TDNBVzRaRjA1dk5SOG02YVRyK1grejJoZGoxS2ZDbHV4RXR5aGpxNVFKYU1y?=
 =?utf-8?B?cHJQVm16dVhvY3pHYlRISG5ndTlHWlc1dXlkdXM0TjRnbmY1MXBYNHBQM1Nl?=
 =?utf-8?B?dUwwTkhiQWhqOTZhZklLT21XcVhWUCtDMDBOOG91WWIybjBKeUFMS3R3VE5k?=
 =?utf-8?B?RW5WeXExRHN6bWJrT2F3NkxFNGYySXNCZHYvRmM4alM0YjZUeVU4a0lpTVdm?=
 =?utf-8?B?cFJVeWVhYTBXTUFoL1RvTEgvak8wVWtrZ2dSMDdtUWl5OXNXOU1IRXB3MnJY?=
 =?utf-8?B?MStLTkRRaXFjQys0dDhYZVVnQUxyaHVLWXoveXB2SE4zV0Y0dVNOZ0FWS2V4?=
 =?utf-8?B?a1JON0VMWWZoWW8zdFFVNnF6bEZhb3dCRnN1V1l4amhLb2NMU2tRMTlTTis3?=
 =?utf-8?B?YURDcWEyMUF5ZDhhc1YwS3J0aFpQODhhbE80ekpCUUUzTzlObFVIMHFDekFl?=
 =?utf-8?B?WFVBemRaNU5sejN1RkptMGhuZUQ5QmlrRVRqbDRwYzNxNlYrV2dGcmI2V25x?=
 =?utf-8?B?LzF4VDZOanpyOTE5T1RZbnVnZGJTL3JjR240Ym10TTIreXFiUTRFRUt2NC9U?=
 =?utf-8?B?SjI4SzZ5blpuUXJoaGl0YkJObWQyMjZteXVkblFvSFRjYklKbzNUeS9PMktq?=
 =?utf-8?B?Zys0RmU3OFRVMHAyUE4yWnRTZ1B6VndFZzhOY0t0ZWxOeUFvUjl1dTJBR093?=
 =?utf-8?B?Q2tFZmVHVGFpdWRWSGpsemNwR2M3d3FiV0NUUGM0MWpXNFVtck5aQy8yaGd3?=
 =?utf-8?B?VXlwdUk0dXN6RE91MWl0QUIvNk5DUlFqR3MyNUxVN041ZWdHYWsxNVFxRjJz?=
 =?utf-8?B?U0pnNHhWeFRndm53TDdKTnZiejNXYmdYdEQydTJsNE5mSzFvYkpXYmVKdncw?=
 =?utf-8?B?OHBQbGt2TnZ3Tml2cDRKNFBEazFVNFEveVpzaStvTUYxYW5DVURiVkJncGw1?=
 =?utf-8?B?K1lXWjRLK2VXa1Q0SEF5d3M1WVFzTjhCdXdBT1VITjlFVUlDUHVOZzFaNncv?=
 =?utf-8?B?eXE4WXU2OHloeFdoMDlueDArZ0RUVFBuWklmL1poQnJLZ2pjdjJHeExUQU1l?=
 =?utf-8?B?aytpZDNEY2oweWd1ZFIrRmdGZCtpdlJXdGZHUWQzdzNJOVB5a3VsQVRycUN3?=
 =?utf-8?B?eTJ0d2tkMjBGVjhhWWdWc1pHYmJmSUUyaGJMTE8veGEvVW44cGVZd1dYb0Jq?=
 =?utf-8?B?OTZlVkJQWFZoZjJFSjNYbVZSV3VzdHRPTmgvT3QyWGlOTHpWSVJ2NkVEMnRC?=
 =?utf-8?B?MU9mMStFcHdtOTVTVG16QjN6NlUrclNLTEpjNzQ2NkFKWVgvaUpIMkxGUHda?=
 =?utf-8?B?U2JEeUtDejQxc0dOVDlkSnN1eENJSWU3WEFlcTF4M09xc21kblB6MlhUU3Jh?=
 =?utf-8?B?bTZVWFZlU2VHRXZYQS90NHBtZjZ5eWpCMkREU3YzOFNUNGVrWjFjSHJwMFlm?=
 =?utf-8?B?U2QyMVVFOTg0NTAvQmZONm5BZVR6NnBET0haRDg4WFNadWRnZTNTczdGQ05O?=
 =?utf-8?B?dXViU3pjbnRTeVlkbXMrMVV0eGlZQVplSXZZdmdYZVY3RUN6ZkJDT0lBME5D?=
 =?utf-8?B?SGhMbEtld0JSVStJazI5N0hCdy85MkJxNFJJNWpSQ2M0bzV5bTVKZnd4Mk5k?=
 =?utf-8?Q?0Qk1RpdtSqLVqdOm9Kutc2jPn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd68444-fcec-45d9-7a74-08dbfca89678
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:28:41.5750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBsuUFH5btTkBu6D16sCG+DtWm7+a4VZ3OUIhJbjufb3QFIUymjF549kJZGXpz7VyiirwIVNI03gKswgW9lneQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/14/23 17:27, Péter Ujfalusi wrote:
>
> On 14/12/2023 12:58, Venkata Prasad Potturu wrote:
>> On 12/14/23 16:18, Péter Ujfalusi wrote:
>> Thanks for your time Peter!
>>> On 09/12/2023 22:53, Cristian Ciocaltea wrote:
>>>> Some SOF drivers like AMD ACP do not always rely on a single static
>>>> firmware file, but may require multiple files having their names
>>>> dynamically computed on probe time, e.g. based on chip name.
>>> I see, AMD vangogh needs two binary files to be loaded sometimes, it
>>> is not using the default name as it hints via the sof_dev_desc
>>> ("sof-vangogh.ri").
>>>
>>> The constructed names for the two files are just using different pattern:
>>> sof-%PLAT%.ri
>>> vs
>>> sof-%PLAT%-code.bin
>>> sof-%PLAT%-data.bin
>>>
>>> iow, instead of the combined .ri file which includes the code and data
>>> segment it has 'raw' bin files and cannot use the core for loading the
>>> firmware.
>>>
>>> What is the reason for this? an .ri file can have two 'modules' one to
>>> be written to IRAM the other to DRAM.
>>> sof_ipc3_load_fw_to_dsp()
>> For AMD Vangogh platform devices signed firmware image is required, so
>> split .ri image into code and data images.
>>
>> Only Code.bin will be signed and loaded into corresponding IRAM location.
> This is not different than what the Intel .ri files are made of. The
> module which is to be loaded to IRAM is signed code the module which
> goes to DRAM is not signed.
> The loader itself is not looking into the sections of the .ri image, it
> just parses the header and copies them where they belong.
>
> if the issue is name collision then you could try to put the signed
> firmware file under 'signed' folder (fw_path_postfix) of the platform
> like Intel does with the community signed ones?

We have a limitation that code image can't be signed during compilation.

So splitting the .ri image into code and data bin and sign the code bin
and load into IRAM.

>
> It would be great if somehow we can handle all of these in core, have
> shared code and familiar prints among vendors, platforms..
>
> Fwiw, I'm planning the path, filename creation to be moved to core for
> the current platforms, but it implies that they do use single firmware file.
> struct sof_dev_desc would only have two strings:
> vendor - AMD / iMX / Intel / Mediatek
> platform - tgl, vaggogh, etc
>
> I need to adjust it based on what I have learned today about vangogh.
>
