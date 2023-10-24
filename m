Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FF07D4463
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjJXA7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJXA7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:59:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3A69B;
        Mon, 23 Oct 2023 17:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698109145;
        bh=SrJb4FRbLHOUMnei7Nu8AGGqkqzQ05jh1OZ/FXAVENs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PqNH62PtOXuWAHsEhJdkbZEUmkBbp0Q35218A1RAwytZsZZALzec9WFlPq6ovY/oK
         UGyE1B3BihV/x82NgTDgFG7zXyf4/psXH97Hr5z2F6ajtoBV/Y6lT3DuKP1CyZoUQi
         n3TmjTdFgZDSmQnyRF2O3N9KpjTEUjuGuIdZ3YSS5JP7pjc/4VSbruR0+bNYSdtXng
         Hh522X98YH8W/SvRbrertwvljy6TZCml1qACpK5tYYLWNWayCV1DklEg3wAi/dDDZm
         pI9VOMOL+9YfK+z7MYmdaz5/sUnkWYWmdqMJDM/AlSsPA7WEkWhAr61xczfzmuaLC1
         KQyOS45nBY3zA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDtx40Qpcz4wx6;
        Tue, 24 Oct 2023 11:59:04 +1100 (AEDT)
Date:   Tue, 24 Oct 2023 11:59:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Dave Airlie <airlied@redhat.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Roman Li <roman.li@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20231024115903.2d73440c@canb.auug.org.au>
In-Reply-To: <20231019120618.71424848@canb.auug.org.au>
References: <20231010124357.5251e100@canb.auug.org.au>
        <20231019120618.71424848@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/79AEwpQI285WYzkSMPrKcN3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/79AEwpQI285WYzkSMPrKcN3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 19 Oct 2023 12:06:18 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Tue, 10 Oct 2023 12:43:57 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > After merging the amdgpu tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >=20
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c: In f=
unction 'dml_core_mode_support':
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:8229:=
1: error: the frame size of 2736 bytes is larger than 2048 bytes [-Werror=
=3Dframe-larger-than=3D]
> >  8229 | } // dml_core_mode_support
> >       | ^
> > cc1: all warnings being treated as errors
> >=20
> > Caused by commit
> >=20
> >   7966f319c66d ("drm/amd/display: Introduce DML2")
> >=20
> > (or maybe something later that changed storage size).
> >=20
> > I have used the amdgpu tree from next-20231009 for today. =20
>=20
> This build failure now (presumably) exists in the drm tree.  I am still
> applying the 2 patches from Rodrigo to my tree as a work around.
>=20
> I would have expected that this was fixed in the amdgpu tree before
> Dave was asked to merge it ...

Any progress here?  I am still applying the 2 patches.

--=20
Cheers,
Stephen Rothwell

--Sig_/79AEwpQI285WYzkSMPrKcN3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU3FtcACgkQAVBC80lX
0GyMvwf9HYGEZDNMSkCZ7E2MOqDEx3Rpt+Mjf/oeNayiftKsDhTXKptwhxVT+gFp
InSe1w3hcETCVtcCE7FLmGblQ9HCOPQmqw78w7X7JvxdOrvuMmpo3S4QykUra6OI
kSXQf+dreUVkBLFp0gdshV78vzTlmDSEczSglxLRJlUqe/+UoyeHv8pPsvXSuS8G
doCDtPqou6MzW7thKx5cfDiaWXHSWS6bo3u4j6Wwdb4cumctnAfrewjM2sp4gH/p
cqeKcpU46v7M3pTV62jDuK4tr8cjsZ1gqJa6JiLC8INgx3W1NUmmF8wzT05E7ouA
Ix+dIp8D7O/jghWcBFriXKWGo3DJPQ==
=REfC
-----END PGP SIGNATURE-----

--Sig_/79AEwpQI285WYzkSMPrKcN3--
