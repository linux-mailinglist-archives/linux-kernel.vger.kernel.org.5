Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E7578FEF6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349963AbjIAOXk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Sep 2023 10:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbjIAOXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:23:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3432ACC5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 07:23:36 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-3-upz6m7wVOF-ZST2cWmMt8w-1; Fri, 01 Sep 2023 15:23:33 +0100
X-MC-Unique: upz6m7wVOF-ZST2cWmMt8w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 1 Sep
 2023 15:23:28 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 1 Sep 2023 15:23:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ammar Faizi' <ammarfaizi2@gnuweeb.org>, Willy Tarreau <w@1wt.eu>
CC:     =?iso-8859-1?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>,
        "Nicholas Rosenberg" <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v1 0/5] nolibc x86-64 string functions
Thread-Topic: [RFC PATCH v1 0/5] nolibc x86-64 string functions
Thread-Index: AQHZ23UUaWogkrxxpUapKlllYL+KVbAF2IcQgAAa01yAABQxQA==
Date:   Fri, 1 Sep 2023 14:23:28 +0000
Message-ID: <b6a33f1c9c0544c29904e29b06a7cff8@AcuMS.aculab.com>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
 <5a821292d96a4dbc84c96ccdc6b5b666@AcuMS.aculab.com> <ZPHPJDXIkFfP5Eux@1wt.eu>
 <ZPHh0duonHnyAX6C@biznet-home.integral.gnuweeb.org>
In-Reply-To: <ZPHh0duonHnyAX6C@biznet-home.integral.gnuweeb.org>
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

From: Ammar Faizi
> Sent: 01 September 2023 14:06
...
> > You're completely right indeed, reminds me about the copy_up/copy_down
> > that were not used anymore :-)
> 
> I'm an idiot, will fix that. Another attempt as suggested below:
> 
> __asm__ (
> ".section .text.nolibc_memmove\n"
> ".weak memmove\n"
> "memmove:\n"
> "    movq    %rdx, %rcx\n"
> "    movq    %rdi, %rdx\n"
> "    movq    %rdi, %rax\n"

You seem to have confused yourself about whether you are using %eax or %edx.

> "    subq    %rsi, %rdx\n"
> "    cmpq    %rcx, %rdx\n"
> "    jnb     .Lforward_copy\n"

I think I'd fall through to the forwards copy
and not worry about replicating the 'reps movsb' and 'ret'.
IIRC 'cld' can be slow as well.

> "    leaq    -1(%rdi, %rcx, 1), %rdi\n"
> "    leaq    -1(%rsi, %rcx, 1), %rsi\n"
> "    std\n"
> ".Lforward_copy:\n"
> "    rep movsb\n"
> "    cld\n"
> "    ret\n"
> );
> 
> --
> Ammar Faizi

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

