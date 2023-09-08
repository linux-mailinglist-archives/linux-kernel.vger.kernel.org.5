Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440B1798E98
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245374AbjIHTCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbjIHTCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:02:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D06AE6F;
        Fri,  8 Sep 2023 12:02:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B6FC43397;
        Fri,  8 Sep 2023 18:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197983;
        bh=ta2natytOGl/MNNvGTNRj7ruD1g8JHgVcPbG7D7SZMw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O1dTQE17H0hK37bWLBp7Nvs8vJBL/lUrWhPq9kWqDh0dmeYZp99J0v83jG5J/nUMi
         GMPkRWsWGU1EW/DHVQJxSBFNPDgYv8vbMHzIJokbzC9g7Vlr37hLVIXborNw3zjJ5z
         OdkTuvKbHQDN+VkVQ+e7KUCv4mTchllOo0t/Y60Bvt3Z0Xu7tlvYz6Gf2svav8ITOc
         Xg1/GwhPEP+e3qiniE0G28whffAJ0Ts4/WYaO7mMfqNxUwas9nOpJ+VZOF9sixdeh7
         tYIwQJKlsMFvK6SnFfRSTLj+QuBOykHcZTw/PUVEO1goSSTlOLWpJ1yXqV5KgQ5tz1
         aIjXhdtRkd45Q==
Date:   Fri, 8 Sep 2023 19:33:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: pressure: Support ROHM BU1390
Message-ID: <20230908193329.0ddd39e2@jic23-huawei>
In-Reply-To: <4d8e2873-49bc-8314-ee16-dd327a92898d@gmail.com>
References: <cover.1694001462.git.mazziesaccount@gmail.com>
        <08f7085ba1af2fae21c942f6c20a94c237df53ba.1694001462.git.mazziesaccount@gmail.com>
        <ZPifWlRvX5hLFPvG@smile.fi.intel.com>
        <4d8e2873-49bc-8314-ee16-dd327a92898d@gmail.com>
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

On Thu, 7 Sep 2023 08:57:17 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Morning Andy,
> 
> Thanks for the review.
> 
> On 9/6/23 18:48, Andy Shevchenko wrote:
> > On Wed, Sep 06, 2023 at 03:37:48PM +0300, Matti Vaittinen wrote:  
> >> Support for the ROHM BM1390 pressure sensor. The BM1390GLV-Z can measure
> >> pressures ranging from 300 hPa to 1300 hPa with configurable measurement
> >> averaging and internal FIFO. The sensor does also provide temperature
> >> measurements.
> >>
> >> Sensor does also contain IIR filter implemented in HW. The data-sheet
> >> says the IIR filter can be configured to be "weak", "middle" or
> >> "strong". Some RMS noise figures are provided in data sheet but no
> >> accurate maths for the filter configurations is provided. Hence, the IIR
> >> filter configuration is not supported by this driver and the filter is
> >> configured to the "middle" setting (at least not for now).
> >>
> >> The FIFO measurement mode is only measuring the pressure and not the
> >> temperature. The driver measures temperature when FIFO is flushed and
> >> simply uses the same measured temperature value to all reported
> >> temperatures. This should not be a problem when temperature is not
> >> changing very rapidly (several degrees C / second) but allows users to
> >> get the temperature measurements from sensor without any additional logic.  
> > 
> > ...
> > 
> >   
> >> +struct bm1390_data {
> >> +	int64_t timestamp, old_timestamp;  
> > 
> > Out of a sudden int64_t instead of u64?  
> 
> Judging the iio_push_to_buffers_with_timestamp() and iio_get_time_ns(), 
> IIO operates with signed timestamps. One being s64, the other int64_t.

That's odd. Ah well.  Should both be s64 as internal to the kernel only.


> 
> >> +	struct iio_trigger *trig;
> >> +	struct regmap *regmap;
> >> +	struct device *dev;
> >> +	struct bm1390_data_buf buf;
> >> +	int irq;
> >> +	unsigned int state;
> >> +	bool trigger_enabled;  
> >   
> >> +	u8 watermark;  
> > 
> > Or u8 instead of uint8_t?  
> 
> So, uint8_t is preferred? I don't really care all that much which of 
> these to use - which may even show up as a lack of consistency... I 
> think I did use uint8_t when I learned about it - but at some point 
> someone somewhere asked me to use u8 instead.. This somewhere might have 
> been u-boot though...
> 
> So, are you Suggesting I should replace u8 with uint8_t? Can do if it 
> matters.
u8 preferred for internal to kernel stuff, uint8_t if a userspace header.
