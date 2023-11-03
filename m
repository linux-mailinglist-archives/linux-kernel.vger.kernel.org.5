Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7FD7E0838
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345333AbjKCSdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345177AbjKCSds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:33:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64150D47
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 11:33:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E749C433CA;
        Fri,  3 Nov 2023 18:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699036417;
        bh=GCcviAr0J+IVeM1/p5MQ4ex6AHZgCCmGit6AtH3K05k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FyM320peA+QJM3iwPOVx6aexI+At1jmo+xGow9tXL1dH6z/biHMdoS+afNaGl1mSa
         H559T8yRhyt/BtwSnyLPNC+nzAAPis18jy9AaJTiXUw12ij6GM5PApK80g7lY7mcT/
         rxtzhYNEuT14oqiJl2oi5vH8irjBNVvM2kjqmum0=
Date:   Fri, 3 Nov 2023 19:33:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>, davem@davemloft.net,
        netdev@vger.kernel.org, florian.fainelli@broadcom.com,
        linux-kernel@vger.kernel.org, edumazet@google.com,
        bcm-kernel-feedback-list@broadcom.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Prevent out-of-bounds read/write in bcmasp_netfilt_rd
 and bcmasp_netfilt_wr
Message-ID: <2023110318-utensil-figure-eb80@gregkh>
References: <DB3PR10MB6835E073F668AD24F57AE64AE8A5A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <2023110301-purist-reputable-fab7@gregkh>
 <e3ac58b2-bb78-4364-94c0-f18c376ac132@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3ac58b2-bb78-4364-94c0-f18c376ac132@broadcom.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 11:23:16AM -0700, Justin Chen wrote:
> 
> 
> On 11/3/23 5:57 AM, Greg KH wrote:
> > On Fri, Nov 03, 2023 at 05:57:48PM +0530, Yuran Pereira wrote:
> > > The functions `bcmasp_netfilt_rd` and `bcmasp_netfilt_wr` both call
> > > `bcmasp_netfilt_get_reg_offset` which, when it fails, returns `-EINVAL`.
> > > This could lead to an out-of-bounds read or write when `rx_filter_core_rl`
> > > or `rx_filter_core_wl` is called.
> > > 
> > > This patch adds a check in both functions to return immediately if
> > > `bcmasp_netfilt_get_reg_offset` fails. This prevents potential out-of-bounds read
> > > or writes, and ensures that no undefined or buggy behavior would originate from
> > > the failure of `bcmasp_netfilt_get_reg_offset`.
> > > 
> > > Addresses-Coverity-IDs: 1544536 ("Out-of-bounds access")
> > > Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> > > ---
> > >   drivers/net/ethernet/broadcom/asp2/bcmasp.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> > > index 29b04a274d07..8b90b761bdec 100644
> > > --- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> > > +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> > > @@ -227,6 +227,8 @@ static void bcmasp_netfilt_wr(struct bcmasp_priv *priv,
> > >   	reg_offset = bcmasp_netfilt_get_reg_offset(priv, nfilt, reg_type,
> > >   						   offset);
> > > +	if (reg_offset < 0)
> > > +		return;
> > >   	rx_filter_core_wl(priv, val, reg_offset);
> > >   }
> > > @@ -244,6 +246,8 @@ static u32 bcmasp_netfilt_rd(struct bcmasp_priv *priv,
> > >   	reg_offset = bcmasp_netfilt_get_reg_offset(priv, nfilt, reg_type,
> > >   						   offset);
> > > +	if (reg_offset < 0)
> > > +		return 0;
> > 
> > Shouldn't you return an error here?
> > 
> > thanks
> > 
> > greg k-h
> 
> As long as offset is less than MAX_WAKE_FILTER_SIZE we don't need to worry
> about error checking. This is already checked before we call
> netfilt_get_reg_offset() in both cases. Instead of returning -EINVAL in
> neffilt_get_reg_offset() lets return 0. This will silence the coverity
> check. In practice we will never hit this logic.

Then don't change it, coverity is incorrect here.

greg k-h
