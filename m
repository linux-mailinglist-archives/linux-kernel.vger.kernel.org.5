Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A20767B8F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 04:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjG2Cks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 22:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjG2Ckq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 22:40:46 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587A93AB4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 19:40:44 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-407db3e9669so80871cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 19:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690598443; x=1691203243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NrLZi3foDUatZBoIkenMkjoRONfSU8tPYtCO27XOHo=;
        b=Mpi2WwucoJYesAk8LQZlRMAYCcoIL+dmOK1VCVtj0lpFFBRi+aku1i2pVB1B2dTKjE
         EEIjt4Di3ybauCm3/RASeSfwSBvexJ77pDe4q1iWrwKuNkgfIZ2vujQ8AnYhnnW46WkM
         HAvsMUy7NyE6HGQNDOB5d6WOEecRre2EzvOp+Z7FEzuRSAuZiYo5vnHwvcfgiRZ2AVYX
         rkkLLc4saeJAJpM+WTSzQfd5yF6rCn/UYM3sDaNVFQxArFa2qZCG/zrLh4h8y72YNk5D
         imZ0uA1fLAgCr4YlBOlbTaxglVVKb/elMCHSbM1+Qw+w2uMKoUmIf/bJrugWL2HvcHOy
         7rsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690598443; x=1691203243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NrLZi3foDUatZBoIkenMkjoRONfSU8tPYtCO27XOHo=;
        b=AyHpDDbEv/qsy55pfeLlRx2Ibcqtva4E2nefI+wBYz3QKHOBlrYDtEuplQWY1T8856
         kkf/W/5m73jiiTZkS4I48oJH4VyYo31d25kzHK5iLdpUPHMaGfAudcVZxdRIeu5vkVhH
         wvI4B6Iuyzkk1t/B6LSzbbbpUcKFhVHhQ1bLA0qP5ZLseSxEPdDun79dJ+0nLhciTxMp
         H+NKDqm6lNfwIVYGIun6Kh4enQp/mr7wZGgtMV7KyVQA9ymzYAPQTWKh7A7FGVLcsKow
         PgKrNGod6yB3mPpeeTugphrZ8vt+GFMuWHPiokHntCjljniAIu8JMIkixFi8UuNIoZTz
         Mp5A==
X-Gm-Message-State: ABy/qLaGu4xA9f+OPn3XZwvwJw4OuHVuvswT21k3aMbtysR7bHQvj1RO
        T4qpsiUeWiieyIuYv1CfS34orxb+SMfCGBe8E00Y5g==
X-Google-Smtp-Source: APBJJlE1s9BZpmQZ6sS26qjuS8QTWGeDAVPasMUvPtrhTUyDAE+3xOPRIkDhH5vfxNuEaj0MEKJw903Q7cEjpiUqgcA=
X-Received: by 2002:ac8:5c05:0:b0:3f8:e0a:3e66 with SMTP id
 i5-20020ac85c05000000b003f80e0a3e66mr70647qti.3.1690598443401; Fri, 28 Jul
 2023 19:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 28 Jul 2023 19:40:29 -0700
Message-ID: <CABXOdTfUs9wySb5ho+SS5MXVRwaD8gvJoUomS9NSx=QeU5nUxA@mail.gmail.com>
Subject: Re: [PATCH 01/22] Input: cros_ec_keyb - use device core to create
 driver-specific device attributes
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 5:51=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Instead of creating driver-specific device attributes with
> devm_device_add_group() have device core do this by setting up dev_groups
> pointer in the driver structure.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/input/keyboard/cros_ec_keyb.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboa=
rd/cros_ec_keyb.c
> index e7ecfca838df..313b7a69dd69 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -686,10 +686,11 @@ static umode_t cros_ec_keyb_attr_is_visible(struct =
kobject *kobj,
>         return attr->mode;
>  }
>
> -static const struct attribute_group cros_ec_keyb_attr_group =3D {
> +static const struct attribute_group cros_ec_keyb_group =3D {
>         .is_visible =3D cros_ec_keyb_attr_is_visible,
>         .attrs =3D cros_ec_keyb_attrs,
>  };
> +__ATTRIBUTE_GROUPS(cros_ec_keyb);
>
>  static int cros_ec_keyb_probe(struct platform_device *pdev)
>  {
> @@ -730,12 +731,6 @@ static int cros_ec_keyb_probe(struct platform_device=
 *pdev)
>                 return err;
>         }
>
> -       err =3D devm_device_add_group(dev, &cros_ec_keyb_attr_group);
> -       if (err) {
> -               dev_err(dev, "failed to create attributes: %d\n", err);
> -               return err;
> -       }
> -
>         ckdev->notifier.notifier_call =3D cros_ec_keyb_work;
>         err =3D blocking_notifier_chain_register(&ckdev->ec->event_notifi=
er,
>                                                &ckdev->notifier);
> @@ -782,6 +777,7 @@ static struct platform_driver cros_ec_keyb_driver =3D=
 {
>         .remove =3D cros_ec_keyb_remove,
>         .driver =3D {
>                 .name =3D "cros-ec-keyb",
> +               .dev_groups =3D cros_ec_keyb_groups,
>                 .of_match_table =3D of_match_ptr(cros_ec_keyb_of_match),
>                 .acpi_match_table =3D ACPI_PTR(cros_ec_keyb_acpi_match),
>                 .pm =3D pm_sleep_ptr(&cros_ec_keyb_pm_ops),
> --
> 2.41.0.487.g6d72f3e995-goog
>
