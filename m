Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACA4757FED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjGROoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjGROoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:44:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF051719
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:44:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D07C8615FA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C501EC433C7;
        Tue, 18 Jul 2023 14:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689691452;
        bh=Dpa0BBJY0usbW6MS1PGwRNsH0/TgQbisQVfWeOxQRoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x0Ti1SlmzgnshUF8UNksWpJy8hprTQUEHUkxeCZ8AjWsdN28Wqp8URpMHY0+bKRwD
         VUPtAQ2a6mPqoEDwxY5AseB5uWCIf8XI6+C4rxPaH8CqeXfpyNj/gtyRBc0HTxPS7+
         /D+g/K3JwWAXtOyf5/V64e3/GBrFJjAWil5DzECg=
Date:   Tue, 18 Jul 2023 16:44:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmem: core: append offset to cell name in sysfs
Message-ID: <2023071830-ruby-atop-99e6@gregkh>
References: <ZLaZ7fzUSsa0Igx1@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLaZ7fzUSsa0Igx1@makrotopia.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 02:55:57PM +0100, Daniel Golle wrote:
> The device tree node names are not required to be unique. Append the
> offset to the name to make cell nodes with identical names become
> accessible via sysfs and avoid kernel stackdump caused by
> sysfs: cannot create duplicate filename '...'
> 
> Fixes: 757f8b3835c9 ("nvmem: core: Expose cells through sysfs")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/nvmem/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 70e951088826d..90fe9dc30f8ba 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -480,7 +480,9 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
>  	/* Initialize each attribute to take the name and size of the cell */
>  	list_for_each_entry(entry, &nvmem->cells, node) {
>  		sysfs_bin_attr_init(&attrs[i]);
> -		attrs[i].attr.name = devm_kstrdup(&nvmem->dev, entry->name, GFP_KERNEL);
> +		attrs[i].attr.name = devm_kasprintf(&nvmem->dev, GFP_KERNEL,
> +						    "%s@%d", entry->name,
> +						    entry->offset);

No documenatation update to show the new naming scheme?

And again, I don't see that git id in Linus's tree, am I just not up to
date properly?

thanks,

greg k-h
