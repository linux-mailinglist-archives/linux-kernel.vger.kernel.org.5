Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB5B7CFBC8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345871AbjJSN4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345616AbjJSN4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:56:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A80126;
        Thu, 19 Oct 2023 06:56:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8CE501F45B;
        Thu, 19 Oct 2023 13:56:05 +0000 (UTC)
Received: from lion.mk-sys.cz (unknown [10.163.44.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2998C2C564;
        Thu, 19 Oct 2023 13:56:05 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 338842016B; Thu, 19 Oct 2023 15:56:03 +0200 (CEST)
Date:   Thu, 19 Oct 2023 15:56:03 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        stable@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH net] Revert "ethtool: Fix mod state of verbose no_mask
 bitset"
Message-ID: <20231019135603.5ujrcrryepo3fnxb@lion.mk-sys.cz>
References: <20231019-feature_ptp_bitset_fix-v1-1-70f3c429a221@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7eoyyk2q7bwdffce"
Content-Disposition: inline
In-Reply-To: <20231019-feature_ptp_bitset_fix-v1-1-70f3c429a221@bootlin.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
        none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
         REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 8CE501F45B
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7eoyyk2q7bwdffce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 03:16:41PM +0200, Kory Maincent wrote:
> This reverts commit 108a36d07c01edbc5942d27c92494d1c6e4d45a0.
>=20
> It was reported that this fix breaks the possibility to remove existing W=
oL
> flags. For example:
> ~$ ethtool lan2
> ...
>         Supports Wake-on: pg
>         Wake-on: d
> ...
> ~$ ethtool -s lan2 wol gp
> ~$ ethtool lan2
> ...
>         Wake-on: pg
> ...
> ~$ ethtool -s lan2 wol d
> ~$ ethtool lan2
> ...
>         Wake-on: pg
> ...
>=20
> This worked correctly before this commit because we were always updating
> a zero bitmap (since commit 6699170376ab ("ethtool: fix application of
> verbose no_mask bitset"), that is) so that the rest was left zero
> naturally. But now the 1->0 change (old_val is true, bit not present in
> netlink nest) no longer works.
>=20
> Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reported-by: Michal Kubecek <mkubecek@suse.cz>
> Closes: https://lore.kernel.org/netdev/20231019095140.l6fffnszraeb6iiw@li=
on.mk-sys.cz/
> Cc: stable@vger.kernel.org
> Fixes: 108a36d07c01 ("ethtool: Fix mod state of verbose no_mask bitset")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Michal Kubecek <mkubecek@suse.cz>

> ---
>=20
> This patch is reverted for now as we are approaching the end of the
> merge-window. The real fix that fix the mod value will be sent later
> on the next merge-window.
> ---

For the record, the term "merge window" is used for the 2-week interval
between a final and following rc1, not for the whole interval between
two final releases.=20

Michal

--7eoyyk2q7bwdffce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmUxNW0ACgkQ538sG/LR
dpXpzAgAhkLiE6HP1Juk2CV218cbvVeNjzEnX6NKoha+PydKxaIzpb6QsnLQHZXt
gNdLVB/C3vemWW1HiqWGJd4bf5/i9SIvS88KG/GpapU2mL2tE0RWrJZorUy4OPaP
cOMJr2pUBXlgeBZeVZCQ50w1/yhMihq9YrAMaSByIsCiswyKLSXBxybud2nt399i
nnBUY9+glEvWnifL9gh0beV2iuUKPo7NanV6BbT+9RxFdHrezF2rghWEQsebhxsj
OL9XlMNlhcyuONUGbDtMIYMEaKErQz9WXfrgbBnhTBEWv71OZ5k9CTsYV91YoMqW
IT3oflnMb6nOjxoOB7veoq2jWDIWwg==
=NLYO
-----END PGP SIGNATURE-----

--7eoyyk2q7bwdffce--
