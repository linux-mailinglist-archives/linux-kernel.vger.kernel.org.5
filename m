Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3878D78002D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355432AbjHQVwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355443AbjHQVwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:52:21 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7CE26BE;
        Thu, 17 Aug 2023 14:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdC0dR6paa5IJLgMKLetS/LFLC1B0pl9F+MoxfWacSPtGcrE/zLLUX81zCUKZYpmZQ56LHQiUbAQ1nMU4EH6qncyrJQcmRR/yCgHR+t2r01IJ+jJtAlX5IzlYB0gu/eP7GcRPB4YgffITJqXTr0grMPi6q3so/gjbM5A504wJGsirwMZkLnspr4MdvIXqHardLWoAa6cFB6XyBaV20QZHQ+ehj0pgIcWDo12leb6o6xROeC663QMBRO42v2XWv+yZt964il2yZWC2hPYRysAPbVehRoprqBj0cKRu0QPfCcoNJ3ExLeU9oBCQNLJJQULhEDM1iEqiJSKQNE4TvQSbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMckJbnUEnjNJCd7Y6bxYK/S9p4kdfVJVfmqly7E6xk=;
 b=bZGT8HGo6iBzRX8wId2bsgThZKZGuucRQe899Rd/eb3dqwGU0bW4P07EA4X5ZUvBlebhcXxmUvEiReq0Hr4u68fOh3f2SwyDnHJtxZFp0sq6/kn3R3TfGKCNEPdrSZVF3uUCKh4S+YltlGSFgvOjNyOk9S1XW0UgkEE/uRQkWRV7YwlB/sBXBjqU1BBNJgSMOSNaosmM4fRAuCgedYRgZl2Oy7bBbz0ZR7HfBCnsJ2yqzC8ELr7SMtVIZztxNmozIv2Egs77/Wxo2QjBLfzS7jaNdNDbOh8SJckmq7gDe1jjYPDVlzPQPgB3onGKws+ic8iAuIXdwmnhBTtWW68jpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMckJbnUEnjNJCd7Y6bxYK/S9p4kdfVJVfmqly7E6xk=;
 b=F6RhBxOK4bLjS4BXJfwvlJBRkUfpc1zI5Uue5HBshOvP4rbhfB3zgVnVYMsI7jDCU7IlJViwnv6MD7oOK0Wljr9nMUS0jkPseACiZj3KbjBUjqw+zIMCSrQRbJgDLpHuuLcNXBOl+wD/QqOOn1UE1JKUEJ9GT35qMUoiRxpVbAJGKspEgAjK1L4qxwbqteMP5R4A1u0WQsDgQgJQIv/FaMvkdJjsw1pENnd6MPrWxFesURm+S2TFz5/uy3tc5k7zwWUkBwHe/orWr3IjEJDKVxWDus6YvaLtErsnOMpKWYlEhrn0bGyXifgYU0BvSu7t5lwJlD4Fah9S1ZMpkqzN0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by SN7PR12MB7810.namprd12.prod.outlook.com (2603:10b6:806:34c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 21:52:16 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260%4]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 21:52:16 +0000
Message-ID: <b2edfbbf-1018-745e-2ce4-946ffe27e5e5@nvidia.com>
Date:   Thu, 17 Aug 2023 17:52:12 -0400
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
From:   Feng Liu <feliu@nvidia.com>
In-Reply-To: <CAF=yD-KN=-2fhc2nxxzr-bJ5kwQVFken_iTo4sBbuAkjmbn3fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0015.namprd12.prod.outlook.com
 (2603:10b6:806:6f::20) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|SN7PR12MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a105e81-3e6a-4948-095b-08db9f6c38c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +cfdai4Vccn++fndeEq4lEtuJpBQl6GQJ/Pf84532BgCI3gjRNhOdiuM9so4YftBwFya0noQxf5W34/qST/Wi6NEA9GmELQHTYpdF7NAKiw0khUwlKJ109cAfYKyEssiYYwnNgsjktTFufRaD4AGdYZZQbNbcVueU4hc0IoSDeO+cYylZ6KgzSgpE0AAxIbEjznHGwtQfFFkVEqnJAJ+FT0NcW+380WXv8TM2x1t4iPp3h9lgfBFU+5bo5ANVtgFatBqgm5yobperFNR/Iw29d8pBfQp4i+K/EnbiaZEByrQwftf7RDLODejPkqpioe2feZ9nI+bNKU1M78UJZU11+BktbFpynTPQiP2vH0hEMlpe6LefrqyEezzkQwnKE2LU9gY8iFxo/rjpLuEP/PthADQ72TIqiD57M7aUJcPceFTTpcvlS3HByt2pF9kd2J2wMKyPQvkn88Xht8kYxf3AebHSgXIqd/lVYe1OJvVTWULm6xas6enVWzqI4l0xtHkPhaqrVC+rDHgig9u2qlSgCEFGMsJ8DBTFkn+7DbqtkYJo7yDO9sK+SooMS0zsW17aE7espGuwgtlUA4JkVRvht3y8YN/LhbbMpCFi0Q3FeKlbCHdGGy/QL9iHhAXO47XAxAfv9TC6jQfRbucZHs2lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(39860400002)(346002)(186009)(1800799009)(451199024)(66899024)(2906002)(7416002)(83380400001)(478600001)(66946007)(66556008)(66476007)(6506007)(6916009)(53546011)(54906003)(316002)(6486002)(6666004)(2616005)(107886003)(5660300002)(4326008)(6512007)(41300700001)(8676002)(8936002)(26005)(86362001)(36756003)(31696002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGt4cjJoNzBxRFVkMDNPeDEvOTRRRmkwWXY2ZEV0NlFYSlZjNXR4ZG5scmlx?=
 =?utf-8?B?MWN3S0hNM3NycHBFMm1qb045VXp5czA3QjhPcGdOOU9DQUxMK0JKekd5L0t3?=
 =?utf-8?B?OEw2bFF1Nm5uVmJzSlZsK1VGc0dZYXBEc0pGSXRXOCt3OS9ScGl6VmNqUElG?=
 =?utf-8?B?b2Q5d2ZXV0xxb0FiK3BxWWlMQnNJQml6Rysra3JFK2kwb0hyTExJVHh6TnNh?=
 =?utf-8?B?ZlQyaWZ3ejhCbytxS0ZhTlFCRG9BLzlTY2EyU1I3MXBRRkUxdG8rR2x3enJL?=
 =?utf-8?B?YytpeUxmbzRYd1N3TkE0bzA3Nlp1QVRVcjUraktVWUJRcTVLRDVYelpnSHJo?=
 =?utf-8?B?Y3ZJWG1mc0NWWmluQnptWHdzaTFYT1ZJZVl6WXhCc0NnZmFJTS9qNmJ5ZjlV?=
 =?utf-8?B?VmMyb1lVVjJoVnROdWZOZTh4dGhhUmF0NlFlZnl6KzlnMzYrMkFiZjZZYzBs?=
 =?utf-8?B?K0tITHdOM0FWZms3c0F4SUdwYmE5UFd2M0Z1Z0hTNjBlMlBPb2NOYUhvVUJy?=
 =?utf-8?B?Zi8vdGZLa014eXJEam5ZQVhTWjA5YUsvbm5uQzVUTm1qSUNuM0krdHR1SkJa?=
 =?utf-8?B?VlFBMlZvMGdnNWM2Qm5tcWI2MElsdDFKZU1VeWVsUWdudjVmVUNiNm9Wc3JW?=
 =?utf-8?B?STdWY2ZwMCtDNFFoNWpQL1VBZFlTaFZocFlVY1lsV21ZbUk4QmtzVHRySWdI?=
 =?utf-8?B?Q0Yvay9LK0prQW43OVhLL1FFVXlUVE82MUt3am92bkpXYzE2WjZyeUVuR09R?=
 =?utf-8?B?YmJ2NkRqT2lTSW1LVkFxM2RoY0V5WGhaamltMkVLL1lRaVk4d1p0VWZIVHJP?=
 =?utf-8?B?MysvUC8rZGx2Zzd5YlRwbXRRUFdESnc2NzVxNzY4N3EvTlJmaStwQlFhWWNI?=
 =?utf-8?B?YUxocGNFYldyRDdFd0cvZHpFMFNVaFZzUjRDdWlVbitSeEU2T003Z2MzYnly?=
 =?utf-8?B?N3owVDJ6MERJRHd6RGhwQWpRRE90ajFDVFJ6SFdxeVlKL0VUNzd4QUpXelZP?=
 =?utf-8?B?SnVjcGZBM1hvcHhBN0gxU3dMbDlMekZZN3B1cUw5SHFaYjJmS1M5TG5UNmsz?=
 =?utf-8?B?R05xTzJhU2JVcXRobVBpNFBXc2hsNW9oUlVkRUszWWFrL1VoK25HL3kydlZu?=
 =?utf-8?B?MnhnbmhYcU84SXd6MUtsenozYjhGZWZPdFJURks4b3grNG1POGIvRVg5S0M3?=
 =?utf-8?B?SFJUUEVUTWI1OUw2dXNWd2FLTmNsUXBMYVZISTF1eEIwazNaRUYxVDZhN1hU?=
 =?utf-8?B?bHJid0pYU3dFdERIK2FaZExQb0F3WTlmSnBtZmdScXpCVWJIZ2dTZGJ2TlR6?=
 =?utf-8?B?RjJvdW53SmZOaEZTOTczWStrblIvR3lOVGFyTFB1OTRYbEMzUUJSeGowcU1E?=
 =?utf-8?B?bmJlcFBKRUFXc0wvN2ZsUGtiVHUvQk1kcThORldCaTd2RGliYUdhV0E2alAw?=
 =?utf-8?B?MVNHd0ZKQ2NaZnY0aitZT1lGL3lXVXlLQkxvdEhjVWJDdGN6bjhqMEpTNWVG?=
 =?utf-8?B?U3Z6NWI2Y0t3bFlicStWalIrWGNETklLTFpsci9WTVEzUnJzTUhCTXlZeCtv?=
 =?utf-8?B?R0tDN2xmUkZ6SGQ4S1JTc0VtSVEwN2Zoay84WERRUUlRVVBRMlNuTVRUQ0Fa?=
 =?utf-8?B?R1dKNlZjUnd5UWJBcUJuaDh2NEhNdjA1QUVsWGxMY2pMbUYzaHZ3MWREVG85?=
 =?utf-8?B?cWlKMW9wdWlQbndsWHhWeXhCWFhLREFFQ2lONXkxYXhZN3VoRlp4T3M5dlM3?=
 =?utf-8?B?TklyOW9KYnVQS0R4djFWMjFTb290dFhEdWRlRWNKelhJY3l1d2hBUUl3cWlR?=
 =?utf-8?B?ZzZxVThMZjdlS3kvRFBwZWc5cU14YlRrM1Y0NGd6ZHk2b29QbDJCMWwzay9w?=
 =?utf-8?B?ZmJVM0dpY0taeHlzT0RENnVEN0haSGxCM1ZETStYbzlEUkF5TnpzNWhpMDBm?=
 =?utf-8?B?WElZaGsybjh5SDdabE9MU0lLVkpPRzlWTlZBYXJuWnJIU2tvZWFrU01kVXNk?=
 =?utf-8?B?dzcrMDVzME9tRTFYdVdXTWxSRmhuRjcwWnI5SlFzMnM4VFhHbTNHMmpCejJa?=
 =?utf-8?B?NkZhRXc0ejFaMytDQUp6YlhHQnR3VnoxSTJsTEJIeG9ONytRcFMveGJIVEtX?=
 =?utf-8?Q?F+wO9nF+AYj94IdT6Jg/sf935?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a105e81-3e6a-4948-095b-08db9f6c38c5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 21:52:16.2316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rfaur0CJbykTqa67/Uxt7x2ooWTyBgYtlLIc41BQ6tLIR+iEC1G+uzA4lUOSmJFiZk7tAgqd25FiHzS9B6rjeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7810
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-08-17 p.m.2:26, Willem de Bruijn wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Aug 17, 2023 at 11:20 AM Feng Liu <feliu@nvidia.com> wrote:
>>
>> The virtio_net driver currently deals with different versions and types
>> of virtio net headers, such as virtio_net_hdr_mrg_rxbuf,
>> virtio_net_hdr_v1_hash, etc. Due to these variations, the code relies
>> on multiple type casts to convert memory between different structures,
>> potentially leading to bugs when there are changes in these structures.
>>
>> Introduces the "struct skb_vnet_common_hdr" as a unifying header
>> structure using a union. With this approach, various virtio net header
>> structures can be converted by accessing different members of this
>> structure, thus eliminating the need for type casting and reducing the
>> risk of potential bugs.
>>
>> For example following code:
>> static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>                  struct receive_queue *rq,
>>                  struct page *page, unsigned int offset,
>>                  unsigned int len, unsigned int truesize,
>>                  unsigned int headroom)
>> {
>> [...]
>>          struct virtio_net_hdr_mrg_rxbuf *hdr;
>> [...]
>>          hdr_len = vi->hdr_len;
>> [...]
>> ok:
>>          hdr = skb_vnet_hdr(skb);
>>          memcpy(hdr, hdr_p, hdr_len);
>> [...]
>> }
>>
>> When VIRTIO_NET_F_HASH_REPORT feature is enabled, hdr_len = 20
>> But the sizeof(*hdr) is 12,
>> memcpy(hdr, hdr_p, hdr_len); will copy 20 bytes to the hdr,
>> which make a potential risk of bug. And this risk can be avoided by
>> introducing struct virtio_net_hdr_mrg_rxbuf.
> 
> You mean virtio_net_common_hdr?
> 
It is a typo, will correct it.

> I'm not sure I follow the reasoning. Because then hdr_len might be
> sizeof(virtio_net_hdr_mrg_rxbuf), but sizeof(virtio_net_common_hdr) is
> larger. So the same issue remains?
>
static int virtnet_probe(struct virtio_device *vdev)
{
[...]
	if (vi->has_rss_hash_report) {
		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash); /* hdr_len will 
be 20 bytes */
	}
	else if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
		 virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
		vi->hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
	else
		vi->hdr_len = sizeof(struct virtio_net_hdr);
[...]
}

When VIRTIO_NET_F_HASH_REPORT is enabled, hdr_len = 20 (as above); and 
the size of virtio_net_hdr_mrg_rxbuf is 12, so virtio_net_hdr_mrg_rxbuf 
is wrong, should use struct virtio_net_common_hdr here.

> Indeed, everywhere this patches replaces the one with the other, you
> have to verify that nothing was using sizeof(*hdr). Which would not be
> visible from the truncated patch contents itself.
> 
Have checked. Nothing is using sizeof(*hdr).

>>
>> Change log
>> v1->v2
>> feedback from Willem de Bruijn <willemdebruijn.kernel@gmail.com>
>> feedback from Simon Horman <horms@kernel.org>
>> 1. change to use net-next tree.
>> 2. move skb_vnet_common_hdr inside kernel file instead of the UAPI header.
>>
>> Signed-off-by: Feng Liu <feliu@nvidia.com>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>   drivers/net/virtio_net.c | 36 +++++++++++++++++++++++-------------
>>   1 file changed, 23 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 1270c8d23463..03cf744de512 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -303,6 +303,13 @@ struct padded_vnet_hdr {
>>          char padding[12];
>>   };
>>
>> +struct virtio_net_common_hdr {
>> +       union {
>> +               struct virtio_net_hdr_mrg_rxbuf mrg_hdr;
>> +               struct virtio_net_hdr_v1_hash hash_v1_hdr;
>> +       };
>> +};
> 
> Perhaps even add in struct virtio_net_hdr. As that is the original of
> the three structs, and all the initial fields overlap.
> 

But I didn't use virtio_net_hdr in this patch, is it redundant to put it 
here？ what do you think?

>> +
>>   static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
>>   static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>>
>> @@ -344,9 +351,10 @@ static int rxq2vq(int rxq)
>>          return rxq * 2;
>>   }
>>
>> -static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_buff *skb)
>> +static inline struct virtio_net_common_hdr *
>> +skb_vnet_common_hdr(struct sk_buff *skb)
>>   {
>> -       return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
>> +       return (struct virtio_net_common_hdr *)skb->cb;
>>   }
>>
>>   /*
>> @@ -469,7 +477,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>                                     unsigned int headroom)
>>   {
>>          struct sk_buff *skb;
>> -       struct virtio_net_hdr_mrg_rxbuf *hdr;
>> +       struct virtio_net_common_hdr *hdr;
>>          unsigned int copy, hdr_len, hdr_padded_len;
>>          struct page *page_to_free = NULL;
>>          int tailroom, shinfo_size;
>> @@ -554,7 +562,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>                  give_pages(rq, page);
>>
>>   ok:
>> -       hdr = skb_vnet_hdr(skb);
>> +       hdr = skb_vnet_common_hdr(skb);
>>          memcpy(hdr, hdr_p, hdr_len);
>>          if (page_to_free)
>>                  put_page(page_to_free);
>> @@ -966,7 +974,7 @@ static struct sk_buff *receive_small_build_skb(struct virtnet_info *vi,
>>                  return NULL;
>>
>>          buf += header_offset;
>> -       memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
>> +       memcpy(skb_vnet_common_hdr(skb), buf, vi->hdr_len);
>>
>>          return skb;
>>   }
>> @@ -1577,7 +1585,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>   {
>>          struct net_device *dev = vi->dev;
>>          struct sk_buff *skb;
>> -       struct virtio_net_hdr_mrg_rxbuf *hdr;
>> +       struct virtio_net_common_hdr *common_hdr;
>> +       struct virtio_net_hdr_mrg_rxbuf *mrg_hdr;
> 
> No more need for this second struct now that we have the union. That's
> its whole purpose?

Yes, struct virtio_net_hdr_mrg_rxbuf *mrg_hdr is not needed. Writing 
mrg_hdr here is just to make the code look more concise, such as 
mrg_hdr->hdr.flags, if mrg_hdr is not used, it should be written as 
common_hdr->mrg_hdr.hdr.flags, I think it looks too long. what you think?


>>
>>          if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>>                  pr_debug("%s: short packet %i\n", dev->name, len);
>> @@ -1597,18 +1606,19 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>          if (unlikely(!skb))
>>                  return;
>>
>> -       hdr = skb_vnet_hdr(skb);
>> +       common_hdr = skb_vnet_common_hdr(skb);
>>          if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
>> -               virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
>> +               virtio_skb_set_hash(&common_hdr->hash_v1_hdr, skb);
>>
>> -       if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
>> +       mrg_hdr = &common_hdr->mrg_hdr;
>> +       if (mrg_hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
>>                  skb->ip_summed = CHECKSUM_UNNECESSARY;
>>
>> -       if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
>> +       if (virtio_net_hdr_to_skb(skb, &mrg_hdr->hdr,
>>                                    virtio_is_little_endian(vi->vdev))) {
>>                  net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
>> -                                    dev->name, hdr->hdr.gso_type,
>> -                                    hdr->hdr.gso_size);
>> +                                    dev->name, mrg_hdr->hdr.gso_type,
>> +                                    mrg_hdr->hdr.gso_size);
>>                  goto frame_err;
>>          }
>>
>> @@ -2105,7 +2115,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
>>          if (can_push)
>>                  hdr = (struct virtio_net_hdr_mrg_rxbuf *)(skb->data - hdr_len);
>>          else
>> -               hdr = skb_vnet_hdr(skb);
>> +               hdr = &skb_vnet_common_hdr(skb)->mrg_hdr;
>>
>>          if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
>>                                      virtio_is_little_endian(vi->vdev), false,
>> --
>> 2.37.1 (Apple Git-137.1)
>>
