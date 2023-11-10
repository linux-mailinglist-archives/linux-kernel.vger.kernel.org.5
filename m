Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5117E8693
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjKJXTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjKJXTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:19:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2403A97
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:19:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C55C433C9;
        Fri, 10 Nov 2023 23:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699658377;
        bh=luJNmLAVg0NvFE4vMKzZIgSGc1vreIiFo+6ll6uU50g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K1fE9DxAmngdEnLFVm0IGl0MMxV8bmBLE0Ae9DA9ep5/htSzaSPrZ06BwKpbu8Awv
         QQkFJyOpbK1xhaj0LojSLeZ6qxU+20U73LLDIwR8j0EbdT2o90JDNif00PNGcZjgQX
         R+z1UqQYhwDMVhxvxSxemLWgLvTkTyTjtXhnMqvI7zRUOwypHo4TEp0IkYZQUrVHW/
         hgFXKLSR/BOf7nYeVqQ30PWCnefMPg90ivl3acdKti9EBwizBYD4TTbUSk/87mr5p0
         VkzMPc0fv3Vdsxw8bT+iI8746rthCtklXgTSra4ki3boHAj2e4s8JAKvzp/9+hlwSH
         /4kbehSUkS9kQ==
Date:   Fri, 10 Nov 2023 15:19:35 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Christian =?UTF-8?B?S8O2bmln?=" <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [RFC PATCH v3 08/12] net: support non paged skb frags
Message-ID: <20231110151935.0859fd7a@kernel.org>
In-Reply-To: <20231106024413.2801438-9-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
        <20231106024413.2801438-9-almasrymina@google.com>
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

On Sun,  5 Nov 2023 18:44:07 -0800 Mina Almasry wrote:
>  #include <net/net_debug.h>
>  #include <net/dropreason-core.h>
> +#include <net/page_pool/types.h>
> +#include <net/page_pool/helpers.h>

>  /**
>   * DOC: skb checksums
> @@ -3402,15 +3404,38 @@ static inline void skb_frag_off_copy(skb_frag_t *fragto,
>  	fragto->bv_offset = fragfrom->bv_offset;
>  }
>  
> +/* Returns true if the skb_frag contains a page_pool_iov. */
> +static inline bool skb_frag_is_page_pool_iov(const skb_frag_t *frag)
> +{
> +	return page_is_page_pool_iov(frag->bv_page);
> +}

Maybe we can create a new header? For skb + page pool.

skbuff.h is included by 1/4th of the kernel objects, we should not
be adding dependencies to this header, it really slows down incremental
builds.

