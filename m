Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA7580ECCD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376364AbjLLNHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjLLNHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:07:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFB3A8;
        Tue, 12 Dec 2023 05:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xbzg90/bq4JsbK+dNE7Eb/swVSGtySgf43OD8igrkzw=; b=fKv4tslN6ob6fVBvqGgRBleUK3
        ixwy1JJ4P+Dc6t/nAbUZeYdRQy05gz2GKaQOhGEI3/K7k80k40bsrIwIHldZt5RwiCD+XcSaBlfrX
        fU361clZ1RiKJY7+55mDsoc4Lb41E9t0PDs7z254jvFOegx2oAjVMr6IKS6JEXsisdpFxiqntc2S+
        5L+fZtwVp3sfL+Rkzsk8oP7uf40+jvMr1+kIHrDUu5f4BbCx1E8oP0jtA43OTru5hy9rWJR5dZeep
        1lsXlmqM7P8///m8p0g2ZcYJy6A+nF7smgZ0dkmFvIGG4x6rDFKrtZIE4ji20a5Q8zEqoDvz8g3Kf
        +5KRU6OA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rD2U2-00Bkt3-0U;
        Tue, 12 Dec 2023 13:07:34 +0000
Date:   Tue, 12 Dec 2023 05:07:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Harshitha Ramamurthy <hramamurthy@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [net-next v1 08/16] memory-provider: dmabuf devmem memory
 provider
Message-ID: <ZXhbFi42YClOVhQ7@infradead.org>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-9-almasrymina@google.com>
 <20231212122535.GA3029808@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212122535.GA3029808@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 08:25:35AM -0400, Jason Gunthorpe wrote:
> > +static inline struct page_pool_iov *page_to_page_pool_iov(struct page *page)
> > +{
> > +	if (page_is_page_pool_iov(page))
> > +		return (struct page_pool_iov *)((unsigned long)page & ~PP_IOV);
> > +
> > +	DEBUG_NET_WARN_ON_ONCE(true);
> > +	return NULL;
> > +}
> 
> We already asked not to do this, please do not allocate weird things
> can call them 'struct page' when they are not. It undermines the
> maintainability of the mm to have things mis-typed like
> this. Introduce a new type for your thing so the compiler can check it
> properly.

Yes.  Or even better avoid this mess entirely..
