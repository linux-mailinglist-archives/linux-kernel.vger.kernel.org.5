Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3CA784CDD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 00:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjHVWeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 18:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjHVWep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 18:34:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FEBCDD;
        Tue, 22 Aug 2023 15:34:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEZzr4nW/kBCN7UJRvoFOw4xTI47qXRFOkaiFmDM+Cw//T3eWHo16R06dVFW6t8rdCQtPhVEvduaxYYYOY12pBIQbxxWoMDdlS8T3fPKN6ei0lPSnLYnvozKh06esuIespHg4U2cq4QwnpK6GzPZPHg+ajdFYaCKxGsB5pMYc0ybyV1biRnTa7/vPvmQ9VBK4cDwqiqdXp3oRfj7v185guXbJQ3JKQBrPQ5J/Kl4aiES5lTou+MlkwbnuC1QZ/bD4aK0bCqdNrMsgv0M6cFT71yNC9/5GeQAYvRZe585qmdDBQHYhJOrtWMzC9HloEmnStuFaZfLVLLjLLw7p53vzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pu47SY9Jdq9M6qXo8a7eeTNb16a4ed6MVj5PjZGKPUE=;
 b=cvQe0/hFI6BnRLK2z3FhGnwk6E5mgDgOxuSF33N6smu26a8XahrXXWwSo35OVQtGVv7Ff1AItSVXi8LmqP4NgoYHBjAP8IP7z9pk0+in2yNMfa9ElIw5cQBDr0oJEe6OgVsuQ2fDbL0Do9vfcRH+3dUP25ZJ/hGV1xI8QuukdT/6Y0lgdfY/8wTYnAxnfBH6KumrWG0/vQ4jTc+YJQpDeCgqEjrxts05j7ikT0M0vbdeUrZz4gxHLWNYZIfhoScqSLhYLAR/2Hn0mT0ZAdv7rjRz4v7xQqS1G4HcfquTM0IM4+sB5pmt4HRLldWqkZMr0akt1mR2yEESpV89kHCWuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pu47SY9Jdq9M6qXo8a7eeTNb16a4ed6MVj5PjZGKPUE=;
 b=LVHKt1Y6eeihxeibtdFAOVa0qIZ6OZbg4n17svwbgnDo8/LoxfxUy5/qYZco2bn1kAz9zA6u6+G9rGi7qfaKX5fljJbV9yamNgsXizQ6KnvNUiFVRu4EIqyqR5fvdLPKcKBkKp9IN+KyFrx10jFnoQlLwBlDaifhV1ZxkTdGsqrXwGOa5IIPt7Cx7CT4KBYPfMceLCQa67gG/5wY+LC0q36IGLRksyzcmPuhjHRqpogUMJm8/Fh2ndrFzUO++b/J4cElIieQpyxSpngwisGWjA32LGazM59GDvJhZyG7ogRWsVk07b47aER8jmr8OJ//2WmDAZxyh+4D6fYR492oCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Tue, 22 Aug
 2023 22:34:40 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f%5]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 22:34:39 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     syzbot <syzbot+3a0ebe8a52b89c63739d@syzkaller.appspotmail.com>,
        davidgow@google.com, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, rydberg@bitmath.org,
        syzkaller-bugs@googlegroups.com, benjamin.tissoires@redhat.com
Subject: Re: [syzbot] [input?] KASAN: slab-use-after-free Read in
 input_dev_uevent
References: <00000000000035beba060371a468@google.com>
        <ijh2qmdtj452nq3idu2tohkrmfwr2qhbhrnyqzxjkkw2lrby53@v2dffcqdohsx>
        <878ra3m5my.fsf@nvidia.com>
Date:   Tue, 22 Aug 2023 15:34:27 -0700
In-Reply-To: <878ra3m5my.fsf@nvidia.com> (Rahul Rameshbabu's message of "Tue,
        22 Aug 2023 08:57:41 -0700")
Message-ID: <874jkqn1u4.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0199.namprd05.prod.outlook.com
 (2603:10b6:a03:330::24) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f2e23f-19be-4f46-1411-08dba35ff861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /fIflxaN8I+1vrPDMY3/Ni6ESwsNxWlo1k8HQLXSkHxtUfNF3DMsrGHPSSuft9NyM14uv76UMbJ7QWljKpXsdy9vfAfheDHlh/VR6tF3afkCoxfEQjE+UkyAFY8VOcy/A2Pql2/EqdnE7E4v5S0vD2/hG5z/AOqvWa56qt3gaj20yJ0k0vXbY/k8Vr4WyI6NlYBw7ln3Ie6bMB5MvqQmvF0nWrtN/WTK94WudiEes7m14n414urpPAFXeXYMZ2t3ql1q9xkeVMCvYh2t/qyYluAbjUeHoKFvV/IeTE89TyxSs8SfgP6WDPHJphKxeun0RGRbBJ5U/2wrD3k0ZFC5lsclRtgfcZ4XSbQPIKTmG0Ym8pkVo+88P3/8eWb7vzz251AmdGcWDgA+TL5f4/LPxz4xu++PlrqHZ/wt3X1yAc0oVFTQbGez2yyC+ey/57LI1Q4PKQlq42iE0KuVTh6B+KRqm++6ecNGXHkNBGbjQ3sGEDUQReLcAdJYJHWU0UVgWCOfh6tyt1uIVpFflCTO3GINgyz7iF+4cWnDNAPeCByVBj5Ix9bBFYlHlOgJFbr+TqLb5wgy/kQsWA64MdEi8zY3TX/486//ss/st3p+H8Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199024)(1800799009)(186009)(83380400001)(478600001)(966005)(26005)(6506007)(6486002)(2616005)(6512007)(6666004)(4326008)(2906002)(5660300002)(7416002)(66556008)(38100700002)(6916009)(316002)(66476007)(41300700001)(66946007)(36756003)(8676002)(8936002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wE5TmxSXYJRGVmATDZXsHXUCjkvqNWqP5vdWXmSNxOeYuUAGGyRrxQjqb8qO?=
 =?us-ascii?Q?OVoT0J4NBTwi/3lEO7AwJKYXLDrpiyqxQK2NFbB6GkSoiPOMHuGHgAi2Kbcv?=
 =?us-ascii?Q?d2htSBcjjvgCNRvIcLDgBBcjQBTT8bVyJLffm6rt8FRkNhAC3fHpScvLqAmO?=
 =?us-ascii?Q?9ehPiCCRU6zsHb06HBm0UUID86y5FPKvZSy/zjeB54BNlm7FGYNRWnR6OHW+?=
 =?us-ascii?Q?S6uSom1KrWGpsCmAdNPyTomHlCa80Sp1wCuYLWW+Hv7/xL6f7E1TM3ZTfZSv?=
 =?us-ascii?Q?4eqLheTcAZBI+kvgPlB979BAgi62cXClaxZ8fqa3bqywJ7zKPN5L15yxT+1Y?=
 =?us-ascii?Q?qQHaDLglZGTLxZ1PHZvwqYcsRsWeiU6EofShojiD3MmQGnZ2KxxLA/4FUDw5?=
 =?us-ascii?Q?Yok8yyKRdi5PXzkGX9FRb74yEmcKnpAl4yJuYeMWQwGEyLac8DC1oZsrQBNo?=
 =?us-ascii?Q?U9qPESJa1phunSwH+GCk26ntcFsluMdiAAE0ZbPKmSF+Cov5DP/fyktNnO7g?=
 =?us-ascii?Q?gTIpKcYcFCDDOrofAoqwVOVWkq4o23abHOKN10qoXjoPT5u4lGeRuHtbDqJK?=
 =?us-ascii?Q?RIzGEkk9NgzVuuo1b/N9F+t2SgWE8+yBnFLRj6FBPGGmmVBtN7z4OIWJSuBq?=
 =?us-ascii?Q?2MDJb+7xDMS270wN4EfEH1vf0UFX4rd+mJM2BWuAYs1QWlueRYtfBX1qtUfJ?=
 =?us-ascii?Q?FCXkeAK8N6MNaed90Vft/DHOGD208g0GryvPd0Qu+DFTq1YU5HcP5MZMxNPW?=
 =?us-ascii?Q?BwPvzLikwB2QqDA8DChoZf6ZRilsxsTw8SQBkxwX7buszrUHAQhwtpfvuRjK?=
 =?us-ascii?Q?+XaU/w9rFXG7tElsLBWk1DcpPZ8zzY1Ppqfb2pzPYjvcN+lyWqKz88jHRlh5?=
 =?us-ascii?Q?ZZnGvNoih3+eeR3wChHsaFtf+RCoRT5NECJJJd8ep72Tj4F7s37D0l1zB++w?=
 =?us-ascii?Q?6ErfzZNjN0MsT1gelzWQly6hu6EjNuwGilTbxHjyiZtbWn5inHnqhpF9y5nH?=
 =?us-ascii?Q?Ex0yXKyT4dqXyORS/bS7oafvK32G0JZMCWHEFr//j0ovubMEs3/d3SgQAQ+r?=
 =?us-ascii?Q?V7eX6Srhj7JHCndHc4krF5eqkk6Mt5GtC6Jo69UUskCpSIkAxHRMpwMSd1qh?=
 =?us-ascii?Q?4Xd1qzsjIxKF0hvEpfJooSzmqv5zRrxFfyTm8zrwLXBMfPq4H4sm6wKTkezq?=
 =?us-ascii?Q?VPcRYdHc8JEMPz23+xXQNC/ByVE2HFWBMXiDXlT3bTbe2KVsSwtjgFybdMkx?=
 =?us-ascii?Q?pmYPDyVi+TOuD4SjDwRUw1evFvpPtSBd9hlcFH00TTY/euNKBulmAHNsXrSa?=
 =?us-ascii?Q?qiAByruOpjkiPxGSvVjDpEZ3U5/YvksTiR2bYEprs+E5RMXiwYZSjc/JvgMQ?=
 =?us-ascii?Q?N2NFXFuYqx1ErxaBAVfZinQsUp/n1+AVg/XUmXxr9woWc9a5ZU64sV8A8ydc?=
 =?us-ascii?Q?oqJhgvw0Lbasoz5l6idEjCRZo20hz6equDQ68xm1fIdnJWgnxCN2WXv/aWaS?=
 =?us-ascii?Q?H52PsyMVZSmt4HKToU3X0jwW7oWrVUA+EWPBvvltfQilAhWrVy5OTskJqQ9h?=
 =?us-ascii?Q?ABXsfXeTm/5+f5uSEYkbUaSRFMmQLmowKnAJ2Nnb12CIo2VfH9AmZh8QPF17?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f2e23f-19be-4f46-1411-08dba35ff861
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 22:34:39.8816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlZQYc24EyQrb+bURn+oMj8xqtf3UQyCv27TVY59jxRj9xrFihFjLKHzUYIyQJwqZ6iTC8Ec1J3CK/qiTGtXhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug, 2023 08:57:41 -0700 Rahul Rameshbabu <rrameshbabu@nvidia.com> wrote:
> Hi Maxime,
>
> On Tue, 22 Aug, 2023 11:12:28 +0200 Maxime Ripard <mripard@kernel.org> wrote:
>> Hi,
>>
>> So, we discussed it this morning with Benjamin, and I think the culprit
>> is that the uclogic driver will allocate a char array with devm_kzalloc
>> in uclogic_input_configured()
>> (https://elixir.bootlin.com/linux/latest/source/drivers/hid/hid-uclogic-core.c#L149),
>> and will assign input_dev->name to that pointer.
>>
>> When the device is removed, the devm-allocated array is freed, and the
>> input framework will send a uevent in input_dev_uevent() using the
>> input_dev->name field:
>>
>> https://elixir.bootlin.com/linux/latest/source/drivers/input/input.c#L1688
>>
>> So it's a classic dangling pointer situation.
>>
>> And even though it was revealed by that patch, I think the issue is
>> unrelated. The fundamental issue seems to be that the usage of devm in
>> that situation is wrong.
>>
>> input_dev->name is accessed by input_dev_uevent, which for KOBJ_UNBIND
>> and KOBJ_REMOVE will be called after remove.
>>
>> For example, in __device_release_driver() (with the driver remove hook
>> being called in device_remove() and devres_release_all() being called in
>> device_unbind_cleanup()):
>> https://elixir.bootlin.com/linux/latest/source/drivers/base/dd.c#L1278
>>
>> So, it looks to me that, with or without the patch we merged recently,
>> the core has always sent uevent after device-managed resources were
>> freed. Thus, the uclogic (and any other input driver) was wrong in
>> allocating its input_dev name with devm_kzalloc (or the phys and uniq
>> fields in that struct).
>>
>> Note that freeing input_dev->name in remove would have been just as bad.
>>
>> Looking at the code quickly, at least hid-playstation,
>> hid-nvidia-shield, hid-logitech-hidpp, mms114 and tsc200x seem to be
>> affected by the same issue.
>
> I agree with this analysis overall. At least in hid-nvidia-shield, I can
> not use devm for allocating the input name string and explicitly free it
> after calling input_unregister_device. In this scenario, the name string
> would have been freed explicitly after input_put_device was called
> (since the input device is not devres managed). input_put_device would
> drop the reference count to zero and the device would be cleaned up at
> that point triggering KOBJ_REMOVE and firing off that final
> input_dev_uevent.
>
> I think this can be done for a number of the drivers as a workaround
> till this issue is properly resolved. If this seems appropriate, I can
> send out a series later in the day. This is just a workaround till the
> discussion below converges (which I am interested in).

After thinking about it a bit further, I believe hid-nvidia-shield is
not impacted by this issue in its current state. hid_hw_stop will
trigger devres_release_all, which will free the input name allocated.
This is problematic in the case that the input_dev is devres managed,
since device resource management will hook the uevent callback on
device_del triggered by input_unregister_device invoked by hid_hw_stop.
However, hid-nvidia-shield does not use devm to allocate the input
device and explicitly calls input_unregister_device before the call to
hid_hw_stop. I believe this leads to the uevent being fired before name
is freed by devres after the hid_hw_stop call. Let me know if this
analysis seems off. Hoping this can be helpful in general if this is the
case.

  Freed by task 4508:
   kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
   kasan_set_track+0x25/0x30 mm/kasan/common.c:52
   kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
   ____kasan_slab_free mm/kasan/common.c:236 [inline]
   ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
   kasan_slab_free include/linux/kasan.h:164 [inline]
   slab_free_hook mm/slub.c:1800 [inline]
   slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
   slab_free mm/slub.c:3809 [inline]
   __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3822
   release_nodes drivers/base/devres.c:506 [inline]
   devres_release_all+0x192/0x240 drivers/base/devres.c:535
   device_del+0x628/0xa50 drivers/base/core.c:3827
   input_unregister_device+0xb9/0x100 drivers/input/input.c:2440
   hidinput_disconnect+0x160/0x3e0 drivers/hid/hid-input.c:2386
   hid_disconnect+0x143/0x1b0 drivers/hid/hid-core.c:2273
   hid_hw_stop+0x16/0x70 drivers/hid/hid-core.c:2322
   uclogic_remove+0x47/0x90 drivers/hid/hid-uclogic-core.c:485

>
>>
>> We discussed a couple of solutions with Benjamin, such as creating a
>> helper devm action to free and clear the input_dev->name field, droping
>> the name, phys and uniq fields from the uevent, or converting name, phys
>> and uniq to char arrays so drivers don't have to allocate them.
>>
>> We couldn't find a perfect one though, so... yeah.
>>
>> Maxime
>
--
Thanks,

Rahul Rameshbabu
