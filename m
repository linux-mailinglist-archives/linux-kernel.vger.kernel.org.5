Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5976879CFDA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbjILL1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbjILL1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:27:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714DD1718
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:26:46 -0700 (PDT)
Date:   Tue, 12 Sep 2023 13:26:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694518005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0969fIIiciKIVWYKv+gSIVjEQIE3takFQ4pk4cNekyc=;
        b=upS6lWG4KA/sDaS8KCTZxLVquM8d5ErN1iba2IEl6XKUljHGNxJ2ichkPJmEx8Db+3JWg5
        Pt420A2X+/DE2yWJUwSkSFhJ8Lxpskq7xZxhh73tuVCT+WpmIC/lHtHeJy+L5bDvU7l94O
        jn89y9Ij6527G3Ed5l3FXIVPXguU96KRieu8uS1EeqMvjY7yJByDdHXEk/jlWe4QBQG4MM
        KmaN7nwOPIxHBlysvAeAmPr+2ZNyD72M3bIEzICE8zUbADm287j1DenuoluPvH6a/UrtfF
        uSOUsmaIf0whz0bvp0Ttmr0efdFDJcY8O+v/Ctj/d+cPd4SnPHWdsSfys/IRjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694518005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0969fIIiciKIVWYKv+gSIVjEQIE3takFQ4pk4cNekyc=;
        b=5ZqGek2+BzumJIuVnGhkaXEEIMvGwbJju6C/BLJl/3UOS1jJ8LLPsuMAHjdnmWJiM+W8+I
        O9SG0bb5frR3YKDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        boqun.feng@gmail.com, bristot@redhat.com, bsegall@google.com,
        dietmar.eggemann@arm.com, jstultz@google.com,
        juri.lelli@redhat.com, longman@redhat.com, mgorman@suse.de,
        mingo@redhat.com, rostedt@goodmis.org, swood@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org
Subject: Re: [PATCH v3 7/7] locking/rtmutex: Acquire the hb lock via trylock
 after wait-proxylock.
Message-ID: <20230912112643.R4IrwXEB@linutronix.de>
References: <20230908162254.999499-1-bigeasy@linutronix.de>
 <20230908162254.999499-8-bigeasy@linutronix.de>
 <20230911141135.GB9098@noisy.programming.kicks-ass.net>
 <20230912105745.GB13926@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230912105745.GB13926@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-12 12:57:45 [+0200], Peter Zijlstra wrote:
> > --- a/kernel/futex/pi.c
> > +++ b/kernel/futex/pi.c
> > @@ -1147,19 +1143,34 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned=
 int flags)
=E2=80=A6
> > +		rt_waiter =3D rt_mutex_top_waiter(&pi_state->pi_mutex);
> > +		if (!rt_waiter)
> > +			goto do_uncontended;
>=20
> That ^ needs to drop wait_lock before the goto.

Ach, you noticed that one. Wrote a reply a few minutes after that one.

Sebastian
