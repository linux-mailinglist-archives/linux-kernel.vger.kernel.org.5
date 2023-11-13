Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF9A7EA6AC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 00:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjKMXGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjKMXGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:06:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B78CD6E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:05:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68507C433C8;
        Mon, 13 Nov 2023 23:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699916759;
        bh=KIbg7WSXtun715GyZV7F9AzyWxN0+AZgQG21Rel54vE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lAF7N6XbdGowJElZh0Qpcpm1mQ8RILmUNzGFr9fu3JccuyDj0m2XKcSyMz4ukLBR5
         SQy0QCW9oecl/BFfCp1O4+40xnUJO2YYCckLGGLcxR4dABVz0emOSiP02Nc/ehr9uj
         mfLlyB/h4oafSQOp+qKwVz0eCy/D5d3jA71cLvJlBsOHv/OfPEK+gV/itm6+5AGLu+
         K1GTQfXaZbAHNCnOLXg1ou7Bl/vuhGOalboG1CSEX1A29PO9x9mIN6kx/szK3JVRz+
         M+6PmL08K0CZcO/mU3lcoZ08JWATpETmcwtI8x2tnm/nT0h2SMcaTmZraYlBaM26qc
         41cd/lYa1NVkw==
Date:   Mon, 13 Nov 2023 18:05:54 -0500
From:   Jakub Kicinski <kuba@kernel.org>
To:     Mina Almasry <almasrymina@google.com>,
        Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
Message-ID: <20231113180554.1d1c6b1a@kernel.org>
In-Reply-To: <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
References: <20231113130041.58124-1-linyunsheng@huawei.com>
        <20231113130041.58124-4-linyunsheng@huawei.com>
        <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2023 05:42:16 -0800 Mina Almasry wrote:
> You're doing exactly what I think you're doing, and what was nacked in RFC v1.
> 
> You've converted 'struct page_pool_iov' to essentially become a
> duplicate of 'struct page'. Then, you're casting page_pool_iov* into
> struct page* in mp_dmabuf_devmem_alloc_pages(), then, you're calling
> mm APIs like page_ref_*() on the page_pool_iov* because you've fooled
> the mm stack into thinking dma-buf memory is a struct page.
> 
> RFC v1 was almost exactly the same, except instead of creating a
> duplicate definition of struct page, it just allocated 'struct page'
> instead of allocating another struct that is identical to struct page
> and casting it into struct page.
> 
> I don't think what you're doing here reverses the nacks I got in RFC
> v1. You also did not CC any dma-buf or mm people on this proposal that
> would bring up these concerns again.

Right, but the mirror struct has some appeal to a non-mm person like
myself. The problem IIUC is that this patch is the wrong way around, we
should be converting everyone who can deal with non-host mem to struct
page_pool_iov. Using page_address() on ppiov which hns3 seems to do in
this series does not compute for me.

Then we can turn the existing non-iov helpers to be a thin wrapper with
just a cast from struct page to struct page_pool_iov, and a call of the
iov helper. Again - never cast the other way around.

Also I think this conversion can be done completely separately from the
mem provider changes. Just add struct page_pool_iov and start using it.

Does that make more sense?
