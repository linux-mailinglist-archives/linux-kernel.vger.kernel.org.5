Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E837619B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjGYNUd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 09:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjGYNU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:20:29 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F661BC2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:20:05 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-3-QArLaFZZPIyQRdYbCeCJSQ-1; Tue, 25 Jul 2023 14:20:02 +0100
X-MC-Unique: QArLaFZZPIyQRdYbCeCJSQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 25 Jul
 2023 14:20:01 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 25 Jul 2023 14:20:01 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthew Wilcox' <willy@infradead.org>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
Subject: RE: [PATCH next resend 1/5] minmax: Add min_unsigned(a, b) and
 max_unsigned(a, b)
Thread-Topic: [PATCH next resend 1/5] minmax: Add min_unsigned(a, b) and
 max_unsigned(a, b)
Thread-Index: Adm+7eUTa4I5Whq+QJmE/BdQ09ksJP///VUA///lOfA=
Date:   Tue, 25 Jul 2023 13:20:01 +0000
Message-ID: <66e58cd2cffa462a979ac5415874a570@AcuMS.aculab.com>
References: <caa84582f9414de895ac6c4fe2b53489@AcuMS.aculab.com>
 <62d82a41b94c475bacceb0f6b11583a1@AcuMS.aculab.com>
 <ZL/CUuIhi6qmTK5+@casper.infradead.org>
In-Reply-To: <ZL/CUuIhi6qmTK5+@casper.infradead.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox
> Sent: 25 July 2023 13:39
> 
> On Tue, Jul 25, 2023 at 11:48:14AM +0000, David Laight wrote:
> > +#define min_unsigned(x, y)	\
> > +	__careful_cmp((x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull, <)
> 
> What is the point of "+ 0u + 0ul + 0ull"?  How is that any different
> from "+ 0ull"?  And why force the compiler to do a 64-bit comparison
> when it could do a 32-bit comparison?

The "+ 0u + 0ul + 0ull" causes a signed 32bit value to be zero extended
to 64bit. This is significantly cheaper than the sign extension.
(Adding 0ull first converts a signed 32bit value to a signed
64bit one - the same as a cast.)

The compiler also then knows that the high 32bit are zero and
optimises away any associated compares.
So you get a 32bit compare (on both 32bit and 64bit) if both
arguments are 32bit.
This happens even at -O0.

It also has no effect on pointer types.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

