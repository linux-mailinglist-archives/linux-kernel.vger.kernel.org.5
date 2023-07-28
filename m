Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CBD7678CC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 01:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjG1XG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 19:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjG1XG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 19:06:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC2D2680
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 16:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690585539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UYKoF8Ks1Q67e6cOSRG114BapfSWNUAmHuoWgV7fg1k=;
        b=QCC0BaOel0FTs6pSCRCmGkuCsiWANgJlYz4U0lKO39574QIkMF4VR6EjAPQ1EKMXHcNUU8
        6DEAoqGpYWXUqtY0zyTItNKKr5vv0bjLoirzvd6mvI6JczvZ9u5q0lysy+v0QrmLfAew2A
        b9JOe/flYG6/UimMYchd/qjVs/97DcU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-WSq0HwDhOx6o8JgrLTBOeQ-1; Fri, 28 Jul 2023 19:05:37 -0400
X-MC-Unique: WSq0HwDhOx6o8JgrLTBOeQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3176ace3f58so1430499f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 16:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690585536; x=1691190336;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYKoF8Ks1Q67e6cOSRG114BapfSWNUAmHuoWgV7fg1k=;
        b=iZ/p8q6VvVUh4hz7UJSWya+NR8pGL83/pdyQG65wN71HCi5VJoF6out1/Mzp4kUPJV
         EbFG35jmDNulTfvscW/YfnQF5iI+kf/FED4nYHxyHZmCQwp7hVi2fZl2epz1utstz3WS
         hkzInzKj9t7FtLRV3m2Rnoj9KxldpE9kUvXJAe74jy30y8+zwdWvKpYo1wvv6QqewxAX
         vXmeQVgawf34tFGQnwPSMr6LV1/+nGfquuHj1ygowKKZam/Z/87C8KoB2Nn+4fuS5RQ/
         HZdCrZf6P2DGxgR17l5qF/EwHu6KDDd0smFdpMk4xIacWYY8QHsdRmUmnaDdL7CFr/WI
         9K2w==
X-Gm-Message-State: ABy/qLbMV6/60bUBprbdJLY0UhMZBZtpv8VxgUEgpz9kY6QqyFqm1Sex
        H0MooVfSB08PE7uH5jgv4fy860z9uLcDoOMllAj24zC9EvoUcmNtNMdnRKHf473Mh2zXOCwDgKk
        L2IhK5meSK7Hrat875ZU7+FTOXqhsKNQM
X-Received: by 2002:a5d:570f:0:b0:317:6f5b:2fb7 with SMTP id a15-20020a5d570f000000b003176f5b2fb7mr2789567wrv.57.1690585535956;
        Fri, 28 Jul 2023 16:05:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGaqeup1KKkFNHEx1uCh4LA2D3TrUL7PCcqpRPBbZgzdQVEdE5dFoZXTmOfccIkNlSYxmwzdA==
X-Received: by 2002:a5d:570f:0:b0:317:6f5b:2fb7 with SMTP id a15-20020a5d570f000000b003176f5b2fb7mr2789560wrv.57.1690585535608;
        Fri, 28 Jul 2023 16:05:35 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y18-20020adff152000000b0031784ac0babsm4768741wro.28.2023.07.28.16.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 16:05:35 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maya Matuszczyk <maccraft123mc@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martijn Braam <martijn@brixit.nl>, Ondrej Jirman <megi@xff.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for
 Pinephone Pro to 1.5 MB
In-Reply-To: <CAO_Mup+JZjUyQK4yC8XwgcRpDU8_TTRJT0rjFQ6OpsEU1BnbJw@mail.gmail.com>
References: <20230403175937.2842085-1-javierm@redhat.com>
 <3797122.KgjxqYA5nG@diego>
 <87pm4kuanl.fsf@minerva.mail-host-address-is-not-set>
 <4495367.TLkxdtWsSY@phil>
 <CAO_Mup+JZjUyQK4yC8XwgcRpDU8_TTRJT0rjFQ6OpsEU1BnbJw@mail.gmail.com>
Date:   Sat, 29 Jul 2023 01:05:34 +0200
Message-ID: <87fs57y6v5.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maya Matuszczyk <maccraft123mc@gmail.com> writes:

> Hi Heiko
>
> pt., 28 lip 2023 o 21:00 Heiko Stuebner <heiko@sntech.de> napisa=C5=82(a):
>>

[...]

>> So far people only reported "breaks my setup". I'm in a pickle here ;-) .
>> Without anybody saying "I want to also move into this direction" I really
>> feel I should not merge a patch that breaks other peoples setups.
>
> Well, I'd prefer 1.5M baud rate as it is more consistent with other Rockc=
hip
> boards and it makes for a much more usable terminal experience when
> logged in, it also doesn't affect boot times when serial is enabled with a
> high loglevel and console on serial as 115200 does.
>
> Though I'm just fine with using kernel's cmdline to set a baud rate.
>

Same, but also what Peter mentioned in this thread:

Peter Geis <pgwipeout@gmail.com> writes:
>
> Good Morning Heiko,
>
> The 1.5M baud is default because the clock structure on rockchip
> devices does not allow a clean 115200 baud. By attempting to force
> 115200, it will always be slightly off (either low or high depending
> on how the driver decided to round). If this actually causes any
> problems is the subject of much debate.
>
> Very Respectfully,
> Peter Geis
>

So that's another argument for setting it to 1.5M. Anyways, I'll just stop
asking for this and set my cmdline to a non-default baud rate and move on.

I was just asking in case there was a decision made on this topic.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

