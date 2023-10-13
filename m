Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FED7C7F37
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjJMIBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJMIBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:01:03 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7487283;
        Fri, 13 Oct 2023 01:00:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vu1RuqR_1697184054;
Received: from 30.221.129.88(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vu1RuqR_1697184054)
          by smtp.aliyun-inc.com;
          Fri, 13 Oct 2023 16:00:55 +0800
Message-ID: <f54560ac-03fd-1a91-e38b-0e67b2c7959d@linux.alibaba.com>
Date:   Fri, 13 Oct 2023 16:00:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
From:   Wen Gu <guwen@linux.alibaba.com>
Subject: Re: [PATCH net] net/smc: return the right falback reason when prefix
 checks fail
To:     Dust Li <dust.li@linux.alibaba.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231012123729.29307-1-dust.li@linux.alibaba.com>
In-Reply-To: <20231012123729.29307-1-dust.li@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/12 20:37, Dust Li wrote:

> In the smc_listen_work(), if smc_listen_prfx_check() failed,
> the real reason: SMC_CLC_DECL_DIFFPREFIX was dropped, and
> SMC_CLC_DECL_NOSMCDEV was returned.
> 
> Althrough this is also kind of SMC_CLC_DECL_NOSMCDEV, but return
> the real reason is much friendly for debugging.
> 
> Fixes: e49300a6bf62 ("net/smc: add listen processing for SMC-Rv2")
> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
> ---
>   net/smc/af_smc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index bacdd971615e..21d4476b937b 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -2361,7 +2361,7 @@ static int smc_listen_find_device(struct smc_sock *new_smc,
>   		smc_find_ism_store_rc(rc, ini);
>   		return (!rc) ? 0 : ini->rc;
>   	}
> -	return SMC_CLC_DECL_NOSMCDEV;
> +	return prfx_rc;
>   }
>   
>   /* listen worker: finish RDMA setup */
Inspired by this fix, I am thinking that is it suitable to store the first
decline reason rather than real decline reason that caused the return of
smc_listen_find_device()?

For example, when running SMC between two peers with only RDMA devices. Then
in smc_listen_find_device():

1. call smc_find_ism_v2_device_serv() and find that no ISMv2 can be used.
    the reason code will be stored as SMC_CLC_DECL_NOSMCD2DEV.

...

2. call smc_find_rdma_v1_device_serv() and find a RDMA device, but somehow
    it failed to create buffers. It should inform users that SMC_CLC_DECL_MEM
    occurs, but now the reason code returned SMC_CLC_DECL_NOSMCD2DEV.

I think users may be confused that why peer declines with this reason and
wonder what happens when trying to use SMC-R.


Thanks,
Wen Gu

