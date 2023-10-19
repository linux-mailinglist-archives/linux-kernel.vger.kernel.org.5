Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FB47CF576
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjJSKgW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Oct 2023 06:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjJSKgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:36:20 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F304D123
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:36:17 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-5-Z1Yi8b17Pr6wQkjS_sMyLQ-1; Thu, 19 Oct 2023 11:35:35 +0100
X-MC-Unique: Z1Yi8b17Pr6wQkjS_sMyLQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 19 Oct
 2023 11:33:50 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 19 Oct 2023 11:33:50 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'gus Gusenleitner Klaus' <gus@keba.com>,
        Al Viro <viro@ftp.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH] amd64: Fix csum_partial_copy_generic()
Thread-Topic: [PATCH] amd64: Fix csum_partial_copy_generic()
Thread-Index: AdoBilvmES7GiG9dTkSxSspB8XHmAgAT0kuAABppQjAADK2L0A==
Date:   Thu, 19 Oct 2023 10:33:50 +0000
Message-ID: <a75691c5f09e4dbf9257f690684ee79d@AcuMS.aculab.com>
References: <VI1PR0702MB3840EB26EF2A1A35BFEA53BFD9D5A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231018154205.GT800259@ZenIV>
 <VI1PR0702MB3840F2D594B9681BF2E0CD81D9D4A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
In-Reply-To: <VI1PR0702MB3840F2D594B9681BF2E0CD81D9D4A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_ActionId=4aed22ee-49cb-451e-8335-840086e98737;MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_ContentBits=0;MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_Enabled=true;MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_Method=Standard;MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_Name=Confidential;MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_SetDate=2023-10-19T04:18:19Z;MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_SiteId=83e2508b-c1e1-4014-8ab1-e34a653fca88
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

> Wireshark shows a bad checksum warning:
>  'Checksum: 0x0000 incorrect, should be 0xffff'

Does the ICMP message contain the non-inverted checksum?
Usually it is inverted before transmission so that a checksum
of the whole buffer (including the checksum) is 0xffff.

If the checksum() function does the reduction mod 0xffff
with 'add with carry' it is only zero if the buffer is zero.
So initialising to 0xffff does make sense.
OTOH the value could be reduced using 'csum64 % 0xffff' which
generates 0x0 not 0xffff (and might be faster code).

There is a different potential issue that IPv6 mandates
a non-zero checksum field.
But a naive ~checksum(buffer, len) can generate zero.

The simple fix is to initialise the checksum with 1
and add 1 back after the invert so:
	buffer->csum = ~checksum(1, buffer, len) + 1;

I'm guessing the current code has an extra conditional
in the hot path?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

