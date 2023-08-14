Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB90077B4AE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjHNIwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjHNIvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B065C10C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692003062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a3gcnZKLEd0/sP/frTnZUie+RYs1JML9llgGix/2OeI=;
        b=BDtudxCKoiSlWOVtjtB8I12pknLBKC+/VnW7YL1eVTlPDM8IKQUAF19oNUM1oQG/7+KWeI
        Eb5sqFUP0SSVzfJJoKMMVNZwtOM3hINgen/VICc81GCbJAC3qL7HhOoEMj0lANRrVnK67P
        sshURZATSvpKON/6vJHdzKk12/N5me0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-iCgkn7bDOQCe4i0Zf9EFKQ-1; Mon, 14 Aug 2023 04:51:00 -0400
X-MC-Unique: iCgkn7bDOQCe4i0Zf9EFKQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99bcf6ae8e1so251787166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692003059; x=1692607859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3gcnZKLEd0/sP/frTnZUie+RYs1JML9llgGix/2OeI=;
        b=hVFdkJQoWK1Qsjq36Vpt5gAUu6RADuQ0k/nlpIWwraJPsb6OdQjojjctBPGc2wQSPZ
         kDu9kck2oql75Hr1cn8jlzEg2egab57dDy0sKHaU9Ec0HKdJwtpgkQZ9EAXUbWSYasWI
         3b2Ok6yjjINinhrtmiGHjnf4gI9xzXd+jmVJnEsgdhBBRgImJlNEjC/FccDTrwMMy9zj
         IVngay5pcKS+AreVsCWlpiLFnWbPfRKy8JOXF86UOqIX68MxJKStXbv2eYDqM+TLZlw7
         VDLB7dNGcFBH/pA1bqbrP4SM6NrHwQ12XrKLfiX0Nt9YS44vrKDvqZZeu2m9lrhDn+fe
         vNtQ==
X-Gm-Message-State: AOJu0YwRw5HHwDURFjpxSSGacr/SLWZSpXeyxRLUSbibhfM45+NMpRA0
        Cd1B3UwESHCkP+1vLUczJzoe7ps2ELcMl9lcilt/4zoONzY5Zg+g33tkd2G0EQKBKQ/iXA7uCSQ
        B5SZrGm8A4B1upFkevCkUpjxY
X-Received: by 2002:a17:906:1daa:b0:988:a986:b11c with SMTP id u10-20020a1709061daa00b00988a986b11cmr6559170ejh.29.1692003059412;
        Mon, 14 Aug 2023 01:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETTCjSXNj0S0mhYm5hz+lr/D6808KX57i2K5b+YUbNVOxibyLYE1n7UQOJHnQKm4MQyNw7Rg==
X-Received: by 2002:a17:906:1daa:b0:988:a986:b11c with SMTP id u10-20020a1709061daa00b00988a986b11cmr6559162ejh.29.1692003059152;
        Mon, 14 Aug 2023 01:50:59 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b00993a37aebc5sm5399887ejb.50.2023.08.14.01.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 01:50:58 -0700 (PDT)
Message-ID: <672725bc-6ebf-0a35-96ab-8862be7de193@redhat.com>
Date:   Mon, 14 Aug 2023 10:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] watchdog: simatic: add PCI dependency
Content-Language: en-US, nl
To:     Arnd Bergmann <arnd@arndb.de>, "xingtong.wu" <xingtong_wu@163.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Haeussler, Gerd" <gerd.haeussler.ext@siemens.com>,
        "Schaffner, Tobias" <tobias.schaffner@siemens.com>,
        "xingtong.wu" <XingTong.Wu@siemens.com>
References: <20230814073924.1066390-1-arnd@kernel.org>
 <a6c2f193-ef7c-54a0-dfbb-13915be259a1@163.com>
 <1834eee9-3fbd-4bea-9e22-960ca993303c@app.fastmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1834eee9-3fbd-4bea-9e22-960ca993303c@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/14/23 10:48, Arnd Bergmann wrote:
> On Mon, Aug 14, 2023, at 10:27, xingtong.wu wrote:
> 
>>>  
>>>  config SIEMENS_SIMATIC_IPC_WDT
>>>  	tristate "Siemens Simatic IPC Watchdog"
>>> -	depends on SIEMENS_SIMATIC_IPC
>>> +	depends on SIEMENS_SIMATIC_IPC && PCI
>>
>> The SIEMENS_SIMATIC_IPC_WDT does not depends on PCI directly,
>> it should depends on P2SB, then P2SB depends on PCI
>>
>>>  	default y
>>>  	select WATCHDOG_CORE
>>>  	select P2SB
>>
>> You can replace the "select" to "depends on" instead.
> 
> That would also work, but it's generally best not to mix
> 'depends on' and 'select' for the same symbol. Changing
> all three 'select P2SB' to 'depends on P2SB', or removing
> the prompt to turn P2SB itself into a hidden symbol is
> probably a good follow-up patch, but I'd keep that separate
> from the regression fix.

Right P2SB would benefit from being changed into a hidden
symbol.

Andy, any comments on making P2SB a hidden symbol ?

Regards,

Hans


> 
>      Arnd
> 

