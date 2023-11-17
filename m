Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788E17EF806
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjKQTsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjKQTsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:48:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A751D5C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:48:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5718C433C8;
        Fri, 17 Nov 2023 19:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700250515;
        bh=X7JZz+ON7qSHlA37jt4TpJnFpH56zWbengdGSXs0b9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZY+8uqWgJilAslNYbhHRu3b8/mWuvqc21zHQ1flxkaFfL2/4HqnaRvX8m/Bonwhgz
         PoJkrKPLwpS3MQ8InlyKUNZ/IxISURrNYJTLuUEeaf7/Vxza3vSl/LKcD4kY9cdZTb
         KhVohOBGaaijinUxkd8GOHHrSn2FrVB/uLTyRJb4=
Date:   Fri, 17 Nov 2023 14:48:32 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Kory Maincent <kory.maincent@bootlin.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH] firmware_loader: Expand Firmware upload error codes with
 firmware invalid error
Message-ID: <2023111727-exert-dab-b940@gregkh>
References: <20231117-feature_firmware_error_code-v1-1-92c973a50847@bootlin.com>
 <2023111720-slicer-exes-7d9f@gregkh>
 <548c3b60-60ce-4166-9943-224e03152cc5@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <548c3b60-60ce-4166-9943-224e03152cc5@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 03:06:44PM +0100, Andrew Lunn wrote:
> On Fri, Nov 17, 2023 at 08:45:59AM -0500, Greg Kroah-Hartman wrote:
> > On Fri, Nov 17, 2023 at 11:27:53AM +0100, Kory Maincent wrote:
> > > No error code are available to signal an invalid firmware content.
> > > Drivers that can check the firmware content validity can not return this
> > > specific failure to the user-space
> > > 
> > > Expand the firmware error code with an additional code:
> > > - "firmware invalid" code which can be used when the provided firmware
> > >   is invalid
> > > 
> > > Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > ---
> > > 
> > > This patch was initially submitted as part of a net patch series.
> > > Conor expressed interest in using it in a different subsystem.
> > > Consequently, I extracted it from the series and submitted it separately
> > > to the main tree, driver-core.
> > > https://lore.kernel.org/netdev/20231116-feature_poe-v1-7-be48044bf249@bootlin.com/
> > 
> > So you want me to take it through my tree?  Sure, but if you are relying
> > on this for any other code, it will be a while before it gets into
> > Linus's tree, not until 6.8-rc1, is that ok?
> 
> My idea was that you could create a stable branch, which can then be
> pulled into netdev and arm-soc.

I'll be glad to do so, you just need to ask me to do that, I don't see
that request here :)

> If you don't want to do that, we can ask Arnd to take it, and he can
> create a stable branch which we pull into netdev.

You want a stable tag to pull from, right?

But really, why not just take this through netdev?  It's just one
commit, I have no problem with it going that way at all.  If the odd
chance there's a merge conflict in the future, I can handle it.

thanks,

greg k-h
