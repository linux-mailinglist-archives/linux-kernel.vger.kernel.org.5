Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28278806DBD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378175AbjLFLSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378100AbjLFLSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:18:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619B4CA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701861530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJncplPRljOk1kpx+WzGu84RdAxKtfrBb2w62k3mS4o=;
        b=aYkklvLLJlFZ2i8RDJM2k3bfgx9jjxKqMkClEh6Lsj6fd/Q1OAzxjttNFdrxBZ/aKsc0oZ
        CPIteijzp0RFNBXVakpfwEJHgNyUTHWVGronzeWkQX+eyoK8JLP34jZV47x+I5w6q3bU6A
        a66WcMRAaDYwfIhiyWvco41bNXmy8Gc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-ImqYeU2NNymMw-owoUm-Gg-1; Wed, 06 Dec 2023 06:18:48 -0500
X-MC-Unique: ImqYeU2NNymMw-owoUm-Gg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a19a974cccfso87850866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 03:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701861527; x=1702466327;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJncplPRljOk1kpx+WzGu84RdAxKtfrBb2w62k3mS4o=;
        b=AiNVscARBrvd4I0Xddw6qQtdWNXdHuAzrZK3u/wSBGFWH69tgxZlTT3NZFrEuOpZd2
         38tCKrRF1TaIEBEeQhV2NAxCFcwsF7XcViRyZos/83Ck8cfupD29B/N58+jWIe8xfR+5
         Ut8ZdoB+queUVqejUPswWRuXgPJqSCJjGp1BWxqJZulmAa128zvFm227leJIqCL691tr
         Jy9SUQo5jKJHisYbXquzBOryJYF8x4upIhQFf7u9ec3+v1xv+xBtwIXa4Umh4mmahjr5
         43ltNb5ol9vLdgNro/o/TfPX0FvyzI+KVZgNNdQax1NXjNQfmyIHcoupln0Ba/nSsX3O
         +i8Q==
X-Gm-Message-State: AOJu0YxgyLvRWWxXfGgkdpiGNLGSsnjG7vi8Z9O7oEoa2GDTPrHYHavy
        jFrbLiLiM7Eet30z7/L+OWiKMBuuv1eArQtFI1W13FYxRtdPHhqt71GsQ5cwltwrUbsI66JJmIV
        4e6Y/4Ex4IdZv6nneTbb70fvcYgncOh4H
X-Received: by 2002:a17:907:d40d:b0:9e6:c282:5bd5 with SMTP id vi13-20020a170907d40d00b009e6c2825bd5mr1127054ejc.3.1701861527664;
        Wed, 06 Dec 2023 03:18:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0Um7Bufb1/ZT9/Kaw3C5YP9nLXIl+1wHqoIb4g2MvErWwV8whtClxgMm14gtL9LyWcUS7SQ==
X-Received: by 2002:a17:907:d40d:b0:9e6:c282:5bd5 with SMTP id vi13-20020a170907d40d00b009e6c2825bd5mr1127034ejc.3.1701861527285;
        Wed, 06 Dec 2023 03:18:47 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-243-102.dyn.eolo.it. [146.241.243.102])
        by smtp.gmail.com with ESMTPSA id hd18-20020a170907969200b00a1cbb289a7csm2037614ejc.183.2023.12.06.03.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 03:18:46 -0800 (PST)
Message-ID: <ffd7a4cbefa8c4f435db5bab0f5f7f2d4e2dad73.camel@redhat.com>
Subject: Re: [PATCH V3 net 1/2] net: hns: fix wrong head when modify the tx
 feature when sending packets
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jijie Shao <shaojijie@huawei.com>, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, wojciech.drewek@intel.com
Cc:     shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 Dec 2023 12:18:45 +0100
In-Reply-To: <20231204143232.3221542-2-shaojijie@huawei.com>
References: <20231204143232.3221542-1-shaojijie@huawei.com>
         <20231204143232.3221542-2-shaojijie@huawei.com>
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

On Mon, 2023-12-04 at 22:32 +0800, Jijie Shao wrote:
> @@ -2159,16 +2175,9 @@ static void hns_nic_set_priv_ops(struct net_device=
 *netdev)
>  		priv->ops.maybe_stop_tx =3D hns_nic_maybe_stop_tx;
>  	} else {
>  		priv->ops.get_rxd_bnum =3D get_v2rx_desc_bnum;
> -		if ((netdev->features & NETIF_F_TSO) ||
> -		    (netdev->features & NETIF_F_TSO6)) {
> -			priv->ops.fill_desc =3D fill_tso_desc;
> -			priv->ops.maybe_stop_tx =3D hns_nic_maybe_stop_tso;
> -			/* This chip only support 7*4096 */
> -			netif_set_tso_max_size(netdev, 7 * 4096);
> -		} else {
> -			priv->ops.fill_desc =3D fill_v2_desc;
> -			priv->ops.maybe_stop_tx =3D hns_nic_maybe_stop_tx;
> -		}
> +		priv->ops.fill_desc =3D fill_desc_v2;
> +		priv->ops.maybe_stop_tx =3D hns_nic_maybe_stop_tx_v2;
> +		netif_set_tso_max_size(netdev, 7 * 4096);
>  		/* enable tso when init
>  		 * control tso on/off through TSE bit in bd
>  		 */

Side note: since both 'fill_desc' and 'maybe_stop_tx' have constant
values, for net-next you should really consider replacing the function
pointers with direct-calls.

You currently have at least 2 indirect calls per wire packet, which
hurt performances a lot in case security issues mitigations are in
place.

Cheers,

Paolo

