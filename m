Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B617BA07F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbjJEOjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbjJEOg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:36:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A542570A;
        Thu,  5 Oct 2023 06:59:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C49C4AF73;
        Thu,  5 Oct 2023 13:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696513089;
        bh=IHjcJEdzOn5XpuR4rXMoCHN3hdl6l6qbxCqy3uQRR68=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hdhzp6tQXl6tvjcq1x6OfQN/c974rRNvEZaKS4R2RpqKqYifvkLl1kGaRhD9rvTWZ
         ga2o1a64DLAey6jhLH1efLIVZcJHzJVYtHSbSBDeeDLl0dXGd/ZS7Ygvj8zyhp2RAW
         x+wXEqby0DQ5y+eMWs3uRzwYGu4Ih4nuE+Y+rcnvbcwXqb1D4Im5BcZJ6epVdP3Bdl
         sc9A9slKc5hXs8qQY85LP0eHqVN/TW0AoYE+g0tYBo9R/THyvGAAJxt/RsuTDTAlg4
         s165+CJNCUAcAv+zB8o7RtfsIo3Oip1XoIuBKen59qYNX95pHYqnyK18ENhmkZ7k6n
         7AvPCNpAyslzQ==
Date:   Thu, 5 Oct 2023 14:38:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/27] staging: iio: resolver: ad2s1210: rework gpios
Message-ID: <20231005143812.42aff573@jic23-huawei>
In-Reply-To: <20230930155536.5a5e982e@jic23-huawei>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-13-fa4364281745@baylibre.com>
        <20230930155536.5a5e982e@jic23-huawei>
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

On Sat, 30 Sep 2023 15:55:36 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 29 Sep 2023 12:23:18 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > From: David Lechner <david@lechnology.com>
> > 
> > From: David Lechner <dlechner@baylibre.com>
> > 
> > - Remove "adi," prefix from gpio names.
> > - Sample gpio is now expected to be active low.
> > - Convert A0 and A1 gpios to "mode-gpios" gpio array.
> > - Convert RES0 and RES1 gpios to "resolution-gpios" gpio array.
> > - Remove extraneous lookup tables.
> > - Remove unused mode field from state struct.
> > - Swap argument order of ad2s1210_set_mode() while we are touching this.
> > 
> > Signed-off-by: David Lechner <dlechner@baylibre.com>  
> Applied,
0-day ran smatch on this and it picked up that a log isn't released in
an error path.  I've fixed that up with a goto error_ret and will push out a
fresh testing branch for 0-day to take another look at.

...

> > @@ -546,7 +537,9 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
> >  	int ret;
> >  
> >  	mutex_lock(&st->lock);
> > -	ad2s1210_set_resolution_pin(st);
> > +	ret = ad2s1210_set_resolution_gpios(st, st->resolution);
> > +	if (ret < 0)
Exiting with lock held.  There is an error_ret label that releases the lock
so use that.

> > +		return ret;
> >  
> >  	/* Use default config register value plus resolution from devicetree. */
> >  	data = FIELD_PREP(AD2S1210_PHASE_LOCK_RANGE_44, 1);
