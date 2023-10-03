Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B1F7B7072
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjJCSBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240706AbjJCSB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:01:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAB88E;
        Tue,  3 Oct 2023 11:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mg54kfLFP4ARELyr5Jm9EALIzbXr97N5oKYWWxq3PjtOKAoDe0RW7DBrDpNEyhUTrTMDJi8gL4jqdik/f/SyvrITQP0lFLFZnLX7/1dkmmBfSBOgIMgkVPvIEh0lPrxdXF4viovRbcwssqNYRXqUHpGfCL8g/IdqQ8lQldatVW4Co4r+wvlipXNtaCY/jt8nl7txBq4/ecqNdPkVdsdwJsti5dY7UmEjjcociatR58x4IyFw/dS9QMnJZIJvYkKNPFpI8sdOyn2zq+5T77HpiM8qbnjaBJI4W4+dV+jX+uApSjfBUDG9ItTLtM0dI8MmsPMv8W7EXmupWrOTvyiWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3P8MilSpAh72/noE2wcNK9afu51CWDfE52TdGH39Tw=;
 b=HcGgKXXFe7BcEhbbJV7giR9SwduZS3Ta/6uunNIsTEVWhUgPyz+gRidshfNlTAD8tIdXGViwzhWUBkyrWIUw8W0ilDILbu7RaLGGO33/rPVERcHDKTyOrYnV236t1DNDR9n1/S4oiTZW2FPWDgoh3h4EAYPNtvGQKSgdUuaaMGLcNx7IXmnVa503yZgK9SJ1KQ9IB+FAGWR0ORv33gmegQlxIgz03XW23T5o6x8mC6xhkFQ+sn7C1mITjJFykaOw0pjSaTyFhqZyNwdeufJxxXIHrh1aIdZPm3WXTX8XKegLkiNyrYdjBwYOByUGFXnXAtDdI/koYi76WUhnX0nQMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3P8MilSpAh72/noE2wcNK9afu51CWDfE52TdGH39Tw=;
 b=xkFI0TmMSIRKHEsV7sJP6J2A2ZF8kOjom1VXOuCQsmKqU8EEAKN6wJBcKVrOImE0T56ZacT4P4jvHQlgnqRrLZuY5y//YrfUxv/AEPthQH9wswAKk0I14NGBHCSc7mtvP5aBQrkzU7fE8UfgMfNMKobWJfMyc7zTBieoRkrXW+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 3 Oct
 2023 18:01:21 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::8304:46bd:5017:3dcb]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::8304:46bd:5017:3dcb%7]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 18:01:21 +0000
Message-ID: <ab00071b-982e-42e1-98c1-a045ec853863@amd.com>
Date:   Tue, 3 Oct 2023 13:01:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] rpmsg: virtio: Make buffer size and number
 configurable
Content-Language: en-US
To:     Divin Raj <divin.raj@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Peter Hoyes <Peter.Hoyes@arm.com>
References: <20230928153825.151948-1-divin.raj@arm.com>
 <20230928153825.151948-2-divin.raj@arm.com>
 <8ed6d9f6-918f-46aa-a2b7-a30c99dcce7f@amd.com>
 <45db1e0a-4f60-4fcc-bf30-06630a712ccc@arm.com>
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <45db1e0a-4f60-4fcc-bf30-06630a712ccc@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0041.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::18) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d9b91b9-237f-448e-d706-08dbc43ac007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5LNVZpdt+HmK3SdfKgXWZZE2i6dJzjghaKD7wO2+hDRyyBkJTLzIy30dT0QuOtgVwPSNlg7n/h6dqs6BmhSNx1IYYIBhx63NRMZPEYrn0k5vuwnR51jr6Cho4IvYet5sIp0tPrHR95/PwZH/lncjESFUbc4qSiCXJ1gaZRA3ZPfEan77uAxaHNGBRjxa7Rb4vKxT5t7Ms5acXw5FikW6pUGF3Qn1Vm8MO+QjApe2B20omQwnPWzcwv9gZJmtUvmRrWQJRwZgwE7w5XXTYne3stfK2BIlz2j2X5mqP1p6gMRHdHalpJ54OgRxGBewdf5Arp80+3Ld2qzwZN0wcsmuVETafBFEMDR2ULusLN/vo/DMKuFmWLb/89iP7TGEwvxkCZo2jY5ldJNemyezHegjdH283WO0ICSwbI6ppOotsF30awq2JY4SzX1s/FhEobp9unpH6gM5FqCaJOV9MtFZdCo/sPXmppP09ZcWm04klRSKVMKXw/fnBBVTvygrTg7QkV4aWS+mPKvBe14OfY75pJwUf3GKosoyDOeaoXsaLY9sB5zLvcq0JshQn/xyfmKoknF4BGFfkmKOy2GirQ6RirdP0phsleHiYqWwFEjq1qWVtklutZYSjxvc5shxmx6YuJUYSxKDsDZ0fjIcdw1/9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6512007)(26005)(31696002)(86362001)(36756003)(38100700002)(83380400001)(66476007)(6506007)(478600001)(66556008)(316002)(31686004)(2616005)(66946007)(5660300002)(44832011)(966005)(6486002)(8936002)(4326008)(110136005)(8676002)(41300700001)(53546011)(6666004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFRldW5yZUhLYWZzRUk1ZktGSE1KNnNoTG1Hb1FteWlDSE5PQ1d3ZHVWMkJs?=
 =?utf-8?B?WmRaNk9rUitYRldkTVQrTkdjeTlDanFKK2tjNTZpMUhIMTNRZFN4eEg5OTNh?=
 =?utf-8?B?QzRqUVpEM0tSWG1mb29Xd3FKVnhQRTd2SGdFMUwwT2hBNmNIK2p6dW8zeTZs?=
 =?utf-8?B?cStPSzh2S3VES2NOdGJjQUloaWowSGx2NE1PT045c1NPSTc5NU1JMU53bGRH?=
 =?utf-8?B?SlNIV29VNzNSMjMrTWJSVEpJclI5V2ZtMEdmeVh0S09HWThCR1hQNlhLMk1Q?=
 =?utf-8?B?d2lCMDByRjNPT1dlMTl3ODRncENQQ2haNVdnY3dUdjVMT2RBQUpQUXVUaUh4?=
 =?utf-8?B?QndUdm51bGhKMzJja0tmY3VzbUtFdnZWL0FORnl3dVc3MDg3aUJTQW9oSWJu?=
 =?utf-8?B?cGFwbGFpZmFBWFpSRGVmbnBuWER3cHllbllkZlZHZFR3Wi9uWG1ZUEpUL1hn?=
 =?utf-8?B?dkJPQ2V4emIwYllOV0JvSzBiU2xNb2xYa0loMHo3K3dWT0oxQ1Y3VHJVVGtK?=
 =?utf-8?B?M0twL0xqenpsWkJYYkM2VDRlU3gyMHROQTZaZW9PeUpMQmpzR2Q1aXJWT0I2?=
 =?utf-8?B?U0V2VXNvNG8wLzRjLzloSFdvNko4TTU4SytLc2h3NE8wVzBJaDNZNFlDNXVJ?=
 =?utf-8?B?UGpHK3BFdnBkU245TDBQL3dscUIveEJQNloxNXBndjg4amI1b1pXUHMyemNX?=
 =?utf-8?B?SC95NDFZVFpscStWYmVVT2Fyd25ySGVyMW5DNWcrNmRUQUh4bkpXRFFQbno4?=
 =?utf-8?B?dFE0ZHRNbnpOanhHTzhUZXdmblUvUVR1YlJMSjVNSVlNcmkxQVdrb2dndXha?=
 =?utf-8?B?UG1vdnY1MkFXQmlqTXRJNnlHbTNYcjFCS2ttTzMvdVNOVHhhQnNQcWtGK0RH?=
 =?utf-8?B?WEl3b3ZSSlNrVlhWTG9mWkhRTzBpaE9LZ3ZyUWR0Q1dpUUxMVVIxeVN3UzZq?=
 =?utf-8?B?cmFzL3gzbjc5MFB5M1VWck9kS3FrZHM1aDZBK0JncXl5QkVRaE9FMXYxMTkw?=
 =?utf-8?B?WndKVVRNMFNnejE4NXh2Y1FJWFMweTVIV2dsRTdKc1VPN3g3MFlhbG9PZSsv?=
 =?utf-8?B?OG5BVWtrQlFmNzB0RVdhbloyQlV3RnRhUXBrUUZkRjAxSjNtamE5MUdjYitG?=
 =?utf-8?B?NVRxL3lKTzhCcmUxM1ZSVGhXSGlScVFKM2Q2WElWV241ZHU3dTBLcGs5bjJ1?=
 =?utf-8?B?cDNFc3l6MGdwbmJOK2dhWExuYUtqcWU0SmVHaFY0bGRrclB5MnYwRytLREYv?=
 =?utf-8?B?YnN1UVl6SXpmUzV4TlNncVJqT3IxbWlreDE2R1ljWGRDeEJuZWpHbElpUHNW?=
 =?utf-8?B?d2VvRmN0amh6RlJDQzhrL1V1WkRZQU8raUlmUzNGT09zdzdZKzVXamkyakNv?=
 =?utf-8?B?K0FmdzJOblhyNFgybFhBdmQwU0JJb1p6WjdzbmRDVU1lRHk3T3orU3pDWmp6?=
 =?utf-8?B?dUZqTXhTK3AxZGNHU0Erb1RITjdmZW5EY25vdUNvQ2ZOTEc2M1ZzRHF3ME8w?=
 =?utf-8?B?L1FFMTBPenNJeExodWZ5Z2RiWDdxNnl6VTUwRElUZ2ltSlJvMDY4RUx2K0gx?=
 =?utf-8?B?MjMycHNiYzhjNHdnakxFbEtQWGtWb3VHTFhQdEU1a0xmb2dWWTNQcWtkY3BS?=
 =?utf-8?B?cVNES1EyMzNUcnJFRWN5MzNhWFNROG1CUUd3M3duOUZ6N0N4NWNKOHZiNEta?=
 =?utf-8?B?dm0zNnJtZjEzNFJlMTdpM3JlY1Q1SU5RK3VQZlgzdFI0Qkluci82amU5cHJZ?=
 =?utf-8?B?cUVaNzU4cU5ReDNlT3BqMGlIK3U4RHNJVTV6QmEvZWxYVFFwMFo4ZC81WDRk?=
 =?utf-8?B?bThKU2RkODRLdUY1R0YwUGdwVkNQdzlNQjZ5N090Y29JTFBaTEo0RW9oc1Vt?=
 =?utf-8?B?NlYxc1NROFh3bHR1R210UmJkTjJVOTF2ZUdsMW1OWXF6Sis1alV5aWxmSUpP?=
 =?utf-8?B?SUZWeFpkb1UvMC9DYmgvaG1xSDNWZDArdjFUT1pUNGFTbGRuY0Y3enJPZDUz?=
 =?utf-8?B?N1loL251NTJpMHRkYTd1Nlh5RXFnOFpoYkt2d1QycjRaY3BWdWpEWEhSY3pE?=
 =?utf-8?B?VVZVclV4UTNVdTdCc2JVNmlXNXBWNTBET3l2U0lMK1ovSnNHMnZ5UUtDc0Y0?=
 =?utf-8?Q?dNk4U0yN2fGkbJ8/Zf1IGG0Mr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9b91b9-237f-448e-d706-08dbc43ac007
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 18:01:21.3848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMov4Lcs9zCLHT3UttBKkD2Ues80wiNoIiqq9vNL0nTS+gyDu3AiFZjotqLYMDUo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/3/23 10:28 AM, Divin Raj wrote:
> Hello,
>
> Thanks for all review comments.
> It makes sense to incorporate a variable-length buffer size. However, we still require an implementation that can successfully achieve this objective.
>
> We will be investigating this matter and will return with a feasible solution.

Thanks.

Here is the previous effort:

Series: "Enhance virtio rpmsg bus driver buffer allocation"

https://lore.kernel.org/all/1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com/

There was discussion to revive the patch and the activity is still pending. This can be good start if we want to achieve it.

Thanks,

Tanmay


>
> Thanks,
>
> On 9/28/23 5:10 PM, Tanmay Shah wrote:
>
> Hello,
>
> Thanks for your patch.
>
> Instead of having this in Kconfig, It's better to have buffer size decided dynamically. Probably by resource-table.
>
> We still need implementation that achieves that goal. Meanwhile  I think it's best to keep buffer size fixed.
>
> Thanks.
>
> On 9/28/23 10:38 AM, Divin Raj wrote:
>
>
>
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
> From: Peter Hoyes <Peter.Hoyes@arm.com><mailto:Peter.Hoyes@arm.com>
>
> Replace the MAX_RPMSG_BUF_SIZE and MAX_RPMSG_NUM_BUFS #define in
> virtio_rpmsg_bus.c with the Kconfig parameters CONFIG_RPMSG_VIRTIO_BUF_SIZE
> and CONFIG_RPMSG_VIRTIO_MAX_NUM_BUFS, allowing user-provided customization.
>
> Making both the number of buffers and size configurable facilitates aligning
> memory requirements between vdev-buffer and vdev-vrings for client drivers
> that require larger buffer sizes, for example.
>
> Signed-off-by: Peter Hoyes <Peter.Hoyes@arm.com><mailto:Peter.Hoyes@arm.com>
> Signed-off-by: Divin Raj <divin.raj@arm.com><mailto:divin.raj@arm.com>
> ---
>  drivers/rpmsg/Kconfig            | 23 +++++++++++++++++++++++
>  drivers/rpmsg/virtio_rpmsg_bus.c | 27 +++------------------------
>  2 files changed, 26 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
> index d3795860f5c0..677f4a1ac8bb 100644
> --- a/drivers/rpmsg/Kconfig
> +++ b/drivers/rpmsg/Kconfig
> @@ -81,4 +81,27 @@ config RPMSG_VIRTIO
>         select RPMSG_NS
>         select VIRTIO
>
> +config RPMSG_VIRTIO_MAX_BUF_SIZE
> +       int "Virtio RPMSG max buffer size (in bytes)"
> +       default 512
> +       depends on RPMSG_VIRTIO
> +       help
> +         This option allows you to configure the maximum buffer size (in bytes)
> +         for Virtio RPMSG communications. The number of buffers will be computed
> +         based on the number of buffers (CONFIG_RPMSG_VIRTIO_MAX_NUM_BUFS)
> +         supported by the vring. By default, it supports up to a maximum of 512
> +         buffers (256 in each direction). Each buffer consists of 16 bytes for the
> +         message header and the remaining bytes for the payload.The default values
> +         will utilize a maximum total space of 256KB for the buffers.
> +
> +config RPMSG_VIRTIO_MAX_NUM_BUFS
> +       int "Virtio RPMSG max buffer count (even number for TX and Rx)"
> +       default 512
> +       depends on RPMSG_VIRTIO
> +       help
> +         This option allows you to configure the maximum number of buffers used
> +         for Virtio RPMSG communication. By default, it supports up to a maximum
> +         of 512 buffers (256 in each direction). Please note that this value
> +         should be an even number, as it accounts for both transmit (TX) and
> +         receive (Rx) buffers.
>  endmenu
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 905ac7910c98..87a9a4fa30e0 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -109,27 +109,6 @@ struct virtio_rpmsg_channel {
>  #define to_virtio_rpmsg_channel(_rpdev) \
>         container_of(_rpdev, struct virtio_rpmsg_channel, rpdev)
>
> -/*
> - * We're allocating buffers of 512 bytes each for communications. The
> - * number of buffers will be computed from the number of buffers supported
> - * by the vring, upto a maximum of 512 buffers (256 in each direction).
> - *
> - * Each buffer will have 16 bytes for the msg header and 496 bytes for
> - * the payload.
> - *
> - * This will utilize a maximum total space of 256KB for the buffers.
> - *
> - * We might also want to add support for user-provided buffers in time.
> - * This will allow bigger buffer size flexibility, and can also be used
> - * to achieve zero-copy messaging.
> - *
> - * Note that these numbers are purely a decision of this driver - we
> - * can change this without changing anything in the firmware of the remote
> - * processor.
> - */
> -#define MAX_RPMSG_NUM_BUFS     (512)
> -#define MAX_RPMSG_BUF_SIZE     (512)
> -
>  /*
>   * Local addresses are dynamically allocated on-demand.
>   * We do not dynamically assign addresses from the low 1024 range,
> @@ -902,12 +881,12 @@ static int rpmsg_probe(struct virtio_device *vdev)
>                 virtqueue_get_vring_size(vrp->svq));
>
>         /* we need less buffers if vrings are small */
> -       if (virtqueue_get_vring_size(vrp->rvq) < MAX_RPMSG_NUM_BUFS / 2)
> +       if (virtqueue_get_vring_size(vrp->rvq) < CONFIG_RPMSG_VIRTIO_MAX_NUM_BUFS / 2)
>                 vrp->num_bufs = virtqueue_get_vring_size(vrp->rvq) * 2;
>         else
> -               vrp->num_bufs = MAX_RPMSG_NUM_BUFS;
> +               vrp->num_bufs = CONFIG_RPMSG_VIRTIO_MAX_NUM_BUFS;
>
> -       vrp->buf_size = MAX_RPMSG_BUF_SIZE;
> +       vrp->buf_size = CONFIG_RPMSG_VIRTIO_MAX_BUF_SIZE;
>
>         total_buf_space = vrp->num_bufs * vrp->buf_size;
>
> --
> 2.25.1
>
>
>
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
>
