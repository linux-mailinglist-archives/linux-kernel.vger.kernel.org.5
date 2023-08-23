Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C16F7851E1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbjHWHoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbjHWHon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:44:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AA1CF1;
        Wed, 23 Aug 2023 00:44:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20F296510D;
        Wed, 23 Aug 2023 07:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068AFC433C9;
        Wed, 23 Aug 2023 07:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692776665;
        bh=+U+2mzuQDP2kSHpIE7UVl09rKO6H/eEHTtGTAsPiD5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SeLwcM76i4y4k6ZRvQzD0Oc8M5UdeEoXR7zNJ8UISApOpTMJxhErbhWJnnYBC3pIZ
         bcwbjWYz73QI9adYAYo3Cc5yB+NeXT9sQ5Ap2x5GUYLp8b00mm3lC33rIlD7VeuAjC
         /GongcmYGUeYxkAcjk35MtLWybYU2DwLoaILQkxfR+7zm/T8JkoasTrwSy4Q/K6m/Y
         jjWpFyEPuBkh4m7QVdjpEgsMIEmYVB2AHdhF7HbD1h6ZwsdIQxlwIW5nEU2XxTGDke
         sPo2nS7TSZZBgWAF3U1XVyvolOT7lrwHZ+deDYa2GdqJidA9UlmGa+6Qvy0pt210nJ
         1fHF3+z26odIQ==
Date:   Wed, 23 Aug 2023 09:44:22 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc:     syzbot <syzbot+3a0ebe8a52b89c63739d@syzkaller.appspotmail.com>,
        davidgow@google.com, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, rydberg@bitmath.org,
        syzkaller-bugs@googlegroups.com, benjamin.tissoires@redhat.com
Subject: Re: [syzbot] [input?] KASAN: slab-use-after-free Read in
 input_dev_uevent
Message-ID: <nqrdxdcvuhvcs2syjfhcp5fbk4ckgzibc3izxknvsrka3kres6@ae65hqx67c4u>
References: <00000000000035beba060371a468@google.com>
 <ijh2qmdtj452nq3idu2tohkrmfwr2qhbhrnyqzxjkkw2lrby53@v2dffcqdohsx>
 <878ra3m5my.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pjf7pgig5r35thxi"
Content-Disposition: inline
In-Reply-To: <878ra3m5my.fsf@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pjf7pgig5r35thxi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rahul,

On Tue, Aug 22, 2023 at 08:57:41AM -0700, Rahul Rameshbabu wrote:
> On Tue, 22 Aug, 2023 11:12:28 +0200 Maxime Ripard <mripard@kernel.org> wr=
ote:
> > Hi,
> >
> > So, we discussed it this morning with Benjamin, and I think the culprit
> > is that the uclogic driver will allocate a char array with devm_kzalloc
> > in uclogic_input_configured()
> > (https://elixir.bootlin.com/linux/latest/source/drivers/hid/hid-uclogic=
-core.c#L149),
> > and will assign input_dev->name to that pointer.
> >
> > When the device is removed, the devm-allocated array is freed, and the
> > input framework will send a uevent in input_dev_uevent() using the
> > input_dev->name field:
> >
> > https://elixir.bootlin.com/linux/latest/source/drivers/input/input.c#L1=
688
> >
> > So it's a classic dangling pointer situation.
> >
> > And even though it was revealed by that patch, I think the issue is
> > unrelated. The fundamental issue seems to be that the usage of devm in
> > that situation is wrong.
> >
> > input_dev->name is accessed by input_dev_uevent, which for KOBJ_UNBIND
> > and KOBJ_REMOVE will be called after remove.
> >
> > For example, in __device_release_driver() (with the driver remove hook
> > being called in device_remove() and devres_release_all() being called in
> > device_unbind_cleanup()):
> > https://elixir.bootlin.com/linux/latest/source/drivers/base/dd.c#L1278
> >
> > So, it looks to me that, with or without the patch we merged recently,
> > the core has always sent uevent after device-managed resources were
> > freed. Thus, the uclogic (and any other input driver) was wrong in
> > allocating its input_dev name with devm_kzalloc (or the phys and uniq
> > fields in that struct).
> >
> > Note that freeing input_dev->name in remove would have been just as bad.
> >
> > Looking at the code quickly, at least hid-playstation,
> > hid-nvidia-shield, hid-logitech-hidpp, mms114 and tsc200x seem to be
> > affected by the same issue.
>=20
> I agree with this analysis overall. At least in hid-nvidia-shield, I can
> not use devm for allocating the input name string and explicitly free it
> after calling input_unregister_device. In this scenario, the name string
> would have been freed explicitly after input_put_device was called
> (since the input device is not devres managed). input_put_device would
> drop the reference count to zero and the device would be cleaned up at
> that point triggering KOBJ_REMOVE and firing off that final
> input_dev_uevent.
>=20
> I think this can be done for a number of the drivers as a workaround
> till this issue is properly resolved. If this seems appropriate, I can
> send out a series later in the day. This is just a workaround till the
> discussion below converges (which I am interested in).

I'm sorry, I don't know the input framework well enough to understand
what you had in mind exactly. Could you send a patch with your
suggestion for the hid-nvidia-shield so we can discuss this further?

That being said, I think that the current design around name, phys and
uniq is fairly treacherous to drivers and we should aim for a solution
that prevents that issue from being possible at all.

I was inclined to go for a char array for each to get rid of the pointer
entirely, but Benjamin raised some concerns over the structure size so
it's probably not a great solution.

Maxime

--pjf7pgig5r35thxi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZOW41gAKCRDj7w1vZxhR
xXKJAQCEK1rAjPxsdcZgi34c4OKKkP/gqsHvgTjxIM7DY8rajgD+N66a5hAibrZ0
O6fjdXZLVoMouFCKcA34BpggpyVFGws=
=pBNd
-----END PGP SIGNATURE-----

--pjf7pgig5r35thxi--
