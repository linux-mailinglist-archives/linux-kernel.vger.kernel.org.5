Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3718C801B89
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 09:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjLBIgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 03:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjLBIgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 03:36:44 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D957D6C;
        Sat,  2 Dec 2023 00:36:50 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-33330305372so1261768f8f.3;
        Sat, 02 Dec 2023 00:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701506209; x=1702111009; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W1Cz0Am5xXhDu9ok/VyPf97AG12MnC7CAXjo29WYQyA=;
        b=F8GXHgImotqHhG1331JclfAugip4b6+Hbx2zn+P9NaE6JdfDP/zZJPQGstZd917Awd
         dZ6NRBn8CfRMU8bkS2xg17M1yHrDY/3yzUR6zNVoNkANcxzjxD5BfFUevNR3VQVZ+pDs
         Ga30V6peVOhmrbWi9OzXKTOsjtOzzauNvTa7hzstLB50S09kfln0n2aRl5FfPmWaEe/x
         l1kQJuA2JPIGroxY8/hsUlT86wc2qHjWpQcOWtI0h1LROYGXIM7dwt4BHsFPtNKNEtfI
         Zp66Dw3B0HZoZMsziuI/eMtyHnvEIuTcdUnpcgIYszaTBqxW93td5XM5sD+cpdzn5vJ/
         TyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701506209; x=1702111009;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W1Cz0Am5xXhDu9ok/VyPf97AG12MnC7CAXjo29WYQyA=;
        b=OXM34YHQd7Asf4tSnumT+SwFQd+z20sWQDBfcx+JxzGcKEntoGvVfIeEpdZzFpitkO
         np05VCALtZggVJtBD0EQfbY6BDj2Ew5Txn2dc0w3w/3tnHG+gaAvzckNuPBOO2qNBenN
         Unei1kQmJfvj4Dq8GvviWZvlzgiZ4YDWcbhkKnrpB0rJIM1J1YmPXEBm5tNCXHrPwaIT
         syOxBkxyDWYOgujazs0S+lbcYhUkuXtO1ESfcmb3/ocjwr9qwQPdxeJdIG0IJFufuJgP
         gCiy5lu0MjP3/qCKzDbVHDeGdx6DsIQi5ny3r2JNoDwTuCcAcMJkr4ssej5MmHpt7uIg
         6IbA==
X-Gm-Message-State: AOJu0YzC4zcDXqmWcBPSTIB+2E86hXTXKp2a8Yvx57pzvCD3ItuRlTrc
        4gjHb1BxGNfWSJtBGL6swd42jKwJiDTh5OYg
X-Google-Smtp-Source: AGHT+IHfOF9eY0WrOu55dMkRd4h3vvFangyeO/vbLfS+S7/JyE28Xxaslwnvil95OAMEwGRBkNthTw==
X-Received: by 2002:a05:6000:8c:b0:332:d504:c138 with SMTP id m12-20020a056000008c00b00332d504c138mr1564309wrx.1.1701506208355;
        Sat, 02 Dec 2023 00:36:48 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600002a700b00332eb16d215sm6278953wry.23.2023.12.02.00.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 00:36:47 -0800 (PST)
Message-ID: <3925cb4b6453644c889675c20329b3477a06fcd5.camel@gmail.com>
Subject: Re: [PATCH 04/12] iio: adc: ad9467: fix reset gpio handling
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     David Lechner <dlechner@baylibre.com>
Cc:     nuno.sa@analog.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Sat, 02 Dec 2023 09:36:47 +0100
In-Reply-To: <CAMknhBGjm2ja9HOenOWi9O5Ao8qUg=gT=_Vz8CyxQ=pfNX2EJQ@mail.gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
         <20231121-dev-iio-backend-v1-4-6a3d542eba35@analog.com>
         <CAMknhBGCqnzCp6vQ+59Z-SybScvbtU7aWdAD6KnP1e6=q60gVQ@mail.gmail.com>
         <d534c3323c32d4ed2aedae19a9f101be90ef0cc7.camel@gmail.com>
         <CAMknhBGjm2ja9HOenOWi9O5Ao8qUg=gT=_Vz8CyxQ=pfNX2EJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-01 at 11:01 -0600, David Lechner wrote:
> On Fri, Dec 1, 2023 at 2:47=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
> >=20
> > On Thu, 2023-11-30 at 15:41 -0600, David Lechner wrote:
> > > On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> > > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > > >=20
> > > > From: Nuno Sa <nuno.sa@analog.com>
> > > >=20
> > > > The reset gpio was being requested with GPIOD_OUT_LOW which means, =
not
> > > > asserted. Then it was being asserted but never de-asserted which me=
ans
> > > > the devices was left in reset. Fix it by de-asserting the gpio.
> > >=20
> > > It could be helpful to update the devicetree bindings to state the
> > > expected active-high or active-low setting for this gpio so it is
> > > clear which state means asserted.
> > >=20
> >=20
> > You could state that the chip is active low but I don't see that change=
 that
> > important for now. Not sure if this is clear and maybe that's why your =
comment.
> > GPIOD_OUT_HIGH has nothing to do with active high or low. It just means=
, "get me
> > the
> > pin in the asserted state".
> >=20
>=20
> I would assume that this bug happened in the first place because
> someone forgot GPIOD_OUT_LOW in the devicetree when they were
> developing the driver. So this is why I suggested that updating the
> devicetree binding docs so that future users are less likely to make
> the same mistake. Currently, the bindings don't even have reset-gpios
> in the examples.

Hmm, I think you're missing the point... The bug has nothing to do with dev=
icetree.
This is what was happening:

1) We were calling devm_gpiod_get_optional() with GPIOD_OUT_LOW. What this =
means is
that you get an output gpio deasserted. Hence the device is out of reset. A=
nd here is
the important part... what you have in dts does not matter. If you have act=
ive low,
it means the pin level will be 1. If you have high, the pin level is 0. And=
 this is
all handled by gpiolib for you.

2) Then, we called gpiod_direction_output(..., 1), which means set the dire=
ction out
(which is actually not needed since it was already done when getting the pi=
n) and
assert the pin. Hence, reset the device. And we were never de-asserting the=
 pin so
the device would be left in reset.

- Nuno S=C3=A1
