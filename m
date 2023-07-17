Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B50756549
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjGQNmI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 09:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjGQNmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:42:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A376A3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:42:01 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-231-n4hzKPGVPluEj2EyIQGAbw-1; Mon, 17 Jul 2023 14:41:59 +0100
X-MC-Unique: n4hzKPGVPluEj2EyIQGAbw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 17 Jul
 2023 14:41:58 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 17 Jul 2023 14:41:58 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Polaris Pi' <pinkperfect2021@gmail.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "ganapathi017@gmail.com" <ganapathi017@gmail.com>,
        "sharvari.harisangam@nxp.com" <sharvari.harisangam@nxp.com>,
        "huxinming820@gmail.com" <huxinming820@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5] wifi: mwifiex: Fix OOB and integer underflow when rx
 packets
Thread-Topic: [PATCH v5] wifi: mwifiex: Fix OOB and integer underflow when rx
 packets
Thread-Index: AQHZtksXz+mc/wmP/kK+sAkKEpAEMa+9+sHw
Date:   Mon, 17 Jul 2023 13:41:58 +0000
Message-ID: <8aacfa081d3f4bc3a3ea8359e610fa3e@AcuMS.aculab.com>
References: <20230714120222.3920248-1-pinkperfect2021@gmail.com>
In-Reply-To: <20230714120222.3920248-1-pinkperfect2021@gmail.com>
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

From: Polaris Pi
> Sent: 14 July 2023 13:02
> 
> Make sure mwifiex_process_mgmt_packet and its callers
> mwifiex_process_sta_rx_packet and mwifiex_process_uap_rx_packet
> not out-of-bounds access the skb->data buffer.
> 
...
> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
> b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
> index 13659b02ba88..88aaec645291 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
> @@ -194,7 +194,8 @@ int mwifiex_process_sta_rx_packet(struct mwifiex_private *priv,
> 
>  	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_offset;
> 
> -	if ((rx_pkt_offset + rx_pkt_length) > (u16) skb->len) {
> +	if ((rx_pkt_offset + rx_pkt_length) > (u16)skb->len ||
> +	    skb->len - rx_pkt_offset < sizeof(*rx_pkt_hdr)) {

What is the (u16) cast for?
The domain of both tx_pkt_offset and rx_pkt_length is 16bits.
Their sum is of type 'int', masking skb->len to 16 bits just
discards high bits (which are probably zero).

The second test should probably be:
	rx_pkt_offset + sizeof(*rx_pkt_hdr) > skb->len
although the first test includes the 'offset > len' check.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

