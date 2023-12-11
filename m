Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA3A80CE15
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344325AbjLKOQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344559AbjLKOQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:16:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D98272B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702303793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vAAvf3xWNdiA5yQ9F9boRppGC66yI7jkgPgymNCWcs8=;
        b=Kx0L4Z2c/L5QuL8pwP5bFOoc3btrWbfbOLIXoO8jyz/plOxvrs8thsIf+ZJvrwW6GBFCNJ
        H900h3fFIzmEIqqap4fa2Y2DhqxJFIl4XO5HcX0rhKsBB7l/RGgI2w+7hgH2hakXm0jynM
        kvXj6vzs75cfRLjMINVvrifizUxxazw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-VsAB1YeZPZy4IUAR44xjWA-1; Mon, 11 Dec 2023 09:09:51 -0500
X-MC-Unique: VsAB1YeZPZy4IUAR44xjWA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-286da868833so2860291a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:09:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702303790; x=1702908590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAAvf3xWNdiA5yQ9F9boRppGC66yI7jkgPgymNCWcs8=;
        b=hyNngcvjp02NNZ31ITDEiL2g0IH6hXdLg9czEGY3zopErr5OLyvjJJySaBIp7Cy5We
         AjSimh1/fDAukonwclt9eYhjMQb8OugzHg4d4ds+Ssk8HI496bIPPYNoPF8tstg+Xsb4
         yBGuQAAHPrx0U9z6jkcgmHb6sakiYSgYjdBSJJxJgL2BToX4i2MwXQduj+IhhCzCC9Bc
         eWW7tp8yfUS2Ilona5rwr9tWj+bCM1g4zjKuTWMdwPpJJh7Bei927Pss518sDR6SR0rI
         HKFk7cxXYr+FfHZhv1I1O9eJEU34qlbxhr3x4KNxIKqO71sQJvmW4cLYIFUG36Ql6rE7
         Y1EQ==
X-Gm-Message-State: AOJu0YxVsvVy51vH3g+2rMz4eJDcnicNnx2gSgeB/bLL2sBAHiHxCIuS
        ysnAlEQEaDrjHlbwenoHe3lZVo3C2rGBwV6X4gGikDZ25Jlicjwr0ZJevWCR0jCLK5K2tUI1d3R
        zs4xFHNTvzWhgJn/uVTd+gNhykOdbisdBgKrP1AqC
X-Received: by 2002:a17:90a:6e42:b0:286:6cc1:2cb1 with SMTP id s2-20020a17090a6e4200b002866cc12cb1mr1793350pjm.59.1702303790644;
        Mon, 11 Dec 2023 06:09:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR/6GiM7/0vFHkDfHn1IFcQktjWuh0v87SXtOh2Gg4WrYU1x0CHfs0k8+lUvJEjfRLnRGu0eSx98AeHk6CVWU=
X-Received: by 2002:a17:90a:6e42:b0:286:6cc1:2cb1 with SMTP id
 s2-20020a17090a6e4200b002866cc12cb1mr1793339pjm.59.1702303790367; Mon, 11 Dec
 2023 06:09:50 -0800 (PST)
MIME-Version: 1.0
References: <20231211131051.1500834-1-neelx@redhat.com> <20231211132217.GF4870@unreal>
 <20231211132522.GY1489931@ziepe.ca>
In-Reply-To: <20231211132522.GY1489931@ziepe.ca>
From:   Daniel Vacek <neelx@redhat.com>
Date:   Mon, 11 Dec 2023 15:09:13 +0100
Message-ID: <CACjP9X8+CgoQRjs2Y9A+OwWCVxMhKyqzLhEjaguxMavHsy8VRg@mail.gmail.com>
Subject: Re: [PATCH] IB/ipoib: No need to hold the lock while printing the warning
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 2:25=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Mon, Dec 11, 2023 at 03:22:17PM +0200, Leon Romanovsky wrote:
>
> > Please fill some text in commit message.
>
> Yes, explain *why* you are doing this

Oh, sorry. I did not mention it but there's no particular reason
really. The @Subject says it all. There should be no logical or
functional change other than reducing the span of that critical
section. In other words, just nitpicking, not a big deal.

While checking the code (and past changes) related to the other issue
I also sent today I just noticed the way 08bc327629cbd added the
spin_lock before returning from this function and it appeared to me
it's clearer the way I'm proposing here.

Honestly, I was not looking into why the lock is released for that
completion. And I'm not changing that logic.

If this complete() can be called with priv->lock held, the cleanup
would look different, of course.

That said, If you'd like to keep this patch I can send a v2 with the
above details in the message body. Otherwise feel free to drop this.

--nX

> > > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers=
/infiniband/ulp/ipoib/ipoib_multicast.c
> > > index 5b3154503bf4..ae2c05806dcc 100644
> > > --- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > > +++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > > @@ -536,17 +536,17 @@ static int ipoib_mcast_join(struct net_device *=
dev, struct ipoib_mcast *mcast)
> > >     multicast =3D ib_sa_join_multicast(&ipoib_sa_client, priv->ca, pr=
iv->port,
> > >                                      &rec, comp_mask, GFP_KERNEL,
> > >                                      ipoib_mcast_join_complete, mcast=
);
> > > -   spin_lock_irq(&priv->lock);
> > >     if (IS_ERR(multicast)) {
> > >             ret =3D PTR_ERR(multicast);
> > >             ipoib_warn(priv, "ib_sa_join_multicast failed, status %d\=
n", ret);
> > > +           spin_lock_irq(&priv->lock);
> > >             /* Requeue this join task with a backoff delay */
> > >             __ipoib_mcast_schedule_join_thread(priv, mcast, 1);
> > >             clear_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
> > >             spin_unlock_irq(&priv->lock);
> > >             complete(&mcast->done);
> > > -           spin_lock_irq(&priv->lock);
>
> It is super weird to unlock just around complete.
>
> Jason
>

