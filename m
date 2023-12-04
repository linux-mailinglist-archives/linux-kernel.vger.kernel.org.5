Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D2B803C93
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjLDSPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjLDSPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:15:51 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C2BB6;
        Mon,  4 Dec 2023 10:15:57 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-67abd1879c0so10502236d6.2;
        Mon, 04 Dec 2023 10:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701713757; x=1702318557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrXoxXZcL5o0bwmshlpciFrBa2ROqvh7a5sct4i1UKg=;
        b=VNOFqti7W1dvOey8wS/CevNZ6k3q2ayPRlfSliWPGTV3koJeYVHAGkXCKNDhdurzLu
         PTJhT2+P0NUQVj/tFfmZm5i9mM+d+ovv3+1Xe8GZ5onxct5rwLSSwAUM9a6YSnB43Mu/
         YRH0ocq4WbAUILVykqHXROqMlMIZ0WF9JY2+o89WpM0BeVDP9BIeZZvyL3GAjYvl9ugh
         6WRxNxAN/jeslzWEvadnIAb7B+v5pXRKJxsTHRj+uGVjAi2jb7KFNvCB0LlW/LQ5x//L
         l9Aal1g/w7AwpWUlIEIpYEzvLi56JThF/547xXnvKtt/HVfgR5X9kN4sU6wd2cwDWkak
         WdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701713757; x=1702318557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrXoxXZcL5o0bwmshlpciFrBa2ROqvh7a5sct4i1UKg=;
        b=hAW1Q9WzkDOub318Q6fGznTKrboScFF/3FxaYuEfPE1+csNm35HN6ezzL55PCn18ye
         H+SPxHov4U9xOGkrNzX9DUYsJuN3Yz1HrfLMKz0ybNSKYPkDMWoD7vFiPY4W99E6x3Ba
         BRXukuOfNSip+GEzddvDE/iT0ERU3i6UmOCWLKmISVHFOHcFWfqRNzzWy5LoDwKNyVz3
         a4Ic6w7ryIB+ICj5vKOyJ6lhH2b4LdbcdNxPK6t32q3OevYEb2VXAwkb1/my0asFPbM0
         zW22dbHFMXGKfHmM41WQtXQYu4kxmCD4EoZLXMGvm0ky0/7E+ANHTSWYM/5VRgHwDZTC
         mzgQ==
X-Gm-Message-State: AOJu0YyfFp900RW+4pCUpglKg8H+3Z39WZsbq/kiTU/XHM+SYuXr70RL
        uXZKC5Q534Of1xrZ13Gj1mqrzBaIkHseu8i0R+k=
X-Google-Smtp-Source: AGHT+IEjajfDd9RKlx7gFUwETBFW3qgAL1nJLNuT4J6PaOtDNdIF8ZKAVyxaqgT8rgBPT4oZQm5GDMnO9BQ+GnLJeQ0=
X-Received: by 2002:a05:6214:1409:b0:67a:96c7:4c90 with SMTP id
 pr9-20020a056214140900b0067a96c74c90mr5715457qvb.38.1701713757080; Mon, 04
 Dec 2023 10:15:57 -0800 (PST)
MIME-Version: 1.0
References: <20231204180603.470421-1-gnstark@salutedevices.com> <20231204180603.470421-4-gnstark@salutedevices.com>
In-Reply-To: <20231204180603.470421-4-gnstark@salutedevices.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Dec 2023 20:15:21 +0200
Message-ID: <CAHp75VeQ86JnDF=nJ_AK5zTPB7BkOvn9wU+GottY_PV7JHzGTg@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] leds: aw2013: use devm API to cleanup module's resources
To:     George Stark <gnstark@salutedevices.com>
Cc:     pavel@ucw.cz, lee@kernel.org, vadimp@nvidia.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hdegoede@redhat.com, mazziesaccount@gmail.com, jic23@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel@salutedevices.com
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

On Mon, Dec 4, 2023 at 8:07=E2=80=AFPM George Stark <gnstark@salutedevices.=
com> wrote:
>
> In this driver LEDs are registered using devm_led_classdev_register()
> so they are automatically unregistered after module's remove() is done.
> led_classdev_unregister() calls module's led_set_brightness() to turn off
> the LEDs and that callback uses resources which were destroyed already
> in module's remove() so use devm API instead of remove().

...

> +static void aw2013_chip_disable_action(void *data)
> +{
> +       struct aw2013 *chip =3D (struct aw2013 *)data;
> +
> +       aw2013_chip_disable(chip);
> +}

As with mutex release, this also can be oneliner

static void aw2013_chip_disable_action(void *chip)
{
       aw2013_chip_disable(chip);
}

...

> +       if (devm_mutex_init(&client->dev, &chip->mutex))
> +               return -ENOMEM;

Shouldn be

       ret =3D devm_mutex_init(&client->dev, &chip->mutex);
       if (ret)
           return ret;

?

> +               return -ENOMEM;

--=20
With Best Regards,
Andy Shevchenko
