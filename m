Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A567E8690
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjKJXT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjKJXTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:19:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA550D64
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:19:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79674C433C8;
        Fri, 10 Nov 2023 23:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699658361;
        bh=1I7t6Ai+hRiLbbZt727Rjf2UhRX77+78thKzDhoeWNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O87Imx2q0q+m9Txp/BMMtKPySHNAC/fXEp5NddB1B31ZjSiC47SpaEs6eJBarHKXm
         +Erk7Qmwa9yVFKKwvAYiGm5AWGK5QVV9b33ahB3sp2SIc6T2CW+FOMDLZq8nL5UCqL
         TtRaBspceqey9QIfFnaplznB+rFQXDfxqixws23mVhSOk/JejjtM/hFqCymVDQ52n7
         tkXcanIIYj9S5W1AQ0IR8GD/uNZMowbqeS9hpF9JS8WIJR9L0qjPwiVrM+/FWRCsTz
         LWLgjQbjT2MJdhifaDNGqktUUGdKgMvYBKr3eMlvijg9am5zIQ3eX6QWTgNboVneoe
         5FQBROhSnrQRw==
Date:   Fri, 10 Nov 2023 15:19:19 -0800
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
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
Message-ID: <20231110151919.4789d54b@kernel.org>
In-Reply-To: <20231106024413.2801438-11-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
        <20231106024413.2801438-11-almasrymina@google.com>
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

On Sun,  5 Nov 2023 18:44:09 -0800 Mina Almasry wrote:
> +		if (!skb_frags_not_readable(skb)) {

nit: maybe call the helper skb_frags_readable() and flip
     the polarity, avoid double negatives.
