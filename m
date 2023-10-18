Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35287CD796
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjJRJKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjJRJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:10:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B378DF9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697620181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUJES4xzz4OgYhBm0mkytoX+dUxjIQDJlTwNvCoMkHk=;
        b=N9KDm+nxYIRjaC35Akp+5e4Ni6fvN5bsCuIjtw2E4rPUuv3GTgreyEoOcFW/eRFxlR94fy
        hsStxWGWWIbDVS92xXnt9aCyZ+ij132q3nOFthO6EAhe53IBwhKpBPLdsSancNsTBDxrYQ
        TndN345F+hA8ArYKZP46KDTpHn0MZ58=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-4ftOwzWwNvyOMy1TAMXUUQ-1; Wed, 18 Oct 2023 05:09:38 -0400
X-MC-Unique: 4ftOwzWwNvyOMy1TAMXUUQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51da39aa6dcso5001414a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697620177; x=1698224977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUJES4xzz4OgYhBm0mkytoX+dUxjIQDJlTwNvCoMkHk=;
        b=HFwIhkQ4FvAjBb0CjZCzY6EexHbZyk3OIT8izHp4SYyeCOZ0HrHVmFkxyRFnDhqXHv
         WrfgAEIhwwHcSobWYfZD8UxVgjC4wGzxT/qAs72joFzkAIdKetFDF5rve7s/g5FNYFvQ
         osvBwrv53gHcaGvYZOFu1lz5AoZQTzC1sEYbk4Me/J1iozEy+ozrzcRcj0+vznicFSi8
         PHH32VESjG2maJ9deKFNnlkRUX7Cl5hHikKBQd6pXE7o2BN67GQ0bH/3udpJ9tyBtX9A
         SOSuV4HTHo8hgqarxSFm/Bcc5z/PRDn7+1Sj38aQh8UQofhNkcRe+Oryu0U345G3AxtM
         RRiQ==
X-Gm-Message-State: AOJu0YwulwsTqJJfU3IFEXC0zIsqQkw9NDfz956vinzFFTJNtinBFjxh
        YkPXV7wXjA3TFqe3su/Iw3v1P62aQQzzd2WmYSq8CLfJx2rGP5gcmSg3tI9wVjwTwhsvw5zzjgj
        NhMKgVxzTbUikGym621NFZ2L/
X-Received: by 2002:a17:906:dc89:b0:9bd:7f40:caa5 with SMTP id cs9-20020a170906dc8900b009bd7f40caa5mr3528473ejc.77.1697620177547;
        Wed, 18 Oct 2023 02:09:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKHi8O4GH1i87FLH4zCOBGCozeaNzeB8YR07/3Ub04FKBzLRHFthyISjh4iNR2VFpoqq1Z6w==
X-Received: by 2002:a17:906:dc89:b0:9bd:7f40:caa5 with SMTP id cs9-20020a170906dc8900b009bd7f40caa5mr3528452ejc.77.1697620177179;
        Wed, 18 Oct 2023 02:09:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709060ac500b009b65a834dd6sm1229567ejf.215.2023.10.18.02.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 02:09:36 -0700 (PDT)
Message-ID: <0c88666a-ff36-b649-d244-ccce500b6c2f@redhat.com>
Date:   Wed, 18 Oct 2023 11:09:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [rft, PATCH v1 0/2] drm/i915/dsi: An attempt to get rid of IOSF
 GPIO on VLV
Content-Language: en-US, nl
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
References: <20231018051052.1328852-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231018051052.1328852-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 10/18/23 07:10, Andy Shevchenko wrote:
> DSI code for VBT has a set of ugly GPIO hacks, one of which is direct
> talking to GPIO IP behind the actual driver's back. An attempt to fix
> that is here.
> 
> If I understood correctly, my approach should work in the similar way as
> the current IOSF GPIO. 
> 
> Hans, I believe you have some devices that use this piece of code,
> is it possible to give a test run on (one of) them?

Yes I should be able to find a device or 2 which poke GPIOs from the
VBT MIPI sequences. Unfortunately I don't know from the top of my head
which devices actually use this, so I may need to try quite a few devices
before finding one which actually uses this.

I'll try to get this series tested sometime the coming weeks,
depending on when I can schedule some time for this.

Regards,

Hans




> 
> Andy Shevchenko (2):
>   drm/i915/dsi: Extract common soc_gpio_exec() helper
>   drm/i915/dsi: Replace poking of VLV GPIOs behind the driver's back
> 
>  drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 150 +++++++------------
>  1 file changed, 58 insertions(+), 92 deletions(-)
> 

