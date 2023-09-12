Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289C179CC35
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjILJql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjILJqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:46:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE6212E;
        Tue, 12 Sep 2023 02:46:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD8DC433C7;
        Tue, 12 Sep 2023 09:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694511996;
        bh=7DHj9Jb6FeJL+iN5c+SG2J1fsifqdWlfmhVDvfRmFmA=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=YNEWSRxx6rYG5byoNYu25NrTupZZrCJHQFsBmqTcSdHCcUA9Mcg5oN5lge5vsYtn0
         2kwHtncXuTIcZBX2e+eBJlY1FakhW0sidIOjrD/0IPBRNHM+cKvysBeJe32QOPyG0x
         aIYNam3ajzSElhdt/yI7YJAafhncq55xLyjQuL1Gjt1hhA7wznNtqCdAcTv5Vt6b+l
         56EK+ScpE47SXN+JwnuyZnZfsRKvsCIFe55fWC7g1Q1IOlp0VOb4354uFRnCyUzYaw
         CFLQ0ZgauqCIMX5nRbio2Xs6G1piGNwG6cahxvSfBGthHhQSUjZNMbDKcFVIQeTvv3
         dN4/T8eNdKY9g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 12:46:32 +0300
Message-Id: <CVGUDAU0TSNU.2KQP3U44NG61T@suppilovahvero>
Cc:     <linux-integrity@vger.kernel.org>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "joeyli" <jlee@suse.com>
Subject: Re: [PATCH] integrity: powerpc: Do not select CA_MACHINE_KEYRING
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
X-Mailer: aerc 0.14.0
References: <20230907165224.32256-1-msuchanek@suse.de>
 <CVGF1AQT9WI4.2660NVII9NIDU@suppilovahvero>
 <20230912075134.GM8826@kitsune.suse.cz>
In-Reply-To: <20230912075134.GM8826@kitsune.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 12, 2023 at 10:51 AM EEST, Michal Such=C3=A1nek wrote:
> On Tue, Sep 12, 2023 at 12:45:35AM +0300, Jarkko Sakkinen wrote:
> > On Thu Sep 7, 2023 at 7:52 PM EEST, Michal Suchanek wrote:
> > > No other platform needs CA_MACHINE_KEYRING, either.
> > >
> > > This is policy that should be decided by the administrator, not Kconf=
ig
> >=20
> > s/administrator/distributor/ ?
>
> It depends on the situation. Ideally the administrator would pick the
> distributor that provides a policy that is considered fitting for the
> purpose or roll their own. Unfortunately, they don't always have the
> choice.
>
> For the kerenel's part it should support wide range of policies for
> different use cases, and not force the hand of the administrator or
> distributor.
>
> >=20
> > > dependencies.
> > >
> > > cc: joeyli <jlee@suse.com>
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > ---
> > >  security/integrity/Kconfig | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> > > index 232191ee09e3..b6e074ac0227 100644
> > > --- a/security/integrity/Kconfig
> > > +++ b/security/integrity/Kconfig
> > > @@ -68,8 +68,6 @@ config INTEGRITY_MACHINE_KEYRING
> > >  	depends on INTEGRITY_ASYMMETRIC_KEYS
> > >  	depends on SYSTEM_BLACKLIST_KEYRING
> > >  	depends on LOAD_UEFI_KEYS || LOAD_PPC_KEYS
> > > -	select INTEGRITY_CA_MACHINE_KEYRING if LOAD_PPC_KEYS
> > > -	select INTEGRITY_CA_MACHINE_KEYRING_MAX if LOAD_PPC_KEYS
> > >  	help
> > >  	 If set, provide a keyring to which Machine Owner Keys (MOK) may
> > >  	 be added. This keyring shall contain just MOK keys.  Unlike keys
> > > --=20
> > > 2.41.0
> >=20
> > I'd suggest to add even fixes tag.
>
> Here it is
>
> Fixes: d7d91c4743c4 ("integrity: PowerVM machine keyring enablement")

commit b755dd58d180b796d21bc14d03045e4ab84222b0 (HEAD -> next, origin/next)
Author: Michal Suchanek <msuchanek@suse.de>
Date:   Thu Sep 7 18:52:19 2023 +0200

    integrity: powerpc: Do not select CA_MACHINE_KEYRING

    No other platform needs CA_MACHINE_KEYRING, either.

    This is policy that should be decided by the administrator, not Kconfig
    dependencies.

    Fixes: d7d91c4743c4 ("integrity: PowerVM machine keyring enablement")
    Signed-off-by: Michal Suchanek <msuchanek@suse.de>
    Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 232191ee09e3..b6e074ac0227 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -68,8 +68,6 @@ config INTEGRITY_MACHINE_KEYRING
        depends on INTEGRITY_ASYMMETRIC_KEYS
        depends on SYSTEM_BLACKLIST_KEYRING
        depends on LOAD_UEFI_KEYS || LOAD_PPC_KEYS
-       select INTEGRITY_CA_MACHINE_KEYRING if LOAD_PPC_KEYS
-       select INTEGRITY_CA_MACHINE_KEYRING_MAX if LOAD_PPC_KEYS
        help
         If set, provide a keyring to which Machine Owner Keys (MOK) may
         be added. This keyring shall contain just MOK keys.  Unlike keys

If this look good to you, I'll put it to the -rc2 pull request.

> Thanks
>
> Michal

BR, Jarkko
