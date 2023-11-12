Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FEE7E9200
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 19:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjKLSfJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 12 Nov 2023 13:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjKLSfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 13:35:07 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779A7100
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 10:35:04 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-267-SshIAShoPSO8B8sp4H7Q1A-1; Sun, 12 Nov 2023 18:35:01 +0000
X-MC-Unique: SshIAShoPSO8B8sp4H7Q1A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 12 Nov
 2023 18:35:00 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 12 Nov 2023 18:35:00 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kent Overstreet' <kent.overstreet@linux.dev>
CC:     Colin Ian King <colin.i.king@gmail.com>,
        Brian Foster <bfoster@redhat.com>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] bcachefs: remove redundant initialization of
 variable level
Thread-Topic: [PATCH][next] bcachefs: remove redundant initialization of
 variable level
Thread-Index: AQHaFOJc+UlSVVrZd0ysZR3wF8M1VrB1n1CggAAnbQCAATvAgA==
Date:   Sun, 12 Nov 2023 18:34:59 +0000
Message-ID: <d106f21ef1164241a275b1f11b82e7b7@AcuMS.aculab.com>
References: <20231111204528.339603-1-colin.i.king@gmail.com>
 <20231111210208.qra7xhf2nd4pqvst@moria.home.lan>
 <184af6778ab64b3eb6a4a6071974d5e8@AcuMS.aculab.com>
 <20231111233904.zxgqyw3epefiqiro@moria.home.lan>
In-Reply-To: <20231111233904.zxgqyw3epefiqiro@moria.home.lan>
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
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet
> Sent: 11 November 2023 23:39
> 
> On Sat, Nov 11, 2023 at 09:19:40PM +0000, David Laight wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> > > Sent: 11 November 2023 21:02
> > > > Variable level is being initialized a value that is never read, the
> > > > variable is being re-assigned another value several statements later
> > > > on. The initialization is redundant and can be removed. Cleans up
> > > > clang scan build warning:
> > > >
> > > > fs/bcachefs/btree_iter.c:1217:11: warning: Value stored to 'level'
> > > > during its initialization is never read [deadcode.DeadStores]
> > > >
> > > > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > >
> > > since we're no longer gnu89, we can simply declare the variable when
> > > it's first used, like so:
> >
> > ugg... I think that is still frowned upon.
> > It makes it very difficult for the average human to find
> > the variable declaration.
> 
> No, it's 2023, there's no good reason to be declaring variables before
> giving them values.

The year has nothing to do with whether it is a good idea.
It is epically bad without -Wshadow.
(Have you ever played 'stop the declaration' in C++, it isn't fun.)

Finding declarations is bad enough when they are at the top
of a big block, never mind in the middle of a load of assignments.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

