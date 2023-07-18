Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB10757A13
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGRLJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGRLJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAFC10EF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689678517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/D23IWoSLSFILOueJ1sqkvAVYDlEez/SkBsdzHm8uI=;
        b=Qwr94Hb4EQDniG06eNej5MzlE63kDHzRMG8lG+AXGLX3Uq+iWkKYE5l0tkDsQOIapYZ2rc
        /ftXHav8bYKD6Clbh8v/vw8f+8/828kj17cODUsSs1mBs/C431RYipWAd+LNPDvS251JE1
        Ffnooz3SSp55VQ68iDKSFclXhbEvhSE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-WPuvamrZMOCwZOwHo3bXkw-1; Tue, 18 Jul 2023 07:08:34 -0400
X-MC-Unique: WPuvamrZMOCwZOwHo3bXkw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-402fa256023so10322051cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689678514; x=1692270514;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/D23IWoSLSFILOueJ1sqkvAVYDlEez/SkBsdzHm8uI=;
        b=hSQbb7kBpsyXFGYdLpsvT6LjqzeBZAoxhEuNcsBp2PYA2nO46tRatpUuRnGK4WT7dc
         9we4sCDtG5JQjpZDdO69Xh6nYDq7ot96CykRKIXS1vsh3S6Ivw+TyQ1zO34hR8TeuQoP
         X2INbcW+ZsXqG2H9Un30wygJmKWZUr4T+dGzjT7y7KNCir2uzngNOLjtVwisj8LPOqAM
         phy6lFdtlOw+eclirmk8dymYy9oWt6WE4nM8NhTd3jvy9sBLuTd9KwO0rJcG5+Yos1fb
         ZvVkP6adWiNj/77fuIMb5jNZgP/gRX7X9ttnBgyWIUV3csRO6sunUVEkBR4OFj93a1au
         wY9A==
X-Gm-Message-State: ABy/qLZWGOKAX5DLIrCVyXO7dQgYwxEjdaJj0mVEwVxdbcp3bmF2K/86
        n6WqTU7nXhzP0kX8O91Kpz6VtvrjUcx63y0To1jmHDjpMomho8WJuWZzQvzu+WrZRG+IjpBxrUr
        zE/tb1PpsQedgscHYBWsFZjfh
X-Received: by 2002:a05:622a:1813:b0:403:59f8:25d9 with SMTP id t19-20020a05622a181300b0040359f825d9mr10942798qtc.2.1689678514166;
        Tue, 18 Jul 2023 04:08:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFGhFXiTRLs4F3xnaUNh0orK4AP5HoC/bfuuBgboh4MQUDGnGejRCegiLOMSjuGkZVMtRDmDA==
X-Received: by 2002:a05:622a:1813:b0:403:59f8:25d9 with SMTP id t19-20020a05622a181300b0040359f825d9mr10942769qtc.2.1689678513856;
        Tue, 18 Jul 2023 04:08:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id r15-20020ac85e8f000000b00403cce833eesm572810qtx.27.2023.07.18.04.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 04:08:33 -0700 (PDT)
Message-ID: <02b2a11c2990fdf21e8cd2c582df67d5883f6eea.camel@redhat.com>
Subject: Re: [net PATCH] octeontx2-af: Adjust Tx credits when MCS external
 bypass is disabled
From:   Paolo Abeni <pabeni@redhat.com>
To:     Geetha sowjanya <gakula@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
        ndabilpuram@marvell.com
Date:   Tue, 18 Jul 2023 13:08:30 +0200
In-Reply-To: <20230716091621.27844-1-gakula@marvell.com>
References: <20230716091621.27844-1-gakula@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-07-16 at 14:46 +0530, Geetha sowjanya wrote:
> From: Nithin Dabilpuram <ndabilpuram@marvell.com>
>=20
> When MCS external bypass is disabled, MCS returns additional
> 2 credits(32B) for every packet Tx'ed on LMAC. To account for
> these extra credits, NIX_AF_TX_LINKX_NORM_CREDIT.CC_MCS_CNT
> needs to be configured as otherwise NIX Tx credits would overflow
> and will never be returned to idle state credit count
> causing issues with credit control and MTU change.
>=20
> This patch fixes the same by configuring CC_MCS_CNT at probe
> time for MCS enabled SoC's
>=20
> Fixes: bd69476e86fc ("octeontx2-af: cn10k: mcs: Install a default TCAM fo=
r normal traffic")
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/mbox.h    |  2 +-
>  drivers/net/ethernet/marvell/octeontx2/af/mcs.c     | 12 ++++++++++++
>  drivers/net/ethernet/marvell/octeontx2/af/mcs.h     |  2 ++
>  drivers/net/ethernet/marvell/octeontx2/af/rvu.h     |  1 +
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c |  8 ++++++++
>  5 files changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/n=
et/ethernet/marvell/octeontx2/af/mbox.h
> index eba307eee2b2..d78d72c0ca18 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -1914,7 +1914,7 @@ struct mcs_hw_info {
>  	u8 tcam_entries;	/* RX/TX Tcam entries per mcs block */
>  	u8 secy_entries;	/* RX/TX SECY entries per mcs block */
>  	u8 sc_entries;		/* RX/TX SC CAM entries per mcs block */
> -	u8 sa_entries;		/* PN table entries =3D SA entries */
> +	u16 sa_entries;		/* PN table entries =3D SA entries */

This chunk looks like an unrelated bug-fix. Please move it to a
separate patch or mention in the commit message why it's needed here.

Thanks!

Paolo

