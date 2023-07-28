Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842C67669A5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbjG1KBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbjG1KAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:00:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6B135BE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690538402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pJQNnDwHhKTOa9Md7V1tRIFhNgoxjH5BC2RheBs12bw=;
        b=H/ksn9T/WRq3rasnzdF93g2CFkycL/pyoBQeAcPuCCoQAVrXNIDON6KUnr3IbGn4J/gRRz
        cDeUzKTTP8JFFaWdjEg6E5/oRy9RQPJBx2UT0oXOPLYjh/xyhEmhSRTCznmKhAjNHiM7jV
        OJyswh+u/CEKSZiRkSGszAOZRBgsdfg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-O4qDQ0TUMxOwgCvBNXgjuA-1; Fri, 28 Jul 2023 06:00:01 -0400
X-MC-Unique: O4qDQ0TUMxOwgCvBNXgjuA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3177af1ceacso1112879f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690538400; x=1691143200;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJQNnDwHhKTOa9Md7V1tRIFhNgoxjH5BC2RheBs12bw=;
        b=FvTKUALlrakqI1/2W2asrfY43MYSXPs5+evs+cKa8C1gDL9YFLiE4M96sT4PsnrC95
         Q9vGvcgFmvVFFosGOrNaNJ1pswQ3M1l+8WjBtcc5X1mn7q9Vi28AVXimjwJxqKxOsGWS
         kz7DYLC5on9ppi+jAjwUWLWZ4EgBy/9rzT3EsuUdw8qz+DfJodo9wS1tebsNHSD+xiMX
         +QieqxcVG8bP7gMarsKMLCyRChSnkUpS+YhO29Aqt3W+meXQm3bniVqySUHLFTv1J3QC
         E4SrkKAtdWrYuowvcFLR+4VyZ6JsR60Den5a0alitfl7RAzxmRGjLe/Q0LwHF0G7FTkQ
         qsXA==
X-Gm-Message-State: ABy/qLbeGykG5qwJZTzv3uCAs+xc/pcu+7AuBGXDW9wm2Jlqx3uknfqw
        B8lxx9Na0MUDNegKHSKsL20yjDyUCNJiBeVfj44v3md1xQCWNaHG4weunDXQoGbUlmNzZwJ/cup
        I95vcO7l6xC9q+nPYljf3S3Px
X-Received: by 2002:a5d:60cb:0:b0:316:f3f3:a1db with SMTP id x11-20020a5d60cb000000b00316f3f3a1dbmr1256317wrt.32.1690538400187;
        Fri, 28 Jul 2023 03:00:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGvVFl/+QuEwGgOf0OtaVy3l68k8gnLu8HbhCGvW7QutT2/hBtKWwBTcx9gJSeg+UzoJSVcMg==
X-Received: by 2002:a5d:60cb:0:b0:316:f3f3:a1db with SMTP id x11-20020a5d60cb000000b00316f3f3a1dbmr1256306wrt.32.1690538399910;
        Fri, 28 Jul 2023 02:59:59 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f14-20020adffcce000000b00316eb7770b8sm4437496wrs.5.2023.07.28.02.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 02:59:59 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/atomic-helper: Update reference to
 drm_crtc_force_disable_all()
In-Reply-To: <CAMuHMdXs47Jt9Kqf-Gm0eoFP8Wpe38cg4POO14GnPZCfWSs_FA@mail.gmail.com>
References: <b8c9c1a8a05dbf0be8e8be98cfdeafa9cecd8cef.1690535002.git.geert+renesas@glider.be>
 <87pm4ctl9b.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdXs47Jt9Kqf-Gm0eoFP8Wpe38cg4POO14GnPZCfWSs_FA@mail.gmail.com>
Date:   Fri, 28 Jul 2023 11:59:58 +0200
Message-ID: <87h6potkyp.fsf@minerva.mail-host-address-is-not-set>
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

> Hi Javier,
>
> On Fri, Jul 28, 2023 at 11:53=E2=80=AFAM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> Geert Uytterhoeven <geert+renesas@glider.be> writes:
>> > drm_crtc_force_disable_all() was renamed to
>> > drm_helper_force_disable_all(), but one reference was not updated.
>> >
>> > Fixes: c2d88e06bcb98540 ("drm: Move the legacy kms disable_all helper =
to crtc helpers")
>>
>> The dim tool complains that:
>>
>> -:10: WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes: <12=
 chars of sha1> ("<title line>")'
>>
>> So I've fixed it locally to only use the first 12 chars of the sha1.
>
> Good luck restoring them in the future (you do care about Y2038,
> do you? ;-)
>

Fair. I fixed it not only because checkpatch complained but also to make
it consistent with the rest of the Fixes: tag in the tree, in case that
people have automation in place having the assumption of the 12 chars...

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

