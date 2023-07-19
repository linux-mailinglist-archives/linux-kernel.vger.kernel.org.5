Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B8D75A04D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjGSVCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGSVCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:02:19 -0400
Received: from resqmta-h1p-028588.sys.comcast.net (resqmta-h1p-028588.sys.comcast.net [IPv6:2001:558:fd02:2446::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B4F1FC0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 14:02:17 -0700 (PDT)
Received: from resomta-h1p-027914.sys.comcast.net ([96.102.179.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resqmta-h1p-028588.sys.comcast.net with ESMTP
        id M8BKqr6301NLIMEJNqyzwF; Wed, 19 Jul 2023 21:02:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1689800537;
        bh=xqMj+3VVjo+8UbUEghVnxRyNG8G2SG/j/lJTsRoSPsQ=;
        h=Received:Received:From:To:Subject:Date:MIME-Version:Message-ID:
         Content-Type:Xfinity-Spam-Result;
        b=M/Qb3VpWAE7bYugC+rHd7Cd5cE3NxoMyRELNAJ97xWWgtX/teX5suAFwORnCr5cPw
         VyAog58FGP8weDbwm8qXeedhP8hlN3mYo5jf/WIbn610nEAr1yNElNOWnHmdyrjxEs
         JYwCjYf5VMekWWDuucIh+qZEqjuAwqSWRcDQNAFWjWUD8ulAl3wy+K5EE8QxSMNFUu
         KCdWpoeV3ELH+sROto/COwmZf1RdD8xZoZjUDxxlDuGqQhbGNzYU4oslXvaEG9PDMw
         GHiiFX5zLPjrJ3fsjWS8zh9QoqpF5l8nkcnOvGVcFMhTwJfHl7hwyOKYzRXreDPhhr
         flBYWxP73gtiA==
Received: from localhost ([IPv6:2601:18c:9082:afd:219:d1ff:fe75:dc2f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resomta-h1p-027914.sys.comcast.net with ESMTPSA
        id MEJAqBpSU0WpqMEJCqnizK; Wed, 19 Jul 2023 21:02:12 +0000
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
Date:   Wed, 19 Jul 2023 17:02:04 -0400
MIME-Version: 1.0
Message-ID: <6609f1b8-3264-4017-ac3c-84a01ea12690@mattwhitlock.name>
In-Reply-To: <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com>
References: <20230629155433.4170837-1-dhowells@redhat.com>
 <20230629155433.4170837-2-dhowells@redhat.com>
 <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
 <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name>
 <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com>
 <ZLg9HbhOVnLk1ogA@casper.infradead.org>
 <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com>
User-Agent: Trojita/v0.7-595-g7738cd47; Qt/5.15.10; xcb; Linux; Gentoo Linux
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 19 July 2023 16:16:07 EDT, Linus Torvalds wrote:
> The *ONLY* reason for splice() existing is for zero-copy.

The very first sentence of splice(2) reads: "splice() moves data between=20
two file descriptors without copying between kernel address space and user=20=

address space." Thus, it is not unreasonable to believe that the point of=20
splice is to avoid copying between user-space and kernel-space.

If you use read() and write(), then you're making two copies. If you use=20
splice(), then you're making one copy (or zero, but that's an optimization=20=

that should be invisible to the user).

> And no, we don't start some kind of crazy "versioned zero-copy with
> COW". That's a fundamental mistake.

Agreed. splice() should steal the reference if it can, copy the page data=20
if it must. Note that, even in the slow case where the page data must be=20
copied, this still gives a better-than-50% speedup over read()+write()=20
since an entire copy (and one syscall) is elided.

> IF YOU DON'T UNDERSTAND THE *POINT* OF SPLICE, DON'T USE SPLICE.

Thanks for being so condescending. Your reputation is deserved.

