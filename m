Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8677DA1A0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 22:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346376AbjJ0UIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 16:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0UIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 16:08:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747481AA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 13:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698437272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TKT2siFILLclNs7DXkgdMslrVPbCgf+UzQ9e1S29k4Y=;
        b=LKalK66+b+2o3mk/MXoVVbJh8vxyRvw0Ejw42m8ryF2pu7I0A2qrvvQSlSHDzdxpaEVYnX
        o+hDXtavddJa42hbJDgWEJAPXbbqOpl7T5yIvE8BnDPU53UHKS7xHuxCqdhBQJK5bzceHk
        /EwoGThOO9sLNPmJApNldMl0jqFRwPE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-SrJO7tu2N4i6d0mLQh3TMw-1; Fri, 27 Oct 2023 16:07:51 -0400
X-MC-Unique: SrJO7tu2N4i6d0mLQh3TMw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32d9b520d15so1256670f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 13:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698437270; x=1699042070;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKT2siFILLclNs7DXkgdMslrVPbCgf+UzQ9e1S29k4Y=;
        b=XoZlOdqNep3qA9GMUZE0wX38SM74poZtsVIZ0W1hxcy6R3yBE0lHVYTVFbE+67FD5s
         2oJlMRtcPzISotd54Irecfgd4EeDmjocXqW8X8SFI5/9QCwSBeRQAY0o5gnOUZOJ5YV6
         B04WnWEX5UUrcAU4bJ6o0noMTSgUCi9YUJoxfNR4YzE4BZn+ER9orLqMvv1ISwi3d+Dp
         qFsUF4NDzh04UZctiK+lY3v8DUnU7MVyi9ubX/kPXdeJblvqwxSp1mMQyHhS/cOwawPx
         piBoT6NeeexEou6azkN8HCyor4ZA/uSHXBYOu5mX73kM+ZuEvl5WwzNrkxgKLp1RII+o
         ydiA==
X-Gm-Message-State: AOJu0YzFLs9vfGehjNPtToDW48vXKbf0/Bc1VOSqOUZUHPrqbTo7ngD7
        T8eHSK2VCxZF9/Bru5GZyC57/PpBsRZOB20excwd/MnCPcK7OGZZeMo9obBx9EWgWOk/MkNqJ46
        RjcHiSEuYAALDceKQqbkiGQdE
X-Received: by 2002:a05:6000:401f:b0:32d:b081:ff38 with SMTP id cp31-20020a056000401f00b0032db081ff38mr2954644wrb.0.1698437269877;
        Fri, 27 Oct 2023 13:07:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkgUTGYjS6f4IS8gpL2kOvvhHnXXSaIDACgCVW9FuhNqYJjmfMRlQW2XMkSuftApFYRJIr7Q==
X-Received: by 2002:a05:6000:401f:b0:32d:b081:ff38 with SMTP id cp31-20020a056000401f00b0032db081ff38mr2954630wrb.0.1698437269519;
        Fri, 27 Oct 2023 13:07:49 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d44c9000000b0032d9caeab0fsm2414342wrr.77.2023.10.27.13.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 13:07:49 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH] dt-bindings: display: ssd132x: Remove '-' before
 compatible enum
In-Reply-To: <20231027172753.GA2834192-robh@kernel.org>
References: <20231020223029.1667190-1-javierm@redhat.com>
 <169801218855.747717.5658253186246322717.robh@kernel.org>
 <87y1foo1in.fsf@minerva.mail-host-address-is-not-set>
 <20231027172753.GA2834192-robh@kernel.org>
Date:   Fri, 27 Oct 2023 22:07:48 +0200
Message-ID: <87msw3omln.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

Hello Rob,

> On Fri, Oct 27, 2023 at 11:30:56AM +0200, Javier Martinez Canillas wrote:
>> Rob Herring <robh@kernel.org> writes:
>> 
>> > On Sat, 21 Oct 2023 00:30:17 +0200, Javier Martinez Canillas wrote:
>> >> This is a leftover from when the binding schema had the compatible string
>> >> property enum as a 'oneOf' child and the '-' was not removed when 'oneOf'
>> >> got dropped during the binding review process.
>> >> 
>> >> Reported-by: Rob Herring <robh@kernel.org>
>> >> Closes: https://lore.kernel.org/dri-devel/CAL_Jsq+h8DcnpKqhokQOODCc8+Qi3M0PrxRFKz_Y4v37yMJvvA@mail.gmail.com/
>> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> >> ---
>> >> 
>> >>  .../devicetree/bindings/display/solomon,ssd132x.yaml      | 8 ++++----
>> >>  1 file changed, 4 insertions(+), 4 deletions(-)
>> >> 
>> >
>> > Reviewed-by: Rob Herring <robh@kernel.org>
>> >
>> 
>> Pushed to drm-misc (drm-misc-next). Thanks!
>
> Given what introduced this is before the drm-misc-next-2023-10-19 tag, 
> isn't it going into 6.7 and needs to be in the fixes branch? Though that 
> doesn't exist yet for 6.7 fixes. I don't understand why that's not done 
> as part of the last tag for a cycle. But drm-misc is special.
>

I pushed to drm-misc-next because I thought that there will be a last PR
of drm-misc-next for 6.7, but it seems I missed it for a couple of hours
(that is drm-misc-next-2023-10-27) :(

https://lists.freedesktop.org/archives/dri-devel/2023-October/425698.html

The solution now is to cherry-pick the fixes already in drm-misc-next to
drm-misc-next-fixes, to make sure that land in 6.7. I can do that once
drm-next is back merged to that branch, if you think the schema warning
fix must land in 6.7 and can't wait for the next release.

> Rob
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

