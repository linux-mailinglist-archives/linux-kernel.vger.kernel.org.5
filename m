Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5137EDDBE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbjKPJgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbjKPJga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:36:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51C5D5D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700127371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+LZsf1Geh2x5b5Ad0zzJw+dVByeOVUvndd2RtoYI34=;
        b=Eqh1Z5Y2Ki6HVIrQgI4hw+ta+pvyxb6mJUmvWLLwD7qf/cP+wUknt5ENduT3KrjXeyaP8X
        PE8Ij1vTFkvLW5zEdC722h1nNzbteUGxJUc+/adMLLVPFBZqwncdg7qjTTiDrJ9LyADuY2
        4cWzenmsxx73arhEv+DNcPb77o+lh58=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-uSghabAmNme-e2FWCnkMIA-1; Thu, 16 Nov 2023 04:36:09 -0500
X-MC-Unique: uSghabAmNme-e2FWCnkMIA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5098fc17ac5so562148e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700127367; x=1700732167;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+LZsf1Geh2x5b5Ad0zzJw+dVByeOVUvndd2RtoYI34=;
        b=pCke+XA31fJt9mw8elBpQhUER9wYLb7iiCFhNtb3qO2EwyNYrn05RcJU277EC63nPT
         xs1nUzHlsGI2jWND/2P2PEnNCJZZWorhbr1RNnIa+oq5QJ19r+elvXWYykV8eB33HhIG
         +9I07kX6Q7NEZNnaJEPX/C/UZS/GB+/kpWMa5Wq32nYJJjCKqTHXNRx3mwj6AotfNlXR
         fEZmUaLpM9CrpA0RWMabAlTlJIU2cp4sXm2Dq/U4RpZloj74qSpeU8JES217ZG6CwHbp
         2HYvXDCQdNDfrQKs9CAjTFB0swtqn8RMQpfoTxgp0E4ZZe76JjcA8xZodtu6BvElilXa
         KOyg==
X-Gm-Message-State: AOJu0Yy2xomnfPqspqb26p6EtKwhEDibRD8IvG83EixU1RR29FlBh3q+
        HHbOQ985VLe4ph5Px/eZaaVok3DNN3GHDXH+4+0zY/Osik4m6qbc2T36v5muG6/TuHZVDTO/soW
        K6zjNoXyZxuFktBAh8vCOxAO1g73BcTfE
X-Received: by 2002:a05:6512:3d02:b0:509:31e6:1de5 with SMTP id d2-20020a0565123d0200b0050931e61de5mr15185628lfv.47.1700127367547;
        Thu, 16 Nov 2023 01:36:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE75yAvd+0pV7xWDGGFOLYeqfxtPEMRAHOezjjPoj7Cde5b1To5N4sTL7RRUU4c3qam6M0Img==
X-Received: by 2002:a05:6512:3d02:b0:509:31e6:1de5 with SMTP id d2-20020a0565123d0200b0050931e61de5mr15185608lfv.47.1700127367236;
        Thu, 16 Nov 2023 01:36:07 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d11-20020a5d4f8b000000b0032d829e10c0sm12933437wru.28.2023.11.16.01.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 01:36:07 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Andrew Worsley <amworsley@gmail.com>,
        Hector Martin <marcan@marcan.st>,
        Sergio Lopez <slp@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH] of/platform: Disable sysfb if a simple-framebuffer
 node is found
In-Reply-To: <CAL_JsqKHTN5hfd4qpg5RXbmQLKZNVywDkSj9mxvfGmjrcChQQg@mail.gmail.com>
References: <20231113085305.1823455-1-javierm@redhat.com>
 <CAL_JsqKHTN5hfd4qpg5RXbmQLKZNVywDkSj9mxvfGmjrcChQQg@mail.gmail.com>
Date:   Thu, 16 Nov 2023 10:36:06 +0100
Message-ID: <87jzqi59bt.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

Hello Rob,

> On Mon, Nov 13, 2023 at 2:53=E2=80=AFAM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> Some DT platforms use EFI to boot and in this case the EFI Boot Services
>> may register a EFI_GRAPHICS_OUTPUT_PROTOCOL handle, that will later be
>> queried by the Linux EFI stub to fill the global struct screen_info data.
>>
>> The data is used by the Generic System Framebuffers (sysfb) framework to
>> add a platform device with platform data about the system framebuffer.
>>
>> But if there is a "simple-framebuffer" node in the DT, the OF core will
>> also do the same and add another device for the system framebuffer.
>>
>> This could lead for example, to two platform devices ("simple-framebuffe=
r"
>> and "efi-framebuffer") to be added and matched with their corresponding
>> drivers. So both efifb and simpledrm will be probed, leading to followin=
g:
>>
>> [    0.055752] efifb: framebuffer at 0xbd58dc000, using 16000k, total 16=
000k
>> [    0.055755] efifb: mode is 2560x1600x32, linelength=3D10240, pages=3D1
>> [    0.055758] efifb: scrolling: redraw
>> [    0.055759] efifb: Truecolor: size=3D2:10:10:10, shift=3D30:20:10:0
>> ...
>> [    3.295896] simple-framebuffer bd58dc000.framebuffer: [drm] *ERROR*
>> could not acquire memory range [??? 0xffff79f30a29ee40-0x2a5000001a7
>> flags 0x0]: -16
>> [    3.298018] simple-framebuffer: probe of bd58dc000.framebuffer
>> failed with error -16
>>
>> To prevent the issue, make the OF core to disable sysfb if there is a no=
de
>> with a "simple-framebuffer" compatible. That way only this device will be
>> registered and sysfb would not attempt to register another one using the
>> screen_info data even if this has been filled.
>>
>> This seems the correct thing to do in this case because:
>>
>> a) On a DT platform, the DTB is the single source of truth since is what
>>    describes the hardware topology. Even if EFI Boot Services are used to
>>    boot the machine.
>
> This is the opposite of what we do for memory and memory reservations.
> EFI is the source of truth for those.
>
> This could also lead to an interesting scenario. As simple-framebuffer
> can define its memory in a /reserved-memory node, but that is ignored
> in EFI boot. Probably would work, but only because EFI probably
> generates its memory map table from the /reserved-memory nodes.
>

I see. So what would be the solution then? Ignoring creating a platform
device for "simple-framebuffer" if booted using EFI and have an EFI-GOP?

> Rob
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

