Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FDD75A2E7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjGSXlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGSXlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:41:19 -0400
Received: from resdmta-c1p-023854.sys.comcast.net (resdmta-c1p-023854.sys.comcast.net [IPv6:2001:558:fd00:56::d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E64E69
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:41:18 -0700 (PDT)
Received: from resomta-c1p-023269.sys.comcast.net ([96.102.18.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resdmta-c1p-023854.sys.comcast.net with ESMTP
        id MC9Tq2iz25fwRMGnFqnXWh; Wed, 19 Jul 2023 23:41:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1689810077;
        bh=D0Zxwoc5PyVtQd58yNNXz/EasT5elbjv8i+Mv7KlxLk=;
        h=Received:Received:From:To:Subject:Date:MIME-Version:Message-ID:
         Content-Type:Xfinity-Spam-Result;
        b=sqlsKlOvFSI4lxRTXrNSR4seZGf5iLSDawGPqWpxYvdXJAMurkohE8bsrfp1hE/5i
         7JdZr2tjIZxEPARFRl69kmmCoCaY8mgOencq9mMmzGuBfHq1uqemzmpc7tz9isIJMS
         fF1c8Kc6ChTLVOPRwtMowI7KrrKMicONqGOzADLVFAfZpGXTs7X6Qk/J87nB4K1aTs
         FLrUBByWH8+WN8tN+OZjq79aNRW5uaUch/iag6P/Yf79juA8tAp+gxowRjaqzF0w1s
         IFC5hYe3o7VlqOyKxrenrK+9t9ZS20P5Fvn5mcKOqQaqxxLC8ncDkHNO4shLbIigJd
         UJzcFWSOez5uw==
Received: from localhost ([IPv6:2601:18c:9082:afd:219:d1ff:fe75:dc2f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resomta-c1p-023269.sys.comcast.net with ESMTPSA
        id MGn6q5Mwsf3EjMGn7qAANV; Wed, 19 Jul 2023 23:41:13 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Matt Whitlock <kernel@mattwhitlock.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>, <netdev@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@kvack.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after =?iso-8859-1?Q?splice()_returns?=
Date:   Wed, 19 Jul 2023 19:41:07 -0400
MIME-Version: 1.0
Message-ID: <0d10033a-7ea1-48e3-806b-f74000045915@mattwhitlock.name>
In-Reply-To: <CAHk-=wh7OY=7ocTFY8styG8GgQ1coWxds=b09acHZG4t36OxWg@mail.gmail.com>
References: <20230629155433.4170837-1-dhowells@redhat.com>
 <20230629155433.4170837-2-dhowells@redhat.com>
 <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
 <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name>
 <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com>
 <ZLg9HbhOVnLk1ogA@casper.infradead.org>
 <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com>
 <6609f1b8-3264-4017-ac3c-84a01ea12690@mattwhitlock.name>
 <CAHk-=wh7OY=7ocTFY8styG8GgQ1coWxds=b09acHZG4t36OxWg@mail.gmail.com>
User-Agent: Trojita/v0.7-595-g7738cd47; Qt/5.15.10; xcb; Linux; Gentoo Linux
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,MIME_QP_LONG_LINE,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 19 July 2023 19:20:32 EDT, Linus Torvalds wrote:
>> On Wednesday, 19 July 2023 16:16:07 EDT, Linus Torvalds wrote:
>>> The *ONLY* reason for splice() existing is for zero-copy.
>>=20
>> The very first sentence of splice(2) reads: "splice() moves data between
>> two file descriptors without copying between kernel address space and user=

>> address space." Thus, it is not unreasonable to believe that the point of
>> splice is to avoid copying between user-space and kernel-space.
>
> I'm not at all opposed to clarifying the documentation.

Then that is my request. This entire complaint/discussion/argument would=20
have been avoided if splice(2) had contained a sentence like this one from=20=

sendfile(2):

"If out_fd refers to a socket or pipe with zero-copy support, callers must=20=

ensure the transferred portions of the file referred to by in_fd remain=20
unmodified until the reader on the other end of out_fd has consumed the=20
transferred data."

That is a clear warning of the perils of the implementation under the hood,=20=

and it could/should be copied, more or less verbatim, to splice(2).
