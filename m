Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222857DA1E7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 22:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346475AbjJ0UoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 16:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjJ0UoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 16:44:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E8C1B6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 13:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698439406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rs7ONdb22HhWn9d4AOLrOhSSYx5jfAxh9HHbCywCFqE=;
        b=ZKXWdhXXFo0MMNEPYHwufI7GtQUoQGoJ4fP0eM9hmmpoi32VWqsGQeemj1dkrEPuWNTpWM
        zYuR/i7lYkR5FTghbbdzuHRG9vWqj4GUmYCde5+9DwVM5CPt6zfsj5wFvHNT1FOo6wdUQQ
        HsaSu3rJpnXHlDEt+MOh5uQGYGC91Co=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-hqWL1uKkOsGwWU3DEWXlYw-1; Fri, 27 Oct 2023 16:43:24 -0400
X-MC-Unique: hqWL1uKkOsGwWU3DEWXlYw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4084a9e637eso18560265e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 13:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698439403; x=1699044203;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rs7ONdb22HhWn9d4AOLrOhSSYx5jfAxh9HHbCywCFqE=;
        b=drA9lHUbeQmdmgDiy94RIBguV36Tgdzpq5qncOFnt3KhZpZgb2TXpx0uxEjplz63mv
         STjJybprfy0NM9CY7nd6xfc9+YVB/LcCbKeRH3mDkA1+a/dOTRp0bzBK1MdyxUtirHWY
         KDH3mJOeXhEQiaKkTMNbGTD2C+LiNLzpELTHiRYGqJ4UHlnVMac6+wrqMV17B0JK95ak
         AFrnc2xJDOWSk3PPRgLx1tH0ACAbOI7CS9qXh44qjFmmrj67qjCFa66Tq9dwqQTIYSwl
         KNXuL/p1orPmnRfIwmP+5c6YC1ZeaelKN4kW+B/LVx4liCfcAf6Mc8sPQmHAk+HMoEhG
         fdPg==
X-Gm-Message-State: AOJu0YxsRsGWZ5L0XfsAYjd5yHDORkddJGDwSZoG4tEr+/U2TZ2MnNWF
        Uilh8z8exwKqUQ7fqudkLYsdxlFynN0P1IDL+3EK3O7VBUbmFKfks1pR/DQniOr/C5LLxjn94DJ
        t7UDh0WlHY7qsTgWdPVplIOw7
X-Received: by 2002:a05:600c:19cc:b0:406:8494:f684 with SMTP id u12-20020a05600c19cc00b004068494f684mr2822673wmq.23.1698439403335;
        Fri, 27 Oct 2023 13:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Rb8y5ov/YtT1rodUK9OcZKUb3rJHbs/rL+T8j5WsAHE4P0HDWV/RoYdEraUvs+e4vR3i9A==
X-Received: by 2002:a05:600c:19cc:b0:406:8494:f684 with SMTP id u12-20020a05600c19cc00b004068494f684mr2822658wmq.23.1698439402952;
        Fri, 27 Oct 2023 13:43:22 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f7-20020a7bcd07000000b003fee567235bsm5865366wmj.1.2023.10.27.13.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 13:43:22 -0700 (PDT)
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
In-Reply-To: <87msw3omln.fsf@minerva.mail-host-address-is-not-set>
References: <20231020223029.1667190-1-javierm@redhat.com>
 <169801218855.747717.5658253186246322717.robh@kernel.org>
 <87y1foo1in.fsf@minerva.mail-host-address-is-not-set>
 <20231027172753.GA2834192-robh@kernel.org>
 <87msw3omln.fsf@minerva.mail-host-address-is-not-set>
Date:   Fri, 27 Oct 2023 22:43:21 +0200
Message-ID: <87msw3zthy.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

[...]

>>> Pushed to drm-misc (drm-misc-next). Thanks!
>>
>> Given what introduced this is before the drm-misc-next-2023-10-19 tag, 
>> isn't it going into 6.7 and needs to be in the fixes branch? Though that 
>> doesn't exist yet for 6.7 fixes. I don't understand why that's not done 
>> as part of the last tag for a cycle. But drm-misc is special.
>>
>
> I pushed to drm-misc-next because I thought that there will be a last PR
> of drm-misc-next for 6.7, but it seems I missed it for a couple of hours
> (that is drm-misc-next-2023-10-27) :(
>
> https://lists.freedesktop.org/archives/dri-devel/2023-October/425698.html
>
> The solution now is to cherry-pick the fixes already in drm-misc-next to
> drm-misc-next-fixes, to make sure that land in 6.7. I can do that once
> drm-next is back merged to that branch, if you think the schema warning
> fix must land in 6.7 and can't wait for the next release.
>

Or wait for the drm-misc-fixes branch to be back merged and land it as a
part of the 6.7-rc cycle. I'll do that since it would cause less trouble
to the drm-misc maintainers.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

