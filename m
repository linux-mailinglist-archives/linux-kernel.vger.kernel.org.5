Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E7A7E2909
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjKFPt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjKFPtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:49:55 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A367A107;
        Mon,  6 Nov 2023 07:49:51 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 67EE4C0007;
        Mon,  6 Nov 2023 15:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699285790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2fzTFRtE8OUbr2+PUc5Jsl8FOsZhgcgp2/rGQyh/LaY=;
        b=Mb+7QgvYWX/CYi2SnZpUmb520oUd+hxz+xJaJ7govP4NaDscocn8T9sLa3PPdowGzGVeE9
        jHw2T41xtF3qCod4eSrM4sJzrq8YgUQpdW8lYtEDb+8DkfQ4O2BMcuDO69Qtos2P1gGAkl
        ImYQ3hsGtS8UgiexOWyg2LX7cwI9oJ28QBPHvi9nFCjY0s8vT3TNpuDEQgUi5cO0EiI5qx
        fks8P+retlmvPU/zNNZaGyfSiHG0+/ZwnRFr3rjOfdB0bJJX1wAlFQ55iLivjyT+8c9UYb
        b0XcMrPuzjGhK32FwDE8RsogzTjUwcznfhXPGLRsltUjPh3cVBC/yup6+vJDuA==
Date:   Mon, 6 Nov 2023 16:49:48 +0100
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, laurent.pinchart@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com
Subject: Re: [PATCH v7 3/3] media: i2c: Introduce a driver for the Techwell
 TW9900 decoder
Message-ID: <ZUkLHDH2Budi+zgc@pc-70.home>
References: <cover.1697463708.git.mehdi.djait@bootlin.com>
 <c3cd9002b2db69a6fb155722adc8410cd6e1f9ab.1697463708.git.mehdi.djait@bootlin.com>
 <ZUNz_h1fn9RH9Uc5@aptenodytes>
 <ZUj/FQTyajQJrxoU@pc-70.home>
 <ZUkFXl7vBS36y4Qi@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUkFXl7vBS36y4Qi@aptenodytes>
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Mon, Nov 06, 2023 at 04:25:18PM +0100, Paul Kocialkowski wrote:
> > > > +static void tw9900_fill_fmt(const struct tw9900_mode *mode,
> > > > +			    struct v4l2_mbus_framefmt *fmt)
> > > > +{
> > > > +	fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
> > > > +	fmt->width = mode->width;
> > > > +	fmt->height = mode->height;
> > > > +	fmt->field = V4L2_FIELD_NONE;
> > > > +	fmt->quantization = V4L2_QUANTIZATION_DEFAULT;
> > > > +	fmt->colorspace = V4L2_COLORSPACE_SMPTE170M;
> > > > +	fmt->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(V4L2_COLORSPACE_SMPTE170M);
> > > > +	fmt->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(V4L2_COLORSPACE_SMPTE170M);
> > > > +}
> > > > +
> > > > +static int tw9900_cfg_fmt(struct v4l2_subdev *sd,
> > > 
> > > You might have to differentiate between set_fmt/get_fmt to return -EBUSY
> > > if streaming is on in set_fmt. However I understand it will just copy the
> > > current mode in both cases, but this might still be required to follow v4l2
> > > semantics (please double-check).
> > > 
> > 
> > This should be done in the driver calling the pad subdev_call set_fmt,
> > right ?
> 
> Well the two things are distinct, even though it's not obvious to think about
> a case where you wouldn't have a video device to grab the frames.
> 
> For instance you can see this being done here:
> https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/ov5648.c#L2259
> 
> I'm just not sure about what the V4L2 subdev API mandates. It would be useful
> to find some piece of documentation that clarifies the requirement.

Ok, I will split the functions then.

--
Kind Regards
Mehdi Djait
