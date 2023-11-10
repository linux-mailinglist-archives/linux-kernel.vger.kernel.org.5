Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A5A7E8649
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjKJXNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjKJXNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:13:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7C3AC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:13:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311CFC433C8;
        Fri, 10 Nov 2023 23:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699658017;
        bh=3kEmglIzeVKeC89qJz186In/g6MnNvWn/X0kBCEAmR0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=urs+N/fb0zYrePTt7BfGxDX3SlOzERDJqx1nVlvFB0bjm20DEIOtlngKpII5c8iUC
         JA+a/PQoHqi7fbtMcF6+72fNv57rXF0fFdo9uGu4Ib4h2e/rh0hXSVpgxVOwgyaE18
         ZOl47igkAtH6rUtgZzs1JZI9ZKl+tQln3SdK3zFqeuuKQSad1G2Qof0r6YqS5f+K/m
         avCl0oRY/UckS2XaoWsLJL6GjlHYaQMA8DZIW6fJPMh3vDNg2oHIlMUpsvzmjp/Qf8
         KlRCpaECHCkbwoKHIiku1cErTYNEclyDVpCghn5fmL2ME3UUxI7uHtCDyIvZ2t9Hq/
         OtoukLeU9AnSw==
Date:   Fri, 10 Nov 2023 15:13:35 -0800
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
Subject: Re: [RFC PATCH v3 12/12] selftests: add ncdevmem, netcat for devmem
 TCP
Message-ID: <20231110151335.38a1c6ec@kernel.org>
In-Reply-To: <20231106024413.2801438-13-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
        <20231106024413.2801438-13-almasrymina@google.com>
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

My brain is slightly fried after trying to catch up on the thread 
for close to 2h. So forgive me if I'm missing something.
This applies to all emails I'm about to send :)

On Sun,  5 Nov 2023 18:44:11 -0800 Mina Almasry wrote:
> +	trigger_device_reset();

The user space must not be responsible for the reset.
We can add some temporary "recreate page pools" ndo
until the queue API is ready. 

But it should not be visible to the user in any way.

And then the kernel can issue the same reset when the netlink 
socket dies to flush device free lists.

Maybe we should also add a "allow device/all-queues reload" flag 
to the netlink API to differentiate drivers which can't implement 
full queue API later on. We want to make sure the defaults work well 
in our "target design", rather than at the first stage. And target
design will reload queues one by one.
