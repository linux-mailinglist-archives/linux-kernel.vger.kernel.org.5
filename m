Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4859375B4C5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjGTQoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjGTQoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:44:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8C419A1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9OfYleDQkVBt8sXbfXxP1DE1c84zrCeOf14R4ZbjH74dO6lzd41ItaiLnIXVlKG/R1gEoDh8H59nHh6+gr8SGwUGolAJKYSKI/3IcxsEGiA1bd/oVS00Ui+G8P77vkkOuN8G/uZ1evoQDZTJKLkRULiKvRFpLlWwhS54rOJCY9Ro+cWBTPXhvJJXDJ9NafO8ji0J6/UqawRjJXsHkJkjxWDSnc/4dgawadCOcwskwsRriQaALK7UE7Z+zUJKpfulJ1v5xoTPrxnSws9faLDTFcKTlXhZ7il0G+CyTIvtsT7L4SHVhJlptFYCgLUhj304lbQfGgUR+G9Wlf0B9e/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77y4nqgRG3VPfB+i9VDLwPuNNpSUn8MbdRrIoJRGtI8=;
 b=QoI1p3jP9WHFPVTxnUQwF/rxtH4xl3BHEzevyKhyPXo/SrFunm0Oy8Pw61GkhWFx0FRODKpqTEjVk1bVH8zC/nedhjWieGdBdrD1WXbUSfXz2ferSw0zbdPzKaLVYndv76G8mOaJD/wgKSfFEUKC/Lv6iOJL2Iy9M7AZ7ycwpmqm8YCVpvDLwMe0y+pLSf4Tm8yGPQX569xZAA1/s17ZlHFLLayFkeslqwcQwfkydiZNhZ62yQyH4k/B8XFuLCIZsQO6YF4RUzUvNPvTg2yV9nwElnNpn3V+NNDvuPU51elBpByFgrNtrBJzAH3M2CgOi5uRH2XokKBmlXZqb4Hzmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77y4nqgRG3VPfB+i9VDLwPuNNpSUn8MbdRrIoJRGtI8=;
 b=ew9QwA8JcmPCMyB4VUph7AS7J+Ky9dWfKPlmT0INffLT0cdD/oKiH5Qzs9ccxhAMDoJHDrLOs/j1EFUbnJTXLFhzihGZ0XGy3K8OcSfsaH1S14b5ZYCYdc0UZIhimznLisZDGF2Het3uzyPVyAgmMDHXGyxk8lVIz+dK3adxbufyxV47Et3yvwN9RAqmCX+Tw5L1FLXteA9jtwOOTsdbZYT3rxXlPOmrICKCU6b9qpm4QNgq/dQhdLsJchZI1/e7Msh8X7Qa0ywo0ticUrX2y8u5lP9oVPsygsCAwJZKfHtubmUa12wIVNRauO8MacHKD/TBbZ5SvBcjGbtIN542dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by MW3PR12MB4588.namprd12.prod.outlook.com (2603:10b6:303:2e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 16:44:01 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260%4]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 16:44:01 +0000
Message-ID: <a6bf9478-af97-4f3f-7600-1c52e27242bc@nvidia.com>
Date:   Thu, 20 Jul 2023 12:43:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v1] virtio-pci: Fix legacy device flag setting error in
 probe
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Bodong Wang <bodong@nvidia.com>,
        Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
References: <20230719154550.79536-1-feliu@nvidia.com>
 <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
From:   Feng Liu <feliu@nvidia.com>
In-Reply-To: <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::26) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|MW3PR12MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: 22151725-0b23-4468-3179-08db89408597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pfm6h+cFWchrY3vBFaAm/zrjQ5IG+dFpLEXr/vBeddjfRBOExy4mikK1MQRNymkub2pLawAo1yAdjY+5R0qEbCGStpU0dgVugPyWE2ZWL8FByUtFTEV0KP0JMuSCaat+PEkGR/tNiFOkeb3uRrVfrpHhf4hYEr8/LNfCjmOusTfKVUotmrU7eyXGqlkEWdCF+2wGK8fxyJi8kHILSsj6F7ISpGVLVwaDRYYRBoZB4KjA7CeFXtmKTySXFkg7prxU8GhENOwurMoEIUUhHw/irhI9dHA2rVfSwwInC5iXvvX5+vNgqu+vWmhcd0RLP19ISNR5CUQudGhcraPah8ruT/L2YBGiveYVrRxLc7fqu/7Si5VzUICDWyBzFlfKYp6Ic1DkwNVpIAdAevCcrc87zkXJqoH+QRUr6I5pL00wJblRhrble2onTv1cCT2hs7HBVkaLFiiEawIv+HUa46DdTsB0YeqAZ/Ytm7J4zGSWusBRbPaX+swOMUlL1lguFK/r52nAbTCBwODWZ3muSOD2pspzhDE9yKkrYWY87rNeU3O9r5NweET0ggKCWMSz3mepXoyq/jG1hiQ4WcZLW1axJ2FmQG/QUAu+mMdbMIQ2dAO7HPZVTwmijByIsEs/9OZ2+6+EMIpIxyZyZPTAD8f1nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199021)(31686004)(54906003)(478600001)(6486002)(6512007)(6666004)(36756003)(31696002)(86362001)(83380400001)(66476007)(2906002)(66556008)(4326008)(107886003)(2616005)(6506007)(53546011)(186003)(66946007)(38100700002)(316002)(26005)(6916009)(8936002)(8676002)(41300700001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEtOUDZaVENvdTE3SU1IYk9YZmNWaFB1bXJYSHRHZE5yK2hBWnFSLzltSy96?=
 =?utf-8?B?WWlraXVPVTZXZjhRWGFEMFAwUXlTM1UyTm9FOU1wS3luMVdYNGJUaWJzOGNK?=
 =?utf-8?B?N05WZUpiZ08wcWQ4YVdISGJMK1F1L3lmVnhta0p1R0xiT1orL3J5MnVpcno5?=
 =?utf-8?B?dGZIcnc5TzMzMDRsSW1KUmFzZUJDeGd6aVZ2ckJ3dS9UWlhyWkVXUTR5UGx1?=
 =?utf-8?B?YmVTVk84TlZ0eHpxTW1jakZWQzh3bzZkaE5QNHFBMmY2WTFFemhDUlhENWpN?=
 =?utf-8?B?L3JGL1ZuZnJEcGhWRk1FR2RmLzFmSFhpcEwvUFQ4TkFuK0l4QUFhZTFHcWhQ?=
 =?utf-8?B?V2l1UWRBWlhIdUpiOTFwZzZVTEE4TkxMR1I2RU1Fc3oxTjFqd01TUE03eHlJ?=
 =?utf-8?B?T0FySXlXMUNsc05VY2ZXZVgvVkpxaDJZMldueit6RVdrRkQ1Y1pCMWlETkUw?=
 =?utf-8?B?aUFXTXZGdzJ5aVpOaXFFNmloWncwY1N6VFYxNXdqU1dhWUtmdkNPUkFmR0lE?=
 =?utf-8?B?YjQ3OXRmUzNhWTFSQTZDc3RseWRYMHhkTkJEMG1EaE5aVU1YcVNrK0dPUi8x?=
 =?utf-8?B?RjB5Ly9naEFoTUYrMlZ2RzBCVlREeUtnaWhvc0llMjYzWGFTRGF2emZaelho?=
 =?utf-8?B?R3B0bUNFT0xTbC92UzBxSC9ZVzVsWEpINXRqMUlNRUZ6eWMzWExXYmF5ejNo?=
 =?utf-8?B?b3ZQN1o2S1gvNThKSzJ1UHNUY21uNVBpSTc1WEVkMjlUL3hkQzdQTEZ6YlAy?=
 =?utf-8?B?eDlzUXNVM3YvLzVxdEk5Rmt6RkxXQmQyS3J4RnYybG9tbTRXSndtYVU3TGxH?=
 =?utf-8?B?ck9Gdi9lbmdNSlRaRWo1YzBZWnRGeHpKbjR4a3pFdGVBbHVnN3JuNHRSRmNv?=
 =?utf-8?B?ZkY5aDF4MHFRcEJGeFdpY1g3Q3MrRlByNlNiR25FZlVoZS9qM1BoSFNIOXdF?=
 =?utf-8?B?U3pBbHFjY1NHNkxEUFVveU9FYWZkaXJoUFFxTjhjY1RuOTNDK2p2MjJyd3pr?=
 =?utf-8?B?SG5FQUY4OXVNS05wQUYxbDVtbUVnL0RoOHRta09HMGtIaTYvYUhieTZSS2Ro?=
 =?utf-8?B?aU5STC9hS0ZGRXdPdk5ZVXM0RFRqNjUvdlk2NCsveGxOSVBxZ2tLV0ZZZG81?=
 =?utf-8?B?Wll6eDlxajAvZ2R2Mi9PaE5VTXpGb083ZWtaSmdqaHhXR1pDUG9QNkhLdUtK?=
 =?utf-8?B?U0JtQ29SQ00yREZPMEtiZlh2K3R3eXFYc21DN05BckoxVzJOcHhQL3R1QU91?=
 =?utf-8?B?UkRFRFc3UWcvRDIxSDZEbG1BZnhnQjQwSDJBSUg0Vk90YjhZYkNxZ0ZJbmJn?=
 =?utf-8?B?TVRFUk5LdTNqZzAwODFGbllJSWxKOHFxTkZpRmFXUTQ2aUoxc2xZVFM5OW1P?=
 =?utf-8?B?Q1gvRGluMkpPVU0xRHRqR1Azdk5NZzhtaThuaUlsRUJ5czc5VFJ2ZmhiamJ2?=
 =?utf-8?B?cGZuZlhnbHFuMmJmOXUvQkgrb0hXRjFlR3I4aEFrK1AvcGZ1eHRkUFlTZlRq?=
 =?utf-8?B?RXNVMUFIUS9IWUVCUHJmQjFyVjdlazl3UzQxazhCTm41QkxpaUZNY05nUFJn?=
 =?utf-8?B?aS9EL20zMlk4cUJqODV1VElOZTBGOXkxZnl0Z2hmS1JUZnNKeXQ1Q1k1MVRF?=
 =?utf-8?B?TytpR2FRdWUxOHZnTlp5OTVSdHNoai9IQ01tQmMxMWJpMG9zMHl5bkpDaXc0?=
 =?utf-8?B?aWRickZOeDlHQzJDTGttNHQvSERHdVdSTk9VQ2k2UlZRamtpbEE3NE5FM1p4?=
 =?utf-8?B?U0x0emdlbEx3ZGoyUFRyaWkvV2hOWVVvc2h5NFEwakZMaXpSNXE4ZGFsMk1J?=
 =?utf-8?B?SEhjaVV1NEN4ZWdsZGlLNTM4cGxQbmdyZDQrTVpXOVJ6Qmg4bUhGUDZDZ3Fy?=
 =?utf-8?B?NTllV3lHNVRNd2J0WjhwdUxXNzd5WjVVQXFXT1RVdmJOblcwRzRZSkthK2FR?=
 =?utf-8?B?UGxEMHFBNVFsbkJsdk5OK1dYVzk5YTIyT2lmV3lrTm8wcDNpNDhpQnlYQ25a?=
 =?utf-8?B?bFE5bzVQYU5uaDVjbnRPSGpzdjBhV01MUllma0c0QlpwbE5yOUpUWmhVWGtn?=
 =?utf-8?B?RWdTUlR2WTdJeFRkYWVoaFBtOTJSb09zUnFOSnBjTmNKSjUzc0V4NVB4cENv?=
 =?utf-8?Q?ua9sgfHhMJGgha9r9skPvG/Mu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22151725-0b23-4468-3179-08db89408597
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 16:44:01.6530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0s8It8lODzLRg0OBcZRRkfJkJTdjFeipVwibmuV9d0lwNCjIywz8endU+qPbXQtrLMxtxs05mMkDVgiE/ORjSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4588
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-07-19 p.m.10:27, Jason Wang wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Jul 19, 2023 at 11:46 PM Feng Liu <feliu@nvidia.com> wrote:
>>
>> The 'is_legacy' flag is used to differentiate between legacy vs modern
>> device. Currently, it is based on the value of vp_dev->ldev.ioaddr.
>> However, due to the shared memory of the union between struct
>> virtio_pci_legacy_device and struct virtio_pci_modern_device, when
>> virtio_pci_modern_probe modifies the content of struct
>> virtio_pci_modern_device, it affects the content of struct
>> virtio_pci_legacy_device, and ldev.ioaddr is no longer zero, causing
>> the 'is_legacy' flag to be set as true. To resolve issue, when legacy
>> device is probed, mark 'is_legacy' as true, when modern device is
>> probed, keep 'is_legacy' as false.
>>
>> Fixes: 4f0fc22534e3 ("virtio_pci: Optimize virtio_pci_device structure size")
>> Signed-off-by: Feng Liu <feliu@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>   drivers/virtio/virtio_pci_common.c | 2 --
>>   drivers/virtio/virtio_pci_legacy.c | 1 +
>>   2 files changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>> index a6c86f916dbd..c2524a7207cf 100644
>> --- a/drivers/virtio/virtio_pci_common.c
>> +++ b/drivers/virtio/virtio_pci_common.c
>> @@ -557,8 +557,6 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>>
>>          pci_set_master(pci_dev);
>>
>> -       vp_dev->is_legacy = vp_dev->ldev.ioaddr ? true : false;
>> -
>>          rc = register_virtio_device(&vp_dev->vdev);
>>          reg_dev = vp_dev;
>>          if (rc)
>> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
>> index 2257f1b3d8ae..d9cbb02b35a1 100644
>> --- a/drivers/virtio/virtio_pci_legacy.c
>> +++ b/drivers/virtio/virtio_pci_legacy.c
>> @@ -223,6 +223,7 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
>>          vp_dev->config_vector = vp_config_vector;
>>          vp_dev->setup_vq = setup_vq;
>>          vp_dev->del_vq = del_vq;
>> +       vp_dev->is_legacy = true;
> 
> This seems break force_legacy for modern device:
> 
>          if (force_legacy) {
>                  rc = virtio_pci_legacy_probe(vp_dev);
>                  /* Also try modern mode if we can't map BAR0 (no IO space). */
>                  if (rc == -ENODEV || rc == -ENOMEM)
>                          rc = virtio_pci_modern_probe(vp_dev);
> 
> Thanks
> 

Hi, Jason

In the case of force_legacy, if no IO space occurs, function will return 
directly after vp_legacy_probe, and will not run vp_dev->is_legacy = 
true; because vp_dev is allocated through kzalloc, the default 
vp_dev->is_legacy is false, which It is expected for modern device, so 
it will not break modern device.

What do you think?

int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
{
[...]

	rc = vp_legacy_probe(ldev);
	if (rc)
		return rc;  /* if no IO space, function will return from here */

[...]
	vp_dev->is_legacy = true;
}


>>
>>          return 0;
>>   }
>> --
>> 2.37.1 (Apple Git-137.1)
>>
> 
