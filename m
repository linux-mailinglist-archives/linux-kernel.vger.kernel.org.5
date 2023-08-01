Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67AD76AB46
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjHAIpS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Aug 2023 04:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjHAIpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:45:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DEC10E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:45:15 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-202-eBnQEioCP9Cm7QIsQJ1Wuw-1; Tue, 01 Aug 2023 09:45:12 +0100
X-MC-Unique: eBnQEioCP9Cm7QIsQJ1Wuw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 1 Aug
 2023 09:45:10 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 1 Aug 2023 09:45:10 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'kernel test robot' <lkp@intel.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "Linux Memory Management List" <linux-mm@kvack.org>
Subject: RE: [PATCH next v2 2/5] minmax: Allow min()/max()/clamp() if the
 arguments have the same signedness.
Thread-Topic: [PATCH next v2 2/5] minmax: Allow min()/max()/clamp() if the
 arguments have the same signedness.
Thread-Index: AdnBYvtzc0TxoNEXQSCZpxDmi1SwuQCjLWkAABi9BYA=
Date:   Tue, 1 Aug 2023 08:45:10 +0000
Message-ID: <a576676d66284659bc91afe93d2b0159@AcuMS.aculab.com>
References: <bf92800b0c5445e2b2ca8c88e1f5e90f@AcuMS.aculab.com>
 <202308010559.SEtfkzQU-lkp@intel.com>
In-Reply-To: <202308010559.SEtfkzQU-lkp@intel.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kernel test robot
> Sent: 31 July 2023 22:44
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on linus/master crng-random/master v6.5-rc4 next-20230731]
> [cannot apply to next-20230728]
...
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git
> f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce: (https://download.01.org/0day-ci/archive/20230801/202308010559.SEtfkzQU-
> lkp@intel.com/reproduce)
> 
....
> >> drivers/gpu/drm/drm_modes.c:2474:15: error: static_assert expression is not an integral constant
> expression
>                    extra_ptr = max(bpp_end_ptr, refresh_end_ptr);
>                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is really a bug in clang - fixed in 16.0.0.
In C (but probably not C++) '(void *)1' should be a compile-time constant.
Will be fixed in v3 of the patch.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

