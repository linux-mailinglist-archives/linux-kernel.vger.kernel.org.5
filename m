Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8939780110
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355765AbjHQWc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355759AbjHQWcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:32:09 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C3730DA;
        Thu, 17 Aug 2023 15:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMgBd5CANvZbkWKWZ3wIjFlb0i7D14F9M58OCu1XDAKxjuga6K/9KEWrdTwAwxqvPh//tioSIYGd8UGvTY3iJ+KaVBKizoPvB839mp+xdj2TVmMccHHSgO2Mi5Bke6aBdnWQdAJOX74z5Yp0gB514Y0zPBvb4vBGBRZiHFz1cqtUTZ4rY1PqqLyyfxwQcG9mNx4JABD5Jv1vqWOcl4gt5irF+nfLQD67NK/mOaOUH8R4WeIBL56RU0ezaYZ9bYr4dfbhE/OBy2gkvQO4jEIxPK4GfhUfjc1Fe5rN5Qy0GaA+f2ihZmcHPgqABjy3mPD1Ah2KjTs+nE5u8PbvjS/GSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AlY+u8pRgaFSMWlxy8NYuGYYo13nDpDHOdQcLXc9NI=;
 b=HGSqnF6QMLMC860HRZSGcnBsPk/7XDJlxxbKBRibonCgGvqYw+bt69D2qe/R0mHk7/+DGoSfN2vQoHEnTB/nwCjMzCQSQxahR+NHr/FwsIWuv5OM4dG9tVyGw/XGUEVZXMfdywWlUkr3bXU1bxcLrmfFrcX4mksEWoScjAU3qEOYRjXnJomZwzVOH4YgBQ666iLgNwDtyZvp4GC+KrUonz0NB/yzrqfE39QjfG8ayqhdJckTvqskje6+n3Lr19v8eDVTnGlGN/L4wF2wQ20sdrXD7bIT8H77J4g8omD9UOLgXdqQz4OqSs7A6lmph8PkQpyuvZQOkKkvOd3L+IzmSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AlY+u8pRgaFSMWlxy8NYuGYYo13nDpDHOdQcLXc9NI=;
 b=J2oD2LbukBquTar2iSSO8PL7ejYlESsMrGwotAzTckEzpPinWbOhsGpZcDcnpS39kIR+xv96JbHRhluRRmUxvnynW3rARJe8uvqdYEEYUK65/xrL7fs91/+GRlp5NWsa4CEKL2li4EVx+xsuZEeq21Moz7834fCEY1vQf9hm6CQnWy/du8Pi0BcWJ88w/RrSCbRSfeJYAEfNw3TuCGR+WlLKkRsyZUAN5JrX0h5vesQx3Tol+SeYQxf5nJz/ohO6+Yf0Ez+WSmtLpOFb7PMvVohyA93G1q8jfRVEldAcH4AGkkJwG4imsbdwghCKG7TnUCVYQtnJ6dHvL0xx6dvp1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) by
 PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 22:32:03 +0000
Received: from DM4PR12MB6207.namprd12.prod.outlook.com
 ([fe80::8adc:80ce:6d72:f512]) by DM4PR12MB6207.namprd12.prod.outlook.com
 ([fe80::8adc:80ce:6d72:f512%5]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 22:32:03 +0000
Message-ID: <e71712c2-3f13-e21c-b8f0-c16f61979e5b@nvidia.com>
Date:   Thu, 17 Aug 2023 18:31:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH net-next v2] virtio_net: Introduce skb_vnet_common_hdr to
 avoid typecasting
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Simon Horman <horms@kernel.org>,
        Bodong Wang <bodong@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
References: <20230817151941.18692-1-feliu@nvidia.com>
 <CAF=yD-KN=-2fhc2nxxzr-bJ5kwQVFken_iTo4sBbuAkjmbn3fQ@mail.gmail.com>
 <b2edfbbf-1018-745e-2ce4-946ffe27e5e5@nvidia.com>
 <CAF=yD-LBHYk=+ty1zTNnN_cU4NoJe0=VZwHy2zVkQiPVx_9gqw@mail.gmail.com>
From:   Feng Liu <feliu@nvidia.com>
In-Reply-To: <CAF=yD-LBHYk=+ty1zTNnN_cU4NoJe0=VZwHy2zVkQiPVx_9gqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::25) To DM4PR12MB6207.namprd12.prod.outlook.com
 (2603:10b6:8:a6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6207:EE_|PH7PR12MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3d8680-2cde-4c00-430c-08db9f71c7d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGWeqRVgIRZXhfZbnAw0P3zKIdpmV6gnqmbTmCcON5/9PGpobmjdDGjf1WMDNoLkcYwYYteuQNw1fOuBiX9jkMjqHxF3kIbAwU550sRmDAFNC6H65snHPQrMYMdYJXG0RUr16+i81lTFZgiQ1kZNFypMXrVqQ3Hy5EXB5JqEZRd4VfisPmiPUooW9sHFS1DD66ethYp/MR8p5db07LgUFsjzqR9Mu3Uxmc5xEcmbW93ixNgdFPJ3on/RoxEoFzSUw8lUZ5hyexQuQ6zz5ltx7TdR7EdGojSEEJHeoYO+bWt2I3a+/bDcWDHI6AKv/kqoUAFyWH4By7hH0PcMJsXXzeOiZZKJ1Zqjjr4lRfY/PDqnSrWWatumWnR+5XOjnO0LGITwS5dqSbwng0cFenyvN+Mz15ubQukVaLXv2Z++jWR4EXE6NbwAf/fKeXMBjZdAuBFhZfoGewjAp3TwIxdFfPwxHaoXa9AHktRcvM5rT+zLBtgJysmBYrsE30NArjpGtrOwEmEhuP7/fxX2pYQQA/Xax/PySy03rMrDqzmRJmOiCar8Aw2fjjwCXgqT99Xuvp0YcqXWyVMLCMsZKcZI020veXmJrl83lsu6ya4mZer7Ped6WSAvFohy/9lU24Dx4YEaHgTfw6o4Cr70PhWXWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(186009)(451199024)(1800799009)(31696002)(2906002)(83380400001)(26005)(86362001)(7416002)(478600001)(6506007)(107886003)(6666004)(6486002)(2616005)(36756003)(6512007)(5660300002)(41300700001)(54906003)(316002)(66946007)(66476007)(66556008)(6916009)(31686004)(8676002)(4326008)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmhFQkh5MnBEMmpwV3ZFd0VvaTdQVUVGTUk3ZkQ2Qmswc0NkTTYxWmpIdXdq?=
 =?utf-8?B?R1B6S2FLM1QyMFBZV0lpcXp3a2s2QTVLbE1WVDk3b1RtUDQ4SG1DSCtHSlBq?=
 =?utf-8?B?MmxNWit5RUtrMXpKV3lrTk9WbUtmcUNkdFN4RkExeGU4MUsxMFZGSzN2ODRT?=
 =?utf-8?B?V255N2VXbUM5RHI2MXUvTUkyNGZGV1pWY0lNOGt2dnlFWVZpcE9WNVlJZmRU?=
 =?utf-8?B?dlZGZHk0K1pnODhvYTNNMWJiNmpCOXFmR0M0Tm4rUm5VcDErMThmQW5SZnEv?=
 =?utf-8?B?THJyMTVFWXRtdWJqY013bkk1cUJwK05nN1VCd1luWTBkS3NSQzlRdVJRUkZN?=
 =?utf-8?B?cnl2MnUvdTcyL0hBNmFQRCtvdmhjd3J5Z253STM5MkxPd05XMXZ1czdZa0k5?=
 =?utf-8?B?NXJ4ZnAyN2ZoYUI2WWw2WnQ1NzRGc3RDL2t3bnVDQWwxQ2hZemxkQlVsdlF2?=
 =?utf-8?B?c3FZMERDTkhESkRSdS82eHlKSHc1d1c5Yit1Z1BpVHNwQ2RxQ1BCazJIdXJ2?=
 =?utf-8?B?M3NtQnJYWGxzdXFnbGFCRC8yQTJQV2R4Snh2aDRrSy9KS1NxMzBiVDhzQTgv?=
 =?utf-8?B?aUc4NGl4N0xuSEZwN3dBVytXY3Q4KzJ6NkpibFU4UjdBVS9oeW1qK1lzUmFN?=
 =?utf-8?B?Q0IyMjRoVW5zMTRTaUVpcUFmYzd2bytJNEJwNlBZWjEweHE2SlJCWlVURlIr?=
 =?utf-8?B?SjY5cnhUb1JHQnBOSU91VWJmc3N2NFhVMXYzSlZXa2tNZlVROGRMdCtObkUz?=
 =?utf-8?B?RU41Nk9Oc25LemRrTnB6WnZkVFVLYTNyN2xaUllvUHQ0VitGYi9qdVNmNm11?=
 =?utf-8?B?WURHeGxSbHAxaXIvUzhXVC9Ga1d3WWpFRWtCWk9weFVIMjBYK2VlTHVBeUtx?=
 =?utf-8?B?b2hLN1ZCM0FNcVVzUjA0OCtxdFRja3RFV3J0SDNHTDQzOFFkQjh6L3dvck1y?=
 =?utf-8?B?WUFBc2xacTByejgxM3lVbWFOaG42dXh2d3pHYkpENmRhSnVsckZzNSsvTzla?=
 =?utf-8?B?Z1c2anNEa1E4b1pCZXMvZFdyVnVYYmVONy9MU2Zad1VUYWo2ZEF2SzJWYzJG?=
 =?utf-8?B?VlR4Nm9ENU5hOUpjcEozOXVDV2RNL0IrcE5xRzE0NUNqYUQxaW12TUlyNnlU?=
 =?utf-8?B?WU9DWWtkd01tcWJ1MCtBRVJaeURyZkRjdHAvcS9PU3BQUmI5NE1QWkRIOW9x?=
 =?utf-8?B?SGx3L3FjTkkxcVpNOTkzMTdMdStLUHdkcjZxWndtcU8xb1orbU1DaWJ0NFpS?=
 =?utf-8?B?bVNzMEVVTVZ0aU1od1N0QXd6U1Vlbm93WUNWSlY3L3FXckdiR0VWL0ZjcE9m?=
 =?utf-8?B?NUlOTnZrWHM3VFNVR1h2aVcydmJ4MkN4MW0remlzZk5CeVRHRnNPNmxBeTBO?=
 =?utf-8?B?U1F3OVYxSnZBZWdSWkVHMzBHbEZuMnBxcE12V0VNT3gwZllJblFaRjBJMzlw?=
 =?utf-8?B?NGhJWHQxWlAzNjNUYTFQYUFWbXlDcS9TT3BuM3ZJcFNpTTFnTTVQaDR1Vlll?=
 =?utf-8?B?dXJYRFhKckpNK2w3T3ZRaUJOWk1hNkJscStMRU1kTFF6eU9jZ1hWU0tNbi9l?=
 =?utf-8?B?T0dHc2JBR1owOVN1Ti82b3NTUG50OFo5c3MxOE03ZDVxd2hIa2NGNzVwa3Zz?=
 =?utf-8?B?MU5HWStjWFNEaERWaUJyblA5cUxuaDJoeUkycytzcDRWZzNnbGpINUJaL054?=
 =?utf-8?B?RThKVWZPMUJsT1NBYnFBaDFWeEhYL0tJczZ3MkR3VmRZTWtkM2QwN1NTeDJz?=
 =?utf-8?B?bDRrRlV5OGV1MFZsVDhGcmRKUHRJQlZFdzNxTWpNaDRZd2E3a1kwdVZwZXNY?=
 =?utf-8?B?N2h5eVpuNU1qTUdueVFmMmpGYmxpNUE4Um5yL3ZNQW5BMUN5ekFlNmdORzRJ?=
 =?utf-8?B?Q1A5ZVBjKytwOVJoMmRXZ3BQWW1EckhZU0hzUk00bS94bkplR3NzUWZDY3V3?=
 =?utf-8?B?TmdnL0dvMW81TS9FMGIxQzNNK3BQQTVWS3dvdDVKQWRVeHZCcXg0YW1jQWRM?=
 =?utf-8?B?UXozN3BGOGdsdmNLREdMM2F3VzR6M2ErL3Q0RWtQTUpTWUlGMnNXQ0hxUnM1?=
 =?utf-8?B?cU0raE5nYnQvTVBTS3NIQUd4NWd3clJ2YWVreUxud0k3MjJnTk9Nd0l3c0xM?=
 =?utf-8?Q?Aci4lqKmlxvGgl/OVcVmohFpL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3d8680-2cde-4c00-430c-08db9f71c7d0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 22:32:03.7327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hr9pGE0HTMmgxRracOphNeTnMDmQBQnn7QBX8gBDAldGDmb52rxoTMvqo32leYCKIIE4XyN8wkRKHDVluJLNkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-08-17 p.m.6:11, Willem de Bruijn wrote:

>>> You mean virtio_net_common_hdr?
>>>
>> It is a typo, will correct it.
>>
will do

>>> I'm not sure I follow the reasoning. Because then hdr_len might be
>>> sizeof(virtio_net_hdr_mrg_rxbuf), but sizeof(virtio_net_common_hdr) is
>>> larger. So the same issue remains?
>>>
>> static int virtnet_probe(struct virtio_device *vdev)
>> {
>> [...]
>>          if (vi->has_rss_hash_report) {
>>                  vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash); /* hdr_len will
>> be 20 bytes */
>>          }
>>          else if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
>>                   virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
>>                  vi->hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
>>          else
>>                  vi->hdr_len = sizeof(struct virtio_net_hdr);
>> [...]
>> }
>>
>> When VIRTIO_NET_F_HASH_REPORT is enabled, hdr_len = 20 (as above); and
>> the size of virtio_net_hdr_mrg_rxbuf is 12, so virtio_net_hdr_mrg_rxbuf
>> is wrong, should use struct virtio_net_common_hdr here.
> 
> I understand in this specific instance. I'm just saying that using sizeof can
> be wrong both in the new and old case.
> 
> This does not fix a real bug, as memcpy just uses hdr_len, which is correct.
> 
Already have used hdr_len in the patch instead of sizeof(*hdr)

>>> Indeed, everywhere this patches replaces the one with the other, you
>>> have to verify that nothing was using sizeof(*hdr). Which would not be
>>> visible from the truncated patch contents itself.
>>>
>> Have checked. Nothing is using sizeof(*hdr).
> 
> Thanks.
:-D

>>
>>>>
>>>> Change log
>>>> v1->v2
>>>> feedback from Willem de Bruijn <willemdebruijn.kernel@gmail.com>
>>>> feedback from Simon Horman <horms@kernel.org>
>>>> 1. change to use net-next tree.
>>>> 2. move skb_vnet_common_hdr inside kernel file instead of the UAPI header.
>>>>
>>>> Signed-off-by: Feng Liu <feliu@nvidia.com>
>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>>> ---
>>>>    drivers/net/virtio_net.c | 36 +++++++++++++++++++++++-------------
>>>>    1 file changed, 23 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index 1270c8d23463..03cf744de512 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -303,6 +303,13 @@ struct padded_vnet_hdr {
>>>>           char padding[12];
>>>>    };
>>>>
>>>> +struct virtio_net_common_hdr {
>>>> +       union {
>>>> +               struct virtio_net_hdr_mrg_rxbuf mrg_hdr;
>>>> +               struct virtio_net_hdr_v1_hash hash_v1_hdr;
>>>> +       };
>>>> +};
>>>
>>> Perhaps even add in struct virtio_net_hdr. As that is the original of
>>> the three structs, and all the initial fields overlap.
>>>
>>
>> But I didn't use virtio_net_hdr in this patch, is it redundant to put it
>> here？ what do you think?
> 
> That's true. But if we're going to add a helper to bind together alll the
> virtio variants, then I think it should be there?
> 
> No strong opinion. Leave out if you prefer and no one else speaks up.
> 
will do

>>>> @@ -1577,7 +1585,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>>>    {
>>>>           struct net_device *dev = vi->dev;
>>>>           struct sk_buff *skb;
>>>> -       struct virtio_net_hdr_mrg_rxbuf *hdr;
>>>> +       struct virtio_net_common_hdr *common_hdr;
>>>> +       struct virtio_net_hdr_mrg_rxbuf *mrg_hdr;
>>>
>>> No more need for this second struct now that we have the union. That's
>>> its whole purpose?
>>
>> Yes, struct virtio_net_hdr_mrg_rxbuf *mrg_hdr is not needed. Writing
>> mrg_hdr here is just to make the code look more concise, such as
>> mrg_hdr->hdr.flags, if mrg_hdr is not used, it should be written as
>> common_hdr->mrg_hdr.hdr.flags, I think it looks too long. what you think?
> 
> If we're going to continue to assign to different structs, then I'm honestly
> not sure how much this patch buys us.
> 
> Adding virtio_net_hdr to the union also shortens the code btw. Then it
> can be common_hdr->hdr.flags
> 
> Also, just a shorter variable name than common_hdr. Fine to call it hdr.
> 
will do

>>
>>>>
>>>>           if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>>>>                   pr_debug("%s: short packet %i\n", dev->name, len);
>>>> @@ -1597,18 +1606,19 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>>>           if (unlikely(!skb))
>>>>                   return;
>>>>
>>>> -       hdr = skb_vnet_hdr(skb);
>>>> +       common_hdr = skb_vnet_common_hdr(skb);
>>>>           if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
>>>> -               virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
>>>> +               virtio_skb_set_hash(&common_hdr->hash_v1_hdr, skb);
>>>>
>>>> -       if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
>>>> +       mrg_hdr = &common_hdr->mrg_hdr;
>>>> +       if (mrg_hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
>>>>                   skb->ip_summed = CHECKSUM_UNNECESSARY;
>>>>
>>>> -       if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
>>>> +       if (virtio_net_hdr_to_skb(skb, &mrg_hdr->hdr,
>>>>                                     virtio_is_little_endian(vi->vdev))) {
>>>>                   net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
>>>> -                                    dev->name, hdr->hdr.gso_type,
>>>> -                                    hdr->hdr.gso_size);
>>>> +                                    dev->name, mrg_hdr->hdr.gso_type,
>>>> +                                    mrg_hdr->hdr.gso_size);
>>>>                   goto frame_err;
>>>>           }
>>>>
>>>> @@ -2105,7 +2115,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
>>>>           if (can_push)
>>>>                   hdr = (struct virtio_net_hdr_mrg_rxbuf *)(skb->data - hdr_len);
>>>>           else
>>>> -               hdr = skb_vnet_hdr(skb);
>>>> +               hdr = &skb_vnet_common_hdr(skb)->mrg_hdr;
>>>>
>>>>           if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
>>>>                                       virtio_is_little_endian(vi->vdev), false,
>>>> --
>>>> 2.37.1 (Apple Git-137.1)
>>>>
