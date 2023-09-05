Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A17B792A31
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbjIEQeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353904AbjIEIem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AC7CC7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693902831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w2dZbqruLad89HXqYH44aUxTnT0KA/arc9cyRXEi5v8=;
        b=Rgua4zbe848WzVjfTLbQ8uyXgex+P52BpPhx5ZRpE/uULpLCJ2aOyKTG5OZ+BYEhFeUD7m
        l+RaAOaOEyIycQbz7SfMaxGFwlMiDOGHtSF00dnexRz/beHuM5ZArPqO6+XeKwALSgaFpl
        sa0kQurpXd3IF8r7pezOKR0psyWmI7k=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-78g2SuE7PhSYjL8YesvvUg-1; Tue, 05 Sep 2023 04:33:50 -0400
X-MC-Unique: 78g2SuE7PhSYjL8YesvvUg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2be48142a6cso4915771fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 01:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693902829; x=1694507629;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2dZbqruLad89HXqYH44aUxTnT0KA/arc9cyRXEi5v8=;
        b=Dv3kn2UVKk3QuyAvFdVD1pNVSLauufvJqbgrSA58IwCBMQzVmn6LD20SPDQwSgWMuE
         wHTEdF8MUrb/wqcPlgOamc8qoxew2wNri0C8kzPNun7fsfA8igZ2oJboZgGV0v8UmlMi
         ZFTqGFYg0aP8jgU62mitGJzv3Tdr06QsbUZ/J4s9lbmMXn4HXtsE49yb+0YMjfv5ZLN3
         bKi96GljJMZ6xC+ROOsLutaNcJ470qwyjEbaMa3Qk1ntUVLqs8QHVLRpiFSUiKe6whA/
         oPxcguUF4put6NT+QPuN0aFeDBV5+ju4+UJuVi2R0RPlTmpE6Xhni0QZ0Jr+Dgh/xjT9
         gzFg==
X-Gm-Message-State: AOJu0YyUO7g5b3G4TxnzdoiYDIQviNYaFebOJrBg3fm7NtwXHLt3HgJO
        eAEhVPnd1XS+N/WGTaM0lU+zuUi8AFRol5aia70non/LVO90V4CzCa21iiCTUEXfIZdD2r3d5Sb
        PvM5ccOjnEWrdf/uPLiC8bZAn
X-Received: by 2002:a2e:bc22:0:b0:2b9:54bd:caed with SMTP id b34-20020a2ebc22000000b002b954bdcaedmr10814653ljf.1.1693902829296;
        Tue, 05 Sep 2023 01:33:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHSHH9ZV0c7ShUCcMbD3sPdS/Ipd+DVqWkpl7VIJC1q9zIUf8iPlXHBjeExzzmuRLtvdjeCA==
X-Received: by 2002:a2e:bc22:0:b0:2b9:54bd:caed with SMTP id b34-20020a2ebc22000000b002b954bdcaedmr10814627ljf.1.1693902828973;
        Tue, 05 Sep 2023 01:33:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-254-194.dyn.eolo.it. [146.241.254.194])
        by smtp.gmail.com with ESMTPSA id j22-20020a170906255600b0099cd008c1a4sm7248580ejb.136.2023.09.05.01.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 01:33:48 -0700 (PDT)
Message-ID: <99b3a1adc89828aa1a761774328e67b386b05611.camel@redhat.com>
Subject: Re: [PATCH] net/mlx5e: Add missing check for xa_load
From:   Paolo Abeni <pabeni@redhat.com>
To:     Chen Ni <nichen@iscas.ac.cn>, borisp@nvidia.com, saeedm@nvidia.com,
        leon@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, sd@queasysnail.net, raeds@nvidia.com,
        ehakim@nvidia.com, liorna@nvidia.com, phaddad@nvidia.com,
        atenart@kernel.org
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Sep 2023 10:33:46 +0200
In-Reply-To: <20230904081210.23901-1-nichen@iscas.ac.cn>
References: <20230904081210.23901-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-04 at 08:12 +0000, Chen Ni wrote:
> Add check for xa_load() in order to avoid NULL pointer
> dereference.
>=20
> Fixes: b7c9400cbc48 ("net/mlx5e: Implement MACsec Rx data path using MACs=
ec skb_metadata_dst")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_accel/macsec.c  | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/=
drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
> index c9c1db971652..d2467c0bc3c8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
> @@ -1673,10 +1673,12 @@ void mlx5e_macsec_offload_handle_rx_skb(struct ne=
t_device *netdev,
> =20
>  	rcu_read_lock();
>  	sc_xarray_element =3D xa_load(&macsec->sc_xarray, fs_id);
> -	rx_sc =3D sc_xarray_element->rx_sc;
> -	if (rx_sc) {
> -		dst_hold(&rx_sc->md_dst->dst);
> -		skb_dst_set(skb, &rx_sc->md_dst->dst);
> +	if (sc_xarray_element) {
> +		rx_sc =3D sc_xarray_element->rx_sc;
> +		if (rx_sc) {
> +			dst_hold(&rx_sc->md_dst->dst);
> +			skb_dst_set(skb, &rx_sc->md_dst->dst);
> +		}
>  	}
> =20
>  	rcu_read_unlock();

@Saeed: I assume this will first go through your tree and then we will
get back via a later PR, right?

In any case Pavan's comment looks reasonable to me, @Chen: please
address it.

Cheers,

Paolo

