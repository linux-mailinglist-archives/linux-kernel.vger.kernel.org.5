Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666E07E8662
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjKJXQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjKJXQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:16:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11067D5A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:16:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF495C433C7;
        Fri, 10 Nov 2023 23:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699658184;
        bh=Uzz0ofUN0GdWH6BIrAshYk7RdH6xgZcN3EjqeZ+1zb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FTADZZ/90F/7qwZfq6DctzfUcvXxWTAoVgPB4JcKl+BMyH4buYHADpYZMdAzpAtq6
         ZkpHYO/gp4t8yqM3oNbMpeyWBT8vky55ihaponMI0vdm/liYjSt1GC4uyn0V9FVaOt
         Ci5+/YA/uVcx09vVsyYQ+9mkDz0IhRweb9Vvn0hs12m85umwqMGYXjdIZAPzcvHR87
         dipszU5QLy7d/fMOLKUiMqv3+0GQX18SNrmWTTOFuVqonSUFbv2X5QLZ0jGlVpsiRR
         /3/6wSoEMflLvU+dcVnsOv05+hwfMLIhOinjtDs49Ql7PYstp/ifr08J9Rtd/e0jlc
         jJoJdqMU03YUQ==
Date:   Fri, 10 Nov 2023 15:16:22 -0800
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
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [RFC PATCH v3 06/12] memory-provider: dmabuf devmem memory
 provider
Message-ID: <20231110151622.2f45f618@kernel.org>
In-Reply-To: <20231106024413.2801438-7-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
        <20231106024413.2801438-7-almasrymina@google.com>
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

On Sun,  5 Nov 2023 18:44:05 -0800 Mina Almasry wrote:
> +static int mp_dmabuf_devmem_init(struct page_pool *pool)
> +{
> +	struct netdev_dmabuf_binding *binding = pool->mp_priv;
> +
> +	if (!binding)
> +		return -EINVAL;
> +
> +	if (pool->p.flags & PP_FLAG_DMA_MAP ||
> +	    pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> +		return -EOPNOTSUPP;

This looks backwards, we should _force_ the driver to use the dma
mapping built into the page pool APIs, to isolate the driver from
how the DMA addr actually gets obtained. Right?

Maybe seeing driver patches would illuminate.
