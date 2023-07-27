Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4CA7644C9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjG0EO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjG0EOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:14:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A53126B8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:14:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF50861D18
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A861BC433C8;
        Thu, 27 Jul 2023 04:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690431292;
        bh=n5IoGgevUqL40CMFdt7WgXl53BmR1iin6IDLbTGFxA4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PzlXTbtf73znm020yTLJQ+ESa5D7kpfpxRD1SSEsIajcmjvFJDyaEY6MUrLZC6jTT
         lW3TwUZYa8YI4t6Sc8CKQK6C6UX4DTUh8riGzQuza9kRsV+k7MuxKkoskZHYjdBrDu
         2GaIc4oZG5n9EPhTqW+L4vaTnOaDm9ZMxT8NxT5H1WctgrG2WWqj0JkUtjshlQJOns
         ZOhi+5vRipzYv+x9/NFUYoJ7F5j8VaHmmtIOY53Dts/HzDa5eC0Lw9y2iI0TQS/5RZ
         mRlxMNX0I5JuQtLX/0shn+kGtIzWkb/eY3bzoT3werJ03+VTkIpnmi0KCUjstSg6pm
         hOqfv44pdnYaQ==
Date:   Wed, 26 Jul 2023 21:14:50 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: fec: tx processing does not call XDP APIs if
 budget is 0
Message-ID: <20230726211450.209efe35@kernel.org>
In-Reply-To: <AM5PR04MB3139FC9C3FED1759E1160EAE8801A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230725074148.2936402-1-wei.fang@nxp.com>
        <70b71e7bb8a7dff2dacab99b0746e7bf2bee9344.camel@gmail.com>
        <AM5PR04MB31390FCD7DB9F905FCB599108800A@AM5PR04MB3139.eurprd04.prod.outlook.com>
        <CAKgT0Ufo8exTv1783Ud7EUg_1ei90Eb4ZoiHFd49zAbfhLgAsQ@mail.gmail.com>
        <AM5PR04MB3139FC9C3FED1759E1160EAE8801A@AM5PR04MB3139.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 02:08:32 +0000 Wei Fang wrote:
> > Actually after talking with Jakub a bit more there is an issue here,
> > but not freeing the frames isn't the solution. We likely need to just
> > fix the page pool code so that it doesn't attempt to recycle the
> > frames if operating in IRQ context.
> > 
> > The way this is dealt with for skbs is that we queue skbs if we are in
> > IRQ context so that it can be deferred to be freed by the
> > net_tx_action. We likely need to look at doing something similar for
> > page_pool pages or XDP frames.
> >   
> After reading your discussion with Jakub, I understand this issue a bit more.
> But we are not sure when this issue will be fixed in page pool, currently we
> can only tolerate a delay in sending of a netpoll message. So I think this patch
> is necessary, and I will refine it in the future when the page pool has fixed the
> issue. In addition, as you mentioned before, napi_consume_skb should be
> used to instead of dev_kfree_skb_any, so I will improve this patch in version 2.

I think so too, since the patch can only help, you already wrote it and
it won't be extra backporting work since the code is only present in
6.5 - I think it's worth applying. And we can refine things as page pool
limitations get listed (the napi_consume_skb() is net-next material,
anyway).
