Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4430778C053
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjH2Ico convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Aug 2023 04:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjH2IcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:32:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDC8A3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:32:09 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-159-gZBynCznM8iIH1jW_lZGuw-1; Tue, 29 Aug 2023 09:32:06 +0100
X-MC-Unique: gZBynCznM8iIH1jW_lZGuw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 29 Aug
 2023 09:32:09 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 29 Aug 2023 09:32:09 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Heiko Carstens' <hca@linux.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        =?iso-8859-1?Q?Jan_H=F6ppner?= <hoeppner@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH 1/1] s390/dasd: fix string length handling
Thread-Topic: [PATCH 1/1] s390/dasd: fix string length handling
Thread-Index: AQHZ2cWnhKdW55JwuUOen/9fPqAWJK//8duQgAD1MkKAAAt+0A==
Date:   Tue, 29 Aug 2023 08:32:09 +0000
Message-ID: <51f70b0ad37f469a93242db9cfc6d9e8@AcuMS.aculab.com>
References: <20230828153142.2843753-1-hca@linux.ibm.com>
 <20230828153142.2843753-2-hca@linux.ibm.com>
 <f0419f6428ad404386ebca813dc1ec03@AcuMS.aculab.com>
 <ZO0k1Par4i4FBCWF@google.com> <20230829074854.7031-A-hca@linux.ibm.com>
In-Reply-To: <20230829074854.7031-A-hca@linux.ibm.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens
> Sent: 29 August 2023 08:49
> 
> On Mon, Aug 28, 2023 at 03:51:00PM -0700, Nick Desaulniers wrote:
> > On Mon, Aug 28, 2023 at 05:18:37PM +0000, David Laight wrote:
> > > From: Heiko Carstens
> > > > Sent: 28 August 2023 16:32
> > > >  	if (strlen(uid.vduit) > 0)
> > >
> > > Does the compiler know enough to optimise that brain-dead test?
> > >
> >
> > For the purposes of skipping diagnostics, no; clang performs semantic
> > analysis BEFORE optimization (which is handled by LLVM). As such, clang
> > will produce diagnostics on dead code.
> >
> > Partly because LLVM isn't very ergonomic at emitting diagnostics from
> > the backend, partly because Clang code owner and developers don't want
> > clang to emit diagnostics dependent on optimization level.
> >
> > I disagree with my compatriots, and you can read more thoughts here:
> > https://discourse.llvm.org/t/rfc-improving-clangs-middle-and-back-end-
> diagnostics/69261?u=nickdesaulniers
> 
> Maybe I misunderstand what you write above, however clang (latest+greatest)
> does indeed optimize the strlen() away and generates code which only tests
> if uid.vduit[0] is zero or not.
> 
> Unlike gcc, which does not optimize this away and which uses the strlen()
> inline assembly provided via string.h...

And, if -ffreestanding is set (as in some kernel builds), the compiler
can't assume what strlen() does.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

