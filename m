Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FAF7A2855
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbjIOUoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjIOUne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:43:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EF418D;
        Fri, 15 Sep 2023 13:43:29 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B6DA766072BE;
        Fri, 15 Sep 2023 21:43:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694810607;
        bh=kDX5Yws24juaWMmgBhmpCp9TZ/myYfWBHnXaef5fOzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BcQZmvB+w08zKhoo4FheZE8owlX0OKnJvSQ0LbZemQ16N8hSod/HTg5oNF4aCPm4L
         buZB4IaIefT5RKPyEuUxX0TtUx5ul7l8zHmAvl1pdQl55g4nUN/dBjqEs09FbjiweM
         elDm88eSf7ksoxdDV9qlS7q84AV9w9mRvH3Ldxw4Ozka+eeX5lnLN8h29/X9K5l8Ri
         uPmaLwLj6Gjx3n8lelEmnUXNekpZlN0L55eoX8yzRzs9G2l0WRoSYLRzE88lN3SWqb
         sbA61++Msiocxf+orUrE6MwGIa/WsrtO7K4mAVsDsld5AEP5LtSO+WPmdfYJipM6CD
         dGyS7fS5kXysg==
Received: by mercury (Postfix, from userid 1000)
        id 16726106044B; Fri, 15 Sep 2023 22:43:25 +0200 (CEST)
Date:   Fri, 15 Sep 2023 22:43:25 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Grant B Adams <nemith592@gmail.com>
Cc:     linux-omap@vger.kernel.org, tony@atomide.com,
        Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/2] power: supply: Fix tps65217-charger vs vbus irq
 conflict
Message-ID: <20230915204325.mokj2nmdwjdekxfo@mercury.elektranox.org>
References: <20230823085430.6610-1-nemith592@gmail.com>
 <20230823085430.6610-2-nemith592@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="flopxljazsb4eo7e"
Content-Disposition: inline
In-Reply-To: <20230823085430.6610-2-nemith592@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--flopxljazsb4eo7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 23, 2023 at 10:54:29AM +0200, Grant B Adams wrote:
> Enabling the tps65217-charger driver/module causes an interrupt conflict
> with the vbus driver resulting in a probe failure.
> The conflict is resolved by changing both driver's threaded interrupt
> request function from IRQF_ONESHOT to IRQF_SHARED.
>=20
> Signed-off-by: Grant B Adams <nemith592@gmail.com>
> ---

Your commit message does not explain why IRQF_ONESHOT is dropped;
IRQF_ONESHOT and IRQF_SHARED are not mutually exclusive.

-- Sebastian

>  drivers/power/supply/tps65217_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supp=
ly/tps65217_charger.c
> index a4bc9f2a10bc..6f68becdbfd0 100644
> --- a/drivers/power/supply/tps65217_charger.c
> +++ b/drivers/power/supply/tps65217_charger.c
> @@ -238,7 +238,7 @@ static int tps65217_charger_probe(struct platform_dev=
ice *pdev)
>  	for (i =3D 0; i < NUM_CHARGER_IRQS; i++) {
>  		ret =3D devm_request_threaded_irq(&pdev->dev, irq[i], NULL,
>  						tps65217_charger_irq,
> -						IRQF_ONESHOT, "tps65217-charger",
> +						IRQF_SHARED, "tps65217-charger",
>  						charger);
>  		if (ret) {
>  			dev_err(charger->dev,
> --=20
> 2.34.1
>=20

--flopxljazsb4eo7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUEweIACgkQ2O7X88g7
+pqBFg//TKpyJrIWxj3CQDqbQlO4Ws8EmT0gAZP8DVzjXF7KZn+RDJ1tCu4QarWl
iOJR72KDBckp2eMwJ3sFdm9MVclv+Z6SvQ9mCv21pCcsZR5I4lClaVHK+FxO23en
vapSg22m8mMtPV7EJsr5UXj4uvRGvBtvZy6VyFc+Afk+u/EmHj8ZUxX27w2oEL/f
xyFBYrXDGkf7hEdzaY9nU9dHjD9qQef9sDE8RlC6GAi4iahW8SysrGhEtPB8yYUR
/HYVAg5S8FEmB+tt5arQO2lkn7Fxz1RKVZlPUaRxx/3HQ2vTqmWBvpG5JkNwezVS
hcD1L0jvBByGxLI/oLNxLW6t56QM6Pz4YkxWdqLJbM+vQiTFaULcKpqxNiNhPBzX
UagvMg8uvGLxZ0rUMg3+EQ1JrkKUAJikZaeoYxUealnAa53i6ozKKG5Y92PeLYyK
yhRtX8FgxKeOT5GyBAn8xT6EUFexigdZ+CZYmsB7B/aWz3S9+rXPNJ5Fxo29g+Bh
H36olrsqE8hqkD1uWrr0dqoIQ0MoWvZxczeiIuMQqtn8yDe24ntxYSAyq62EwPp8
fEVjJwtCsJfqQOiACXtbipOjg0BFY4cwHHJOGy2f9mzL9pJAOTxJq7vWCcZJZaSl
EoPuk2/NG2C6UPB2paj19j/WJAWlgWeKZX1KDP/B/FRCqTMnAZg=
=fRtN
-----END PGP SIGNATURE-----

--flopxljazsb4eo7e--
