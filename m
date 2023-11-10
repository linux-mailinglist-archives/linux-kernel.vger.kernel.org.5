Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103FB7E8694
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjKJXTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjKJXTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:19:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C5A118
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:19:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F09C433C7;
        Fri, 10 Nov 2023 23:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699658349;
        bh=Dd3jebo4AS2ZWH3RN1miW12tLJYVseY43ijk1beJi20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H9fRqmR1U2biaQbf9D263gpWDTf7YUhWXczhracH0Gqee0CmKA+qgzlo4rVot0AT4
         VvRnNAMYi7xL/S717i4c4IPxlDQ27Xxz57zXWvgzpQbfb74hpSm4wp2JFMaRxkOJzB
         fj+czz+E8Oyt4aBl87v8bnmzxlr/c0CbeoIEEYUAueWdb4mk+2NjoQkZEjcjQBwozh
         9LfL+qJ3dyIPJ7NWqMHfS+YwblGi8nruc0OQAmVHTOTE14qsTB3BQT468KtuRrzLAb
         UoScOA5QJtOXbeetxc/ztCQwsddpviKocGz4LIRvi4ARQsbMSMxQImFnyt701L9Nqf
         m1tE/OsABgSxA==
Date:   Fri, 10 Nov 2023 15:19:07 -0800
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
Subject: Re: [RFC PATCH v3 02/12] net: page_pool: create hooks for custom
 page providers
Message-ID: <20231110151907.023c61cd@kernel.org>
In-Reply-To: <20231106024413.2801438-3-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
        <20231106024413.2801438-3-almasrymina@google.com>
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

On Sun,  5 Nov 2023 18:44:01 -0800 Mina Almasry wrote:
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 6fc5134095ed..d4bea053bb7e 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -60,6 +60,8 @@ struct page_pool_params {
>  	int		nid;
>  	struct device	*dev;
>  	struct napi_struct *napi;
> +	u8		memory_provider;
> +	void            *mp_priv;
>  	enum dma_data_direction dma_dir;
>  	unsigned int	max_len;
>  	unsigned int	offset;

you should rebase on top of net-next

More importantly I was expecting those fields to be gone from params.
The fact that the page pool is configured to a specific provider
should be fully transparent to the driver, driver should just tell
the core what queue its creating the pool from and if there's a dmabuf
bound for that queue - out pops a pp backed by the dmabuf.

My RFC had the page pool params fields here as a hack.
