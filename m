Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55C07898E2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 22:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjHZUAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 16:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjHZT7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 15:59:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB95D8;
        Sat, 26 Aug 2023 12:59:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7B7A61F2F;
        Sat, 26 Aug 2023 19:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84168C433C8;
        Sat, 26 Aug 2023 19:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693079988;
        bh=wk7TTw46I9VQ1vaqjL5oYSR1MWRvL3QqszPe1Ac3vEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUceMAv4p78ZNILkEQmopDvcIZ44XkSx8YyqCQzeVhrnFNDWN3wcMc8ZoERhQFETn
         c8e7ID/zkoi0nwVWXynboBvJsIvtCSXs4S3OcfJ2lr5Ac4GDBo5U/Nx3T1SLQfKXvo
         VPZa3kfJE565DVd7Jkrtr2glSNkantuwuRdZjw1A=
Date:   Sat, 26 Aug 2023 21:59:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lucas Tanure <tanure@linux.com>
Cc:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>,
        Nick <nick@khadas.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v9 2/2] tty: serial: meson: Add a earlycon for the T7 SoC
Message-ID: <2023082636-embolism-submitter-5e8c@gregkh>
References: <20230814080128.143613-1-tanure@linux.com>
 <20230814080128.143613-2-tanure@linux.com>
 <20230823082940.t4xjgfzwpt2hsfst@CAB-WSD-L081021>
 <29cfd5ef-16ae-4960-a95e-13b58c090604@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29cfd5ef-16ae-4960-a95e-13b58c090604@linux.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 07:07:18PM +0100, Lucas Tanure wrote:
> On 23-08-2023 09:29, Dmitry Rokosov wrote:
> > Hello Lucas,
> > 
> > Thank you for the patch! Please find my small comment below.
> > 
> > On Mon, Aug 14, 2023 at 09:01:28AM +0100, Lucas Tanure wrote:
> > > The new Amlogic T7 SoC does not have a always-on uart,
> > > so add OF_EARLYCON_DECLARE for it.
> > > 
> > > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > > Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > > Since v8:
> > >   - Fix issues with git send-mail command line
> > > Since v7:
> > >   - Send to the correct maintainers
> > > 
> > >   drivers/tty/serial/meson_uart.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> > > index 790d910dafa5..c4f61d82fb72 100644
> > > --- a/drivers/tty/serial/meson_uart.c
> > > +++ b/drivers/tty/serial/meson_uart.c
> > > @@ -648,6 +648,8 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
> > >   OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
> > >   		    meson_serial_early_console_setup);
> > > +OF_EARLYCON_DECLARE(meson, "amlogic,t7-uart",
> > > +		    meson_serial_early_console_setup);
> > >   #define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
> > >   #else
> > 
> > I suppose you need to add a separate meson_t7_uart_data to switch the T7
> > UART to a regular TTY devname 'ttyS'. For the new Amlogic SoCs, we have
> > agreed to use 'ttyS' instead of 'ttyAML'. Please refer to the already
> > applied patch series at [1] and the IRC discussion at [2].
> > 
> > Links:
> >      [1] https://lore.kernel.org/all/20230705181833.16137-1-ddrokosov@sberdevices.ru/
> >      [2] https://libera.irclog.whitequark.org/linux-amlogic/2023-07-03
> > 
> I asked Greg to drop this patch as is not need anymore.
> T7 will use S4 TTY/UART code.

I can't drop it, I need a revert :(
