Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EA97D56DC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343802AbjJXPrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJXPrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:47:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6D4C2;
        Tue, 24 Oct 2023 08:47:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5267FC433C7;
        Tue, 24 Oct 2023 15:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698162439;
        bh=IoRcMqQobOWmVc0E97Y2wJjL+IlvKc3OjGUUBJBdy2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfyqkcXuTiq9JCbtgds/gyTx61nkkPRAH+LYRCaqwbIIXsi+rXAYSPHMjOsSHf+tA
         O74wFQtvu2Pd7Sutu6+aumBA5QZKjF5jY4CqlMaEeHKYP2ZmbTxc+NaKB0dyhkddEc
         8AbaXFhRunA43jgMPC1VbFwV6vjgWhdE4jvStFumGsfz2emXRAzhiIlBpu3zHsbYG+
         309vL/WkHIjSK/7vdjkxRO03Lx6uAH7sUL9/KFBbVhwZMfqLp38FlrNVWqltqT1V0l
         SobbKEOcRejC2X6ewHA5cUmzn3uxhWPdvJVWV3Vm+Z4JxSqJN5s+ddiqRbD6NGBcDW
         BDCZ81BCBiweQ==
Date:   Tue, 24 Oct 2023 16:47:14 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     James Ogletree <James.Ogletree@cirrus.com>,
        James Ogletree <james.ogletree@opensource.cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] mfd: cs40l50: Add support for CS40L50 core driver
Message-ID: <20231024154714.GK8909@google.com>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
 <20231018175726.3879955-4-james.ogletree@opensource.cirrus.com>
 <20231019162359.GF2424087@google.com>
 <E3224624-7FF4-48F6-BA53-08312B69EF9F@cirrus.com>
 <20231023092046.GA8909@google.com>
 <ZTcZIMbrFEhz+rm4@nixie71>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTcZIMbrFEhz+rm4@nixie71>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023, Jeff LaBundy wrote:
> I understand that no customer would ever build the to-be-added codec
> driver _without_ the input driver, but the MFD must be generic enough
> to support this case. Would a codec-only implementation use f0 and ReDC
> estimation? If so, then these functions _do_ belong in the MFD, albeit
> with some comments to explain their nature.

I'm not going to be able to accept a single-function device into the
multi-function devices subsystem.  Please submit both once the codec is
ready.

> > > >> + struct device *dev = cs40l50->dev;
> > > >> + int error;
> > > >> +
> > > >> + mutex_init(&cs40l50->lock);
> > > > 
> > > > Don't you need to destroy this in the error path?
> > > 
> > > My understanding based on past feedback is that mutex_destroy()
> > > is an empty function unless mutex debugging is enabled, and there
> > > is no need cleanup the mutex explicitly. I will change this if you
> > > disagree with that feedback.
> > 
> > It just seems odd to create something and not tear it down.
> 
> mutex_init() is not creating anything; the mutex struct is allocated as
> part of the driver's private data, which is de-allocated as part of device
> managed resources being freed when the module is unloaded.
> 
> mutex_destroy() is a NOP unless CONFIG_DEBUG_MUTEXES is set, and there are
> roughly 4x fewer instances of it than mutex_init() in mainline. I recommend
> not to add mutex_destroy() because it adds unnecessary tear-down paths and
> remove() callbacks that wouldn't otherwise have to exist.

Fair enough.

-- 
Lee Jones [李琼斯]
