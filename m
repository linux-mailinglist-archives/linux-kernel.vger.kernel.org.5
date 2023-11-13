Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C044A7EA5E1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 23:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjKMWRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 17:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKMWR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 17:17:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65DA10C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 14:17:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACAAC433C8;
        Mon, 13 Nov 2023 22:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699913845;
        bh=CxWQpMYa8YFxdmrO7alx+fTpOfQbmSEl3BDYj4zQHDQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pfTtVlCfr2biHw2W2q09MzqRYOXyxULA1cvXKH7lJgKmOoBelavwg2NXMOeLV7RUo
         hrZuG3PHE0z5OMU4LNRcYJVjk0cH2848YM8SF61BQovVnipqwkNu8pDfRo54FL/qed
         /K+B+kMd4vlsDHBN45H7bcB4/VHCJY4WQK9LS2T0cMlbtHGDade5u1H98jC04pTWwN
         KPdxdN8TpGk98s6qR3UTMZL77bOJSTg3QVyGaeJlKZR8wMv/V50rWPbz2j2fb7M3J8
         gAhCxBNq7Y1mkkatFEdAbqH0WbqHrEMgjNWtPrunbYike0UbTQowc3cHZ7MmbWmELA
         naKo5qrdJEm0Q==
Date:   Mon, 13 Nov 2023 17:17:21 -0500
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
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [RFC PATCH v3 08/12] net: support non paged skb frags
Message-ID: <20231113171721.1a6731e6@kernel.org>
In-Reply-To: <CAHS8izN7MydkJPaHfj7Pw0V+xoDBkCmEVTc1TH24=hjXm98xnQ@mail.gmail.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
        <20231106024413.2801438-9-almasrymina@google.com>
        <20231110151935.0859fd7a@kernel.org>
        <CAHS8izN7MydkJPaHfj7Pw0V+xoDBkCmEVTc1TH24=hjXm98xnQ@mail.gmail.com>
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

On Sun, 12 Nov 2023 22:05:30 -0800 Mina Almasry wrote:
> My issue here is that all these skb helpers call each other so I end
> up having to move a lot of the unrelated skb helpers to this new
> header (maybe that is acceptable but it feels weird).

Splitting pp headers again is not an option, we already split it into
types and helpers.

The series doesn't apply and it's a bit hard for me to, in between LPC
talks, figure out how to extract your patches from the GH UI to take a
proper look :(
We can defer this for now, and hopefully v4 will apply to net-next.
But it will need to get solved.
