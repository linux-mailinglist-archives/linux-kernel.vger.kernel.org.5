Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6CA75FB42
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjGXPyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGXPyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:54:47 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5608E;
        Mon, 24 Jul 2023 08:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/T4b5niEyR4mZCuDGPl+hY4So/AXh1+NSpM5MAWjNig=; b=gCon4PPrmEX9pjBv2vCF5E6wIx
        G4VxmIoK7qcAD7irGRI09CzsImpbHHCYK3aB8orBat7+pD28XdP5MM6vlBva8Xvhgp2pLYkmerMGU
        66Yt6tpqo/ZK0GPzslXbKxoXHLtlBUxvJzYXAdzZdgMty9wWXDPu6Jmei3CxF3X+t/Mk=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:57608 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qNxtG-0007Li-Ix; Mon, 24 Jul 2023 11:54:31 -0400
Date:   Mon, 24 Jul 2023 11:54:28 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Message-Id: <20230724115428.d191186852c0bd0ee0d78398@hugovil.com>
In-Reply-To: <2023072240-supremacy-shallot-a77f@gregkh>
References: <20230721161840.1393996-1-hugo@hugovil.com>
        <20230721161840.1393996-7-hugo@hugovil.com>
        <CAL_JsqJpdhtnZ8FcM7kGWnM+iuDs1fWiCVgf413evbw-o8TZGQ@mail.gmail.com>
        <20230722104724.ef0c5896c239e721794b9fe9@hugovil.com>
        <2023072240-supremacy-shallot-a77f@gregkh>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [RESEND PATCH v8 06/10] serial: sc16is7xx: fix regression with
 GPIO configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2023 17:15:26 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sat, Jul 22, 2023 at 10:47:24AM -0400, Hugo Villeneuve wrote:
> > On Fri, 21 Jul 2023 13:24:19 -0600
> > Rob Herring <robh+dt@kernel.org> wrote:
> > 
> > > On Fri, Jul 21, 2023 at 10:19 AM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > >
> > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > >
> > > > Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> > > > and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> > > > changed the function of the GPIOs pins to act as modem control
> > > > lines without any possibility of selecting GPIO function.
> > > 
> > > Requiring a new DT property is not fixing a kernel regression. You
> > > should be returning the kernel to original behavior and then have a
> > > new DT property for new behavior.
> > 
> > Hi Rob,
> > please read the entire patch history starting from V1
> >  and you will understand why this course of action was
> >  not selected.
> 
> That's not going to happen, sorry, you need to explain it here, in this
> patch series, why a specific action is being taken over another one, as
> no one has time to go dig through past history, sorry.

Hi Rob,
I initially submitted a patch to revert the kernel to original
behavior, but it created more problems because the patch was
unfortunately split in two separate patches, and mixed with other non
closely-related changes. It was also noted to me that reverting to the
old behavior would break things for some users.

It was suggested to me by a more experienced kernel developer to
"suggest a fix, instead of hurrying a revert":

    https://lkml.org/lkml/2023/5/17/758

That is what we decided to do in the end, and it worked quite well.

Hugo.
