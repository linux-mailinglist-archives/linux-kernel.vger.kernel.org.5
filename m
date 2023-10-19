Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687017D0109
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345562AbjJSR5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjJSR5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:57:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2D4E8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:57:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BB8C433C8;
        Thu, 19 Oct 2023 17:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697738226;
        bh=8mcVIkh+ilUfV+/qwx1svrvpt+dMNpngwLshc/nC9SU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xdjCSwh/wyoz/GXl8HyjGJpFGWmGj53WFlchZPoHrYGth53m8d94v0VxMg0WsttU/
         Z53FtVFfS2lEt4o3Q4kYcrCN2ahp2l81zsfORezV+5CzQougLcoJB8QGIHYwqb8anw
         cAWviGhTinR7jKDUQ9QMXDPqgUa2o3ibZ+MDQDGk=
Date:   Thu, 19 Oct 2023 19:57:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eliza Balas <eliza.balas@analog.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Message-ID: <2023101917-cork-numeric-dab8@gregkh>
References: <20231019125646.14236-1-eliza.balas@analog.com>
 <20231019125646.14236-3-eliza.balas@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019125646.14236-3-eliza.balas@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 03:56:46PM +0300, Eliza Balas wrote:
> +config ADI_AXI_TDD
> +	tristate "Analog Devices TDD Engine support"
> +	depends on HAS_IOMEM
> +	select REGMAP_MMIO
> +	help
> +	  The ADI AXI TDD core is the reworked and generic TDD engine which
> +	  was developed for general use in Analog Devices HDL projects. Unlike
> +	  the previous TDD engine, this core can only be used standalone mode,
> +	  and is not embedded into other devices.

What does "previous" mean here?  That's not relevant for a kernel help
text, is it?

Also, what is the module name?  Why would someone enable this?  What
userspace tools use it?


> +
>  config DUMMY_IRQ
>  	tristate "Dummy IRQ handler"
>  	help

Why put your entry in this specific location in the file?

> +static int adi_axi_tdd_parse_ms(struct adi_axi_tdd_state *st,
> +				const char *buf,
> +				u64 *res)
> +{
> +	u64 clk_rate = READ_ONCE(st->clk.rate);
> +	char *orig_str, *modf_str, *int_part, frac_part[7];
> +	long ival, frac;
> +	int ret;
> +
> +	orig_str = kstrdup(buf, GFP_KERNEL);
> +	int_part = strsep(&orig_str, ".");

Why are we parsing floating point in the kernel?  Please just keep the
api simple so that we don't have to try to do any type of parsing other
than turning a single text number into a value.

> +	ret = kstrtol(int_part, 10, &ival);
> +	if (ret || ival < 0)
> +		return -EINVAL;

You leaked memory :(

Use the new logic in completion.h to make this simpler?

> +	modf_str = strsep(&orig_str, ".");
> +	if (modf_str) {
> +		snprintf(frac_part, 7, "%s00000", modf_str);
> +		ret = kstrtol(frac_part, 10, &frac);
> +		if (ret)
> +			return -EINVAL;

You leaked memory :(

> +	} else {
> +		frac = 0;
> +	}
> +
> +	*res = DIV_ROUND_CLOSEST_ULL((u64)ival * clk_rate, 1000)
> +		+ DIV_ROUND_CLOSEST_ULL((u64)frac * clk_rate, 1000000000);

Why isn't userspace doing this calculation?

I stopped reviewing here, sorry.

greg k-h
