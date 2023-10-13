Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7537C862C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjJMMyl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Oct 2023 08:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjJMMyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:54:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD38BD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:54:36 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-317-U7r5hpf3P-qz6uyO7uX2kQ-1; Fri, 13 Oct 2023 13:54:34 +0100
X-MC-Unique: U7r5hpf3P-qz6uyO7uX2kQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 13 Oct
 2023 13:54:32 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 13 Oct 2023 13:54:32 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Frederic Weisbecker' <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Denis Arefev <arefev@swemel.ru>, Boqun Feng <boqun.feng@gmail.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: RE: [PATCH 09/18] srcu: Fix srcu_struct node grpmask overflow on
 64-bit systems
Thread-Topic: [PATCH 09/18] srcu: Fix srcu_struct node grpmask overflow on
 64-bit systems
Thread-Index: AQHZ/czQOSuWXrFURUqEf76SS6pOObBHq6Fg
Date:   Fri, 13 Oct 2023 12:54:32 +0000
Message-ID: <f6cc79b13ccf471aa275bee88559b6bd@AcuMS.aculab.com>
References: <20231013115902.1059735-1-frederic@kernel.org>
 <20231013115902.1059735-10-frederic@kernel.org>
In-Reply-To: <20231013115902.1059735-10-frederic@kernel.org>
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

From: Frederic Weisbecker
> Sent: 13 October 2023 12:59
> 
> The value of a bitwise expression 1 << (cpu - sdp->mynode->grplo)
> is subject to overflow due to a failure to cast operands to a larger
> data type before performing the bitwise operation.
> 
> The maximum result of this subtraction is defined by the RCU_FANOUT_LEAF
> Kconfig option, which on 64-bit systems defaults to 16 (resulting in a
> maximum shift of 15), but which can be set up as high as 64 (resulting
> in a maximum shift of 63).  A value of 31 can result in sign extension,
> resulting in 0xffffffff80000000 instead of the desired 0x80000000.
> A value of 32 or greater triggers undefined behavior per the C standard.
> 
> This bug has not been known to cause issues because almost all kernels
> take the default CONFIG_RCU_FANOUT_LEAF=16.  Furthermore, as long as a
> given compiler gives a deterministic non-zero result for 1<<N for N>=32,
> the code correctly invokes all SRCU callbacks, albeit wasting CPU time
> along the way.
> 
> This commit therefore substitutes the correct 1UL for the buggy 1.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: David Laight <David.Laight@aculab.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/srcutree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 833a8f848a90..5602042856b1 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -223,7 +223,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
>  				snp->grplo = cpu;
>  			snp->grphi = cpu;
>  		}
> -		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
> +		sdp->grpmask = 1UL << (cpu - sdp->mynode->grplo);
>  	}
>  	smp_store_release(&ssp->srcu_sup->srcu_size_state, SRCU_SIZE_WAIT_BARRIER);
>  	return true;
> @@ -835,7 +835,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
>  	int cpu;
> 
>  	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
> -		if (!(mask & (1 << (cpu - snp->grplo))))
> +		if (!(mask & (1UL << (cpu - snp->grplo))))
>  			continue;
>  		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
>  	}

That loop is entirely horrid.
The compiler almost certainly has to reload snp->grphi every iteration.
Also it looks as though the bottom bit of mask is checked first.
So how about:
	grphi = snp->grphi;
	for (cpu = snp->grplo; cpu <= grphi; cpu++, mask >>= 1) {
		if (!(mask & 1))
			continue;
		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
	}

	David		

> --
> 2.34.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

