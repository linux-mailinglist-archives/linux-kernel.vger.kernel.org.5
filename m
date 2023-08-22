Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F994784AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjHVUFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjHVUFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:05:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C0ACE3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:05:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F75E6290A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 20:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74655C433C7;
        Tue, 22 Aug 2023 20:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692734747;
        bh=CD1KmySIxZZR1tfayqqTmXWyATHSKxdxwQsQPpiG098=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Co7fYn/R4HTkNJwo6bVOpUMwcT4d/cBtRjGgqJuMG0jH0rwPlhzWGHz0+BKz/BujJ
         s91p6FAp/BrB/nzhjWyPUwtXkBSuwhRHALZGOlaDyRGetRSh+mISrqD97GJH2Le04K
         qsVbuFdsBBjqRhlwYg5PLalr/SUm32C0/4r4+uDvZt4TiMAWBSNTGQsjKwDtRSqScx
         LAD69Iyc6Iar8B32sfHyo5TRQ149QRGwneEL8oSPLdDrptvH4tg/6E9SIy+WlRypfP
         LxP9aSb2OQ94ViM8kuSeyYILp3QTX22o8rmL69mmXN7M9ZvO+iX8tR3CVY6Gf90Xbi
         PuUqUbKipGWPA==
Date:   Tue, 22 Aug 2023 22:05:42 +0200
From:   Simon Horman <horms@kernel.org>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Suman Ghosh <sumang@marvell.com>, sgoutham@marvell.com,
        gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
        lcherian@marvell.com, jerinj@marvell.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net PATCH V3 1/3] octeontx2-pf: Fix PFC TX scheduler free
Message-ID: <20230822200542.GA3523530@kernel.org>
References: <20230821052516.398572-1-sumang@marvell.com>
 <20230821052516.398572-2-sumang@marvell.com>
 <20230822071101.GI2711035@kernel.org>
 <d3073c7b5d54e1ad4790b16c419e862fee952350.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3073c7b5d54e1ad4790b16c419e862fee952350.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 12:58:04PM +0200, Paolo Abeni wrote:
> On Tue, 2023-08-22 at 09:11 +0200, Simon Horman wrote:
> > On Mon, Aug 21, 2023 at 10:55:14AM +0530, Suman Ghosh wrote:
> > > During PFC TX schedulers free, flag TXSCHQ_FREE_ALL was being set
> > > which caused free up all schedulers other than the PFC schedulers.
> > > This patch fixes that to free only the PFC Tx schedulers.
> > > 
> > > Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
> > > Signed-off-by: Suman Ghosh <sumang@marvell.com>
> > > ---
> > >  .../ethernet/marvell/octeontx2/nic/otx2_common.c  |  1 +
> > >  .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c   | 15 ++++-----------
> > >  2 files changed, 5 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > > index 77c8f650f7ac..289371b8ce4f 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > > @@ -804,6 +804,7 @@ void otx2_txschq_free_one(struct otx2_nic *pfvf, u16 lvl, u16 schq)
> > >  
> > >  	mutex_unlock(&pfvf->mbox.lock);
> > >  }
> > > +EXPORT_SYMBOL(otx2_txschq_free_one);
> > 
> > Hi Suman,
> > 
> > Given that the licence of both this file and otx2_dcbnl.c is GPLv2,
> > I wonder if EXPORT_SYMBOL_GPL would be more appropriate here.
> 
> AFAICS all the symbols exported by otx2_common use plain
> EXPORT_SYMBOL(). I think we can keep that for consistency in a -net
> patch.

Sure, no objection.

> In the long run it would be nice to move all of them to
> EXPORT_SYMBOL_GPL :)
> 
> Cheers,
> 
> Paolo
> 
