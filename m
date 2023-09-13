Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D1279E285
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbjIMIsA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 04:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237278AbjIMIr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:47:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AAF91993
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:47:55 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-266-m12S0s3ZOouc56uUjgkHeA-1; Wed, 13 Sep 2023 09:47:52 +0100
X-MC-Unique: m12S0s3ZOouc56uUjgkHeA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 13 Sep
 2023 09:47:49 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 13 Sep 2023 09:47:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Charlie Jenkins' <charlie@rivosinc.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: RE: [PATCH v4 2/5] riscv: Add checksum library
Thread-Topic: [PATCH v4 2/5] riscv: Add checksum library
Thread-Index: AQHZ5QNmAqaxDkDqBUuW+t+6iXe0brAW2+/wgAEox4CAAGmkUA==
Date:   Wed, 13 Sep 2023 08:47:49 +0000
Message-ID: <b503e341f2334d6b9b902a6e621ed7c3@AcuMS.aculab.com>
References: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
 <20230911-optimize_checksum-v4-2-77cc2ad9e9d7@rivosinc.com>
 <1818c4114b0e4144a9df21f235984840@AcuMS.aculab.com> <ZQEn+8Bi8dxNgg3g@ghost>
In-Reply-To: <ZQEn+8Bi8dxNgg3g@ghost>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charlie Jenkins
> Sent: 13 September 2023 04:10
> 
> On Tue, Sep 12, 2023 at 08:45:38AM +0000, David Laight wrote:
> > From: Charlie Jenkins
> > > Sent: 11 September 2023 23:57
> > >
> > > Provide a 32 and 64 bit version of do_csum. When compiled for 32-bit
> > > will load from the buffer in groups of 32 bits, and when compiled for
> > > 64-bit will load in groups of 64 bits. Benchmarking by proxy compiling
> > > csum_ipv6_magic (64-bit version) for an x86 chip as well as running
> > > the riscv generated code in QEMU, discovered that summing in a
> > > tree-like structure is about 4% faster than doing 64-bit reads.
> > >
> > ...
> > > +	sum   = saddr->s6_addr32[0];
> > > +	sum  += saddr->s6_addr32[1];
> > > +	sum1  = saddr->s6_addr32[2];
> > > +	sum1 += saddr->s6_addr32[3];
> > > +
> > > +	sum2  = daddr->s6_addr32[0];
> > > +	sum2 += daddr->s6_addr32[1];
> > > +	sum3  = daddr->s6_addr32[2];
> > > +	sum3 += daddr->s6_addr32[3];
> > > +
> > > +	sum4  = csum;
> > > +	sum4 += ulen;
> > > +	sum4 += uproto;
> > > +
> > > +	sum  += sum1;
> > > +	sum2 += sum3;
> > > +
> > > +	sum += sum2;
> > > +	sum += sum4;
> >
> > Have you got gcc to compile that as-is?
> >
> > Whenever I've tried to get a 'tree add' compiled so that the
> > early adds can be executed in parallel gcc always pessimises
> > it to a linear sequence of adds.
> >
> > But I agree that adding 32bit values to a 64bit register
> > may be no slower than trying to do an 'add carry' sequence
> > that is guaranteed to only do one add/clock.
> > (And on Intel cpu from core-2 until IIRC Haswell adc took 2 clocks!)
> >
> > IIRC RISCV doesn't have a carry flag, so the adc sequence
> > is hard - probably takes two extra instructions per value.
> > Although with parallel execute it may not matter.
> > Consider:
> > 	val = buf[offset];
> > 	sum += val;
> > 	carry += sum < val;
> > 	val = buf[offset1];
> > 	sum += val;
> > 	...
> > the compare and 'carry +=' can be executed at the same time
> > as the following two instructions.
> > You do then a final sum += carry; sum += sum < carry;
> >
> > Assuming all instructions are 1 clock and any read delays
> > get filled with other instructions (by source or hardware
> > instruction re-ordering) even without parallel execute
> > that is 4 clocks for 64 bits, which is much the same as the
> > 2 clocks for 32 bits.
> >
> > Remember that all the 32bit values can summed first as
> > they won't overflow.
> >
> > 	David

> Yeah it does seem like the tree-add does just do a linear add. All three
> of them were pretty much the same on riscv so I used the version that
> did best on x86 with the knowledge that my QEMU setup does not
> accurately represent real hardware.

The problem there is that any measurement on x86 has pretty much
no relevance to what any RISCV cpu might do.
The multiple execution units and out of order execution on x86
are far different from anything any RISCV cpu is likely to have
for many years.
You might get nearer running on one of the Atom cpu - but it won't
really match.
There are too many fundamental differences between the architectures.

All you can do is to find and read the instruction timings for
a target physical cpu and look for things like:
- Whether arithmetic results are available next clock.
  (It probably is)
- How many clocks it takes for read data to be available.
  I suspect the cpu will stall if the data is needed.
  A block of sequential reads is one way to avoid the stall.
  On x86 the instruction that needs the data is just deferred
  until it is available, the following instructions execute
  (provided their input are all available).
- Clock delays for taken/not taken predicted/not predicted branches.
  
> I don't quite understand how doing the carry in the middle of each
> stage, even though it can be executed at the same time, would be faster
> than just doing a single overflow check at the end.

You need to do half as many reads and adds.

> I can just revert
> back to the non-tree add version since there is no improvement on riscv.

The 'tree' version is only likely to be faster on cpu (like x86)
that can (at least sometimes) do two memory reads in one clock
and can do two adds and two read in the same clock.
Even then, without out of order execution, it is hard to get right.

Oh, you might want to try getting the default csum_fold() to
be the faster 'arc' version rather than adding your own version.

	David

> I can also revert back to the default version that uses carry += sum < val
> as well.
> 
> - Charlie

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

