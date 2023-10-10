Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ED37C45AD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344223AbjJJXsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJJXsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:48:07 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022E394;
        Tue, 10 Oct 2023 16:48:06 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-49d55b90a5aso251260e0c.0;
        Tue, 10 Oct 2023 16:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696981685; x=1697586485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9QviIRuDzheQ8CzniSPUXGfTmlt7tS6/YvDRgmfhztA=;
        b=QvTwp2FAhN82j3lzdF7PqkxXSCCNmzWTbKUnPWw5El3AdX6hCVZoEHDGzVQn8VvlmU
         mGO7K/XCkiOU6/e2fkj3S4XRO2YiXe0lVTzTHBWkQmjtprCwE5hCfYD/kLA+ZsMatJTe
         ls8eJooTmmusLce/+7xUYjLjZoS6Tawz8xZ/0z18djixkf6Xan7vIjBEkZZ7cN1I+IuP
         PZfJcP8sNUQFEaYMIdTGmlvEgzU5xhUtL/bEmdAupT92FvD+Fc/Nx6jFQsJOTGpLrAHE
         9vNyKvAKQUyW66wKTD5G3QvbgHd0nE0z1TZp0uf1Cm2ISqfNtsArPyYF43k0VGfEBlj8
         215A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696981685; x=1697586485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QviIRuDzheQ8CzniSPUXGfTmlt7tS6/YvDRgmfhztA=;
        b=R13vqA/AdAnL6xfCv0CNoyIV+8ggHJToCBo29wwblUKMcy2Nup86BMw5ZfkepKJ0Bg
         JBa1vKDTFg13gFW+S/dqn71pMY6Vl+XOuJJfJhIGFeic4Ju+3rqOuXmqWyUMu9XqVepQ
         +nb/fmjTLNl4k7lge8Vgpjbxlbbiq2n87cVkkR58S8C6qMWIqrSCVbm5d+wBnXtREl8k
         a0Wd9kyDP0ie5NdhT7wUcEFu0zhhtHANksdg41yhUPb1eIdjXHvRqPGZx74CGka/qRLw
         AJfXNd6kt75USRaw7NqCifq2LWAs8PehXblHSfbe8LeZ6YSV5Hj0HZbn0HTVlOj4qAdU
         4IQg==
X-Gm-Message-State: AOJu0Yy8nt5mGIkeLU6IPACD71LFxxee8LCRH2jVFcIUoDs6yCsy3/iB
        I0LBH7S8UCIlEwGPxPq28brhP2WdHeE=
X-Google-Smtp-Source: AGHT+IEuzXuz33vaWkVbhjpdApypb50wJ2C29fX9oNneNNfmfPT8cyQbfwG6/7Bn3a7HiqEPEiLTTg==
X-Received: by 2002:a1f:e7c4:0:b0:49a:9f99:bb03 with SMTP id e187-20020a1fe7c4000000b0049a9f99bb03mr9860723vkh.1.1696981684927;
        Tue, 10 Oct 2023 16:48:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s2-20020a05612204c200b0049ab44fce7esm2273841vkn.50.2023.10.10.16.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:48:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 10 Oct 2023 16:48:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: marvell_gti: Replace of_platform.h with
 explicit includes
Message-ID: <4e5b2282-5c96-48cc-9271-11932df63cf3@roeck-us.net>
References: <20231010205636.1584480-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010205636.1584480-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 03:56:36PM -0500, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other and pull in various other headers. In
> preparation to fix this, adjust the includes for what is actually needed.
> 
> of_platform.h isn't needed, but of.h was implicitly included by it (via
> of_device.h).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Note this was added in the merge window and missed the last round.
> ---
>  drivers/watchdog/marvell_gti_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/marvell_gti_wdt.c b/drivers/watchdog/marvell_gti_wdt.c
> index d7eb8286e11e..01e9177cbf20 100644
> --- a/drivers/watchdog/marvell_gti_wdt.c
> +++ b/drivers/watchdog/marvell_gti_wdt.c
> @@ -8,8 +8,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/of.h>
>  #include <linux/watchdog.h>
>  
>  /*
> -- 
> 2.42.0
> 
