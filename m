Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3268F812145
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjLMWOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjLMWOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:14:16 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B07E0;
        Wed, 13 Dec 2023 14:14:22 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6ce76f0748fso5011126b3a.2;
        Wed, 13 Dec 2023 14:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702505662; x=1703110462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9QxhbW+nAi3VnrIxlU07D1CRBPKIxjUPRxFVorWzuw=;
        b=GZUWSEj5QQixzoGeNXNmlot7LUhspzxf/NXHxQahwzO2opABUvEvIdx26gOW4NhImp
         nxmgj7wKJUzCRGz6LqjB14SoX06nu/9qLTIefdcXMnKvadMyFLrwnYJQGibjAYcKVxYm
         zm6PQYxbY3lvy3ish9uV4Hj9h9+POnNILxZQ7llWxH6XgkEf2PSiSrQoF5Cz6ctrEroo
         S9zpa8s+lzCKvV07rCSa+6OyojioIzJwFlxeTMzENbhHpmZHfD2TL8l8vJ+FWPLFMl6k
         MKKTo4Lq8C06sc4DVrCa+VPK3OnYQjIwoiIyVps9WLmaWyHeJ6jaZ26zOO2fawqKzYyI
         YGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702505662; x=1703110462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9QxhbW+nAi3VnrIxlU07D1CRBPKIxjUPRxFVorWzuw=;
        b=LATP0piJ/q4lFM2kpTi3UENNfy6UGoDGrH2mnh1MTTrnUvc5s1qTPkHJBZxCnwwDLN
         Jnoi6Ya7USgK+0fIJtzPFHcNSqFnrsVSYqhFZcjzCszMgt/Kg37LvUTAhUaBT/EucZZg
         nMizxBSsPgkS1mN3IXrxX6yXRjKb8kJqbM59d0Uqytis/Eipzm0+jQ4CDT+8CoDRHauU
         UjkOBY0SyH5qkJXhbkuoyM0wXQY3p1KGt4n7NN2ROn1DLGHXv4aU+953gAqmMP0ZE2wk
         IFFGRbGXgIkiqWZcKaj3leFvCsOdywwQfc+ndweLtB+MzqFYteR55GQTbQFoBaS70LeI
         cEuA==
X-Gm-Message-State: AOJu0YxeEPYeX23/BxpfmjjLWB6WqTvPaIVrXppmhRtHlxOXSavop8hn
        blZisbwFKrbNyhhmDjJZaN4=
X-Google-Smtp-Source: AGHT+IFKnbnpod4hkwq3TH2X9J61F7X//vlOu9zg8JmpWzOrRni66GstwLc29UyFdCPLAPEbJAlqZg==
X-Received: by 2002:a05:6a00:27a1:b0:6ce:7612:6c30 with SMTP id bd33-20020a056a0027a100b006ce76126c30mr4589745pfb.65.1702505662197;
        Wed, 13 Dec 2023 14:14:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u10-20020a62d44a000000b006cde1cef719sm10770769pfl.152.2023.12.13.14.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:14:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 13 Dec 2023 14:14:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] watchdog/hpwdt: Remove redundant test.
Message-ID: <1ce74029-2bf8-4bce-9c67-aa2be277861f@roeck-us.net>
References: <20231213215340.495734-1-jerry.hoemann@hpe.com>
 <20231213215340.495734-3-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213215340.495734-3-jerry.hoemann@hpe.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 02:53:39PM -0700, Jerry Hoemann wrote:
> ProLiants of vintage to have an iLO 5, no longer send watchdog NMI
> as an IO CHECK.  They are presented to hpwdt_pretimeout as NMI_UNKNOWN.
> The preceding if statement rejects if !mynmi irrespective of value
> of pretimeout making this if statement redundant.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/hpwdt.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 79ed1626d8ea..d5c0aa3ef069 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -181,9 +181,6 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>  	if (ulReason == NMI_UNKNOWN && !mynmi)
>  		return NMI_DONE;
>  
> -	if (ilo5 && !pretimeout && !mynmi)
> -		return NMI_DONE;
> -
>  	if (kdumptimeout < 0)
>  		hpwdt_stop();
>  	else if (kdumptimeout == 0)
> -- 
> 2.41.0
> 
