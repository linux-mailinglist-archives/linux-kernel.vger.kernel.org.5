Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A5176D82C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjHBTuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjHBTus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:50:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797AB1BD9;
        Wed,  2 Aug 2023 12:50:46 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso2402545e9.1;
        Wed, 02 Aug 2023 12:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691005845; x=1691610645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIsEdvHTkRHt69kFNg/UK9NrCtXb0lJcor4CbmeS9Hk=;
        b=R5wZp/xcsv35BlfRKilsYrHF1dhaqJAiOM88mITtX2ac33Ys3k+SZ6hzpyoP/EncS0
         PlQlnh1B7WsiB34wEYWeyPFGel3GTMWqUs22JBAS+xCX34/eQc8oHTV20pe079jQhUco
         AldAYBl/7BQOilco0TIDkaCBEW0kNsLo3iTG/2CPGR1jfreq+IHr2a+e3MGq5JIKK8dg
         SW7X+kfIrvWwvm0b7kU7zwCGGHiZ97UmhrFkkEnCt2Uyb9Ui9eqGZrbQPt1HyrL+vrBA
         67CIrGTNbdPKee5Va56I3zOhucFhXGpEIe34NknlPMpPBl9onEfZdJ0qge0LONsurRXX
         uSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691005845; x=1691610645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIsEdvHTkRHt69kFNg/UK9NrCtXb0lJcor4CbmeS9Hk=;
        b=A2u/RVhOGRAe2Y76PY1FWmC5Amv7pRAk8WqcHEB2/eSmnKwG00hsHjblqsIzi/rO3A
         /1xCtLe2ShZoCyz0hKkgto2RAJDYPHzqKqGOFPH+dJru580m2KwEep4sA0M/coQcQOZa
         rOt67Swj4sxOmsd3+aB7gLEGTPQ3V5ISyPjdxsxgP3Lh0NyQL2+bEqQHKty1CaMcvLlx
         ubbQe3YHYPoTAmQFyNovN/C8/lZYe0XcF61qEJJTRaLMksWoXXAqe29kTLTZSnANJdrw
         0Ar4mCmVnQVcR3X51Dk14cV7+PY63dqvabE4pBHAhQedrLntIHp1HegRyL5eZGHDHrhq
         lmPA==
X-Gm-Message-State: ABy/qLZFB4WDiPbFQLHaAScETyCmrO7JMtnWC4ksEW5j6ZjVaI0BcVsp
        TNVRp+ec4c24wb0Y86ftaqs=
X-Google-Smtp-Source: APBJJlHHgd2WIdq0IccJQZ2AKkE0gkK04uGb9tNRmFHgVwOqmlDWdtUcLWuRXjitS2H+CPmD7MrvSg==
X-Received: by 2002:a1c:7511:0:b0:3fe:2f31:8bf7 with SMTP id o17-20020a1c7511000000b003fe2f318bf7mr2864638wmc.26.1691005844631;
        Wed, 02 Aug 2023 12:50:44 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id a23-20020a05600c225700b003fc01495383sm2418619wmm.6.2023.08.02.12.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 12:50:44 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] riscv: dts: allwinner: d1: Add QSPI pins node for pinmux
 PC port
Date:   Wed, 02 Aug 2023 21:50:39 +0200
Message-ID: <5956489.lOV4Wx5bFT@jernej-laptop>
In-Reply-To: <CALHCpMgXy0pLiVR8V48Roi82EJ7Zrx-Xyc-6etjgkmN0B7pb8A@mail.gmail.com>
References: <20230624131632.2972546-1-bigunclemax@gmail.com>
 <10311404.nUPlyArG6x@jernej-laptop>
 <CALHCpMgXy0pLiVR8V48Roi82EJ7Zrx-Xyc-6etjgkmN0B7pb8A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 31. julij 2023 ob 17:22:11 CEST je Maxim Kiselev napisal(a):
> =D0=BF=D0=BD, 31 =D0=B8=D1=8E=D0=BB. 2023=E2=80=AF=D0=B3. =D0=B2 01:30, J=
ernej =C5=A0krabec <jernej.skrabec@gmail.com>:
> > Dne sobota, 24. junij 2023 ob 15:16:24 CEST je Maksim Kiselev napisal(a=
):
> > > Add pinmux node that describes pins on PC port which required for
> > > QSPI mode.
> > >=20
> > > Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> > > ---
> > >=20
> > >  arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> > > b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi index
> > > 1bb1e5cae602..9f754dd03d85 100644
> > > --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> > > +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> > > @@ -131,6 +131,13 @@ uart3_pb_pins: uart3-pb-pins {
> > >=20
> > >                               pins =3D "PB6", "PB7";
> > >                               function =3D "uart3";
> > >                      =20
> > >                       };
> > >=20
> > > +
> > > +                     /omit-if-no-ref/
> > > +                     qspi0_pc_pins: qspi0-pc-pins {
> > > +                             pins =3D "PC2", "PC3", "PC4", "PC5",
> >=20
> > "PC6",
> >=20
> > > +                                    "PC7";
> > > +                             function =3D "spi0";
> > > +                     };
> >=20
> > Sorry for late review, but it seems I'm missing something. D1 manual sa=
ys
> > those are pins for ordinary SPI, with HOLD and WP signals. Can they be
> > repurposed for quad SPI?
>=20
> Yes, they can. Here is a quote from D1 datasheet (9.3.3.8 SPI
> Quad-Input/Quad-Output Mode):
> "Using the quad mode allows data to be transferred to or from the
> device at 4 times the rate of standard single mode, the data can be
> read
> at fast speed using four data bits (MOSI, MISO, IO2 (WP#) and IO3
> (HOLD#)) at the same time."

Alright then.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



