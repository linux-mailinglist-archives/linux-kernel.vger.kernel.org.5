Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECA57F5F97
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345387AbjKWM5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345271AbjKWM5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:57:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C0791
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 04:57:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4141C433CA;
        Thu, 23 Nov 2023 12:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700744248;
        bh=QwjBh/mDzLfgK//ibCN5gogLgPuteQNEfc+ssHHKUMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iA+yVV+Tk2ZeYGlwl6FZUiFqmkwUsz/u6Y2NTaNKF+RMvh3i9pTtRx7aM/U5m6R/3
         zAhL5FhZu6HkxZ9jaNL30DNvIUlQ1BIu7q1DlPoZDucI5DFxniYOXm/iskDfTwPVvn
         oToXverh7L3Ax/MawE4ulncpNwb61JrYqEoCMWog0PnqzpvNDF4N+YQpbKHch4ZBKe
         XderX+dHiINBY/A43KbY82QcPCec1mO9SByMdPZuDePNQqoq5K9kxQLY7H6JN0djkx
         DSzluwwweljAFoswIN9FfbrZma2962ynGJC0MsnrE1hIP3+bzihaE5VOragCNzvk2K
         TMXzWJCxVNrtw==
Date:   Thu, 23 Nov 2023 12:57:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulator: event: Add regulator netlink event support
Message-ID: <ZV9MNdOCkIpLB+6Y@finisterre.sirena.org.uk>
References: <20231121101331.22837-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hfmqmatwhTT9Ynoi"
Content-Disposition: inline
In-Reply-To: <20231121101331.22837-1-naresh.solanki@9elements.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hfmqmatwhTT9Ynoi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 21, 2023 at 10:13:30AM +0000, Naresh Solanki wrote:

> This commit introduces netlink event support to the regulator subsystem.

This looks a lot nicer, there's some feedback below but nothing
maissively substantial.

> +#ifdef CONFIG_NET

This is essentially the entire file - it's probably better to just put
the stub functions in the header and do the building with Kconfig.

> +static unsigned int reg_event_seqnum;
> +struct reg_genl_event {
> +	char reg_name[15];
> +	u64 event;
> +};

Given that this is going to get sent to userspace shouldn't it be in a
uapi header?  Some of the other event types don't seem to do this
though...  that might be an issue with those examples though.   We'll
also make the event numbers into uapi so they should go in a uapi header
as well.

I'm also not clear on where the 15 byte limit comes from.

> +EXPORT_SYMBOL(reg_generate_netlink_event);

Everything else in regulator is EXPORT_SYMBOL_GPL() so this should be
too - though given that the only caller is _notifier_call_chain() which
is in the core does it need to be exported at all?  I can't see a case
for anything calling it independently of that.

--hfmqmatwhTT9Ynoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVfTDQACgkQJNaLcl1U
h9DE+AgAga4ENL0Saql9gBXIwkH6zvOVuaGmUXjNr3LkVsPIwx/Q+Y1ibLCLedxx
AV7Z3sEFpJehQspzg9X6lkbiX+yskuv6ri/PMpSi2MbKAt61H/uvkKG7rGQ7O4LI
Wgl49dQgmOsEGWLb5MQP+iw5YBxoHUzehMipRbVcRrm+04UAK6AFyo4sXu5TCoRQ
jHnN6UpiNTFn0SNmdJD/BVLuT3tpAFTVIRE42maydS0+Xg5twXR2YnAsoiGrwUoJ
5exsjlFYBhOg6GOcU4iWIm1UlnBQ1A5nnG2p8vPDvjNL5ZXHSYj1sUkpROXDkZXK
VdMJNENScxdGePD/EFHYeyV6uZkOgg==
=Xef/
-----END PGP SIGNATURE-----

--hfmqmatwhTT9Ynoi--
