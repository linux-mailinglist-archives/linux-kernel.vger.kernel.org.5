Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C4378FC52
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349182AbjIALe2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Sep 2023 07:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjIALe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:34:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1BA91
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 04:34:24 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-91-Ii1bV-p4PeKtO_W6zNK67Q-1; Fri, 01 Sep 2023 12:34:21 +0100
X-MC-Unique: Ii1bV-p4PeKtO_W6zNK67Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 1 Sep
 2023 12:34:18 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 1 Sep 2023 12:34:18 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ammar Faizi' <ammarfaizi2@gnuweeb.org>, Willy Tarreau <w@1wt.eu>,
        =?iso-8859-1?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>
CC:     Nicholas Rosenberg <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v1 0/5] nolibc x86-64 string functions
Thread-Topic: [RFC PATCH v1 0/5] nolibc x86-64 string functions
Thread-Index: AQHZ23UUaWogkrxxpUapKlllYL+KVbAF2IcQ
Date:   Fri, 1 Sep 2023 11:34:18 +0000
Message-ID: <5a821292d96a4dbc84c96ccdc6b5b666@AcuMS.aculab.com>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
In-Reply-To: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
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

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> Sent: 30 August 2023 14:57
> 
> This is an RFC patchset for nolibc x86-64 string functions. There are 5
> patches in this series.
> 
> ## Patch 1-3: Use `rep movsb`, `rep stosb`, and `rep cmpsb` for:
>     - memcpy() and memmove()
>     - memset()
>     - memcmp()
> respectively. They can simplify the generated ASM code.
> 
...
> After this series:
> ```
>   000000000000140a <memmove>:
>     140a: 48 89 f8              mov    %rdi,%rax
>     140d: 48 89 d1              mov    %rdx,%rcx
>     1410: 48 8d 7c 0f ff        lea    -0x1(%rdi,%rcx,1),%rdi
>     1415: 48 8d 74 0e ff        lea    -0x1(%rsi,%rcx,1),%rsi
>     141a: fd                    std
>     141b: f3 a4                 rep movsb %ds:(%rsi),%es:(%rdi)
>     141d: fc                    cld
>     141e: c3                    ret

Isn't that completely broken?

You need to select between forwards and backwards moves.
Since forwards moves are preferred it is best to do
	if (dst - src < len)
		backards_copy()
	else
		formwards_copy()

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

