Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BBE78F9F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjIAIZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjIAIZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:25:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B81193
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 01:25:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 91D93CE2377
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81289C433C9;
        Fri,  1 Sep 2023 08:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693556704;
        bh=Ia2YKPpb8VGizArtf2/JksHQM98ix2QTPhtXfsg80Co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=caGGvcqelZ3VTnyY9z2yJ3CzHd/XH2fxxlIn3275iN1nQT1xgnwuSg7KfsXUeMuCr
         9NK8/E3ER268LCX/kp0j5OyE4s6vLCAhpTuxwNoAu7g1BDlpJabZftkrCXG5KKbr0k
         ol3Zz7hyjLil4qeeZyz6zEt+PSe0d/l1oIeS1g7agRQ+jbYlfdLnOz38LmIYsMR8Fn
         5coemk6qRWErF1vpgkUIGutxSJpGDECUudsKlSl6/BtK+Qnbsm8uNn/IQjifU/9G71
         W4wjf+rNtMeQL9sv5XGqu0DrejL0mOKJL6gqsvvbnrwJ3Q0K69U2/Uk3a40up29oaH
         Ol+XEshSYuHIA==
Date:   Fri, 1 Sep 2023 10:25:02 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH] drm/ssd130x: Allocate buffer in the CRTC's
 .atomic_check() callback
Message-ID: <5dj43wxsszikpwbwzxx5v5h7jbx4vjjavnhzi26xgfcdp5wsws@t2hd3pawau4t>
References: <20230830062546.720679-1-javierm@redhat.com>
 <6654778d-1f40-1775-c32c-ebf9728bc9a9@suse.de>
 <87ledqbah2.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qhw5hxui7uborewx"
Content-Disposition: inline
In-Reply-To: <87ledqbah2.fsf@minerva.mail-host-address-is-not-set>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qhw5hxui7uborewx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 09:48:09AM +0200, Javier Martinez Canillas wrote:
> Thomas Zimmermann <tzimmermann@suse.de> writes:
>=20
> > Hi Javier,
> >
> > another idea about this patch: why not just keep the allocation in the=
=20
> > plane's atomic check, but store the temporary buffers in a plane struct=
=2E=20
> > You'd only grow the arrays length in atomic_check and later fetch the=
=20
> > pointers in atomic_update. It needs some locking, but nothing complicat=
ed.
> >
>=20
> Yes, that would work too. Another option is to just move the buffers to
> struct ssd130x_device as it was before commit 45b58669e532 ("drm/ssd130x:
> Allocate buffer in the plane's .atomic_check() callback") but just make
> them fixed arrays with the size of the biggest format.
>=20
> That will be some memory wasted but will prevent the problem of trying to
> allocate buffers after drm_atomic_helper_swap_state() has been called.

If we want to go that road, we don't even need an extra allocation, it
can be part of the state or object structure itself.

Maxime

--qhw5hxui7uborewx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZPGf3gAKCRDj7w1vZxhR
xbKvAQCMJzdResZ3bEsMgrE2V/6WGCsjUuFwfnYt7jg9AHOhYgD+Ku7NT7+Twn6Z
4/7EztFhnNPN1pkQHVmljeupKsxrXQg=
=4h8D
-----END PGP SIGNATURE-----

--qhw5hxui7uborewx--
