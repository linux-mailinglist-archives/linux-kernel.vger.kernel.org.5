Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E286A770F04
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 11:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjHEJQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 05:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHEJQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 05:16:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CC71720;
        Sat,  5 Aug 2023 02:16:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 490DE60C37;
        Sat,  5 Aug 2023 09:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C920C433C7;
        Sat,  5 Aug 2023 09:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691226989;
        bh=t0DJnSfJtgbU31SV0UNLXtedUGd37BfS/ndW7mTKU/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJfj+UD1dkOvwhQWzQXBWpN2wS/7wEQFj0c1Yzr9MLE4WexmT9k0615Itsq19DGe0
         lWoyuYJVIAh/BbYj656bIlgyo0hvMa5Hb3t2tu2MdtLy8TtbbNAnanYs2iMm0qL6Mu
         v8F3sElLQYi6SBVwZaf70nt8kDr1sSnNLqqn1nvJ/WTfoeJb9Ra4wGadX4VTrfr/Tm
         bFz0VkrubnMvlJydroSCy+tKP3EUmmmfky/WR0dD7IvkLmV/0ZR4m+NHOt/PTcyhTd
         Ps69CJmx8dtkpsHI2AHP1s72VTNKxNnqxCkD5o8kjyQL/LhvJPCYRxqpRDj8NFaWJ6
         54yL0Ld/fJVbg==
Date:   Sat, 5 Aug 2023 10:16:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt: dt-check-compatible: Find struct of_device_id
 instances with compiler annotations
Message-ID: <20230805-murmuring-primate-42e9d91957f3@spud>
References: <20230804190130.1936566-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eZIVIoSIJPOLxpFH"
Content-Disposition: inline
In-Reply-To: <20230804190130.1936566-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eZIVIoSIJPOLxpFH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2023 at 01:01:29PM -0600, Rob Herring wrote:
> The regex search for declarations of struct of_device_id was missing
> cases that had a compiler annotation such as "__maybe_unused". Improve
> the regex to allow for these. Use '\S' instead of specific characters to
> shorten the regex. That also finds some more compatibles using '.'
> characters.
>=20
> Unfortunately, these changes add ~400 more compatibles without a
> schema.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  scripts/dtc/dt-extract-compatibles | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/dtc/dt-extract-compatibles b/scripts/dtc/dt-extract-=
compatibles
> index a1119762ed08..9df9f1face83 100755
> --- a/scripts/dtc/dt-extract-compatibles
> +++ b/scripts/dtc/dt-extract-compatibles
> @@ -25,8 +25,8 @@ def parse_of_declare_macros(data):
>  def parse_of_device_id(data):
>  	""" Find all compatible strings in of_device_id structs """
>  	compat_list =3D []
> -	for m in re.finditer(r'of_device_id\s+[a-zA-Z0-9_]+\[\]\s*=3D\s*({.*?);=
', data):
> -		compat_list +=3D re.findall(r'\.compatible\s+=3D\s+"([a-zA-Z0-9_\-,]+)=
"', m[1])
> +	for m in re.finditer(r'of_device_id(\s+\S+)?\s+\S+\[\](\s+\S+)?\s*=3D\s=
*({.*?);', data):
> +		compat_list +=3D re.findall(r'\.compatible\s+=3D\s+"(\S+)"', m[3])
> =20
>  	return compat_list
> =20
> --=20
> 2.40.1
>=20

--eZIVIoSIJPOLxpFH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZM4TaQAKCRB4tDGHoIJi
0naKAP0a6lnnf9EluakyiD8DIZ5eTg3C+0e12abEd2BdzXXQrgD/fA2yL0eE2HGW
X6OyUrb1vwNWn39u9Mt3HUhZ8Q4lbwk=
=zKzk
-----END PGP SIGNATURE-----

--eZIVIoSIJPOLxpFH--
