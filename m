Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9D8784666
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbjHVP6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjHVP6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:58:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D6CBE;
        Tue, 22 Aug 2023 08:57:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Np/JJDrETpOOs2ybAn2MMG7L5n0lWGHS72JmPEaCveSQetNqGShcINJZge5vcva8gWZ7z6St6rDcT88f4p7kyfn0a2AhXB0s9q6SSX6v0b4JbtajqcEuAebmiR+nkU4Vf5ANstCG3arGhoMX4uSQ97RA+lIc3HuwsuB6TJs9RTSRs34s94tLNg9v0YUNoQU2pusMAAC2w/uwCTwacbjZefWjbwoMcdJbV2G9cBUot86kkYuimHJAWQyi9lPZxYXv6pm1L58/t4wKOrgPzvfclNrfeoDLCqcZQ04dqK6DDcqTBLEjc4JVvVDTAW/3rdP/ZjyumZnvdAYDQ7cumTr/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l19JLGF+I+bQ+P2kCTs7DIhR3i4n98VZ+jy4gUqIeAs=;
 b=HtqJT2qWNrgTyikiM1tWj8xNDZp50OiwQYGOLpmhuLXSDb609WQJRMyj+GEAZHeRRMIQyLYugZEo3umybuKveKd/hzpur2rj7MKoV/j54/mt+Sfi1xtI7eey+0velOERyKGk/q2afi/2AlS0SdjI/aum3fzeuJ6yOTd/ZqNim1qFTTOq9ZDkMb2OBR/rolrAByf9FjW8jcC2XkEjS67mDrHEbRifYcWGppeZleVN7fyon3NiYoMITMgWJIhGYgo4TXtLFwuSUanZMAJADNM/NoUNQTehatYF1EbJ0WdYi2e4SDssfXhnLU5Qm4icDSUCJ4MJxczfwVfphxhSOmzpJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l19JLGF+I+bQ+P2kCTs7DIhR3i4n98VZ+jy4gUqIeAs=;
 b=ebUApBAeKBrniqFtxscSRRVOza1SekTWkiO3e18LmhI19ht0glNFyQLVWfN32bWulrzoyCdyOQ7nW4+/BV5gXuqHe17k40NdOECfvk+6VGHiVrfW80BwatU/5l5GAZwiWWpNgmK9Yfe0AKyYtLtAP1nF3Iivh/USiFIX0ourk94/6DPopQz68Q/2E4mWT0sU9X1pjavaOKvk4ZOhBtsP5CK8nYOKKeJ13gVjX6Pa/qrrHTerYFYMDdvbKm2HPqh+vB/8aqL407qXp8KhqiGitWWTYfWPctDwGUcrJCPmOQ6RvRtqsVqAqcaqN83ZnHc2RbseWMeVgJ4HwODX023QNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ0PR12MB6991.namprd12.prod.outlook.com (2603:10b6:a03:47c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 15:57:55 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f%5]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 15:57:54 +0000
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
Date:   Tue, 22 Aug 2023 08:57:41 -0700
In-Reply-To: <ijh2qmdtj452nq3idu2tohkrmfwr2qhbhrnyqzxjkkw2lrby53@v2dffcqdohsx>
        (Maxime Ripard's message of "Tue, 22 Aug 2023 11:12:28 +0200")
Message-ID: <878ra3m5my.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::12) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ0PR12MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: a26dbbb5-beee-4e5f-ef20-08dba3288bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TVNm2j7D/cPxgdmHsCgWkC/bbhbKMERY0wNkMuqG34qHGYLr9CZ/rU7I5fsdiT/2vQejTWeEqgfjjRE6C5Cwg415Jk5VqfwjhJEFd2OLcgRQ2ug+RGBOc537kiypIPileEqVHploER0Gs70zW9Q7T2+hxn07bLVU086gsSeCvzI0O70kNtxp1701drAgbCsHhYD0rQiqhNSxsLih5MO2MErn0liyrlm1NgttPTAGIDRpW+wq4EgSS4qdgxDRw2R7qA2JdDbZjN5S22z7ApauiePHFLP7+5GZCeGGsZkY1OJclKt0Ad58rYJnty9hhdIClDwTsGxsEz4Xl//FiuoL1opbeQAAmkpQAH+h6PF/on5P3LHrEjge7NrMi8UBxUtLJp4l1zpAXHGETRXz250yArbDDA9RnMgXTo/eiCSkJ4Q8q0D7AGju+P+7jCJUTskuTwU+69SKDM8/kD9arAxBf+hscL+ttNYZJT2sJPk38gj+G3Nk7z9kj4aH7XTC5VMla859dQw6E+Nzm4p9RnfBtlhVjJ+ktjBm9dkG2r3oNFGm4swnZaBBKCKz7N15e5SshZBBTI5UM+sUyc5ms3kuamhunnKFA4C1SP2//kIEkOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(1800799009)(186009)(451199024)(6916009)(66476007)(66556008)(6512007)(316002)(66946007)(966005)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(6486002)(6506007)(83380400001)(2906002)(7416002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D2LMCif5+qIA0ZkSr/KnbLRez10pyR3xLVtFPa0hoFfYSBtabAWm4GnfkUko?=
 =?us-ascii?Q?RG1VfUmvmiNXVCzwlnSUzfoXdXG3spiRkXacp7Q3X9ltBilUrrNQuNsf4uOF?=
 =?us-ascii?Q?M39+AKRC8YZGETjKl2+iizQo3izF0M+CA3EpcQqFLor6Q63ZoaCj8Fq16JKj?=
 =?us-ascii?Q?1GVWtsHLUiPPHPz9WqDWcBVEla/H5k/kidNjd4FGiDc7Jhbn4yaufP9A8hLY?=
 =?us-ascii?Q?4TKFVHwFpCx+FhxLaip5NpU1ynbU6gj1QYWhzNPJTpLaWX/N23fypjClHSvw?=
 =?us-ascii?Q?eincDi66YK+mYnMZDtzb2jJuL/AtIxdqxXGm8DwHKHYsOKCMELaRiYQKcHC6?=
 =?us-ascii?Q?OcJyxaISp3qWDcAZvPQegfBw71ssQNl84X02/xIqo2y7SAd63nW7O5rEuvHD?=
 =?us-ascii?Q?+l1XFOQKiIcapnlSSx51K/gHdHvdhCh1a1c+/w2a8J3SeK0JaIWWD1zZ0LVw?=
 =?us-ascii?Q?MTK2F9vZemVUoR8xiigtHBZ7ZoblftX80Y9q4PcE35n1gua44j9jLLWy/zmZ?=
 =?us-ascii?Q?l9MM9MKMZATPNjVeH6Z2V5jlqYCP/bByIOXXZ3Oz2EDkV4STUPJZhuoZ1+Lo?=
 =?us-ascii?Q?x+8NTN6Pi2Kp5SQIzjIauMyWXFuZFNSpNZxSbQxj5jkLza9LdmstQFz0RkNP?=
 =?us-ascii?Q?UUAepAyQIQ97r5sz6ujHMX/Q6SrckzPivtKT7dOYG+5HkQ3Lf/psomaT/QMy?=
 =?us-ascii?Q?ocnQ22ROPFHHrc7kJDh0cT6kkKvX8Rxl6iOtWfaHn/FtgtTBBOcXQgU1BoCk?=
 =?us-ascii?Q?VtedE57pnOXD4bOcQ/ZyeuYcT+X7lvYs8XRm2FqpXi9eyQxiCn8yC/Lfu89g?=
 =?us-ascii?Q?bIX5JQO/fkvitk2szlvAMTYaNVoPA4T8QA3U4GsRIphmw6OguldKyojXfdyM?=
 =?us-ascii?Q?QkB6EnCpt2PUe7cQGxWl2Sv0O1HdqKX1OIdzI0MyEgHmA7KvZpvcNusXGWpY?=
 =?us-ascii?Q?nEwt3fsE+gKKAKoWmIVG4fnPVfLzJYhlRqmH4QUm0CH0ywkIVj+5Y9g9IgF+?=
 =?us-ascii?Q?/bXdUaBFA1X5U4AGSSGN+eqcUBcKEpxYnIiDivuKZrruiNv3/xkrIo6+w9jS?=
 =?us-ascii?Q?vQOFk2uUKkmj2nG5dpO7+MhUf+5U2KMCNWWO2jJZEeLH/Tw7c6QyCSjkoK2Q?=
 =?us-ascii?Q?30uBxcQAiGjGFnBJSw+NdM5G7QI6eX6hvieWaU3UpcKpH0gjkM2A4AZg6jVQ?=
 =?us-ascii?Q?Lw9+LcmqvW4lvmz3KqZFzfUwoNI3nrNTHU1otTUA5TddHv86OTJ3jcMgs26w?=
 =?us-ascii?Q?plJFOMHKKD1ZoKsMylR2GXMn1tTHXtJFjIGDYccnaHrP5h2QnM3pK9MtWmE4?=
 =?us-ascii?Q?rp2D1MfWIMh905DmggXrh5WuxOWVAUAu+LC9LgGueU+tITa4REVNDt8DwdKG?=
 =?us-ascii?Q?zS8Z8dKULnmFyWyEG/VeCVi5+bonZv76orFgui1eP2+S+VYZ9dWgkjQsW/MU?=
 =?us-ascii?Q?5mVrIa4VN3XNAnlXWjV5n7g1rNbOMD6cLKLrNHOkZeC8sdsaTYgBx0WVuC/f?=
 =?us-ascii?Q?csW2smeG0kD+EaO2BkZDynPH2gMJ0wVqr3aM3IrxRu6w0uMkE6IVcLTJFCT6?=
 =?us-ascii?Q?uCpN0dfz4xeT/z2FZKUqOsgkubGquqc8LFrBrc9cbceXIYh/ZA5ceVSgZcUu?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26dbbb5-beee-4e5f-ef20-08dba3288bed
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:57:54.6737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAhBlQz/7NY+7nH/EBqZ/wnKFqpICQWGUP+m1CNkzaThRoU+x8Hih6vfgUvp1Esh/DqnNY60uc/VbPFknQTV8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6991
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Tue, 22 Aug, 2023 11:12:28 +0200 Maxime Ripard <mripard@kernel.org> wrote:
> Hi,
>
> So, we discussed it this morning with Benjamin, and I think the culprit
> is that the uclogic driver will allocate a char array with devm_kzalloc
> in uclogic_input_configured()
> (https://elixir.bootlin.com/linux/latest/source/drivers/hid/hid-uclogic-core.c#L149),
> and will assign input_dev->name to that pointer.
>
> When the device is removed, the devm-allocated array is freed, and the
> input framework will send a uevent in input_dev_uevent() using the
> input_dev->name field:
>
> https://elixir.bootlin.com/linux/latest/source/drivers/input/input.c#L1688
>
> So it's a classic dangling pointer situation.
>
> And even though it was revealed by that patch, I think the issue is
> unrelated. The fundamental issue seems to be that the usage of devm in
> that situation is wrong.
>
> input_dev->name is accessed by input_dev_uevent, which for KOBJ_UNBIND
> and KOBJ_REMOVE will be called after remove.
>
> For example, in __device_release_driver() (with the driver remove hook
> being called in device_remove() and devres_release_all() being called in
> device_unbind_cleanup()):
> https://elixir.bootlin.com/linux/latest/source/drivers/base/dd.c#L1278
>
> So, it looks to me that, with or without the patch we merged recently,
> the core has always sent uevent after device-managed resources were
> freed. Thus, the uclogic (and any other input driver) was wrong in
> allocating its input_dev name with devm_kzalloc (or the phys and uniq
> fields in that struct).
>
> Note that freeing input_dev->name in remove would have been just as bad.
>
> Looking at the code quickly, at least hid-playstation,
> hid-nvidia-shield, hid-logitech-hidpp, mms114 and tsc200x seem to be
> affected by the same issue.

I agree with this analysis overall. At least in hid-nvidia-shield, I can
not use devm for allocating the input name string and explicitly free it
after calling input_unregister_device. In this scenario, the name string
would have been freed explicitly after input_put_device was called
(since the input device is not devres managed). input_put_device would
drop the reference count to zero and the device would be cleaned up at
that point triggering KOBJ_REMOVE and firing off that final
input_dev_uevent.

I think this can be done for a number of the drivers as a workaround
till this issue is properly resolved. If this seems appropriate, I can
send out a series later in the day. This is just a workaround till the
discussion below converges (which I am interested in).

>
> We discussed a couple of solutions with Benjamin, such as creating a
> helper devm action to free and clear the input_dev->name field, droping
> the name, phys and uniq fields from the uevent, or converting name, phys
> and uniq to char arrays so drivers don't have to allocate them.
>
> We couldn't find a perfect one though, so... yeah.
>
> Maxime

--
Thanks,

Rahul Rameshbabu
