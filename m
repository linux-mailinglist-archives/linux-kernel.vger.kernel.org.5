Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4D7769C86
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjGaQbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjGaQbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:31:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F1F19AE;
        Mon, 31 Jul 2023 09:30:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A36F22195;
        Mon, 31 Jul 2023 16:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690821019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRi27RxqxV0i0ym17kj/c0a3gna5lH0Z+6HActWoXl4=;
        b=l+ZKgRNNKM7ez1Dl1pHzRijH6B3dejW8bX4DekjR2UuIqikaEYEEk2UtwU0Ns7tPWttAgL
        /ev3pklrQ0+O5+LHPhC/EGgk5bl+eNFKrD1SWnvpahU2Gs67eBlwjJktGAI8E/dML1dZB/
        oF/Uf8xHzcutYRk7R1z12Ny22Le0ewc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690821019;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRi27RxqxV0i0ym17kj/c0a3gna5lH0Z+6HActWoXl4=;
        b=+Xi8ZmAwcxcr5zLI6xmgt3KP9N/ApdhlJ1V6BDMBgBgxOuEQ8/GdWLPo2BPukpaDMmpofA
        c+vhvQkN2Bg1yXCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D14B1322C;
        Mon, 31 Jul 2023 16:30:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zOK+EJrhx2TlFAAAMHmgww
        (envelope-from <rhopkins@suse.de>); Mon, 31 Jul 2023 16:30:18 +0000
Message-ID: <ac73ecd7d6c71e35fd34182daf12b26d4b69046d.camel@suse.de>
Subject: Re: scheduler problems in -next (was: Re: [PATCH 6.4 000/227]
 6.4.7-rc1 review)
From:   Roy Hopkins <rhopkins@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Date:   Mon, 31 Jul 2023 17:30:17 +0100
In-Reply-To: <20230731161452.GA40850@hirez.programming.kicks-ass.net>
References: <2cfc68cc-3a2f-4350-a711-ef0c0d8385fd@paulmck-laptop>
         <D56D0318-A2EA-4448-8F4D-BE84706E26A5@joelfernandes.org>
         <3da81a5c-700b-8e21-1bde-27dd3a0b8945@roeck-us.net>
         <20230731141934.GK29590@hirez.programming.kicks-ass.net>
         <20230731143954.GB37820@hirez.programming.kicks-ass.net>
         <f5a18aa3-9db7-6ad2-33d5-3335a18e4e2f@roeck-us.net>
         <20230731145232.GM29590@hirez.programming.kicks-ass.net>
         <7ff2a2393d78275b14ff867f3af902b5d4b93ea2.camel@suse.de>
         <20230731161452.GA40850@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-31 at 18:14 +0200, Peter Zijlstra wrote:
> Ha!, I was poking around the same thing. My hack below seems to (so far,
> <20 boots) help things.
>=20
>=20
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 56c470a489c8..b083b5a30025 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -652,7 +658,11 @@ static void __init rcu_spawn_tasks_kthread_generic(s=
truct rcu_tasks *rtp)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0t =3D kthread_run(rcu_tas=
ks_kthread, rtp, "%s_kthread", rtp->kname);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (WARN_ONCE(IS_ERR(t), =
"%s: Could not start %s grace-period kthread, OOM is now expected behavior\=
n", __func__, rtp->name))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0smp_mb(); /* Ensure others see=
 full kthread. */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (;;) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0cond_resched();
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0if (smp_load_acquire(&rtp->kthread_ptr))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0}
> =C2=A0
> =C2=A0#ifndef CONFIG_TINY_RCU

FWIW, here's my hack which seems to fix it.

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 9b9ce09f8f35..2e76fbfff9c6 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -52,6 +52,7 @@ struct rcu_tasks_percpu {
  * @cbs_gbl_lock: Lock protecting callback list.
  * @tasks_gp_mutex: Mutex protecting grace period, needed during mid-boot =
dead zone.
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
+ * @kthread_started: Flag that indicates whether kthread has been launched=
.
  * @gp_func: This flavor's grace-period-wait function.
  * @gp_state: Grace period's most recent state transition (debugging).
  * @gp_sleep: Per-grace-period sleep to prevent CPU-bound looping.
@@ -92,6 +93,7 @@ struct rcu_tasks {
        unsigned long n_ipis;
        unsigned long n_ipis_fails;
        struct task_struct *kthread_ptr;
+       int kthread_started;
        rcu_tasks_gp_func_t gp_func;
        pregp_func_t pregp_func;
        pertask_func_t pertask_func;
@@ -582,7 +584,7 @@ static void synchronize_rcu_tasks_generic(struct rcu_ta=
sks *rtp)
                return;
=20
        // If the grace-period kthread is running, use it.
-       if (READ_ONCE(rtp->kthread_ptr)) {
+       if (READ_ONCE(rtp->kthread_started)) {
                wait_rcu_gp(rtp->call_func);
                return;
        }
@@ -595,6 +597,7 @@ static void __init rcu_spawn_tasks_kthread_generic(stru=
ct rcu_tasks *rtp)
        struct task_struct *t;
=20
        t =3D kthread_run(rcu_tasks_kthread, rtp, "%s_kthread", rtp->kname)=
;
+       rtp->kthread_started =3D 1;
        if (WARN_ONCE(IS_ERR(t), "%s: Could not start %s grace-period kthre=
ad, OOM is now expected behavior\n", __func__, rtp->name))
                return;
        smp_mb(); /* Ensure others see full kthread. */
