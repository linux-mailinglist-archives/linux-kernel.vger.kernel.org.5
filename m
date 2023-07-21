Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF9E75C8C6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjGUN7U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Jul 2023 09:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjGUN7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:59:07 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7094A3A84
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:58:56 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-27-tUZJkKfjPuSYNBamH4xjCA-1; Fri, 21 Jul 2023 14:58:54 +0100
X-MC-Unique: tUZJkKfjPuSYNBamH4xjCA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 21 Jul
 2023 14:58:53 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 21 Jul 2023 14:58:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: RE: [PATCH v1 1/1] ALSA: korg1212: Re-use sockptr_t and respective
 APIs
Thread-Topic: [PATCH v1 1/1] ALSA: korg1212: Re-use sockptr_t and respective
 APIs
Thread-Index: AQHZu8ALiLW3NE9rpEyBJunRSGnWfK/EPjVA
Date:   Fri, 21 Jul 2023 13:58:52 +0000
Message-ID: <b8e6f7ae1e684f85902cb3a787436bd9@AcuMS.aculab.com>
References: <20230721100146.67293-1-andriy.shevchenko@linux.intel.com>
 <878rb9h901.wl-tiwai@suse.de> <ZLphAJG4Tz8zLUSN@smile.fi.intel.com>
In-Reply-To: <ZLphAJG4Tz8zLUSN@smile.fi.intel.com>
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
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko
> Sent: 21 July 2023 11:42
> 
> On Fri, Jul 21, 2023 at 12:08:46PM +0200, Takashi Iwai wrote:
> > On Fri, 21 Jul 2023 12:01:46 +0200,
> > Andy Shevchenko wrote:
> > >
> > > The sockptr_t (despite the naming) is a generic type to hold kernel
> > > or user pointer and there are respective APIs to copy data to or
> > > from it. Replace open coded variants in the driver by them.
> >
> > While I see the benefit, I feel this is very confusing.  If we use the
> > API for a generic use, it should be renamed at first.
> >
> > Also, the current function actually follows the call pattern, and we
> > know in the caller side whether it's called for a kernel pointer or a
> > user pointer.  So, if any, the PCM core callbacks should be revised to
> > use a generic pointer instead of fiddling in each driver side.
> 
> Any suggestion for the name?
> And I believe for the bigger series the new callback should be added first.

It would also be better to replace the current sockptr_t with
a structure that contains separate user and kernel addresses
(instead of a union of the pointer types and a flag).

The size of the structure wouldn't change and the code might
even come out better.

There is also scope for adding a length and passing the structure
by reference instead of by value.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

