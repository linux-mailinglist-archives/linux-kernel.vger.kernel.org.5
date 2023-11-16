Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902F77EDFF4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345115AbjKPLiM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Nov 2023 06:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjKPLiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:38:10 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC2B85
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:38:06 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-56-nB6YrNm6ObaH_dAU9qjzxw-1; Thu, 16 Nov 2023 11:38:04 +0000
X-MC-Unique: nB6YrNm6ObaH_dAU9qjzxw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 16 Nov
 2023 11:38:08 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 16 Nov 2023 11:38:08 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Howells' <dhowells@redhat.com>
CC:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        kernel test robot <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>
Subject: RE: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
Thread-Topic: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
Thread-Index: AQHaF/9mUr/d/cPMC0WC86r1pNT+UrB8tOywgAAGVICAAAkJMA==
Date:   Thu, 16 Nov 2023 11:38:08 +0000
Message-ID: <cde76a2d8ed54885a77771894ecd3e99@AcuMS.aculab.com>
References: <4c0c3ee6cfa84d21a807055bc1aa27b8@AcuMS.aculab.com>
 <202311061616.cd495695-oliver.sang@intel.com>
 <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local>
 <CAHk-=whFW+uWOmOtRNh0What_fu8Xo8KF2+EeUH1kn4qFxGAhA@mail.gmail.com>
 <CAHk-=whrc-ruKs4Kt90EGzKd+pYhZFKs6bgBVCV=55BK+p1nzg@mail.gmail.com>
 <97468.1700129643@warthog.procyon.org.uk>
In-Reply-To: <97468.1700129643@warthog.procyon.org.uk>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells
> Sent: 16 November 2023 10:14
> 
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > On haswell (which is now quite old) both 'rep movsb' and
> > 'rep movsq' copy 16 bytes/clock unless the destination
> > is 32 byte aligned when they copy 32 bytes/clock.
> > Source alignment make no different, neither does byte
> > alignment.
> 
> I think the i3-4170 cpu I'm using is Haswell.  Does that mean for my
> particular cpu, just using inline "rep movsb" is the best choice?

I've just looked at a slight old copy of the instruction timing
doc from https://www.agner.org/optimize

Apart from P4 (130 clock setup!) the setup cost for 'rep movs'
is relatively small.
I think everything since sandy bridge and bulldozer (except atoms,
but including silvermont) do fast copies for 'rep movsb'.
(But the C2758 atom we use claims erms.)

I'd bet that the overhead for using 'rep movsb' for a short copy
is less than that of the mispredicted branch (or two) to select
the required code.

That rather implies always using 'rep movsb' is best unless
someone is compiling explicitly for an old cpu.
And apart from P4 an explicit 'rep movsl' will be fastest then
because the setup cost is minimal/zero.

The cutoff for using 'rep movsb' for constant sized copies
is probably also a lot less than you might expect.
Especially assuming cold cache.

This all makes that POS that gcc is inlining even more stupid.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

