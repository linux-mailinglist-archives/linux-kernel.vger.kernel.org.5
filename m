Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408797DCBCD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343712AbjJaL2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbjJaL2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:28:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2008C2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698751634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gFENUoE4QZmy/1C9/9VR1y/yhegXs4pxY1CyQb2hNdA=;
        b=e75EkMQuoCN3RpmJspM1kuzmtSX6fzujMHMVS7R5Izm9JjrTYG9KDDj5DTI1b/y/AgaCbe
        CdoAV7oYTL+gwnLQN3R8iTyXYNEFvPzdrAyU3kFlNigXLPfSEyDn8m/HHLSDusfx8pHhIw
        l4mEEUnSuLPUMjhYFwOlHButS08hr5U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-uCEiTIwwOfuvJcNzrkP6uQ-1; Tue, 31 Oct 2023 07:27:08 -0400
X-MC-Unique: uCEiTIwwOfuvJcNzrkP6uQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-408374a3d6bso38228975e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698751627; x=1699356427;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFENUoE4QZmy/1C9/9VR1y/yhegXs4pxY1CyQb2hNdA=;
        b=C3r6880oPQ4BEtAIsJtHqo2oFajU6+nAe7Di6y/jpCRklDQzguJBxIoxGf0MNiWg6w
         pkGcot42pkz4hNVznI/QlR3TIbOoeroCcDZ4BR66J+qJlQQX6HbPghnRFDzhV8ViVPeD
         VZfRs3S1M+UhCsLOzl8QRYg6nOFdcasK2XaVlMKF89Hte5JFBWfbFEQf9rbnVWhenose
         V5RRgUEky8M3UkbrKinxlHSpixgOy4PxCGZ6ghumyOaeL2qT0meOE5TVRGRWwMwrK3wX
         zkO05Enr1E82L+t2CVQVywElAB2/88vTNNMo7JfttfFXtu+vTIIH3H0kwD8nxTL0SyDO
         kopQ==
X-Gm-Message-State: AOJu0Yz7+CCN43IbCts1rYbCGeeyKi7Lb/i4xAF1Z936B79DAkR17mwG
        9iiySiavBpTLj0ZxcdX437ppxhIbI3KSKOJPLb+dRBrLaYKZSohzpj6pJovDsTeFklKPL0oD04C
        tQ7GtQahd5DgSbJiZgZvEZU/4RV76Bvzs
X-Received: by 2002:a05:600c:3b0f:b0:405:95ae:4a94 with SMTP id m15-20020a05600c3b0f00b0040595ae4a94mr10138787wms.5.1698751627009;
        Tue, 31 Oct 2023 04:27:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyn3f7N3+9Jfr+BsYwz1GP3j0/tAScocUYQVNydkFrJWH3GUUHSv9UN3qAzfB0OVYQRDNO2Q==
X-Received: by 2002:a05:600c:3b0f:b0:405:95ae:4a94 with SMTP id m15-20020a05600c3b0f00b0040595ae4a94mr10138774wms.5.1698751626720;
        Tue, 31 Oct 2023 04:27:06 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p6-20020adf9d86000000b0032d829e10c0sm1301848wre.28.2023.10.31.04.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 04:27:06 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jocelyn Falempe <jfalempe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] drm/ssd130x: Fix possible uninitialized usage of
 crtc_state variable
In-Reply-To: <CAMuHMdXdYm6Opyhgte7CaScs_jdPNUqrQTbPCMSQXqkKpKTd8w@mail.gmail.com>
References: <20231020225338.1686974-1-javierm@redhat.com>
 <b048247c-75e9-488e-a4f3-b227a38bca5e@redhat.com>
 <87v8aso1ha.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdVLf=H7QWaUXrN17ABw9eE1MjBdzFEM0AhMNj8_ULSz+Q@mail.gmail.com>
 <87lebjksoj.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdXdYm6Opyhgte7CaScs_jdPNUqrQTbPCMSQXqkKpKTd8w@mail.gmail.com>
Date:   Tue, 31 Oct 2023 12:27:05 +0100
Message-ID: <87il6nkp6e.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Javier,

[...]

>> >> Pushed to drm-misc (drm-misc-next). Thanks!
>> >
>> > Looks like you introduced an unintended
>> >
>> >     (cherry picked from commit 9e4db199e66d427c50458f4d72734cc4f0b92948)
>> >
>> > ?
>> >
>>
>> No, that's intended. It's added by the `dim cherry-pick` command, since I
>> had to cherry-pick to drm-misc-next-fixes the commit that was already in
>> the drm-misc-next branch.
>>
>> You will find that message in many drm commits, i.e:
>>
>> $ git log --oneline --grep="(cherry picked from commit" drivers/gpu/drm/ | wc -l
>> 1708
>
> Ah, so that's why it's (way too) common to have merge conflicts between
> the fixes and non-fixes drm branches :-(
>

I guess so. In this particular case it was my fault because I pushed to
drm-misc-next with the expectation that there would be a last PR before
the drm-next tree was sent to Torvalds but I missed for a few hours...

So then I had the option for the fixes to miss 6.7 and wait to land in
6.8, or cherry-pick them to the drm-misc-next-fixes branch and pollute
the git history log :(

> Gr{oetje,eeting}s,
>
>                         Geert
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

