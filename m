Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99507EDD30
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjKPI6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKPI6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:58:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0740CA1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700125091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lzR95smyeeh/FiV11pRQQl93svK/jp4ut938ur2cfQs=;
        b=E7VX5Y16lWuy9+OZjcjepIinHnPyIAgtLkpUnhwqydD0ciKehLoDh1rQjOSrHbpunfYzOt
        c7TWcBqVno9/nTwBtL2Wd3R5wnz72ktdBiUTVw7De1sFURw/h+M8oJAmfl5iQhzpG/hIwj
        pdd1FN2bs8eMfe3mjNx/n+HinggweVc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-mktYOBE6O8SM0vqJ2zonUA-1; Thu, 16 Nov 2023 03:58:09 -0500
X-MC-Unique: mktYOBE6O8SM0vqJ2zonUA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-53dfe3af1b9so400676a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:58:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700125088; x=1700729888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzR95smyeeh/FiV11pRQQl93svK/jp4ut938ur2cfQs=;
        b=ZBdykD6fpNMnz6plV+kRjk9+yhwp8nQqgVz0jRPn6ZF+IUrQToQ93MUfe6i3pK6T5d
         V3J1tSTITF7sqtBJ9EszD30mMgNSf2cm8zEgTuqn+6UNIZ6OjhsInYDEArjyW4jdoDDN
         ks02Fooi2Ga0v2m0cDiYfda+2nR6YnsPaMIqPQbinlWIf2XePVLdhQhBSNQPptdGHXCv
         uotrNbriCcGs8/YqZyOMXYZ9gJCYCuL7aqMzu8zxW3VZuyVDoOZv4N1a+Lt0WYOreJwX
         kVzz4puqYopMCe2BNJ2xijvskRR+4BgfgjNBCzwm1upCTlSQwVc96KTA2GCVMjM+cCCO
         xwXw==
X-Gm-Message-State: AOJu0YyaBkv9oQKOQmlq94kwvrV0FPnbqFxVH8ZQwDrXp2H7+TsHZoYi
        +K6uuxKsO83sLmm7CgnBPCaod17MyhSlsmkyvZA1h+Kk8RjprSDloC+g8SIwiCvdUXg9Zx3kehn
        iaPzaLPrIeX7uYfLkDOZGYE2u
X-Received: by 2002:aa7:d4c2:0:b0:543:9670:7ee8 with SMTP id t2-20020aa7d4c2000000b0054396707ee8mr11227124edr.14.1700125088222;
        Thu, 16 Nov 2023 00:58:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeO8Z4VQxOJHWlez75/PPOrqNzsKmQn04wP1vApaXiXcOExOZBZFeAqXryegrjIC2O0lA3eA==
X-Received: by 2002:aa7:d4c2:0:b0:543:9670:7ee8 with SMTP id t2-20020aa7d4c2000000b0054396707ee8mr11227112edr.14.1700125087921;
        Thu, 16 Nov 2023 00:58:07 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id v6-20020a056402174600b00530a9488623sm7474432edx.46.2023.11.16.00.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 00:58:07 -0800 (PST)
Message-ID: <e66638b0-bbad-4ac7-ad93-6fb0c6147005@redhat.com>
Date:   Thu, 16 Nov 2023 09:58:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [rft, PATCH v4 00/16] drm/i915/dsi: 4th attempt to get rid of
 IOSF GPIO
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20231103201831.1037416-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231103201831.1037416-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/3/23 21:18, Andy Shevchenko wrote:
> DSI code for VBT has a set of ugly GPIO hacks, one of which is direct
> talking to GPIO IP behind the actual driver's back. A second attempt
> to fix that is here.
> 
> If I understood correctly, my approach should work in the similar way as
> the current IOSF GPIO.
> 
> Hans, I believe you have some devices that use this piece of code,
> is it possible to give a test run on (one of) them?

Ok, this now has been testen on both a BYT and a CHT device which
actually use GPIO controls in their MIPI sequences so this
series is:

Tested-by: Hans de Goede <hdegoede@redhat.com>

And the code of the entire series also looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans




> In v4:
> - fixed compile time errors in patch 14 (Hans, LKP)
> - fixed cover letter Subject
> - added patch 15 (as suggested by Ville)
> - added Ack tag (Jani)
> 
> In v3:
> - incorporated series by Jani
> - incorporated couple of precursor patches by Hans
> - added Rb tag for used to be first three patches (Andi)
> - rebased on top of the above changes
> - fixed indexing for multi-community devices, such as Cherry View
> 
> In v2:
> - added a few cleanup patches
> - reworked to use dynamic GPIO lookup tables
> - converted CHV as well
> 
> Andy Shevchenko (9):
>   drm/i915/dsi: Replace while(1) with one with clear exit condition
>   drm/i915/dsi: Get rid of redundant 'else'
>   drm/i915/dsi: Replace check with a (missing) MIPI sequence name
>   drm/i915/dsi: Extract common soc_gpio_set_value() helper
>   drm/i915/dsi: Replace poking of VLV GPIOs behind the driver's back
>   drm/i915/dsi: Prepare soc_gpio_set_value() to distinguish GPIO
>     communities
>   drm/i915/dsi: Replace poking of CHV GPIOs behind the driver's back
>   drm/i915/dsi: Combine checks in mipi_exec_gpio()
>   drm/i915/iosf: Drop unused APIs
> 
> Hans de Goede (2):
>   drm/i915/dsi: Remove GPIO lookup table at the end of
>     intel_dsi_vbt_gpio_init()
>   drm/i915/dsi: Fix wrong initial value for GPIOs in
>     bxt_gpio_set_value()
> 
> Jani Nikula (5):
>   drm/i915/dsi: assume BXT gpio works for non-native GPIO
>   drm/i915/dsi: switch mipi_exec_gpio() from dev_priv to i915
>   drm/i915/dsi: clarify GPIO exec sequence
>   drm/i915/dsi: rename platform specific *_exec_gpio() to
>     *_gpio_set_value()
>   drm/i915/dsi: bxt/icl GPIO set value do not need gpio source
> 
>  drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 355 +++++++------------
>  drivers/gpu/drm/i915/vlv_sideband.c          |  17 -
>  drivers/gpu/drm/i915/vlv_sideband.h          |   3 -
>  3 files changed, 136 insertions(+), 239 deletions(-)
> 

