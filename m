Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAD875DD1E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 17:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjGVPPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 11:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGVPPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 11:15:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0294C269D;
        Sat, 22 Jul 2023 08:15:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AC0A60B59;
        Sat, 22 Jul 2023 15:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDC2C433C8;
        Sat, 22 Jul 2023 15:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690038930;
        bh=D/ZQiYRXlvjSk0N3A/KXclUm5Du0x5u8jmAWMQMJ5SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N7p7q66fUWG+3i2cmZEfxCix8UIBJ8B/CiAPOSVoACMMvvav21y6TBeePm+s9EV73
         T2ydMqw6zZSCI+MdZyG5n7CXCp1qoQncox3qC+l9op67gKPlCa+8ZITRncZhccFwTE
         SZ6c7heV02kWK2JRXCS4WC3gkiO74R3VJqb+tlso=
Date:   Sat, 22 Jul 2023 17:15:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
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
Subject: Re: [RESEND PATCH v8 06/10] serial: sc16is7xx: fix regression with
 GPIO configuration
Message-ID: <2023072240-supremacy-shallot-a77f@gregkh>
References: <20230721161840.1393996-1-hugo@hugovil.com>
 <20230721161840.1393996-7-hugo@hugovil.com>
 <CAL_JsqJpdhtnZ8FcM7kGWnM+iuDs1fWiCVgf413evbw-o8TZGQ@mail.gmail.com>
 <20230722104724.ef0c5896c239e721794b9fe9@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230722104724.ef0c5896c239e721794b9fe9@hugovil.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 10:47:24AM -0400, Hugo Villeneuve wrote:
> On Fri, 21 Jul 2023 13:24:19 -0600
> Rob Herring <robh+dt@kernel.org> wrote:
> 
> > On Fri, Jul 21, 2023 at 10:19 AM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > >
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > >
> > > Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> > > and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> > > changed the function of the GPIOs pins to act as modem control
> > > lines without any possibility of selecting GPIO function.
> > 
> > Requiring a new DT property is not fixing a kernel regression. You
> > should be returning the kernel to original behavior and then have a
> > new DT property for new behavior.
> 
> Hi Rob,
> please read the entire patch history starting from V1
>  and you will understand why this course of action was
>  not selected.

That's not going to happen, sorry, you need to explain it here, in this
patch series, why a specific action is being taken over another one, as
no one has time to go dig through past history, sorry.

thanks,

greg k-h
