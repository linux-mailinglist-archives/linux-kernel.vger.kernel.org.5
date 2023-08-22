Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D358E784407
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbjHVO0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236641AbjHVOZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:25:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF1DFB;
        Tue, 22 Aug 2023 07:25:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMGAZnszGvw0aouy/fj0X6nEmoxQ2jaz/4+HEr4oY6fn/LZGEjbk1gA1BuJQWTp+4kgxVBaRwh7vIW7U0vpV96gTmi518aHkMSBJgmv8B7dbaeDWYL8g+lCM2jlK74pul4fgNo2HUD4fUhVV+AVwsBCQAARfc4J9rI7vUnR9OxU35PeBuYDUp/QyiLR6QvxZ3k8135B/xjuThQqNaGeKdm+8idTnM5lq4rK3eQFPwZRnzKsCpr0HZYF0yLkcuzlfAqotiec9A5aywZog4X3dXGccTdFF07tWUVn7lgZYS4UPIYfB39kyhQ0Wl3g8rHZuVHr2M2FQb9KOu2678PZ92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bdOAv91KMCAvzXGwKzTJLC8kqoTKXjHHd197D6GaCk=;
 b=NRn86HasjGy5Pcvw6c1Uku7yU9/2QgBvCGYJAWUgK47G2LHFNYD9bHUZarWOf6uUPRWBUYVBM2Q6XbGluBTw9vR6Ayt8HY473QD0+6XPNrYdHGyglukpua2XnGAJePSkNCkF9nSKV4XVdGlB8HeFug7UjbC0gRAKrPoOeSH7nWCHXj1XtzSixvDv70GYHw2PlWONyrvfSuEH7Ie4nVqcwd6I63o6HScXCtX5Yx6XKxCuBe0amDMhwfOi3KbeFBgX8eYBW7k7yQRAv5b1eQCmeBTBaaxtrW+SJdMQHc5lbQn+ZCjxzNi79H9cLlaY0lhtzjjreJIcF7B7k+BxzUqeXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bdOAv91KMCAvzXGwKzTJLC8kqoTKXjHHd197D6GaCk=;
 b=k5dp+qj1IwUtIRyCUAh/etnaoUwx7oEpzN/5NknHDXEd6kmJc2OLo4UEnaPJCSxsVPiKDpVRvMLVrs5Y7KfI0p+Gz/GY/jhKtvVNq4sXvdHqPV9wY3OrYP19BqNJWZrCi6ZSdqiLWk3/DGhafGViZa9RaxWvyPIUV3pdL8md1Ja1JWvA1aAOG8q8a9GtPtZibK3byUgL7lT+LivViFgmbqA7lKZW+unrk5IEqX7YJgQ74Du4i+j4LGv4FOglD/ukzQZK+4yQEwF+DNbFZYQqZr+GpV4+fzkLGrmhgEHhX/aZy0nA4Vu02icnIO7ixBzPwZwgq6UXWQ6U1+uN8Z5z0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 14:25:52 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260%4]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 14:25:52 +0000
Message-ID: <6b022182-fc7d-9269-c1aa-39e2a807d39f@nvidia.com>
Date:   Tue, 22 Aug 2023 10:25:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH net-next v3] virtio_net: Introduce skb_vnet_common_hdr to
 avoid typecasting
To:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Bodong Wang <bodong@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
References: <20230821142713.5062-1-feliu@nvidia.com>
From:   Feng Liu <feliu@nvidia.com>
In-Reply-To: <20230821142713.5062-1-feliu@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0042.namprd07.prod.outlook.com
 (2603:10b6:5:74::19) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb21628-109b-4a7a-0096-08dba31bb013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tlpxd1YVwFH10rKhMtTwD1OPgE9dM7FGPkwdx0z3Po/aUPcMXAPSKDpDUKLsyh81DMclTDvnwmfYHg1kXIoXAFMIZw/QjGATeZQZ5qvkXCe04vOkTuNOtjjoQAKPSZRZW3whTJfGvjVoZNnXmW7fqmPS6omEDDwE9HGs7/jk/ttg27BJ+lM9OjXQ2h7vTRwqTNmghGyoFdfii14azfIDOffMWrZKWNwu6tJE3DEdUjbDr+YZLq6DxzIg397V/lE+0gGKamf/U2Fx99YSrssB7FpmSSzvNGZxsnLA1FyQBzKxpCJVRe7exFEyj97zt+7tl/b7fqzx8zsLuYAcA+mm+y6DxaRcRQr9VacjuPabWfqu/BaR3gscu/8xOhfS6NTULQUi8KXvsCUqDNp6GBLX8WFd/J1wAGJFpZ9YPNm/Fe/z/kCRqgZX9++oc6/Uk8n+kWDC9E2UMt0KH0as2IDnNMocHF0jKnl3jNIsSN8HWjHe4GjM3wrlpLWwW1An67nnX1hXywnA5uaisTLO5rvgvwkfO0QUHtFir/fLZ+HWE4zepQ7q3kKhkazmxY6XKfdq3BHr9FArK6d16k3uLn8v36doduaqRbljJ68ur8OmgOhT7lqnaW1iX57SREb7t5nOTpH5GHUoCrSbLtXjUXvALg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(54906003)(66476007)(66556008)(6512007)(316002)(66946007)(66899024)(110136005)(8676002)(8936002)(2616005)(107886003)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(6486002)(6506007)(83380400001)(2906002)(7416002)(31686004)(31696002)(86362001)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3lUK0xSdldYUVFIZEZxbS9ENnl6NVo2K3ZtZUs3TGI1SWgzVWpUMGJTRzly?=
 =?utf-8?B?eGRac0xFakFDY2VZZW5BOVFjbHNsdnUxZUczZU5PMmJuSEptdmJ2Y3NJMXor?=
 =?utf-8?B?L3J0cTBaR0pIbW5hRTdhK0wrVUJncUhha0Q4dHpkY3BVM3lKVVpqbDJnZlBw?=
 =?utf-8?B?a0NLOE1oMGdvdUg5STl4SVJxOXFHMG1pR3crVjFmUnp6TzUwZ0JraTVJVDkz?=
 =?utf-8?B?UE9xbXBwMnovbUxRRHF0YitBelBKSy95dEVtZWNGeEtKdkY4Sk8xenlCN1FB?=
 =?utf-8?B?bXRXdTY1amVPd2FLdENmL3FhNVRhYmgxd3ZIQUE5c1hVMWlpbTlWQjRxb3d3?=
 =?utf-8?B?VEdWbTBqTWN4bEQ1azRuSG9BaDZPcGJXTkZlYnRpK0htVEhNWU5GUmNJYXZy?=
 =?utf-8?B?YU5PRGhmcVZrbmhFajlBaDZaajdkY0pkSW0vRWtuRXUrYU5QNlQwVGd4a3dQ?=
 =?utf-8?B?UUt6S1ZHOFA3SEJpYkM4YmRNMzZSRHVTc2FnV2ZhejJyWU4wY3hCa2ZrUFh4?=
 =?utf-8?B?Z3ZWUTFOMWlDMDJldDF4TXBiYktyN2FmbGJoZnYvTk5ZTHptdFh4VmNpUVJl?=
 =?utf-8?B?ZU5zOTRiWk5TMEc2RENyMGRIK1VVOFBDdHVPV3ZXbytzY24ybkVwVG13Y0xZ?=
 =?utf-8?B?eWIyb1Njd0Foa1R0QkZTRlVCY0VFUlFnWlNsTUNkTmxGRndBKzFIYThkWWhN?=
 =?utf-8?B?alp5NnBGQXZRVllmUjlrMzBwOVRCOTRDN0s2WFVuUTlReGZEdDFhQnNGYnhy?=
 =?utf-8?B?azdQbTFiSWFPSkN3bEt1UTJSR1Y0SzVYM25lRkEyRCtyVTk0TTVRb3JudHl4?=
 =?utf-8?B?T3RiaFBLeTFzNnFHT1RDWXRsdnQyYjdlZzlkZVovZ2lQcWZnQVRLV1dvRTJW?=
 =?utf-8?B?UGtpOHF4V21GcXlrcW1qMzNHSjBpUWdZSXAzNm9nZFMzVHRZR1VLU3NMR2hS?=
 =?utf-8?B?QkpRTWFSU0Y2ZXRZZm5BeWpTcGtWU0kzRW5UZVVyeTkzVUcwK1VHa2dBSjNU?=
 =?utf-8?B?cHI0N3BncVhDdVRCNUVHYXh2Q3VObEdEZmpUa001dDNGdjJBd0w4ci9odUN4?=
 =?utf-8?B?alVyVlpyMTJlUzN5cXNuMmZIcDFidngvaFlDVDJPZ1lLS3lZWXRkc2dzOE1O?=
 =?utf-8?B?a3Jwa0JNSG5PdVVNUm45UUt4eWRRTUFXcE1HeTBjTGxMWmd5eDdYellEL3pG?=
 =?utf-8?B?eUowNlMyMWh4RDJkNUtsTG5Ta1pjMFAzRzlpVk1SUUdhZ3Evd2UwKzlJL0NU?=
 =?utf-8?B?S2VpcWZMaUo5blRTUURuYXJSRDJaNTRqd0llRlVnUlNaMDVZSzczOVRFVWNE?=
 =?utf-8?B?TU1hKzI3M1REOEdSSW5iOWNFMHcvNWx0VldqSG92a1BobEczTER6ZVltTGhn?=
 =?utf-8?B?U1NnYnFIYlJseEYzTEZCRmpINDJjd3lUU0lkalh2YUVDODBnbHh1cHFzVlVl?=
 =?utf-8?B?UEVXYlhxRGhMbjEyc1M3UlkxMWlMVzlQMjlMeFpnVE5uSlcyVnVkZXp3S0hM?=
 =?utf-8?B?QWxMOGl0cHNzQXoraEYwY2NtczdLVzl4ampUdzI3MjNXQXZVbkpFMXBYN09Z?=
 =?utf-8?B?bmZiMXpHQUh2OWVXTXdLSlNudktSTjArc1NXWkNBRXVQODZxTzFzbXp6WXpr?=
 =?utf-8?B?RTM3NlZXc2RLQnVUb1ErMzZxNDNtVGVQeVFYWWxPTGdRRkpUd1B6WUlucG4w?=
 =?utf-8?B?Unpldjh5UEtEb25CVnFVeXpqczNkdkdmZ1ZPaytObjJqcUtyckozNTVUWDkr?=
 =?utf-8?B?TlcxRmU2Ym5OcUc3OGtTWGxDUFdiRTIvbXpDZTNndDlBdjlRQWFXQjFvUDlv?=
 =?utf-8?B?MW44bndqYUVKREs5UmRlV25PMmlDeEZUcjZhdWRFN2FxSnVadTkzRi9CL2x2?=
 =?utf-8?B?V3IvRTcxODZ4V09zM1JsVENOeDY0RWYwMVhzRXp5cFRPWFZ6SVhmaUl3VE4w?=
 =?utf-8?B?cXFGS3JHTi9iUFVYN09uTm90ODloN0tHSGlYSFJ2SWozdXZ2TnZUTUNheC9T?=
 =?utf-8?B?L09ZWDVXc1VFbm1ybVQxekdXOVZuV040a2JjYUJUdHprRFB2Z1NDM1I2TDY3?=
 =?utf-8?B?N0o2V1gzQm5uZTZwaGl6S0lsenVQSHlmRXozNElucXBMd1NNY1EvbEVXOFkw?=
 =?utf-8?Q?0VAdCNtEmxXmb3aIf/g9Ibmnv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb21628-109b-4a7a-0096-08dba31bb013
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:25:51.8759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZlw+ubCJelEUJYaxGmj4+eW09OdGgbSHqmwL2SSavnkZzUsV7DdRWsRi2UHfkRQ69OIRxnjeGabyrVFAtg7gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason , MST

Could you help to review this patch ?  Any more comments?

Thanks
Feng

On 2023-08-21 a.m.10:27, Feng Liu wrote:
> The virtio_net driver currently deals with different versions and types
> of virtio net headers, such as virtio_net_hdr_mrg_rxbuf,
> virtio_net_hdr_v1_hash, etc. Due to these variations, the code relies
> on multiple type casts to convert memory between different structures,
> potentially leading to bugs when there are changes in these structures.
> 
> Introduces the "struct skb_vnet_common_hdr" as a unifying header
> structure using a union. With this approach, various virtio net header
> structures can be converted by accessing different members of this
> structure, thus eliminating the need for type casting and reducing the
> risk of potential bugs.
> 
> For example following code:
> static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> 		struct receive_queue *rq,
> 		struct page *page, unsigned int offset,
> 		unsigned int len, unsigned int truesize,
> 		unsigned int headroom)
> {
> [...]
> 	struct virtio_net_hdr_mrg_rxbuf *hdr;
> [...]
> 	hdr_len = vi->hdr_len;
> [...]
> ok:
> 	hdr = skb_vnet_hdr(skb);
> 	memcpy(hdr, hdr_p, hdr_len);
> [...]
> }
> 
> When VIRTIO_NET_F_HASH_REPORT feature is enabled, hdr_len = 20
> But the sizeof(*hdr) is 12,
> memcpy(hdr, hdr_p, hdr_len); will copy 20 bytes to the hdr,
> which make a potential risk of bug. And this risk can be avoided by
> introducing struct skb_vnet_common_hdr.
> 
> Change log
> v1->v2
> feedback from Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> feedback from Simon Horman <horms@kernel.org>
> 1. change to use net-next tree.
> 2. move skb_vnet_common_hdr inside kernel file instead of the UAPI header.
> 
> v2->v3
> feedback from Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> 1. fix typo in commit message.
> 2. add original struct virtio_net_hdr into union
> 3. remove virtio_net_hdr_mrg_rxbuf variable in receive_buf;
> 
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>   drivers/net/virtio_net.c | 27 ++++++++++++++++++---------
>   1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e9f4cfe941f..8c74bc8cfe68 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -303,6 +303,14 @@ struct padded_vnet_hdr {
>   	char padding[12];
>   };
>   
> +struct virtio_net_common_hdr {
> +	union {
> +		struct virtio_net_hdr hdr;
> +		struct virtio_net_hdr_mrg_rxbuf	mrg_hdr;
> +		struct virtio_net_hdr_v1_hash hash_v1_hdr;
> +	};
> +};
> +
>   static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
>   static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>   
> @@ -344,9 +352,10 @@ static int rxq2vq(int rxq)
>   	return rxq * 2;
>   }
>   
> -static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_buff *skb)
> +static inline struct virtio_net_common_hdr *
> +skb_vnet_common_hdr(struct sk_buff *skb)
>   {
> -	return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
> +	return (struct virtio_net_common_hdr *)skb->cb;
>   }
>   
>   /*
> @@ -469,7 +478,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>   				   unsigned int headroom)
>   {
>   	struct sk_buff *skb;
> -	struct virtio_net_hdr_mrg_rxbuf *hdr;
> +	struct virtio_net_common_hdr *hdr;
>   	unsigned int copy, hdr_len, hdr_padded_len;
>   	struct page *page_to_free = NULL;
>   	int tailroom, shinfo_size;
> @@ -554,7 +563,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>   		give_pages(rq, page);
>   
>   ok:
> -	hdr = skb_vnet_hdr(skb);
> +	hdr = skb_vnet_common_hdr(skb);
>   	memcpy(hdr, hdr_p, hdr_len);
>   	if (page_to_free)
>   		put_page(page_to_free);
> @@ -966,7 +975,7 @@ static struct sk_buff *receive_small_build_skb(struct virtnet_info *vi,
>   		return NULL;
>   
>   	buf += header_offset;
> -	memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
> +	memcpy(skb_vnet_common_hdr(skb), buf, vi->hdr_len);
>   
>   	return skb;
>   }
> @@ -1577,7 +1586,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>   {
>   	struct net_device *dev = vi->dev;
>   	struct sk_buff *skb;
> -	struct virtio_net_hdr_mrg_rxbuf *hdr;
> +	struct virtio_net_common_hdr *hdr;
>   
>   	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>   		pr_debug("%s: short packet %i\n", dev->name, len);
> @@ -1597,9 +1606,9 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>   	if (unlikely(!skb))
>   		return;
>   
> -	hdr = skb_vnet_hdr(skb);
> +	hdr = skb_vnet_common_hdr(skb);
>   	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> -		virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
> +		virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
>   
>   	if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
>   		skb->ip_summed = CHECKSUM_UNNECESSARY;
> @@ -2105,7 +2114,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
>   	if (can_push)
>   		hdr = (struct virtio_net_hdr_mrg_rxbuf *)(skb->data - hdr_len);
>   	else
> -		hdr = skb_vnet_hdr(skb);
> +		hdr = &skb_vnet_common_hdr(skb)->mrg_hdr;
>   
>   	if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
>   				    virtio_is_little_endian(vi->vdev), false,
