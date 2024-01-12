Return-Path: <linux-kernel+bounces-24631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D45D82BF77
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837011F251DB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F8F6A01B;
	Fri, 12 Jan 2024 11:51:34 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2885C651BF;
	Fri, 12 Jan 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TBKbv3krrz1Q7kQ;
	Fri, 12 Jan 2024 19:50:35 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BCDA1402C7;
	Fri, 12 Jan 2024 19:51:22 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Jan
 2024 19:51:21 +0800
Subject: Re: [RFC PATCH net-next v5 2/2] net: add netmem to skb_frag_t
To: Mina Almasry <almasrymina@google.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe
	<jgg@nvidia.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
	<christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>
References: <20240109011455.1061529-1-almasrymina@google.com>
 <20240109011455.1061529-3-almasrymina@google.com>
 <5219f2cd-6854-0134-560d-8ae3f363b53f@huawei.com>
 <CAHS8izOtr+jfqQ6xCB3CoN-K_V1-4hPsB4-k5+1z-M3Qy2BbwA@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <0711845b-c435-251f-0bbc-20b243721c06@huawei.com>
Date: Fri, 12 Jan 2024 19:51:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHS8izOtr+jfqQ6xCB3CoN-K_V1-4hPsB4-k5+1z-M3Qy2BbwA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/1/12 8:34, Mina Almasry wrote:
> On Thu, Jan 11, 2024 at 4:45 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/1/9 9:14, Mina Almasry wrote:
>>
>> ...
>>
>>>
>>> +             if (WARN_ON_ONCE(!skb_frag_page(&skb_shinfo(skb)->frags[0]))) {
>>
>> I am really hate to bring it up again.
>> If you are not willing to introduce a new helper,
> 
> I'm actually more than happy to add a new helper like:
> 
> static inline netmem_ref skb_frag_netmem();
> 
> For future callers to obtain frag->netmem to use the netmem_ref directly.
> 
> What I'm hung up on is really your follow up request:
> 
> "Is it possible to introduce something like skb_frag_netmem() for
> netmem? so that we can keep most existing users of skb_frag_page()
> unchanged and avoid adding additional checking overhead for existing
> users."
> 
> With this patchseries, skb_frag_t no longer has a page pointer inside
> of it, it only has a netmem_ref. The netmem_ref is currently always a
> page, but in the future may not be a page. Can you clarify how we keep
> skb_frag_page() unchanged and without checks? What do you expect
> skb_frag_page() and its callers to do? We can not assume netmem_ref is
> always a struct page. I'm happy to implement a change but I need to
> understand it a bit better.

There are still many existing places still not expecting or handling
skb_frag_page() returning NULL, mostly those are in the drivers not
supporting devmem, what's the point of adding the extral overhead for
those driver?

The networking stack should forbid skb with devmem frag being forwarded
to drivers not supporting devmem yet. I am sure if this is done properly
in your patchset yet? if not, I think you might to audit every existing
drivers handling skb_frag_page() returning NULL correctly.


> 
>> do you care to use some
>> existing API like skb_frag_address_safe()?
>>
> 
> skb_frag_address_safe() checks that the page is mapped. In this case,
> we are not checking if the frag page is mapped; we would like to make
> sure that the skb_frag has a page inside of it in the first place.
> Seems like a different check from skb_frag_address_safe().
> 
> In fact, skb_frag_address[_safe]() actually assume that the skb frag
> is always a page currently, I think I need to squash this fix:
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index e59f76151628..bc8b107d0235 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3533,7 +3533,9 @@ static inline void skb_frag_unref(struct sk_buff
> *skb, int f)
>   */
>  static inline void *skb_frag_address(const skb_frag_t *frag)
>  {
> -       return page_address(skb_frag_page(frag)) + skb_frag_off(frag);
> +       return skb_frag_page(frag) ?
> +               page_address(skb_frag_page(frag)) + skb_frag_off(frag) :
> +               NULL;
>  }
> 
>  /**
> @@ -3545,7 +3547,14 @@ static inline void *skb_frag_address(const
> skb_frag_t *frag)
>   */
>  static inline void *skb_frag_address_safe(const skb_frag_t *frag)
>  {
> -       void *ptr = page_address(skb_frag_page(frag));
> +       struct page *page;
> +       void *ptr;
> +
> +       page = skb_frag_page(frag);
> +       if (!page)
> +               return NULL;
> +
> +       ptr = page_address(skb_frag_page(frag));
>         if (unlikely(!ptr))
>                 return NULL;
> 
>>> +                     ret = -EINVAL;
>>> +                     goto out;
>>> +             }
>>> +
>>>               iov_iter_bvec(&msg.msg_iter, ITER_SOURCE,
>>> -                           skb_shinfo(skb)->frags, skb_shinfo(skb)->nr_frags,
>>> -                           msize);
>>> +                           (const struct bio_vec *)skb_shinfo(skb)->frags,
>>> +                           skb_shinfo(skb)->nr_frags, msize);
>>
>> I think we need to use some built-time checking to ensure some consistency
>> between skb_frag_t and bio_vec.
>>
> 
> I can add static_assert() that bio_vec->bv_len & bio_vec->bv_offset
> are aligned with skb_frag_t->len & skb_frag_t->offset.
> 
> I can also maybe add a helper skb_frag_bvec() to do the cast instead
> of doing it at the calling site. That may be a bit cleaner.

I think the more generic way to do is to add something like iov_iter_netmem()
instead of doing any cast, so that netmem can be decoupled from bvec completely.

> 
>>>               iov_iter_advance(&msg.msg_iter, txm->frag_offset);
>>>
>>>               do {
>>>
> 
> 
> 
> --
> Thanks,
> Mina
> .
> 

