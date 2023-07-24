Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5179375F801
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjGXNOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjGXNOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:14:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6743DD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:14:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYHwfwGxNnPXuqfVmmqJmVLn3EBlFeTf4mlkM3i79T01P6iM7tMTDZO4FqTOwxWKMSSFq1DMhQCgRmtouM7/MQqEUGZpzhqlHIdo9+zfVCt+6O90tebw0ye01FOHq2RANyZo3jsS4n/duotBv6xaqiCwVI0VoE++IXjKbHwSkypjivea8VezOoFgyk3MJGWsnQ6uAJbOtQk37tWG/wDYzbO+FotRXk424cqHCou2jNI5H5lMzVPAYpRW2dRjL1IDUuH8FuE0UbvBgDMWQen9VJsOdJLVTQXHlEasmfsi6+xv8U+raNGEA0tXJpAUpkzOFo23+j2YoFgKh8svEc74Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xkb6FTw2EvmbfzjF9UZXK8QcBZzSlB4/HmIaOI6Jj5Q=;
 b=Wsm4lYUvc5YjuMjb+NRWNsE0tIz23LI15PCj5zzKBGUp0evvlE4U5jLM5xnQGOynLSTfhjZVM1jjPuNbfpiUNljOLJXw7Cz48yG1Ne+4cH0sKl37puhfT8ETCOdFZx8SbWPouLCg6aoYJwUvAq0ccCT+a/J5EjuFlP5j2mKYgKx7zgk7sEIshrPWwUH80hAu+oYHFTvJ1AcjZOB5smsrfSCwmjbDrChaBcyCRALPLym7kaYNKPthJkakzikjBA033YcobTpn3Wp8FdGgl3389yfyxG9lgTgg98xo7veccavVHSLPwpQx+iU3SKykYAW/+3zqwTbFk+ihh2o97Wia1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xkb6FTw2EvmbfzjF9UZXK8QcBZzSlB4/HmIaOI6Jj5Q=;
 b=B3FDKSk46F+OL/NCvI/BfUtew7uLEYzyrYzLX8IKxRTP/kPJzn0ueCFAZiAIhlqai3iymvr9EYkRreyioYRkB+fchjzCKL3jpfWh2oaaVouijLLiLEgBCQSGftgb99oq9Jyc6TMv3AfVbyT+VASG+3x+wcFeLOFWa2TNhsdbm66WqPDYwvtDYCdPNgMBQLmp20HXAKC4iqVIhgB0kvAxBL1fryZTfTinojDqIwG+s+ZkrSNv/AqzFb1MvaD7cbadytx1EWgXGFYNrJDa0cbNBipnZJUt+kConPbFXZ88R7/xPboVUagzJyTtnleJD6wbUakawicqnhGb/m0i+pfVmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 13:14:36 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 13:14:36 +0000
Message-ID: <c1bfdfd3-e7b5-56dd-39a6-b93c43da42eb@nvidia.com>
Date:   Mon, 24 Jul 2023 09:14:29 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v1] virtio-pci: Fix legacy device flag setting error in
 probe
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Bodong Wang <bodong@nvidia.com>,
        Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
References: <20230719154550.79536-1-feliu@nvidia.com>
 <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
 <20230720131423-mutt-send-email-mst@kernel.org>
From:   Feng Liu <feliu@nvidia.com>
In-Reply-To: <20230720131423-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:806:f2::6) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: a1554f7d-f2b8-4b1b-5d7d-08db8c47edc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWtOLxo2vmh+Phf7CwJGuX1hWmYEJK321K0oEGZp9i+sjHEsyWm6SbMuTjTbZBVtn11XPvgnroy8/EOSSvAkt0r2tV5XKLfe743rMBJV0hMU2+/6EaIPIP6rvvEtAn/mFHHBD6lqoQ97QfxQpWuaFRy7+BUBX6Nz4MFKBmEeK5dGe4zm62Tf0uiFbcXTR2383NGrAdB6xkQ6R3WkSdmiqorXVbslrrNKSJ4oyPplek9TLoicYgOoUkJfIPctbhinXei1aCb1WaH7DNhu8LUxPQdk0rf4jZx9klW5x00jls33bk5cT2vR+bgPz+FSDnI9qN1X8poGMnZviIzf92sWaYp6WmKOyBI5zuK/D9h9PLdtDzGiJoLLW3mENcSZU8MXkFoQqtYN5YaW2EZVWNrGgSeYH4/PgDQV63PsFKd+LYA4dxY1/6zBnrHiSkjqBtxGSjXFlFjAc9WpTn0LT/PR1JulWaSYU9uSYg0agEV1rDhADLLo3gp7GieqrEybdIvvnC6ByXksy0Ywya6kv3b62/Uaw7Ce7qWfaBx15aXONSoZQzKO8LGe6n+EOO9RjxjsS8pjXSo0euxmr7CxRGi/E8hAyawV7MOH2xs7qGUODs12fnA8v+mHtGvFdjw4alkdjQ7v+ZG14NPHRqP/LiiE3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(38100700002)(53546011)(2616005)(107886003)(36756003)(83380400001)(8676002)(110136005)(8936002)(5660300002)(478600001)(54906003)(66556008)(66476007)(316002)(4326008)(66946007)(41300700001)(186003)(26005)(6506007)(2906002)(6512007)(6486002)(6666004)(31696002)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1AxcnhaNEswTlhBNnhUczNySnlHTVZnNFFKbmNSSUUwV3hmUmh6OVlYcitW?=
 =?utf-8?B?a1lDdUJsSkxiVTkweXdwRWZtUGFyaVRFaUNHMXcwVkhMalIrd3VBQ1ZtZ0Vo?=
 =?utf-8?B?dEtNY212ckphQmVGMXNCVThPTEpML0JuQnNzNExjWFU0WEh4K3NSTndDUC9n?=
 =?utf-8?B?RTBwd1ZyU1NjSmdWQk9vcjllKzFISTZjY1UrSXNuK3Q2SVNkSktrN0IralJP?=
 =?utf-8?B?U1dqbXdzcVB2Zk1CTitIQWxndnd2RnRjK1FCVGxrOTJRYldJQ1NhSDJjdmdW?=
 =?utf-8?B?UzcxRzZ3S1VKNklOMjFUUnBOR2Yxb01ORTBYWmY3R2FSZ1BJSTJCUXZQdWV2?=
 =?utf-8?B?MkFPSzQ2V0ZZcENNZGVvenlWWVNySU1jam40aER5cEZtOUdEM2pUR1N2aUJi?=
 =?utf-8?B?ZUg5YmpwVlJadHBwdUt4NnlvSGUyR3poWG1GK2kwNHpnTFNSOUVuemNpUENy?=
 =?utf-8?B?MTdaeTRoaGtCR0laWDFSVWpManRrbUlaUThmRHFwWlVMck1EemN1c25rRmVF?=
 =?utf-8?B?b2hmcDV1TEJ6Rk9vUkZjUGxncnNkWk4xWllyT3NIY3FZQ1dqVVp2akN1WDRP?=
 =?utf-8?B?RHpUbWdGbE1SSTVkb3RIYUwrK09SUy9LV0J3dTBMS2pTRTR1ZnMyeVFZdmZK?=
 =?utf-8?B?YkdRVmhiMHpRdzdFbU9tKzFhWVoxaXZGVXhhaGMxdDhrUzlpTEdFcW04WWZC?=
 =?utf-8?B?ME1wUitVZDhaSWZpZFVvdmdDSzZhKys4THdYOTk3V21yaGtqOEk0SVIxN2NS?=
 =?utf-8?B?OW5NL1I3a2RpS3I5dVlYSnZUUXNpR044QVFwWFluWnVJYnY3eEkrRWZwaVpN?=
 =?utf-8?B?Q3A0ZkFGOU40bFkxVVoyVXRmQ0dwbXFkajFJNEZjbTJJVjZJQ2hsR1FQUlZ3?=
 =?utf-8?B?Zy9wbjZyb1BKNzNsTmx0TFNUY2pvUmNCZGF3Q0dTbGR3bFlhcXRudjF1Y1gv?=
 =?utf-8?B?QXJHL29IN2ZPTnJwMXNUYUxodGZ2ZkUwQ1pkN2NEd09WTEg0cm1ISC9YMlVZ?=
 =?utf-8?B?YXBBeDJjYm93M2dqeHV3bGhnd0pmTTZOSklxYjYxb1R3ZXNhbjRJaHBxaVZW?=
 =?utf-8?B?QTU1T2ZkcUZROC9jb1p2Y2JlVnZ6VERJdENFT1k0NXM5bXZBRGNwemRsMncy?=
 =?utf-8?B?YVBxUk5CWUlObjhQYkE3SDFqUDd4R0N0a0pJazlXakgyYmtoWG1mQ0RZSC9m?=
 =?utf-8?B?aVQwMG84NVdBTTJycUlIRTR1bzBNcjBIaVJNczF5TXhUaUFncnI1aExmckFu?=
 =?utf-8?B?bVhpbVZBYzQrTElwWWkvTUkra3duNFJrdGJuZklUQlJwMTQxQTVYazl0TXBE?=
 =?utf-8?B?NVVDUXJIRVl3a3J6V21MZHM1aFQ5Wk81Y1VvL1RBRmRqQ1o5dHBSaHNuRm1y?=
 =?utf-8?B?OGZjL3pJZjRHZlBBSlhBYU5PMCtRZ0ttTkVXVWwyRS82SFNhUktyWmxpaW1l?=
 =?utf-8?B?SFRyNjRzWUUzbStlNmsvVlZkdmxDWTZIcVdpWkJ1NWJkVUhxVFl3RWs4dTk3?=
 =?utf-8?B?a1pFenlsRUVTUTAxRHFBYVRLZExxcVJFazRxWXRJNEhCS3doNDdoVUhVdDRl?=
 =?utf-8?B?NFBBbUJ4UHFBL1ZBZGM2c0dteXhBQ3hEdmlORDEvdjZWeTBCTkJrZzMvdzBL?=
 =?utf-8?B?cncvbjYxS0paUkNOQjRmZ21IOSt1MERla2J2ODZQdEpiSUJQQkRkR1o4U0I2?=
 =?utf-8?B?WFdGUU4wUjVLQk9FMWd6UUNVYllIMXptazlqREUxem5QK0dvK284aVhNSGNR?=
 =?utf-8?B?Rm8wb1VVQmtKSkllYjVwNEpDVnN6RGhUOHBoWTJDMEllUFpQTlBoeFlCVlNv?=
 =?utf-8?B?QWl3dFF5TEFDS0ZvNmJtcGFaYUREeTNXYm1BM1h1N0Z5UEQ4NEE3QWlJQ1Vl?=
 =?utf-8?B?U0hXZ3F0OWlkWFYxSUtRUzZhaHBRWityRU83N0dkcUJ1dURINCtUT1pIak1C?=
 =?utf-8?B?NXNzU2RLM1JjZFZQWmlnNzkyU1hLKzdCYkxmZnNzYnBjQVJ0OHI2eCtiNHFB?=
 =?utf-8?B?RFg0NStjNkNwWGpYVmhTcmtveXl2QWhoaWJNM3B3ZFg0Q1FFYnVadXVnY3ZG?=
 =?utf-8?B?a1JhaWRiYjlkNVNCNlZ1T1ZyVTVsazN6U3hvc2ZQaW00ekRUMUI0empWS0VW?=
 =?utf-8?Q?x1e5hGiAFR3HDxMoZnrn2GP2d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1554f7d-f2b8-4b1b-5d7d-08db8c47edc4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 13:14:36.4859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUrcr3/9imyy0za8mmy30nhi3TK3em+Mlv7oVgA5tXh/X6uN9LfLCaEGFelmeQYVOzKqwnW3Je/NmDDy12dgPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-07-20 p.m.1:14, Michael S. Tsirkin wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Jul 20, 2023 at 10:27:04AM +0800, Jason Wang wrote:
>> On Wed, Jul 19, 2023 at 11:46 PM Feng Liu <feliu@nvidia.com> wrote:
>>>
>>> The 'is_legacy' flag is used to differentiate between legacy vs modern
>>> device. Currently, it is based on the value of vp_dev->ldev.ioaddr.
>>> However, due to the shared memory of the union between struct
>>> virtio_pci_legacy_device and struct virtio_pci_modern_device, when
>>> virtio_pci_modern_probe modifies the content of struct
>>> virtio_pci_modern_device, it affects the content of struct
>>> virtio_pci_legacy_device, and ldev.ioaddr is no longer zero, causing
>>> the 'is_legacy' flag to be set as true. To resolve issue, when legacy
>>> device is probed, mark 'is_legacy' as true, when modern device is
>>> probed, keep 'is_legacy' as false.
>>>
>>> Fixes: 4f0fc22534e3 ("virtio_pci: Optimize virtio_pci_device structure size")
>>> Signed-off-by: Feng Liu <feliu@nvidia.com>
>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>> ---
>>>   drivers/virtio/virtio_pci_common.c | 2 --
>>>   drivers/virtio/virtio_pci_legacy.c | 1 +
>>>   2 files changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>>> index a6c86f916dbd..c2524a7207cf 100644
>>> --- a/drivers/virtio/virtio_pci_common.c
>>> +++ b/drivers/virtio/virtio_pci_common.c
>>> @@ -557,8 +557,6 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>>>
>>>          pci_set_master(pci_dev);
>>>
>>> -       vp_dev->is_legacy = vp_dev->ldev.ioaddr ? true : false;
>>> -
>>>          rc = register_virtio_device(&vp_dev->vdev);
>>>          reg_dev = vp_dev;
>>>          if (rc)
>>> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
>>> index 2257f1b3d8ae..d9cbb02b35a1 100644
>>> --- a/drivers/virtio/virtio_pci_legacy.c
>>> +++ b/drivers/virtio/virtio_pci_legacy.c
>>> @@ -223,6 +223,7 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
>>>          vp_dev->config_vector = vp_config_vector;
>>>          vp_dev->setup_vq = setup_vq;
>>>          vp_dev->del_vq = del_vq;
>>> +       vp_dev->is_legacy = true;
>>
>> This seems break force_legacy for modern device:
>>
>>          if (force_legacy) {
>>                  rc = virtio_pci_legacy_probe(vp_dev);
>>                  /* Also try modern mode if we can't map BAR0 (no IO space). */
>>                  if (rc == -ENODEV || rc == -ENOMEM)
>>                          rc = virtio_pci_modern_probe(vp_dev);
>>
>> Thanks
> 
> don't see the breakage here - can you explain a bit more?
> 
Hi, Jason

I also think there is no breakage herea and gave an explanation in 
another email, please have a see.

So are there any comments about this bug fix patch? Can this patch pass 
the review?

Thanks
Feng

>>>
>>>          return 0;
>>>   }
>>> --
>>> 2.37.1 (Apple Git-137.1)
>>>
> 
