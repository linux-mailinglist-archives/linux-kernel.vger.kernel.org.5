Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E5E7579AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjGRKyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjGRKyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:54:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C98E60
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:54:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09650614F9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4846C433C8;
        Tue, 18 Jul 2023 10:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689677690;
        bh=VkiCUBmbXEThupNefKNKWnl4TsWI33/Zru4NwUp15sY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtZB0+of8mIHWCMLv1juOhUqqkkafip9RBlX56sG9o8x83U9k4B8NL7jjbCc8f37A
         bclxrPhMiDUTGSA6PYHOz2JgJViQzykXsNi5fdS1BJFIQzKQoWUMGJDGcfHQY8JGQN
         WIsRrRo25w2av3YKQDrwbN2wCtK9dvr3DcLCSoCG/rLSGRWsTbcsoTjYa/QNsWADZA
         Im3kgKg5FtTdGwjLd5Yr/sS9LK5jJj646LRMmBCubkSvNp9keJf2kK8Z/63emxCiJE
         WwUqS69seNytGmyGtazPuODnQM0dzYF5X4IuwmSbRlDQbD1dVJrvfALmMPVvQxzrF6
         DOKzH5hcVwZPA==
Date:   Tue, 18 Jul 2023 13:54:46 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ilia Lin <ilia.lin@gmail.com>
Cc:     Ilia Lin <quic_ilial@quicinc.com>, netdev@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfrm: Allow ESP over UDP in packet offload mode
Message-ID: <20230718105446.GD8808@unreal>
References: <20230718092405.4124345-1-quic_ilial@quicinc.com>
 <20230718095242.GC8808@unreal>
 <CA+5LGR0q6ut3CRgOx7VUC3MdZ5oJXU6E8RE0QVgN_m8yBxb57A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+5LGR0q6ut3CRgOx7VUC3MdZ5oJXU6E8RE0QVgN_m8yBxb57A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 01:15:12PM +0300, Ilia Lin wrote:
> Hi Leon,

Please don't top-post your replies.

> 
> Indeed the policy check is checking the sec_path lags set after
> decapsulation, but this has nothing to do with UDP encapsulation, the
> driver will set them anyway.

It doesn't make commit message correct.
"In packet offload mode, the RX is bypassing the XFRM, so we can enable the encapsulation."

> Regarding the driver support, each driver may restrict NAT-T support
> in their state_add callback, so in common code it may stay allowed.

We don't support out-of-tree drivers. Please submit it together with
relevant driver changes which exercise your newly opened path.

If you want, you can even take my series and submit it.

Thanks

> 
> Thanks,
> Ilia
> 
> BR,
> Ilia Lin
> 
> 
> 
> On Tue, Jul 18, 2023 at 12:53 PM Leon Romanovsky <leonro@nvidia.com> wrote:
> >
> > On Tue, Jul 18, 2023 at 12:24:05PM +0300, Ilia Lin wrote:
> > > The ESP encapsulation is not supported only in crypto mode.
> > > In packet offload mode, the RX is bypassing the XFRM,
> > > so we can enable the encapsulation.
> >
> > It is not accurate. RX is bypassed after XFRM validated packet to ensure
> > that it was really handled by HW.
> >
> > However, this patch should come with relevant driver code which should
> > support ESP over UDP. You can see it here:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=xfrm-next
> >  xfrm: Support UDP encapsulation in packet offload mode
> >  net/mlx5e: Support IPsec NAT-T functionality
> >  net/mlx5e: Check for IPsec NAT-T support
> >  net/mlx5: Add relevant capabilities bits to support NAT-T
> >
> > Thanks
> >
> > >
> > > Signed-off-by: Ilia Lin <ilia.lin@kernel.org>
> > > ---
> > >  net/xfrm/xfrm_device.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> > > index 4aff76c6f12e0..3018468d97662 100644
> > > --- a/net/xfrm/xfrm_device.c
> > > +++ b/net/xfrm/xfrm_device.c
> > > @@ -246,8 +246,10 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
> > >               return -EINVAL;
> > >       }
> > >
> > > -     /* We don't yet support UDP encapsulation and TFC padding. */
> > > -     if (x->encap || x->tfcpad) {
> > > +     is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;
> > > +
> > > +     /* We don't yet support UDP encapsulation except full mode and TFC padding. */
> > > +     if ((!is_packet_offload && x->encap) || x->tfcpad) {
> > >               NL_SET_ERR_MSG(extack, "Encapsulation and TFC padding can't be offloaded");
> > >               return -EINVAL;
> > >       }
> > > @@ -258,7 +260,6 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
> > >               return -EINVAL;
> > >       }
> > >
> > > -     is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;
> > >       dev = dev_get_by_index(net, xuo->ifindex);
> > >       if (!dev) {
> > >               if (!(xuo->flags & XFRM_OFFLOAD_INBOUND)) {
> > > --
> > >
> > >
> 
