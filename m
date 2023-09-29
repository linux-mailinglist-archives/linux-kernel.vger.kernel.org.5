Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3467B3C00
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjI2VgO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Sep 2023 17:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2VgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:36:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2861AB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:36:11 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-95-t2b_ZynWOe24ksn49Kg4FA-1; Fri, 29 Sep 2023 22:36:08 +0100
X-MC-Unique: t2b_ZynWOe24ksn49Kg4FA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 29 Sep
 2023 22:36:06 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 29 Sep 2023 22:36:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>,
        Matthew Maurer <mmaurer@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>
CC:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        "Alice Ryhl" <aliceryhl@google.com>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rust: Use awk instead of recent xargs
Thread-Topic: [PATCH] rust: Use awk instead of recent xargs
Thread-Index: AQHZ8kr/VXhkUs4M10WbSSTh7+OPhLAyVEjw
Date:   Fri, 29 Sep 2023 21:36:06 +0000
Message-ID: <be10d55a785d4d9b983b2dae6ed65942@AcuMS.aculab.com>
References: <20230928202116.2298150-1-mmaurer@google.com>
 <106c8bdb960da1568d0b3879efa76cd2acec032e.camel@perches.com>
In-Reply-To: <106c8bdb960da1568d0b3879efa76cd2acec032e.camel@perches.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches
> Sent: 28 September 2023 21:33
> 
> On Thu, 2023-09-28 at 20:21 +0000, Matthew Maurer wrote:
> > `awk` is already required by the kernel build, and the `xargs` feature
> > used in current Rust detection is not present in all `xargs` (notably,
> > toybox based xargs, used in the Android kernel build).
> []
> > diff --git a/rust/Makefile b/rust/Makefile
> []
> > @@ -365,8 +365,7 @@ quiet_cmd_exports = EXPORTS $@
> >        cmd_exports = \
> >  	$(NM) -p --defined-only $< \
> >  		| grep -E ' (T|R|D) ' | cut -d ' ' -f 3 \
> > -		| xargs -Isymbol \
> > -		echo 'EXPORT_SYMBOL_RUST_GPL(symbol);' > $@
> > +		| awk 'NF {printf "EXPORT_SYMBOL_RUST_GPL(%s);\n",$$0}' > $@
> 
> Perhaps remove the cut as well and use $$3 instead of $$0 ?
> Maybe integrate the grep as well.

Or keep the grep and use a shell loop?
	grep -E ' (T|R|D) ' | while read val flag symbol; do \
		echo "EXPORT_SYMBOL_RUST_GPL($symbol);"; done

(The grep is typically much faster than a shell conditional.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

