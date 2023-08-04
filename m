Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E822F76F92B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 06:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjHDEx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 00:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjHDExG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 00:53:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485C52D49;
        Thu,  3 Aug 2023 21:53:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBF2561F23;
        Fri,  4 Aug 2023 04:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0AAC433C7;
        Fri,  4 Aug 2023 04:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691124783;
        bh=H0r420Rv0jy6sbduYNWFrMk8bU+2FH4efv4MEVBrzMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D4cGJjtV8HI447xvYWdb3TtixgaYUV4PkbGZAkQwzpTeDXuW6Jj/iHFtyrvaMEgDg
         PYe7vOi2o78mzoGYJpOAdiiv0m5N94xeuL4QAZJQJEN1X23SDJBT7L3ncQ6bmQaGRf
         ZZ/qzezvQvEnP9vVTShhbv9jCz/WuArL/djMoQcQ=
Date:   Fri, 4 Aug 2023 06:53:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hugo Villeneuve <hugo@hugovil.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Lech Perczak <lech.perczak@camlingroup.com>
Subject: Re: [PATCH v9 06/10] serial: sc16is7xx: fix regression with GPIO
 configuration
Message-ID: <2023080434-outcast-preheated-29b1@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
 <20230725142343.1724130-7-hugo@hugovil.com>
 <2023073105-elevation-canister-2777@gregkh>
 <20230803101814.39a61229d81dcd3e96cbe8ee@hugovil.com>
 <CAHp75VdCqqZfQXRRWUkbDTf_gd3T60Stp+m59Q34iWxddLiG5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdCqqZfQXRRWUkbDTf_gd3T60Stp+m59Q34iWxddLiG5g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 12:04:29AM +0300, Andy Shevchenko wrote:
> On Thu, Aug 3, 2023 at 5:18 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > On Mon, 31 Jul 2023 17:58:41 +0200
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> > > On Tue, Jul 25, 2023 at 10:23:38AM -0400, Hugo Villeneuve wrote:
> 
> ...
> 
> > > > Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> > > > Fixes: 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> > > > Cc: <stable@vger.kernel.org> # 6.1.x: 95982fad dt-bindings: sc16is7xx: Add property to change GPIO function
> > > > Cc: <stable@vger.kernel.org> # 6.1.x: 1584d572 serial: sc16is7xx: refactor GPIO controller registration
> > > > Cc: <stable@vger.kernel.org> # 6.1.x: ac2caa5a serial: sc16is7xx: remove obsolete out_thread label
> > > > Cc: <stable@vger.kernel.org> # 6.1.x: d90961ad serial: sc16is7xx: mark IOCONTROL register as volatile
> > > > Cc: <stable@vger.kernel.org> # 6.1.x: 6dae3bad serial: sc16is7xx: fix broken port 0 uart init
> > >
> > > Where are these git commit ids from?  I don't see them in Linus's tree,
> > > how are they supposed to be picked up by the stable developers if they
> > > are not valid ones?
> > >
> > > confused,
> 
> ...
> 
> > I wrongly assumed that, for example, this patch had, as a prerequisite,
> > all the patches before it in this series, and that is why I listed
> > them.

That's fine, but if you have already marked those patches for stable
inclusion, no need to list them here too.

> The problem, as I understand it, is not that you listed them (how else
> will the backporter know that this patch requires something else?) but
> the format (you used wrong SHA-1 sums).

Exactly, those are invalid sha1 values.

> > So I will remove them all, since this patch doesn't have any other
> > requisites other than the previous patches in this series.
> >
> > Maybe it would be good to add some notes about that in
> > stable-kernel-rules.rst?
> 
> This probably is a good idea. Briefly looking at it I see no examples
> like yours there.

Because it's not a thing?  Just mark all of these patches in the series
as cc: stable@ and all will happen automatically for you.  Nothing
fancy or complex here, happens daily in other subsystems just fine :)

thanks,

greg k-h
