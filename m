Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32E3797B5A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343625AbjIGSNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbjIGSNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:13:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431F81710
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694110341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7iV8N0Zs9ekoCmuMeKBQuzMuRWS57eO3gP7qT4sD/5o=;
        b=FCOOQw4bFTIfhWhFOps/1deDBOVbo90uKQmj7+2VJWCyrp3VEHjTTVTPqqrpL+HJdFBaqq
        7Jzzhxdk/WiEmmqYRlaJLq32Y/B1qavVhPYerhsJtM8AL3HK6QSfoorzaGbd43WSZa3OsF
        7btLNRQf7VgAHeCCOBL8bmjl+qlw1Ag=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-fVQbx2WVNc6z7-dDrqubCg-1; Thu, 07 Sep 2023 05:44:50 -0400
X-MC-Unique: fVQbx2WVNc6z7-dDrqubCg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a5c5f0364dso16945466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 02:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694079889; x=1694684689;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7iV8N0Zs9ekoCmuMeKBQuzMuRWS57eO3gP7qT4sD/5o=;
        b=j/oWbonKWnG+1WmEwkRjj239XyLpt1ZKe/K6ryz1yXAkGO2DMPXf7bFliVS4BrREXF
         dRgv0QyHoMgZIQ32ujTL0di2yuRAMAaUCjbtGfCebh1Ivdrf838q1f7O0eTMftufad/x
         jypn/0YkHAyUmKaAVa+B6zYN0hdvzOZMX8i7XrA9xiVDgUR5TvGF8uC3yfdEEYYIGEI+
         fOMqHZKPegbRb/R96WvQ3bPjPB51GcajetXF6hSFFVu7uNMh0gekXqIxOLIkZ7cITnJu
         tYpbjIv6rlRKm6/JA6HC33b95QYBvdh5QAU/8LgYCoLr55bZRmJzjd3NyNy8VVkKv5Zf
         Lh8g==
X-Gm-Message-State: AOJu0Yw87fL860Yw43YNWqld1MTMaykSLNXXuPjgiyn2CbfeJj0gEPS5
        NnEeDo846WAa+g6NF4whtqQy++Tu8OBC6G3vgiT2WoyWcUegItWXaHTTHsk/L++rfJLtZYOKYeB
        3peV6l1goc2uXmE0CNNMWHH2p
X-Received: by 2002:a17:907:cca1:b0:9a6:ae76:d6ae with SMTP id up33-20020a170907cca100b009a6ae76d6aemr3715607ejc.3.1694079889068;
        Thu, 07 Sep 2023 02:44:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnPN4syHJKZykCDJc7KbCt9GyZHbum1qYTeTY8d2HUtrQ1128rOz00zDgwcLVUTwKZzjDO1g==
X-Received: by 2002:a17:907:cca1:b0:9a6:ae76:d6ae with SMTP id up33-20020a170907cca100b009a6ae76d6aemr3715589ejc.3.1694079888723;
        Thu, 07 Sep 2023 02:44:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-112.dyn.eolo.it. [146.241.251.112])
        by smtp.gmail.com with ESMTPSA id ja8-20020a170907988800b0099290e2c163sm10063541ejc.204.2023.09.07.02.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:44:48 -0700 (PDT)
Message-ID: <7b42e1ca549f8d7d18a4df9d74a93cf527071a4d.camel@redhat.com>
Subject: Re: [PATCH 1/3] net: ethernet: bcmasp: fix possible OOB write in
 bcmasp_netfilt_get_all_active()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Hangyu Hua <hbh25y@gmail.com>, justin.chen@broadcom.com,
        florian.fainelli@broadcom.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, mw@semihalf.com,
        linux@armlinux.org.uk, nbd@nbd.name, john@phrozen.org,
        sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
        lorenzo@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        maxime.chevallier@bootlin.com, nelson.chang@mediatek.com
Cc:     bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Date:   Thu, 07 Sep 2023 11:44:46 +0200
In-Reply-To: <20230906092107.19063-2-hbh25y@gmail.com>
References: <20230906092107.19063-1-hbh25y@gmail.com>
         <20230906092107.19063-2-hbh25y@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-06 at 17:21 +0800, Hangyu Hua wrote:
> rule_locs is allocated in ethtool_get_rxnfc and the size is determined by
> rule_cnt from user space. So rule_cnt needs to be check before using
> rule_locs to avoid OOB writing or NULL pointer dereference.
>=20
> Fixes: c5d511c49587 ("net: bcmasp: Add support for wake on net filters")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/et=
hernet/broadcom/asp2/bcmasp.c
> index d63d321f3e7b..4df2ca871af8 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> @@ -535,6 +535,9 @@ void bcmasp_netfilt_get_all_active(struct bcmasp_intf=
 *intf, u32 *rule_locs,
>  	int j =3D 0, i;
> =20
>  	for (i =3D 0; i < NUM_NET_FILTERS; i++) {
> +		if (j =3D=3D *rule_cnt)
> +			break;

Side note: it's a bit unfortunate/confusing that the drivers can
arbitrary return  -EMSGSIZE or silently truncate the list. I think it
would be clearer if we could stick to single behavior - and I'll vote
for -EMSGSIZE.

Cheers,

Paolo

