Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39492793F11
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241755AbjIFOjB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Sep 2023 10:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240731AbjIFOjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:39:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3609910C8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 07:38:56 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-51-JU8GsIpzNuGR6R61Nji-YA-1; Wed, 06 Sep 2023 15:38:53 +0100
X-MC-Unique: JU8GsIpzNuGR6R61Nji-YA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 6 Sep
 2023 15:38:49 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 6 Sep 2023 15:38:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Noah Goldstein' <goldstein.w.n@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: x86/csum: Remove unnecessary odd handling
Thread-Topic: x86/csum: Remove unnecessary odd handling
Thread-Index: AQHZ3SKcfs4a8+P0bkWBCjHsrqR0abAN4sGg
Date:   Wed, 6 Sep 2023 14:38:49 +0000
Message-ID: <d4c6e6274bd14391a1e59f84f9ebce7a@AcuMS.aculab.com>
References: <20230628020657.957880-1-goldstein.w.n@gmail.com>
 <20230901222100.1027371-1-goldstein.w.n@gmail.com>
In-Reply-To: <20230901222100.1027371-1-goldstein.w.n@gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Noah Goldstein
> Sent: 01 September 2023 23:21
...
> +	return add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);

The generic C alternative:
	return (temp64 + ror64(temp64, 32)) >> 32;
is the same number of instructions but might get
better scheduling.

The C version of csum_fold() from arc/include/asm/checksum.h
is also better than the x86 asm version.
(And also pretty much all the other architecture dependant
copies.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

