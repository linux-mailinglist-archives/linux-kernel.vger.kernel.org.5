Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6086E7C4BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345097AbjJKHfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344641AbjJKHfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B21F92
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697009672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PT6Sw/x4JIJ/TiIyhjM4l1jVYrrCLNDF9k0rE6BJkQw=;
        b=chuoiV0VqFMTKQ5zoKLV6pB7cCE0j6BGryVfgc+vwjFKHeVzRZvAlOCOcG3P4zwFVzwMsU
        7ak96X42Bqwkgi9uwxyYvNKZqz0GXgKD9lwWOE9hUe3YosXXItO+YYm0iRjiLFJh5ycSUQ
        X8j923ywtuWLBpNJF0hkTYBczHh0mPU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-hKMwcZ80N7m5UxZjgefceQ-1; Wed, 11 Oct 2023 03:34:30 -0400
X-MC-Unique: hKMwcZ80N7m5UxZjgefceQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fef5403093so2960805e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697009669; x=1697614469;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PT6Sw/x4JIJ/TiIyhjM4l1jVYrrCLNDF9k0rE6BJkQw=;
        b=biL1bPKNOgczkiD254ppoiUoHkI64UUAvcEdPkl6fI7FjaUKnIi3R+OF7rQ5Crev4/
         qyMFXpMTEiF39kvrwnlnJe3c12Ob5JwnVe9w+PjSQ4OsNFManZnAqg9g0YuO8mv5XuvC
         JMUJ2TDMdLSRZlMvTV4tuxBgfomFqZjTCjh/+T+Oa+2yXsor8to5zboQA1Z39WCM+c/s
         SA6qfXLusG3NpL0hCcNttWyC7DKwwwomjv9qUllJ4OkkhjAT7VMZOrFNA+zIhIerVVuF
         cSYzPb62MYEKKnFkbbdK1C5/cjT6HXzS8mkubjPrdWP0lkMWvSXmvt9ervl2XcRE/7JW
         KsQw==
X-Gm-Message-State: AOJu0YyX2uTAYbu34BH2V5uy/0xuZJetaCPfzuwzjPrd/gEmVyeXT4EY
        O4nsAkWr8p6tS5gIxm1v8pW/xYPpJ1p3ceTI3XYJQyLFe54lHN65ZoUES4+W2ZtGhXcIOVev77U
        VgWmlttHlyc8Ns1RC4S9Mdhh9
X-Received: by 2002:a05:600c:827:b0:405:2d29:1648 with SMTP id k39-20020a05600c082700b004052d291648mr13461808wmp.19.1697009669620;
        Wed, 11 Oct 2023 00:34:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsejCRRnJRskgCxuslOB4PnR/uGl69Os7lgF/uOLkrZgLkZeJMtWHRM0lwrPP4gwBR56jZDQ==
X-Received: by 2002:a05:600c:827:b0:405:2d29:1648 with SMTP id k39-20020a05600c082700b004052d291648mr13461784wmp.19.1697009669247;
        Wed, 11 Oct 2023 00:34:29 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f19-20020a7bc8d3000000b00405959469afsm16076183wml.3.2023.10.11.00.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 00:34:28 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 8/8] dt-bindings: display: Add SSD132x OLED controllers
In-Reply-To: <87v8bdslx7.fsf@minerva.mail-host-address-is-not-set>
References: <20231009183522.543918-1-javierm@redhat.com>
 <20231009183522.543918-9-javierm@redhat.com>
 <20231010165838.GA1039918-robh@kernel.org>
 <87v8bdslx7.fsf@minerva.mail-host-address-is-not-set>
Date:   Wed, 11 Oct 2023 09:34:28 +0200
Message-ID: <87sf6hsjcr.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

> Rob Herring <robh@kernel.org> writes:
>
> Hello Rob,
>
> Thanks a lot for your feedback.
>
>> On Mon, Oct 09, 2023 at 08:34:22PM +0200, Javier Martinez Canillas wrote:
>>> Add a Device Tree binding schema for the OLED panels based on the Solomon
>>> SSD132x family of controllers.
>>
>> Looks like the same binding as solomon,ssd1307fb.yaml. Why a different 
>> binding? Why does that binding need a slew of custom properties and here 
>> you don't?
>>
>
> It's a sub-set of it. Because only the minimum required properties are
> defined. But also, is a clean slate schema because the old ssd1307fb fbdev
> driver only supports the Solomon SSD130x family, so there is no need to
> follow the existing solomon,ssd1307fb.yaml nor the need for backward compat.
>

I think this answer was a little sparse, let me elaborate a bit. The Solomon
display controllers are quite flexible, so that could be used with different
OLED panels.

And the ssd1307fb binding schema defines a set of properties that are almost
a 1:1 mapping from properties to the configuration registers. This makes the
driver to support most SSD130x controller + panel configurations but at the
expense of making the binding more complicated (a slew of custom propertie
as you pointed out).

Now, as mentioned this is support for greyscale Solomon controllers (the old
fbdev driver only supports monochrome controllers) so we don't care about DT
backward compatibility.

I decided for now to keep the binding at a minimum and be more opinionated in
the driver with having what I think are sane defaults for most of the config
registers.

If there is a need to expose any of this configuration as DT properties, then
we can later added it share some of the existing solomon,ssd1307fb.yaml custom
properties and move them to a common schema.

We can always change the driver in the future anyways, but we can't do the same
with the DT binding schema since that is considered an ABI.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

