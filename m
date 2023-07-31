Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE41769BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjGaQIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjGaQIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:08:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFA61981;
        Mon, 31 Jul 2023 09:08:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 15A9B1F45F;
        Mon, 31 Jul 2023 16:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690819711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qQs9wdHlrLhwCHhCKhiMFGg1nYsVa/Zj2WYMaePC1WA=;
        b=Ey1zRaXBulEDJJXu0A8G9m07QKDcUMmlb3XQ5FzB2Ym1V8q6qMPkZT+1ojZQRYFliXzpWw
        s/XXEJRB1PxU8OVvS4ysosWisk1AYSGwLFren7+/SVwLPj5rfVTkpmqab+rJUN3JMPMstT
        UGYECBPPpj0DB8+IU+gt827R4wgJZKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690819711;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qQs9wdHlrLhwCHhCKhiMFGg1nYsVa/Zj2WYMaePC1WA=;
        b=macfYBb1CFMfpmvl7jPxMbvRiiXrZf9ZlE3jbB8Rgz6tSC6Z94CqsTykdLXiK7XlJWg8oV
        XusEAO7EP58FfhCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1632D1322C;
        Mon, 31 Jul 2023 16:08:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p/8xA37cx2QCCwAAMHmgww
        (envelope-from <rhopkins@suse.de>); Mon, 31 Jul 2023 16:08:30 +0000
Message-ID: <7ff2a2393d78275b14ff867f3af902b5d4b93ea2.camel@suse.de>
Subject: Re: scheduler problems in -next (was: Re: [PATCH 6.4 000/227]
 6.4.7-rc1 review)
From:   Roy Hopkins <rhopkins@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Date:   Mon, 31 Jul 2023 17:08:29 +0100
In-Reply-To: <20230731145232.GM29590@hirez.programming.kicks-ass.net>
References: <2cfc68cc-3a2f-4350-a711-ef0c0d8385fd@paulmck-laptop>
         <D56D0318-A2EA-4448-8F4D-BE84706E26A5@joelfernandes.org>
         <3da81a5c-700b-8e21-1bde-27dd3a0b8945@roeck-us.net>
         <20230731141934.GK29590@hirez.programming.kicks-ass.net>
         <20230731143954.GB37820@hirez.programming.kicks-ass.net>
         <f5a18aa3-9db7-6ad2-33d5-3335a18e4e2f@roeck-us.net>
         <20230731145232.GM29590@hirez.programming.kicks-ass.net>
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

On Mon, 2023-07-31 at 16:52 +0200, Peter Zijlstra wrote:
> On Mon, Jul 31, 2023 at 07:48:19AM -0700, Guenter Roeck wrote:
>=20
> > > I've taken your config above, and the rootfs.ext2 and run-sh from x86=
/.
> > > I've then modified run-sh to use:
> > >=20
> > > =C2=A0=C2=A0 qemu-system-x86_64 -enable-kvm -cpu host
> > >=20
> > > What I'm seeing is that some boots get stuck at:
> > >=20
> > > [=C2=A0=C2=A0=C2=A0 0.608230] Running RCU-tasks wait API self tests
> > >=20
> > > Is this the right 'problem' ?
> > >=20
> >=20
> >=20
> > Yes, exactly.
>=20
> Excellent! Let me prod that with something sharp, see what comes
> creeping out.

In an effort to get up to speed with this area of the kernel, I've been pla=
ying
around with this too today and managed to reproduce the problem using the s=
ame
configuration. I'm completely new to this code but I think I may have found=
 the
root of the problem.

What I've found is that there is a race condition between starting the RCU =
tasks
grace-period thread in rcu_spawn_tasks_kthread_generic() and a subsequent c=
all
to synchronize_rcu_tasks_generic(). This results in rtp->tasks_gp_mutex bei=
ng
locked in the initial thread which subsequently blocks the newly started gr=
ace-
period thread.

The problem is that although synchronize_rcu_tasks_generic() checks to see =
if
the grace-period kthread is running, it uses rtp->kthread_ptr to achieve th=
is.
This is only set in the thread entry point and not when the thread is creat=
ed,
meaning that it is set only after the creating thread yields or is preempte=
d. If
this has not happened before the next call to synchronize_rcu_tasks_generic=
()
then a deadlock occurs.

I've created a debug patch that introduces a new flag in rcu_tasks that is =
set
when the kthread is created and used this in synchronize_rcu_tasks_generic(=
) in
place of READ_ONCE(rtp->kthread_ptr). This fixes the issue in my test
environment.

I'm happy to have a go at submitting a patch for this if it helps.
