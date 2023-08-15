Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D72C77CB9B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbjHOLUY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Aug 2023 07:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbjHOLUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:20:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527B8FE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:19:55 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-233-kVB3OncmNJKG28V9ejQR5Q-1; Tue, 15 Aug 2023 12:19:52 +0100
X-MC-Unique: kVB3OncmNJKG28V9ejQR5Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 15 Aug
 2023 12:19:50 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 15 Aug 2023 12:19:50 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'minyard@acm.org'" <minyard@acm.org>,
        Justin Stitt <justinstitt@google.com>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] ipmi_si: fix -Wvoid-pointer-to-enum-cast warning
Thread-Topic: [PATCH] ipmi_si: fix -Wvoid-pointer-to-enum-cast warning
Thread-Index: AQHZzJJNhRgyMCyjXUCyrlg7Yy+IN6/rOtTw
Date:   Tue, 15 Aug 2023 11:19:50 +0000
Message-ID: <85c5e4b69dbb4ff699f380b373f6440f@AcuMS.aculab.com>
References: <20230809-cbl-1902-v1-1-92def12d1dea@google.com>
 <ZNaZrHEs5FP7Lf8A@mail.minyard.net>
In-Reply-To: <ZNaZrHEs5FP7Lf8A@mail.minyard.net>
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

From: Corey Minyard
> Sent: 11 August 2023 21:27
...
> >  	memset(&io, 0, sizeof(io));
> > -	io.si_type	= (enum si_type) match->data;
> > +	io.si_type	= (unsigned long) match->data;
> 
> Wouldn't you want to use intptr_t or uintptr_t?

The kernel tends to use 'long' for the same reason
it doesn't use uint8_t.

Although I'm sure the correct/better fix is to either add variants
of the match/lookup functions that return (say) unsigned long
or change all the drivers to allocate a structure that contains
the required value.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

