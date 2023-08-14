Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FEA77B425
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjHNI30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjHNI3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:29:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43788B4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692001701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=njJM+a6VSJc0grHBKboYKUlbiiHbX1cXgDomhB4l3j0=;
        b=HZlDgHlJD+dH7Gq9AABIBj4QjXxNahYWe+mSt+TcdKdwv/kCH3KAaReb+mDAcUZKmoT1P8
        7IFQvEYhlJvBuiN65cHe4uh+I03YYyXu+2FdDh4bZ78fOcjUkdsh4ETnlmLMjnDdpjgtOH
        ef/8MD3yGJiKVN6Kzv8jB+lXlujv0iQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-7Y-JXo5nPrWygrey73KBTw-1; Mon, 14 Aug 2023 04:28:20 -0400
X-MC-Unique: 7Y-JXo5nPrWygrey73KBTw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-993c2d9e496so254832366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692001699; x=1692606499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njJM+a6VSJc0grHBKboYKUlbiiHbX1cXgDomhB4l3j0=;
        b=E6xvukyZbs/oiFbyEGyFNsuTFkKrs3ncYivPqPI4cXyx5nRgfi19Ucejn5OoP9fNsv
         xCYCzGhvGpAVFOOGQN9CL2sj+7TjQaWabfWWNgKeLHUHLDTEYGq2UH/v3LQObV/s97kb
         Ojlql5DONngrmRXwkZ3u7XgzNXOfxX9G6YLGrPOBL806GMEGCMfLEQxm/XEyvZzokzgN
         k9iQDlFPQZn4KQWgmG2LP5jzz4oCabPoUmywURqaVhxuRo1Ara7GNJNSDOEHtf9X0wQS
         qzanIzHF0kqicCNDQUi6nL7CBi2rJf1BVwiC4W88i182yda/fO9ivUHTfgojbGK9EqTj
         yMDA==
X-Gm-Message-State: AOJu0YxcmsWZFZjJxh1X1wyDmaoN8479zn9XwQqF7LyQjpenang9/8wH
        uZzjzlG4tr4wF4ohtrxVE3N5XlXVT0lTysxGh4glv37RJ6OofncEpz0nTokBP/ALiuJ5urPMfVk
        MMVYWtcgo2quN0k+NHq9ObPol
X-Received: by 2002:a17:906:1d:b0:99c:e38d:e47d with SMTP id 29-20020a170906001d00b0099ce38de47dmr8572682eja.27.1692001698935;
        Mon, 14 Aug 2023 01:28:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHny6IFDAGUS87QvmR7wAhgdmqa9K87UudUKzBAFrpA+BQsqp327Er/BYlH0vj3UNg8TvsHIw==
X-Received: by 2002:a17:906:1d:b0:99c:e38d:e47d with SMTP id 29-20020a170906001d00b0099ce38de47dmr8572671eja.27.1692001698609;
        Mon, 14 Aug 2023 01:28:18 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id d3-20020a1709063ec300b0099bcb44493fsm5466856ejj.147.2023.08.14.01.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 01:28:18 -0700 (PDT)
Message-ID: <ad158876-6634-ce4e-4d38-678e2a31a97c@redhat.com>
Date:   Mon, 14 Aug 2023 10:28:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] watchdog: simatic: add PCI dependency
Content-Language: en-US, nl
To:     Arnd Bergmann <arnd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Henning Schild <henning.schild@siemens.com>
Cc:     "xingtong . wu" <xingtong_wu@163.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230814073924.1066390-1-arnd@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230814073924.1066390-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/14/23 09:38, Arnd Bergmann wrote:
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

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Wachdog maintainers the commit causing the fixed issue is part of my
platform-drivers-x86-simatic-ipc branch:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=platform-drivers-x86-simatic-ipc

And more importantly that branch already contains a conflicting commit to the SIEMENS_SIMATIC_IPC_WDT Kconfig entry, which was merged through that branch with
Guenter's ack.

So I'll also pick up this fix and merge it through that branch to avoid conflicts.

Regards,

Hans




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

