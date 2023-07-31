Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C39B76967B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjGaMiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjGaMhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:37:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28940E46
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690807016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GOFjSuz+nzO0XVUy4hfdNTLjsQdAMvC2f0+2gyXsjM0=;
        b=fkC/aUVNYpE64JurGvOthZoMjJ2Qfn+QqSzfw6CsweSjTEurZwtijdkqvdcKER2eR4Cjs9
        1S+L9a4SbfJRcAsv29chJugimdt4I0R2wSdLnRNeKAcsF+BY35GJiSJe7kakoccOrrNjcf
        iEeEDfSm6vba5gEQ2oiQIGs9+DG5mOY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-PEU2YiWHN9CF6xkI5coRpA-1; Mon, 31 Jul 2023 08:36:55 -0400
X-MC-Unique: PEU2YiWHN9CF6xkI5coRpA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51bef8bb689so7606032a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690807013; x=1691411813;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOFjSuz+nzO0XVUy4hfdNTLjsQdAMvC2f0+2gyXsjM0=;
        b=axyqcYLfZkL8bzUNtA5if7jv9dsuLVfWby+c2VF6h9keELgf6Kqxbjune497eakJ1N
         QqBEcLOmG27mQM63hjckMVrHUAEvbV3qVgQ/H9IimPX1ST2MYeKJKZWb0GXQ6CUoP6BA
         CRNKJFpTQiFUcaGxl26ItdY7j3aHWh8eX0BFZXwqHM1rVHayonHsihYElFFtvUMeZU58
         OxSc58oP/Tudk4Wnq6+InyWTIJ8MHh96mXsybyPlomOmUWMHivOhYRTEm536hQg4wyAP
         x5XwiTNSVwH+FA6kWOPY2M5M0vxY/0sT+I1TBxqzOuRBgif0n2QZOhVd7B7xJb6ZDYKj
         cirA==
X-Gm-Message-State: ABy/qLbShzlP4pkr9woG6lCWlfePOG4voJH6kff+OVSwX6z3zxY0G0O0
        /x+uKahOW49BZVCOmjIRD1VPtNcZEUgCH+9EpTYIBZDSPyf89eRv/iMld/MgT9swvEs3CgbQ5Ea
        KNp+15thpFsE5bCbalC2wKgpYhH22OWpO
X-Received: by 2002:a50:ea82:0:b0:522:3a54:1c05 with SMTP id d2-20020a50ea82000000b005223a541c05mr11936280edo.5.1690807013574;
        Mon, 31 Jul 2023 05:36:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEsWInA7GJjO2YOR6fGzgFfUxuF4KQw7pGEuJcvlvlcgQUSMGtQLI2sVc55Zur0oqFTTno/Dw==
X-Received: by 2002:a50:ea82:0:b0:522:3a54:1c05 with SMTP id d2-20020a50ea82000000b005223a541c05mr11936260edo.5.1690807013228;
        Mon, 31 Jul 2023 05:36:53 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id y19-20020aa7ccd3000000b0051d9ee1c9d3sm5370905edt.84.2023.07.31.05.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 05:36:52 -0700 (PDT)
Message-ID: <aea56ab4-e965-204c-4df1-040323c341f9@redhat.com>
Date:   Mon, 31 Jul 2023 14:36:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3] platform/x86: simatic-ipc: add another model
 BX-56A/BX-59A
Content-Language: en-US
To:     xingtong_wu@163.com, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, lee@kernel.org,
        xingtong.wu@siemens.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gerd Haeussler <gerd.haeussler@t-online.de>
References: <20230731071424.4663-1-xingtong_wu@163.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230731071424.4663-1-xingtong_wu@163.com>
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

Hi,

On 7/31/23 09:14, xingtong_wu@163.com wrote:
> From: "xingtong.wu" <xingtong.wu@siemens.com>
> 
> These are patches adding features for another Simatic IPC model
> BX-56A/BX-59A, features for led and battery monitor are involved.
> 
> Based on:
>  [PATCH v2 0/3] platform/x86: move simatic drivers into subdir
>  [PATCH v2 0/2] leds: simatic-ipc-leds-gpio: add new model BX-21A
>  [PATCH 0/2] platform/x86/siemens: fixes for CMOS battery hwmon
> 
> xingtong.wu (3):
>   platform/x86: simatic-ipc: add new models BX-56A/BX-59A
>   leds: simatic-ipc-leds-gpio: add support for module BX-59A
>   batt: simatic-ipc-batt: add support for module BX-59A

Thank you. I have merged patches 1/3 and 3/3 into
the platform-drivers-x86-simatic-ipc branch now:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=platform-drivers-x86-simatic-ipc

Lee, I'll send you a pull-req for an immutable tag so that you
can merge 2/3 into lee/leds.git .

Once I've run some tests on this branch the patches there will be
merged into the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans






> 
>  .../leds/simple/simatic-ipc-leds-gpio-core.c  |  1 +
>  .../simple/simatic-ipc-leds-gpio-f7188x.c     | 42 ++++++++++++++++---
>  drivers/platform/x86/siemens/Kconfig          |  1 +
>  .../x86/siemens/simatic-ipc-batt-f7188x.c     | 37 +++++++++++-----
>  .../platform/x86/siemens/simatic-ipc-batt.c   |  3 +-
>  drivers/platform/x86/siemens/simatic-ipc.c    | 12 +++++-
>  .../platform_data/x86/simatic-ipc-base.h      |  1 +
>  include/linux/platform_data/x86/simatic-ipc.h |  2 +
>  8 files changed, 80 insertions(+), 19 deletions(-)
> 

