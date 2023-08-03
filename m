Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DAF76EC35
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbjHCOS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbjHCOSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:18:24 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E601981;
        Thu,  3 Aug 2023 07:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=e0cd+bfuuJW5D9Vjs7Kwr/ftMzeFILJUbMoh0kdOipw=; b=EXQn0KHSOEFemcJr9tzvUCuA6X
        IUdoxJh0x4owZByHKyfE7VOq0bHIkOUQkgxJ1TNN82jm0UB2uXoWdsHBXmx4vmcIytm2Oa8HLbEuS
        EsVVmHiTkrugW3Bz1LgtWx1HpmRj68prsQk9wMjAIylpRMnLuX8hqpbjhdI0g2qj5Se0=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:43022 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qRZ9b-0000Wk-Jc; Thu, 03 Aug 2023 10:18:16 -0400
Date:   Thu, 3 Aug 2023 10:18:14 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Message-Id: <20230803101814.39a61229d81dcd3e96cbe8ee@hugovil.com>
In-Reply-To: <2023073105-elevation-canister-2777@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
        <20230725142343.1724130-7-hugo@hugovil.com>
        <2023073105-elevation-canister-2777@gregkh>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v9 06/10] serial: sc16is7xx: fix regression with GPIO
 configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 17:58:41 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Jul 25, 2023 at 10:23:38AM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> > and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> > changed the function of the GPIOs pins to act as modem control
> > lines without any possibility of selecting GPIO function.
> > 
> > As a consequence, applications that depends on GPIO lines configured
> > by default as GPIO pins no longer work as expected.
> > 
> > Also, the change to select modem control lines function was done only
> > for channel A of dual UART variants (752/762). This was not documented
> > in the log message.
> > 
> > Allow to specify GPIO or modem control line function in the device
> > tree, and for each of the ports (A or B).
> > 
> > Do so by using the new device-tree property named
> > "nxp,modem-control-line-ports" (property added in separate patch).
> > 
> > When registering GPIO chip controller, mask-out GPIO pins declared as
> > modem control lines according to this new DT property.
> > 
> > Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> > Fixes: 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> > Cc: <stable@vger.kernel.org> # 6.1.x: 95982fad dt-bindings: sc16is7xx: Add property to change GPIO function
> > Cc: <stable@vger.kernel.org> # 6.1.x: 1584d572 serial: sc16is7xx: refactor GPIO controller registration
> > Cc: <stable@vger.kernel.org> # 6.1.x: ac2caa5a serial: sc16is7xx: remove obsolete out_thread label
> > Cc: <stable@vger.kernel.org> # 6.1.x: d90961ad serial: sc16is7xx: mark IOCONTROL register as volatile
> > Cc: <stable@vger.kernel.org> # 6.1.x: 6dae3bad serial: sc16is7xx: fix broken port 0 uart init
> 
> Where are these git commit ids from?  I don't see them in Linus's tree,
> how are they supposed to be picked up by the stable developers if they
> are not valid ones?
> 
> confused,
> 
> greg k-h

Hi Greg,
once again, I simply misinterpreted stable-kernel-rules.rst.

I wrongly assumed that, for example, this patch had, as a prerequisite,
all the patches before it in this series, and that is why I listed
them.

So I will remove them all, since this patch doesn't have any other
requisites other than the previous patches in this series.

Maybe it would be good to add some notes about that in
stable-kernel-rules.rst?

Thank you, Hugo.
