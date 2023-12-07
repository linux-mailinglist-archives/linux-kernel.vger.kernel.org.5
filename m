Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F69808EC7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443239AbjLGRag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjLGRae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:30:34 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9F210CA;
        Thu,  7 Dec 2023 09:30:40 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-58d12b53293so517835eaf.0;
        Thu, 07 Dec 2023 09:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701970239; x=1702575039;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqj0z6kEygULbYJbl9fDvMATmV0n6DPZZ0Ol7473clQ=;
        b=Ie5KPFuFjNI8LNiDdCiUbWAFSd2o1hOXcif1JKQTnMuY1iUrf9Blu7xLWZbOgMp/Su
         xzFr90mpeCXCyADJMqI8H2+7tKfEViPZ8PlSZElYepQsf62aLAJIVYSRls90PBc4AJhZ
         DSm1fLrhG7VQjxO9vYF9eiu2rKho7XEk6y4p4J3SUWwIGOWKQNGD2qk7r9AbTHpbYiOg
         17irKggpuMwn3YLqs/VVnilZNQcxccDnHwhxlDM87h1IF9BrNo0ZYR5snejn2SAgRV1X
         medlzFHj3R8H7asvuHs8l5TmaOpklms5lkL+WRH8sUQ0+xqf7OXHbwId4gf3Bkosn6+G
         YKWw==
X-Gm-Message-State: AOJu0YwTKaxma+/Tj7UCgdn33v2ZVTAz+bZv43nNjkxGOFassR3KFEL2
        yE5ZZe5xGGG94o4IBnFZUA==
X-Google-Smtp-Source: AGHT+IF3F8YBAWZBvd1RIa5py5Lvvl2NkA72wnpM8EkmUcXD/AJYQyxVqC4by4fUaPk/uragnrGJtQ==
X-Received: by 2002:a05:6820:1c90:b0:58d:9ff4:7646 with SMTP id ct16-20020a0568201c9000b0058d9ff47646mr3042277oob.4.1701970239382;
        Thu, 07 Dec 2023 09:30:39 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w21-20020a4a3555000000b00587947707aasm10168oog.4.2023.12.07.09.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 09:30:38 -0800 (PST)
Received: (nullmailer pid 2946014 invoked by uid 1000);
        Thu, 07 Dec 2023 17:30:37 -0000
Date:   Thu, 7 Dec 2023 11:30:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
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
Message-ID: <20231207173037.GA2944721-robh@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zfyqvtpx.fsf@minerva.mail-host-address-is-not-set>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 05:05:30PM +0100, Javier Martinez Canillas wrote:
> Rob Herring <robh@kernel.org> writes:
> 
> > On Mon, Dec 4, 2023 at 3:39 AM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
> >> Rob Herring <robh@kernel.org> writes:
> >> > On Fri, Dec 1, 2023 at 4:21 AM Javier Martinez Canillas
> 
> [...]
> 
> >>
> >> > However, there might be one other issue with that and this fix. The DT
> >> > simplefb can have resources such as clocks and regulators. With
> >> > fw_devlink, the driver won't probe until those dependencies are met.
> >> > So if you want the framebuffer console up early, then you may want to
> >> > register the EFI framebuffer first and then handoff to the DT simplefb
> >> > when it probes (rather than registering the device).
> >> >
> >> > But I agree, probably better to take this patch now and have those
> >> > quirks instead of flat out not working.
> >> >
> >>
> >> If we do that what's the plan? Are you thinking about merging this patch
> >> through your OF tree or do you want to go through drm-misc with your ack?
> >
> > I can take it. Do we need this in 6.7 and stable?
> >
> 
> IMO this can wait for v6.8 since is not a fix for a change introduced in
> the v6.7 merge window and something that only happens on a very specific
> setup (DT systems booting with u-boot EFI and providing an EFI-GOP table).
> 
> Also the -rc cycle is already in -rc5, so it seems risky to push a change
> at this point. And distros can pick the patch if want to have it earlier.

Okay, I've applied it for 6.8.

Rob
