Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB6180075F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378037AbjLAJpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378047AbjLAJpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:45:39 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CC010F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:45:45 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-4645a9ab3d2so534484137.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 01:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701423944; x=1702028744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ekfjW5/RgeJMklE7juR1PMpyxSeXgb7TqD/ojEgNQc=;
        b=RiGjBsq508f4Xnodj8k5T9pILSjQRsHEhMzLYt37HgBTQtRbfowOIOb9wfbMgzVXCd
         0/NdgOaZeeGhkSbomoGCl3c+918KoFMrdJCg8xRcpZTbfu1TygZSMUbxTHwtug34Kfzd
         I65Xjnp9YQo5CGIDwqRNDs3C9o1wMzujGSn2ORkL3ulKAnDh6gLbE7/L1ydp7RJdisso
         yCGdTBOfdJHykysDnP6dQiFHLecWAK0eS/PHcIsPAb9/Ge80jIhb8OwdmG4iIQpEeGKa
         SWdISdHaHgR0nGtxE0dkPpCiPKT3p9frsfaIsyYFhx1VCArOLbCKqq90s4kFBcOwZiup
         z9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701423944; x=1702028744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ekfjW5/RgeJMklE7juR1PMpyxSeXgb7TqD/ojEgNQc=;
        b=DDZ/sa888d4vt73Sv6qoTwf3kOeG7RoPYuBxvrUpnGXyw4QWd4dmFN2sx28n5GGN2k
         kfCLrYX1UfaqRp60oxrpuPdoFZrwJGD/4l2ziuGyl+lTDJ7sXhLANQFHCX7a8UrJB9Ho
         uDC1eZKQ+45tvJuhTnDX8UmytAvChioy/oJtP+AeNqm/t4PlnwMcKrsTlhy1u3jd2z6p
         CdyNFCb7XPKm0ZpFHVqvnb3TrA+eutYH+p3cLduZiwxpC97aXLVLrYQ3bdv5qu3svgcb
         k3WKeK5mRmVhMK+lVBoMHiZdMeOux11JFVVqaMh6Jf7BDbFb9S7ENy/rdumQOn/l7XKZ
         HODw==
X-Gm-Message-State: AOJu0Yzv8Xb88569jGGZ6qz6AJBzT5Okpg4a8ET474KZCfyEv8QrJBsZ
        UL5dkG9N0t4dpLL0LIAPFT5MR9FxadhwapIERsqP6w==
X-Google-Smtp-Source: AGHT+IFr+Ufz2SBZX19p2XbDRne9u7F1ltfFub1k2ZxTvyuIg3+ny5t7o6ebQ713T2lIv6X1Ub4M1HAWVO27LQo6MNk=
X-Received: by 2002:a05:6102:450:b0:464:6018:abc5 with SMTP id
 e16-20020a056102045000b004646018abc5mr3747554vsq.5.1701423944545; Fri, 01 Dec
 2023 01:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20231129152307.28517-1-boerge.struempfel@gmail.com>
In-Reply-To: <20231129152307.28517-1-boerge.struempfel@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 1 Dec 2023 10:45:33 +0100
Message-ID: <CAMRc=Mc6YV0ayaaSO9CnxnTGT4FAe7kADt+j32xKY+xh1OwBRQ@mail.gmail.com>
Subject: Re: [PATCH v3] gpiolib: sysfs: Fix error handling on failed export
To:     Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     andy@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Rob Herring <robh@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, bstruempfel@ultratronik.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 4:23=E2=80=AFPM Boerge Struempfel
<boerge.struempfel@gmail.com> wrote:
>
> If gpio_set_transitory() fails, we should free the GPIO again. Most
> notably, the flag FLAG_REQUESTED has previously been set in
> gpiod_request_commit(), and should be reset on failure.
>
> To my knowledge, this does not affect any current users, since the
> gpio_set_transitory() mainly returns 0 and -ENOTSUPP, which is converted
> to 0. However the gpio_set_transitory() function calles the .set_config()
> function of the corresponding GPIO chip and there are some GPIO drivers i=
n
> which some (unlikely) branches return other values like -EPROBE_DEFER,
> and -EINVAL. In these cases, the above mentioned FLAG_REQUESTED would not
> be reset, which results in the pin being blocked until the next reboot.
>
> Fixes: e10f72bf4b3e ("gpio: gpiolib: Generalise state persistence beyond =
sleep")
> Signed-off-by: Boerge Struempfel <boerge.struempfel@gmail.com>
>
> ---
>
> V2: https://lore.kernel.org/linux-gpio/CAEktqcv8NC0Cy+wo7nRGOp9USoBdta=3D=
n=3Dmrbo-WomxgcmWN5nQ@mail.gmail.com/T/#t
> V1: https://lore.kernel.org/linux-gpio/CAEktqcuxS1sPfkGVCgSy1ki8fmUDmuUsH=
rdAT+zFKy5vGSoKPw@mail.gmail.com/T/#t
>
> Changes from V2:
>         - Capitalized all occurances of GPIO in commit message
>         - Added Missing - in front of Error Code in commit message
>         - Added Fixes Tag in commit message
>
> Changes from V1:
>         - Marked all functions in commit message with parenthesis
>         - Elaborated in commit message
>
>  drivers/gpio/gpiolib-sysfs.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
> index 6f309a3b2d9a..12d853845bb8 100644
> --- a/drivers/gpio/gpiolib-sysfs.c
> +++ b/drivers/gpio/gpiolib-sysfs.c
> @@ -474,14 +474,17 @@ static ssize_t export_store(const struct class *cla=
ss,
>                 goto done;
>
>         status =3D gpiod_set_transitory(desc, false);
> -       if (!status) {
> -               status =3D gpiod_export(desc, true);
> -               if (status < 0)
> -                       gpiod_free(desc);
> -               else
> -                       set_bit(FLAG_SYSFS, &desc->flags);
> +       if (status) {
> +               gpiod_free(desc);
> +               goto done;
>         }
>
> +       status =3D gpiod_export(desc, true);
> +       if (status < 0)
> +               gpiod_free(desc);
> +       else
> +               set_bit(FLAG_SYSFS, &desc->flags);
> +
>  done:
>         if (status)
>                 pr_debug("%s: status %d\n", __func__, status);
> --
> 2.42.0
>

Applied, thanks!

Bart
