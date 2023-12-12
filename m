Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D9980ED7C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjLLN0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjLLN0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:26:54 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB3BA8;
        Tue, 12 Dec 2023 05:26:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0VyMZ.ND_1702387614;
Received: from 30.221.129.163(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VyMZ.ND_1702387614)
          by smtp.aliyun-inc.com;
          Tue, 12 Dec 2023 21:26:55 +0800
Message-ID: <6064a6d7-8790-cf15-2d2e-eddb04e4e668@linux.alibaba.com>
Date:   Tue, 12 Dec 2023 21:26:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 31/35] net: smc: optimize
 smc_wr_tx_get_free_slot_index()
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Alexandra Winter <wintera@linux.ibm.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
 <20231212022749.625238-32-yury.norov@gmail.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20231212022749.625238-32-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/12 10:27, Yury Norov wrote:

> Simplify the function by using find_and_set_bit() and make it a simple
> almost one-liner.
> 
> While here, drop explicit initialization of *idx, because it's already
> initialized by the caller in case of ENOLINK, or set properly with
> ->wr_tx_mask, if nothing is found, in case of EBUSY.
> 
> CC: Tony Lu <tonylu@linux.alibaba.com>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
>   net/smc/smc_wr.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> index 0021065a600a..b6f0cfc52788 100644
> --- a/net/smc/smc_wr.c
> +++ b/net/smc/smc_wr.c
> @@ -170,15 +170,11 @@ void smc_wr_tx_cq_handler(struct ib_cq *ib_cq, void *cq_context)
>   
>   static inline int smc_wr_tx_get_free_slot_index(struct smc_link *link, u32 *idx)
>   {
> -	*idx = link->wr_tx_cnt;
>   	if (!smc_link_sendable(link))
>   		return -ENOLINK;
> -	for_each_clear_bit(*idx, link->wr_tx_mask, link->wr_tx_cnt) {
> -		if (!test_and_set_bit(*idx, link->wr_tx_mask))
> -			return 0;
> -	}
> -	*idx = link->wr_tx_cnt;
> -	return -EBUSY;
> +
> +	*idx = find_and_set_bit(link->wr_tx_mask, link->wr_tx_cnt);
> +	return *idx < link->wr_tx_cnt ? 0 : -EBUSY;
>   }
>   
>   /**

Thank you! Yury.

Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
