Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DE27DA557
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 08:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjJ1Gi6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 28 Oct 2023 02:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJ1Gi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 02:38:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2927AAB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 23:38:53 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-53-WxaLHLu_OZ2prnQx6wMy0Q-1; Sat, 28 Oct 2023 07:38:49 +0100
X-MC-Unique: WxaLHLu_OZ2prnQx6wMy0Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 28 Oct
 2023 07:38:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 28 Oct 2023 07:38:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Shinas Rasheed' <srasheed@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "hgani@marvell.com" <hgani@marvell.com>,
        "vimleshk@marvell.com" <vimleshk@marvell.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        "Sathesh Edara" <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: RE: [PATCH net-next v2 3/4] octeon_ep: implement xmit_more in
 transmit
Thread-Topic: [PATCH net-next v2 3/4] octeon_ep: implement xmit_more in
 transmit
Thread-Index: AQHaBomkOels9gSWWE2IVlse9GkwiLBevpOA
Date:   Sat, 28 Oct 2023 06:38:51 +0000
Message-ID: <0fc50b8e6ff44c43b10481da608c95c3@AcuMS.aculab.com>
References: <20231024145119.2366588-1-srasheed@marvell.com>
 <20231024145119.2366588-4-srasheed@marvell.com>
In-Reply-To: <20231024145119.2366588-4-srasheed@marvell.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shinas Rasheed
> Sent: 24 October 2023 15:51
> 
> Add xmit_more handling in tx datapath for octeon_ep pf.
> 
...
> -
> -	/* Ring Doorbell to notify the NIC there is a new packet */
> -	writel(1, iq->doorbell_reg);
> -	iq->stats.instr_posted++;
> +	/* Ring Doorbell to notify the NIC of new packets */
> +	writel(iq->fill_cnt, iq->doorbell_reg);
> +	iq->stats.instr_posted += iq->fill_cnt;
> +	iq->fill_cnt = 0;
>  	return NETDEV_TX_OK;

Does that really need the count?
A 'doorbell' register usually just tells the MAC engine
to go and look at the transmit ring.
It then continues to process transmits until it fails
to find a packet.
So if the transmit is active you don't need to set the bit.
(Although that is actually rather hard to detect.)

The 'xmit_more' flag is useful if (the equivalent of) writing
the doorbell register is expensive since it can be delayed
to a later frame and only done once - adding a slight latency
to the earlier transmits if the mac engine was idle.

I'm not sure how much (if any) performance gain you actually
get from avoiding the writel().
Single PCIe writes are 'posted' and pretty much completely
asynchronous.

The other problem I've seen is that netdev_xmit_more() is
the state of the queue when the transmit was started, not
the current state.
If a packet is added while the earlier transmit setup code
is running (setting up the descriptors etc) the it isn't set.
So the fast path doesn't get taken.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

