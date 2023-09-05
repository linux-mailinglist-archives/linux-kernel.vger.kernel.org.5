Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A0479252D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjIEQBn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Sep 2023 12:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354769AbjIEONK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:13:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5A671A7;
        Tue,  5 Sep 2023 07:13:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91547143D;
        Tue,  5 Sep 2023 07:13:43 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E63A23F67D;
        Tue,  5 Sep 2023 07:13:03 -0700 (PDT)
Date:   Tue, 5 Sep 2023 15:13:01 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] phy: sun4i-usb: Fix a W=1 compilation failure
Message-ID: <20230905151301.591fa238@donnerap.manchester.arm.com>
In-Reply-To: <e1a5eea0-33a0-4a58-912a-9548d249ea5d@kadam.mountain>
References: <0bc81612171baaa6d5dff58c8e009debc03e1ba8.1693735840.git.christophe.jaillet@wanadoo.fr>
        <20230904005855.658819b3@slackpad.lan>
        <e1a5eea0-33a0-4a58-912a-9548d249ea5d@kadam.mountain>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sep 2023 13:32:08 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

Hi,

> On Mon, Sep 04, 2023 at 12:58:55AM +0100, Andre Przywara wrote:
> > On Sun,  3 Sep 2023 12:11:06 +0200
> > Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> >   
> > > With gcc 12.3.0, when this file is built, we get errors such as:
> > > 
> > > drivers/phy/allwinner/phy-sun4i-usb.c: In function ‘sun4i_usb_phy_probe’:
> > > drivers/phy/allwinner/phy-sun4i-usb.c:790:52: error: ‘_vbus’ directive output may be truncated writing 5 bytes into a region of size between 2 and 12 [-Werror=format-truncation=]
> > >   790 |                 snprintf(name, sizeof(name), "usb%d_vbus", i);
> > >       |                                                    ^~~~~
> > > drivers/phy/allwinner/phy-sun4i-usb.c:790:17: note: ‘snprintf’ output between 10 and 20 bytes into a destination of size 16
> > >   790 |                 snprintf(name, sizeof(name), "usb%d_vbus", i);
> > >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > Because of the possible value of 'i', this can't be an issue in real world  
> > 
> > Would using "u8 i;" help? After all currently there are only 4 PHYs
> > max, and in general this isn't expected to be more than a "handful", so
> > 8 bits should be plenty. An unsigned is better anyway.  
> 
> Generally unsigned types are trickier and cause bugs.  I've blogged
> about this before.  The title is a probably more negative than it should
> have been.
> 
> https://staticthinking.wordpress.com/2022/06/01/unsigned-int-i-is-stupid/
> 
> My blog mentions u8 i.  I would say avoid that unless forced by an API.

Fair enough, the reason I suggested u8 was to allow us using "%u" in the
snprintf, so any static checker would not try to account for a potential
'-' character. Because not doing so would spoil that approach for the
"usb%d_hsic_12M" string further down.

> > It leaves a bit of a bitter taste, though, as we shouldn't do this kind
> > type tweaking, especially not to work around the compiler trying to be
> > clever, but then not seeing the whole picture (that "i" is bounded by
> > compile time constants not exceeding "4").  
> 
> Yeah.  There is always the option of just ignoring the static checker
> when it tells you to write bad code.

Agreed on that, though I find those diagnostics useful, and just ignoring
or masking them might come back and haunt us later.

So I still think we should fix this, one way or the other.

But I feel this goes quite far into bikeshedding territory, so we should
probably just go with name[32].

Cheers,
Andre.

> You don't have to even look at the *whole* picture to know that GCC is
> wrong.  The BIT(i) would overflow if i is more than 31.
> 
> regards,
> dan carpenter
> 

