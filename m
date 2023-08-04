Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE71770423
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjHDPMD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Aug 2023 11:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjHDPL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:11:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4602949F2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:11:53 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-69--ezDvafoOoC2ioaAAB2V4A-1; Fri, 04 Aug 2023 16:11:51 +0100
X-MC-Unique: -ezDvafoOoC2ioaAAB2V4A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 4 Aug
 2023 16:11:49 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 4 Aug 2023 16:11:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Paul Moore' <paul@paul-moore.com>,
        =?iso-8859-1?Q?Christian_G=F6ttsche?= <cgzones@googlemail.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
CC:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/9] selinux: use u32 as bit type in ebitmap code
Thread-Topic: [PATCH v2 2/9] selinux: use u32 as bit type in ebitmap code
Thread-Index: AQHZxno7WAML9teEJUiVyNIDpo4Zsa/aOz6A
Date:   Fri, 4 Aug 2023 15:11:49 +0000
Message-ID: <52329f0195a549d1b7abb3417cb2c225@AcuMS.aculab.com>
References: <20230728155501.39632-1-cgzones@googlemail.com>
 <c8f7b16afb26b2357fdc2b590a8cdcba.paul@paul-moore.com>
In-Reply-To: <c8f7b16afb26b2357fdc2b590a8cdcba.paul@paul-moore.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Moore
> Sent: 04 August 2023 03:20
> 
> On Jul 28, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
....
> > +	last_startbit = (u32)-1;
> 
> I can't say I'm as current on all of the C standards and compilier
> oddities as some other in the Linux kernel space, but my
> understanding is that on assignment the right value is always
> implicitly type cast to the type of the left variable, is that not
> true?  Assuming it is true, I think this explicit cast isn't
> necessary and could actually be harmful if we need to change the
> ebitmap types in the future.

The only question is where any required sign extend happens.
If you do:
	u64 val = -1;
then the signed int is first sign extended to 64 bit and then
converted to unsigned (which just copies the bit pattern on any
sane system that Linux might run on).
Whereas:
	u64 val = (u32)-1;
Converts an (assumed) 32bit -1 to unsigned and then zero extends it.

What you should really be using is a named constant that is
(for the current implementation) (~0u) and doesn't ever need
any casts and is always unsigned.

If you are actually worried about 'int' being other than 32bits
then there will be a lot more places that need fixing.

But you could use ((u32)~(u32)0) if you really want to allow
for 'u32' being both smaller and larger than 'int' and for
non 2's compliment (eg 1's compliment and sign overpunch)
systems.
(Good luck on finding a working C compiler for either of those.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

