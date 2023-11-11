Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7754C7E8803
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 02:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345398AbjKKBut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 20:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjKKBur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 20:50:47 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A36E44B3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:50:44 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-421ae866bc2so124271cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699667443; x=1700272243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTTqEiDUhW/mKRIEgttSV/8piH+WGk8jPPTrPrLv0Uc=;
        b=MsMh2qvy3uKjPJ/VandMG4vAmad8nDNvc7NxT/1MKznyD4QKiTu+113zAJmzkL2rfv
         K6i+SdEl8vy0SQsK1gku2NQorUCzYFJ8hD6qQ9GLGsjEKDRZ0F75qY2FBIJavUgdQyln
         MbEO4LM+B2keg7dRM6SdoGt2BCNGgNWCnRSorWBwG/a9cwevYXYhXxwIlZSFbvyYZmNs
         OCpGAEYNjedk0haXW1sTdagWfE6MtRtiOv+3BdsMle/Cz8h54XScLydbT9P2E2HDzQv6
         6mJNpyrzcWGTdMUo5dHx+TSz4oUfrcRU8cVUZEGc5XW8+geQZwBE0i7MwNk5GVR5dp4N
         GWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699667443; x=1700272243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTTqEiDUhW/mKRIEgttSV/8piH+WGk8jPPTrPrLv0Uc=;
        b=eFli/ukiuyxx/jjF/iR/Epck/6MkV1Ohfdrpdg+31C1WqmZM8herjIckrhUU6svHD/
         reENNacdJoBiVfhqj6/F9kGtvrg9lZNcNTTgoJFCC4mAWKAReBRdvdHTUpsQkSPORr5U
         ooIy02gpl93pHxW0DQN951OwaYyxAs12/xvWYeRAXeObkxp1u5HVEs/WhhluEEYSOEXu
         vDCS/nH/oakwaVPKlWTOjuQOKJfzCYXUnsgeb4nZpxapw6C+AqDmaEn+0+F8pPznUuyK
         58RVoBy8/AnGrjIH3X6kmglYtoa0i5OKbJlTk/geb+BiBhatd93bcA+9pLna18bHHebg
         xsxg==
X-Gm-Message-State: AOJu0YzNGllGeITnT5maKORp2Fo+t7i8u/+GwdAHAtQt3l+b3ybLhGrx
        XZ3bHdtbKacrfpHdUbdITvXb5qQFtLD1QOF2TeA82A4IcMr/4WI6kuoGqQ==
X-Google-Smtp-Source: AGHT+IGd6uIbUqVofLNQra221fSGWFzX3taR/ZkXwZNBuoqsLb5BJNOxwefUSi+gQNtdZjmTaH9LiU4gJnqFfXIytaU=
X-Received: by 2002:ac8:5206:0:b0:421:1c15:a8fd with SMTP id
 r6-20020ac85206000000b004211c15a8fdmr64288qtn.14.1699667443061; Fri, 10 Nov
 2023 17:50:43 -0800 (PST)
MIME-Version: 1.0
References: <20231110075549.702374-1-herve.codina@bootlin.com>
In-Reply-To: <20231110075549.702374-1-herve.codina@bootlin.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 10 Nov 2023 17:50:07 -0800
Message-ID: <CAGETcx-06mFw+KNvYRf36etkQwuF4TJyNzt=KmwnCUzptKnMrw@mail.gmail.com>
Subject: Re: [PATCH 1/1] driver core: Keep the supplier fwnode consistent with
 the device
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 11:56=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> The commit 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child
> fwnode's consumer links") introduces the possibility to use the
> supplier's parent device instead of the supplier itself.
> In that case the supplier fwnode used is not updated and is no more
> consistent with the supplier device used.
>
> Update the fwnode used to be consistent with the supplier device used.
>
> Fixes: 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child fwnode's=
 consumer links")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/base/core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4d8b315c48a1..17f2568e0a79 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2076,6 +2076,18 @@ static int fw_devlink_create_devlink(struct device=
 *con,
>                 sup_dev =3D get_dev_from_fwnode(sup_handle);
>
>         if (sup_dev) {
> +               /*
> +                * The supplier device may have changed and so, the suppl=
ier
> +                * fwnode maybe inconsistent.
> +                * Update the supplier fwnode
> +                */
> +               sup_handle =3D sup_dev->fwnode;
> +               if (!sup_handle) {
> +                       dev_dbg(con, "Not linking %s - fwnode NULL\n",
> +                               dev_name(sup_dev));
> +                       goto out;
> +               }
> +

Nack. It's easier to debug when you know what supplier you were
pointing to in DT that triggered the creation of the device link. The
parent could be several levels up and multiple supplier links might be
skipped for various reasons. If they all printed the parent's fwnode,
it'll be confusing to debug.

-Saravana

>                 /*
>                  * If it's one of those drivers that don't actually bind =
to
>                  * their device using driver core, then don't wait on thi=
s
> --
> 2.41.0
>
