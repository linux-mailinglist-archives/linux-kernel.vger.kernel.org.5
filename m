Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F0C7E8664
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjKJXQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344800AbjKJXQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:16:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69BE211D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:16:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D168C433C8;
        Fri, 10 Nov 2023 23:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699658191;
        bh=lp6MUfcnlWg0MaE5+BDw4kORckYukPsXO/JArSSKHJ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iVuzaAhclFKl7LeZxL1NI8Ry5+2sm28Vs5NzEPoZdxbe3go12IaDJWLkU1qciBkSM
         whBYgKfAUNPBSEhJE4QJ7XezrNh7jGDkV5xIkVM0WEaslaTziGDnt7EcXARHStWAV+
         X6UvXOaaioy3gynvYEIjRXId9KFFQwsnC44K5pRX/XKXmzuJmcbveiUyk5oASlRWGl
         kJorEGqFqwRuYuDjtmNfv3ReaToE+lgcd+/1MwmRx/qDbHlD4itRI3rUiLvAhgRsE6
         /3K9PErcilfL1+yDjqcvhNbjPdvssNyP6Hk78Zm7WjFtgVSVlPYeMoU0i4fqtJVGeA
         dQ6M9ylbMVj5Q==
Date:   Fri, 10 Nov 2023 15:16:29 -0800
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
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [RFC PATCH v3 03/12] net: netdev netlink api to bind dma-buf to
 a net device
Message-ID: <20231110151629.047b1389@kernel.org>
In-Reply-To: <20231106024413.2801438-4-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
        <20231106024413.2801438-4-almasrymina@google.com>
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

On Sun,  5 Nov 2023 18:44:02 -0800 Mina Almasry wrote:
> +      -
> +        name: queues
> +        doc: receive queues to bind the dma-buf to.
> +        type: u32
> +        multi-attr: true

I think that you should throw in the queue type.
I know you made the op imply RX:

> +    -
> +      name: bind-rx

but if we decide to create a separate "type" for some magic 
queue type one day we'll have to ponder how to extend this API

IMHO queue should be identified by a <type, id> tuple, always.
