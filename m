Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598F3768A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 04:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjGaCwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 22:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGaCwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:52:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0531FE47;
        Sun, 30 Jul 2023 19:52:22 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bcd6c0282so635042666b.1;
        Sun, 30 Jul 2023 19:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690771940; x=1691376740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLKpbSPGzXDuDP4SHea1EinIC04xetUtSoOaZK7zadI=;
        b=TIUk1xsJFtc/l1rkYdG1pQM7UONNtqxRPkuH29DeHBA3RYK88MDM3fdhyAL3UpWqAN
         3PePMM62m3sNz9z8xLjzpz2Fdy5mmep8Ic9ixGyw42cjUmxceDuN0thJaZqe0BSex32l
         SOUgBP6TfjUvX6p6Yw7PWQ/zsbtDPu3pG0T2NyKntDUW69+9J8jcGeGcFkk/msujXFE5
         bEi/IEZkFpDw54AaMMFtIrE0lIHB3jzMeqwA1zAwn8B/vgfAe15/kQ2vtw2+/dYfUJM2
         YMNf5rVO+HynIBmPeSggR8VZqi3LJEGfE22iYvUu4vKfLmLNHvyzVdNUcRviDG5mCkOT
         snbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690771940; x=1691376740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLKpbSPGzXDuDP4SHea1EinIC04xetUtSoOaZK7zadI=;
        b=NFL7YJS219luG9SFd6B90RjJ98cn2X7YX1GkIUXOtRxsXUADT3VJi2YioFWkOBKSIi
         pd69vGyj3RFlwxSLrH6eMscC3OYZ8UjqumxNCa9UcDB05sslaVzqUmC7KaayUI9KI1pl
         PibJZFwqqOdrNJmCRLQKbBB1KU49311mQuQiegY821HipzBIUu9oHaidoogmP6JswRm0
         cxPsQcDV2fMrSydWNIxdE+weyXStLzWUWQHd+hWgiroS9xc6Jta2gKCfKgWtOujUKUqF
         vgxzMMKq/yGTdDtfve3wLRhrQyGFF4fVMAUYAW89aCefUqx/s1YgCu5AaVAukI/tcL1I
         BrbQ==
X-Gm-Message-State: ABy/qLYMmnwknYf6gCn5hQbQ1LSpiRNofCvhQaW7AWUno8WvNSwRhGor
        8teExbyfiAjO0C+BRwXr+LICuPKM3ae1SoapAyc=
X-Google-Smtp-Source: APBJJlEN2cSvwOt5awG0AZZHeBr3zDivNmi+GZamrE/u79nfCP/SKQTNWjC9vvTZ4cd+LlzKGlRBvL+eXBNs5K8DgYw=
X-Received: by 2002:a17:907:7819:b0:99b:f392:10b1 with SMTP id
 la25-20020a170907781900b0099bf39210b1mr6092103ejc.37.1690771940131; Sun, 30
 Jul 2023 19:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
 <20230729134318.1694467-7-keguang.zhang@gmail.com> <551ac5ae-2ccf-0a7e-46df-e1b05e8163cc@linaro.org>
In-Reply-To: <551ac5ae-2ccf-0a7e-46df-e1b05e8163cc@linaro.org>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Mon, 31 Jul 2023 10:52:03 +0800
Message-ID: <CAJhJPsW+WkdA1kXBn=J2biAUn_GXH8PiBmsZ9UKSYJaWvK0Oog@mail.gmail.com>
Subject: Re: [PATCH 06/17] MIPS: loongson32: Convert platform IRQ driver to DT
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 4:24=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/07/2023 15:43, Keguang Zhang wrote:
> > This patch enables Loongson-1 irqchip driver
> > by adding platform INTC device nodes.
> > And drop the legacy platform IRQ driver accordingly.
> >
> > Based on previous patch by Jiaxun Yang.
> >
> > Link: https://lore.kernel.org/all/20190411121915.8040-3-jiaxun.yang@fly=
goat.com
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> >  arch/mips/boot/dts/loongson/loongson1.dtsi  |  53 ++++++
> >  arch/mips/boot/dts/loongson/loongson1c.dtsi |  13 ++
>
> DTS is always separate from the drivers.

Got it. Will do.
>
> >  arch/mips/loongson32/common/Makefile        |   2 +-
> >  arch/mips/loongson32/common/irq.c           | 191 --------------------
> >  arch/mips/loongson32/init.c                 |   5 +
> >  5 files changed, 72 insertions(+), 192 deletions(-)
> >  delete mode 100644 arch/mips/loongson32/common/irq.c
> >
>
>
>
> Best regards,
> Krzysztof
>


--=20
Best regards,

Keguang Zhang
