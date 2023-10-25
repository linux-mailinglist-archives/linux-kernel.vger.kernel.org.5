Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73D07D619D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 08:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjJYGZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 02:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjJYGZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 02:25:05 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241C2CC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:25:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjBTFHQfJhHAVdrId30EW4jzxzl46BrU4+V5twBnIkFZtVrAjOMMK9MpSiGD1wIddsm5glYoeAmk9g4uNJmF9jAq+/Y309StOv9cF21iFT6o0TGYboopPEaZaQj9VFCPFJYULpNeqqfFv1YjnTRYy30xBi5k/OX9n1esu0y0U8mf2fhrnyHnj7WWYwNn7griT6LU2hETxCYptDZ9KW7XkKO2RiV8YJsVi5YpNG5swTxjWGHHMH91aWigoIyXU9u/EMYSHq/es2b1POd3SddFbjD/0xgTHbmXbao/5X7N12u+97QB4qFVNUcmbX8uiGc6Sr4lfrBEfrm4JplvmGT9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VE1iH8+0eX0qSCncco6jXdOI6KaClAUpdkKps8bITVE=;
 b=csZ3C0Z1p8rmfsX9xb1DIk5yF+yKoNaled0Q195OohSme6Mnni81NuHhEhuuuycEke60zkmxZLtK5Zjcwfh2TdgF5LonE4qviXA2LJLgeFwtDUe4vHza5SO+bcPSC3pXbH/DkhAJi7s/9+ADsCVdRbDej2eCuXarR0NiDegaeRnBKZJc5udvmw7e+ytBHGqwmo0c9GtLUU2ZwA1SMkkm7CzVTA1dBiHy8XLg2dvRKHDT0TFS0xiKvqUOXdZul4kl4yc60ubOFpzM806WB2HgybnYpNw8dWTW4O0/nNg68yqNBS7Imqg316HCLgHU+74xQXrVsIL8fxqulEjqoG8NaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VE1iH8+0eX0qSCncco6jXdOI6KaClAUpdkKps8bITVE=;
 b=U0U2Iv3vwp5+aQeI+5BYYoeyuAlLF+muE8y6uuB22bR/1/dvtTMXmff0vCz12xi6fz9lhwerP708d8LAP1XQyeqNF0z2kEmlzxKCdg7C72O2jWSAOVTVA2qilucktM5PmayyS+grinqerruF1R9hB465/QlcACB7TKGTelrhvuA2EwdkgSwyQnOGUEsc/vefxSG/Rlmhd08tZa4PXPMkYruIjkhwBhrtyhJsudwQetUlE+kOz6f+FoVyjiJpCDeSWFldD1VBN+UG2QAc1opNA051aMfJrkun5Z8Q4r8GESU2jOmCDbLBj112cMqx/jIdzu0mErfyx4RQ2STMtdgH2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7432.namprd12.prod.outlook.com (2603:10b6:303:22d::9)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 25 Oct
 2023 06:24:59 +0000
Received: from MW4PR12MB7432.namprd12.prod.outlook.com
 ([fe80::9511:61f5:8e32:b30f]) by MW4PR12MB7432.namprd12.prod.outlook.com
 ([fe80::9511:61f5:8e32:b30f%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 06:24:59 +0000
Message-ID: <a97fb789-ce3f-44bc-ab0c-797d18cd2cc3@nvidia.com>
Date:   Wed, 25 Oct 2023 11:54:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/memory/tegra/tegra186.c:74:49: warning: '%u' directive
 output may be truncated writing between 1 and 10 bytes into a region of size
 6
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Thierry Reding <treding@nvidia.com>
References: <202310182004.0XOYolzI-lkp@intel.com>
 <1046b929-8eb6-43bc-9660-a5a1a43916d8@kernel.org>
Content-Language: en-US
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <1046b929-8eb6-43bc-9660-a5a1a43916d8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::20) To MW4PR12MB7432.namprd12.prod.outlook.com
 (2603:10b6:303:22d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7432:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 0663280f-0ef1-486c-4b80-08dbd5231cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11hhaWX7b/1NkW37xo16kWIrdHdz3q0SrIHmlThpyi/TyhJiXvyaSq85IT9kHtrs5JDavEgRnN58Zo5s20LXaGmmXLsjZEjzqfZdgOyiFYV8DYlkLBH7f5CAnI3BmR90+5PltaW7NJ6PJjUUVsIJF2X1upMbBAgj5EijsEzKSFR+oB1PqLHWwu+sNhO+uN8ZFH/TXX9350scGmftIWQ5mdqo3gFUBehifIbSERxiH7Eukwbl48n9OdLNeWlNYBShuxsmr/OUgQXEmafZCT/6YpGHkazOQGn/Bq8KuYwfqllezQvnOIHjxsd56O3tjOiZwOKwaw2acNZQx47GP+yE761PLMpbfBeIMhtMPhUE+aSSyYG9T7LPTxVK5IIO6Aws26oHaPkC5bQ//tmYSpYDGnEuPsuSzxvVhbOBjdsMnDT9VwQ/+EEuDv07gfl1caqW3mVQlikF6nFCgbQVynFPvWN8xhMryhQUB+rdfTZoOx2jXrQzwTfy/uyT7L4lmp2i5BrTOAxCko93OD0yuI8Ewweeq0xbdg8efNFYWQcVIGcpZESjYH1WxK2DaRftljh9wUfHBnOIxMIAkV35zIbuHxRbcbLsvZzzFxNj52+yYFJ+rZOoO4OQILyZZlKbMQjzapkni7WzL8BJvYeR3cIgNHbR3DKbEQxlO+r7LdiHlshrcgDN4533OQ2BYDjev8/a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(66946007)(66476007)(54906003)(66556008)(316002)(6666004)(53546011)(110136005)(966005)(6486002)(83380400001)(6506007)(6512007)(478600001)(36756003)(4326008)(38100700002)(86362001)(2906002)(8936002)(41300700001)(31686004)(26005)(107886003)(2616005)(31696002)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em5vTjh0akYydm1RRm83enpxRkkzNmZRZ3hoRDdUV2Q4Z2llbk40T3hHUDNq?=
 =?utf-8?B?d1lMeEU5alVhN3Z5Z3MzOStuMWVpSUxUQXRLMzFORjZYUnBCYk1OVzh5eW55?=
 =?utf-8?B?Wkl0VWc2UFBqWDRlMTd0N3FVa2V5Mmd6azlQTyt5aEUxL1RlR3RUaWx0MHFl?=
 =?utf-8?B?dXNkQ2VLM0tlVFhka1lYN0lXYzJvU01jNk9nM1FaclpVMExlMFJtdTZUS3ln?=
 =?utf-8?B?MFBudmJjQ3hJUVc3eGFLTXVoOWlPRHRKdlF4SHE1YTlzRnNuT3JCU251SkxH?=
 =?utf-8?B?OTVZV05SNUVjL2pMaXcyOThMOTBMSFR1ZFdTSHZCbWNrYXR0T2JlbXBzckM1?=
 =?utf-8?B?RjhYLzEvUjJ4T3pvOFpkaHFNN0crWHZEcFd2RmJ6eURXcjRVQ1gzNUU1eDNj?=
 =?utf-8?B?RnFrZVcxMjYxN3NtWFdPcUVid0Z1VVVvRXBHNVMwcUVZeXE2VU1FR0c0WEdM?=
 =?utf-8?B?ZEtMOU1FMnZOalhDMEsrZHVMNFdwMGppZFpWOUxqdjl6Q0hHZ1hTSWFjOGlX?=
 =?utf-8?B?Zy9wOU1INTBmY3J6YjVLZHFxSXExSFZhRzRvZDh4UklPbVNiOG1BSldpbDRM?=
 =?utf-8?B?dElIU0k1bTdYN2hKTHdBelloTlFkZzczYTJ1RlZDNFdndFltbTB4REtEZlYy?=
 =?utf-8?B?Y0RzWFlxYXBxMEpzWDlkVGRqckVFS0ZpSEFNS3M1SkJURWpLYzUzSFdHMjU3?=
 =?utf-8?B?bnZCVzQzWWFsU21WYzZHekhBamxtaVlxZzhXWlBOS25oNlZNT3QxVjNydk5h?=
 =?utf-8?B?NU9GaDRTUUN4ZUVWL0UxQU41RDFwY055RE9Nb1hQT2FRdlEydm9SR3crSWRU?=
 =?utf-8?B?QjBpdk82VHlsTlJZUitGbzhqUmpvckRodk0vdXNmT3JsTUhzVG5RNXA1WGFy?=
 =?utf-8?B?RnpKemphaDlSaEtlNGpmQ09pZW05VjlwNE5YdEMrS21GTGpacHVwWEdVOGtq?=
 =?utf-8?B?Zk1jcDMrK09JNFZKRnVoZHF2ZDRaanpDbkkrcFRFbE5IMkphR3JiTzA5L3JL?=
 =?utf-8?B?Ri9JVXFPcnAycDZHN1AyOWxtRlprRG1WVXgzRDdhVnVIbS9XMzZBZnRYaUU2?=
 =?utf-8?B?STM3QmFoM0ZZYjEzU25zbnYrT2w2bmlaYkVHdHZrajJEeWNWaGIrN1FoeHdp?=
 =?utf-8?B?VGhoM0JheTZsUXA0UHZ6enBvOVVBdXBtYjZiQ0hHNlh1Tlp6N3M0dWRiR0pq?=
 =?utf-8?B?SWVRQmRUbnFudmJQK0gzOFdlVVVmVUhqNzJLTjN2VG1hUGtBcjBZL0IzZDI1?=
 =?utf-8?B?MzFBWmVNalAxMkFEYVhNUzl5SzRqVnd2ZHlMb0JIeFpNekRkZGhuOGl2bVFM?=
 =?utf-8?B?d28zcWVrb1k4VXJUb1Y4RCtZTm9YRlJtS2V3VmRoK1RTQjZyMTczT2xiWXJ6?=
 =?utf-8?B?WEhEY2VOaFAwSEQzd0pwbHhZSnp6ejMveFNRc0lVRzJMZmM4WGl1bnFMNzZF?=
 =?utf-8?B?RlhMNGR3Z0QyRkZ5Q3V4M1lSUEJ0MmZVYjNVZVM0bVNrNWhIaFhHL1VuVS83?=
 =?utf-8?B?bTc2UWxDd1U2RU9QQVZCUmVNd3NiUS9vcTRUQnF4SHJRYklmWlJJdUxuMXpO?=
 =?utf-8?B?STZ5SVZXOG43L0ZVanQwUlNVVnFCVW05N1FNc2tNY3BObG56MWdwc1BvWlNk?=
 =?utf-8?B?TDNtb0lmM2JQQ3hNTXpjdDFOL3RXMi9yS3AweWIvTlQwQkJJRjRLK05HQ29w?=
 =?utf-8?B?Ry8rNUhDSlROZkNjOGtnYjV0WWRrM3o3WGJ6UldzZjBESXgvNE91VFJqZHBB?=
 =?utf-8?B?SXRkTFlnbEJoSVNiQ2F3WVNLVEJpbHYrUGlUdGlLZDVCejlBUmhWVWNjckRk?=
 =?utf-8?B?UmRVL1dkYzdzYk92RnJqcWpLT0ZhYXJYYTlxNWhqb1M1MlhxRUhCV2ZWdG9x?=
 =?utf-8?B?RldDWEt1Yitid3RpYmZRc0N6SGhnNzNQL3llSVhUK21qdDJpVHRvaGQ3NUVR?=
 =?utf-8?B?dEVyOVY3SFVvaXFDVUN4VHhyNksxQTRsTkQzYXFrTElFQlV6OUQ4MEYyeVhO?=
 =?utf-8?B?OW9mNmNZNmFRT3g0UkpFOHZKa3FMZ25Sdk5LdmNBV3JObXhpcnQ0U1BtWEJr?=
 =?utf-8?B?Q1FON3NwT3hCRVI1aUR1ZXpIT1l0azJ1L0czcVRlVnBpNE4yeVBoS3A1M2p0?=
 =?utf-8?Q?PWbMc7d3von3s9Dszk1zr3P0T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0663280f-0ef1-486c-4b80-08dbd5231cb1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 06:24:58.8240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zv7aBe8gUtm/PnQOAvIyUa/G7JKEIHTJ5vplhbNcYHJE0LvxGrJBSzFKORkjSlCTzIK7IU8TqMlddCt9EDumg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/19/2023 7:06 PM, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
>
>
> On 18/10/2023 14:32, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   06dc10eae55b5ceabfef287a7e5f16ceea204aa0
>> commit: a7cffa11fa9232eabf0c4f441dc53002978ab526 memory: tegra: Add memory controller channels support
>> date:   1 year, 5 months ago
>> config: arm64-randconfig-r036-20230512 (https://download.01.org/0day-ci/archive/20231018/202310182004.0XOYolzI-lkp@intel.com/config)
>> compiler: aarch64-linux-gcc (GCC) 11.3.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310182004.0XOYolzI-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202310182004.0XOYolzI-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
> Ashish,
>
> Are you planning to respond to this?
>
> Best regards,
> Krzysztof

Hi Krzysztof,

The value of mc->soc->num_channels is not more that 16. The number of
characters written in 'name' variable won't be more than 4 which is less
than buffer size of 8 bytes. So, can we ignore this warning?
If not, then I can fix this with a patch to check the return value of
snprintf and compare that with size of buffer 'name'. Something like:

-               snprintf(name, sizeof(name), "ch%u", i);
+               int n = snprintf(name, sizeof(name), "ch%u", i);
+
+               if (n < 0) {
+                       dev_err(&pdev->dev, "snprintf failed\n");
+                       return -EFAULT;
+               }
+               if ((size_t)n > sizeof(name)) {
+                       dev_err(&pdev->dev, "snprintf output is 
truncated\n");
+                       return -EFAULT;
+               }

Thanks,

Ashish Mhetre

