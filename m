Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B4977119A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjHESsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjHESsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:48:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1462D4C;
        Sat,  5 Aug 2023 11:48:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE05060E86;
        Sat,  5 Aug 2023 18:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353C7C433C7;
        Sat,  5 Aug 2023 18:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691261301;
        bh=X0vVWlTMnFs9XoqLM3QFPQkWJUBbJY9JzDMLLwSgTcg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sB0yfncSyayzLSfI8NEi3zkIRoaUekXPIQ5PwneUk/5xqyReZim9H7O3SbxGBRZiv
         7yDPeQUJJpAeRB3jrlSD+T/BpapbZ/HQsCwqSLX/d2EfKeiFvwxrKdrXJpHz2t7zEd
         aUQfqpWReFdJ5HZm6v14nBEe5D8Qr/2ikzCv9d7iRYJi0hfF+KgT+4jFCkAxXuor9N
         Bgna1OFGnhLsBB7Od1dovhACIyBvZpheETFcp2+cbHyXxgb39oP4XTSs9NznObO5ED
         du8pkldMzAP+S0Z2SFB3HGDt3uruUAN7vN8ChekELq1nqNXJyz1FNsYmYax+bd088M
         jfkYp3orwkr+Q==
Date:   Sat, 5 Aug 2023 19:48:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Support ROHM BU27010 RGBC sensor
Message-ID: <20230805194815.09e1dfb4@jic23-huawei>
In-Reply-To: <cover.1690958450.git.mazziesaccount@gmail.com>
References: <cover.1690958450.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 10:35:55 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Support ROHM BU27010 RGBC + flickering sensor.
> 
> Following description copied from commit log:
> 
> > The ROHM BU27010 is an RGBC sensor with a flickering detection FIFO. The
> > RGBC+IR sensor functionality is largely similar to what the BU27008 has.
> > There are some notable things though:
> >  - gain setting is once again new and exotic. Now, there is 6bit gain
> >    setting where 4 of the bits are common to all channels and 2 bits
> >    can be configured separately for each channel. The BU27010 has
> >    similar "1X on other channels vs 2X on IR when selector is 0x0"
> >    gain design as BU27008 had. So, we use same gain setting policy for
> >    BU27010 as we did for BU27008 - driver sets same gain selector for
> >    all channels but shows the gains separately for all channels so users
> >    can (at least in theory) detect this 1X vs 2X madness...
> >  - BU27010 has suffled all the control register bitfields to new
> >    addresses and bit positions while still keeping the register naming
> >    same.
> >  - Some more power/reset control is added.
> >  - FIFO for "flickering detection" is added.
> >
> > The control register suffling made this slightly nasty. Still, it is
> > easier for maintenance perspective to add the BU27010 support in BU27008
> > driver because - even though the bit positions/addresses were changed -
> > most of the driver structure can be re-used. Writing own driver for
> > BU27010 would mean plenty of duplicate code albeit a tad more clarity.  
> 
> Revision history:
> 
> v2 => v3:
>  - minor styling and added comment
>  - rebased on iio-fixes-for-6.5a which contains prerequisite patches
> v1 => v2:
>  - make vdd-supply required binding.
>  - Some re-ordering for struct member init.
>  - Some re-ordering for code to get rid of function declarations.
>  - Tidy up the mess from patch 2/3.
>    - Refactor parts from 3/3 to 2/3.
>    - Clean-up commented out code and tidy things in general.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to poke at it and see if we missed anything in review.

Thanks,

Jonathan

> 
> 
> ---
> 
> Matti Vaittinen (3):
>   dt-bindings: iio: ROHM BU27010 RGBC + flickering sensor
>   iio: light: bu27008: add chip info
>   iio: light: bd27008: Support BD27010 RGB
> 
>  .../bindings/iio/light/rohm,bu27010.yaml      |  49 ++
>  drivers/iio/light/rohm-bu27008.c              | 630 ++++++++++++++----
>  2 files changed, 565 insertions(+), 114 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
> 
> 
> base-commit: 8a4629055ef55177b5b63dab1ecce676bd8cccdd

