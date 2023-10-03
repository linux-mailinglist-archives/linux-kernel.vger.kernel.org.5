Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA437B5E64
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238916AbjJCAzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbjJCAzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:55:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4D9AD;
        Mon,  2 Oct 2023 17:55:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3DDC433C8;
        Tue,  3 Oct 2023 00:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696294503;
        bh=63nIVmpYLKILW/s0Kk9Sh87RCRFxM5iTBFmG5AAZttk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ptlfSJp8QgLh9LOcU8agJhr19fChW4R0QJVLZ/ca3F12+ZeLbIjvIP+Tyh7pgCP+K
         q/vxN+CbACkCfhv4JTrmGcNr5HXG/3kQ57uqTn8MGI+JhMxB0EfWBpzcAQN/16gjPU
         jVWnhHIBSZRY+GkBqnM8jo4AVuwOhyXzSTzNtU7aDvqZR0OLnfYQT/+fUAaHTvNSpH
         m2DvWK10uurat5xAhWOnZ1hclwaIlMvdfACXSej2+mndvzW+KXBVt7JOIhXUgJEZf8
         XZUdglK3/FDDVidGgCU6Jga7Byu+49B62tGkJrWQhjXY3MqrwX0t8P7+hFdb5Dv9Uz
         dJ+v8ZynmXQ0Q==
Message-ID: <d2fd9a3c-3efd-dbfe-7b2a-dc36989b8379@kernel.org>
Date:   Tue, 3 Oct 2023 09:55:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/4] pata_parport: add custom version of wait_after_reset
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230930191511.24994-1-linux@zary.sk>
 <20230930191511.24994-4-linux@zary.sk>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230930191511.24994-4-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/23 04:15, Ondrej Zary wrote:
> Some parallel adapters (e.g. EXP Computer MC-1285B EPP Cable) return
> bogus values when there's no master device present. This can cause
> reset to fail, preventing the lone slave device (such as EXP Computer
> CD-865) from working.
> 
> Add custom version of wait_after_reset that ignores master failure when
> a slave device is present. The custom version is also needed because
> the generic ata_sff_wait_after_reset uses direct port I/O for slave
> device detection.
> 
> Signed-off-by: Ondrej Zary <linux@zary.sk>
> ---
>  drivers/ata/pata_parport/pata_parport.c | 65 ++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
> index cf87bbb52f1f..b3db953e615a 100644
> --- a/drivers/ata/pata_parport/pata_parport.c
> +++ b/drivers/ata/pata_parport/pata_parport.c
> @@ -80,6 +80,69 @@ static bool pata_parport_devchk(struct ata_port *ap, unsigned int device)
>  	return (nsect == 0x55) && (lbal == 0xaa);
>  }
>  
> +static int pata_parport_wait_after_reset(struct ata_link *link,
> +					 unsigned int devmask,
> +					 unsigned long deadline)
> +{
> +	struct ata_port *ap = link->ap;
> +	struct pi_adapter *pi = ap->host->private_data;
> +	unsigned int dev0 = devmask & (1 << 0);
> +	unsigned int dev1 = devmask & (1 << 1);
> +	int rc, ret = 0;
> +
> +	ata_msleep(ap, ATA_WAIT_AFTER_RESET);
> +
> +	/* always check readiness of the master device */
> +	rc = ata_sff_wait_ready(link, deadline);
> +	/* some adapters return bogus values if master device is not present,
> +	 * so don't abort now if a slave device is present
> +	 */

In addition to Sergey's comment, please move this comment inside the "if", or
even better, merge it with the otherwise not very useful "always check
readiness..." comment.

> +	if (rc) {
> +		if (!dev1)
> +			return rc;
> +		ret = -ENODEV;
> +	}
> +
> +	/* if device 1 was found in ata_devchk, wait for register
> +	 * access briefly, then wait for BSY to clear.
> +	 */
> +	if (dev1) {
> +		int i;
> +
> +		pata_parport_dev_select(ap, 1);
> +
> +		/* Wait for register access.  Some ATAPI devices fail
> +		 * to set nsect/lbal after reset, so don't waste too
> +		 * much time on it.  We're gonna wait for !BSY anyway.
> +		 */
> +		for (i = 0; i < 2; i++) {
> +			u8 nsect, lbal;
> +
> +			nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
> +			lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
> +			if ((nsect == 1) && (lbal == 1))
> +				break;
> +			ata_msleep(ap, 50);	/* give drive a breather */

Please move the comment on its own line above the sleep call.

> +		}
> +
> +		rc = ata_sff_wait_ready(link, deadline);
> +		if (rc) {
> +			if (rc != -ENODEV)
> +				return rc;
> +			ret = rc;
> +		}
> +	}
> +
> +	/* is all this really necessary? */

I don't know. It is your driver... So either drop this comment, or clearly
explain why this is done.

> +	pata_parport_dev_select(ap, 0);
> +	if (dev1)
> +		pata_parport_dev_select(ap, 1);
> +	if (dev0)
> +		pata_parport_dev_select(ap, 0);

Can you have dev1 && dev0 == true ? This seems like the second if should be an
"else if", but it is not clear what this is doing.

> +
> +	return ret;
> +}
> +
>  static int pata_parport_bus_softreset(struct ata_port *ap, unsigned int devmask,
>  				      unsigned long deadline)
>  {
> @@ -94,7 +157,7 @@ static int pata_parport_bus_softreset(struct ata_port *ap, unsigned int devmask,
>  	ap->last_ctl = ap->ctl;
>  
>  	/* wait the port to become ready */
> -	return ata_sff_wait_after_reset(&ap->link, devmask, deadline);
> +	return pata_parport_wait_after_reset(&ap->link, devmask, deadline);
>  }
>  
>  static int pata_parport_softreset(struct ata_link *link, unsigned int *classes,

-- 
Damien Le Moal
Western Digital Research

