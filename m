Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209C478002A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355437AbjHQVt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355463AbjHQVtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:49:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF38123;
        Thu, 17 Aug 2023 14:49:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28E726340A;
        Thu, 17 Aug 2023 21:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C074C433C9;
        Thu, 17 Aug 2023 21:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692308970;
        bh=Vh7ns8nXAs6t160DrytAoo4IiSGWxufrYdnLXab9+3E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sMJs4cvFuiuLTXFmInpnmeR5WxEX8KInYEzqK7ckfyvBPzE/dFtzdYTTpr+BuUc5+
         w/FBRS+WbB0i4G4v30ig8W2SgATGpPFSu4+eHUuCn/Idma8Zob0PPBgiOVZGSu8GzC
         RvnqA6NdjXoVF3u7KAGI5/sZu4532Vtr+h4Hz+xxibz3QyN2xKCsrIrJwK3gI0KWCE
         sElRKiHjoP7WbCOQCRYUFBkifjBAFHs+EI9Z+pNmkMMKojfJfM/KsuCJg0oxQHsGkG
         XVCKNUbk1OfGiDnoXTiXYKKgATRnR7QSAz6nlaAk5Bn/YW4F7lVb8fABbQRBeghuNm
         D67/5LPfkZQYA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so300111e87.3;
        Thu, 17 Aug 2023 14:49:30 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw6GBM1oYVwCis5zu/SwNn9RwAj8PZbzfsOxa82ww2WToSNHArm
        yS1qCB8trYVXx5VOiRdUV1a/7sKEpAj8jIFd/cI=
X-Google-Smtp-Source: AGHT+IF7Hh8zabSpoEV+PXJbowP74S1cypCv6tqd0qkD8+wO1bb8d+3FfVVkROtC2rGTnFzFtdDePqSxikvpv9wTFxo=
X-Received: by 2002:a05:6512:2822:b0:4f6:2317:f387 with SMTP id
 cf34-20020a056512282200b004f62317f387mr443850lfb.35.1692308968522; Thu, 17
 Aug 2023 14:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230815030957.509535-1-yukuai1@huaweicloud.com>
 <20230815030957.509535-3-yukuai1@huaweicloud.com> <20230817095814.00005530@linux.intel.com>
In-Reply-To: <20230817095814.00005530@linux.intel.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 17 Aug 2023 14:49:16 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5Nn4gPv6EKaxHqtJfRFXMLg3bEBTNknLBR3tNuxFyVMQ@mail.gmail.com>
Message-ID: <CAPhsuW5Nn4gPv6EKaxHqtJfRFXMLg3bEBTNknLBR3tNuxFyVMQ@mail.gmail.com>
Subject: Re: [PATCH -next v2 2/7] md: factor out a helper to choose sync
 direction from md_check_recovery()
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, xni@redhat.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 12:58=E2=80=AFAM Mariusz Tkaczyk
<mariusz.tkaczyk@linux.intel.com> wrote:
>
> On Tue, 15 Aug 2023 11:09:52 +0800
> Yu Kuai <yukuai1@huaweicloud.com> wrote:
>
> > From: Yu Kuai <yukuai3@huawei.com>
> >
> > There are no functional changes, on the one hand make the code cleaner,
> > on the other hand prevent following checkpatch error in the next patch =
to
> > delay choosing sync direction to md_start_sync().
> >
> > ERROR: do not use assignment in if condition
> > +       } else if ((spares =3D remove_and_add_spares(mddev, NULL))) {
> >
> > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > ---
> >  drivers/md/md.c | 68 +++++++++++++++++++++++++++++++------------------
> >  1 file changed, 43 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index 90815be1e80f..4846ff6d25b0 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -9246,6 +9246,48 @@ static int remove_and_add_spares(struct mddev *m=
ddev,
> >       return spares;
> >  }
> >
> > +static bool md_choose_sync_direction(struct mddev *mddev, int *spares)
>
> The naming is little confusing because as a direction I would expect forw=
ard or
> backward - from end to start or or from start to end. In this case you ar=
e
> determining the type of the background operation needed. Assuming that re=
shape
> is a kind of "sync" operation I would say "md_choose_sync_action".

Yeah, md_choose_sync_direction is indeed confusing.

Thanks,
Song
