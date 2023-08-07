Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5872771CD6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjHGJD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjHGJDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:03:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB6F19A9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:03:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FF5E616B6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD5AC433C8;
        Mon,  7 Aug 2023 09:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691398957;
        bh=jZPRyaGCBjcvPhosHGkOjAp/BB38MBkqzg7j28UROPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4QtD8HE0PAjKHvgQJjxGqgBvSUEAb3GXDVkEJEjU3DFqUK2kTAev3njqUaLkh356
         hL5IXiRnCPk2zhi7hnDoRXTYm3IykiEQHw61BE27aRorJeW4PCGJjNGgjfVof6a/kF
         sqOONOPgOz3m7WAAq481evwiCVY9s+pkWZqQdZNk=
Date:   Mon, 7 Aug 2023 11:02:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH v8 4/8] nvmem: core: Track the registered devices
Message-ID: <2023080732-gulp-pancake-93a5@gregkh>
References: <20230807082419.38780-1-miquel.raynal@bootlin.com>
 <20230807082419.38780-5-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807082419.38780-5-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 10:24:15AM +0200, Miquel Raynal wrote:
> Create a list with all the NVMEM devices registered in the
> subsystem. This way we can iterate through them when needed (unused for
> now).
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/nvmem/core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 257328887263..4e81e0aaf433 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -23,6 +23,7 @@
>  struct nvmem_device {
>  	struct module		*owner;
>  	struct device		dev;
> +	struct list_head	node;
>  	int			stride;
>  	int			word_size;
>  	int			id;
> @@ -76,6 +77,9 @@ static LIST_HEAD(nvmem_cell_tables);
>  static DEFINE_MUTEX(nvmem_lookup_mutex);
>  static LIST_HEAD(nvmem_lookup_list);
>  
> +static DEFINE_MUTEX(nvmem_devices_mutex);
> +static LIST_HEAD(nvmem_devices_list);

But this list should already be in the driver core, why create
yet-another-list-and-lock?

Why is "when needed" not sufficient to use the list already present?

And now note, you have the same structure on 2 different lists, watch
out for device lifetime rules :(

thanks,

greg k-h
