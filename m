Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A7B7E8667
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344425AbjKJXRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjKJXRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:17:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B2A1B3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:17:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B48C433C7;
        Fri, 10 Nov 2023 23:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699658232;
        bh=DgVOmmZyh3PXIlWFtVjMUaKArXLuCBtm1eqxE6u0RQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IgPe1WP3NH7aJqiPGbFf01nnZ3S9WWaPDdxWlqeYzs9iaDXsoDvv2dqwKir3GxS/8
         ovIfqe7IwZnmwI9MvJbsCTwHRj4470U3s09zOeVzdZc/YZ2sZAar9hq9ndnbCwoiF8
         KPicEYVkTbWf2SWOfHTrvLpJWh7+lddI4LXveik/S0m5YQEgD8OwusdxvhMnijrwp3
         QbeMiiInT7XxDlesibExVQDmqs0ZhzwtrM7mq3HcqWj+OtiNDqLoDWk/RiwPdsfMrP
         +fEJD6tHAp1grxD54ay+pE7B6chuXtshliijsxPD1JgQiX16WMoSN6FtvZ78OGNuwC
         //C01sLxUSBsQ==
Date:   Fri, 10 Nov 2023 15:17:10 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Christian =?UTF-8?B?S8O2bmln?=" <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable
 frags
Message-ID: <20231110151710.2ceded75@kernel.org>
In-Reply-To: <ZUq42Po1Pn-9QxrM@google.com>
References: <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
        <ZUlvzm24SA3YjirV@google.com>
        <CAHS8izMQ5Um_ScY0VgAjaEaT-hRh4tFoTgc6Xr9Tj5rEj0fijA@mail.gmail.com>
        <CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com>
        <CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com>
        <CAHS8izNxKHhW5uCqmfau6n3c18=hE3RXzA+ng5LEGiKj12nGcg@mail.gmail.com>
        <ZUmNk98LyO_Ntcy7@google.com>
        <CAHS8izNTDsHTahkd17zQVQnjzniZAk-dKNs-Mq0E4shdrXOJbg@mail.gmail.com>
        <ZUqms8QzQpfPQWyy@google.com>
        <CANn89iJNR8bYYBO92=f5_2hFoTK8+giH11o-7NHURoahwvV11w@mail.gmail.com>
        <ZUq42Po1Pn-9QxrM@google.com>
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

On Tue, 7 Nov 2023 14:23:20 -0800 Stanislav Fomichev wrote:
> Can we mark a socket as devmem-only? Do we have any use-case for those
> hybrid setups? Or, let me put it that way: do we expect API callers
> to handle both linear and non-linear cases correctly?
> As a consumer of the previous versions of these apis internally,
> I find all those corner cases confusing :-( Hence trying to understand
> whether we can make it a bit more rigid and properly defined upstream.

FWIW I'd also prefer to allow mixing. "Some NICs" can decide HDS
very flexibly, incl. landing full jumbo frames into the "headers".

There's no sender API today to signal how to mark the data for
selective landing,  but if Mina already has the rx side written 
to allow that...
