Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40D77B9895
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240531AbjJDXKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbjJDXKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:10:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFC3D8;
        Wed,  4 Oct 2023 16:10:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01CEC433C7;
        Wed,  4 Oct 2023 23:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696461006;
        bh=sr3ifcYlnQGpK7RnHCI5qP/JfUY4gY6cRzG0hwZktu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CIyVh30kCx/E3HkEEl2nSJkUfwb0kjb3KXI8ARak+kw+rvNQCmJglP/CtQEaDBYOP
         UmJgRx1niIHuZVu4fiOMIgM/xdw8s/DHLyfteoAF9i91+74oPnxgaSVFgPqxVQxweM
         XYaRLUNX1C6k4R5n9S0lI0bCMK2o5Ck45irETSBscxPno1fsrsFattKipt61D0NwG9
         x1ocuKJBWNjJjS/B14TN+SU3kAuHDrUgdr1cKqJskBA/uaVMKgNZx0tQ+j1gdrZIhg
         9WIc2//ILIuhU4N2mnGJh+bVkeVx82YFrXhrsvuPZPhJllvTE7UZ3YBIekGloVb7sc
         O/MzMZwgP7sYw==
Received: by mercury (Postfix, from userid 1000)
        id B812E106052D; Thu,  5 Oct 2023 01:10:03 +0200 (CEST)
Date:   Thu, 5 Oct 2023 01:10:03 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jun.ma2@amd.com
Subject: Re: [PATCH 2/3] power: supply: Don't count 'unknown' scope power
 supplies
Message-ID: <20231004231003.z55btgajmixxadqo@mercury.elektranox.org>
References: <20230926225955.386553-1-mario.limonciello@amd.com>
 <20230926225955.386553-3-mario.limonciello@amd.com>
 <20230930201826.biy27esyw4ttxt4p@mercury.elektranox.org>
 <8d4e4b74-4477-41e0-a690-8b9f38907a7b@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mavrvis2xy3vzwff"
Content-Disposition: inline
In-Reply-To: <8d4e4b74-4477-41e0-a690-8b9f38907a7b@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mavrvis2xy3vzwff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 01, 2023 at 07:00:11PM -0500, Mario Limonciello wrote:
> Let me try to add more detail.
>=20
> This is an OEM system that has 3 USB type C ports.  It's an Intel system,
> but this doesn't matter for the issue.
> * when ucsi_acpi is not loaded there are no power supplies in the system =
and
> it reports power_supply_is_system_supplied() as AC.
> * When ucsi_acpi is loaded 3 power supplies will be registered.
> power_supply_is_system_supplied() reports as DC.
>=20
> Now when you add in a Navi3x AMD dGPU to the system the power supplies do=
n't
> change.  This particular dGPU model doesn't contain a USB-C port, so there
> is no UCSI power supply registered.
>=20
> As amdgpu is loaded it looks at device initialization whether the system =
is
> powered by AC or DC.  Here is how it looks:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_device.c?h=3Dlinux-6.5.y#n3834
>=20
> On the OEM system if amdgpu loads before the ucsi_acpi driver (such as in
> the initramfs) then the right value is returned for
> power_supply_is_system_supplied() - AC.
>=20
> If amdgpu is loaded after the ucsi_acpi driver, the wrong value is return=
ed
> for power_supply_is_system_supplied() - DC.
>=20
> This value is very important to set up the dGPU properly.  If the wrong
> value is returned, the wrong value will be notified to the hardware and t=
he
> hardware will not behave properly.  On the OEM system this is a "black
> screen" at bootup along with RAS errors emitted by the dGPU.
>=20
> With no changes to a malfunctioning kernel or initramfs binaries I can add
> modprobe.blacklist=3Ducsi_acpi to kernel command line avoid registering t=
hose
> 3 power supplies and the system behaves properly.
>=20
> So I think it's inappropriate for "UNKNOWN" scope power supplies to be
> registered and treated as system supplies, at least as it pertains to
> power_supply_is_system_supplied().

So the main issue is, that the ucsi_acpi registers a bunch of
power-supply chargers with unknown scope on a desktop systems
and that results in the system assumed to be supplied from battery.

The problem with your change is, that many of the charger drivers
don't set a scope at all (and thus report unknown scope). Those
obviously should not be skipped. Probably most of these drivers
could be changed to properly set the scope, but it needs to be
checked on a case-by-case basis. With your current patch they would
regress in the oposite direction of your use-case.

Ideally ucsi is changed to properly describe the scope, but I
suppose this information is not available in ACPI?

Assuming that the above are not solvable easily, my idea would be to
only count the number of POWER_SUPPLY_TYPE_BATTERY device, which have
!POWER_SUPPLY_SCOPE_DEVICE and exit early if there are none.
Basically change __power_supply_is_system_supplied(), so that it
looks like this:

=2E..
	if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_SCOPE, &ret))
		if (ret.intval =3D=3D POWER_SUPPLY_SCOPE_DEVICE)
			return 0;

	if (psy->desc->type =3D=3D POWER_SUPPLY_TYPE_BATTERY)
			(*count)++;
    else
		if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_ONLINE,
					&ret))
			return ret.intval;
=2E..

That should work in both cases.

-- Sebastian

> > >   drivers/power/supply/power_supply_core.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power=
/supply/power_supply_core.c
> > > index d325e6dbc770..3de6e6d00815 100644
> > > --- a/drivers/power/supply/power_supply_core.c
> > > +++ b/drivers/power/supply/power_supply_core.c
> > > @@ -349,7 +349,7 @@ static int __power_supply_is_system_supplied(stru=
ct device *dev, void *data)
> > >   	unsigned int *count =3D data;
> > >   	if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_SCOPE, &ret))
> > > -		if (ret.intval =3D=3D POWER_SUPPLY_SCOPE_DEVICE)
> > > +		if (ret.intval !=3D POWER_SUPPLY_SCOPE_SYSTEM)
> > >   			return 0;
> > >   	(*count)++;
> > > --=20
> > > 2.34.1
> > >=20
>=20

--mavrvis2xy3vzwff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUd8McACgkQ2O7X88g7
+poWjA/9HdkzUe4iv3N7kLQ1MX8LLpg04IlI4kPsSscO2XL8B9FQgQVSaVaH8bSc
IB0/8clq1dhPvpsC2lZBKGxEnzm1DA3Q97UZ+i+pO2yCeYB2b/I5dnXLYr5m3teZ
prHUSgoGMNF3lc5QeLO7hc/RT4pKbk7eme3geqCj8Z1JDRUnJLychMMhtzqRch7k
14ZZWZ3e93vDs6J0Kz5/MT4ws/4m831MzA9sbXK2qRtugV259jeEw/6UtUIdyp8V
QK2/P9k6ZXfcZjzkm0JVm19lWvyF3YM2WzeoLLeYE8bz6BIBQauw/DyTknKFDmQx
3ftwFyd6fbnfOfKRgXac2zlrG5W1v1y6Xs8GfMvrWf1KxvXNrpzU8VBCArJk67k3
CP2s6f7CvFxe9XrMinsge58mraayaqSUmc9QeM/tKuBNpUGglUJo/FFFHMBfITqb
M1zll2uGFGajOfEpiI9pHIIVWhXzVCoYUdvu3KJsmTciuqSX2qJWY/76P6YdVLXR
JT1i64+6ca7VklC5PWgG98s2xoGHYowVmGSChtEkYvAD8GpR+CQELBj8R6xcApAu
njA+xFNG6ZvP8BSLYUd5Qon+EHqHmBA70oj9FkZueKie1+YLSlH4prMn5aQqThkP
WZodfhxa5KMbzTbnsd62i4yZkfbU1uKFsgYPXDCA/feQeuQLLwE=
=/PRi
-----END PGP SIGNATURE-----

--mavrvis2xy3vzwff--
