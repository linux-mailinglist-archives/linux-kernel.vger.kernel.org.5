Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C877A7867
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbjITKAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjITKAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:00:18 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1931A9;
        Wed, 20 Sep 2023 03:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1695204007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HDgBkqd7CGwUFR4E4j39QdMs+mSsvXlDvmJsLeLhHLs=;
        b=oBuPzZNyJyn2WqpUcwM4yY0CbL+6sASmYva4EkuAJKej+9dHR3XMuqIwW8wVXOpJIJhrod
        nnKSf78q2YvMmretbr5VHtunUSO5Ry+82tPpw5o98iAJsIM3gVjymEkGivly8k2VgLg4JB
        iMctt2UAMOuViPWBAMaXkCVnMpEkryA=
Message-ID: <46a28af1045211edd6c44f7b6aa4c23e7b3a208d.camel@crapouillou.net>
Subject: Re: [PATCH v3] PM: Fix symbol export for _SIMPLE_ variants of
 _PM_OPS()
From:   Paul Cercueil <paul@crapouillou.net>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
        rf@opensource.cirrus.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Date:   Wed, 20 Sep 2023 12:00:05 +0200
In-Reply-To: <ZQq8V5D06CaMxWqQ@black.fi.intel.com>
References: <20230920084121.14131-1-raag.jadav@intel.com>
         <790fac97ce79534733fe0bbd93cc0c9eaa835bf2.camel@crapouillou.net>
         <ZQq8V5D06CaMxWqQ@black.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 20 septembre 2023 =C3=A0 12:33 +0300, Raag Jadav a =C3=A9crit=
=C2=A0:
> On Wed, Sep 20, 2023 at 10:53:23AM +0200, Paul Cercueil wrote:
> > Le mercredi 20 septembre 2023 =C3=A0 14:11 +0530, Raag Jadav a =C3=A9cr=
it=C2=A0:
> > > Currently EXPORT_*_SIMPLE_DEV_PM_OPS() use EXPORT_*_DEV_PM_OPS()
> > > set
> > > of macros to export dev_pm_ops symbol, which export the symbol in
> > > case
> > > CONFIG_PM=3Dy but don't take CONFIG_PM_SLEEP into consideration.
> > >=20
> > > Since _SIMPLE_ variants of _PM_OPS() do not include runtime PM
> > > handles
> > > and are only used in case CONFIG_PM_SLEEP=3Dy, we should not be
> > > exporting
> > > their dev_pm_ops symbol in case CONFIG_PM_SLEEP=3Dn.
> > >=20
> > > This can be fixed by having two distinct set of export macros for
> > > both
> > > _RUNTIME_ and _SIMPLE_ variants of _PM_OPS(), such that the
> > > export of
> > > dev_pm_ops symbol used in each variant depends on CONFIG_PM and
> > > CONFIG_PM_SLEEP respectively.
> > >=20
> > > Introduce _DEV_SLEEP_PM_OPS() set of export macros for _SIMPLE_
> > > variants
> > > of _PM_OPS(), which export dev_pm_ops symbol only in case
> > > CONFIG_PM_SLEEP=3Dy
> > > and discard it otherwise.
> > >=20
> > > Fixes: 34e1ed189fab ("PM: Improve EXPORT_*_DEV_PM_OPS macros")
> > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > ---
> > > PS: This is a standalone fix and works without updating any
> > > drivers.
> >=20
> > I had to double-check that, to make sure that none of the drivers
> > using
> > these macros also use pm_ptr() instead of pm_sleep_ptr() to access
> > the
> > exported dev_pm_ops.
> >=20
> > I did not check extensively but everything seems to use
> > pm_sleep_ptr(),
> > so it looks safe enough.
>=20
> I have tested it against -rc2 without any problems.

You'd need to test an "allyesconfig" with CONFIG_PM=3Dy, and
CONFIG_PM_SLEEP disabled. Is that what you tested?

>=20
> > > Changes since v2:
> > > - Drop redundant patches
> > >=20
> > > Changes since v1:
> > > - Update drivers to new set of macros
> > >=20
> > > =C2=A0include/linux/pm.h | 43 +++++++++++++++++++++++++++++----------=
-
> > > ---
> > > =C2=A01 file changed, 29 insertions(+), 14 deletions(-)
> > >=20
> > > diff --git a/include/linux/pm.h b/include/linux/pm.h
> > > index 1400c37b29c7..99a8146fa479 100644
> > > --- a/include/linux/pm.h
> > > +++ b/include/linux/pm.h
> > > @@ -374,24 +374,39 @@ const struct dev_pm_ops name =3D { \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0RUNTIME_PM_OPS(runtim=
e_suspend_fn, runtime_resume_fn,
> > > idle_fn) \
> > > =C2=A0}
> > > =C2=A0
> > > -#ifdef CONFIG_PM
> > > -#define _EXPORT_DEV_PM_OPS(name, license,
> > > ns)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0\
> > > +#define _EXPORT_PM_OPS(name, license,
> > > ns)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct dev_pm_o=
ps
> > > name;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__EXPORT_SYMBOL(name,=
 license,
> > > ns);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct dev_pm_o=
ps name
> > > -#define EXPORT_PM_FN_GPL(name)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0EXPORT_SYMBOL_GPL(name)
> > > -#define EXPORT_PM_FN_NS_GPL(name,
> > > ns)=C2=A0=C2=A0EXPORT_SYMBOL_NS_GPL(name,
> > > ns)
> > > -#else
> > > -#define _EXPORT_DEV_PM_OPS(name, license,
> > > ns)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0\
> > > +
> > > +#define _PM_OPS(name, license,
> >=20
> > This macro creates a dev_pm_ops that's meant to be garbage-
> > collected by
> > the compiler; so maybe name it _USELESS_PM_OPS() or something like
> > that.
>=20
> _USELESS_PM_OPS() sounds a bit heavy handed ;)
> Gives the impression that the macro itelf is not used anywhere in
> code.
>=20
> Something like _DISCARD_PM_OPS() makes more sense.

Works for me.

>=20
> Raag

Cheers,
-Paul
