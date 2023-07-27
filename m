Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EC5765582
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjG0OB5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Jul 2023 10:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjG0OBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:01:54 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE1130C0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:01:52 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-228-MA1g0RDwNJKsqFhPGNhzQA-1; Thu, 27 Jul 2023 15:01:49 +0100
X-MC-Unique: MA1g0RDwNJKsqFhPGNhzQA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 27 Jul
 2023 15:01:48 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 27 Jul 2023 15:01:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
CC:     'kernel test robot' <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "Linux Memory Management List" <linux-mm@kvack.org>
Subject: RE: [PATCH next 2/5] minmax: Allow min()/max()/clamp() if the
 arguments have the same signedness.
Thread-Topic: [PATCH next 2/5] minmax: Allow min()/max()/clamp() if the
 arguments have the same signedness.
Thread-Index: Adm+2wKUQ5yQ6t/FR+W/hRy2DuErJQALXH0AACSnwSAADmS3gAAu/pPA
Date:   Thu, 27 Jul 2023 14:01:48 +0000
Message-ID: <c7e4b886eae04d3f9ea50be0685839e9@AcuMS.aculab.com>
References: <454f967d452548a9acfa7c0a0872507e@AcuMS.aculab.com>
 <202307252359.Is4T2MXC-lkp@intel.com>
 <350c7fe495424138afd15d797830c417@AcuMS.aculab.com>
 <ZMFHs4MV6vUhwn7r@smile.fi.intel.com>
In-Reply-To: <ZMFHs4MV6vUhwn7r@smile.fi.intel.com>
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

From: 'Andy Shevchenko'
> Sent: 26 July 2023 17:20
> 
> On Wed, Jul 26, 2023 at 08:30:59AM +0000, David Laight wrote:
> > From: kernel test robot
> > > Sent: 25 July 2023 16:58
> > >
> > > kernel test robot noticed the following build errors:
> 
> ...
> 
> > >    In file included from init/calibrate.c:8:
> > > >> include/linux/jiffies.h:427:28: error: call to undeclared function 'static_assert'; ISO C99 and
> > > later do not support implicit function declarations [-Wimplicit-function-declaration]
> > >      427 |         return jiffies_to_clock_t(max(0L, delta));
> > >          |                                   ^
> > ...
> > >    include/linux/minmax.h:29:3: note: expanded from macro '__cmp_once'
> > >       29 |                 static_assert(__types_ok(x, y),         \
> >
> > This is fixed by the earlier patch:
> > [PATCH v1 1/1] minmax: Fix header inclusions
> >
> > which adds #include <linux/build_bug.h> and thus defines static_assert().
> >
> > Can I just assume that will be applied?
> 
> You can test that and reply there with your Tested-by there, it will help it
> to be applied.

I can check it doesn't break my x86-64 build.

I think the build error was on a 'um' build - not really obvious
in the report.

I suspect everything else gets build_bug.h included from a very
common header file.

On x86-64 (5.10.xxx) by forcing an error I get:
  CC      init/calibrate.o
In file included from linux/include/linux/bits.h:22,
                 from linux/include/linux/bitops.h:5,
                 from linux/include/linux/kernel.h:12,
                 from linux/arch/x86/include/asm/percpu.h:27,
                 from linux/arch/x86/include/asm/current.h:6,
                 from linux/arch/x86/include/asm/processor.h:17,
                 from linux/arch/x86/include/asm/timex.h:5,
                 from linux/include/linux/timex.h:67,
                 from linux/include/linux/time32.h:13,
                 from linux/include/linux/time.h:73,
                 from linux/include/linux/jiffies.h:10,
                 from linux/init/calibrate.c:9:
linux/include/linux/build_bug.h: ...

I can't help feeling some of that chain isn't needed :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

