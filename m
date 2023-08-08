Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E3E773DE1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjHHQXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjHHQWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:22:22 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC56A247;
        Tue,  8 Aug 2023 08:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJq4bg/GytGNqgRSrGAI4ZfgxLNdOlCkkKzzvHoyqTTT8ZYENA4cqV7OEI90zE1RDpP+LV+o2SPz9GXVudPWB8nKnP32XDNLSvoWyzCpnp6nHkvHvA+bjFtiLwdvnXv86/ljg3QqmcEkukpfQ0i58TAndv+X++UfVA0AwVjmm+L0H52qjWLbeKgIcq/6fzJpSwjTyKRf8p+bqEHrVGoQbhz7jCFKsCUt+RQ/IW8TWCIQtp4Bt7eqS8GzSLjZSpQZI+exBqWymSBIrUIoaNHm3MNxvpJOYF2eySg8KHpCqZJLzUftqtlOpMGEKUmHy2UKO5CEUwmBe1hwNPQHsU/3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D95mWif/Gd1nVJLEgdmAX6KDAvO9MLg+vt/mPgQp2Bc=;
 b=NfhiksInuVnDvxAVTS6IWuDjt70q3kVPV4wwW1NwcKjSuIUOgVekwcN+v+hUO4zQX6VO2NeOkTpfwKNq/LI6VJ7mtrSk/O79OUaeNOp1iSLRRB0N8bB8K8PP1msYfzeyPS8/GMa80bKgDN1HQJfDvMnMVYkTeDpHS2At+wlcK2AwSOaqKSxH/rE+9E74vt9p8nLQb58lpXfxAon5ez9I6+kyvKupyQu9rJhRr7nuRbPlalA1bkWsivvlaEQtvB8QVLZrSj84uoD+l4JIj9rEBKB9UEU3NJ3cVnaCF5IGXxHEklqxadve26RgdwrNHGpzOjW5QngxXhjOCj2nnArGKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D95mWif/Gd1nVJLEgdmAX6KDAvO9MLg+vt/mPgQp2Bc=;
 b=MQZJb32DX0am24Judkblln5WuamW6R/dRBr4rohldI8l3JDt+nOcKWw/a/dBBG1mB7yWbTxi2D9yGZWTqyj+WusbtbaXWHYcwEwsbGXJ1muv3WIIMrwxIVWa3jv0tHaUQq1UpAEqaUtqjigeJREK6AtaNqrdw3KaMEmvomVPPbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 14:08:05 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 14:08:04 +0000
Message-ID: <f989cd56-a066-409a-8d82-40d0bc6ff89b@amd.com>
Date:   Tue, 8 Aug 2023 10:07:19 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
        avadhut.naik@amd.com
Subject: Re: [PATCH 1/2] platform/x86/amd: Introduce AMD Address Translation
 Library
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        linux-edac@vger.kernel.org, hdegoede@redhat.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        "Luck, Tony" <tony.luck@intel.com>
References: <20230802185504.606855-1-yazen.ghannam@amd.com>
 <20230802185504.606855-2-yazen.ghannam@amd.com>
 <58934edf-4fad-48e0-bc5d-62712b11e607@amd.com>
 <894b3737-1a0a-4139-9c73-686a95481795@amd.com>
 <B3BE6B56-FBAB-4878-A45D-E95AFAC86AB1@alien8.de>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <B3BE6B56-FBAB-4878-A45D-E95AFAC86AB1@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0624.namprd03.prod.outlook.com
 (2603:10b6:408:106::29) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DM6PR12MB4122:EE_
X-MS-Office365-Filtering-Correlation-Id: b172fe25-48ce-40f6-c09c-08db9818e234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AcTOtLdSZqveHAcTC/OOwyezk7qCU6e0+Ynp+SXr2HLmkhBYx94ci+Yohze8PRnbpQi0UPNScmoWZ0dEOYaalPxKyHxBd3c9D9LHlP9RHDKUjsSwzYe1TL2JTVEeC/eZ//iKJmrCBgv+HA7apEt9I8iuCWqIUd5q+C21BIETV5Kh/RdUBn9NlSRDLWtPQtST6QzKKKVH0sJopQ0kPZN31IEvhhfpAusPvPa83KI+95AXJzU9vyF1oDW13DKtZIPZlu//KkMDGC7CnZBoWXLNP149lrkPl/t7+yDehKz/l0w2il/TgC5CHy59RZ7bwO+854koMqi+X7igmu2BH3hn3CEDMP6WV3hsyo9mq5uUoJtdnu9/e+6QyV0azmJh3h/Jx9PrJW45KVTv4W/Wfyq/KXET1mn2hCE6TFq+E6+sabz9inq34RlMdHGRT/vh2fPxWgD1AOuu6brE8yZeoXu7lXw2UQ5pnLcQd1HFJFbj1SoFcuoCW9fqLodM+HhSni06ncwhveI4DIIH97Dp2qenkcjf8XL8EiI8c6PDHJElHYZaHZlDFEDL5gk9rrrOStKR29Pm5gI/P9yJA1tJpiDcPprKOUqqX5zRQXjfB/NlR3UiaBKEY0PR9qqDBlRUaicMOeGzYVqGm+Ez6YvONjmdMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199021)(186006)(1800799003)(44832011)(8676002)(8936002)(5660300002)(4326008)(41300700001)(316002)(31696002)(86362001)(4744005)(2906002)(6486002)(6512007)(6666004)(2616005)(6506007)(53546011)(26005)(66556008)(66476007)(66946007)(478600001)(31686004)(36756003)(110136005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkFpY3hibkVvdDZNZXR0OVFybUY1TjRxU2FSOG9TTmV1dGJPL2p3RkE5Q2dl?=
 =?utf-8?B?b3haL1NXS3dLTXhNQW1qOVJLaU1aanY4Rmg4TEVCZmdPbnhCSndZZDFkV0xx?=
 =?utf-8?B?WkdDYngrLzRZWFNqcE41Y2o3WVVoWW9FYmIzTUtYTFNUWW8xRHRwZGh3Mk1h?=
 =?utf-8?B?cEFiMTNmNGZuN0tyZ29KYXJGU0lET3FqcklBd3lDYXc4ZFpyaE5GODlHTy9Z?=
 =?utf-8?B?aXcvUEtMem1MSVVYU0NEZnJmZVpGbFZpaHVvYnFkbXViN1p1ZlE2VzRTVURs?=
 =?utf-8?B?WGVsZGtFY3NjdGl1SjY5RGptVUplTGtLUGVGbUhlVGl3VFZGYUdUY3loeWMy?=
 =?utf-8?B?NXFVL2UzWEQ4L05kaUtvQjBxMjREYzZKaXh6TE0xZzVRYW5lWWFpeDc0NEk4?=
 =?utf-8?B?MFVUb0xLYnNXWnI5N2w3SFRyQW9aaFh5N3RBemVXdVdvQk1hZWxMMW9ybEM3?=
 =?utf-8?B?TTczRk54V0t1VEJ1alBRS2RFdXpsVHc3NG0yYTRxT1lTYkVNWGZlNkI3MmVr?=
 =?utf-8?B?S282MWZibXAwUHludWRQeDZFYjBnbzdqUDhhbjZ5UkQ0T2MxeHFGM1B5ZlY2?=
 =?utf-8?B?RHNJQ1IwY0ZtK0VQUFJnS05TVFo5ZTE3VlZGRG8vQWhEU3BNbE8yK3V4V3Vi?=
 =?utf-8?B?VXJWb1FrMm5DZ1ZkZlJGdE9KR2tkWTFsYWw1VkJ1cG5UZm13RFh2eGxoU3hR?=
 =?utf-8?B?SlIvUW1KM2VKNExrUWJxYUZDZ0V0c3BwU2FHQnhhRFZ6dXdrai9kdHAvZUN0?=
 =?utf-8?B?K3ZYNEszU3Fscm1TeitnQzkxdVFleHlKby9zbEdCcVBzbCtHMUlyaFNFbkJo?=
 =?utf-8?B?a0RMay9MTzZzM2J5Nzg2cWpiOWRqMzFTS3lnYzFOSy8rT1NobTJ5eEpvUUZt?=
 =?utf-8?B?WFFQY214d0hIakprdHhFaitiWWF6Q3BwU1YxRHZiblNBT244RWJYaVJpUUVB?=
 =?utf-8?B?eWtqajBBZCtWNXN5RVlxdFpwdU0xdGh2SlhlNXNaSHVtMFRXaENmRWFuWHlH?=
 =?utf-8?B?bXUxa20wUW43M1p0ZkRYcElGWHVWNkkwRXE0L3l5Q3I0K2tGMTlMV2xTN0ta?=
 =?utf-8?B?NVdhSm42aW12aEpXVGdzK2RqRFlJL21rVmpxN2J2ajBZOXFyWVZGcE1DSFln?=
 =?utf-8?B?TjhzL3FMMVE0cnhZRzZJMlBnYzl1SERTTWIvdWtwc3NpZjZMWVQ1TElPTjlw?=
 =?utf-8?B?a0dvNTE3NmJCNHEvQk1obU1iV2ZaL2M0SytaUVdIdzNicjd6bkdUYUZPb28x?=
 =?utf-8?B?RHZjaytmeU5FbTJHZG5uVUtHY05mblJkTk82MS9id3hFQ2pkbjNwYnVjK0Jw?=
 =?utf-8?B?Zmt4dkE0SS9MN1h4N2NwNnFrVU9uZFh4c3RtOHVjUGpUK3M0ckdsay9EcDhY?=
 =?utf-8?B?RU1LZXh4SEFVZWU3UW9uNjN2OWxqVzk4WUZ2Z3dTcEk5VFFUQzNGWmQyeEZh?=
 =?utf-8?B?WnEyd1Mrb3c2RVEwcXpZYk9ib2F5YXZtQnRSQVVEc1VmZW9yVlM3ZG9hd1Qz?=
 =?utf-8?B?OG1rZCtJTnZPQlJCOFdjdTFETVljQ2sxM3daaTVxY3pXeU1BT2c3aUpRb3VX?=
 =?utf-8?B?TzJWcHlqT0hTRmwxSkJrbjhCZUZETzNtM1p3eHh3ang1dUdlMUliRjBoS21H?=
 =?utf-8?B?OGxpVno3bEh2T1dSdG5QZ0Q1OWRIR1hxS2hRSmtrYlV3anRNb3d1RHlycG5H?=
 =?utf-8?B?ajBhYXVQZ0VteVRidzBSOHVZbHo3emtjQnRXOC9CV25NZ3FUT1BxM01yUSs1?=
 =?utf-8?B?RHpwRDJqeExtbDdiZ3dRZGJsaTFnWXdUbWhXU3lWRWJ1T09VY2RraVVmYXNN?=
 =?utf-8?B?NlRiZmNHcDBrcEZPWmk4cW1EQ2N2emE4UmRyQmFZSWNNa1Q1cHVQalhwWjVu?=
 =?utf-8?B?akF0bjRVZTlIRWREeUtpcWhWR0pMQVZ5bC9ZVGY1UmNLc3RwVGFIeHAydXlQ?=
 =?utf-8?B?T1I3eUFhWVhXUHBZOWNZOC92dlRzSDFVbnlFUElmcXlJazR3WlkvT1ZMd2o2?=
 =?utf-8?B?MVdudEszQ2NRbTBUUk5NVFY0bStqNGVxWnlmaGVBUWNnZktHa3VDSHVFU2ZP?=
 =?utf-8?B?STZoZitQV1g2VmJ2WkZlS1pjbGljdW9HOTZ3SGFaejdhc1BBNFBXM0NpNWFx?=
 =?utf-8?Q?r1djnDDzI8/2buNPxkjVjN4Y7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b172fe25-48ce-40f6-c09c-08db9818e234
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:08:04.7834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VutBfZ1wifkoClFqz4euCiF7tWH4K+LtNtiXwxM08s9YXXwAi7Lw7Wyak4T1dOY04tbmTBNfsbVeFy51n57wyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/2023 8:10 AM, Borislav Petkov wrote:
> On August 8, 2023 5:17:33 AM GMT+02:00, "Limonciello, Mario" <mario.limonciello@amd.com> wrote:
>> Given it's 'library code' to be used by a bunch of things and also want to be able to use a module, what about putting it in lib/?  There's plenty of library code there as tristate.
> 
> It is x86-specific so not in there. Also, it might be used by multiple things so you want it as a separate "translation" service which is called by other modules.
> 

There are modules in arch/x86, so I guess that's not an issue (not sure 
what I was thinking).

This code is AMD-specific, and there's vendor-specific code in arch/x86 
already. So it may be fine to have this in arch/x86/ras.

But just because there's existing vendor-specific code in arch/x86 
doesn't necessarily mean we should keep adding to it. So is this okay?

Thanks,
Yazen

