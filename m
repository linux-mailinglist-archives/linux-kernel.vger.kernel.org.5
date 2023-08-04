Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030E7770A2D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjHDU7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjHDU7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:59:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC55E46
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:59:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EF2D620A7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 20:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC36AC433C7;
        Fri,  4 Aug 2023 20:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691182779;
        bh=xl9ztlWBE79b1gyAU0i58q8O4xnhwyApAJm9B8ORFps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TLfT6PIF0sqgoaK3n/922Fa8/0gbGRWzzj/dTE1NEb80e9p+UDpiPw2Etmo+/399F
         gj9QhBEPBBkXT5rVG+n+aVfTO5n5cQEgDp7vKsiCOQTWE2G5mVWENI7oF+HvuRKhei
         n63JWg+aVkNjc7zs5ZpdAdJQ+twt7S4EIrIeLo9FxqBCcy0LQOCJGF4vI5ht4ChVQ3
         EoPnAjDeuBIREbrezDZJYMGXa0DGk2DyGSOqh6Q7/MA5Te6zGXxa3yLrPxTPK1O0j8
         HKREwC78Jxros3kkvSp3NchfTEtcKZI2/aVErOMd8Ta0xAk/6R1ljGKOrvZV5cWP9/
         wcuhxNsK5XIow==
Date:   Fri, 4 Aug 2023 22:59:33 +0200
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
        Menglong Dong <imagedong@tencent.com>,
        Richard Gobert <richardbgobert@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [RFC Optimizing veth xsk performance 05/10] veth: use send queue
 tx napi to xmit xsk tx desc
Message-ID: <ZM1mtcIBUzL5kwll@vergenet.net>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
 <20230803140441.53596-6-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803140441.53596-6-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 10:04:31PM +0800, huangjie.albert wrote:

Please include a patch description.

> Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>

Please consider formatting this as:

	... Albert Huang <huangjie.albert@bytedance.com>

> ---
>  drivers/net/veth.c | 265 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 264 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 63c3ebe4c5d0..944761807ca4 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -27,6 +27,8 @@
>  #include <linux/bpf_trace.h>
>  #include <linux/net_tstamp.h>
>  #include <net/page_pool.h>
> +#include <net/xdp_sock_drv.h>
> +#include <net/xdp.h>
>  
>  #define DRV_NAME	"veth"
>  #define DRV_VERSION	"1.0"

> @@ -1061,6 +1063,176 @@ static int veth_poll(struct napi_struct *napi, int budget)
>  	return done;
>  }
>  
> +static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool, int budget)
> +{
> +	struct veth_priv *priv, *peer_priv;
> +	struct net_device *dev, *peer_dev;
> +	struct veth_rq *peer_rq;
> +	struct veth_stats peer_stats = {};
> +	struct veth_stats stats = {};
> +	struct veth_xdp_tx_bq bq;
> +	struct xdp_desc desc;
> +	void *xdpf;
> +	int done = 0;

Please try to use reverse xmas tree ordering - longest line to shortest -
for local variable declarations in new Networking code.

https://github.com/ecree-solarflare/xmastree is your friend here.

> +
> +	bq.count = 0;
> +	dev = sq->dev;
> +	priv = netdev_priv(dev);
> +	peer_dev = priv->peer;

Sparse seems a bit unhappy about this.

  .../veth.c:1081:18: warning: incorrect type in assignment (different address spaces)
  .../veth.c:1081:18:    expected struct net_device *peer_dev
  .../veth.c:1081:18:    got struct net_device [noderef] __rcu *peer

Looking over existing code in this file, perhaps this is appropriate:

	peer_dev = rtnl_dereference(priv->peer);

Likewise in a few other places in this patch.

...
