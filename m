Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD90B77BD5A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjHNPqL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Aug 2023 11:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjHNPpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:45:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41EF10E4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:45:37 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-264-4VDMbRvdM6CccUdMezF-iA-1; Mon, 14 Aug 2023 16:45:35 +0100
X-MC-Unique: 4VDMbRvdM6CccUdMezF-iA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 14 Aug
 2023 16:45:22 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 14 Aug 2023 16:45:22 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
CC:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Andrew.Cooper3@citrix.com" <Andrew.Cooper3@citrix.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [RFC][PATCH 06/17] x86/cpu: Add SRSO untrain to retbleed=
Thread-Topic: [RFC][PATCH 06/17] x86/cpu: Add SRSO untrain to retbleed=
Thread-Index: AQHZzRDK8HwTTXk3aUC67vPYTNvPsK/p8R2g
Date:   Mon, 14 Aug 2023 15:45:22 +0000
Message-ID: <dc56b3592f9e41c29609ec5e7eb4ffa4@AcuMS.aculab.com>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.850338672@infradead.org>
 <20230810154404.GOZNUFxHxLIMth6j9s@fat_crate.local>
 <20230810161003.i65d37ozlt3d5xse@treble>
 <20230811102748.GEZNYNJEeDxTqcOLvj@fat_crate.local>
 <20230812113256.GC749618@hirez.programming.kicks-ass.net>
In-Reply-To: <20230812113256.GC749618@hirez.programming.kicks-ass.net>
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

From: Peter Zijlstra
> Sent: 12 August 2023 12:33
> 
> On Fri, Aug 11, 2023 at 12:27:48PM +0200, Borislav Petkov wrote:
> > On Thu, Aug 10, 2023 at 12:10:03PM -0400, Josh Poimboeuf wrote:
> > > I tend to agree that SRSO is a new issue and should have its own sysfs
> > > and cmdline options (though a separate CONFIG option is overkill IMO).
> >
> > Yeah, there's a patch floating around adding a config option for every
> > mitigation. Apparently people want to build-time disable them all.
> 
> So I really hate that .Kconfig explosion, that's the very last thing we
> need :-( More random options that can cause build time trouble.
> 
> I might see value in one knob that kills all speculation nonsense at
> build time, but not one per mitigation, that's maddness.

Or a very limited number of options for things that are
pretty separate.
Maybe the call/indirect jump are separate enough from the
return ones?

An one big KNOB to disable them all (DEPEND_ON !NO_MIGIGATIONS ?).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

