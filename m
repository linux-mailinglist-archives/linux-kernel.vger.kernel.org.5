Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0783E78B383
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjH1Or6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjH1OrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:47:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F9211A;
        Mon, 28 Aug 2023 07:47:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D38F649E5;
        Mon, 28 Aug 2023 14:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF44C433C7;
        Mon, 28 Aug 2023 14:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693234032;
        bh=t4UYsFixGBWU+iQLBjiupWXXolJDGFOG986A39rhGqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fcyb3VRkhGoZGw9T/045gq6wy3bRR/5rGAtlNrFRlm8hbkAWx9gmdoEAx7ASCmlpt
         XkzxG3rFG69tUteuUSj6/sB0X4YJCo1ydUt/pisYfLSzX0TFFGAEbMkcGXVg9HJb1m
         BAeva63G3b5bXBQll6h1h030wIJ9mEv8DAuzYra8=
Date:   Mon, 28 Aug 2023 16:47:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Lucas Tanure <tanure@linux.com>, Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2] Revert "tty: serial: meson: Add a earlycon for the T7
 SoC"
Message-ID: <2023082803-alone-tingle-b639@gregkh>
References: <20230827082944.5100-1-tanure@linux.com>
 <944f1370-c092-484e-a13d-b7f8211c4835@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <944f1370-c092-484e-a13d-b7f8211c4835@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 02:31:06PM +0200, Neil Armstrong wrote:
> Hi Greg,
> 
> On 27/08/2023 10:29, Lucas Tanure wrote:
> > This reverts commit 6a4197f9763325043abf7690a21124a9facbf52e.
> > New SoC will use ttyS0 instead of ttyAML, so T7 SoC doesn't need a OF_EARLYCON_DECLARE.
> > 
> > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > ---
> > Since V1:
> > - add Signed-off-by:
> > 
> >   drivers/tty/serial/meson_uart.c | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> > index c4f61d82fb727..790d910dafa5d 100644
> > --- a/drivers/tty/serial/meson_uart.c
> > +++ b/drivers/tty/serial/meson_uart.c
> > @@ -648,8 +648,6 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
> >   OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
> >   		    meson_serial_early_console_setup);
> > -OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
> > -		    meson_serial_early_console_setup);
> >   #define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
> >   #else
> 
> After some clarifications, it's ok to merge the revert:
> 
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Already merged :)

thanks,

greg k-h
