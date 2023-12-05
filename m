Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F762805DA1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbjLES3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLES3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:29:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44305D43
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:29:27 -0800 (PST)
Date:   Tue, 5 Dec 2023 19:29:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701800965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+ROuSujUk/tPri8un5u3/M8TC4emax/F2/1hCSNTUM=;
        b=SSYp71gHAv8EGD6zdebeGV7Lh89cV/Nk8GPPODHfjBQXUCt+Zc+sDOzZEhHSp/f/FpmHs6
        o8ITlgx2yeaUrGgphbl/zJTo8Q31M9htc53SsteXq8uy5pLbY4h8cdwWptQAYHFyoZvZm4
        C1HA5ByrAby6NdXwYjyWNje7nPJDWeiK0Rmlv8Yq3VkY14XkNy3IZaC86jBMsEcEcbwKdF
        yBY/A6VuVLBSPwmuINo+9CtkQcpDgq0o7GeqOesqJersklmbp5nofaG6t27Dk2rzwNMAFF
        oOoZYTN6S61anXN/kJcPGjBWXdua6PGji0cw14M8M1sBstdJZC0yttWfRDyz2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701800965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+ROuSujUk/tPri8un5u3/M8TC4emax/F2/1hCSNTUM=;
        b=PaJmUhoI6K56KvqAeYMmaqsmT+yuSP6Y+G1Q7SPG993zoUoCwOOh4QcldNkB5hVTGW1kmG
        phYXQvKemUJucxDA==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v9 19/32] timers: add_timer_on(): Make sure TIMER_PINNED
 flag is set
Message-ID: <20231205182924.SFCmSKXe@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-20-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231201092654.34614-20-anna-maria@linutronix.de>
X-TUID: pj+LAvNjV8hx
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-01 10:26:41 [+0100], Anna-Maria Behnsen wrote:
> When adding a timer to the timer wheel using add_timer_on(), it is an
> implicitly pinned timer. With the timer pull at expiry time model in plac=
e,
> TIMER_PINNED flag is required to make sure timers end up in proper base.
>=20
> Add TIMER_PINNED flag unconditionally when add_timer_on() is executed.

This is odd. I have some vague memory that this was already the case.
Otherwise all add_timer_on() users without TIMER_PINNED may get it wrong
due to optimisation. Looking at git history it was never the case and I
can't confuse it with hrtimer since it never supported the "_on()"
feature=E2=80=A6
At least the mix timer in drivers/char/random.c is not using the PINNED
flag with _on(). So this was wrong then?=E2=80=A6

Sebastian
