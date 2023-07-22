Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6184C75D80F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 02:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjGVAOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 20:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGVAOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 20:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9946410CB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 17:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689984800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9zAUVsITJjQgJMe+wUauASsmwQ/Teft8FD3ucSilGuQ=;
        b=EC2FjVcYajejlMjQg1CMiQdZIco+eJ9yTWQDgQFqcTeAOQlErW7tU9n8vGRXM2kUWDC/x5
        OLz3tVDzH5uhWhGWg+jcaaEcgEP2U6WGne+5CbqJAg+CWaI9gM2JItfVm1iDUKDchqu0LM
        Z3f8MJhp5GbmaIveE5dkJLifqvmYzjU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-BCn7wMvlPC65ajC2KReeHQ-1; Fri, 21 Jul 2023 20:13:18 -0400
X-MC-Unique: BCn7wMvlPC65ajC2KReeHQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3144bf68a03so1294127f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 17:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689984797; x=1690589597;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zAUVsITJjQgJMe+wUauASsmwQ/Teft8FD3ucSilGuQ=;
        b=PTZ3rOe8MYPxVPwNT6iAGi2OM291hkl/oYt2XuLA5MzYQPqiTLcBqaMNcxWhNL+auC
         NuQLJfv1whXoag+PiLCa6lk+PzH2ohJLUuhGsFVxkLE+Dsahd9yzXSkIdMJBYvePZplO
         2LBtOos+3dUvWDROUlNzQp+LzdHw8ChSi8HKYWGGnqW51yEzjz92o17i7kwVuGFSQ8Zf
         gzFI9wVYLSZTVU8auDh9GBOOm+fNFJ6j8a/Dzx7Gy6WkGA5JmnmvO0EGBkp6dF0n1ktz
         BI4XrKbhyx3X3lfS6MelxPVg77J5plxlFjH6VglbuRWuVXS+IrbrVkuKpikColKv4h8U
         BUcQ==
X-Gm-Message-State: ABy/qLb920cgUKLxDA5qlldmf2TKDvN4xAVU7kXhfGVFQkpXj0PRCW92
        mNIRae0C7ENhnFU5GY8TB65kpd4A4ztEagAn7LGjzFaJ6cdSeYGdevIWUBRiZyzlnK560dpmeII
        tturfxi4ZuUzUFv4TodMpKlaStTEa4Wb2
X-Received: by 2002:a05:600c:20d1:b0:3fd:1daf:abd8 with SMTP id y17-20020a05600c20d100b003fd1dafabd8mr2089746wmm.40.1689984797569;
        Fri, 21 Jul 2023 17:13:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEXRkyrt5UhsSX2MfCaQiSDHQSKHbh/kU/IrA6UfVzAbLX+sn0IQirVDLsddlSuFOcFPpbQDw==
X-Received: by 2002:a05:600c:20d1:b0:3fd:1daf:abd8 with SMTP id y17-20020a05600c20d100b003fd1dafabd8mr2089733wmm.40.1689984797253;
        Fri, 21 Jul 2023 17:13:17 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c210900b003fbcdba1a52sm6920280wml.3.2023.07.21.17.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 17:13:16 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 1/4] video: Add auxiliary display drivers to Graphics
 support menu
In-Reply-To: <CANiq72=A3PLGGPGnwL=gjX7LFsQL9N8W__ojxmVpj2uCAKvhQA@mail.gmail.com>
References: <20230719081544.741051-1-javierm@redhat.com>
 <20230719081544.741051-2-javierm@redhat.com>
 <87sf9gublz.fsf@minerva.mail-host-address-is-not-set>
 <CANiq72=A3PLGGPGnwL=gjX7LFsQL9N8W__ojxmVpj2uCAKvhQA@mail.gmail.com>
Date:   Sat, 22 Jul 2023 02:13:16 +0200
Message-ID: <87mszou7kz.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

Hello Miguel,

> On Sat, Jul 22, 2023 at 12:46=E2=80=AFAM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> Javier Martinez Canillas <javierm@redhat.com> writes:
>>
>> [adding Miguel Ojeda who was not in the Cc list]
>>
>> Hello Miguel, could you please ack this patch so that I can take the who=
le
>> patch-set through the drm-misc tree?
>
> A note below...
>
>> > The drivers in this subsystem are for character-based LCD displays, wh=
ich
>> > can fall into the same category of the DRM/KMS and fbdev drivers that =
are
>> > located under the "Graphics support" menu. Add auxdisplay there as wel=
l.
>
> Nit: this is not exactly true, e.g. ks0108/cfag12864b (which were the
> first in the subsystem) were not character-based but a very simple
> black-or-white 128x64 grid, so we should probably reword slightly
> this.
>

Oh, interesting. I wonder why that couldn't had been a fbdev driver then
using FB_VISUAL_MONO01? I'll reword then the commit message before apply
to the following instead:

"The drivers in this subsystem are for either character-based or monochrome
LCD controllers, which can fall into the same category of the DRM/KMS and
fbdev drivers, that are located under the "Graphics support" menu.

Add the auxdisplay drivers there as well to have all display drivers under
the same menu."

> In any case, if Helge thinks these may belong in the "Graphics
> support" menu, then I am fine with it:
>
>     Acked-by: Miguel Ojeda <ojeda@kernel.org>
>

Perfect, thanks!

> Thanks!
>
> Cheers,
> Miguel
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

