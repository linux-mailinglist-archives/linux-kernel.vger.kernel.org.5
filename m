Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA197BA226
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjJEPQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjJEPPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:15:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03B665BF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A3dD49hcyp5oU6Y79kzfv064lAkg1W7ksDH4T/U5iJ8=; b=W3Vistp0YedPgkRP2WHTP846Mh
        0BeGZI/5OiqAl04tE/7St7RaWoY/TYIJ4DWK42MAee28XUtkRFLzVA1A6Yin9whHEYe0UR0lZrHj3
        80DCalOudbJwPQ+44zCXmZHD2Fxg38oonzhgBOacq/eCkqRKfYF2/CXg7j6hADZ/zyK3mWgkFQUHF
        xNXDlrL2uCA8LqBMPBnUrXcZJT8irVCkJ8QjhShLMV9WpZEPqxI1+qnIg3arwBFrF5rEoeupZvKRM
        CnQViVfWISEOw7KQ0YZc2qB6Xhz3MlMVEIKslM2G0XL2pvjDtFm8jw4nj/Y3TBAi3QRjGogstZFMb
        kIBsqCCw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qoPZ1-00BmDr-39;
        Thu, 05 Oct 2023 14:42:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1AACA300451; Thu,  5 Oct 2023 16:42:57 +0200 (CEST)
Date:   Thu, 5 Oct 2023 16:42:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Youssef Esmat <youssefesmat@chromium.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Subject: Re: [PATCH 00/15] sched: EEVDF and latency-nice and/or slice-attr
Message-ID: <20231005144257.GC743@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <dlbtvvm5cewqzh5bcpl4cqhcwxmnnjb6pdle5jzywiiznlactd@cmhnpim42m3p>
 <20230906131356.GG38741@noisy.programming.kicks-ass.net>
 <CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com>
 <20231002184136.GA1539@noisy.programming.kicks-ass.net>
 <20231005120557.GA743@noisy.programming.kicks-ass.net>
 <20231005141408.GB743@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005141408.GB743@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 04:14:08PM +0200, Peter Zijlstra wrote:

> --- eevdf.c.orig	2023-10-05 16:11:35.821114320 +0200
> +++ eevdf.c	2023-10-05 16:08:38.387080327 +0200
> @@ -7,6 +7,7 @@
>  #include <sys/param.h>
>  
>  bool eligible = true;
> +bool bias = false;
>  unsigned long V_lim = 20;
>  
>  struct entity {
> @@ -79,16 +80,17 @@
>  
>  struct entity *pick_entity(int nr, struct entity *es)
>  {
> -	unsigned long W = 0, V = 0;
> +	unsigned long W = 0, V = 0, R = 0;
>  	struct entity *e = NULL;
>  
>  	for (int i = 0; i < nr; i++) {
>  		V += es[i].weight * es[i].vruntime;
> +		R += es[i].request;

				* 1024

Also, average seems too much, one large value lifts it too easily. 

Need to come up with something better :/

>  		W += es[i].weight;
>  	}
>  
>  	for (int i = 0; i < nr; i++) {
> -		if (eligible && W*es[i].vruntime > V)
> +		if (eligible && W*es[i].vruntime > V + (bias * R))
>  			continue;
>  
>  		if (!e || es[i].vdeadline < e->vdeadline)
> @@ -169,10 +171,14 @@
>  
>  	const int N = sizeof(es) / sizeof(es[0]);
>  
> -	while ((opt = getopt(argc, argv, "nv:e:")) != -1) {
> +	while ((opt = getopt(argc, argv, "bnv:e:")) != -1) {
>  		unsigned int v,w,r;
>  
>  		switch (opt) {
> +		case 'b':
> +			bias = true;
> +			break;
> +
>  		case 'n':
>  			eligible = false;
>  			break;
