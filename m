Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379117B2732
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjI1VLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjI1VLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:11:33 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A371BF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:11:28 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d8afe543712so842921276.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695935487; x=1696540287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02U1Rt8dFlpoDrbdGEdfT6fcRmNro9CBN5gcx8xV91U=;
        b=k4yhsOoLfhHIyLw8krnVaYc6Eh2X0CB3HOHUr2o7eNRWckWtL45+NOczHTH6aJvjzJ
         0NgYkf1rPaj38Gki3XksegiRzLHVciZTfdfQQ4UjWTM2DRZ+cbybAruQtsIMJhtAxI1n
         RNSCIul/NWZAD9iNbX8FewQr07ro1+yu/VT8+KX6TKR1Un8oADzk0RVXYAw/bO9kCMNJ
         inY6eETL+2azL5E4QccPFGTL8/MR2TckYrf9hJ+UwzLTdaa1/GI3bOC4hkUc2AqW2jCp
         woqQJq45G2meI7hIKSa0ShY8Zy9reYu+5E703CltK1A+SjsOOtRxULvDA+BWawgYaxjA
         9pGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695935487; x=1696540287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02U1Rt8dFlpoDrbdGEdfT6fcRmNro9CBN5gcx8xV91U=;
        b=hSbbxDZ/00NfLHhk7jRz6Qn6u2xrae9z5E7TQv/lFqfHJRGk6JYkvsBttpQqthir9t
         PsHdwdlmw0EjkEsL50gJ4cV+DusUPDErsGsmfiBbtjn9iyGGDnN0pL0FzBiVMsCdNsxu
         k4u+VdIpnpTPfDdrZw6BnOT1ItP4+nfDm6SJXqDsVDSALedB5Rf0njoRWPEJ6mbIxin4
         PFVcubuVaAZAdt2pL41sZBZq9+HypzO1M/+It5xfjRienC2ZYpo1wUmSJqDDzSjBsCuW
         je9SWMJSxsDq+pRGr/rAnVGSd9+XlE5qSjVcMiAXAabzVrmtA1eph5fHVlnDjtSU639h
         EvVw==
X-Gm-Message-State: AOJu0YxlGr+n3DvCCmeR/XlyaTVbLumve6+7TXggLNScbu3DdOR96axG
        W/jToPsvqN8M2dxmUcEzQbKGaAVo7RsLJDGfZiOmGg==
X-Google-Smtp-Source: AGHT+IG7dG2z/wMvGWlyeaYZaye5IJfggkazjCfjq/+A1dRkAVSKM04AuFkYyqiQ8ZkJbHP8pcUqsNPVHcEcRL5E11Y=
X-Received: by 2002:a25:c551:0:b0:d81:89e9:9f48 with SMTP id
 v78-20020a25c551000000b00d8189e99f48mr2434636ybe.63.1695935487097; Thu, 28
 Sep 2023 14:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230926160255.330417-1-robert.marko@sartura.hr>
In-Reply-To: <20230926160255.330417-1-robert.marko@sartura.hr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Sep 2023 23:11:16 +0200
Message-ID: <CACRpkdZem9Gtd==gQM4EQ9R8MN2ZQ0JCyMCoTjg0kqCNDjuFMA@mail.gmail.com>
Subject: Re: [PATCH] i2c: core: dont change pinmux state to GPIO during
 recovery setup
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     wsa@kernel.org, codrin.ciubotariu@microchip.com,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 6:03=E2=80=AFPM Robert Marko <robert.marko@sartura.=
hr> wrote:

> @@ -359,13 +359,6 @@ static int i2c_gpio_init_generic_recovery(struct i2c=
_adapter *adap)
>         if (bri->recover_bus && bri->recover_bus !=3D i2c_generic_scl_rec=
overy)
>                 return 0;
>
> -       /*
> -        * pins might be taken as GPIO, so we should inform pinctrl about
> -        * this and move the state to GPIO
> -        */
> -       if (bri->pinctrl)
> -               pinctrl_select_state(bri->pinctrl, bri->pins_gpio);
> -

But this might be absolutely necessary for other i2c drivers and this is
set in generic code.

My first question is: why is this platform even defining the "gpio" pin
control state for this i2c device if it is so dangerous to use?
If it can't be used, you just give it too much rope, delete the "gpio"
state for this group from the device tree: problem solved.

(This can be done with the specific /delete-node/ directive if
necessary, e.g. if you want to use the "gpio" state on other boards.)

Second: do you even want to do recovery on this platform then?
Is it necessary? What happens electronically in this case, if we don't
switch the pins to GPIO mode? Is it something akin to the "strict"
property in struct pinmux: that the GPIO block and the device can
affect the same pins at the same time? That warrants an explanation
and a comment.

If you can't delete the "gpio" pin control state, I would add a
bool pinctrl_stay_in_device_mode;
to
struct i2c_bus_recovery_info
in include/linux/i2c.h

And just:

if (bri->pinctrl && !bri->pinctrl_stay_in_device_mode)
    pinctrl_select_state(bri->pinctrl, bri->pins_gpio);

(Also the switch to the "default" state further down could be
contitional !bri->pinctrl_stay_in_device_mode)

But mostly I wonder why the "gpio" pin control state is defined, if it's
not to be used.

Yours,
Linus Walleij
