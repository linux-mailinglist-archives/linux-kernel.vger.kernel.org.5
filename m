Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164BB7C6816
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbjJLIJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbjJLIJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:09:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7963B90
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697098112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4sy1niajabmtfJtjCY77OzeeT/0lqMPwPT7C3Wbak1k=;
        b=JQt2/pjDjmoRyAvUrDJNY5mXNM/dMOgwCMty5np6bAuyJqR2v3g00rkboG/6tHLvE0iXGs
        awtCLZGVn3someEMeW5hkUT61suTHaNwQyhbHgTt/4rb68s+8eiyOzStP125kBDerNL5Lb
        apHsQFQEiCYfMtjuoLpEeJVh5xQrjQ8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-r3A7nYl8P9OpytewEa2UFw-1; Thu, 12 Oct 2023 04:08:26 -0400
X-MC-Unique: r3A7nYl8P9OpytewEa2UFw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4067f186039so5543315e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697098104; x=1697702904;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sy1niajabmtfJtjCY77OzeeT/0lqMPwPT7C3Wbak1k=;
        b=LTHynFP3tmZhq/k+vnXPbQm6ZYDijo2fElEHcmSvZWG/OkQi0O7Mmb37snHP4OHMjw
         yIiYi8Ji4PMaunOL+MyxANtOESFdRoMQOX6Xknpx8O1YFcYOoDvCMuvi/tHyXcONzJzl
         h3RomD1i0dz8xwugy83nBGV8w0/CTbU6yCzzDWFzFHujgkYomzO1xFKQ9FG0Fwf+oLjo
         PwDk5jyfhFfyAQKgG5wt7Wnv1TGXqyK02aYPDQ/VbuXj2tihQmkOg2hAEeKHwEDDH9GB
         NG6m3V2ivhq9OsDGfXkTuOHIdHoec2TweagEwOVBD0Zs5A51pjyqmG0/tyHIxvPbmMc6
         YaJg==
X-Gm-Message-State: AOJu0YwWRlnJeyqTLNC5oHn8a144/Qd6AlVqXQ/X5af8E/25dHVrHIxl
        Mwp7RZxTrvrP41obLC4DFPKDOf8V8mCqbXEPmGK8XhziVW1BCR5eNyKx0l/hMeqm2zmd6TU8oXZ
        ncYRWf3HABrTzYNWO8WNXa2Gr
X-Received: by 2002:a05:600c:4fc4:b0:407:6911:447c with SMTP id o4-20020a05600c4fc400b004076911447cmr789171wmq.4.1697098104762;
        Thu, 12 Oct 2023 01:08:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiZTBKUlCnAh+CV/NuP4uEbPNN+Std09KdK+CwQMNFHnOTkVZIvzDNtwZ5zDNL5/aKHpfW/g==
X-Received: by 2002:a05:600c:4fc4:b0:407:6911:447c with SMTP id o4-20020a05600c4fc400b004076911447cmr789152wmq.4.1697098104439;
        Thu, 12 Oct 2023 01:08:24 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c025300b00401d8181f8bsm21134403wmj.25.2023.10.12.01.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 01:08:24 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Conor Dooley <conor@kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 5/6] dt-bindings: display: Split common Solomon
 properties in their own schema
In-Reply-To: <CAMuHMdVR=aM-fr6SLfZMyA-Mdw23Tv+rX-iQQmw5u5U3vW5Ajg@mail.gmail.com>
References: <20231012065822.1007930-1-javierm@redhat.com>
 <20231012065822.1007930-6-javierm@redhat.com>
 <CAMuHMdVR=aM-fr6SLfZMyA-Mdw23Tv+rX-iQQmw5u5U3vW5Ajg@mail.gmail.com>
Date:   Thu, 12 Oct 2023 10:08:23 +0200
Message-ID: <874jiw4614.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Javier,
>
> On Thu, Oct 12, 2023 at 8:58=E2=80=AFAM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> There are DT properties that can be shared across different Solomon OLED
>> Display Controller families. Split them into a separate common schema to
>> avoid these properties to be duplicated in different DT bindings schemas.
>>
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>> (no changes since v1)
>
> New patch in v2.
>

Yeah, I mention that in the cover letter. That "(no changes since...)"
message is automatically added by the tool I use to post patches (patman)
for all patches that don't have a change history, even for new patches in
a series revision. And I don't know of a way to disable it...

Maybe what I should do is to add a change history to new patches mentioned
that is a new patch to prevent this message to appear.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

