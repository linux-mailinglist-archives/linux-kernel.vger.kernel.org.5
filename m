Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D1D7BC4F2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 08:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343550AbjJGGNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 02:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343510AbjJGGNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 02:13:21 -0400
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D32BB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 23:13:19 -0700 (PDT)
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1qp0YY-003YDr-MS; Sat, 07 Oct 2023 06:12:54 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
        by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1qp0YU-00EeYm-0R;
        Sat, 07 Oct 2023 07:12:54 +0100
Message-ID: <c6c0dea2-bbf6-80a6-1888-c1fa4718d4c2@cambridgegreys.com>
Date:   Sat, 7 Oct 2023 07:12:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] um: vector: fix return value check in vector_mmsg_rx
Content-Language: en-US
To:     Ma Ke <make_ruc2021@163.com>, richard@nod.at,
        johannes@sipsolutions.net, xiangyang3@huawei.com
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231007005104.3994678-1-make_ruc2021@163.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <20231007005104.3994678-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -2.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2023 01:51, Ma Ke wrote:
> In vector_mmsg_rx, to avoid an unexpected result returned by
> pskb_trim, we should check the return value of pskb_trim().
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>   arch/um/drivers/vector_kern.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 131b7cb29576..c280ce5ea6ce 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1013,8 +1013,8 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
>   					skb->ip_summed = CHECKSUM_UNNECESSARY;
>   				}
>   			}
> -			pskb_trim(skb,
> -				mmsg_vector->msg_len - vp->rx_header_size);
> +			if (pskb_trim(skb, mmsg_vector->msg_len - vp->rx_header_size))
> +				return 0;
>   			skb->protocol = eth_type_trans(skb, skb->dev);
>   			/*
>   			 * We do not need to lock on updating stats here

That does not look right. You can have errors when processing an 
individual packet. That is not a reason to bail and you should process 
the next ones. This way you just dropped the rest of the RX vector (up 
to 64 packets at default settings).

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

