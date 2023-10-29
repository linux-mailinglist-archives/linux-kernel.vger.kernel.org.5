Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419B37DAEB5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjJ2WB6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 29 Oct 2023 18:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjJ2WBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:01:55 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003E9B7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 15:01:49 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-170-8fg6BVyCOq2NOYcIuwnfBQ-1; Sun, 29 Oct 2023 22:01:47 +0000
X-MC-Unique: 8fg6BVyCOq2NOYcIuwnfBQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 29 Oct
 2023 22:01:58 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 29 Oct 2023 22:01:58 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: RE: lockdep: holding locks across syscall boundaries
Thread-Topic: lockdep: holding locks across syscall boundaries
Thread-Index: AQHaCO6j4ltnKj0zt0q1hvBGfTxP87BhVBWw
Date:   Sun, 29 Oct 2023 22:01:58 +0000
Message-ID: <1543b5a7ec2d4524bf8c081061048a97@AcuMS.aculab.com>
References: <a99a7fbe-ec31-4e31-87c7-1b7ae1dd1a5a@kernel.dk>
 <20231027155949.GA26550@noisy.programming.kicks-ass.net>
In-Reply-To: <20231027155949.GA26550@noisy.programming.kicks-ass.net>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 27 October 2023 17:00
> 
> On Fri, Oct 27, 2023 at 09:14:53AM -0600, Jens Axboe wrote:
> > Hi,
> >
> > Normally we'd expect locking state to be clean and consistent across
> > syscall entry and exit, as that is always the case for sync syscalls.
> 
> > We currently have a work-around for holding a lock from aio, see
> > kiocb_start_write(), which pretends to drop the lock from lockdeps
> > perspective, as it's held from submission to until kiocb_end_write() is
> > called at completion time.
> 
> I was not aware of this, the only such hack I knew about was the
> filesystem freezer thing.
> 
> The problem with holding locks past the end of a syscall is that you'll
> nest whatever random lock hierarchies possibly by every other syscall
> under that lock.
> 
...
> 
> Suppose syscall-a returns with your kiocb thing held, call it lock A
> Suppose syscall-b returns with your inode thing held, call it lock B
> 
> Then userspace does:
> 
> 	syscall-a
> 	syscall-b
> 
> while it also does:
> 
> 	syscall-b
> 	syscall-a
> 
> and we're up a creek, no?

Isn't it also open to a massive denial-of-service attack?
	syscall-a
	sleep(infinity)

assuming you actually catch:
	syscall-a
	_exit()

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

