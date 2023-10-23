Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48987D3759
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjJWNAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjJWNA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:00:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DA9102
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:00:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524FFC433C8;
        Mon, 23 Oct 2023 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698066023;
        bh=pQvhdbHVvsUbJtKT6sW4IR5pD/yK0HwxeWEyJADxP68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xmhEzgs/DsrluSYaGT8zSh8/2nPhniKLwPAN0EktqnifjgOWrzjDk4Q5zXYEkph/X
         0ejiuiAC4ia7XlypYpcbp/T1oEpInHZrdvNe27cCyzCwpTYH40Exdonbqk5sOhBXi6
         fJb2PMlYh+zdk4ZvYq58gcx3S7Ily1lTIURlkB/w=
Date:   Mon, 23 Oct 2023 15:00:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Balas, Eliza" <Eliza.Balas@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Message-ID: <2023102339-outcast-scone-5a63@gregkh>
References: <20231019125646.14236-1-eliza.balas@analog.com>
 <20231019125646.14236-3-eliza.balas@analog.com>
 <2023101917-cork-numeric-dab8@gregkh>
 <BN7PR03MB4545E7EAB2D72B9098C30C6797DBA@BN7PR03MB4545.namprd03.prod.outlook.com>
 <2023102030-resort-glance-57ef@gregkh>
 <BN7PR03MB4545FF54B96514EC9F41887E97D8A@BN7PR03MB4545.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN7PR03MB4545FF54B96514EC9F41887E97D8A@BN7PR03MB4545.namprd03.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 12:54:15PM +0000, Balas, Eliza wrote:
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Friday, October 20, 2023 17:32
> > To: Balas, Eliza <Eliza.Balas@analog.com>
> > Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>; Derek Kiernan <derek.kiernan@amd.com>; Dragan
> > Cvetic <dragan.cvetic@amd.com>; Arnd Bergmann <arnd@arndb.de>
> > Subject: Re: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
> > 
> > [External]
> > 
> > On Fri, Oct 20, 2023 at 11:18:44AM +0000, Balas, Eliza wrote:
> > > > > +static int adi_axi_tdd_parse_ms(struct adi_axi_tdd_state *st,
> > > > > +				const char *buf,
> > > > > +				u64 *res)
> > > > > +{
> > > > > +	u64 clk_rate = READ_ONCE(st->clk.rate);
> > > > > +	char *orig_str, *modf_str, *int_part, frac_part[7];
> > > > > +	long ival, frac;
> > > > > +	int ret;
> > > > > +
> > > > > +	orig_str = kstrdup(buf, GFP_KERNEL);
> > > > > +	int_part = strsep(&orig_str, ".");
> > > >
> > > > Why are we parsing floating point in the kernel?  Please just keep the
> > > > api simple so that we don't have to try to do any type of parsing other
> > > > than turning a single text number into a value.
> > > >
> > >
> > > The adi_axi_tdd_parse_ms function does almost the same thing as the
> > > iio_str_to_fixpoint() function which already exists in kernel.
> > 
> > That does not mean that this is a valid api for your device as you are
> > not an iio driver (why aren't you an iio driver?)
> > 
> > > It parses a fixed-point number from a string.
> > 
> > And as such, you shouldn't duplicate existing logic.
> > 
> > > The __iio_str_to_fixpoint is used in a similar way, as I intend to use adi_axi_tdd_parse_ms.
> > > It writes to a channel the corresponding scale (micro,nano) for a value.
> > 
> > Why not just have the api accept values in nanoseconds and then no
> > parsing is needed?
> 
> I thought this would be easier for the user, to work with smaller values,
> than using a lot of zeros for nanoseconds. I will make the changes
> to accept values in nanoseconds..

Make the kernel simpler, it's easier to make more complex userspace,
right?

> > > Since the device is not an iio device, using an iio function would be confusing.
> > 
> > Why isn't this an iio device?
> 
> The device is not registered into the IIO device tree, 
> and does not rely on IIO kernel APIs. 
> Even though there are a few attributes that resemble the
> ones from iio, and the sysfs structure is similar,
> this is not an IIO device.
> In the previous patch versions 1 and 2 we concluded
> that this device fits better in the misc subsystem.

Ok, can you point to that in the changelog where the IIO maintainer
agreed that this doesn't fit into that subsystem?

thanks,

greg k-h
