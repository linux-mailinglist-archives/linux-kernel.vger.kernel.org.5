Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3017B53BC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbjJBNC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237186AbjJBNC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:02:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4755A93;
        Mon,  2 Oct 2023 06:02:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8D7C433C9;
        Mon,  2 Oct 2023 13:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696251743;
        bh=tYgjzEelwToAG5hZdFfT9BvK6R9nIvBGWgQkejATYgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0U7zCa4ZJKEgJHrs6JNk97vPL6vyZ0D9Bc6O7EqQeN/NuxT9QxNhPYZ6H99cH1Dw
         ZFBSGpoBq/gs7nhFgC8X+KxyCCfadab6VwUtORCTGHtQSnYOovyB7KljgDJnBhqfo4
         gV4vGWKbnU1k2EjogZsugUGFUpkVpg2Kvy6O3VRCUR2OFTYJ96KNoEyz5sAOe7/LBE
         ZkpxH1JwLYCodtwEYJcTt/0MCfP7Q079ZethW0vcHcxC6T0e7MwTl30i7sL+t0Nygp
         3vq7XMSoVWHI2+PDj3jfMpzwE5yWZlnehdghfuW0oHnbQKF9eSIZXhrDxoY11V5bKz
         rHG2+XMiEPrtg==
Date:   Mon, 2 Oct 2023 14:02:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Woody Zhang <woodylab@foxmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: sun4i: Fix memory leak on device removal
Message-ID: <06646231-d67e-453a-a1a0-d2665c1f9421@sirena.org.uk>
References: <20231002062957.1741396-1-woodylab@foxmail.com>
 <tencent_E465261B2BB2C1EBAF5C19912B9F19B7E107@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MmQt3Jv7+ExT5bXv"
Content-Disposition: inline
In-Reply-To: <tencent_E465261B2BB2C1EBAF5C19912B9F19B7E107@qq.com>
X-Cookie: Postage will be paid by addressee.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MmQt3Jv7+ExT5bXv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 02, 2023 at 02:29:59PM +0800, Woody Zhang wrote:

> Call spi_master_put to free the spi_master structure on device removal
> and driver detachment.

>  static void sun4i_spi_remove(struct platform_device *pdev)
>  {
> +	struct spi_master *master = dev_get_drvdata(&pdev->dev);
> +
>  	pm_runtime_force_suspend(&pdev->dev);
> +	spi_master_put(master);
>  }

This is just obviously buggy, it doesn't match the registration at all.

--MmQt3Jv7+ExT5bXv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUav1gACgkQJNaLcl1U
h9COpQf/ZZ2D4twgg+aSv1ip9qVUzmoZwIO04bU7hbfXvyVqzX5DF5t0YiR9CNmt
kk91dpgKCXMqyy2GrjKyA4nDVyhh/hJKRLzjfTe9UjkWOV9orLMRfjm3d7GfbS0b
Gezpdi3vBYozHCnAVs1A2o7qrOIJp0KrN5/9dDUAplIFSEiS/viF81OWYdfiYw9v
gLu5boQeqZUJEPcSaJyVQOkzsV1rS8vhEr1cybpgRcmdn33k/DDtA29qwZkgA7Ty
gHXdCG1NXg4l6htjZAsqrzLznJ6WcRwh/VuL5zJIvpfDKeiLIMJhvkMsXWgX9/6l
n/qIkaJnWhvyw01GBpHeRINw0HqKQg==
=tS9I
-----END PGP SIGNATURE-----

--MmQt3Jv7+ExT5bXv--
