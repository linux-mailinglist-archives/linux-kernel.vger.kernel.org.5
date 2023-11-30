Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23657FF2A5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346038AbjK3OlE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Nov 2023 09:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbjK3OlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:41:02 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5A0BD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:41:07 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-48-t3ILSSs2OZqhiSRZq3Dljg-2; Thu, 30 Nov 2023 14:40:57 +0000
X-MC-Unique: t3ILSSs2OZqhiSRZq3Dljg-2
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 30 Nov
 2023 14:40:12 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 30 Nov 2023 14:40:12 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Lee Jones' <lee@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yuan-Hsin Chen <yhchen@faraday-tech.com>,
        Feng-Hsin Chiang <john453@faraday-tech.com>,
        Po-Yu Chuang <ratbert.chuang@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH 3/5] usb: fotg210-hcd: Replace snprintf() with the safer
 scnprintf() variant
Thread-Topic: [PATCH 3/5] usb: fotg210-hcd: Replace snprintf() with the safer
 scnprintf() variant
Thread-Index: AQHaI3u56JraFtMggUKBqY7WM/KeMLCS64WA
Date:   Thu, 30 Nov 2023 14:40:12 +0000
Message-ID: <f79f570f12cf424b992a7bc87664588a@AcuMS.aculab.com>
References: <20231130105459.3208986-1-lee@kernel.org>
 <20231130105459.3208986-4-lee@kernel.org>
In-Reply-To: <20231130105459.3208986-4-lee@kernel.org>
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

From: Lee Jones
> Sent: 30 November 2023 10:55
> 
> There is a general misunderstanding amongst engineers that {v}snprintf()
> returns the length of the data *actually* encoded into the destination
> array.  However, as per the C99 standard {v}snprintf() really returns
> the length of the data that *would have been* written if there were
> enough space for it.  This misunderstanding has led to buffer-overruns
> in the past.  It's generally considered safer to use the {v}scnprintf()
> variants in their place (or even sprintf() in simple cases).  So let's
> do that.
> 
> The uses in this file both seem to assume that data *has been* written!
...
> -		temp = snprintf(next, size,
> -				"\n\t%p%c%s len=%d %08x urb %p",
> -				td, mark, ({ char *tmp;
...
> -		if (size < temp)
> -			temp = size;

That is actually a bug - even though it is trying to be correct.
The trailing '\0' that snprintf() adds (unless you are using the
M$ one) will end up in the buffer.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

