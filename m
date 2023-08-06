Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6457716A8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 21:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjHFTvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 15:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHFTvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 15:51:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7D8171B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 12:51:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BE5361072
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A88C433C7;
        Sun,  6 Aug 2023 19:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691351493;
        bh=wv7mtAHZJr2vZeWnUM1Beb+dSs/Qq2Vp36EkkPj9g1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l0Vh9B6yDi1z2HfT80A6yDd/ZUhnPq6Ot51QorbDetx2LDATIK3EsklcgbkVwR00l
         8lF2dN10cfGjkxZZ9YKJ7aLJt1427MjFmYxmK8sRhunSKyFdOWh/0h7p742Z8WB0hx
         MGpT634+O6jGo6GHn0EwX5sWeGSOTRD4jk/LHqX64I/syC4ki6+UnXha5hMNBYX9m0
         UvORuvoEhQsts/Ml0+XtqtaL9Azo4yRfYxP5MPArAN1A5FfnC1q528oqbotIB4Woia
         dViongoUvqmhykZnW/SN8hxmUrHaCKB4QFWoLkK23l0zuP5hUgXJUx/07BqT83ux4i
         EILWDbQlSVKBA==
Date:   Sun, 6 Aug 2023 21:51:28 +0200
From:   Simon Horman <horms@kernel.org>
To:     Simon Horman <horms@kernel.org>
Cc:     yang.yang29@zte.com.cn, jmaloy@redhat.com, davem@davemloft.net,
        ying.xue@windriver.com, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: tipc: add net device refcount tracker for bearer
Message-ID: <ZM/5wD5hZqgDNg3i@vergenet.net>
References: <202308041653414100323@zte.com.cn>
 <ZM4yAOKtdcTBXQQY@vergenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZM4yAOKtdcTBXQQY@vergenet.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 01:26:56PM +0200, Simon Horman wrote:
> On Fri, Aug 04, 2023 at 04:53:41PM +0800, yang.yang29@zte.com.cn wrote:
> > From: xu xin <xu.xin16@zte.com.cn>
> > 
> > Add net device refcount tracker to the struct tipc_bearer.
> > 
> > Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> > Reviewed-by: Yang Yang <yang.yang.29@zte.com.cn>
> > Cc: Kuang Mingfu <kuang.mingfu@zte.com.cn>
> 
> ...
> 
> > @@ -479,7 +479,7 @@ void tipc_disable_l2_media(struct tipc_bearer *b)
> >  	dev_remove_pack(&b->pt);
> >  	RCU_INIT_POINTER(dev->tipc_ptr, NULL);
> >  	synchronize_net();
> > -	dev_put(dev);
> > +	netdev_put(dev, &b->devtracker);
> >  }
> > 
> >  /**
> > diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h
> > index 41eac1ee0c09..1adeaf94aa62 100644
> > --- a/net/tipc/bearer.h
> > +++ b/net/tipc/bearer.h
> > @@ -174,6 +174,7 @@ struct tipc_bearer {
> >  	u16 encap_hlen;
> >  	unsigned long up;
> >  	refcount_t refcnt;
> > +	netdevice_tracker	devtracker;
> 
> Hi Xu Xin and Yang Yang,
> 
> Please add netdevice_tracker to the kernel doc for struct tipc_bearer,
> which appears just above the definition of the structure.
> 
> >  };
> > 
> >  struct tipc_bearer_names {
> 
> With that fixed, feel free to add:
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Given review of other, similar patches, by Eric.
I think it would be best to confirm that this patch
has been tested.
