Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1297DD136
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344942AbjJaQIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344803AbjJaQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8128CB4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698768475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=thpxtjONj4QTupD90Q3EZvagp9KsKzzPeE2dqPNx7k0=;
        b=OOIOU6E54G6e1JDS34jzGdpp0YTLzWyZPqwVqu2ZtVtKVDmWQuDqlJq49LNb/7LrGH8s6K
        vLxduC/hg/63LRFgqpJEltiA51JGACf1aadK2jQ7cpypBcToQRbdJjHbP6yEArvpKX8ra1
        ebdAzapvOTQ0o3sqE33VjSzlguTFlJA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-bTYHjEmsNAuk1L4-vIU30A-1; Tue, 31 Oct 2023 12:07:43 -0400
X-MC-Unique: bTYHjEmsNAuk1L4-vIU30A-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9d216597f5fso218405166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698768462; x=1699373262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thpxtjONj4QTupD90Q3EZvagp9KsKzzPeE2dqPNx7k0=;
        b=oZ/IjrV3BOIbCiaQmPltuJvUC0zEVPzejXPBfwxdtpxVzzM+USNFIjwA9PorUHjfdC
         cu7m0IN/f9ubGlm3aTj+XywBfmK9sdgQNvb3obuPtw/u68YoLVVVQoDqKE3PaATaYjEt
         AL+fMz6BEfX86V9dhwZWCKzkARXkbEL6m6ZW51UUczxiVu/vj8fcfOgiEuEwB4G0u2XK
         F4t2Bcjpyx5dPvOpRxIMBp26fYgk+soJaKGE5FHdwmg5kw2Gfy+vtfGINU7O/R+gE8zE
         5oB2UFxhartC9flRc9+TM1Q+qH6OYGCxmcMxsxghlpsy2j797PvyVNLemHE7R+WWR5X1
         URiA==
X-Gm-Message-State: AOJu0YwmsVk8X8MlU2hNDG2BmN1YBXrHHzCK6rbAa3VjCC+WR575HO6/
        bQM3YNpXE2x6Nq5+tyL338v7JP3RQiL+ZusJirDcTyhS7Vqz0PX3WJPTRPndVZxgc/5ij5eyKf0
        RC4sYdWxLcql/WZ1T0A1Ypvfo
X-Received: by 2002:a17:906:4784:b0:9ad:e180:16e3 with SMTP id cw4-20020a170906478400b009ade18016e3mr12240289ejc.37.1698768461849;
        Tue, 31 Oct 2023 09:07:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDV51Onpp+gtuqKcZZe8kMiLqbF3dH6IJu74qigRPDiD5Lk35IqZsmbryB7ATZnw7t7AJDEQ==
X-Received: by 2002:a17:906:4784:b0:9ad:e180:16e3 with SMTP id cw4-20020a170906478400b009ade18016e3mr12240270ejc.37.1698768461497;
        Tue, 31 Oct 2023 09:07:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:6c4:9fb2:fbc:7029? (2001-1c00-2a07-3a01-06c4-9fb2-0fbc-7029.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:6c4:9fb2:fbc:7029])
        by smtp.gmail.com with ESMTPSA id fy23-20020a170906b7d700b009b2f2451381sm1187507ejb.182.2023.10.31.09.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 09:07:40 -0700 (PDT)
Message-ID: <b489675d-e9de-4bca-9622-78545aa8606d@redhat.com>
Date:   Tue, 31 Oct 2023 17:07:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] drm/i915/dsi: Replace poking of CHV GPIOs behind
 the driver's back
Content-Language: en-US
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
References: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
 <20231024155739.3861342-7-andriy.shevchenko@linux.intel.com>
 <ZTfssxRsrDxhzSQ6@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZTfssxRsrDxhzSQ6@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 10/24/23 18:11, Andy Shevchenko wrote:
> On Tue, Oct 24, 2023 at 06:57:38PM +0300, Andy Shevchenko wrote:
>> It's a dirty hack in the driver that pokes GPIO registers behind
>> the driver's back. Moreoever it might be problematic as simultaneous
>> I/O may hang the system, see the commit 0bd50d719b00 ("pinctrl:
>> cherryview: prevent concurrent access to GPIO controllers") for
>> the details. Taking all this into consideration replace the hack
>> with proper GPIO APIs being used.
> 
> Ah, just realised that this won't work if it happens to request to GPIOs with
> the same index but different communities. I will fix that in v3, but will wait
> for Hans to test VLV and it might even work in most of the cases on CHV as it
> seems quite unlikely that the above mentioned assertion is going to happen in
> real life.

I have added patches 1-5 to my personal tree + a small debug patch on top
which logs when soc_exec_opaque_gpio() actually gets called.

So these patches will now get run every time I run some tests on
one my tablets.

I'll get back to you with testing results when I've found a device where
the new soc_exec_opaque_gpio() actually gets called.

As for the CHT support, I have not added that to my tree yet, I would
prefer to directly test the correct/fixed patch.

Regards,

Hans

