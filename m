Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35496787A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243654AbjHXVOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243707AbjHXVOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:14:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C411BF2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B85F766B82
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B2FC433C7;
        Thu, 24 Aug 2023 21:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692911639;
        bh=PiGcZUN2mZd8Vk93r4PySjNQnqlrRCaVX8oTOFh7OqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oEXQr0fuvabRy+l8/XTJS8uJZQ3ZVQ8HayMse9JlsrxWeJV5K8A1ApIkmvuyW/RZ3
         JcRPZ/xLH8Blkopi2A3f24J+Nt4RigSHjRuUeExdyI6mPIYs3JtbGdfXjNC6ZcprTS
         V+Sc3jODlFrmevNiFXZWDSF9vlqa3DKIljy3Z7QreSYlJRnOlBAkKEOYkeQNjzD1d5
         IPBKuUR/Dmp3AcZa1Kb8S02wu4biNzPn9UR9fZAy+iYfBuEU7U845tPxCKLhcr/a64
         AhZpfVfju4ZRmSepnmQ17oEPBeX3BEb25U6V+i8LYOtEEVqIIj1QSBQQSp9J2WmDvz
         NknwmxhpLISjQ==
Date:   Thu, 24 Aug 2023 22:13:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: userspace-consumer: Add regulator event
 support
Message-ID: <ZOfIEzYPU/35Qmtd@finisterre.sirena.org.uk>
References: <20230803111225.107572-1-Naresh.Solanki@9elements.com>
 <d3ea0fe2-00bb-493b-aca7-ba7a31bd3c78@hatter.bewilderbeest.net>
 <CABqG17j1KGoW3UVM1kttg08V0R0xC0gP3YOyE7DeboE4SWa+vw@mail.gmail.com>
 <0643fa76-5320-4e1a-84d4-c3be4b1d1df6@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9kU3F9W7z+4t58cA"
Content-Disposition: inline
In-Reply-To: <0643fa76-5320-4e1a-84d4-c3be4b1d1df6@hatter.bewilderbeest.net>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9kU3F9W7z+4t58cA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 04, 2023 at 05:02:02AM -0700, Zev Weiss wrote:
> On Fri, Aug 04, 2023 at 01:59:44AM PDT, Naresh Solanki wrote:
> > On Fri, 4 Aug 2023 at 02:15, Zev Weiss <zev@bewilderbeest.net> wrote:
> > > On Thu, Aug 03, 2023 at 04:12:25AM PDT, Naresh Solanki wrote:

> > > >Add sysfs attribute to track regulator events received from regulator
> > > >notifier block handler.

> > > >+      mutex_lock(&events_lock);
> > > >+      e = data->events;
> > > >+      data->events = 0;

> > > ...particularly this bit -- a read operation on a read-only file (and
> > > especially one with 0644 permissions) having side-effects (clearing the
> > > value it accesses) seems on the face of it like fairly surprising
> > > behavior.  Is this a pattern that's used elsewhere in any other sysfs
> > > files?

> > These are regulator events & are valid when it occurs.
> > Userspace application is intended to consume them as soon as the
> > event is notified by kernel sysfs_notify.

> Sure, but that doesn't really address what I was concerned about -- as
> written this is a read operation on a read-only file (0444, not 0644 as I
> mistakenly wrote above) that nevertheless alters the state of an internal
> kernel data structure.  Can you point to any other sysfs attributes that
> behave like that?  I can't think of one offhand, and I'd be reluctant to
> establish the precedent.

The whole userspace consumer interface is a kludge so I'm not super
concerned about what's effectively clear on read interrupts, ideally
it'd be a file reporting the current status but we don't have a way to
read the current status of everything...

> Would a uevent-based mechanism maybe be a better fit for the problem you're
> trying to solve?

uevents would definitely be good to have, and much better than polling
for apps that can use them, but they don't preclude a read interface.

> > > However, it looks like this would expose the values of all the
> > > REGULATOR_EVENT_* constants as a userspace-visible ABI -- is that
> > > something we really want to do?

> > Yes.

> Given that the REGULATOR_EVENT_* constants are defined in headers under
> include/linux and not include/uapi, it doesn't seem like they were intended
> to be used as part of a userspace-visible interface.  If they're going to
> be, I think they should be moved to the uapi directory so that applications
> can use the proper definitions from the kernel instead of manually
> replicating it on their own (but I suspect we should probably find a
> different approach instead).

This is a concern.  We should probably indirect via strings at least,
but that probably implies a file per event at least.  Due to that I'll
drop this patch for this release.  Sorrt for doing that this late, it's
not ideal - like I said in the other thread I lost this thread under a
bunch of others in my inbox.

--9kU3F9W7z+4t58cA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTnyBIACgkQJNaLcl1U
h9C/jwf/YMo93sl87ElpEosMLMUWnpUp3dXYSyESJg0fuP2esFY8x/5llbWR7bGr
kaA09Slf71V8YXXVDjUmNmkAzmJNpdaruVMu2FhzfM25HFszA5bIl0s0FcpD1T6s
x6a7HzO3Y55PN3MNZwBkqKASwu+S9O4vUqofpVRUUkoJepc0tm5UZOfFV4KVsAIm
xYrJDX4gcjObkDgPf5jKNJqu/KkSwCxsB1w4JkfcE+hyGh36cj+hQjd4diwGZYiG
jc16NqctSF1ywkEv8nOK5lCVurSyWE7ek7jeTCPEuxUkCZv4B0iKmQ9ZDhCk2t1Z
Odf5L/hOdI3Bg+DLpfoLHoJUCAsHJg==
=Fe1z
-----END PGP SIGNATURE-----

--9kU3F9W7z+4t58cA--
