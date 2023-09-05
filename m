Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C31F792B34
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244021AbjIEQtj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Sep 2023 12:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354774AbjIEOPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:15:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D9A1A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 07:15:32 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-213-W_uhwjSCPzKzgPTx1pZAYg-1; Tue, 05 Sep 2023 15:15:29 +0100
X-MC-Unique: W_uhwjSCPzKzgPTx1pZAYg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 5 Sep
 2023 15:15:25 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 5 Sep 2023 15:15:25 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'paulmck@kernel.org'" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Denis Arefev <arefev@swemel.ru>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trufanov@swemel.ru" <trufanov@swemel.ru>,
        "vfh@swemel.ru" <vfh@swemel.ru>
Subject: RE: [PATCH v2] The value may overflow
Thread-Topic: [PATCH v2] The value may overflow
Thread-Index: AQHZ3xnFNLjoHgiM306HccvtrgnILrAL+RdggABM0NiAAADkEA==
Date:   Tue, 5 Sep 2023 14:15:25 +0000
Message-ID: <c312066b2cc44919bd11b6cd938cb05f@AcuMS.aculab.com>
References: <20230904094251.64022-1-arefev@swemel.ru>
 <bb708695-a513-2006-0985-d6686e525f5a@efficios.com>
 <429249323d5f41ebbfa4f9e0294b2ddb@AcuMS.aculab.com>
 <89dc5f3f-f959-0586-6f3c-1481c5d3efc4@efficios.com>
 <f4e8d869-401b-43f0-a326-52522730fb17@paulmck-laptop>
 <228160e9-96f1-6d1c-06c7-a5336dc93536@efficios.com>
 <b79eb142-67b2-48f0-9ad9-f9b634491e09@paulmck-laptop>
In-Reply-To: <b79eb142-67b2-48f0-9ad9-f9b634491e09@paulmck-laptop>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...
> That would instead be more than 512-16=496 CPUs, correct?  496 CPUs would
> only require a 31-bit shift, which should be OK, but 497 would require
> a 32-bit shift, which would result in sign extension.  If it turns out
> that sign extension is OK, then we should get in trouble at 513 CPUs,
> which would result in a 33-bit shift (and is that even defined in C?).

Not quite right :-)

(1 << 31) is int and negative, that gets sign extended before
being converted to 'unsigned long' - so has the top 33 bits set.

(1 << 32) is undefined, the current x86 cpu ignore the high
shift bits so it is (1 << 0).

If the mask is being used to optimise a search the code might
just happen to work!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

