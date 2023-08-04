Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2737A7709F4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjHDUpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHDUpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C2E4C2D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 276B1620B6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 20:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC365C433C8;
        Fri,  4 Aug 2023 20:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691181905;
        bh=8ywDJqkGVQloG5UrT53vJCwzkueyvL2Zdl1L+cadkP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RMwCQ3Vnw71xzrZuJ/jJ94o18ySfq5CXdxO1zj2Uwkwmzuuh5dSZoPMbRPleTSsVr
         QqirqQcnS7O3+eFxn+npGzlKeiueik5fE5S48AJJ/u5GlXUEeAXzagw0ms3ZtVt+Ip
         6FakjKhPwGAYikmH6Ba+/1XW5JlnjElhXooIHPyBom3rSgNij/74pHAVMOT7azjwXG
         XH//lz4B//oNKeQZ+EGKHLHu9vxS3vSZS4uAmtxKMZ1+5qKZ0LPPXFAEy7oDhCqfY+
         NdmkaDMvD4hjBCH9dIfhW6xHL5tLnZILsVTWXytFTzkLdiPjS3JovqEjaN02okZZ8y
         eZksZXtoEPR/g==
Date:   Fri, 4 Aug 2023 22:44:59 +0200
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
        Kees Cook <keescook@chromium.org>,
        Richard Gobert <richardbgobert@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [RFC Optimizing veth xsk performance 03/10] veth: add support
 for send queue
Message-ID: <ZM1jS2ndLNS+AjIv@vergenet.net>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
 <20230803140441.53596-4-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803140441.53596-4-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 10:04:29PM +0800, huangjie.albert wrote:

...

> @@ -69,11 +74,25 @@ struct veth_rq {
>  	struct page_pool	*page_pool;
>  };
>  
> +struct veth_sq {
> +	struct napi_struct	xdp_napi;
> +	struct net_device	*dev;
> +	struct xdp_mem_info	xdp_mem;
> +	struct veth_sq_stats	stats;
> +	u32 queue_index;
> +	/* this is for xsk */
> +	struct {
> +		struct xsk_buff_pool __rcu *pool;
> +		u32 last_cpu;
> +	}xsk;

nit: '}xsk;' -> '} xsk;'

Please consider running checkpatch.pl

...
