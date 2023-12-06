Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925D680691A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376742AbjLFII5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLFIIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:08:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722F6D3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:09:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0877DC433C8;
        Wed,  6 Dec 2023 08:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701850140;
        bh=dbaCGgIHqNo8yZQRScnnf4gBHa499emj86x/EkqbO/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V+DDbMBPoM0fGmXfCIj0JkmfrfPa/SphYYlAmjkW/jxPEzVI5S13EMHbvhHINZMdj
         zVgvI/lJdxtYTh7FevhIk3e0Z+9rv7OmwinbmzIi0EHq2fJMyHcRZSBX8NaBQfnEs+
         TBAbaam4eFEAXrtOUzBKHIxAD7RcSo1a39zr4igBm1gqJB2CRyR1teBPl04dZcJyTs
         era9Iu/qf6H0sRhLAzQ1Wjoqcf6O23/7CA/fpmCuWqgcNKlyOtC4KJLUdOT+wEeVSJ
         8Cyl/CaA7vKm7Uf1FzHsFb8zUNwCgbBaxZDfBUDmdsl6WoMnb8t4R0XUXAZuuKgVe7
         rGRTNsvTMDYyQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rAmyY-0006ae-28;
        Wed, 06 Dec 2023 09:09:46 +0100
Date:   Wed, 6 Dec 2023 09:09:46 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 23/27] tty: serdev: convert to u8 and size_t
Message-ID: <ZXAsSjFzBaBdqJSg@hovoldconsulting.com>
References: <20231206073712.17776-1-jirislaby@kernel.org>
 <20231206073712.17776-24-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206073712.17776-24-jirislaby@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 08:37:08AM +0100, Jiri Slaby wrote:
> Switch character types to u8 and sizes to size_t. To conform to
> characters/sizes in the rest of the tty layer.
>
> This patch converts struct serdev_device_ops hooks and its
> instantiations.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> ---
  
> diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
> index 5d8e9bfb24d0..baa956494e79 100644
> --- a/drivers/gnss/serial.c
> +++ b/drivers/gnss/serial.c
> @@ -80,8 +80,8 @@ static const struct gnss_operations gnss_serial_gnss_ops = {
>  	.write_raw	= gnss_serial_write_raw,
>  };
>  
> -static int gnss_serial_receive_buf(struct serdev_device *serdev,
> -					const unsigned char *buf, size_t count)
> +static ssize_t gnss_serial_receive_buf(struct serdev_device *serdev,
> +				       const u8 *buf, size_t count)
>  {
>  	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
>  	struct gnss_device *gdev = gserial->gdev;
> diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
> index bcb53ccfee4d..6801a8fb2040 100644
> --- a/drivers/gnss/sirf.c
> +++ b/drivers/gnss/sirf.c
> @@ -160,8 +160,8 @@ static const struct gnss_operations sirf_gnss_ops = {
>  	.write_raw	= sirf_write_raw,
>  };
>  
> -static int sirf_receive_buf(struct serdev_device *serdev,
> -				const unsigned char *buf, size_t count)
> +static ssize_t sirf_receive_buf(struct serdev_device *serdev,
> +				const u8 *buf, size_t count)
>  {

The gnss subsystem consistently use tabs-only for indentation of
continuation lines so please don't change the indentation for these
files.

With that fixed:

Acked-by: Johan Hovold <johan@kernel.org>

Johan
