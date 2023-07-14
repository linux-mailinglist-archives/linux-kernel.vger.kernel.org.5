Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70FA7537D0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbjGNKTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbjGNKSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:18:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770B91989
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689329887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=96qqFzDGT6zmEWh/wldMyUAPgFi2WARkbaGaLknDDcA=;
        b=E0pA+QK0lfNA1fqbUW8KHJHIltcB4cI6sgmruahmq70cZFVJdymVYkphtPX1x4nxU4harE
        aCYK0jbLd6ik4MaO2DrXcDFTquYyIxR/4vEmZf6mOHwld5Oy+qbstnjIAM1fuxNXKzXh4l
        /f/qF+VfFPmWYsQmdOOKNfVIFJzmbHk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-NU0TN5WPNVKVVHokeMOujQ-1; Fri, 14 Jul 2023 06:18:06 -0400
X-MC-Unique: NU0TN5WPNVKVVHokeMOujQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a355c9028so96226366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689329885; x=1691921885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96qqFzDGT6zmEWh/wldMyUAPgFi2WARkbaGaLknDDcA=;
        b=c1m1yaDLUMUu/INRKUl7PXT+JwtK4jgHWa1Dh3+odm9eKJjSxQm4Ot/TDwyj3rPJEn
         pzxIUfI/oXfnfyMyOQX1DQWeNVfXeiY82snI/JYQndkhfK8ioYHz7Ow+C+a7gPGqkIjj
         gOxiqKlFAtG1Mhrh5bT8+4pSsOKK/61kGG/06Bv/8Fck2a1EXdTEssXapVuhTJpYjEXW
         pzDyBXkqeHIT5g9nZ9HsI1h/fKJL4ihWrftz7Yd8MQjYvksscRVoEpeUf1HtZROMdJny
         Tuf71kiIXBkuis25JTPvqKT7bX8qIHebIr2Hm+Zvm5THnYc5BdTACiZMdVq18zIpDNlw
         4EqA==
X-Gm-Message-State: ABy/qLalP3FW5jVPx+GM4wOd1gkTXV/ok8Mm39szt2eZsZOAJWQpNjKa
        qoA9lgB22mEhQB/3RQ4hsnTWYo01Q3mdZX8yz+tI9hddQmSd/T8cheEgvo0PAybQt/xXzhwn6SD
        nRF1vBjEnDQD2q3vu5fJRQf02
X-Received: by 2002:a17:906:10cf:b0:993:d8be:53f3 with SMTP id v15-20020a17090610cf00b00993d8be53f3mr3484732ejv.14.1689329885489;
        Fri, 14 Jul 2023 03:18:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHCJTIIyRl8+BlQ73bAXsPhvOQ7wy4rqxK16R36vhSzNRVVss/aPygJ8qwcA5idF2uURvfUbA==
X-Received: by 2002:a17:906:10cf:b0:993:d8be:53f3 with SMTP id v15-20020a17090610cf00b00993d8be53f3mr3484717ejv.14.1689329885208;
        Fri, 14 Jul 2023 03:18:05 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906a18800b0098e0a937a6asm5218411ejy.69.2023.07.14.03.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 03:18:04 -0700 (PDT)
Message-ID: <88021872-8aff-4bd2-ba95-8277a5a8e1fe@redhat.com>
Date:   Fri, 14 Jul 2023 12:18:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/3] platform/x86: simatic-ipc: add another model and
 hwmon module loading
Content-Language: en-US, nl
To:     Henning Schild <henning.schild@siemens.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
References: <20230713144832.26473-1-henning.schild@siemens.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230713144832.26473-1-henning.schild@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henning,

On 7/13/23 16:48, Henning Schild wrote:
> cahnged since v1:
>  - switch to using a list of modules per device
>  - add p3 and make the watchdog module load code use what p2 created
> 
> The first patch just adds a device that is pretty similar to another one
> we already had here.
> 
> The second patch loads modules for hwmon support, should they be
> available. That will save users the need to detect and manually load
> those modules after a machine has been clearly identified by its Siemens
> Simatic IPC station id.
> 
> And finally p3 changes another request_module call to use the mechanism
> introduced in p2.
> 
> Henning Schild (3):
>   platform/x86: simatic-ipc: add another model
>   platform/x86: simatic-ipc: add auto-loading of hwmon modules
>   platform/x86: simatic-ipc: use extra module loading for watchdog
> 
>  drivers/platform/x86/simatic-ipc.c            | 74 ++++++++++++++-----
>  include/linux/platform_data/x86/simatic-ipc.h |  1 +
>  2 files changed, 57 insertions(+), 18 deletions(-)

p.s.

Looking at the latest simatic pdx86 code:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=platform-drivers-x86-simatic-ipc

I see 5 Kconfig options and 5 .c files directly under

drivers/platform/x86/

at this point I think it would be nice to move this into its
own simatic subdir: drivers/platform/x86/simatic

with its own Makefile and Kconfig to avoid cluttering the main
drivers/platform/x86 dir and Kconfig too much.

Can you prepare a patch for this on top of:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=platform-drivers-x86-simatic-ipc

?

See:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f1e1ea516721d1ea0b21327ff9e6cb2c2bb86e28

For an example of a similar move done for Dell.

Note this example also adds

"default m"

to all options except for the main X86_PLATFORM_DRIVERS_DELL (X86_PLATFORM_DRIVERS_SIMATIC in this case) so that on interactive make config only the X86_PLATFORM_DRIVERS_SIMATIC will gets asked about and then the rest will automatically get enabled as modules.

Regards,

Hans



