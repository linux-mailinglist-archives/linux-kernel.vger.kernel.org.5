Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B147EBF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbjKOJ0T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Nov 2023 04:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbjKOJ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:26:18 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E550FFE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:26:13 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-159-wXE6x5jdOEGZiCEH3TuXeA-1; Wed, 15 Nov 2023 09:26:11 +0000
X-MC-Unique: wXE6x5jdOEGZiCEH3TuXeA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 15 Nov
 2023 09:26:10 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 15 Nov 2023 09:26:10 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'imre.deak@intel.com'" <imre.deak@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Build fail in drivers/gpu/drm/i915/display/intel_tc.c
Thread-Topic: Build fail in drivers/gpu/drm/i915/display/intel_tc.c
Thread-Index: AdoTX9s2sPRYSwRmSkOwOZ8JicXQjgAEEIUiABCaxIAA3tRGgAAdyf/A
Date:   Wed, 15 Nov 2023 09:26:10 +0000
Message-ID: <cc36c3c2f0324ffbab4df089a6cc2621@AcuMS.aculab.com>
References: <4df68c74c4da46ac943ac21578e9b084@AcuMS.aculab.com>
 <ZU1shQH64ryxp/l5@ideak-desk.fi.intel.com>
 <CAHk-=wgiPxF6GnvaSGV+xOjcBO-T1vxLYhSvho0Q5Cdqw7t74w@mail.gmail.com>
 <39709b4bb3e447159759a9923bd4a564@AcuMS.aculab.com>
 <ZVPFUdc6Q/qCI8M7@ideak-desk.fi.intel.com>
In-Reply-To: <ZVPFUdc6Q/qCI8M7@ideak-desk.fi.intel.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Imre Deak
> Sent: 14 November 2023 19:08
> 
> On Fri, Nov 10, 2023 at 09:00:21AM +0000, David Laight wrote:
> > From: Linus Torvalds
> > > Sent: 10 November 2023 00:52
> > >
> > > On Thu, 9 Nov 2023 at 15:34, Imre Deak <imre.deak@intel.com> wrote:
> > > >
> > > > The compiler warn should be fixed/suppressed by:
> > > > https://lore.kernel.org/all/20231026125636.5080-1-nirmoy.das@intel.com
> > >
> > > Ugh, so now it's a dynamic allocation, wasting memory, and a pointer
> > > to it, using as much memory as the array did in the first place.
> > >
> > > All because of a pointless warning that was a false positive - and was
> > > always harmless anyway, since snprintf() is safe (ie it was only a
> > > "might be truncated").
> >
> > That entire warning for snprintf() is a false positive.
> > The ones that are likely to overflow unexpectedly are the ones
> > with a "%s" format for a 'char *' pointer where there is no
> > implied length.
> >
> > The same check for printf() using the implied buffer length
> > probably does make sense.
> >
> > I don't even think there is a way of avoiding it on a case by case
> > basis - apart from passing both the buffer address and length
> > to an inline asm that the compiler has to assume might change
> > the values, but that tends to generate an extra 'mov' instruction
> > for no good reason at all.
> >
> > >
> > > Please don't do this. Either do that ((tc_port & 7) + 1) suggestion of
> > > David's, or just do '%c' and make the expression be
> > >
> > >   '1' + tc_port
> > >
> > > which should be fine since I915_MAX_PORTS is 8 or whatever.
> 
> Ok, the patch above was merged already to drm-tip,

I'd noticed ....

> but I agree not to use kasprintf for this.
> The above looks ok and there is already
> tc_port_name() for this, would just need to export that from
> intel_display.h.

I'm not sure that #define does anything except obscure what
is going on.
Anyone reading the code is going to search for it and then sigh.
But it is your code :-)

> I can follow up with a patch for this, or if you or David wanted to do
> that please send a patch to the intel-gfx@lists.freedesktop.org list.

Probably much easier for you to do it.
My process to get patches emailed is a PITA.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

