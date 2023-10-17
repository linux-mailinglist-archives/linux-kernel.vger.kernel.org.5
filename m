Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0097CCC38
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344114AbjJQT1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjJQT1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:27:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AC6F0;
        Tue, 17 Oct 2023 12:27:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FD7C433C9;
        Tue, 17 Oct 2023 19:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697570832;
        bh=4FngpJTICQXkllJWNzVSnfiaHhpz1oCUaStsqDRzIi0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ujGvTkWhBLV1cd0RkE4gKTcfm274HI9jRL9ey8Ab6OZ2J8UC1rd31KXDsV5gvo+1Z
         vS8C+xZv9TtP0Caqj0MXjxYccgdSdBdEt1BTxCgwt7rRbLkaVJ8wbTZtTTdTS7/Gt4
         qezCV6fFQUO24259O93LM2KD1l6Ri+JSuA/K3+P9gMjl+OPqzatv21zeLN+g/qolFf
         hvLw0l8Nt9Pc5Y9VC1s6a6n/weKs9HXOsmdWpY85PfPyCGrTyDP6llBMyx1RZDaDaU
         E8X7bGkauk30/CYn1DwgOT1ocZ2KBKHjygDvtbq1GyfmxPmhrxlOZcAb5o6wC6Wkg7
         cjyiiL5QovqjQ==
Date:   Tue, 17 Oct 2023 20:27:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: afe: rescale: Accept only offset channels
Message-ID: <20231017202729.30f2927f@jic23-huawei>
In-Reply-To: <2a15c359-2a04-9a45-f30a-c7a0e4b67871@axentia.se>
References: <20230902-iio-rescale-only-offset-v2-1-988b807754c8@linaro.org>
        <a0a55276-297b-e2b7-79b3-e4aadd39b400@axentia.se>
        <CACRpkdaMj2XFcwqaSiRSA2A41zYsW=AG_Fi7v7AjbuLBByxVaQ@mail.gmail.com>
        <948548a0-d132-4f5c-819e-40bacb367be4@axentia.se>
        <20231017100539.000039b0@Huawei.com>
        <2a15c359-2a04-9a45-f30a-c7a0e4b67871@axentia.se>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 16:00:22 +0200
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> 2023-10-17 at 11:05, Jonathan Cameron wrote:
> > On Mon, 16 Oct 2023 12:05:32 +0200
> > Peter Rosin <peda@axentia.se> wrote:  
> >> 2023-10-16 at 10:39, Linus Walleij wrote:  
> 
> 
> 
> >>> Just raw (with neither offset or rescale) doesn't make sense, since    
> >>
> >> And I don't see why not. That's the crux.
> >>  
> >>> the AFE rescaler does just offsetting and rescaling, in that case the
> >>> user should just use the raw channel. Also it would then take
> >>> precedence over a processed channel (which applies rescale and
> >>> offset internally) which doesn't make sense to me.    
> >>
> >> Why isn't it perfectly fine for a device to provide only a raw
> >> channel and then expect that to be interpreted as the real unit?
> >> Why would it need a processed channel when no processing is
> >> going on? E.g. a device reporting the temp in the expected unit
> >> in one of its registers. Or whatever with such a friendly
> >> register.  
> > 
> > In that case it should report a processed value to indicate that.
> > It's admittedly a bit of a corner case given it's not processed by
> > the kernel - there is an argument that this (more or less) only
> > happens when someone has processed a raw ADC count but in theory
> > that's not necessarily true.
> > 
> > There are a few examples of drivers passing through the register value
> > as processed in tree - normally when there
> > is a microprocessor doing some fusion of signals or similar.
> > 
> > Raw gets reported on it's own in a few other cases, such as when
> > there are no known units - that happens for things like light intensity,
> > proximity (which is often reflected light intensity).
> > For those I'm not sure the rescaler is useful.  
> 
> Excellent, thanks for the clarification!
> 
> Reviewed-by: Peter Rosin <peda@axentia.se>
Thanks,

Applied to the fixes-togreg branch of iio.git.  I'll just let this
sit in linux-next for a day or so before a pull request (I have
a few other fixes queued).  That will almost certainly get queued for
the merge window given timing.

Thanks,

Jonathan


> 
> Cheers,
> Peter

