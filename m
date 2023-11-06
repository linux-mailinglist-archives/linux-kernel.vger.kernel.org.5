Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C638D7E356E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjKGHBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjKGHBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:01:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A10D11A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 23:01:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F91C433C7;
        Tue,  7 Nov 2023 07:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699340480;
        bh=PwZNo4H0+xJc5t0ME1zU4siHPtjo0n0x/hgKoJJp1Wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvO/Z76czVdugwXRRrUFDNfBthP/D12rTYBLpKCN+UGrmf+R9/mGKKmmUbRXr8hSw
         e/REna7XTvcgMxQnjIiAyL/boIYfNbHSVH3EaVydchap1uEDHzUlYdXqML8gSasN2z
         8Fa1rtL5eBYNPnr85IdktQc1KkR1ZXojJhdrKo/c=
Date:   Mon, 6 Nov 2023 14:48:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Stanley Chang <stanley_chang@realtek.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] Revert "usb: phy: add usb phy notify port status API"
Message-ID: <2023110636-illusive-widow-8c95@gregkh>
References: <20231106110654.31090-1-johan+linaro@kernel.org>
 <2023110623-pointing-stump-643d@gregkh>
 <ZUjNLj-sKBogTKcd@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUjNLj-sKBogTKcd@hovoldconsulting.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 12:25:34PM +0100, Johan Hovold wrote:
> On Mon, Nov 06, 2023 at 12:15:59PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Nov 06, 2023 at 12:06:51PM +0100, Johan Hovold wrote:
> > > The recently added Realtek PHY drivers depend on the new port status
> > > notification mechanism which was built on the deprecated USB PHY
> > > implementation and devicetree binding.
> > > 
> > > Specifically, using these PHYs would require describing the very same
> > > PHY using both the generic "phy" property and the deprecated "usb-phy"
> > > property which is clearly wrong.
> > > 
> > > We should not be building new functionality on top of the legacy USB PHY
> > > implementation even if it is currently stuck in some kind of
> > > transitional limbo.
> > > 
> > > Revert the new Realtek PHY drivers for now so that the port status
> > > notification interface can be reverted and replaced before we dig
> > > ourselves into an even deeper hole with this PHY mess.
> > > 
> > > Note that there are no upstream users of these PHYs and the drivers were
> > > only included in 6.6 so there should still be time to undo this.
> > 
> > No users of these phy drivers yet?  Why were they added?
> 
> The devicetree bindings were also merged in 6.6 (and are left in place),
> but there are no devicetrees that actually use these new bindings in
> mainline yet.
> 
> > > Preferably these should go in through Greg's tree for 6.7-rc1.
> > 
> > I'll be glad to take this if I can get an ack for it.
> 
> They went in through your tree, but note that you may now get a conflict
> with 
> 
> 	7e909370a5cd ("phy: realtek: Replace of_device.h with explicit includes")
> 
> in the phy tree.

I fixed it up by hand, should be good now, thanks.

greg k-h
