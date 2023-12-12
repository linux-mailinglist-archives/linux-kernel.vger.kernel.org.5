Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE25B80F60C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjLLTIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjLLTIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:08:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4457E9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:08:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54B9C433C8;
        Tue, 12 Dec 2023 19:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702408094;
        bh=jhISTjjXnV6IhH0cY8Vge/0tePQdfehvyIi305w0McY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Au4hC/1gn8GAGqeNMIHMx+pf9H5e6cZx6if1YTAQ6myI1fcVcXp5E5HE2JZd7l5Ox
         z67YTPNEYCNjnSuydNuYjf11+fIKfzPgHgAvXDJMesthEcR7qviRft/QV/5zK2IHqc
         ruHQ42BTGcBdnaq77FMuM0r1fOHC9LqNVWjgGTPuAoXZTpwGA7dF5WXD028QLwM5fU
         83R8uUGoHmwAgKnoHD0ERZyXGTjjQTXsSeJdhkJcoe/E2jvGdjrJ/mAO3N0OzKkaja
         5wgu6LG6g2ra++dYX1DnvaNKyc0fxe1LJrSA1Kpyox0qvKLpHzYMqlHmzVyMur9vKu
         ehmZCE5A0RUew==
Date:   Tue, 12 Dec 2023 19:08:06 +0000
From:   Simon Horman <horms@kernel.org>
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
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Harshitha Ramamurthy <hramamurthy@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [net-next v1 14/16] net: add SO_DEVMEM_DONTNEED setsockopt to
 release RX frags
Message-ID: <20231212190806.GB5817@kernel.org>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-15-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208005250.2910004-15-almasrymina@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 04:52:45PM -0800, Mina Almasry wrote:
> Add an interface for the user to notify the kernel that it is done
> reading the devmem dmabuf frags returned as cmsg. The kernel will
> drop the reference on the frags to make them available for re-use.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

...

> diff --git a/net/core/sock.c b/net/core/sock.c
> index fef349dd72fa..521bdc4ff260 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1051,6 +1051,41 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
>  	return 0;
>  }
>  
> +static noinline_for_stack int
> +sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
> +{
> +	struct dmabuf_token tokens[128];

Hi Mina,

I am guessing it is mostly due to the line above,
but on x86 32bit builds I see:

	warning: the frame size of 1048 bytes is larger than 1024 bytes [-Wframe-larger-than

> +	unsigned int num_tokens, i, j;
> +	int ret;
> +
> +	if (sk->sk_type != SOCK_STREAM || sk->sk_protocol != IPPROTO_TCP)
> +		return -EBADF;
> +
> +	if (optlen % sizeof(struct dmabuf_token) || optlen > sizeof(tokens))
> +		return -EINVAL;
> +
> +	num_tokens = optlen / sizeof(struct dmabuf_token);
> +	if (copy_from_sockptr(tokens, optval, optlen))
> +		return -EFAULT;
> +
> +	ret = 0;
> +	for (i = 0; i < num_tokens; i++) {
> +		for (j = 0; j < tokens[i].token_count; j++) {
> +			struct page *page = xa_erase(&sk->sk_user_pages,
> +						     tokens[i].token_start + j);
> +
> +			if (page) {
> +				if (WARN_ON_ONCE(!napi_pp_put_page(page,
> +								   false)))
> +					page_pool_page_put_many(page, 1);
> +				ret++;
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  void sockopt_lock_sock(struct sock *sk)
>  {
>  	/* When current->bpf_ctx is set, the setsockopt is called from

...
