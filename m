Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0706B7668EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjG1Jdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbjG1JdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:33:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DB34203
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690536726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gcjUt618Z45nMTb+RFtsmBBBhq7ViXpq+z7I95/Kk+o=;
        b=Aj23PC+VMiq6A7MXrtkCzCVHkCRZgmcHRjCJuaOLWPq6YfwUSKuUQOm9C4ybxrGifXrD8J
        XyMplmNEfplWEuPhAgbdHe04NHX8D00uJd+nagH9ix9BWb6+cc5Wta4t2wsJX6oj3XcLyW
        +hbfl6pogtgHKZD1tFNt5k2CLxFCI8A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-Du9-U1jlMVW89p6cVo6CUg-1; Fri, 28 Jul 2023 05:32:04 -0400
X-MC-Unique: Du9-U1jlMVW89p6cVo6CUg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-98e40d91fdfso121372166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690536723; x=1691141523;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcjUt618Z45nMTb+RFtsmBBBhq7ViXpq+z7I95/Kk+o=;
        b=NUpDeFmiZXbOxxHu9/cvymeMoVATk1dJK0lTIEfuSIGFRKbsDILnq6fj20YZt+WtWK
         P2C27v7vPGJVc6/xqAe+EIOYVVT2KKDyEQ56+rW5aUf4i7+toRn7U1KcO2j2iFNDA+sk
         8YamOkeSrukRwhnYmS/CxXXmquTQ2b7iXPCdo3s/Ki4831LDTXpm4cvKQzZ9dKW/e+Lq
         rvL2yk4443ICD6BXFWPk7HqBXT5i2hOmSwmU+1laZF82Qv5HNBt33UzszE9Jyz3lq8JL
         LEd/lPh7pDdaDtXc1VDZwUveGVVAgZ60gyHXO6Mrzr+QI58ZevEAuq6WrESMo6UraT/P
         OfDg==
X-Gm-Message-State: ABy/qLY+ey5KT+6jF1eNVahHFjmRhVV//vgX7oLhaJYq+t3b+qXEl/1F
        euCFmh8q+GMuyUA6TzQKsiQLLvF0CwpKqYd6lQDpNezUVl0FCrhVFiHKh6DIRxmP1Z27/xxm7ZM
        uKc5VG9o+1s37pwobQ20WcDXh
X-Received: by 2002:aa7:d616:0:b0:522:3081:ddb4 with SMTP id c22-20020aa7d616000000b005223081ddb4mr1368400edr.20.1690536723366;
        Fri, 28 Jul 2023 02:32:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGdL9m3DjLNN/ZU/lTc9TOFyIZ02cvDfIMMhRXp57SSjAnA34gcDPuPkMEe2O1hvcsTsletfg==
X-Received: by 2002:aa7:d616:0:b0:522:3081:ddb4 with SMTP id c22-20020aa7d616000000b005223081ddb4mr1368388edr.20.1690536723082;
        Fri, 28 Jul 2023 02:32:03 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id x8-20020aa7d388000000b005228614c358sm1584021edq.88.2023.07.28.02.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 02:32:02 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <db85d260-fdad-9b7c-cf7e-2e848151292d@redhat.com>
Date:   Fri, 28 Jul 2023 11:32:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     brouer@redhat.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        qingfang.deng@siflower.com.cn
Subject: Re: [PATCH net-next 9/9] net: skbuff: always try to recycle PP pages
 directly when in softirq
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
 <20230727144336.1646454-10-aleksander.lobakin@intel.com>
In-Reply-To: <20230727144336.1646454-10-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/07/2023 16.43, Alexander Lobakin wrote:
> Commit 8c48eea3adf3 ("page_pool: allow caching from safely localized
> NAPI") allowed direct recycling of skb pages to their PP for some cases,
> but unfortunately missed a couple of other majors.
> For example, %XDP_DROP in skb mode. The netstack just calls kfree_skb(),
> which unconditionally passes `false` as @napi_safe. Thus, all pages go
> through ptr_ring and locks, although most of time we're actually inside
> the NAPI polling this PP is linked with, so that it would be perfectly
> safe to recycle pages directly.

The commit messages is hard to read. It would help me as the reader if
you used a empty line between paragraphs, like in this location (same
goes for other commit descs).

> Let's address such. If @napi_safe is true, we're fine, don't change
> anything for this path. But if it's false, check whether we are in the
> softirq context. It will most likely be so and then if ->list_owner
> is our current CPU, we're good to use direct recycling, even though
> @napi_safe is false -- concurrent access is excluded. in_softirq()
> protection is needed mostly due to we can hit this place in the
> process context (not the hardirq though).

This patch make me a little nervous, as it can create hard-to-debug bugs
if this isn't 100% correct.  (Thanks for previous patch that exclude
hardirq via lockdep).

> For the mentioned xdp-drop-skb-mode case, the improvement I got is
> 3-4% in Mpps. As for page_pool stats, recycle_ring is now 0 and
> alloc_slow counter doesn't change most of time, which means the
> MM layer is not even called to allocate any new pages.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org> # in_softirq()
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   net/core/skbuff.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index e701401092d7..5ba3948cceed 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -901,8 +901,10 @@ bool page_pool_return_skb_page(struct page *page, bool napi_safe)
>   	/* Allow direct recycle if we have reasons to believe that we are
>   	 * in the same context as the consumer would run, so there's
>   	 * no possible race.
> +	 * __page_pool_put_page() makes sure we're not in hardirq context
> +	 * and interrupts are enabled prior to accessing the cache.
>   	 */
> -	if (napi_safe) {
> +	if (napi_safe || in_softirq()) {

I used to have in_serving_softirq() in PP to exclude process context
that just disabled BH to do direct recycling (into a lockless array).
This changed in kernel v6.3 commit 542bcea4be86 ("net: page_pool: use
in_softirq() instead") to help threaded NAPI.  I guess, nothing blew up
so I guess this was okay to relax this.

>   		const struct napi_struct *napi = READ_ONCE(pp->p.napi);
>   
>   		allow_direct = napi &&

AFAIK this in_softirq() will allow process context with disabled BH to
also recycle directly into the PP lockless array.  With the additional
checks (that are just outside above diff-context) that I assume makes
sure CPU (smp_processor_id()) also match.  Is this safe?

--Jesper

