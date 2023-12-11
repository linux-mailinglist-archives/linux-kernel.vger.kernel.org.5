Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F5B80D072
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344292AbjLKQEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344053AbjLKQD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:03:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968B34690
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EHAD8QzyszkPFNAlHyUSTdlIryxo3+R+BtrCDQDD9fA=;
        b=RTx62y04cNCVCKZ9Bzhz6BGDX/OmXCnobSMQXZch/n74TbkJvU87f0UTu3wqIuGm9H0115
        oWjFOMrVwgKXGfzZRi5O9nN5V203ZMCQeeN2EWi/RLaLg4RWuaXOvhdxyk1g8b8TlPB05R
        Ie0fpl3Rg3FVHv5026qerZB+VOxnjiQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-4WO0QDeLMzy5KhwBfMPuxw-1; Mon, 11 Dec 2023 11:00:49 -0500
X-MC-Unique: 4WO0QDeLMzy5KhwBfMPuxw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-286f8b84890so3196216a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:00:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702310448; x=1702915248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHAD8QzyszkPFNAlHyUSTdlIryxo3+R+BtrCDQDD9fA=;
        b=rNOQtED3nn3ouvo1d4hOM0f8fw9hzzjD+OUU5IpiZ+u/oIsroCPBIR5uw6Dqq+cjY5
         8ulfxvYm5q+heiA3EC/32FyTCNJpj5wNw2/QCb61IHPOoNmM6xKOpeBJemvSLUlYVLtx
         gxIEOjAM69YvJX60PBYXSkB98DsX60Ilt9KyIioKEmcsCuhzcX0B+3w9bATyeQ/l4RZa
         0yZCArjcAxafPeM9Mw/pG1AnYqAOFUBMzBBuadMoG52G6zUAAvi2jdnHb1Om5UAj3a5T
         fr5zZ1lcKDkT1AIStFh5Fw3UiB1NogQFFWPpRa/Qa705p55huXgpkj9R0/PreMktdvYK
         htZw==
X-Gm-Message-State: AOJu0YzfzdFhkzLzBISarFpmGDbu+HV30CvkmTXZgRqC9nPour4pUz8D
        mppii4tS1HurJHUSUCE3Dtif9rLEvbWWatCjTgJvEvgdBdbwOPCEE/Zcz74UAqeSZ/1jOrGPW/b
        c+R1yN7p1lutv2ckhHdIpTKA634qfq9QD9p9dWge7
X-Received: by 2002:a17:90b:1289:b0:286:6cc1:8675 with SMTP id fw9-20020a17090b128900b002866cc18675mr2078241pjb.90.1702310448473;
        Mon, 11 Dec 2023 08:00:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVVT3C0M8O/eEeQ50zRhgoa+MHhfCNaSFCwCtQYxLhdGbkfTxwmx1tPi2sX8o3r/uEhx9fT3+bAwaU8yK+z30=
X-Received: by 2002:a17:90b:1289:b0:286:6cc1:8675 with SMTP id
 fw9-20020a17090b128900b002866cc18675mr2078218pjb.90.1702310448097; Mon, 11
 Dec 2023 08:00:48 -0800 (PST)
MIME-Version: 1.0
References: <20231211130426.1500427-1-neelx@redhat.com> <20231211130426.1500427-2-neelx@redhat.com>
 <20231211134542.GG4870@unreal> <CACjP9X8zarONgO-QLvyzh-w7ax-7Fx0jdBWCF3VFQ09KDcaYnQ@mail.gmail.com>
 <20231211150657.GH4870@unreal>
In-Reply-To: <20231211150657.GH4870@unreal>
From:   Daniel Vacek <neelx@redhat.com>
Date:   Mon, 11 Dec 2023 17:00:11 +0100
Message-ID: <CACjP9X8wxW5jYiXcjg+2oGt7_aoc9KJ_XxKokt06B5d+FY6kEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] IB/ipoib: Fix mcast list locking
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yuya Fujita-bishamonten <fj-lsoft-rh-driver@dl.jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 4:18=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> What about the following change instead of adding extra lock to already
> too much complicated IPoIB?

Yeah, that's the other option should also work I believe. And it
simplifies the code nicely.

The allocated mcast_member and mcast_group structures are small enough
so that slab (by default) should not need more then order 1 block to
eventually extend/refill the full kmalloc-256 cache. Some arches will
even use order 0 I believe.
And unless I'm missing something I do not see any other sleeps in that path=
.

That said, as long as you are fine with occasional failures under
memory pressure, it looks OK to me.

--nX

> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/inf=
iniband/ulp/ipoib/ipoib_multicast.c
> index 5b3154503bf4..bca80fe07584 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> @@ -531,21 +531,17 @@ static int ipoib_mcast_join(struct net_device *dev,=
 struct ipoib_mcast *mcast)
>                 if (test_bit(IPOIB_MCAST_FLAG_SENDONLY, &mcast->flags))
>                         rec.join_state =3D SENDONLY_FULLMEMBER_JOIN;
>         }
> -       spin_unlock_irq(&priv->lock);
>
>         multicast =3D ib_sa_join_multicast(&ipoib_sa_client, priv->ca, pr=
iv->port,
> -                                        &rec, comp_mask, GFP_KERNEL,
> +                                        &rec, comp_mask, GFP_ATOMIC,
>                                          ipoib_mcast_join_complete, mcast=
);
> -       spin_lock_irq(&priv->lock);
>         if (IS_ERR(multicast)) {
>                 ret =3D PTR_ERR(multicast);
>                 ipoib_warn(priv, "ib_sa_join_multicast failed, status %d\=
n", ret);
>                 /* Requeue this join task with a backoff delay */
>                 __ipoib_mcast_schedule_join_thread(priv, mcast, 1);
>                 clear_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
> -               spin_unlock_irq(&priv->lock);
>                 complete(&mcast->done);
> -               spin_lock_irq(&priv->lock);
>         }
>         return 0;
>  }
>
>
> >
> > --nX
> >
> >
> > > Thanks
> > >
> > > > Unfortunately we could not reproduce the lockup and confirm this fi=
x but
> > > > based on the code review I think this fix should address such locku=
ps.
> > > >
> > > > crash> bc 31
> > > > PID: 747      TASK: ff1c6a1a007e8000  CPU: 31   COMMAND: "kworker/u=
72:2"
> > > > --
> > > >     [exception RIP: ipoib_mcast_join_task+0x1b1]
> > > >     RIP: ffffffffc0944ac1  RSP: ff646f199a8c7e00  RFLAGS: 00000002
> > > >     RAX: 0000000000000000  RBX: ff1c6a1a04dc82f8  RCX: 000000000000=
0000
> > > >                                   work (&priv->mcast_task{,.work})
> > > >     RDX: ff1c6a192d60ac68  RSI: 0000000000000286  RDI: ff1c6a1a04dc=
8000
> > > >            &mcast->list
> > > >     RBP: ff646f199a8c7e90   R8: ff1c699980019420   R9: ff1c6a1920c9=
a000
> > > >     R10: ff646f199a8c7e00  R11: ff1c6a191a7d9800  R12: ff1c6a192d60=
ac00
> > > >                                                          mcast
> > > >     R13: ff1c6a1d82200000  R14: ff1c6a1a04dc8000  R15: ff1c6a1a04dc=
82d8
> > > >            dev                    priv (&priv->lock)     &priv->mul=
ticast_list (aka head)
> > > >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> > > > --- <NMI exception stack> ---
> > > >  #5 [ff646f199a8c7e00] ipoib_mcast_join_task+0x1b1 at ffffffffc0944=
ac1 [ib_ipoib]
> > > >  #6 [ff646f199a8c7e98] process_one_work+0x1a7 at ffffffff9bf10967
> > > >
> > > > crash> rx ff646f199a8c7e68
> > > > ff646f199a8c7e68:  ff1c6a1a04dc82f8 <<< work =3D &priv->mcast_task.=
work
> > > >
> > > > crash> list -hO ipoib_dev_priv.multicast_list ff1c6a1a04dc8000
> > > > (empty)
> > > >
> > > > crash> ipoib_dev_priv.mcast_task.work.func,mcast_mutex.owner.counte=
r ff1c6a1a04dc8000
> > > >   mcast_task.work.func =3D 0xffffffffc0944910 <ipoib_mcast_join_tas=
k>,
> > > >   mcast_mutex.owner.counter =3D 0xff1c69998efec000
> > > >
> > > > crash> b 8
> > > > PID: 8        TASK: ff1c69998efec000  CPU: 33   COMMAND: "kworker/u=
72:0"
> > > > --
> > > >  #3 [ff646f1980153d50] wait_for_completion+0x96 at ffffffff9c7d7646
> > > >  #4 [ff646f1980153d90] ipoib_mcast_remove_list+0x56 at ffffffffc094=
4dc6 [ib_ipoib]
> > > >  #5 [ff646f1980153de8] ipoib_mcast_dev_flush+0x1a7 at ffffffffc0945=
5a7 [ib_ipoib]
> > > >  #6 [ff646f1980153e58] __ipoib_ib_dev_flush+0x1a4 at ffffffffc09431=
a4 [ib_ipoib]
> > > >  #7 [ff646f1980153e98] process_one_work+0x1a7 at ffffffff9bf10967
> > > >
> > > > crash> rx ff646f1980153e68
> > > > ff646f1980153e68:  ff1c6a1a04dc83f0 <<< work =3D &priv->flush_light
> > > >
> > > > crash> ipoib_dev_priv.flush_light.func,broadcast ff1c6a1a04dc8000
> > > >   flush_light.func =3D 0xffffffffc0943820 <ipoib_ib_dev_flush_light=
>,
> > > >   broadcast =3D 0x0,
> > > >
> > > > The mcast(s) on the &remove_list (the remaining part of the ex &pri=
v->multicast_list):
> > > >
> > > > crash> list -s ipoib_mcast.done.done ipoib_mcast.list -H ff646f1980=
153e10 | paste - -
> > > > ff1c6a192bd0c200        done.done =3D 0x0,
> > > > ff1c6a192d60ac00        done.done =3D 0x0,
> > > >
> > > > Reported-by: Yuya Fujita-bishamonten <fj-lsoft-rh-driver@dl.jp.fuji=
tsu.com>
> > > > Signed-off-by: Daniel Vacek <neelx@redhat.com>
> > > > ---
> > > >  drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drive=
rs/infiniband/ulp/ipoib/ipoib_multicast.c
> > > > index 5b3154503bf4..8e4f2c8839be 100644
> > > > --- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > > > +++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
> > > > @@ -580,6 +580,7 @@ void ipoib_mcast_join_task(struct work_struct *=
work)
> > > >       }
> > > >       netif_addr_unlock_bh(dev);
> > > >
> > > > +     mutex_lock(&priv->mcast_mutex);
> > > >       spin_lock_irq(&priv->lock);
> > > >       if (!test_bit(IPOIB_FLAG_OPER_UP, &priv->flags))
> > > >               goto out;
> > > > @@ -634,6 +635,7 @@ void ipoib_mcast_join_task(struct work_struct *=
work)
> > > >                               /* Found the next unjoined group */
> > > >                               if (ipoib_mcast_join(dev, mcast)) {
> > > >                                       spin_unlock_irq(&priv->lock);
> > > > +                                     mutex_unlock(&priv->mcast_mut=
ex);
> > > >                                       return;
> > > >                               }
> > > >                       } else if (!delay_until ||
> > > > @@ -655,6 +657,7 @@ void ipoib_mcast_join_task(struct work_struct *=
work)
> > > >               ipoib_mcast_join(dev, mcast);
> > > >
> > > >       spin_unlock_irq(&priv->lock);
> > > > +     mutex_unlock(&priv->mcast_mutex);
> > > >  }
> > > >
> > > >  void ipoib_mcast_start_thread(struct net_device *dev)
> > > > --
> > > > 2.43.0
> > > >
> > >
> >
>

