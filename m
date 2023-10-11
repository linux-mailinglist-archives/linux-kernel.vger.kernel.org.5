Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6847C4ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345441AbjJKGf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345391AbjJKGfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A209B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697006073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jCqyGdsD5AcMFlVOcceMRSGgH6K4lj4Nvbst1STzOBA=;
        b=UBpD4shiv31ghvoIqsYg0G5OiMlKgFVP7zkx7KZcBaP0/2SvzUjdAWJVzczjShhTZz56p7
        tcb7zaDhzQ9bxDkzmIZlivpVZBgXKmQNdc5b+nbBwG1c9Ex5Mr1p8JG5uO+LzgNp5Dfosr
        lDJ7yGVnNYRPyBbZqEFdr1WpUeEC1YA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-0AQBa5dZOVqIcYrhh5rgJg-1; Wed, 11 Oct 2023 02:34:31 -0400
X-MC-Unique: 0AQBa5dZOVqIcYrhh5rgJg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32980f21cd4so2164591f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697006070; x=1697610870;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCqyGdsD5AcMFlVOcceMRSGgH6K4lj4Nvbst1STzOBA=;
        b=IiHGgQ2WUHQGadSTz0F++nGs/2sJ4Kszmas/2VQtJ5lPs3q8Cvk+6VBFBoeR778GFI
         VchHjs2+MXqZ+eRPWqyv04ACpBxh9vda2nFNhdtkaIXIHTgFJWidcgV0xb60DGIFsXCQ
         eHUFr+lPMGFp7QoND0U765QJ67vSDy8eAc0MgopfceVoFH+ftTAf3YscqUkoC4Xsvoko
         LfBKbz28AXh0CVEap3jIJYL1JR8NmFLozuW9WXkf8gLqaHVi8dndEKlyqGgUMmna/Ef8
         xGd2RSsPDDjlaCaVym2yP1r+FHNO3TD1/0ed8Gy12xOM+iSs/IdYh9+myrmBg5CGRkfC
         HnIQ==
X-Gm-Message-State: AOJu0YwFe4udAK4+uDfTYgfNmWqUO0dcz5rIr5uP0n84ogSOMyS8QHZo
        oadQHn34gRllYUGRycElZ2oEbbcXFgPYXhubqOH/y0wgkOEISBes9Mjo+BS3wHCrKs5E8yrPMcn
        dQ3a+FRoZvYTwZSRxZEAehTBv
X-Received: by 2002:adf:8bde:0:b0:32c:e910:b69f with SMTP id w30-20020adf8bde000000b0032ce910b69fmr3104148wra.56.1697006070740;
        Tue, 10 Oct 2023 23:34:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn1mtTeV29rnDa6jf79nXH+N2kbU5qoJT18TCRs5EkAnTEIyRFWTjc0V0TBxpSuSsrLcZUkg==
X-Received: by 2002:adf:8bde:0:b0:32c:e910:b69f with SMTP id w30-20020adf8bde000000b0032ce910b69fmr3104127wra.56.1697006070424;
        Tue, 10 Oct 2023 23:34:30 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d4903000000b0031fa870d4b3sm14382993wrq.60.2023.10.10.23.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 23:34:29 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 8/8] dt-bindings: display: Add SSD132x OLED controllers
In-Reply-To: <20231010-headache-hazard-834a3338c473@spud>
References: <20231009183522.543918-1-javierm@redhat.com>
 <20231009183522.543918-9-javierm@redhat.com>
 <20231010-headache-hazard-834a3338c473@spud>
Date:   Wed, 11 Oct 2023 08:34:29 +0200
Message-ID: <87y1g9sm4q.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley <conor@kernel.org> writes:

Hello Conor,

Thanks a lot for your feedback.

> Hey,
>
> On Mon, Oct 09, 2023 at 08:34:22PM +0200, Javier Martinez Canillas wrote:

[...]

>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - enum:
>> +          - solomon,ssd1322
>> +          - solomon,ssd1325
>> +          - solomon,ssd1327
>
> You don't need the oneOf here here as there is only the enum as a
> possible item.

Indeed. I'll fix that in v2.

> I didn't get anything else in the series, I have to ask - are these
> controllers not compatible with eachother?
>

They are not, basically the difference is in the default width and height
for each controller. That's why the width and height fields are optional.

But other than the default resolution, yes the controllers are very much
the same.

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +
>> +  # Only required for SPI
>> +  dc-gpios:
>> +    description:
>> +      GPIO connected to the controller's D/C# (Data/Command) pin,
>> +      that is needed for 4-wire SPI to tell the controller if the
>> +      data sent is for a command register or the display data RAM
>> +    maxItems: 1
>> +
>> +  solomon,height:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Height in pixel of the screen driven by the controller.
>> +      The default value is controller-dependent.
>
> You probably know better than me, operating in drm stuff, but are there
> really no generic properties for the weidth/height of a display?
>

There are some common properties, such as the width-mm and height-mm for
the panel-common:

Documentation/devicetree/bindings/display/panel/panel-common.yaml

But those are to describe the physical area expressed in millimeters and
the Solomon drivers (the old ssd1307fb fbdev driver and the new ssd130x
DRM driver for backward compatibility with existing DTB) express the width
and height in pixels.

That's why are Solomon controller specific properties "solomon,width" and
"solomon,height".

[...]

>> +    then:
>> +      properties:
>> +        width:
>> +          default: 128
>> +        height:
>> +          default: 128
>
> Unless you did it like this for clarity, 2 of these have the same
> default width and 2 have the same default height. You could cut this
> down to a pair of if/then/else on that basis AFAICT.
> :wq
>

Yes, this was done like that for clarity. Because is easier for someone
reading the DT binding schema to reason about resolution (width,height)
for a given SSD132x controller, rather than following the if/else logic.

>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            ssd1327_i2c: oled@3c {
>
> This label is unused as far as I can tell. Ditto below.
>

Right, I'll drop those too.

> Cheers,
> Conor.
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

