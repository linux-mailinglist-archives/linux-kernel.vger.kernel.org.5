Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FBE790C48
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 15:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242461AbjICNlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 09:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240689AbjICNlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 09:41:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C1F1BD4
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 06:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B47AB80D21
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 13:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69269C433C8;
        Sun,  3 Sep 2023 13:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693748357;
        bh=vFZrypYTdTZY4tH9j+WcacU5AKW83DdoognQj/JAc8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mQ88GOhFYzwbxP6JdgxJupJpet+TuMAJCTyJXHBmFZHI99ZcNH0goMqXZ7VXAEjP9
         91y8m+3Ib8aDpElZRVaLaPhXzR5IZfkyw8jsK6exHgd50PXG3Uj3jdDEfuWpcI2LV2
         o2OsTeLlKZynolSkaEZJUVK323TDbI+Q5v+co9Ek=
Date:   Sun, 3 Sep 2023 15:04:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation: ABI: sysfs-driver-regulator-output
Message-ID: <2023090330-bling-mammary-3177@gregkh>
References: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
 <20230831121412.2359239-3-Naresh.Solanki@9elements.com>
 <90b1af83-cb03-476f-9147-eb06247bf09c@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90b1af83-cb03-476f-9147-eb06247bf09c@hatter.bewilderbeest.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 02:13:23AM -0700, Zev Weiss wrote:
> Adding Greg re: sysfs ABI design...
> 
> On Thu, Aug 31, 2023 at 05:14:10AM PDT, Naresh Solanki wrote:
> > Adds sysfs-driver-regulator-output
> > 
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > ---
> > .../ABI/testing/sysfs-driver-regulator-output         | 11 +++++++++++
> > 1 file changed, 11 insertions(+)
> > create mode 100644 Documentation/ABI/testing/sysfs-driver-regulator-output
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-driver-regulator-output b/Documentation/ABI/testing/sysfs-driver-regulator-output
> > new file mode 100644
> > index 000000000000..f9b0a8f810fa
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-driver-regulator-output
> > @@ -0,0 +1,11 @@
> > +What:		/sys/bus/platform/drivers/regulator-output/*/events
> > +Date:		August 2023
> > +Description:	Provided regulator events.
> > +
> > +		Read provides various events the regulator associated with the
> > +		driver has encountered. All REGULATOR_EVENT_* are
> > +		defined in include/uapi/linux/regulator.h
> > +
> > +		e.g.
> > +		cat /sys/bus/platform/drivers/regulator-output/ssb_rssd32/events
> > +		0x0
> 
> If we really are going to proceed with a "read with side-effects"
> (clear-on-read) design, that should absolutely be loudly and clearly
> documented, since it's very different from how sysfs files typically work
> and hence a somewhat glaring principle-of-least-surprise violation.  Also,
> since from the code it looks like it's intended to be used via poll(2), that
> should be described here as well.

Poll?  Ick, but that can happen.

But yes, reading a sysfs should almost never cause a side affect at all.

But what do you mean by "clear events?"  sysfs is only "one value per
file", so you are only returning a single event, right?  It can't be a
list of events, sorry, that's not ok, use a different api for that
please (like a char device node.)

thanks,

greg k-h
