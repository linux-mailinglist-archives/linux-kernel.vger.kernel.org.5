Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAD17E7497
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjKIWzs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Nov 2023 17:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKIWzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:55:46 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C4E4228
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 14:55:43 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-108-sFXzATMuP2KFfcPbdzzZPw-1; Thu, 09 Nov 2023 22:55:39 +0000
X-MC-Unique: sFXzATMuP2KFfcPbdzzZPw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 9 Nov
 2023 22:55:39 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 9 Nov 2023 22:55:39 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Imre Deak <imre.deak@intel.com>
Subject: Build fail in drivers/gpu/drm/i915/display/intel_tc.c
Thread-Topic: Build fail in drivers/gpu/drm/i915/display/intel_tc.c
Thread-Index: AdoTX9s2sPRYSwRmSkOwOZ8JicXQjg==
Date:   Thu, 9 Nov 2023 22:55:38 +0000
Message-ID: <4df68c74c4da46ac943ac21578e9b084@AcuMS.aculab.com>
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

I'm seeing a build fail at line 1878 of intel_tc.c

gcc is being a bit over-enthusiastic about snprintf() formats
and reports that "%c/TC#%d", xxx, tc_port + 1 might not fit
in the 8 bytes available.
'tc_port' is an enum with values -1 to 5.
I guess it is either allowing for the full 'int' value of
the enum.
Changing to '(tc_port & 7) + 1' stops the compiler bleating.

The code isn't new, so I guess the compiler flags have changed?

It might depend on the gcc version as well.
I'm using gcc 7.5.0 from Ubuntu 18.04.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

