Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E42277C399
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjHNWlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjHNWkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:40:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281FC1715
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692052802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l7gIh6nlPqSk8LuuWdz7csSouyNxDZki4ms0rDOko5s=;
        b=WRIjQBjJPz9VloENeOoxHvr/UkFHC9HZn+lnCinXL0z0HiPD4W1nXXKdJIh1laTiuzu6o/
        vIB9UzIDO2cFz+upj9ulNs3WJq9goPyw8yiFC+KrTZ26jjjnlkGKk4GV60r+H74ZMjXGvh
        JwPSnTEeLgxYez756nb6T1oo67flMao=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-pvsEIUuAOS2lWcmtrBWNJw-1; Mon, 14 Aug 2023 18:40:01 -0400
X-MC-Unique: pvsEIUuAOS2lWcmtrBWNJw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5637a108d02so5083218a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692052800; x=1692657600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7gIh6nlPqSk8LuuWdz7csSouyNxDZki4ms0rDOko5s=;
        b=iXHCWSVX8blZ3xlB9JSmOWKsDVctXJfphVimHu/LkrJ4QWHXLSHi8pR+zTZrsDrEcQ
         2tVBj1pq5uiZ39z5PiO5VW69y/0w7+Ap8l3C912TM/6xT1QNQS06pVFkM0fZ9AxvttUz
         DiuOSLXzCTWirLR7bD6cVJqtqzxp/QMdQzhHhzFrSpMp+A1AXHBmckBrnPvs8J3M5C+A
         8a4PA437NxNt0pMDbt+ESxbGIt07crAyQXqV8Z4kQx5bSKIChI3fnZG12UfwTc+WhIPF
         NtFk7v3AjqeIPgJfRVocVBwPiUblGiucw+m0iepXxGDm5p9/H4eSFzcTIqBZaXT+sxgu
         mh2g==
X-Gm-Message-State: AOJu0YyQtZr6RbEVUtW7bWkqYNNpxXarSlgEa835+bTUEG0Iu6s+7FqJ
        8wVHYoero9QaoNnDfFf4psQgc6SmfW/klYj3Fqjq0TTdeidKtad3R1ExH3pRNc0m14Eko9lgwnC
        12jiVWLGlmM2B8vcotZ/iCne2
X-Received: by 2002:a05:6a20:441f:b0:12e:7c29:a6dd with SMTP id ce31-20020a056a20441f00b0012e7c29a6ddmr11376826pzb.43.1692052800015;
        Mon, 14 Aug 2023 15:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF01jSZJ6upznh7bf7zow0hjWHaC+2v5nH9nEmy2PDwpj41mQnVkeFYwD3RO97AQ8NT35C/VA==
X-Received: by 2002:a05:6a20:441f:b0:12e:7c29:a6dd with SMTP id ce31-20020a056a20441f00b0012e7c29a6ddmr11376811pzb.43.1692052799700;
        Mon, 14 Aug 2023 15:39:59 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id u18-20020a170903125200b001b53953f306sm9975124plh.178.2023.08.14.15.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 15:39:57 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:39:56 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts categorically for Lenovo
Message-ID: <7ruidj3qnt6eapetwt6uwhkqeextehaisoc2i6axqax3s5js7z@eu6hoh2q7tkd>
References: <20230810182433.518523-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810182433.518523-1-jarkko@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 09:24:33PM +0300, Jarkko Sakkinen wrote:
> By large most of the entries in tpm_tis_dmi_table[] are for Lenovo laptops,
> and they keep on coming. Therefore, disable IRQs categorically for Lenovo.
> 
> Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> Cc: <stable@vger.kernel.org> # v6.4+
> Reported-by: "Takashi Iwai" <tiwai@suse.de>
> Closes: https://lore.kernel.org/linux-integrity/87il9qhxjq.wl-tiwai@suse.de/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Acked-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
> This will be included into v6.5-rc6 PR, as long as Takashi ack's it. I'm
> planning to send tomorrow morning (GMT+3).
> 
> BR, Jarkko
>  drivers/char/tpm/tpm_tis.c | 34 ----------------------------------
>  1 file changed, 34 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 3c0f68b9e44f..dd0f52d35073 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -132,42 +132,8 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
>  	},
>  	{
>  		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkPad T490s",
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkStation P360 Tiny",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P360 Tiny"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkPad L490",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L490"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkPad L590",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L590"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkStation P620",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P620"),
>  		},
>  	},
>  	{
> -- 
> 2.39.2
> 

