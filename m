Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D7380E414
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjLLF6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLF6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:58:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2451DA1;
        Mon, 11 Dec 2023 21:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lgLwTEhQVr7SeOkAbXZIpqhiCYecdKkb92XRhk3Nnto=; b=YhOHsMUxRMFey39Ub+BOoHUSpN
        6MD2YvGw42vNtElnYki1NxJH9KlY8dt3Xm1HkV2P6cve8n0OT2lWYfK3Du2qGpAm+OR+Cys5wPkIf
        LE4znGLFwFzfwfuhB6/ZRcFvqHR3KNSaEVVBM4sFec7GGKvkoEBEVIp1GDKF6IeHVHVxytGCrpZCx
        1faM9v6zX2g+69mh7wf3OyXFWKq/ZNrIB+bGXJyrwEC02dodJ4tmwi4CT68czYOjwgp+Y+4GW16Am
        Y55OjcCnUTKf5hamO76diNt+t88idSnTc+d8igc/Ad7wSE/4sh15ZHLMvQYX/GREDrEwnDJrL70OT
        pMrg2+hQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rCvmR-00ApZl-36;
        Tue, 12 Dec 2023 05:58:07 +0000
Date:   Mon, 11 Dec 2023 21:58:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
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
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [net-next v1 00/16] Device Memory TCP
Message-ID: <ZXf2b/Bmupwm9LaD@infradead.org>
References: <20231208005250.2910004-1-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208005250.2910004-1-almasrymina@google.com>
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

Please don't spread scatterlists further.  They are a bad data structure
that mix input data (page, offset, len) and output data (phys_addr,
dma_offset, dma_len), and do in a horrible way for iommmu mappings that
can coalesce.  Jason and coworkers have been looking into the long
overdue API to better support batch mapping of better data structures,
and this is a prime example of new code that should be using.
