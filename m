Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5337778B63E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjH1RSu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Aug 2023 13:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjH1RSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:18:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFDA18D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:18:36 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-10-YKII-GO7PdOrcrxYUkBxtA-1; Mon, 28 Aug 2023 18:18:34 +0100
X-MC-Unique: YKII-GO7PdOrcrxYUkBxtA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 28 Aug
 2023 18:18:37 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 28 Aug 2023 18:18:37 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Heiko Carstens' <hca@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
CC:     Stefan Haberland <sth@linux.ibm.com>,
        =?iso-8859-1?Q?Jan_H=F6ppner?= <hoeppner@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: [PATCH 1/1] s390/dasd: fix string length handling
Thread-Topic: [PATCH 1/1] s390/dasd: fix string length handling
Thread-Index: AQHZ2cWnhKdW55JwuUOen/9fPqAWJK//8duQ
Date:   Mon, 28 Aug 2023 17:18:37 +0000
Message-ID: <f0419f6428ad404386ebca813dc1ec03@AcuMS.aculab.com>
References: <20230828153142.2843753-1-hca@linux.ibm.com>
 <20230828153142.2843753-2-hca@linux.ibm.com>
In-Reply-To: <20230828153142.2843753-2-hca@linux.ibm.com>
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

From: Heiko Carstens
> Sent: 28 August 2023 16:32
> 
> Building dasd_eckd.o with latest clang reveals this bug:
> 
>     CC      drivers/s390/block/dasd_eckd.o
>       drivers/s390/block/dasd_eckd.c:1082:3: warning: 'snprintf' will always be truncated;
>       specified size is 1, but format string expands to at least 11 [-Wfortify-source]
>        1082 |                 snprintf(print_uid, sizeof(*print_uid),
>             |                 ^
>       drivers/s390/block/dasd_eckd.c:1087:3: warning: 'snprintf' will always be truncated;
>       specified size is 1, but format string expands to at least 10 [-Wfortify-source]
>        1087 |                 snprintf(print_uid, sizeof(*print_uid),
>             |                 ^
> 
> Fix this by moving and using the existing UID_STRLEN for the arrays
> that are being written to. Also rename UID_STRLEN to DASD_UID_STRLEN
> to clarify its scope.

If you embed that char[] in a struct and pass the address of the
struct then sizeof will return the correct value and you get the
size checked properly.

...
>  	if (strlen(uid.vduit) > 0)

Does the compiler know enough to optimise that brain-dead test?

> -		snprintf(print_uid, sizeof(*print_uid),
> +		snprintf(print_uid, DASD_UID_STRLEN,
>  			 "%s.%s.%04x.%02x.%s",
>  			 uid.vendor, uid.serial, uid.ssid,
>  			 uid.real_unit_addr, uid.vduit);
>  	else
> -		snprintf(print_uid, sizeof(*print_uid),
> +		snprintf(print_uid, DASD_UID_STRLEN,
>  			 "%s.%s.%04x.%02x",
>  			 uid.vendor, uid.serial, uid.ssid,
>  			 uid.real_unit_addr);

or:
	snprintf(print_uid, DASD_UID_STRLEN,
		"%s.%s.%04x.%02x%s%s",
		uid.vendor, uid.serial, uid.ssid,
		uid.real_unit_addr,
		uid.vduit[0] ? "." : "", uid.vduit);

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

