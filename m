Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553F37F8DD6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 20:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjKYTPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 14:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYTPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 14:15:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49459C2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 11:15:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF474C433C8;
        Sat, 25 Nov 2023 19:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700939737;
        bh=5U6ilYOb9JOBKF6J2hmo2yKz7KIJBaspaNBWIMEXAHk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YTzcUKjFn88nrPC276FOv9e7ls8eMT58+rj30j/T4s2A7y3BkJMBbmH7QOYsaopqG
         LY6qRwSxN5IgfrjsRcrHhFwV6XZt51lQWyev1EXhJUU5t4zIJ/Pti9u3uCujYw1rhG
         TIRznnqXUt49PChQSzcOKOdbQN1x3kI7b4oBukIdo6d3+HwEVSCf7bCN+PpJc+wUJG
         JDxpIlCLZM5KbsdJnaCXMS3wFVVxrCj2EU1GHNKd9V/9RnRUUJtGOpe3yUvWuVl6Pu
         EvDhAVVIBcrRnnknE9+T+3JCPvTMVnpVzCGYZHkgG2Eqz91LFEgQmrtmC7zRKNQuAt
         F22rScENy/EdA==
Date:   Sat, 25 Nov 2023 19:15:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petre Rodan <petre.rodan@subdimension.ro>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] iio: pressure: driver for Honeywell HSC/SSC series
 pressure sensors
Message-ID: <20231125191529.2ed1ddfb@jic23-huawei>
In-Reply-To: <ZV3b5sUrGEj5ZOF0@smile.fi.intel.com>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
        <20231117164232.8474-2-petre.rodan@subdimension.ro>
        <ZVtSm5f-Qyp8LFFp@smile.fi.intel.com>
        <ZV2a213oidterHYZ@sunspire>
        <ZV3b5sUrGEj5ZOF0@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > > > +	ret = devm_regulator_get_enable_optional(dev, "vdd");
> > > > +	if (ret == -EPROBE_DEFER)
> > > > +		return -EPROBE_DEFER;  
> > > 
> > > Oh, boy, this should check for ENODEV or so, yeah, regulator APIs a bit
> > > interesting.  
> > 
> > since I'm unable to test this I'd rather remove the block altogether.
> > if I go the ENODEV route my module will never load since I can't see any
> > vdd-supply support on my devboard.  
> 
> No, what I meant is to have something like
> 
> 	if (ret) {
> 		if (ret != -ENODEV)
> 			return ret;
> 		...regulator is not present...
> 	}
> 
> This is how it's being used in dozens of places in the kernel. Just utilize
> `git grep ...` which should be a top-10 tool for the Linux kernel developer.

As per my very late reply to previous email. Nope. This regulator is never
not present. It's just a question of whether the firmware tells us what
it is, or it is supplied with a stub regulator.

