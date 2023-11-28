Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA287FC43E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344553AbjK1T0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjK1T0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:26:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54670D66
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701199615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MS3bSC/lh7WFrp63LfDhGI9l2oiNjApvavz8PpRiwhM=;
        b=W5pxptq3kCgyMCEsenTvEdIrgFUF1vRmhqksZ6aUyYA2/QmPM1ydlaWJ/WZ/i7naFxDOJF
        bH0RM3w3u9eDc0LyRiqdKQhcjHJJlK6F1R+TlBRu+8UvxV2b0Kd/9K+Re55rjcXPAnzbZP
        xq8Tv6+eDNMmfO4Txe2aghZ0MXBTzoU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-ndCCNtc-M56-hFeUPPh2aw-1; Tue, 28 Nov 2023 14:26:53 -0500
X-MC-Unique: ndCCNtc-M56-hFeUPPh2aw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332d213c2bbso4036196f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701199612; x=1701804412;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MS3bSC/lh7WFrp63LfDhGI9l2oiNjApvavz8PpRiwhM=;
        b=t6iXqTmT6V29kHDT1rrZXDmEq+4D3TRPVxvBh14Wh34RXvSXXbWm7vTP1PSMf5dbGA
         EWgEDTldkfkMeD9nVQgf7+Ha3NAvbZDba4w9YxY67bvbWo46pJArgGve+tDgiE+kzmfL
         YoDyc53sRAh5XCd3dzYM+k1dSbNJpc2o63tUrPgRZhbQ3B1mNR8/S8OnBD3uB+r9TDqH
         CaFTcz6vz6EL4bfe1b/MtfcLhHcUhv0pJ2i1wdVMRBIiEuyTKlI4khT8xaJ9B11BZyhf
         jlqJ2J55SwOZ467atbaUQJMd72jD7IGxmtinZ5HdRXOrlr8kiVyNmWft+3XC3wruwrCf
         EWHg==
X-Gm-Message-State: AOJu0YxSrJTfDwWyB5pkhrHj0HgYI9meB7K27CHR236c9LahI6WD6qm0
        TSOhNXfijp1dyFyNlb+7CFgRZlls490jX9qJ7ulegOQP5worcDxDaMrnJFkO9K4mQItvr475Px9
        ysdRUqONQlkWraqcULtOaMR23V7y6iz2v
X-Received: by 2002:a5d:698f:0:b0:333:a30:1084 with SMTP id g15-20020a5d698f000000b003330a301084mr2562148wru.36.1701199612453;
        Tue, 28 Nov 2023 11:26:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgXVVnlAR7W0JMvI7O0Q/Or9OcgM4j86TTiRG31fyoyYCrlzYqVF+Thl0Tirl17AB6LtZAoQ==
X-Received: by 2002:a5d:698f:0:b0:333:a30:1084 with SMTP id g15-20020a5d698f000000b003330a301084mr2562142wru.36.1701199612107;
        Tue, 28 Nov 2023 11:26:52 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s18-20020a5d6a92000000b00332eaede976sm12668449wru.86.2023.11.28.11.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:26:51 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sarah Walker <sarah.walker@imgtec.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/imagination: DRM_POWERVR should depend on ARCH_K3
In-Reply-To: <CAMuHMdUhuO++ZSxh+_TX_6DHHxjPYY20jTppbNZ4FnuBvxxinQ@mail.gmail.com>
References: <b9360c2044a1001b9a5bcb5914611711d040d4fe.1701196029.git.geert+renesas@glider.be>
 <87o7fdbszs.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdUhuO++ZSxh+_TX_6DHHxjPYY20jTppbNZ4FnuBvxxinQ@mail.gmail.com>
Date:   Tue, 28 Nov 2023 20:26:51 +0100
Message-ID: <87il5lbrwk.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Javier,
>
> On Tue, Nov 28, 2023 at 8:03=E2=80=AFPM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> Geert Uytterhoeven <geert+renesas@glider.be> writes:
>> > The Imagination Technologies PowerVR Series 6 GPU is currently only
>> > supported on Texas Instruments K3 AM62x SoCs.  Hence add a dependency =
on
>> > ARCH_K3, to prevent asking the user about this driver when configuring=
 a
>> > kernel without Texas Instruments K3 Multicore SoC support.
>> >
>> > Fixes: 4babef0708656c54 ("drm/imagination: Add skeleton PowerVR driver=
")
>> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> > ---
>>
>> Indeed. Although I wonder what is the supposed policy since for example
>> the DRM_PANFROST symbol only depends on ARM || ARM64 and others such as
>
> I think ARM Mali is sufficiently ubiquitous on ARM/ARM64 systems to
> have just an ARM/ARM64 dependency...
>

Fair.

>> DRM_ETNAVIV don't even have an SoC or architecture dependency.
>
> Vivante GPUs are found in DTS files on at least 4 architectures.
> Might be worthwhile to add some dependencies, though...
>

Yeah, that's what I was thinking.

>> In any case, I agree with you that restricting to only K3 makes sense.
>
> I am looking forward to adding || SOC_AM33XX || ARCH_RENESAS || ...,
> eventually ;-)
>

Same! :)

>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --=20
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

