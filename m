Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DED7FF2EE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346070AbjK3OwM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Nov 2023 09:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjK3OwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:52:11 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F94F133
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:52:17 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-167-ehzvvOoBOZGyvf_gdvKpVw-1; Thu, 30 Nov 2023 14:52:14 +0000
X-MC-Unique: ehzvvOoBOZGyvf_gdvKpVw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 30 Nov
 2023 14:52:11 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 30 Nov 2023 14:52:11 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'marc.ferland@gmail.com'" <marc.ferland@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "marc.ferland@sonatest.com" <marc.ferland@sonatest.com>,
        "jeff.dagenais@gmail.com" <jeff.dagenais@gmail.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/5] w1: ds2433: use the kernel bitmap implementation
Thread-Topic: [PATCH v3 4/5] w1: ds2433: use the kernel bitmap implementation
Thread-Index: AQHaI5Se1RHZ/iJZnUSiQqCBTHupzLCS8aAQ
Date:   Thu, 30 Nov 2023 14:52:10 +0000
Message-ID: <d123196b2c5d486cbf3b2e7e4b1fc774@AcuMS.aculab.com>
References: <20231130135232.191320-1-marc.ferland@sonatest.com>
 <20231130135232.191320-5-marc.ferland@sonatest.com>
In-Reply-To: <20231130135232.191320-5-marc.ferland@sonatest.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: marc.ferland@gmail.com
> Sent: 30 November 2023 13:53
> 
> The ds2433 driver uses the 'validcrc' variable to mark out which pages
> have been successfully (crc is valid) retrieved from the eeprom and
> placed in the internal 'memory' buffer (see CONFIG_W1_SLAVE_DS2433_CRC).
> 
> The current implementation assumes that the number of pages will never
> go beyond 32 pages (bit field is a u32). This is fine for the ds2433
> since it only has 16 pages.
> 
> Use a dynamically allocated bitmap so that we can support eeproms with
> more than 32 pages which is the case for the ds28ec20 (80 pages).

Dynamically allocating seems excessive.
Why not just make the maximum a compile-time constant (say 96 or 128)
and just check that the actual size isn't too big.

> As an added bonus, the code also gets easier on the eye.

and slower :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

