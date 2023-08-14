Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF7777B56D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjHNJ1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236341AbjHNJ1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:27:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09DA10FE;
        Mon, 14 Aug 2023 02:27:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CC3B61032;
        Mon, 14 Aug 2023 09:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4CAC433C7;
        Mon, 14 Aug 2023 09:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692005217;
        bh=kfODF3htHFqvg1C/xE2XnZ4LlEuCRb3RyYko4VaZ1UI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=OvT3kYZfaSiN5TfLuobR+izFj4e76xL2irDMmKR9gr8jBHtQJWRAOhoA08+iabigg
         y7bf3AKKFZCTpH9n44O85cyghv+Jt93Rrf3hqy2C0Swv8vIWx8DnYY9lWeRl8bC+T7
         ltJnyzB5T533FXiFv+qVwwenNy0WmXi1Nk7ZBNkhsNz+To7HbfOv73jYSbhrJu9s8L
         McyWf60MBsacMDe50RX9V1yDRBnAwQo4fZWXaT/3COnrMCJIGylEdKlqvIzABiOQ3I
         syw+2gpAWfMu7wCHtqc4cQ+c652lQ1eV9I2C0bXbZL8IWPkgNIMKVlsSLJdOf4tejD
         umuMVU0YygTTw==
Date:   Mon, 14 Aug 2023 11:26:53 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Riwen Lu <luriwen@hotmail.com>
cc:     benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        linux@weissschuh.net, hdegoede@redhat.com, rrangel@chromium.org,
        u.kleine-koenig@pengutronix.de, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v1] HID: i2c-hid: use print_hex_dump_debug to print report
 descriptor
In-Reply-To: <TYCP286MB260706B19C5E30EE2774784EB129A@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM>
Message-ID: <nycvar.YFH.7.76.2308141126330.14207@cbobk.fhfr.pm>
References: <TYCP286MB260706B19C5E30EE2774784EB129A@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2023, Riwen Lu wrote:

> From: Riwen Lu <luriwen@kylinos.cn>
> 
> The format '%*ph' print up to 64 bytes long as a hex string with ' '
> sepatator. Usually the size of report descriptor is larger than 64
> bytes, so consider using print_hex_dump_debug to print out all of it for
> better debugging.
> 
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index efbba0465eef..8e97fc01c852 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -772,7 +772,9 @@ static int i2c_hid_parse(struct hid_device *hid)
>  		}
>  	}
>  
> -	i2c_hid_dbg(ihid, "Report Descriptor: %*ph\n", rsize, rdesc);
> +	i2c_hid_dbg(ihid, "Report Descriptor\n");
> +	print_hex_dump_debug("  ", DUMP_PREFIX_OFFSET, 16, 1,
> +			rdesc, rsize, false);

But that would dump it unconditionally, while i2c_hid_dbg() is 
conditional.

-- 
Jiri Kosina
SUSE Labs

