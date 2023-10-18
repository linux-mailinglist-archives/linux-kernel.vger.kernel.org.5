Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123157CEB27
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjJRW0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjJRW0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:26:38 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A9B95
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:26:36 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41b813f0a29so52541cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697667996; x=1698272796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cps5qFsl8dCxcozU9JLJWhUdMhqzHRZEHjJguRtUFe8=;
        b=A/IDcwMl62u1F1/Ls0FJUoiIulS0vbwNUh6C51OJqc9P/8camFf/HRADpoMg5R+Qzm
         RNIDhOGmZkYr22xxuhQulAXliRkmMwRZO7MriQ8hns5M+IlMXDVlumdAuTwDQM25Z7jH
         Ln5mGKwEbFsyTGoSlKNFVz0YbFxkfm2bRj1ZWciyep3ERHhWvO6kkR2575drJMT84MOV
         GmH5h3LxUal65KEWCpaxSBDTPsJ5hSt1qW9Ep5zZ84LbBznZXVk5Au+azB19xhrfnlGB
         RfPH3+hpBKolD668ZcudKZczOQViOHyqzjZRav361B5HOw1URNJGhL+DjHTEqzySyxd9
         Be+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697667996; x=1698272796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cps5qFsl8dCxcozU9JLJWhUdMhqzHRZEHjJguRtUFe8=;
        b=kd54cUUXUQnfcrimrrwxN7CXM1yC/+4pXKN0wQ2YMUE7i4lwyfVTBLzRFhylX7bYCi
         Isboe2PB/mphHHJ0kmNCSRy41FRkUWjHSnMQY6yilsQkbTHr6rKCNUzWCaIu+j7zizhe
         vNu+ZTYOvQ+5QBBIteYU0ZTjVIkV8GFguvJJ8bmVV93455V7vW/zHSbm9Lp7Xrtz2q7E
         PBiDSaHrgSyDIlCorGn9L2USIbNJh+rZzuxLthH3d8i3RhHIYwyjA6I08pLgNqnid0C/
         1ZQL73A7/wAUuEr2CWwJf5awVDTJV7RcU9MbxJ9Po1rrnRQGYF+PEBDWm2qm512pAnaM
         eb4A==
X-Gm-Message-State: AOJu0YxzbrkcqTW87WgLPYuyxvafSnq1dv3qsnYTu1e5eA8WoSu3zESQ
        AjZvOZjfAPJJE1lmAC3du+19iHneV6O5dNyKAclPyA==
X-Google-Smtp-Source: AGHT+IHp+uKYWmV4AUxlGp+XifpuEl5Ey6wC1cv5mMGnRcqiFXZ7YoOJa8yiiITglG2Ofg2ffIsowoxkUABb28MGDCI=
X-Received: by 2002:a05:622a:a04b:b0:41c:40cc:ef31 with SMTP id
 ju11-20020a05622aa04b00b0041c40ccef31mr106844qtb.12.1697667995547; Wed, 18
 Oct 2023 15:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231018013851.3303928-1-saravanak@google.com> <20231018104029.zairwt4nzub33ekr@pengutronix.de>
In-Reply-To: <20231018104029.zairwt4nzub33ekr@pengutronix.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 18 Oct 2023 15:25:59 -0700
Message-ID: <CAGETcx8uB6i2jt_9gvhcbzARNhy_r-byZxvdLp=mTywFEHNDbQ@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Release all resources during unbind
 before updating device links
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        James Clark <james.clark@arm.com>, kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 3:40=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Tue, Oct 17, 2023 at 06:38:50PM -0700, Saravana Kannan wrote:
> > This commit fixes a bug in commit 9ed9895370ae ("driver core: Functiona=
l
> > dependencies tracking support") where the device link status was
> > incorrectly updated in the driver unbind path before all the device's
> > resources were released.
> >
> > Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking sup=
port")
> > Reported-by: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> > Closes: https://lore.kernel.org/all/20231014161721.f4iqyroddkcyoefo@pen=
gutronix.de/
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Yang Yingliang <yangyingliang@huawei.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> > Cc: James Clark <james.clark@arm.com>
> > ---
> >  drivers/base/dd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index a528cec24264..0c3725c3eefa 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -1274,8 +1274,8 @@ static void __device_release_driver(struct device=
 *dev, struct device *parent)
> >               if (dev->bus && dev->bus->dma_cleanup)
> >                       dev->bus->dma_cleanup(dev);
> >
> > -             device_links_driver_cleanup(dev);
> >               device_unbind_cleanup(dev);
> > +             device_links_driver_cleanup(dev);
>
> Tested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> This indeed fixes the crash I experinced before.

Thanks for the Tested-by!

-Saravana
