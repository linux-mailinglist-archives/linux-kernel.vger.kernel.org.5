Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22E375806E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjGRPIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjGRPIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:08:04 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE411726;
        Tue, 18 Jul 2023 08:07:56 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a36b309524so4505667b6e.3;
        Tue, 18 Jul 2023 08:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689692876; x=1692284876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVXWZBoSx664OwzviIxNRhNVG6aySGYnPSBHtULJaqo=;
        b=IY8zsZy1EGcCt5w//qyi566YNY7hud+3nNoCJwi3Sh/IpLn7jLWWrsFAYyz0N+CQYq
         HEhBIoLaVLZvz5wcbJ25ruOonkG1uSIdoWTvwpJOyisDvNiSfcSRaADBZIeNjFdjzbpg
         hfyzFxK+gjW+DKXzwcO2Vx+TnXikjcEGnXMtuR0CUuriIo0QXQdQ7qYGcVkDR77mYncE
         kbQyGGCVZ6pKGDURtlQSd0PHVoKVDDdnYyraP5wzT0iKhKOm7+j50BZgmo965ps7aN0w
         rT+707G2NveksjGSGLdvm2jEmNIEgcJjpx38fcixi330FvlPYXZ8wBZd1hP0TE/B9RQ6
         Cnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689692876; x=1692284876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVXWZBoSx664OwzviIxNRhNVG6aySGYnPSBHtULJaqo=;
        b=IgTtu2Ll0n+9SrTE05L3GVKxZTW9Y8Pg0qCHzKBtkE54iLzVc8RzRB09yhPQmjEif0
         X+6tfBk9dKIuIZBxVR+vNB9UpaNj4hUHiYYxjybxGCkEKaEpFqmWy3cOimAWJVKq3WaW
         dx2JOjYeXOOwEy5+MQJnXuVGLwhdZhxzWTMVrtZbDnuxaOLmIBjLwqPt72QPTivSu9xH
         sUKml06gC5FPGazwU6XGUSESdiTAYdhmYxDC7hIHnkQ2r865I3UsCK9WkkGYS/aWf4p2
         IzjihhRVFvqa4aQkPFmHmkXscKiiOxmLeOn7E1y59Fj3pVrB67Fa9Le3n8+PSVcDgE9L
         R4Og==
X-Gm-Message-State: ABy/qLZEYQ6clvHwOZGIIIkWoasgLhpXfZWqWaWu3ZzoLCgCPiDi5xJX
        STaayBVfjv59Op4GvaauW7U=
X-Google-Smtp-Source: APBJJlHdU6d2pHGgptBtZ/6h3R56fCbABYzHJC7+lVaMDSO+5JvTzNc+FVk1DXE6CjO1/meNPS3wcw==
X-Received: by 2002:a05:6808:118c:b0:3a3:7248:252a with SMTP id j12-20020a056808118c00b003a37248252amr20524855oil.0.1689692876126;
        Tue, 18 Jul 2023 08:07:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r74-20020a0de84d000000b00545a081849esm506030ywe.46.2023.07.18.08.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 08:07:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 Jul 2023 08:07:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Lee Jones <lee@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH 1/3] watchdog: make Siemens Simatic watchdog driver
 default on platform
Message-ID: <0f38956f-8d23-4f50-8e76-85fc3e225fd6@roeck-us.net>
References: <20230718105213.1275-1-henning.schild@siemens.com>
 <20230718105213.1275-2-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718105213.1275-2-henning.schild@siemens.com>
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

On Tue, Jul 18, 2023 at 12:52:11PM +0200, Henning Schild wrote:
> If a user did choose to enable Siemens Simatic platform support they
> likely want that driver to be enabled without having to flip more config
> switches. So we make the watchdog driver config switch default to the
> platform driver switches value.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/watchdog/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index ee97d89dfc11..ccdbd1109a32 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1681,6 +1681,7 @@ config NIC7018_WDT
>  config SIEMENS_SIMATIC_IPC_WDT
>  	tristate "Siemens Simatic IPC Watchdog"
>  	depends on SIEMENS_SIMATIC_IPC
> +	default SIEMENS_SIMATIC_IPC

Why not just "default y" ? That does the same (it will be set to m if
SIEMENS_SIMATIC_IPC=m) without the complexity.

Guenter

>  	select WATCHDOG_CORE
>  	select P2SB
>  	help
> -- 
> 2.41.0
> 
