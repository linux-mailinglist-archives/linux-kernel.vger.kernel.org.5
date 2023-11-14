Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5DB7EB3F4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjKNPmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjKNPl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:41:59 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D992FE;
        Tue, 14 Nov 2023 07:41:55 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41e1921da84so36487781cf.1;
        Tue, 14 Nov 2023 07:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976514; x=1700581314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHuPbGTkYgcRjXR0hklnMMX7c/POaWOgK07UCodpGXc=;
        b=WikkVV6b7JRsehG6wm7zCddjinfnnizaiCewlrH4sTaxXw4GrJ2+lHUS5NU6iGSY6J
         /hLs9w04nF2Bk4D8n+I3VTSaBpFbSAo+rnMlqxg5fv0ShJCIBuVwcdapLsw76X5zpH2W
         1UkI5syhCfEmpHHljBtzFRnLBzs/DxD/l2653i3piGCmGe+3kGYHOjzm1qX407jfcs6j
         F/hlsMaVOA6L0JwQUPk9FS/OAApEtOaAxJxWqxSTL0eKXs6LVHaKHLsC39gf74fgn+5/
         xeH00EaTiHNBfvOAYWIbjoq8FpDjQXFVy9ysTRw4NSkgWmzg9gb0+1cRyykAz2zGpqDI
         MXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976514; x=1700581314;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OHuPbGTkYgcRjXR0hklnMMX7c/POaWOgK07UCodpGXc=;
        b=U/sL8UxmQJ2yJDlFBymL+tblBYl/2EfEwJoVFHoxobLroryw7t0lzC2u+z0R4dD4yE
         bluXohX9jC3oLrRnONZBXyz43BTcWJwxaGmQ3yRkQaLqilBR9+3NoV2LolXoldmj4QIT
         EZ+7wvWAoPruVj3IU8xWK9j5CPR9jqAUCMWbPDC/0AUeKk86xvgKcTf+dry4O96d3qqe
         n6cZxwO5Adqy+oYX8M7E+M5vnL1ieh4Tp1DOfuusshtKh2f5CzPtOnZAAGfLG/Apw5kv
         ap7cNeedhEsKbHg7R0LMfO6s7SUcVYaM4qKpVHHA7rkh0faR+/IBKqX51bUkEJrbucnf
         geLw==
X-Gm-Message-State: AOJu0YxPvVN059uChIkq1a/liaVeWpkzJWs7DKwj6EmDH48LdgqPAxFo
        qzPxyqmUu8coAOOyNeWKLTw=
X-Google-Smtp-Source: AGHT+IFs64/UsS9fZvQ9xDBNoANRH+wyYXjr0la/mrjhV9dTBqJKDbpQ+ydNpWVgesakcWDxb3pZVg==
X-Received: by 2002:a05:622a:1792:b0:41c:bbd0:48c2 with SMTP id s18-20020a05622a179200b0041cbbd048c2mr2618524qtk.59.1699976514116;
        Tue, 14 Nov 2023 07:41:54 -0800 (PST)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id o11-20020ac8428b000000b004166ab2e509sm2804405qtl.92.2023.11.14.07.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:41:53 -0800 (PST)
Date:   Tue, 14 Nov 2023 10:41:53 -0500
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Yunsheng Lin <linyunsheng@huawei.com>,
        Mina Almasry <almasrymina@google.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Message-ID: <6553954141762_1245c529423@willemb.c.googlers.com.notmuch>
In-Reply-To: <3ff54a20-7e5f-562a-ca2e-b078cc4b4120@huawei.com>
References: <20231113130041.58124-1-linyunsheng@huawei.com>
 <20231113130041.58124-4-linyunsheng@huawei.com>
 <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
 <20231113180554.1d1c6b1a@kernel.org>
 <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
 <CAHS8izNxkqiNbTA1y+BjQPAber4Dks3zVFNYo4Bnwc=0JLustA@mail.gmail.com>
 <fa5d2f4c-5ccc-e23e-1926-2d7625b66b91@huawei.com>
 <CAHS8izMj_89dMVaMr73r1-3Kewgc1YL3A1mjvixoax2War8kUg@mail.gmail.com>
 <3ff54a20-7e5f-562a-ca2e-b078cc4b4120@huawei.com>
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yunsheng Lin wrote:
> On 2023/11/14 20:58, Mina Almasry wrote:
> 
> >>
> >> Yes, as above, skb_frags_not_readable() checking is still needed for
> >> kmap() and page_address().
> >>
> >> get_page, put_page related calling is avoided in page_pool_frag_ref()
> >> and napi_pp_put_page() for devmem page as the above checking is true
> >> for devmem page:
> >> (pp_iov->pp_magic & ~0x3UL) == PP_SIGNATURE
> >>
> > 
> > So, devmem needs special handling with if statement for refcounting,
> > even after using struct pages for devmem, which is not allowed (IIUC
> > the dma-buf maintainer).
> 
> It reuses the already existing checking or optimization, that is the point
> of 'mirror struct'.
> 
> > 
> >>>
> >>>> The main difference between this patchset and RFC v3:
> >>>> 1. It reuses the 'struct page' to have more unified handling between
> >>>>    normal page and devmem page for net stack.
> >>>
> >>> This is what was nacked in RFC v1.
> >>>
> >>>> 2. It relies on the page->pp_frag_count to do reference counting.
> >>>>
> >>>
> >>> I don't see you change any of the page_ref_* calls in page_pool.c, for
> >>> example this one:
> >>>
> >>> https://elixir.bootlin.com/linux/latest/source/net/core/page_pool.c#L601
> >>>
> >>> So the reference the page_pool is seeing is actually page->_refcount,
> >>> not page->pp_frag_count? I'm confused here. Is this a bug in the
> >>> patchset?
> >>
> >> page->_refcount is the same as page_pool_iov->_refcount for devmem, which
> >> is ensured by the 'PAGE_POOL_MATCH(_refcount, _refcount);', and
> >> page_pool_iov->_refcount is set to one in mp_dmabuf_devmem_alloc_pages()
> >> by calling 'refcount_set(&ppiov->_refcount, 1)' and always remains as one.
> >>
> >> So the 'page_ref_count(page) == 1' checking is always true for devmem page.
> > 
> > Which, of course, is a bug in the patchset, and it only works because
> > it's a POC for you. devmem pages (which shouldn't exist according to
> > the dma-buf maintainer, IIUC) can't be recycled all the time. See
> > SO_DEVMEM_DONTNEED patch in my RFC and refcounting needed for devmem.
> 
> I am not sure dma-buf maintainer's concern is still there with this patchset.
> 
> Whatever name you calling it for the struct, however you arrange each field
> in the struct, some metadata is always needed for dmabuf to intergrate into
> page pool.
> 
> If the above is true, why not utilize the 'struct page' to have more unified
> handling?

My understanding is that there is a general preference to simplify struct
page, and at the least not move in the other direction by overloading the
struct in new ways.

If using struct page for something that is not memory, there is ZONE_DEVICE.
But using that correctly is non-trivial:

https://lore.kernel.org/all/ZKyZBbKEpmkFkpWV@ziepe.ca/ 

Since all we need is a handle that does not leave the network stack,
a network specific struct like page_pool_iov entirely avoids this issue.
RFC v3 seems like a good simplification over RFC v1 in that regard to me.
I was also pleasantly surprised how minimal the change to the users of
skb_frag_t actually proved to be.
