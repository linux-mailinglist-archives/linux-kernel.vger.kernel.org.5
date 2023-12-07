Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45A28096A9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444110AbjLGXj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLGXj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:39:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F211713
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 15:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701992402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xg11osurhuZW+ExEnJSQ2VKUNQ2I4+/joQa17Mg9pp4=;
        b=ABsxg7snlChiiiWgKuZu0hsMJJhgWsPeCOowPS/UsFYqunxkWQcmjHHpxy6k2YPI0HTBdv
        Z8+N8GVrq+1CozpTaEW2XgeCLIMPkoctwJ34Adm6FG2luPXaEOSd8hUUjvq2k4ll37mXbY
        lMbhTgrPuMmayHFyhLsW70BIxSqUMLk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-iibx87w1PRyfAP4W92Mdmg-1; Thu, 07 Dec 2023 18:40:00 -0500
X-MC-Unique: iibx87w1PRyfAP4W92Mdmg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-54ca588b6d6so778376a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 15:40:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701992399; x=1702597199;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xg11osurhuZW+ExEnJSQ2VKUNQ2I4+/joQa17Mg9pp4=;
        b=PreHAKVOFNwKeXKKDxl+kRoNgmLKn8N86Sk/1usqiePFFUsSYnhxVF6qKxlntCrbt5
         b1AKo9ik2vk+YM5H6d5UhFQYwqrRAHHX7LGxSrCkKC5hgrvE2wS/zMvurb+QD+PXM7Re
         wHgNhyQRx7c88pzEmCNP7JLipX7blvr2+y2Y9RG8swiNmoEPMNR8q//VAoE/i1uIiCot
         TKVkRumzEPpHN85fJTkBqnRBIKbjRYRByY1A82Zsyybms3pFOE1c4zb1qkdoijGFMDUL
         6evWQUayu138CwaQUQ3jqYTEC1rUDkysq8jHDp293/WmOg4EmjlKXF457VYjoXVp+7KB
         TEcg==
X-Gm-Message-State: AOJu0YxUPGI47pYGfSIezcjxp8CVyCVoROn2CiyQmEUr/3h7Ii+5zliJ
        Amg2eeLOUn+zjpKvydcdht0Jhzxt0Yy4CrMvhYcPNgaus82Pj+OEd34OEzipd6G2Q/M/baCX/vw
        cm5nowxU71NdLQip3TMj2yhRN
X-Received: by 2002:a50:8d0f:0:b0:54c:7833:c111 with SMTP id s15-20020a508d0f000000b0054c7833c111mr2654166eds.36.1701992399579;
        Thu, 07 Dec 2023 15:39:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHONLQX5QD7kpaVJvn8DPKveQlpsowHFBYDxpIMAEK33ea6TyJJupLCP9XwWuJZegmCPjXkaQ==
X-Received: by 2002:a50:8d0f:0:b0:54c:7833:c111 with SMTP id s15-20020a508d0f000000b0054c7833c111mr2654157eds.36.1701992399265;
        Thu, 07 Dec 2023 15:39:59 -0800 (PST)
Received: from localhost ([84.236.194.198])
        by smtp.gmail.com with ESMTPSA id dn20-20020a05640222f400b0054cc22af09esm299697edb.46.2023.12.07.15.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 15:39:58 -0800 (PST)
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
In-Reply-To: <20231207173037.GA2944721-robh@kernel.org>
References: <87jzqi59bt.fsf@minerva.mail-host-address-is-not-set>
 <CAL_JsqJM9+cbNviwuKGB5+3YbyAP3UH+TxCxsU5nUtX-iRGP2w@mail.gmail.com>
 <CAMj1kXG7Xyk0ys9j-XRo7Rr8gYz1qJE8fFSixBOwVbm-pjeX+A@mail.gmail.com>
 <874jhj1fm3.fsf@minerva.mail-host-address-is-not-set>
 <58672ab8-99bf-4a2a-af79-031d1e8fcba0@suse.de>
 <87fs0mxlyp.fsf@minerva.mail-host-address-is-not-set>
 <CAL_JsqJbZ736iV+bRbSNNaimkbJLpB9MbeKLSct16Yi67ttFcw@mail.gmail.com>
 <87a5qqxq56.fsf@minerva.mail-host-address-is-not-set>
 <CAL_Jsq+7AwuLt9pfX0zr8g=65zSVLUFzFds82ENaspEFQNK=gg@mail.gmail.com>
 <87zfyqvtpx.fsf@minerva.mail-host-address-is-not-set>
 <20231207173037.GA2944721-robh@kernel.org>
Date:   Fri, 08 Dec 2023 00:39:57 +0100
Message-ID: <87cyvhh99u.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> On Mon, Dec 04, 2023 at 05:05:30PM +0100, Javier Martinez Canillas wrote:
>> Rob Herring <robh@kernel.org> writes:
>>=20
>> > On Mon, Dec 4, 2023 at 3:39=E2=80=AFAM Javier Martinez Canillas
>> > <javierm@redhat.com> wrote:
>> >> Rob Herring <robh@kernel.org> writes:
>> >> > On Fri, Dec 1, 2023 at 4:21=E2=80=AFAM Javier Martinez Canillas
>>=20
>> [...]
>>=20
>> >>
>> >> > However, there might be one other issue with that and this fix. The=
 DT
>> >> > simplefb can have resources such as clocks and regulators. With
>> >> > fw_devlink, the driver won't probe until those dependencies are met.
>> >> > So if you want the framebuffer console up early, then you may want =
to
>> >> > register the EFI framebuffer first and then handoff to the DT simpl=
efb
>> >> > when it probes (rather than registering the device).
>> >> >
>> >> > But I agree, probably better to take this patch now and have those
>> >> > quirks instead of flat out not working.
>> >> >
>> >>
>> >> If we do that what's the plan? Are you thinking about merging this pa=
tch
>> >> through your OF tree or do you want to go through drm-misc with your =
ack?
>> >
>> > I can take it. Do we need this in 6.7 and stable?
>> >
>>=20
>> IMO this can wait for v6.8 since is not a fix for a change introduced in
>> the v6.7 merge window and something that only happens on a very specific
>> setup (DT systems booting with u-boot EFI and providing an EFI-GOP table=
).
>>=20
>> Also the -rc cycle is already in -rc5, so it seems risky to push a change
>> at this point. And distros can pick the patch if want to have it earlier.
>
> Okay, I've applied it for 6.8.
>

Great, thanks a lot.

> Rob
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

