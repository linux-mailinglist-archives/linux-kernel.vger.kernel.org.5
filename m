Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D61578563E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbjHWKv4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Aug 2023 06:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbjHWKvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:51:24 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA25A1980
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:49:45 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-309-dnwCdy7dN0qtUfFbZHofUA-1; Wed, 23 Aug 2023 11:49:43 +0100
X-MC-Unique: dnwCdy7dN0qtUfFbZHofUA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 23 Aug
 2023 11:49:42 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 23 Aug 2023 11:49:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jan Kara' <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>
CC:     Dennis Zhou <dennis@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 0/2] execve scalability issues, part 1
Thread-Topic: [PATCH 0/2] execve scalability issues, part 1
Thread-Index: AQHZ1aeVc0rzaxTOZkOyAPVlJjGUQ6/3shQw
Date:   Wed, 23 Aug 2023 10:49:41 +0000
Message-ID: <c5b9a025165a4c93aa10b462a40641dc@AcuMS.aculab.com>
References: <20230821202829.2163744-1-mjguzik@gmail.com>
 <ZOPSEJTzrow8YFix@snowbird> <20230821213951.bx3yyqh7omdvpyae@f>
 <CAGudoHHJECp2-DfSr5hudooAdV6mivvSO+4mC9kwUrWnSiob5g@mail.gmail.com>
 <20230822095154.7cr5ofogw552z3jk@quack3>
 <CAGudoHHe5nzRTuj4G1fphD+JJ02TE5BnHEDwFm=-W6DoEj2qVQ@mail.gmail.com>
 <20230823094915.ggv3spzevgyoov6i@quack3>
In-Reply-To: <20230823094915.ggv3spzevgyoov6i@quack3>
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

From: Jan Kara
> Sent: Wednesday, August 23, 2023 10:49 AM
....
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -737,7 +737,11 @@ struct mm_struct {
> >
> >                 unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for
> > /proc/PID/auxv */
> >
> > -               struct percpu_counter rss_stat[NR_MM_COUNTERS];
> > +               union {
> > +                       struct percpu_counter rss_stat[NR_MM_COUNTERS];
> > +                       u64 *rss_stat_single;
> > +               };
> > +               bool    magic_flag_stuffed_elsewhere;

I wouldn't use a union to save a pointer - it is asking for trouble.

> >
> >                 struct linux_binfmt *binfmt;
> >
> >
> > Then for single-threaded case an area is allocated for NR_MM_COUNTERS
> > countes * 2 -- first set updated without any synchro by current
> > thread. Second set only to be modified by others and protected with
> > mm->arg_lock. The lock protects remote access to the union to begin
> > with.
> 
> arg_lock seems a bit like a hack. How is it related to rss_stat? The scheme
> with two counters is clever but I'm not 100% convinced the complexity is
> really worth it. I'm not sure the overhead of always using an atomic
> counter would really be measurable as atomic counter ops in local CPU cache
> tend to be cheap. Did you try to measure the difference?

A separate lock is worse than atomics.
(Although some 32bit arch may have issues with 64bit atomics.)

I think you'll be surprised just how slow atomic ops are.
Even when present in the local cache.
(Probably because any other copies have to be invalidated.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

