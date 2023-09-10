Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E90879A012
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 23:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjIJVUz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 10 Sep 2023 17:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjIJVUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 17:20:54 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3916188
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 14:20:49 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-146-jIjh0yxkNzCFrfh3QFoU7A-1; Sun, 10 Sep 2023 22:20:42 +0100
X-MC-Unique: jIjh0yxkNzCFrfh3QFoU7A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 10 Sep
 2023 22:20:33 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 10 Sep 2023 22:20:33 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Charlie Jenkins' <charlie@rivosinc.com>,
        Conor Dooley <conor@kernel.org>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: RE: [PATCH v2 1/5] riscv: Checksum header
Thread-Topic: [PATCH v2 1/5] riscv: Checksum header
Thread-Index: AQHZ4bMJWeMEu2xwd0uaIDwvnyVCgbAUlGVw
Date:   Sun, 10 Sep 2023 21:20:33 +0000
Message-ID: <cec0f23506a54b9aaaef054ea949e4aa@AcuMS.aculab.com>
References: <20230905-optimize_checksum-v2-0-ccd658db743b@rivosinc.com>
 <20230905-optimize_checksum-v2-1-ccd658db743b@rivosinc.com>
 <20230907-f8c8993dbeb24d5ea5310ec7@fedora> <ZPoMAGYlIxPZsE7+@ghost>
In-Reply-To: <ZPoMAGYlIxPZsE7+@ghost>
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

...
> > > +/*
> > > + *	Fold a partial checksum without adding pseudo headers
> > > + */
> > > +static inline __sum16 csum_fold(__wsum sum)
> > > +{
> > > +	sum += (sum >> 16) | (sum << 16);
> > > +	return (__force __sum16)(~(sum >> 16));
> > > +}

I'm intrigued, gcc normally compiler that quite well.
The very similar (from arch/arc):
	return (~sum - rol32(sum, 16)) >> 16;
is slightly better on most architectures.
(Especially if the ~sum and rol() can be executed together.)

The only odd archs I saw were sparc32 (carry flag bug no rotate)
and arm (barrel shifter on all instructions).

It is better than the current asm for a lot of archs including x64.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

