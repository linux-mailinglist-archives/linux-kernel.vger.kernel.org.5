Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07359807E38
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 03:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442044AbjLGCJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 21:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjLGCJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 21:09:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2926D3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 18:09:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20C3C433C8;
        Thu,  7 Dec 2023 02:09:53 +0000 (UTC)
Date:   Wed, 6 Dec 2023 21:10:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     paulmck@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 48/86] rcu: handle quiescent states for
 PREEMPT_RCU=n
Message-ID: <20231206211022.710ada02@gandalf.local.home>
In-Reply-To: <87zfymn6h9.fsf@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107215742.363031-49-ankur.a.arora@oracle.com>
        <2027da00-273d-41cf-b9e7-460776181083@paulmck-laptop>
        <87v89lzu5a.ffs@tglx>
        <209f0e89-7ebd-4759-9883-21d842d0d26c@paulmck-laptop>
        <87zfymn6h9.fsf@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec 2023 17:31:30 -0800
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> ---
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index 9aa6358a1a16..d8139cda8814 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -226,9 +226,11 @@ do { \
>  #ifdef CONFIG_PREEMPTION
>  #define preempt_enable() \
>  do { \
>  	barrier(); \
>  	if (unlikely(preempt_count_dec_and_test())) \
>  		__preempt_schedule(); \
> +	else if (unlikely(raw_cpu_read(rcu_data.rcu_urgent_qs))) \

Shouldn't this still have the:

	else if (!IS_ENABLED(CONFIG_PREEMPT_RCU) && \

That is, is it needed when PREEMPT_RCU is set?

-- Steve


> +		rcu_all_qs_check();
>  } while (0)
> 
>  #define preempt_enable_notrace() \
