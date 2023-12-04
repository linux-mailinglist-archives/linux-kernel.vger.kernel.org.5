Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55F580399C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344495AbjLDQFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjLDQFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:05:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CA3E6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701705942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=72Qq8SUAOQ029tY/AmkNsTOso8dRLQAyWrIEdI18AJU=;
        b=LAgjO71dimOcF6qJvBvyWay1zxTg7KbSxb6kWDPzeyjkhvtOJ8NVq/whbBNnQWsjh+lbQC
        yZPZa/Tc9itwpf/opFBBWu9CiJU8adXmbaTxvieBZgQC3UA2FEB2v1Yy0M93Hu6gIaNeyf
        qi6Skh/s/nFNq98IKkJdyRD9RZWEqyg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-fhFdAWjQMGqnBIqN299MZA-1; Mon, 04 Dec 2023 11:05:33 -0500
X-MC-Unique: fhFdAWjQMGqnBIqN299MZA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-333501e22caso541501f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701705932; x=1702310732;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72Qq8SUAOQ029tY/AmkNsTOso8dRLQAyWrIEdI18AJU=;
        b=O9NHJ7uznqh/2ylkAScHAYAyprg/8pXagEwPo9PT8ig+8KwCswn50gSJICC8t/qVQT
         jYUCSxf9qafBh1EGDB4aY4QAjVcyM+UnTbUdRFs3sUJ0Aedvqgp9WOgzrb8WnNrh2nNn
         zosdgT8K4hxF/l8WPhsZQB3ZQPbyMxHPaOaOtlZZbC8rlRzgwIIHFIT3O9gYQyZdLHuS
         Er/jG/h36HOXF9dvL9bT2HJqrj1/x89Xwuo/9zPBDSita3dtrm2vPPpGGhJmxHVDsy20
         RXnaC0X29rUc8eYtSoldwwjLFehKshVTb6PKOIqhDjoyJdMfac4YQbyH2wnsP2iTiGSS
         iMjQ==
X-Gm-Message-State: AOJu0YxRMQpWHR7hSIF1jlz8Hvs3hApTFpa+EpXJP96bHoWx9iCrl8wq
        yOtyC/pO5v73KtIZKCVq9EKjc+Myv8/qDeXp2L8B7PObwKdJC8Zfaevtcp09RNkEZXagx2AjP8X
        dD4fSmmVYf7Ip+lPFcaLx6vtZ
X-Received: by 2002:adf:f841:0:b0:333:38b1:2bde with SMTP id d1-20020adff841000000b0033338b12bdemr2460720wrq.100.1701705932207;
        Mon, 04 Dec 2023 08:05:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGO2c8RIk7FOWrdCK6Vi2bSTizrP/0htWBOg3sB5XZ8oHosjIGzLt0ctc0XtiZkgie4jvH15Q==
X-Received: by 2002:adf:f841:0:b0:333:38b1:2bde with SMTP id d1-20020adff841000000b0033338b12bdemr2460709wrq.100.1701705931899;
        Mon, 04 Dec 2023 08:05:31 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600010cc00b0033340aa3de2sm5284527wrx.14.2023.12.04.08.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:05:31 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, devicetree@vger.kernel.org,
        Sergio Lopez <slp@redhat.com>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Hector Martin <marcan@marcan.st>,
        Andrew Worsley <amworsley@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC PATCH] of/platform: Disable sysfb if a simple-framebuffer
 node is found
In-Reply-To: <CAL_Jsq+7AwuLt9pfX0zr8g=65zSVLUFzFds82ENaspEFQNK=gg@mail.gmail.com>
References: <20231113085305.1823455-1-javierm@redhat.com>
 <CAL_JsqKHTN5hfd4qpg5RXbmQLKZNVywDkSj9mxvfGmjrcChQQg@mail.gmail.com>
 <87jzqi59bt.fsf@minerva.mail-host-address-is-not-set>
 <CAL_JsqJM9+cbNviwuKGB5+3YbyAP3UH+TxCxsU5nUtX-iRGP2w@mail.gmail.com>
 <CAMj1kXG7Xyk0ys9j-XRo7Rr8gYz1qJE8fFSixBOwVbm-pjeX+A@mail.gmail.com>
 <874jhj1fm3.fsf@minerva.mail-host-address-is-not-set>
 <58672ab8-99bf-4a2a-af79-031d1e8fcba0@suse.de>
 <87fs0mxlyp.fsf@minerva.mail-host-address-is-not-set>
 <CAL_JsqJbZ736iV+bRbSNNaimkbJLpB9MbeKLSct16Yi67ttFcw@mail.gmail.com>
 <87a5qqxq56.fsf@minerva.mail-host-address-is-not-set>
 <CAL_Jsq+7AwuLt9pfX0zr8g=65zSVLUFzFds82ENaspEFQNK=gg@mail.gmail.com>
Date:   Mon, 04 Dec 2023 17:05:30 +0100
Message-ID: <87zfyqvtpx.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> On Mon, Dec 4, 2023 at 3:39=E2=80=AFAM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> Rob Herring <robh@kernel.org> writes:
>> > On Fri, Dec 1, 2023 at 4:21=E2=80=AFAM Javier Martinez Canillas

[...]

>>
>> > However, there might be one other issue with that and this fix. The DT
>> > simplefb can have resources such as clocks and regulators. With
>> > fw_devlink, the driver won't probe until those dependencies are met.
>> > So if you want the framebuffer console up early, then you may want to
>> > register the EFI framebuffer first and then handoff to the DT simplefb
>> > when it probes (rather than registering the device).
>> >
>> > But I agree, probably better to take this patch now and have those
>> > quirks instead of flat out not working.
>> >
>>
>> If we do that what's the plan? Are you thinking about merging this patch
>> through your OF tree or do you want to go through drm-misc with your ack?
>
> I can take it. Do we need this in 6.7 and stable?
>

IMO this can wait for v6.8 since is not a fix for a change introduced in
the v6.7 merge window and something that only happens on a very specific
setup (DT systems booting with u-boot EFI and providing an EFI-GOP table).

Also the -rc cycle is already in -rc5, so it seems risky to push a change
at this point. And distros can pick the patch if want to have it earlier.

> Rob
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

