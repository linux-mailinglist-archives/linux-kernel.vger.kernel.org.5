Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B8C7CF360
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344919AbjJSI5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjJSI5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:57:33 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0244C0;
        Thu, 19 Oct 2023 01:57:31 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66d0169cf43so49128196d6.3;
        Thu, 19 Oct 2023 01:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697705851; x=1698310651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfG7yXeQOrqyeFt+i2oHLTbkjrUziurPpvi/iRBx44E=;
        b=bonkjiQ0JIVAwQnFa1DTsOOFp7qQrGqZwFu/RSHewtIvUoXSjyexpkj+U4FBz4jB0r
         /0J3tEh9ilXMsIXC7lDpnc2FRM6oUAc2oyMOUoqcLYYLih8eegaTq5hdArjJmaBawoXX
         sYLGeO2a4Vj64seNkrzdZRimrd8TTTh0H+gmIU8HHCARSLXm26GkWL9Cp1HAJXaTr6hd
         SPilRfbCoWquaQ4mssgHPaI6B0OKraCqQY5vI509LjeWHoSer0jyFkTsfsqTV7HNXYxZ
         5YqJgTgjahpmpzyIbrKgBpsdMTq9W0mufvci6ry60zTv7zL5j046CekqP5yCc/BltkUf
         aqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697705851; x=1698310651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfG7yXeQOrqyeFt+i2oHLTbkjrUziurPpvi/iRBx44E=;
        b=NcJgxugHYg1t7GxS6UzPpM6HwANXDQkjsed/ZKNm5LVLplfLCivjEops6PgQjO8Itx
         CX6Yo/Iz/4arprmzVSGMKgZWdGEpJygRO9AY2rPy8EdZGenDIG1kbTAtqASeOe+1QkoS
         JV/R3d8x6iKPYPjFh8Azm9Ckz2xiyQeduvR7cxArfINqMvwWkLDivkHOpAnWiT3TcPfM
         Eue54CrWZUmawQVVnm3TgTH1Jtu685MvAZzP71wJXqrRlPREpPUmNzqyrVisV78Mqsxn
         bLHlLYhDzaEhvPX5QX0tp8lYldlES6/kd8GVkZfKD+JIGp5Li/1bEfTYgoC6KlNc8DgY
         FCLQ==
X-Gm-Message-State: AOJu0Yw6Y6G5yfn5TGkhETsTht5H2Rf8f6PvXTQLGSNvrkoMpRlNQUV1
        c5jmGuAxio6a5hbBB0nQ4GeXHm1/gia8F4CVCWGteEcYW6M=
X-Google-Smtp-Source: AGHT+IF/qOCsq9MQ5J02hR8T3TDhwvoL+Ax3X/yGk6sp5gCqt9R0E1RPVbSXlxAqn6D2ptGaeHINIgGii8mACM+ispk=
X-Received: by 2002:a05:6214:cca:b0:66d:20f5:23cb with SMTP id
 10-20020a0562140cca00b0066d20f523cbmr1830308qvx.5.1697705850902; Thu, 19 Oct
 2023 01:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231018182943.18700-1-ddrokosov@salutedevices.com> <20231018182943.18700-3-ddrokosov@salutedevices.com>
In-Reply-To: <20231018182943.18700-3-ddrokosov@salutedevices.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Oct 2023 11:56:54 +0300
Message-ID: <CAHp75VcyvEdkzx4emYwssdYuqAiPdx5iqc-tY74_ebZfLKKM3A@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] leds: aw200xx: support HWEN hardware control
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     lee@kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        kernel@sberdevices.ru, rockosov@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 9:29=E2=80=AFPM Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> HWEN is hardware control, which is used for enable/disable aw200xx chip.
> It's high active, internally pulled down to GND.
>
> After HWEN pin set high the chip begins to load the OTP information,
> which takes 200us to complete. About 200us wait time is needed for
> internal oscillator startup and display SRAM initialization. After
> display SRAM initialization, the registers in page 1 to page 5 can be
> configured via i2c interface.

Is there any Documentation update for this new binding?

...

> +       chip->hwen =3D devm_gpiod_get_optional(&client->dev, "hwen", GPIO=
D_OUT_HIGH);

With _optional APIs we distinguish 3 cases: found, not found, error.
And error can be (among others) the deferred probe, meaning that GPIO
_is coming_. Hence the rule of thumb for the _optional() APIs is to
check for error and bail out on that condition (note, it's applicable
to any _optional() APIs, not limited by GPIO library).

...

>         aw200xx_chip_reset(chip);
> +       aw200xx_disable(chip);

It seems it can be modeled as a (GPIO) regulator. At least many
drivers do so, but I leave this to the maintainers to decide.

--=20
With Best Regards,
Andy Shevchenko
