Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BBE75C3C3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjGUJyX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Jul 2023 05:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjGUJyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:54:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBFD3A9F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:53:22 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-317-0nzHMNa9O-mcATlUMwzBYg-1; Fri, 21 Jul 2023 10:52:08 +0100
X-MC-Unique: 0nzHMNa9O-mcATlUMwzBYg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 21 Jul
 2023 10:52:05 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 21 Jul 2023 10:52:05 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Richard Gobert' <richardbgobert@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "tom@herbertland.com" <tom@herbertland.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gal@nvidia.com" <gal@nvidia.com>
Subject: RE: [PATCH v2 1/1] net: gro: fix misuse of CB in udp socket lookup
Thread-Topic: [PATCH v2 1/1] net: gro: fix misuse of CB in udp socket lookup
Thread-Index: AQHZuyb8Dgvvf3H/5Uu3VMX13B7+Z6/D+W5A
Date:   Fri, 21 Jul 2023 09:52:05 +0000
Message-ID: <09f45decdd92494f9ef5abb2c5ce13f3@AcuMS.aculab.com>
References: <20230720161322.GA16323@debian> <20230720162624.GA16428@debian>
In-Reply-To: <20230720162624.GA16428@debian>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gobert
> Sent: 20 July 2023 17:26
> 
> This patch fixes a misuse of IP{6}CB(skb) in GRO, while calling to
> `udp6_lib_lookup2` when handling udp tunnels. `udp6_lib_lookup2` fetch the
> device from CB. The fix changes it to fetch the device from `skb->dev`.
> l3mdev case requires special attention since it has a master and a slave
> device.
> 
...
> +/* This function is the alternative to 'inet_iif' and 'inet_sdif'
> + * functions in case we can not rely on fields of IPCB.
> + *
> + * The caller must verify skb_valid_dst(skb) is false and skb->dev is initialized.
> + * The caller must hold the RCU read lock.
> + */
> +inline void udp4_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif)
> +{
> +	*iif = inet_iif(skb) ?: skb->dev->ifindex;
> +	*sdif = 0;
> +
> +#if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
> +	if (netif_is_l3_slave(skb->dev)) {
> +		struct net_device *master = netdev_master_upper_dev_get_rcu(skb->dev);
> +
> +		*sdif = *iif;
> +		*iif = master ? master->ifindex : 0;
> +	}
> +#endif
> +}

You need to make that a 'static inline' in the .h file.
Otherwise the code generated will be horrid.

It would be much better to use the return value - say for 'iif'
then have:
{
	iif = inet_iif(skb) ?: skb->dev->ifindex;

if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
	if (netif_is_l3_slave(skb->dev)) {
		struct net_device *master = netdev_master_upper_dev_get_rcu(skb->dev);

		*sdif = iif;
		return master ? master->ifindex : 0;
	}
#endif
	*sdif = 0;
	return iif;
}

The compiler might generate that is inlined, not inlined
it is definitely better.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

