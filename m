Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CA877F565
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350355AbjHQLhn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Aug 2023 07:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350318AbjHQLhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:37:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD061AE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:37:31 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-208-gwuNGtgYP1ytLiWlQdQCzA-1; Thu, 17 Aug 2023 12:37:29 +0100
X-MC-Unique: gwuNGtgYP1ytLiWlQdQCzA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 17 Aug
 2023 12:37:25 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 17 Aug 2023 12:37:25 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jiri Slaby (SUSE)'" <jirislaby@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] tty: gdm724x: use min_t() for size_t varable and a
 constant
Thread-Topic: [PATCH] tty: gdm724x: use min_t() for size_t varable and a
 constant
Thread-Index: AQHZ0B87nDgSkZkjFECy+iNTKj/JmK/uXXfg
Date:   Thu, 17 Aug 2023 11:37:25 +0000
Message-ID: <e082032238ae4d5e9af2c0ccdc79889f@AcuMS.aculab.com>
References: <20230816085322.22065-1-jirislaby@kernel.org>
In-Reply-To: <20230816085322.22065-1-jirislaby@kernel.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby (SUSE)
> Sent: Wednesday, August 16, 2023 9:53 AM
> 
> My thinking was that ulong is the same as size_t everywhere. No, size_t
> is uint on 32bit. So the below commit introduced a build warning on
> 32bit:
> .../gdm724x/gdm_tty.c:165:24: warning: comparison of distinct pointer types ('typeof (2048UL) *' (aka
> 'unsigned long *') and 'typeof (remain) *' (aka 'unsigned int *'))
> 
> To fix this, partially revert the commit (remove constants' suffixes)
> and switch to min_t() in this case instead.
> 
....
> -		size_t sending_len = min(MUX_TX_MAX_SIZE, remain);
> +		size_t sending_len = min_t(size_t, MUX_TX_MAX_SIZE, remain);

It would be slightly safer to use:
		min(remain, (size_t)MAX_TX_MAX_SIZE);
since that maintains the type check.
(It is also nicer to put the constant second.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

