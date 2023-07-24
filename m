Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DA675EC4E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjGXHNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGXHM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B8F138
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690182729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zelsN5BeeBrPMCjnspiDiZUy4sr+lnzwwZJWHuHRBfs=;
        b=YbjfFxSERCr6YT2stBuGNiKaKsSrZsabMuXfHarJ/G2utjJoWki/fx28z0y0d8vieQhIoN
        gbHN2EeHI/vQKYyumnbPRAqvx2x2CKQpNJm2w2b2NOqabkcuISOCwocfwINtjxKKm4Wjv/
        e5mvghTlORq3gjSkzLxejt+273PzXgk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-7btHHMPSNgKNMWfyST184w-1; Mon, 24 Jul 2023 03:12:08 -0400
X-MC-Unique: 7btHHMPSNgKNMWfyST184w-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b708d79112so34276081fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690182726; x=1690787526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zelsN5BeeBrPMCjnspiDiZUy4sr+lnzwwZJWHuHRBfs=;
        b=Fa6h5+5S4tyN8cLtzyKkUOLHb/O6475ibiOtDjft97y5p+J064guzZVyhWlNWR0PXy
         aQ/bEAvPO9p1nedzVUu50wxWTzWui4rR21x0A57Zf5gepQBbk7NQSiC94WrKTbZT38JL
         41oKY7EWxUA9FcPDEz9ceb66ClJPMGfFdm8zockdJ3/1FsLYF/fwg9gD/PZ9o30ljCOW
         S+NCa3L5bI9ZPn1oTUq0axj1bIYQTx1yGDj8Cy6vQ40jCNyC1l9R/xxlF22UWZxR98xx
         Puhdambnf3h7gJbKq9nCm6gQxxjMPX2gap+pYxyAdtBO4DL1TYBUkex+Y29uRqoCJkRz
         heVw==
X-Gm-Message-State: ABy/qLaUhqXzXocasIURrtQ5GysaI4UV064ZpXJoFCzOFDXLISl3zyUn
        B0yoYYzVyhEyAeYik98Hmi1E8HTMjDzhgwEIJGUYp9SKv5zHbPHg79U9tKBt3jKw9Pu0vA0FB4w
        9SGUAXBzYNypDfWvUgxYdFQRy9Gd0/6eq1ku3nYGv
X-Received: by 2002:a2e:9c93:0:b0:2b6:dd9a:e1d3 with SMTP id x19-20020a2e9c93000000b002b6dd9ae1d3mr5575011lji.44.1690182726703;
        Mon, 24 Jul 2023 00:12:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF/dSwy0GmZagFnogQhoaJYCR8t/Cuk1jUqXQpbcm+KkX8fY/+GF61XRMrS9DnuWvdZKn5Uuid3IjmwRT2134U=
X-Received: by 2002:a2e:9c93:0:b0:2b6:dd9a:e1d3 with SMTP id
 x19-20020a2e9c93000000b002b6dd9ae1d3mr5575002lji.44.1690182726409; Mon, 24
 Jul 2023 00:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230723080507.3716924-1-linma@zju.edu.cn> <20230723050656-mutt-send-email-mst@kernel.org>
 <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn> <8ecec51.e40ad.1898226c545.Coremail.linma@zju.edu.cn>
 <20230723055820-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230723055820-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 24 Jul 2023 15:11:55 +0800
Message-ID: <CACGkMEuGHMu6te3jRfEhhwTrWR1mpqp3hbVhDKQiXK9tgwz3qw@mail.gmail.com>
Subject: Re: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length check
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Lin Ma <linma@zju.edu.cn>, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>,
        Eli Cohen <elic@nvidia.com>,
        Dragos Tatulea <dtatulea@nvidia.com>
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

On Sun, Jul 23, 2023 at 6:02=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sun, Jul 23, 2023 at 05:48:46PM +0800, Lin Ma wrote:
> >
> > > Sure, that is another undergoing task I'm working on. If the nlattr i=
s parsed with
> > > NL_VALIDATE_UNSPEC, any forgotten nlattr will be rejected, therefore =
(which is the default
> > > for modern nla_parse).
> >
> > For the general netlink interface, the deciding flag should be genl_ops=
.validate defined in
> > each ops. The default validate flag is strict, while the developer can =
overwrite the flag
> > with GENL_DONT_VALIDATE_STRICT to ease the validation. That is to say, =
safer code should
> > enforce NL_VALIDATE_STRICT by not overwriting the validate flag.
> >
> > Regrads
> > Lin
>
>
> Oh I see.
>
> It started here:
>
> commit 33b347503f014ebf76257327cbc7001c6b721956
> Author: Parav Pandit <parav@nvidia.com>
> Date:   Tue Jan 5 12:32:00 2021 +0200
>
>     vdpa: Define vdpa mgmt device, ops and a netlink interface
>
> which did:
>
> +               .validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALID=
ATE_DUMP,
>
>
> which was most likely just a copy paste from somewhere, right Parav?
>
> and then everyone kept copying this around.
>
> Parav, Eli can we drop these? There's a tiny chance of breaking something
> but I feel there aren't that many users outside mlx5 yet, so if you
> guys can test on mlx5 and confirm no breakage, I think we are good.

Adding Dragos.

Thanks

>
> --
> MST
>

