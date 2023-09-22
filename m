Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597817AB350
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjIVOOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbjIVOOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:14:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC59F19A;
        Fri, 22 Sep 2023 07:14:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABDAC43391;
        Fri, 22 Sep 2023 14:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695392071;
        bh=T8rFOp5c/QzIwjzIQ5gCHFQ+RtWQM1Gbc96XZKpVHU4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eK6VqpbwghzMdQi7kn4A4v1NS9ocmVHQZD5/dZTDQ40qJQonEckr5J8Ojdu1FOkLr
         Rds5wpig51H4u4nPPK9hUd5NOHDcc63SAsqq5GsXxi6L0rUX6lNVRfjAPgvbj4l828
         tLhVbGv4D6PEhZnKGv8aR6vuZeD2K4fG2qxaU7dVpH+5sk27kyHqDG11DlTbQ7f57I
         86C29NH3uzAeAOAynZMOEBYzU5WXEjeuPLiMVFPf0iwBPxw4DficlLmwfePDKfc1Wo
         enLtVffSfg4mk2dZNaupAKHUMV6lTTAH9k5y29xFqjZoPATR/OFdJ0sda/fgfmT+oe
         y0nZigc4EwANA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2c022ce8114so37445661fa.1;
        Fri, 22 Sep 2023 07:14:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YwH+dC4DLLQdAmrJZOo8/yzXDIYv6bqgOi39+85VQfkMedFuI6G
        bN1WB0h7oQ01aoURI02zlLlMHBtZSufrT9tZDQ==
X-Google-Smtp-Source: AGHT+IHLg3zvq6lxP7QDJhcamQt8J+/HhjHmr80OQTyA6zn7ImZUA3UUttinPjYNRGBZK7/dvEUb04D//DX6nR71X1s=
X-Received: by 2002:a2e:b1c7:0:b0:2c0:3429:8167 with SMTP id
 e7-20020a2eb1c7000000b002c034298167mr7423906lja.11.1695392069409; Fri, 22 Sep
 2023 07:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230921102420.RFC.1.I9dddd99ccdca175e3ceb1b9fa1827df0928c5101@changeid>
In-Reply-To: <20230921102420.RFC.1.I9dddd99ccdca175e3ceb1b9fa1827df0928c5101@changeid>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 22 Sep 2023 09:14:15 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+noP32-m5xdUCLFPFBXLxX9Ys1BNFM+9sga6KYTmDzqQ@mail.gmail.com>
Message-ID: <CAL_Jsq+noP32-m5xdUCLFPFBXLxX9Ys1BNFM+9sga6KYTmDzqQ@mail.gmail.com>
Subject: Re: [RFC PATCH] of: device: Support 2nd sources of probeable but
 undiscoverable devices
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-input@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        andriy.shevchenko@linux.intel.com, broonie@kernel.org,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, james.clark@arm.com, james@equiv.tech,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        petr.tesarik.ext@huawei.com, rafael@kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 12:26=E2=80=AFPM Douglas Anderson <dianders@chromiu=
m.org> wrote:
>
> Support for multiple "equivalent" sources for components (also known
> as second sourcing components) is a standard practice that helps keep
> cost down and also makes sure that if one component is unavailable due
> to a shortage that we don't need to stop production for the whole
> product.
>
> Some components are very easy to second source. eMMC, for instance, is
> fully discoverable and probable so you can stuff a wide variety of
> similar eMMC chips on your board and things will work without a hitch.
>
> Some components are more difficult to second source, specifically
> because it's difficult for software to probe what component is present
> on any given board. In cases like this software is provided
> supplementary information to help it, like a GPIO strap or a SKU ID
> programmed into an EEPROM. This helpful information can allow the
> bootloader to select a different device tree. The various different
> "SKUs" of different Chromebooks are examples of this.
>
> Some components are somewhere in between. These in-between components
> are the subject of this patch. Specifically, these components are
> easily "probeable" but not easily "discoverable".
>
> A good example of a probeable but undiscoverable device is an
> i2c-connected touchscreen or trackpad. Two separate components may be
> electrically compatible with each other and may have compatible power
> sequencing requirements but may require different software. If
> software is told about the different possible components (because it
> can't discover them), it can safely probe them to figure out which
> ones are present.
>
> On systems using device tree, if we want to tell the OS about all of
> the different components we need to list them all in the device
> tree. This leads to a problem. The multiple sources for components
> likely use the same resources (GPIOs, interrupts, regulators). If the
> OS tries to probe all of these components at the same time then it
> will detect a resource conflict and that's a fatal error.
>
> The fact that Linux can't handle these probeable but undiscoverable
> devices well has had a few consequences:
> 1. In some cases, we've abandoned the idea of second sourcing
>    components for a given board, which increases cost / generates
>    manufacturing headaches.
> 2. In some cases, we've been forced to add some sort of strapping /
>    EEPROM to indicate which component is present. This adds difficulty
>    to manufacturing / refurb processes.
> 3. In some cases, we've managed to make things work by the skin of our
>    teeth through slightly hacky solutions. Specifically, if we remove
>    the "pinctrl" entry from the various options then it won't
>    conflict. Regulators inherently can have more than one consumer, so
>    as long as there are no GPIOs involved in power sequencing and
>    probing devices then things can work. This is how
>    "sc8280xp-lenovo-thinkpad-x13s" works and also how
>    "mt8173-elm-hana" works.
>
> Let's attempt to do something better. Specifically, we'll allow
> tagging nodes in the device tree as mutually exclusive from one
> another. This says that only one of the components in this group is
> present on any given board. To make it concrete, in my proposal this
> looks like:
>
>   / {
>     tp_ex_group: trackpad-exclusion-group {
>     };

Interesting way to just get a unique identifier. But it could be any
phandle not used by another group. So just point all the devices in a
group to one of the devices in the group.

>   };
>
>   &i2c_bus {
>     tp1: trackpad@10 {
>       ...
>       mutual-exclusion-group =3D <&tp_ex_group>;
>     };
>     tp2: trackpad@20 {
>       ...
>       mutual-exclusion-group =3D <&tp_ex_group>;
>     };
>     tp3: trackpad@30 {
>       ...
>       mutual-exclusion-group =3D <&tp_ex_group>;
>     };
>   };
>
> In Linux, we can make things work by simply only probing one of the
> devices in the group at a time. We can make a mutex per group and
> enforce locking that mutex around probe. If the first device that gets
> the mutex fails to probe then it won't try again. If it succeeds then
> it will acquire the shared resources and future devices (which we know
> can't be present) will fail to get the shared resources. Future
> patches could quiet down errors about failing to acquire shared
> resources or failing to probe if a device is in a
> mutual-exclusion-group.

This seems like overkill to me. Do we really need groups and a mutex
for each group? Worst case is what? 2-3 groups of 2-3 devices?
Instead, what about extending "status" with another value
("fail-needs-probe"? (fail-xxx is a documented value)). Currently, the
kernel would just ignore nodes with that status. Then we can process
those nodes separately 1-by-1. You may just have to change "status"
via a changeset as there's already some support in some buses (I2C,
SPI IIRC) for new devices showing up with overlays. I'm not really a
fan of adding the probe mutex and would prefer if we can serialize
this with just controlling "status". The challenge at that level is
knowing if/when you have probed especially if we have to wait on
modules to load. But if we must serialize with a mutex, with 1 group
it could be a global mutex and a 1 bit flag in struct device instead.

Rob
