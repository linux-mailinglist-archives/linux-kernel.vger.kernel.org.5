Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466D977B6FF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbjHNKnX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Aug 2023 06:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbjHNKmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:42:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D692F1708
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:42:40 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-10-bYN0va-pOwmudf1yAI4-aA-1; Mon, 14 Aug 2023 11:42:38 +0100
X-MC-Unique: bYN0va-pOwmudf1yAI4-aA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 14 Aug
 2023 11:42:26 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 14 Aug 2023 11:42:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>
CC:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        "Vijay Balakrishna" <vijayb@linux.microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] printk: ringbuffer: Fix truncating buffer size min_t cast
Thread-Topic: [PATCH] printk: ringbuffer: Fix truncating buffer size min_t
 cast
Thread-Index: AQHZzBcPYpG1g1kNlkm6DrLi5BIXA6/pnsfQ
Date:   Mon, 14 Aug 2023 10:42:26 +0000
Message-ID: <42a1e2099fe141c3a57e808cbf06d8a0@AcuMS.aculab.com>
References: <20230811054528.never.165-kees@kernel.org>
In-Reply-To: <20230811054528.never.165-kees@kernel.org>
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

From: Kees Cook
> Sent: 11 August 2023 06:46
> 
> If an output buffer size exceeded U16_MAX, the min_t(u16, ...) cast in
> copy_data() was causing writes to truncate. This manifested as output
> bytes being skipped, seen as %NUL bytes in pstore dumps when the available
> record size was larger than 65536. Fix the cast to no longer truncate
> the calculation.
> 
...
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 2dc4d5a1f1ff..fde338606ce8 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -1735,7 +1735,7 @@ static bool copy_data(struct prb_data_ring *data_ring,
>  	if (!buf || !buf_size)
>  		return true;
> 
> -	data_size = min_t(u16, buf_size, len);
> +	data_size = min_t(unsigned int, buf_size, len);

I'd noticed that during one of my test compiles while looking
at making min() less fussy.

A better fix would be:
	data_size = min(buf_size + 0u, len);

Or put an ack on my patch 3/5 to minmax.h and then min(buf_size, len)
will be fine (because both arguments are unsigned).

	David

> 
>  	memcpy(&buf[0], data, data_size); /* LMM(copy_data:A) */
>  	return true;
> --
> 2.34.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

