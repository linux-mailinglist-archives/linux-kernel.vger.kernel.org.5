Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7B87C7D41
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 07:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjJMFxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 01:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjJMFxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 01:53:53 -0400
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817AAC0;
        Thu, 12 Oct 2023 22:53:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 4D60720847;
        Fri, 13 Oct 2023 07:53:48 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QFD-3-QelxB8; Fri, 13 Oct 2023 07:53:47 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 17372207C6;
        Fri, 13 Oct 2023 07:53:47 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
        by mailout2.secunet.com (Postfix) with ESMTP id 1247D80004A;
        Fri, 13 Oct 2023 07:53:47 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 07:53:46 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 13 Oct
 2023 07:53:46 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
        id 48E423182B10; Fri, 13 Oct 2023 07:53:46 +0200 (CEST)
Date:   Fri, 13 Oct 2023 07:53:46 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Cong Wang <xiyou.wangcong@gmail.com>, Ma Ke <make_ruc2021@163.com>,
        <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ipv6: fix return value check in esp_remove_trailer
Message-ID: <ZSjbatU0tcVZGWCW@gauss3.secunet.de>
References: <20231007005953.3994960-1-make_ruc2021@163.com>
 <ZSLh0vtpbP81Vh7G@pop-os.localdomain>
 <ZSUTdBpSTgNz5CA8@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZSUTdBpSTgNz5CA8@gondor.apana.org.au>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 05:03:48PM +0800, Herbert Xu wrote:
> On Sun, Oct 08, 2023 at 10:07:30AM -0700, Cong Wang wrote:
> > On Sat, Oct 07, 2023 at 08:59:53AM +0800, Ma Ke wrote:
> > > In esp_remove_trailer(), to avoid an unexpected result returned by
> > > pskb_trim, we should check the return value of pskb_trim().
> > > 
> > > Signed-off-by: Ma Ke <make_ruc2021@163.com>
> > > ---
> > >  net/ipv6/esp6.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > We need the same change for net/ipv4/esp4.c?
> 
> Please verify that it can actually fail first.  Note that I'm
> busy right now so I haven't looked at it at all.

It can, we don't linearize the packte data anymore.

