Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078F37DB7CB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjJ3KTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjJ3KSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B245C6F86
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698660285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3jV9wsFuEisf3vb2BAnPpXdxe1/PPDMuldDZzCp400E=;
        b=AuYGFBrolrKZoSTHq2+FidQHYNqF5nmo2qu4/4pZR10CwRyfZC4G/PiOIFxD96f4Mb0Buq
        llq21gWGE9XNdPOUTV4YkW141iSA5bwkvqy6yVBq4z/SNngMjhtRqG8opD7uMC5PjQ6pBq
        cUr6IvyivDREsWQDYyxTvqSn0f/0itU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-VdXbB8e6M-GXAOg5kdJaHA-1; Mon, 30 Oct 2023 06:04:44 -0400
X-MC-Unique: VdXbB8e6M-GXAOg5kdJaHA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4092164ee4eso31116015e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698660283; x=1699265083;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jV9wsFuEisf3vb2BAnPpXdxe1/PPDMuldDZzCp400E=;
        b=ENzamZePQdefXDeOsMHmS3HRX9z7qDZ8cozmm3iYKOA3Z7mTNgKIrP5B4CSsAdzcMg
         8H8XkZK5nRxVYwKxQ4BwURvqKl7YzMbVMVsBYA/BgOHNq6TY15IWxwjDY1CvsjFK7+Tg
         ZdEVZPsVy10FXREplVeYUX/qJfix0EyPfLK9qmff+Ft6i6C53W8C6Ie6YIwCBaABqQKo
         oZyBmGad8HxlFxGBZDJ6vxpunl5P1ZXfiYTK8UtGJt58dVZ3FncLiv+lk54iHjBAZNth
         ITlWJfVw4xZpW92SEwJXL5doK6zTt5Iptf31nH/wXJOiY4wT1qj5GX37j8MeotlVOqZi
         MhaA==
X-Gm-Message-State: AOJu0Yy0JMONbvP2d+C1fkSRFwIqQE3aC7x9GV+4fAVuR57BiZL3Kxve
        wii9QWNZli2yN2xAblu78ZHmEK6EKRT7kzwK7OpwLbZPYmbjAaepVcaDLCs4Vi/ZzXjo4e1lXQP
        QGbH+eHqW/Ry2fLrjOIX8lsZm
X-Received: by 2002:a5d:6d08:0:b0:32d:967d:1bae with SMTP id e8-20020a5d6d08000000b0032d967d1baemr8378500wrq.0.1698660283172;
        Mon, 30 Oct 2023 03:04:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyZDSUvodlaTnopLvaCTSB7TOJfDUWETWpqkH2ReIYOzMzfqhzqmVbyJj2e+ZFmRu5TTpvyw==
X-Received: by 2002:a5d:6d08:0:b0:32d:967d:1bae with SMTP id e8-20020a5d6d08000000b0032d967d1baemr8378481wrq.0.1698660282858;
        Mon, 30 Oct 2023 03:04:42 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a17-20020adfe5d1000000b003142e438e8csm7922409wrn.26.2023.10.30.03.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 03:04:42 -0700 (PDT)
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
Date:   Mon, 30 Oct 2023 11:04:41 +0100
Message-ID: <87jzr4zarq.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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

Cherry-picked the commit in drm-misc-next-fixes as well.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

