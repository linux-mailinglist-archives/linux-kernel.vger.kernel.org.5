Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17599770359
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjHDOnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHDOnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:43:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0DF46B2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691160134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAvTWqAeXBrkQJC92t5R4tpJzEn0Uk1niwpeCxuucnk=;
        b=X4AmpPI2HPbHAKMVpGNTLF2eGvs6MpnU/6oaui9XM/n5xvQy6V+UaXwo4vACw7JR+0mRKV
        +ScyNeSEge7wlVPziqBhG7AFsIwWRtyKMe1QeXn5t+qc51HpMXDT9BztpMzlrCgVhoSg2k
        41I+xIB4JTlAqezRRCWwTnFyWMpsrIg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-Obz10uoAO0KBZ9z4X7wzCg-1; Fri, 04 Aug 2023 10:42:12 -0400
X-MC-Unique: Obz10uoAO0KBZ9z4X7wzCg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9e9a85a42so24969861fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 07:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691160131; x=1691764931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xAvTWqAeXBrkQJC92t5R4tpJzEn0Uk1niwpeCxuucnk=;
        b=OWSr92fbBrzXNiFcIezWgcg6wiOPULsjzBv+3VCxdnd9dxTlYBOW2K6+9jy6FwOLEr
         BVkXXA1ojPtYzGxQdQn86Pph6BeHaUj/W6BgAI8WJFVWwb5i0UzgYSA9YqCOMzsX5jiW
         3TUsf9c1qOHNvxEzoL0q9/7WGkE+/g9XyIVGhRc1NJoZUHGGj5nSssIahFTc7iSzm6VX
         CmbtXK3FeLZFVsjU7G9dyN6DmVypbXM8rr+2DFIa5j2L1zesSqwUEQL1T7yqcKQsTivt
         fEglfOaFSdaxtsZRC7uXKuImBLX6tIf1bJ+5tdVxJP+ljTwGqNUtjSDpO4lU637JbBOl
         OBSQ==
X-Gm-Message-State: AOJu0Yx+t+RAad3MSlhm7S+oyemZDFIgFMy1fT/59SCfxT0xhb7cXy2g
        /rlOk9+III4/GHDrS2Yb9xYWklpAXjRqcdg3wVKu/lIRWbRB1BornFsGF9pYaYXF/m8rqALoOO0
        a9Ho+OVHbtIx+b36ZoCrRQ0Su
X-Received: by 2002:a05:651c:103c:b0:2b9:f27f:e491 with SMTP id w28-20020a05651c103c00b002b9f27fe491mr1622306ljm.42.1691160131490;
        Fri, 04 Aug 2023 07:42:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaI/lh9gaOuIoOx7Ky0rMbUoV+9sFDknqJwocsolNjo0QS7yYwKpDIVEPok64i3I1lk5JOMg==
X-Received: by 2002:a05:651c:103c:b0:2b9:f27f:e491 with SMTP id w28-20020a05651c103c00b002b9f27fe491mr1622287ljm.42.1691160131151;
        Fri, 04 Aug 2023 07:42:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u19-20020a170906125300b0099251a40184sm1396560eja.99.2023.08.04.07.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 07:42:10 -0700 (PDT)
Message-ID: <de0d09b7-1ec8-e2a4-6c52-dbc5632bcdcd@redhat.com>
Date:   Fri, 4 Aug 2023 16:42:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] extcon: cht_wc: add POWER_SUPPLY dependency
To:     Arnd Bergmann <arnd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
References: <20230804132853.2300155-1-arnd@kernel.org>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230804132853.2300155-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/4/23 15:28, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver fails to link when CONFIG_POWER_SUPPLY is disabled:
> 
> x86_64-linux-ld: vmlinux.o: in function `cht_wc_extcon_psy_get_prop':
> extcon-intel-cht-wc.c:(.text+0x15ccda7): undefined reference to `power_supply_get_drvdata'
> x86_64-linux-ld: vmlinux.o: in function `cht_wc_extcon_pwrsrc_event':
> extcon-intel-cht-wc.c:(.text+0x15cd3e9): undefined reference to `power_supply_changed'
> x86_64-linux-ld: vmlinux.o: in function `cht_wc_extcon_probe':
> extcon-intel-cht-wc.c:(.text+0x15cd596): undefined reference to `devm_power_supply_register'
> 
> It should be possible to change the driver to not require this at
> compile time and still provide other functions, but adding a hard
> Kconfig dependency does not seem to have any practical downsides
> and is simpler since the option is normally enabled anyway.
> 
> Fixes: 66e31186cd2aa ("extcon: intel-cht-wc: Add support for registering a power_supply class-device")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/extcon/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index 0ef1971d22bb0..8de9023c2a387 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -62,6 +62,7 @@ config EXTCON_INTEL_CHT_WC
>  	tristate "Intel Cherrytrail Whiskey Cove PMIC extcon driver"
>  	depends on INTEL_SOC_PMIC_CHTWC
>  	depends on USB_SUPPORT
> +	depends on POWER_SUPPLY
>  	select USB_ROLE_SWITCH
>  	help
>  	  Say Y here to enable extcon support for charger detection / control

