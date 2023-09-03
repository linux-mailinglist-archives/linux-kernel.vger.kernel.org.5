Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD69790BB6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 13:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbjICLwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 07:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjICLwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 07:52:50 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9326E11D;
        Sun,  3 Sep 2023 04:52:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E2019CE0947;
        Sun,  3 Sep 2023 11:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FBFC433C7;
        Sun,  3 Sep 2023 11:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693741962;
        bh=cxyIgvgIZ5hFw4+LmUCRY7UAgvFWrzKap+K9RohlwbI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sZY8zqHUT/5fZjThVW0Dg110RljkNP3dOWBvkETVqZl9mW/mbzCJLOpEmL6sVf8mT
         n38ZYkf76gxBVF+IUjEcHWcysh1ebAiH+W+YKmq9vvyMMUTj5hjtebsJCza2K+aeqE
         iwjFCEYBQC0lDjlhZqjZUTYvjxAJb101PcussiZx00dv9lnOx06R/HtITip9p4REXx
         wSVcEpS0EeexoMOw71SzIe3Lx799b1nIIIoj/wOhpfrB7hb6dJJDtTG2y8NtSDZAp4
         ss4UwY7oqvp5gVA25Y84onpWT1KdTg5xJvNPAXkCS6FWYudxjVijv58SYrqt+/Ggbt
         RcH0SNAFehXJQ==
Date:   Sun, 3 Sep 2023 12:53:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Cc:     eajames@linux.ibm.com, lars@metafoo.de, joel@jms.id.au,
        andrew@aj.id.au, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] iio: pressure: dps310: Adjust Timeout Settings
Message-ID: <20230903125309.12c59189@jic23-huawei>
In-Reply-To: <20230829180222.3431926-2-lakshmiy@us.ibm.com>
References: <20230829180222.3431926-1-lakshmiy@us.ibm.com>
        <20230829180222.3431926-2-lakshmiy@us.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 13:02:22 -0500
Lakshmi Yadlapati <lakshmiy@us.ibm.com> wrote:

> The DPS310 sensor chip has been encountering intermittent errors while
> reading the sensor device across various system designs. This issue causes
> the chip to become "stuck," preventing the indication of "ready" status
> for pressure and temperature measurements in the MEAS_CFG register.
> 
> To address this issue, this commit fixes the timeout settings to improve
> sensor stability:
> - After sending a reset command to the chip, the timeout has been extended
>   from 2.5 ms to 15 ms, aligning with the DPS310 specification.
> - The read timeout value of the MEAS_CFG register has been adjusted from
>   20ms to 30ms to match the specification.
> 
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Hi Lakshmi,

This seems reasonable to me, but as we probably want to backport it to
stable kernels, please could you figure out an appropriate Fixes tag.

Fine to just reply to this email with the tag rather than resend.

Thanks

Jonathan
 
> ---
>  drivers/iio/pressure/dps310.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index b10dbf5cf494..1ff091b2f764 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -57,8 +57,8 @@
>  #define  DPS310_RESET_MAGIC	0x09
>  #define DPS310_COEF_BASE	0x10
>  
> -/* Make sure sleep time is <= 20ms for usleep_range */
> -#define DPS310_POLL_SLEEP_US(t)		min(20000, (t) / 8)
> +/* Make sure sleep time is <= 30ms for usleep_range */
> +#define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
>  /* Silently handle error in rate value here */
>  #define DPS310_POLL_TIMEOUT_US(rc)	((rc) <= 0 ? 1000000 : 1000000 / (rc))
>  
> @@ -402,8 +402,8 @@ static int dps310_reset_wait(struct dps310_data *data)
>  	if (rc)
>  		return rc;
>  
> -	/* Wait for device chip access: 2.5ms in specification */
> -	usleep_range(2500, 12000);
> +	/* Wait for device chip access: 15ms in specification */
> +	usleep_range(15000, 55000);
>  	return 0;
>  }
>  

