Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B48177CE63
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbjHOOr3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Aug 2023 10:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237799AbjHOOrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:47:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8453493
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:47:13 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-283-aQY9xdUMN3GeVjFFocRg_w-1; Tue, 15 Aug 2023 15:47:10 +0100
X-MC-Unique: aQY9xdUMN3GeVjFFocRg_w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 15 Aug
 2023 15:47:07 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 15 Aug 2023 15:47:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Oleg Nesterov' <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
CC:     Petr Skocik <pskocik@gmail.com>, Kees Cook <keescook@chromium.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Marco Elver" <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] signal: Fix the error return of kill -1
Thread-Topic: [PATCH] signal: Fix the error return of kill -1
Thread-Index: AQHZzsZurwDqks8Mx0Ka5moH+T06/q/rb+fw
Date:   Tue, 15 Aug 2023 14:47:07 +0000
Message-ID: <3b14ae8091e3403bbc4ef1bee6dcf4f6@AcuMS.aculab.com>
References: <20221122161240.137570-1-pskocik@gmail.com>
 <202211220913.AF86992@keescook>
 <d2d508b7-f267-0fe6-1b56-4292c95355a7@gmail.com>
 <878rai7u0l.fsf@email.froward.int.ebiederm.org>
 <336ae9be-c66c-d87f-61fe-b916e9f04ffc@gmail.com>
 <87pm3t2rvl.fsf@email.froward.int.ebiederm.org>
 <87jzu12pjh.fsf_-_@email.froward.int.ebiederm.org>
 <20230814140652.GA30596@redhat.com> <20230814154351.GA4203@redhat.com>
In-Reply-To: <20230814154351.GA4203@redhat.com>
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

From: Oleg Nesterov
> Sent: 14 August 2023 16:44
...
> Even simpler
> 
> 	} else {
> 		struct task_struct * p;
> 		bool success = false;
> 		int err = -ESRCH;

		int err;
		ret = -ESRCH;

> 
> 		for_each_process(p) {
> 			if (task_pid_vnr(p) > 1 &&
> 					!same_thread_group(p, current)) {
> 				err = group_send_sig_info(sig, info, p,
> 							  PIDTYPE_MAX);
> 				success |= !err;
> 			}
> 		}
> 		ret = success ? 0 : err;
> 	}

or maybe even:
	} else {
		struct task_struct * p;
		int err;
		ret = -ESRCH;

		for_each_process(p) {
			if (task_pid_vnr(p) > 1 &&
					!same_thread_group(p, current)) {
				err = group_send_sig_info(sig, info, p,
							  PIDTYPE_MAX);
				if (ret)
					ret = err; 
			}
		}
	}

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

