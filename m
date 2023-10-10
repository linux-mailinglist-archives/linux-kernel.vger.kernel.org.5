Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2367C0409
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343679AbjJJTCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbjJJTCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:02:52 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5DB93;
        Tue, 10 Oct 2023 12:02:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27C131BF208;
        Tue, 10 Oct 2023 19:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696964568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTkwciBPHpkHQim+hrwizd7vUiFtamHK2mlyN+IwYbc=;
        b=gVfmVRcAbr/0CVhMqNzg/qc+f+gFVBT0enuSrYZHcwfVH+Ae7LueB0d4xTSd4oYLyliKNk
        fHG9G12xn3bDRMwwsAoVfmH/miao4/uQYgWD/PpoLzHDlD4rFyeYj4ibqSjBNZWkMymQS4
        gOzG5sqZG4ZLYY7w3jiKVJCzh7wgm5Iwe0fc9q8Wu/vndVwMOIZAQmjVyJF2xILgXwh+iH
        NTIsVAvamhqEzFj0DMKc7E1ImI5hJofY7APMzK7uMmzKCK1bCNLdbxIuSAX+RueO20ZJeb
        KXm9Y1hfIybJzTN+iwo/O3Ch7RnENb4bpAZl119eSLY+DCJcdaQdh9JRK7yoWQ==
Date:   Tue, 10 Oct 2023 21:02:42 +0200
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com
Subject: Re: [PATCH v6 0/3] media: i2c: Introduce driver for the TW9900 video
 decoder
Message-ID: <ZSWf0iVvBoZGbjAx@Host-002>
References: <cover.1696608809.git.mehdi.djait@bootlin.com>
 <20231009022122.GH5121@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009022122.GH5121@pendragon.ideasonboard.com>
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Mon, Oct 09, 2023 at 05:21:22AM +0300, Laurent Pinchart wrote:
> On Fri, Oct 06, 2023 at 06:25:27PM +0200, Mehdi Djait wrote:
> > Hello everyone,
> > 
> > This series is based on the fifth iteration of the series introducing the
> > tw9900 driver: sent 29 Dec 2020 [1]
> > 
> > This is the version 6 of the series adding support for the Techwell
> > TW9900 multi standard decoder. It's a pretty simple decoder compared to
> > the TW9910, since it doesn't have a built-in scaler/crop engine.
> > 
> > Changes v5 => v6:
> > - dropped .skip_top and .field in the supported_modes
> > - added error handling for the i2c writes/reads
> > - added the colorimetry information to fill_fmt
> > - removed pm_runtime
> 
> It's not very nice to keep the chip powered up all the time :-(
> 

I agree 100% I tried to make it work with pm_runtime but I faced many
issues. I don't know if this is due to my lack of experience but here is
the situation when I enable pm_runtime:

I get most of the time wrong values when calling g_input_status to check
if I have a signal or not. 

To do that I read the 0x01 – Chip Status Register I (STATUS1) and check
the BIT(6): HLOCK:
	- 1 = Horizontal sync PLL is locked to the incoming video source.
	- 0 = Horizontal sync PLL is not locked.

To make the g_input_status work with pm_runtime I had to add a 300
msleep after power ON! Which is a huge delay.

I also face issues with the standard detection...
So I decided to drop it for this first version of the driver.

--
Kind Regards
Mehdi Djait
