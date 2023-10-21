Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3267D1C54
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjJUKAI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 21 Oct 2023 06:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjJUKAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:00:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DB71A4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:00:03 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-311-BFirYQlCNs6HGOUkj5FRTQ-1; Sat, 21 Oct 2023 11:00:00 +0100
X-MC-Unique: BFirYQlCNs6HGOUkj5FRTQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 21 Oct
 2023 10:59:59 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 21 Oct 2023 10:59:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Miklos Szeredi' <mszeredi@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Takashi Iwai <tiwai@suse.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Christian Brauner" <brauner@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: RE: [RFC PATCH 1/2] add list_for_each_entry_del()
Thread-Topic: [RFC PATCH 1/2] add list_for_each_entry_del()
Thread-Index: AQHaA0BhVdxwGOC7H06bkVWqGZ+tgrBUAoSg
Date:   Sat, 21 Oct 2023 09:59:59 +0000
Message-ID: <3ab474953c734d0bbf0177bf5d208799@AcuMS.aculab.com>
References: <20231020102901.3354273-1-mszeredi@redhat.com>
 <20231020102901.3354273-2-mszeredi@redhat.com>
In-Reply-To: <20231020102901.3354273-2-mszeredi@redhat.com>
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

From: Miklos Szeredi
> Sent: 20 October 2023 11:29
> 
> Add a new list iteration macro that always takes the first element of the
> list and removes it, until the list is empty.
...
> +/**
> + * list_for_each_entry_del - iterate list and remove elements
> + * @pos:	the type * to use as a loop cursor.
> + * @head:	the head for your list.
> + * @member:	the name of the list_head within the struct.
> + *
> + * Delete first element from list before the iteration.  Iterate until
> + * the list is empty.
> + */
> +#define list_for_each_entry_del(pos, head, member)			\
> +	while (!list_empty(head) &&					\
> +		({ pos = list_first_entry(head, typeof(*(pos)), member);\
> +		   list_del(&(pos)->member); 1; }))

That pattern is actually pretty obvious.
Add another wrapper and people end up having to read the
header to find out what it does.

I can't help feeling that if you look inside list_empty(),
list_first_entry() and list_del() there is a lot of
replicated code and tests.

Adding a list_del_first() function that returns the deleted
item or NULL to optimise it might make more sense.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

