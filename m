Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F34C7D38D3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjJWOEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjJWOEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:04:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA893100
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:04:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74247C433C8;
        Mon, 23 Oct 2023 14:04:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NZR/yraA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1698069857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a50K0V9T1FPsR2jaKp1w4O6pzSmklgTtl4SI1anzDNw=;
        b=NZR/yraAyQD6UFh5OFNCQwAN8jFa0XXnp5//mlWQvFo7VrBJlkIs/Los7YsKijowzzCMrN
        TjYIzwVoyCzNEgSl5csIDcuJLWw/FG+CmawZlQmsVSJGvE76RPTAq7dWigIPcH4jJ5RWCA
        zg4lZUDB48ZR/K6VLkx/SQTQHYqRKiQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c64f3372 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 23 Oct 2023 14:04:16 +0000 (UTC)
Date:   Mon, 23 Oct 2023 16:04:13 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Daniel =?utf-8?Q?Gr=C3=B6ber?= <dxld@darkboxed.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, wireguard@lists.zx2c4.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wireguard: Fix leaking sockets in wg_socket_init error
 paths
Message-ID: <ZTZ9XfPOXD4JXdjk@zx2c4.com>
References: <20231023130609.595122-1-dxld@darkboxed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023130609.595122-1-dxld@darkboxed.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The signed-off-by is missing and the subject does not match the format
of any other wireguard commits.

On Mon, Oct 23, 2023 at 03:06:09PM +0200, Daniel Gröber wrote:
> This doesn't seem to be reachable normally, but while working on a patch

"Normally" as in what? At all? Or?

> for the address binding code I ended up triggering this leak and had to
> reboot to get rid of the leaking wg sockets.

This commit message doesn't describe any rationale for this patch. Can
you describe the bug?

> ---
>  drivers/net/wireguard/socket.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
> index 0414d7a6ce74..c35163f503e7 100644
> --- a/drivers/net/wireguard/socket.c
> +++ b/drivers/net/wireguard/socket.c
> @@ -387,7 +387,7 @@ int wg_socket_init(struct wg_device *wg, u16 port)
>  	ret = udp_sock_create(net, &port4, &new4);
>  	if (ret < 0) {
>  		pr_err("%s: Could not create IPv4 socket\n", wg->dev->name);
> -		goto out;
> +		goto err;

`new4` is either NULL or has already been freed here in the `goto retry`
case. `new6` is NULL here.

>  	}
>  	set_sock_opts(new4);
>  	setup_udp_tunnel_sock(net, new4, &cfg);
> @@ -402,7 +402,7 @@ int wg_socket_init(struct wg_device *wg, u16 port)
>  				goto retry;
>  			pr_err("%s: Could not create IPv6 socket\n",
>  			       wg->dev->name);
> -			goto out;
> +			goto err;

`new4` has just been freed by `udp_tunnel_sock_release` just above the
context. `new6` is NULL.

>  		}
>  		set_sock_opts(new6);
>  		setup_udp_tunnel_sock(net, new6, &cfg);
> @@ -414,6 +414,11 @@ int wg_socket_init(struct wg_device *wg, u16 port)
>  out:
>  	put_net(net);
>  	return ret;
> +
> +err:
> +	sock_free(new4 ? new4->sk : NULL);
> +	sock_free(new6 ? new6->sk : NULL);
> +	goto out;
>  }
>  
>  void wg_socket_reinit(struct wg_device *wg, struct sock *new4,

I don't see the bug. If there is one, maybe try again with a real patch
that describes it better. If there isn't one, what is the point?

Jason
