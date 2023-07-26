Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731DE76395D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjGZOjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjGZOjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569F610DB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690382310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bkeaL9XjDhpA8ZoKIDSlYWZH67zFgnFmAVvVA6vDvLc=;
        b=ai1dx76vXyvAdjREp9W1kW8oQ6zv2y26uQOnBBta/jRdK9YI1mTfxWoKqYY4WunRdz1BfO
        iLpxnewX7+Mu3l8kmQcxpiUV0ndjosBiVygdPiOBlTm76yJkDGp/U0e7u1huBc1eXVhWqw
        odw63w+11OliZ0LxDNyw/XqqFzrMEiU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-TvgvMOIMNJSOU411B7Q3qQ-1; Wed, 26 Jul 2023 10:38:29 -0400
X-MC-Unique: TvgvMOIMNJSOU411B7Q3qQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b70bfc97e4so64217841fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690382307; x=1690987107;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkeaL9XjDhpA8ZoKIDSlYWZH67zFgnFmAVvVA6vDvLc=;
        b=h7VqMMoAYyqrKVh4jhHGvTZUiSp280a8PrFSvo/llZCKIc0Qxz9besWf3SFJRgdkqJ
         JFuSefCxN/U6ps07F+ZKZ/VgHntV47dBUFhhwUVa6eJ9ThzKXEUno5nxiZePBtZRcCA+
         TKfvF8T+okXrbKrWU4H7ikwaH4aXt9yarDYholYPGdNOsJ39g0+mtgkjUOr4PXAZg8Qv
         OXuK94I4kATbi9947/qBZlwO3WlTceAEHrRj/TyzjzqIWH6x3BthRy1Bb2qMTGIQ0LBm
         TszQlHK3yrIpBWyV8lMFHaiL5yUaFdHLOhQtkgYCZuIfV7dmoryCDv6OsJ521wiezio4
         OT1g==
X-Gm-Message-State: ABy/qLbLApjGtgzlp3OQN+l4aTLKBbd6ztICgWC14u7A+qxHjBghry5h
        8xGCSIVGQzdwa4u3YJIHqWh0WKUI4f4JjewDsyA+mGwh3LJN9P2axAOHjNKTBfDHf6iruFhT7WA
        OXc5GRxm/hj7AMMHNaGrmAerU1vE0Y6Vp
X-Received: by 2002:a2e:8810:0:b0:2b6:e2c1:6cda with SMTP id x16-20020a2e8810000000b002b6e2c16cdamr1575390ljh.46.1690382307309;
        Wed, 26 Jul 2023 07:38:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGOuyT1UUU626piEDgoGBZcB6J7nJcxqWYnLsqj2xprB+BOzJ2DO5S92UP5O+CzqhCxOwR+Kg==
X-Received: by 2002:a2e:8810:0:b0:2b6:e2c1:6cda with SMTP id x16-20020a2e8810000000b002b6e2c16cdamr1575370ljh.46.1690382306936;
        Wed, 26 Jul 2023 07:38:26 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m25-20020a7bce19000000b003fbe36a4ce6sm2233242wmc.10.2023.07.26.07.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:38:26 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 1/2] drm/ssd130x: Inline the
 ssd130x_buf_{alloc,free}() function helpers
In-Reply-To: <CAMuHMdUbOJ5_iEcV=G9ogZJ36T2qj8=tnutXcVZ=Sn-0=dqGug@mail.gmail.com>
References: <20230726105433.389740-1-javierm@redhat.com>
 <CAMuHMdUbOJ5_iEcV=G9ogZJ36T2qj8=tnutXcVZ=Sn-0=dqGug@mail.gmail.com>
Date:   Wed, 26 Jul 2023 16:38:25 +0200
Message-ID: <87a5vi4u1q.fsf@minerva.mail-host-address-is-not-set>
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

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Wed, Jul 26, 2023 at 12:55=E2=80=AFPM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> There is only a single caller for both helper functions and these don't =
do
>> much other than allocate and free two buffers, so let's just inline them.
>>
>> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>

Pushed to drm-misc (drm-misc-next). Thanks!

> Gr{oetje,eeting}s,
>
>                         Geert

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

