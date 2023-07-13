Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4780F75274C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbjGMPe5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 11:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjGMPef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:34:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD442213B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:34:29 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-96-72mzMEKxMcawh9IWZJu5jg-1; Thu, 13 Jul 2023 16:34:27 +0100
X-MC-Unique: 72mzMEKxMcawh9IWZJu5jg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 13 Jul
 2023 16:34:26 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 13 Jul 2023 16:34:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Leon Romanovsky' <leon@kernel.org>,
        Krister Johansen <kjlx@templeofstupid.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH net] net: ena: fix shift-out-of-bounds in exponential
 backoff
Thread-Topic: [PATCH net] net: ena: fix shift-out-of-bounds in exponential
 backoff
Thread-Index: AQHZs8j5z2bF0RP/C0e6CLHv2DmaRK+310mw
Date:   Thu, 13 Jul 2023 15:34:25 +0000
Message-ID: <20412c4fb06147c3b2e4ae90ed26fdb7@AcuMS.aculab.com>
References: <20230711013621.GE1926@templeofstupid.com>
 <20230711072603.GI41919@unreal>
In-Reply-To: <20230711072603.GI41919@unreal>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky
> Sent: 11 July 2023 08:26
...
> > +#define ENA_MAX_BACKOFF_DELAY_EXP 16U
> > +
> >  #define ENA_MIN_ADMIN_POLL_US 100
> >
> >  #define ENA_MAX_ADMIN_POLL_US 5000
> > @@ -536,6 +538,7 @@ static int ena_com_comp_status_to_errno(struct ena_com_admin_queue *admin_queue,
> >
> >  static void ena_delay_exponential_backoff_us(u32 exp, u32 delay_us)
> >  {
> > +	exp = min_t(u32, exp, ENA_MAX_BACKOFF_DELAY_EXP);

This shouldn't need to be a min_t()

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

