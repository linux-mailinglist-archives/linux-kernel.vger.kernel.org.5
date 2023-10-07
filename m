Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CC07BC914
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 18:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344037AbjJGQbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 12:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343956AbjJGQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 12:31:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA27B9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 09:31:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B749C433C8;
        Sat,  7 Oct 2023 16:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696696263;
        bh=3saiFoFOXsJSmnhZLFioUhijfK07a5KjkQ16Shr0Tlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CLLJanprTG5mz641FdNC0EgNnkUfxQ5ZBC7WolVoMeEvuzESgZ9Lp+LKOhHG/8BRT
         50XNsXr2kyUJK+WOXAznr1k/j7UCYQSieAeq54JUprx3fCwtBff51vPfQsQ35DqtEv
         yrD7qzPSVXkNCuJqkdoFhDSyqeFX/12WzrKVRYh0=
Date:   Sat, 7 Oct 2023 18:31:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Walle <michael@walle.cc>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v12 5/7] nvmem: core: Rework layouts to become regular
 devices
Message-ID: <2023100722-stallion-unquote-a3b1@gregkh>
References: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
 <20231005155907.2701706-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005155907.2701706-6-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 05:59:05PM +0200, Miquel Raynal wrote:
> --- a/drivers/nvmem/internals.h
> +++ b/drivers/nvmem/internals.h
> @@ -28,8 +28,30 @@ struct nvmem_device {
>  	nvmem_reg_read_t	reg_read;
>  	nvmem_reg_write_t	reg_write;
>  	struct gpio_desc	*wp_gpio;
> +	struct device		*layout_dev;
>  	struct nvmem_layout	*layout;
>  	void *priv;
>  };

Wait, is this now 2 struct device in the same structure?  Which one is
the "real" owner of this structure?  Why is a pointer to layout_dev
needed here as a "struct device" and not a real "struct
nvmem_layout_device" or whatever it's called?

>  struct nvmem_layout {
> -	const char *name;
> -	const struct of_device_id *of_match_table;
> +	struct device *dev;

Shouldn't this be a "real" struct device and not just a pointer?  If
not, what does this point to?  Who owns the reference to it?

thanks,

greg k-h
