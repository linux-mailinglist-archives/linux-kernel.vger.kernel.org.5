Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336DB7EEE6B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbjKQJ0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235702AbjKQJZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:25:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6955FD52
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:25:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB81C433C7;
        Fri, 17 Nov 2023 09:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700213151;
        bh=ynP6wGzU5LUouTfo4D4BIT9n/6thiSEuoVGu3nB7YEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FDxpoXMEU2eEutnSwR58ZwSYEmEEkQoep3f+3MKVPVW280HlDub9DJTIODSirzftT
         GOhp+iwygQCMejWYZPNGV4Ufp0gsLHb61pEDRS3JK31CGw/hSnIiYUg9zwVgwPJokJ
         h+twd3Fi2YcBDa/SI7zTPJ+1pGGo2f5jbCve3sZ3HbpJaWuVR53htwbqjomx8sOwQc
         6+cT4CkBwQ4E/BT0oPDDdEbBfJDfi1FTuSsFOhoKt//UnQQOqPOVipT3jXTWYEKQRs
         LZuVZ5j65IrlPYwdvL1njCyxxu/rydwtdT6MRisgdfPiuJNBpk2Q6c/UEvU6NZiWYm
         Gx0SVvxakukhA==
Date:   Fri, 17 Nov 2023 10:25:47 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Toshiaki Makita <toshiaki.makita1@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] veth: fix ethtool statistical errors
Message-ID: <ZVcxmwm/DRTB8QwO@lore-desk>
References: <20231116114150.48639-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wM0LZ3in3H4K3W0K"
Content-Disposition: inline
In-Reply-To: <20231116114150.48639-1-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wM0LZ3in3H4K3W0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> if peer->real_num_rx_queues > 1, the ethtool -s command for
> veth network device will display some error statistical values.
> The value of tx_idx is reset with each iteration, so even if
> peer->real_num_rx_queues is greater than 1, the value of tx_idx
> will remain constant. This results in incorrect statistical values.
> To fix this issue, assign the value of pp_idx to tx_idx.
>=20
> Fixes: 5fe6e56776ba ("veth: rely on peer veth_rq for ndo_xdp_xmit account=
ing")
> Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> ---
>  drivers/net/veth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 0deefd1573cf..3a8e3fc5eeb5 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -225,7 +225,7 @@ static void veth_get_ethtool_stats(struct net_device =
*dev,
>  	for (i =3D 0; i < peer->real_num_rx_queues; i++) {
>  		const struct veth_rq_stats *rq_stats =3D &rcv_priv->rq[i].stats;
>  		const void *base =3D (void *)&rq_stats->vs;
> -		unsigned int start, tx_idx =3D idx;
> +		unsigned int start, tx_idx =3D pp_idx;
>  		size_t offset;
> =20
>  		tx_idx +=3D (i % dev->real_num_tx_queues) * VETH_TQ_STATS_LEN;
> --=20
> 2.20.1
>=20

Hi Albert,

Can you please provide more details about the issue you are facing?
In particular, what is the number of configured tx and rx queues for both
peers?
tx_idx is the index of the current (local) tx queue and it must restart from
idx in each iteration otherwise we will have an issue when
peer->real_num_rx_queues is greater than dev->real_num_tx_queues.

Regards,
Lorenzo

--wM0LZ3in3H4K3W0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZVcxmwAKCRA6cBh0uS2t
rL8vAQCJSYOePaGYIAzOPQ5MeXrdFWCb6zjNMqja2zjHP45xGgEAwDNcSm8iPh7+
8RLoiNT+UNlBNyHWxEGBO5trDBfoRgg=
=15I0
-----END PGP SIGNATURE-----

--wM0LZ3in3H4K3W0K--
