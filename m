Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73207FA8F6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjK0S1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjK0S1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:27:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09FD19B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:27:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16382C433C7;
        Mon, 27 Nov 2023 18:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701109675;
        bh=49rdIgAyXCrdCaCD66GasnyhWQCc7vPRFDpNQSTb9Nk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vCdTwkhlvgSOmd+H3z4lNLeXIkSF0lTMPk07qaXTAEjwPe3SlCCGn/OiGIeGJQMWk
         5yxIc0LltRbiGyFrA5qOPefOO1f0gAqOQa5F5FMqdz5XXAl+5mxQ+snf1usnI/v9x5
         id34aeLaaZkVlrGWTRVaija/IcYOuKh9AT4kvB2w=
Date:   Mon, 27 Nov 2023 18:27:53 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <2023112707-feline-unselect-692f@gregkh>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-3-saeed@kernel.org>
 <2023112702-postal-rumbling-003f@gregkh>
 <20231127144017.GK436702@nvidia.com>
 <2023112752-pastel-unholy-c63d@gregkh>
 <20231127161732.GL436702@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127161732.GL436702@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 12:17:32PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 27, 2023 at 03:51:10PM +0000, Greg Kroah-Hartman wrote:
> 
> > Ok, best of luck with this mess, I'll stop harping on it now and just
> > point out all of the other issues here.  First off, you all need to get
> > the network maintainers to agree that this driver is ok to do this way,
> > and I don't think that has happened yet, so I'll wait on reviewing the
> > series until that is resolved.
> 
> As I said already, I strongly disagree with the idea that the netdev
> maintainers get a global veto on what happens with mlx5 devices just
> because they sometimes have an ethernet port on the back of the card.

I understand you might disagree, however I hold their opinion in high
regard and want to ensure that they agree that exposing device-specific
debugging information for a device that deals with networking is ok to
do so in a device-specific misc device node and not through some other
way that other networking devices normally do (i.e. netlink or
some-other-such-thing.)

Note, device-specific character devices have almost always proven to be
a bad idea in the long run, I understand your immediate need to do
something like this, but remember that keeping it alive for the next 20+
years is going to be tough.

> This module is primarily (but not exclusively) for rdma related
> functionality, not netdev, and the RDMA maintainers Ack it.

In my mind, RDMA implies networking, as it's over a network connection,
but hey, I might be wrong :)

thanks,

greg k-h
