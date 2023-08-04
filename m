Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4CF770A5E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjHDVFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjHDVFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:05:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD475592
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:05:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00D28620DD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 21:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B429AC433C8;
        Fri,  4 Aug 2023 21:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691183108;
        bh=gJt669rsfGxg9edElmNCRVGPd1QDKDSpXCM3ZtENT2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E16slqox7a3VQa4utXPuURhDCW1McbB9kCRJaIIHQqNEWriaHXjOMhwmMsmKV7jiN
         uRakANi+tNkYAPlU2THvsLNpwBAwzyS2oeshEuj/nFSMVR1pgqSouihj5JOqKAH1Dy
         j9XKloVg2zGbqI0+gQX1ybOBB4fhR+2KDk9ujyEgsjk8CbndAVK2vPrXFwmNQZQz21
         U0uWPIw3GfwAGpOSDj8Y9xStDDthanaNGeC/qslT3UE5M9KhfOY4H0bCE0mi+tsMal
         aH7vu8rul4eAR1ztuTQX6c4I/dGW14tf/ayiPG/sqKY4iRgQisRmipSex2LKTB837n
         X3JOz9kBX/A/A==
Date:   Fri, 4 Aug 2023 23:05:02 +0200
From:   Simon Horman <horms@kernel.org>
To:     "huangjie.albert" <huangjie.albert@bytedance.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Gobert <richardbgobert@gmail.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [RFC Optimizing veth xsk performance 09/10] veth: support zero
 copy for af xdp
Message-ID: <ZM1n/kAXoL3oeprb@vergenet.net>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
 <20230803140441.53596-10-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803140441.53596-10-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 10:04:35PM +0800, huangjie.albert wrote:

...

> +static struct sk_buff *veth_build_skb_zerocopy(struct net_device *dev, struct xsk_buff_pool *pool,
> +					      struct xdp_desc *desc)
> +{
> +	struct veth_seg_info *seg_info;
> +	struct sk_buff *skb;
> +	struct page *page;
> +	void *hard_start;
> +	u32 len, ts;
> +	void *buffer;
> +	int headroom;
> +	u64 addr;
> +	u32 index;
> +
> +	addr = desc->addr;
> +	len = desc->len;
> +	buffer = xsk_buff_raw_get_data(pool, addr);
> +	ts = pool->unaligned ? len : pool->chunk_size;
> +
> +	headroom = offset_in_page(buffer);
> +
> +	/* offset in umem pool buffer */
> +	addr = buffer - pool->addrs;
> +
> +	/* get the page of the desc */
> +	page = pool->umem->pgs[addr >> PAGE_SHIFT];
> +
> +	/* in order to avoid to get freed by kfree_skb */
> +	get_page(page);
> +
> +	hard_start = page_to_virt(page);
> +
> +	skb = veth_build_skb(hard_start, headroom, len, ts);
> +	seg_info = (struct veth_seg_info *)kmalloc(struct_size(seg_info, desc, MAX_SKB_FRAGS), GFP_KERNEL);

There is no need to explicitly case the return value of kmalloc,
as it returns void *.

	seg_info = kmalloc(struct_size(seg_info, desc, MAX_SKB_FRAGS),
			   GFP_KERNEL);

...
