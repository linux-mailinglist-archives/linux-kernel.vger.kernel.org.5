Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828107D5F4A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjJYA4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjJYA4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:56:40 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE93D128;
        Tue, 24 Oct 2023 17:56:38 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c9e06f058bso2681965ad.0;
        Tue, 24 Oct 2023 17:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698195398; x=1698800198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=idCmePkmuapOmhTFu8C7IFO+GDsYxAan7/9IMTzaD9M=;
        b=MnI655B7tqkLj/TW2nlBTVXGPLScrq5SDXe/igQ2nO7+hzq8AA1RXUTqzzODw/wMiZ
         sKp2vdqXUaeKLqPyD42Xu2aaHmRrgn9pmCTd/sDgo4JhGTBQYNzc1Q3flppa1FnD84vT
         S8pVLvhseex+/HfViQO4tFNNGyAkmwR067TfFeo/uQRzeL6K85jLTaoI0vWBx9yQSqXN
         iNy42DM/E1Oqxh0c5fHbs2GHIKiKQQ+8j7Z1hz2L2FrBu5McSCqIfRoXLVgnr/aREVw2
         MThgkDDy0VYd14UTwyHH9F/R06VWUFxoLKTzWcWiuXAEVbDc2Ud6jFvE7vCaBJcuEMoP
         kJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698195398; x=1698800198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idCmePkmuapOmhTFu8C7IFO+GDsYxAan7/9IMTzaD9M=;
        b=xKLfjIzAXxbX0jDZ5Ifef7fa0NiwXWeNLQWXZYP9tA3tixkAILKekDuZW6g7tlSWyQ
         K0bIW35SVXE6zwCsasIMcWJAhbc5F1IBihhOjge+fCHOvPwiFCy5WPimMLiLh4COyLQi
         Pu6WYzRIrAOkQngg/aJAY5HVGvJr7QEt+N5UJlJpTyznM4GGyKGoHB+yUfSIVBwGmznZ
         IIt9mr7kHYZSCfQYh/y6g5Hb7kNF052/Smhi9I4o8WVVa1WpbYWqSSYDxULQhrMwaSkg
         XJjvSoKNtMlEbYQX5LfRBde26kvTYc8sUQI8H93d+sz6h4Pjwdcl5EFPfm1/M0xL6GKg
         vplA==
X-Gm-Message-State: AOJu0YxJb2ntnuYAAxMEyf073/+t2oIW8x5TE6zZ6lt+P4ZmgOuyfCTA
        KhqZtBVWNlRXtqDO7TR7Cuq6/PORr1A=
X-Google-Smtp-Source: AGHT+IGJgyhZvs/DxUdMPw6LHhjYzSVzjI+gdVIZdAFLgzhN4L4CKfQAIgUW6oEW7DPYNUXPlg8zzA==
X-Received: by 2002:a17:903:6cc:b0:1c3:868f:5958 with SMTP id kj12-20020a17090306cc00b001c3868f5958mr17419062plb.20.1698195397893;
        Tue, 24 Oct 2023 17:56:37 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090301d100b001b898595be7sm7917360plh.291.2023.10.24.17.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 17:56:37 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C6D39819CFF3; Wed, 25 Oct 2023 07:56:34 +0700 (WIB)
Date:   Wed, 25 Oct 2023 07:56:34 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Vladimir Smelhaus <vl.sm@email.cz>,
        Linux Netfilter <netfilter@vger.kernel.org>,
        coreteam@netfilter.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: Re: Flowtables ignore timeout settings in recent kernels
Message-ID: <ZThnwhWD308vrkUP@debian.me>
References: <ughg4v$130b$1@ciao.gmane.io>
 <ZSyBtn8cplLWoNn-@debian.me>
 <ZTglADWVBgKxKOIC@calendula>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cM5L7aeMb6NeOAH/"
Content-Disposition: inline
In-Reply-To: <ZTglADWVBgKxKOIC@calendula>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cM5L7aeMb6NeOAH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 10:11:44PM +0200, Pablo Neira Ayuso wrote:
> On Mon, Oct 16, 2023 at 07:20:06AM +0700, Bagas Sanjaya wrote:
> > On Sun, Oct 15, 2023 at 09:56:14PM +0200, Vladimir Smelhaus wrote:
> > > Netfilter ignores the timeout settings for a flowtable
> > >=20
> > > # sysctl -a -r flowtable
> > > net.netfilter.nf_flowtable_tcp_timeout =3D 30
> > > net.netfilter.nf_flowtable_udp_timeout =3D 30
> > >=20
> > > Situation. A long udp connection (tunnel) with some data flowing thro=
ugh a
> > > router. The connection is sent to a flowtable on the router. It's a f=
ew
> > > packets per second, more here and there, a pause here and there, and =
so on
> > > over and over. The pauses are minimal and are also limited by the tun=
nel
> > > settings to be no longer than 25 seconds. Everything is satisfying to=
 make
> > > the connection last continuously in the flowtable and not reappear in
> > > forward. However, the connection keeps dropping out of the flowtable.=
 It
> > > stays in the flowtable (offloaded) for a second at most and then it is
> > > kicked out, back to forward.
> > >=20
> > > In an attached test script you can see counters that should be zero b=
ut are not. If I watch the normal packet flow on a particular router, I can=
 see packets in the conntrack table that should be OFFLOAD as ASSURED.
> > >=20
> > > Tested in kernel 6.5.6. In an old(er) kernel 5.10 it works as expecte=
d.
> > >=20
> >=20
> > Then please perform bisection to find a culprit that introduces your
> > regression (see Documentation/admin-guide/bug-bisect.rst in the kernel
> > sources for reference). Also, it'd been great if you also post the
> > reproducer script inline (within your email) instead, as some MUAs
> > (like mutt that I'm using now) may ignore the attachment.
> >=20
> > Anyway, thanks for the regression report. I'm adding it to regzbot:
> >=20
> > #regzbot ^introduced: v5.10..v6.5
>=20
> Fix here:
>=20
> https://patchwork.ozlabs.org/project/netfilter-devel/patch/20231024193815=
=2E1987-1-pablo@netfilter.org/
>=20
> it is a bug from Jun 2023, regression was introduced in the v6.5
> development cycle.
>=20

Telling regzbot:

#regzbot fix: netfilter: nf_flow_table: GC pushes back packets to classic p=
ath

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--cM5L7aeMb6NeOAH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZThnvgAKCRD2uYlJVVFO
o8J0AQD7MDH2zNbKZM6ZlcvUYRSmRK0rvX6lR+6/MFllgRlZnAEA7GV4EePorg3E
0xZhimBiax8M/oW2TAW86qCo9VyAegY=
=3CKf
-----END PGP SIGNATURE-----

--cM5L7aeMb6NeOAH/--
