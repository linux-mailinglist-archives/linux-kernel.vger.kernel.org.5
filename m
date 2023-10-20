Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A667D0CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376853AbjJTKHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376715AbjJTKHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:07:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB4BD55
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:06:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507b9408c61so774187e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697796416; x=1698401216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U60xRu3muth06imj7dV2lIvp06gGg+EXmKMXyWpygio=;
        b=bV4Z/OKI+riUNStRKFEBAshzqkQkzmNoYW3D4zOAxKs1AcdR/ITKjdcwDdM/j7kYc/
         xMLRJv8BS7bvcjcbXKWhkMP5cfipX63VPxtZRhW6f+HbXuj+Q9AxdN6tN7YoN0wzcrqX
         1KaTBtpXQcVv9m2kNPdMROMB0T3NoPw8Gmo1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697796416; x=1698401216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U60xRu3muth06imj7dV2lIvp06gGg+EXmKMXyWpygio=;
        b=rOv6ZEazGdLCvYZIavVHpaNuyQ221sQNCVznGsQEX2fc6Mjsj0QcTpCxyoL9OEXOK3
         je51HTpdMVzC1TJV8W/6tbwdNiLC+FCyNx7/kVzKCCSMqevzLNVNx2O5+L++Ddweyem1
         qrFFrTFRwr8TpZgp3Ahgq33JXcIyWY+3ZPW+B4W9KbWCXcSu/C4Q/qje5//LmqgdCTEw
         RJV2Z0IOA5+Fq2xHWnpv/5H0aCiPZmWp13ZjA5kadyj/gdGL2GWjPzkYkAcMfY30qTrY
         yWuzl587cNzfb6zWLerGxSeX7n8YGRhkpUSH3sA8QHNbYZvyM6vtmTkMteEJ1+f1vL6i
         JvdA==
X-Gm-Message-State: AOJu0YzH3kjBRlKA8zB1ZGCp3AwyRpCHfAPCczYgf4MGiDLvVJQcJYsE
        wRDlIED4agTDU+7gg3ROaNMccRll5FMG+rJyjBDY2g==
X-Google-Smtp-Source: AGHT+IGMgUhxeAaKaib8jj8BktoeGnz9Vt6YddVIkuEOsf7lHfREqf/7V17tOsIuYSEJ0VxY4zzdyMBMFhYnMoAkzgg=
X-Received: by 2002:ac2:46f9:0:b0:507:9702:8e0f with SMTP id
 q25-20020ac246f9000000b0050797028e0fmr868400lfo.25.1697796415848; Fri, 20 Oct
 2023 03:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231012230237.2676469-1-wenst@chromium.org> <20231012230237.2676469-3-wenst@chromium.org>
 <20231013-washer-mortally-b27c196ac50f@spud> <CAGXv+5GF7HfQSOg9c=G+c4DPUW24Ax7LX4raTynDbE3xc8iCdg@mail.gmail.com>
 <20231013-panic-vaseline-350c10e7d585@spud> <CAGXv+5EmLDWi3Lnca1vPft=9z9Cp2L2ee08in_b_21hipf9ieQ@mail.gmail.com>
 <20231014-proud-levers-eb03f30a0a9a@spud> <CAGXv+5F-x9m2WYZm-YLaxqio=VnfKkL26gLFbayJctBEJrSM6A@mail.gmail.com>
 <20231018-earpiece-dimmed-81c0f728d0b6@spud>
In-Reply-To: <20231018-earpiece-dimmed-81c0f728d0b6@spud>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 20 Oct 2023 18:06:44 +0800
Message-ID: <CAGXv+5F8rLOnUuCJ_PYxqXYN68Hd7OafLR0a6+kHV-n2wuR5=A@mail.gmail.com>
Subject: Re: [PATCH 2/9] dt-bindings: arm: mediatek: Add MT8186 Tentacruel /
 Tentacool Chromebooks
To:     Conor Dooley <conor@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:07=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Sun, Oct 15, 2023 at 11:15:22PM -0700, Chen-Yu Tsai wrote:
> > On Sat, Oct 14, 2023 at 6:40=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Fri, Oct 13, 2023 at 11:19:16AM -0700, Chen-Yu Tsai wrote:
> > > > On Fri, Oct 13, 2023 at 10:55=E2=80=AFAM Conor Dooley <conor@kernel=
.org> wrote:
> > > > >
> > > > > On Fri, Oct 13, 2023 at 10:29:25AM -0700, Chen-Yu Tsai wrote:
> > > > > > On Fri, Oct 13, 2023 at 8:11=E2=80=AFAM Conor Dooley <conor@ker=
nel.org> wrote:
> > > > > > >
> > > > > > > On Fri, Oct 13, 2023 at 07:02:28AM +0800, Chen-Yu Tsai wrote:
> > > > > > > > Add entries for MT8186 based Tentacruel / Tentacool Chromeb=
ooks. The two
> > > > > > > > are based on the same board design: the former is a convert=
ible device
> > > > > > > > with a touchscreen, stylus, and some extra buttons; the lat=
ter is a
> > > > > > > > clamshell device and lacks these additional features.
> > > > > > > >
> > > > > > > > The two devices both have two variants. The difference is a=
 second
> > > > > > > > source touchpad controller that shares the same address as =
the original,
> > > > > > > > but is incompatible.
> > > > > > >
> > > > > > > > The extra SKU IDs for the Tentacruel devices map to differe=
nt sensor
> > > > > > > > components attached to the Embedded Controller. These are n=
ot visible
> > > > > > > > to the main processor.
> > > > > > >
> > > > > > > Wha? Given your ordering, is a "google,tentacruel-sku262144" =
a super-set
> > > > > > > of "google,tentacruel-sku262145"? If not, this compatible ord=
ering
> > > > > > > doesn't make sense. I can't tell from your description, and t=
he
> > > > > > > absence of a
> > > > > > > items:
> > > > > > >           - const: google,tentacruel-sku262145
> > > > > > >           - const: google,tentacruel-sku262146
> > > > > > >           - const: google,tentacruel-sku262147
> > > > > > >           - const: google,tentacruel
> > > > > > >           - const: mediatek,mt8186
> > > > > > > suggests that there is no google,tentacruel-sku262145
> > > > > > > device?
> > > > > >
> > > > > > AFAIK all four SKUs exist. And as far as the main processor is =
concerned,
> > > > > > they look completely identical, so they should share the same d=
evice tree.
> > > > > > As mentioned in the commit message, the differences are only vi=
sible to
> > > > > > the embedded controller, which fuses the sensor inputs.
> > > > >
> > > > > Then it makes very little sense to write a binding like this.
> > > > > If this was just for the 252144 SKU, this would be fine.
> > > > > For the other SKUs, there is no way to uniquely identify them, as
> > > > > all four of google,tentacruel-sku262144, google,tentacruel-sku262=
145,
> > > > > google,tentacruel-sku262146 and google,tentacruel-sku262147 must =
be
> > > > > present.
> > > > > Given that, why even bother including the SKUs in the first place=
,
> > > > > since no information can be derived from them that cannot be deri=
ved
> > > > > from google,tentacruel?
> > > > > There's something that I am clearly missing here...
> > > >
> > > > There are incompatible variants of google,tentacruel. This is why t=
his
> > > > patch has four google,tentacruel based entries. Of them, two are Te=
ntacool,
> > > > which are clamshell laptops, and two of them are Tentacruel, which =
are
> > > > convertibles.
> > > >
> > > > Within each group there are two variants: the second variant swaps =
out
> > > > the I2C touchpad controller. These two controllers use the same I2C
> > > > address but use different compatible strings, so it's not possible =
to
> > > > have them coexist within the same device tree file like we do for m=
any
> > > > other second source components.
> > > >
> > > > So the relationship looks like the following:
> > > >
> > > > google,tentacruel --- Tentacruel --- google,tentacruel-sku26214[456=
7]
> > > >                    |              |
> > > >                    |              -- google,tentacruel-sku2621{48,4=
9,50,51}
> > > >                    |
> > > >                    -- Tentacool ---- google,tentacruel-sku327681
> > > >                                  |
> > > >                                  --- google,tentacruel-sku327683
> > > >
> > > > Also, the devices themselves only know their own SKU ID. The firmwa=
re
> > > > will generate a list of compatible strings like:
> > > >
> > > >   google,tentacruel-rev4-sku262144
> > > >   google,tentacruel-rev4
> > > >   google,tentacruel-sku262144
> > > >   google,tentacruel
> > > >
> > > > and try to find a match in the kernel FIT image. The method we curr=
ently
> > > > use is to include all the applicable board compatible strings.
> > >
> > > Then it seems like what you need is something like
> > > oneOf:
> > >   - items:
> > >       - const: google,tentacruel-sku262144
> > >       - const: google,tentacruel
> > >       - const: mediatek,mt8186
> > >   - items:
> > >       - enum:
> > >           - google,tentacruel-sku262145
> > >           - google,tentacruel-sku262146
> > >           - google,tentacruel-sku262147
> > >       - const: google,tentacruel-sku262144
> > >       - const: google,tentacruel
> > >       - const: mediatek,mt8186
> > >
> > > What you have at the moment just seems like a hack because you want t=
o
> > > stuff all of these compatible strings into a single dts.
> >
> > It is. And it works OK downstream. The reason we want to stuff them in
> > one dts is because the firmware will not generate the fallback to
> > sku262144 as the scheme above suggests.
>
> I'm not going to ack the hack that you have here, sorry. Maybe Rob or

I understand.

> Krzysztof will. The list your firmware generates above doesn't even
> match the contents of this patch, with the extra "rev-4" compatibles.

The firmware generates a list of compatibles that it will go through and
try to find a matching compatible with. I believe the intent was not to
use it as "a list of compatibles" in the usual sense. The kernel image
comes bundled with a whole bunch of device trees, and the firmware just
tries to find the best or most specific match. The firmware only knows
about itself, and does not know about adjacent or similar SKUs or
revisions.

The process is described in detail in the kernel tree in

    Documentation/arch/arm/google/chromebook-boot-flow.rst

or https://docs.kernel.org/arch/arm/google/chromebook-boot-flow.html

> > Having three or four identical device trees just with different board
> > compatible string sequences to me seems a bit redundant, and it does
> > end up bloating our FIT image a bit, which impacts boot time.
>
> I'm not aware of the capabilities of your bootloader when it comes to
> setting properties before passing them to the kernel, but that is what I
> would be doing to cut down on having 4 different dtbs.

That could be a solution for future devices, but the devices this series
covers are already on the market. The firmware on these devices is very
hard to update, and there is no guarantee that the device ever gets
updated. Sometimes these extra SKUs or component changes happen after
the device is in production, due to inventory issues or EOL of components.
This is what happened here.

Then there's sometimes the problem where we are originally shipping with
downstream patches / bindings that may change as they are upstreamed.
This is something we are trying to fix by having our vendors upstream
earlier, but sometimes we do end up carrying some stuff downstream
regardless.

Also, doing the customization in firmware would be somewhat fragile as
we end up trying to keep two separate software packages in sync.


I talked to Doug Anderson about this, and his "of: device: Support 2nd
sources of probeable but undiscoverable devices" proposal (specifically,
the second proposal [1] after Rob nacked the first one) could help solve
this as well. Part of what we have with the Tentacruel series is second
source drop-in components, which is the same issue that the proposal
wants to solve.

Specifically, instead of the firmware solution you proposed, there would
be a hardware prober driver running early in the kernel that deals with
the board specifics, either by checking the SKU ID passed in by the
firmware (in inserted device tree nodes), or by manually probing the
hardware in some board specific way and tweaking the device tree to
match. It would know what needs to be handled for each device series.

With this scheme, we would be able to merge some of the device trees
together, though I'm not sure we would want to merge all of
"google,tentacruel", as that would also cover variants of different
form factors. I guess it depends on how much editing or probing we
want to allow in the board manager.


Thanks
ChenYu

[1] https://lore.kernel.org/linux-devicetree/CAD=3DFV=3DUjVAgT-febtj4=3DUZ2=
GQp01D-ern2Ff9+ODcHeQBOsdTQ@mail.gmail.com/
