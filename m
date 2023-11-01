Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7857DDF48
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjKAKVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjKAKVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B42DA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698834031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxZkGQlELPKTx4ZEkf/xjndhXilo1fuybmUWb62vNJo=;
        b=YPWCoCnCp478SmtuM3gt0l4g2eJpc9EJzD8RBmLuY4lGY80GyuqgrVy/9GnkH6lV7MYnW2
        EbB4/xBqB2uXT6RNWldXsSptmpMV/5Jx4lqCNZsXtVoKUcbFCWVA9yQMvtKKY6ztaw8XSD
        TxApCZyG9LdZLq2iTHJbjr+4z99zn14=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-XI8WEySgP_OpU1i45_5IOw-1; Wed, 01 Nov 2023 06:20:26 -0400
X-MC-Unique: XI8WEySgP_OpU1i45_5IOw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9d891685063so32884866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 03:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698834025; x=1699438825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxZkGQlELPKTx4ZEkf/xjndhXilo1fuybmUWb62vNJo=;
        b=UvHZXmUs/+oQvMGtjNpjqhqG4oUb7/PF1dQsTpwcRBb3oO+00HuGMdSI7tqrug7K2l
         +K7STgQLDE/7r6gIfRwsPvWI7/lFvwHBKE1b8JUT3/ELL1g4B+XwTqevQaNTQFqYUWWf
         dSbwCV1GkuFrOSRgp2A3Qp8ijZ4i5MdyhmvinRHZbtyKEmL0VMoRNp7F9LMcg9W8qqi8
         ti8X1Lv7sEr0IPaei9bD9IN2It1YhVIvz/2sL4BFWAN6r9mzps8KjAJ0zPDOY1Vp88B+
         Y9qb4DKd9uM+d6R/xa9k4HFJBqSldKxLco0lL2fVMrpsbPYUcbYGNI0UCm00aienBh3u
         kyKg==
X-Gm-Message-State: AOJu0YxeZB5Bcn0LTKUtyekHqNfDedjd91iswM2/V6JHq14Mx0tHdIdU
        uZzrYCdqzUoZZZqsAHxHuGy5Z1dxB0rZgADzJX/jfmsq6sA3675Ne1XPBe0/ggayWDK3Nrn3fpW
        hCN6Z7qi95+876gVm2a5vXLt9GZOjrJ+W
X-Received: by 2002:a50:ef0e:0:b0:540:9444:c281 with SMTP id m14-20020a50ef0e000000b005409444c281mr12883098eds.24.1698834025203;
        Wed, 01 Nov 2023 03:20:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx5HMtvWX7uX1/e+f0BpfFb0fDc18xYncSC48psIYMvU8Wo7A5K4aVkm5jCQ14ieNxwK4o2Q==
X-Received: by 2002:a50:ef0e:0:b0:540:9444:c281 with SMTP id m14-20020a50ef0e000000b005409444c281mr12883084eds.24.1698834024911;
        Wed, 01 Nov 2023 03:20:24 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id q29-20020a50cc9d000000b0053e2a64b5f8sm894534edi.14.2023.11.01.03.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 03:20:24 -0700 (PDT)
Message-ID: <f68dca47-d9ed-a146-b152-c19bcc9d8828@redhat.com>
Date:   Wed, 1 Nov 2023 11:20:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 6/7] drm/i915/dsi: Replace poking of CHV GPIOs behind
 the driver's back
Content-Language: en-US, nl
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
 <20231024155739.3861342-7-andriy.shevchenko@linux.intel.com>
 <ZTfssxRsrDxhzSQ6@smile.fi.intel.com>
 <b489675d-e9de-4bca-9622-78545aa8606d@redhat.com>
 <16e533e2-81bb-47ba-9e23-460a626bcad7@redhat.com>
 <ZUIbPtEEbl6pjdqg@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZUIbPtEEbl6pjdqg@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On 11/1/23 10:32, Andy Shevchenko wrote:
> On Tue, Oct 31, 2023 at 10:15:52PM +0100, Hans de Goede wrote:
>> On 10/31/23 17:07, Hans de Goede wrote:
>>> On 10/24/23 18:11, Andy Shevchenko wrote:
>>>> On Tue, Oct 24, 2023 at 06:57:38PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
>>> As for the CHT support, I have not added that to my tree yet, I would
>>> prefer to directly test the correct/fixed patch.
>>
>> And I hit the "jackpot" on the first device I tried and the code needed
>> some fixing to actually work, so here is something to fold into v3 to
>> fix things:
> 
> Thanks!
> 
> But let me first send current v3 as it quite differs to v2 in the sense
> of how I do instantiate GPIO lookup tables.

The problem is there already is a GPIO lookup table registered for
the "0000:00:02.0" device by intel_dsi_vbt_gpio_init() and there can
be only be one GPIO lookup table per device. So no matter how you
instantiate GPIO lookup tables it will not work.

The solution that I chose is to not instantiate a GPIO lookup table
at all and instead to extend the existing table with an extra entry.

Although thinking more about it I must admit that this is racy.

So a better idea would be to unregister the GPIO lookup
table registered by intel_dsi_vbt_gpio_init() after getting
the GPIOs there, that would allow instantiating a new one
from soc_exec_opaque_gpio() as it currently does and that
would be race free.

> Meanwhile I will look into the change you sent (and hopefully we can
> incorporate something in v3 for v4).

Ok, lets go with your v3.

I'll prepare a patch  to move the unregistering of the existing
conflicting GPIO lookup from intel_dsi_vbt_gpio_cleanup()
to the end of intel_dsi_vbt_gpio_init() to avoid the conflict
we have there.

Note you still need the first part of my patch which is
an unrelated bugfix:

--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -219,8 +219,7 @@ static void soc_exec_gpio(struct intel_connector *connector, const char *con_id,
 	} else {
 		gpio_desc = devm_gpiod_get_index(dev_priv->drm.dev,
 						 con_id, gpio_index,
-						 value ? GPIOD_OUT_LOW :
-						 GPIOD_OUT_HIGH);
+						 value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
 		if (IS_ERR(gpio_desc)) {
 			drm_err(&dev_priv->drm,
 				"GPIO index %u request failed (%pe)\n",

Regards,

Hans


