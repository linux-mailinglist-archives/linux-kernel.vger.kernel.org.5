Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A585F7BD922
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346160AbjJILBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbjJILBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:01:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63ED99;
        Mon,  9 Oct 2023 04:01:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10713C433C7;
        Mon,  9 Oct 2023 11:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696849275;
        bh=GM6lil/Db0A1tuVrZOEG4FKtpcXLCTM68+3297DcxXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r5UjdL6xkr0Mtjg6lUjJB8wIJq7fxLJqz6bbMvMnFwixDqF2H/JUQWeY0W0QCn0qi
         TRkgvElF2pKWNFe3u9J7BdZY7FdXhIFDj6ufpIL7rDsRyfjJ28aX1M/U4+nkFo+aG4
         oEIAVPdOn7u6Y9aRZhjOOQQ5JtVB+iME2F8QKB69XBTzmCxJnJCxe70r7Oh2L0chTl
         t1kU9P79bIorKHzFGZPYjeHvH9kRj4LYVnOokLzpVHmKV5ITZTwXnOAhZcw0S1nTTi
         YYj4gui7iA6jXXEl8TAeEH8H/JRK8GcNNyz96mo/tQ8I28cHqti0/xGiaJKpqzvdBQ
         73bl8jeAjw0vA==
Date:   Mon, 9 Oct 2023 13:01:11 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] ioctl_userfaultfd.2: correct and update UFFDIO_API
 ioctl error codes
Message-ID: <ZSPdd-5UtiXU8sGF@debian>
References: <20230919190206.388896-1-axelrasmussen@google.com>
 <20230919190206.388896-8-axelrasmussen@google.com>
 <5ddepg57wqnidtvsio2pse44dot6pvr3rcmhwld6ml3sflwcz3@ijd3h4teqblr>
 <20231009084911.GK3303@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DvgcUIV2tNB0f+sm"
Content-Disposition: inline
In-Reply-To: <20231009084911.GK3303@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DvgcUIV2tNB0f+sm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 9 Oct 2023 13:01:11 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>, Peter Xu <peterx@redhat.com>,
	linux-man@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] ioctl_userfaultfd.2: correct and update UFFDIO_API
 ioctl error codes

Hi Mike,

On Mon, Oct 09, 2023 at 11:49:11AM +0300, Mike Rapoport wrote:
> On Tue, Sep 26, 2023 at 01:52:34AM +0200, Alejandro Colomar wrote:
> > Hi Axel,
> >=20
> > On Tue, Sep 19, 2023 at 12:02:03PM -0700, Axel Rasmussen wrote:
> > > First, it is not correct that repeated UFFDIO_API calls result in
> > > EINVAL. This is true *if both calls enable features*, but in the case
> > > where we're doing a two-step feature detection handshake, the kernel
> > > explicitly expects 2 calls (one with no features set). So, correct th=
is
> > > description.
> > >=20
> > > Then, some new error cases have been added to the kernel recently, and
> > > the man page wasn't updated to note these. So, add in descriptions of
> > > these new error cases.
> > >=20
> > > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > > ---
> > >  man2/ioctl_userfaultfd.2 | 24 +++++++++++++++++++-----
> > >  1 file changed, 19 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> > > index 53b1f473f..1aa9654be 100644
> > > --- a/man2/ioctl_userfaultfd.2
> > > +++ b/man2/ioctl_userfaultfd.2
> > > @@ -280,17 +280,31 @@ refers to an address that is outside the callin=
g process's
> > >  accessible address space.
> > >  .TP
> > >  .B EINVAL
> > > -The userfaultfd has already been enabled by a previous
> > > -.B UFFDIO_API
> > > -operation.
> > > -.TP
> > > -.B EINVAL
> > >  The API version requested in the
> > >  .I api
> > >  field is not supported by this kernel, or the
> > >  .I features
> > >  field passed to the kernel includes feature bits that are not suppor=
ted
> > >  by the current kernel version.
> > > +.TP
> > > +.B EPERM
> >=20
> > This EPERM should probably be at the end.  Unless you have a good reason
> > to break alphabetic order.
>=20
> I agree with Alex here, other than that feel free to add
>=20
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

Thanks.  Since v2 only reorders these, I've added your tag.

Cheers,
Alex

>=20
> =20
> > Thanks,
> > Alex
> >=20
> > > +The
> > > +.B UFFD_FEATURE_EVENT_FORK
> > > +feature was enabled,
> > > +but the calling process doesn't have the
> > > +.B CAP_SYS_PTRACE
> > > +capability.
> > > +.TP
> > > +.B EINVAL
> > > +A previous
> > > +.B UFFDIO_API
> > > +call already enabled one or more features for this userfaultfd.
> > > +Calling
> > > +.B UFFDIO_API
> > > +twice,
> > > +the first time with no features set,
> > > +is explicitly allowed
> > > +as per the two-step feature detection handshake.
> > >  .\" FIXME In the above error case, the returned 'uffdio_api' structu=
re is
> > >  .\" zeroed out. Why is this done? This should be explained in the ma=
nual page.
> > >  .\"
> > > --=20
> > > 2.42.0.459.ge4e396fd5e-goog
> > >=20
>=20
>=20
>=20
> --=20
> Sincerely yours,
> Mike.

--=20
<https://www.alejandro-colomar.es/>

--DvgcUIV2tNB0f+sm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUj3XcACgkQnowa+77/
2zJ3OA//TkwE8xHpU+OC/EDqkSMUQlYNsehg5XZg6x3xnyvU5yoZM5IdN5CeUuZE
LoCeoEVsPgtUSejsWSr9FvDm/pSydyuxl+STppA8xN8SvlXOFJqQi0XM4WC3Elgq
gqzN0/yNsDN1hz3Rs+g0CqJdLuvkDu6+KAXmwxPzzf5AdGh6kzaGPsgDLmOnyB0X
Cs287bja5vs54JuNYgnLV7fivotp0q6XzWuf2tno0AOLVNtbmEerHcTLU/haBgKc
+34hrrNgf0lGStXv1uhM8uZC4vb60NyvvE+AfTthJ0kkC5nHxRQmJ6b4xEpjPSzR
kndiMBC+Uq/kDGQHOaX6zgDVPbSjCUIcR9lhJ97QM1vKIFZJDovaj7242repcc5z
ols8lYQXA6tfhNgsff58IH6B7ca69weAv2PxqtDCYunejkZpMwDq9YMKB9pcaNdx
hKECDguag+FG1g9PY36fJjHzP1yiWVhW4LF48ECkuq2sjfFP83ZO4T8KEqxl4HkN
ZuNdNRVIV2Xz9wN2gotn0g6KFgJwdfJik9Ul+UvSEjsUu8zuvyJFAupdUZuU3+tJ
AgRc1dRClhSdu9CLT7utnRq8Pb2oYZjebNnAxClewtLptGpz+/uexUIsJ46sMXzJ
o4qevWxEH/d9ICOEyQqke3Rp7ptcOBlUISjANeS1is98gC1W5zs=
=zWY9
-----END PGP SIGNATURE-----

--DvgcUIV2tNB0f+sm--
