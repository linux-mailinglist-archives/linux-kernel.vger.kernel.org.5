Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685B87A0935
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbjINP2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbjINP2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:28:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE6B1FCC;
        Thu, 14 Sep 2023 08:28:19 -0700 (PDT)
Received: from mercury (dyndsl-091-248-132-131.ewe-ip-backbone.de [91.248.132.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 41464660734A;
        Thu, 14 Sep 2023 16:28:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694705297;
        bh=scTdHYUG3vlS8gakKlEwrcrCH5h02xxYjz9XR2kOUbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HNN97fIGOsZXFOAxfItgx7XGN1wZEvWnbDV24dmlW8E5O0Ehv7q7uSDG5PSFGS9rF
         pPpu4qGy+2dcYtcVvvjBENdESMpUqPttEKisnJMbypehHsYBh/0nz9edh6Jt7nD2pC
         wqAnfIbyUo/S644/flMUPfuet0c5tvJNnLLy8HX9C2Y7GXQNAWo5LWcbALcY/NGmXm
         /YBSU4+Ybz58Wtx3OfNDQ20MZK8ojSzoXMnbZB+jyTPKx397gvz8RRZAjUXc0adspP
         KEcz/plnvUpNlUoAgxeR7bmWCw3JlJI5+9b1Fgu/N4j3eNJ6KZudKBegQJ/npyTTIG
         ukUMWQqAojSuA==
Received: by mercury (Postfix, from userid 1000)
        id 3E039106098B; Thu, 14 Sep 2023 17:22:07 +0200 (CEST)
Date:   Thu, 14 Sep 2023 17:22:07 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH] power: supply: Propagate of_node to child device
Message-ID: <20230914152207.ezerlzxrizmcie4e@mercury.elektranox.org>
References: <20230704-power-of-v1-1-cc82d2eda65b@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f5wbotyrng53giaf"
Content-Disposition: inline
In-Reply-To: <20230704-power-of-v1-1-cc82d2eda65b@axis.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f5wbotyrng53giaf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 04, 2023 at 09:43:29AM +0200, Vincent Whitchurch wrote:
> Ensure that the dynamically created power supply device sets its
> ->of_node if the parent device has one.  This brings it in line with
> several other subsystems (see git grep 'of_node =3D.*parent.*of_node') and
> allows easier identification of the device from udev rules and similar.
>=20
> Before this patch:
>=20
>  /sys/class/power_supply# ls -l bq256xx-battery/of_node
>  ls: cannot access 'bq256xx-battery/of_node': No such file or directory
>  # ls -l bq256xx-battery/hwmon1/of_node
>  ls: cannot access 'bq256xx-battery/hwmon1/of_node': No such file or dire=
ctory
>=20
> After:
>=20
>  /sys/class/power_supply# ls -l bq256xx-battery/of_node
>  lrwxrwxrwx 1 root root 0 May 17 09:14 bq256xx-battery/of_node ->
>  ../../../../../../../../firmware/devicetree/base/virtio@1/i2c/bq25619@09
>  # ls -l bq256xx-battery/hwmon1/of_node
>  lrwxrwxrwx 1 root root 0 May 17 09:14 bq256xx-battery/hwmon1/of_node ->
>  ../../../../../../../../../firmware/devicetree/base/virtio@1/i2c/bq25619=
@09
>=20
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---

This should use the same value as psy->of_node (so cfg->of_node),
which can be different from the parent of_node in some corner cases.

(also psy->of_node can be dropped in favour of always using
psy->dev->of_node, but that's a separate patch)

P.S.: Sorry for slow review

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 3791aec69ddc6..8769d82dd9c3d 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1368,6 +1368,7 @@ __power_supply_register(struct device *parent,
>  	dev->class =3D power_supply_class;
>  	dev->type =3D &power_supply_dev_type;
>  	dev->parent =3D parent;
> +	dev->of_node =3D parent->of_node;
>  	dev->release =3D power_supply_dev_release;
>  	dev_set_drvdata(dev, psy);
>  	psy->desc =3D desc;
>=20
> ---
> base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
> change-id: 20230704-power-of-4e2ab0bbe48d
>=20
> Best regards,
> --=20
> Vincent Whitchurch <vincent.whitchurch@axis.com>
>=20

--f5wbotyrng53giaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUDJRYACgkQ2O7X88g7
+pqO4A//XUfFDxCE7Nm0TUL1FR7gvKcrM/041CU3HqGCA35PGpOK+l9EdNVfNVV4
dsfi3xvqLN3mVJ1BCO44twaB5o8UvT3CkfLdxOM/IDMJk8JCwib2hXZ1g9GR+KGO
ADwTwSITQSxwVsf/SuRMZBFVpsWksQOOepzm1GphQWtciVpL6UOBEPtkRjBtuxxB
PgzjQ6LHAmZ5aSTEtmRwQSAvXSSVxjt77IsBB+xZcsic4Sw/PTMawjobWz5lSVXz
bzNqwy4TcltTKbHxVXpCqDWQ3oXE19HjlCT3ODXI9GA4RWV34DAelxriljmmfHYV
ERmmWyyeY6hDBdESoPMTD+wSM/VwrJgkjMi1zURnYMrJBkNsQZ64y35g0sOzVcq1
Dh3r8lVO9pZM8jvO+lS5DQ5lTnwAYvV0rM8H9vedXVCGV9EiMbAzTYJMDDcpazkz
WAXPqfjUOeQR+lqdmfSazLXP/TdkOsa+cB7JENlEP5/NSBtE8aRnuEm35K8bXM1C
EbcJMe4aP/UWDaw2UIOQ4lrVXY6sAwalNWfQgCMy/9BdNgiQ12mXWrfV+rolf3/K
+EW22409TFsfzgvYFXt+udZhfbzg4wLjCwL5ZnAB2x3RQ8K357PjWdGjsj9/5+F0
T92GNhA2xjPXsWFFgB27oKTyZzI7lPwZvodO/Yl4w1ZTtyuCMn8=
=uvBR
-----END PGP SIGNATURE-----

--f5wbotyrng53giaf--
