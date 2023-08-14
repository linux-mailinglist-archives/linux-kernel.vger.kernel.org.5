Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3C177BA96
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjHNNtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjHNNsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:48:43 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86A810DE;
        Mon, 14 Aug 2023 06:48:42 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1bba7717d3bso3292206fac.1;
        Mon, 14 Aug 2023 06:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692020922; x=1692625722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hl1VWJqwbRtkVZU9kxa+Wp4UzmA2hPMJtxFbWtnID98=;
        b=Ls97xeRr3iWacANUr7IlnehraFHOXYkh1gQ8FryFhWk7ej/49Mmk2Kdibx+TrgOjKt
         0mePgV53dQUULlO6+ZkhXsXYVWIGJeD/whzVXkjeXIE/1gpCM6/j/nFgHqFEF8XuZ44Q
         HUP8F+Jt8vvEtGtDsW1CKRpps/C8Ul7uqPdDairHyC+AujitHeSftFeXwcpWfbbEIrXP
         dDoMhDV4uqhU72t+Qgg2g3VRItrGUovlRF34JTUxTIJrHooLUPcILwfvrLChYVcLfQuR
         far5t+79sHpKNVw6oRcAryE0Q4LTHLj6RKt3yoFzh4/krBS8L2eYKRhT7nUk6pKruFD1
         lp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692020922; x=1692625722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hl1VWJqwbRtkVZU9kxa+Wp4UzmA2hPMJtxFbWtnID98=;
        b=lkoy5Cs+extGMDfaCrXXFltKRRMNQNsqcC00XNqrEeOphchiiwTUIzeRm/mtVGz3CH
         G2Zd3qQ1WaPnRmq0J9+iy7toFlwMLoi87l7p5sYgAsXR5WGYPfMKxo1yDaNq4lPf+CGt
         Lniln3SZ5bEG9U9KRf4O00JSHNSv99/ie+x4VhLrxdAds2lypVBLyg97W/+hlTI4HG4o
         CbQBjCkltgi/mwAWiehOt/HaAdfRuBUtiO9NJK7tz1fO9dbBQfFtP4xugtp/Wokhx0ZS
         k7kHZ1Z1iri7y3psFT06qfT21OLvntY0/JNgNy6qxxtNxjG1oFChRF6UJc8gbQIyevy4
         o64A==
X-Gm-Message-State: AOJu0YxMSwnhDWAyhW0qXyJXgEHyBADNOPFbQl2/3Le3N60BX4Ixp8D+
        dFaN9AioW5nqtfHcIEmceVQ=
X-Google-Smtp-Source: AGHT+IHFjIKjHNQ/FKFkRPUsszVzx+JdDwSl+Ib78UhwTqBmxLcpZVkuxyM3BXKuB449gteDVszb9g==
X-Received: by 2002:a05:6870:c6a5:b0:1bb:b025:3e87 with SMTP id cv37-20020a056870c6a500b001bbb0253e87mr10045294oab.58.1692020921896;
        Mon, 14 Aug 2023 06:48:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t4-20020a02c484000000b0042b6cb44429sm3042211jam.46.2023.08.14.06.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:48:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Aug 2023 06:48:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Henning Schild <henning.schild@siemens.com>,
        "xingtong . wu" <xingtong_wu@163.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: simatic: add PCI dependency
Message-ID: <cf7f3934-b81b-4629-b124-cf7a15c83481@roeck-us.net>
References: <20230814073924.1066390-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814073924.1066390-1-arnd@kernel.org>
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

On Mon, Aug 14, 2023 at 09:38:50AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The simatic-ipc driver no longer depends on PCI, but its watchdog portion
> still needs it, otherwise P2SB runs into a build  failure:
> 
> WARNING: unmet direct dependencies detected for P2SB
>   Depends on [n]: PCI [=n] && X86 [=y]
>   Selected by [m]:
>   - SIEMENS_SIMATIC_IPC_WDT [=m] && WATCHDOG [=y] && SIEMENS_SIMATIC_IPC [=y]
> 
> drivers/platform/x86/p2sb.c:121:3: error: call to undeclared function 'pci_bus_write_config_dword'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                 pci_bus_write_config_dword(bus, devfn_p2sb, P2SBC, 0);
> 
> Add back the minimum dependendency to make it build in random configurations
> again.
> 
> Fixes: b72da71ce24b0 ("platform/x86: simatic-ipc: drop PCI runtime depends and header")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 04e9b40cf7d53..09452384221a4 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1680,7 +1680,7 @@ config NIC7018_WDT
>  
>  config SIEMENS_SIMATIC_IPC_WDT
>  	tristate "Siemens Simatic IPC Watchdog"
> -	depends on SIEMENS_SIMATIC_IPC
> +	depends on SIEMENS_SIMATIC_IPC && PCI
>  	default y
>  	select WATCHDOG_CORE
>  	select P2SB
> -- 
> 2.39.2
> 
