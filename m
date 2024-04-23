Return-Path: <linux-kernel+bounces-155738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5101F8AF66B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D69C2861A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9235E13E3EB;
	Tue, 23 Apr 2024 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kH2vBiAo"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA4313D8BA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713896391; cv=none; b=f5r8dHnMJ8LlJ20KqvSLpdzOvVXgIn1UCGlul2KvcF5Quj2Pptsw4tSMSee3MGBsUvtX1ObijprobRSxgndq6rLS8gXmWVn82Cp42pb4hEWI8gfwOdfbEy3mSpiCAXA7uxhzzOSHzszBpsaeG+TntsBozlu+A02WoFSa/ZSHkng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713896391; c=relaxed/simple;
	bh=oVSimOQFOxbjRp8F5hqap+KnKU7S2Ifth8z3iypX9Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beWHM9rJJARN2MShUWcvn4YRzifZr6ClRDe/xdLsg2Im2/DRFpZ905PHyCIMfVS/8DHBZBvUvTYp7A95vIwZVj0jNhy1x3KFmDsTzas1qT7zyt5r0H1Oq/+fe558IjU+ip3Oiu4p1f68kG8Qq5tHP5ehXCbQrf28xqJ4JjYFFKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=kH2vBiAo; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so79894181fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1713896388; x=1714501188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1o4Xoxam1hucE10zqLFgiDlF1FTTCxVt5NXIsVs9D4Y=;
        b=kH2vBiAoYU4I4a48nQMOxkXSNcaplP9TKYcmePi0pFFTRWn+ClHS7k5hpv6TGZBW4R
         jd1bcvwh46gheYUW3HMzyIItZTxijysKjdvTZxA+gYFcvisXd6cgRKS/8xdAoOAoH0Rj
         sFe/Fwuec3Q28btGnEBJrqeNYo+L72qfXZDXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713896388; x=1714501188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1o4Xoxam1hucE10zqLFgiDlF1FTTCxVt5NXIsVs9D4Y=;
        b=bqV8rjFMLw4/TT+1q0gxN1W6z6q9DqfJwWYe2zm52grX4MbbB5Mnr0hhVDs2mODPbX
         P1gqh1iOF8ySPym1m5HpJK2cj1KXooT60yPtXMHrTE5WTnwQdtIv7RRP/W8aq7GXKzMP
         u6V5ZEMr5rjGL2xxVXOyFOw9Xi9j2UUAaNq5+NTBt7i2eXXUNKex3Z2uvITfhkuckgjI
         nEJTPVKjbbdg5tpOnp2LKZ+cSlFZQKDvV4lmqe4/QR5zgm/RvGKnbTxqckUKY3pkSU3r
         YxTegcmIt5Zk7BK1/mICQG9Ln4W0EA2lClt7KG07L9lk49BLq3bzsd432CGYJ76qqzot
         e9Zw==
X-Gm-Message-State: AOJu0Yyon6eAWSOErcS1N9fgLnFZOAURu25KsXiTsOkqqNTSAxRhEes1
	kKIMugaOsybdxA06EJ1av0voQbBmS0q0J2MfRIDjWBzZqzVvsY5Je3Afi0WIqAbkMxEW8Mvuwxm
	ybK77Rq2/QQXPWlafbbaFtcFJuTkgHQoXFlqOIA==
X-Google-Smtp-Source: AGHT+IEqhp8XrGJRoCvx3+YvYSEU09Kqd1S0AecrGPcXF71jLcBWLddQs2Xp/bjZ7Va6KcTLbDUrBNYTg2rIllmPXDM=
X-Received: by 2002:a2e:868e:0:b0:2d7:10a1:481e with SMTP id
 l14-20020a2e868e000000b002d710a1481emr31854lji.31.1713896387696; Tue, 23 Apr
 2024 11:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407090558.3395-1-jiangshanlai@gmail.com> <20240407090558.3395-10-jiangshanlai@gmail.com>
In-Reply-To: <20240407090558.3395-10-jiangshanlai@gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 23 Apr 2024 14:19:34 -0400
Message-ID: <CAEXW_YSz8xD4WXO0dOyKC6X7BZeqMD2TOCm0=43=owLjJj=PVA@mail.gmail.com>
Subject: Re: [PATCH V2 09/11] rcu: Implement PCPU_RCU_PREEMPT_COUNT framework
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, x86@kernel.org, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <quic_neeraju@quicinc.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Zqiang <qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 5:04=E2=80=AFAM Lai Jiangshan <jiangshanlai@gmail.co=
m> wrote:
>
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>
> When the arch code provides HAVE_PCPU_RCU_PREEMPT_COUNT and the
> corresponding functions, rcu core uses the functions to implement
> rcu_preempt_depth(), special bits, switching and so on.
>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  include/linux/rcupdate.h | 33 +++++++++++++++++++++++++++++++++
>  kernel/rcu/Kconfig       |  8 ++++++++
>  kernel/rcu/rcu.h         |  4 ++++
>  kernel/rcu/tree_plugin.h |  8 ++++++++
>  4 files changed, 53 insertions(+)
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 328667ae8086..e3e5ce44c7dc 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -70,6 +70,8 @@ static inline bool same_state_synchronize_rcu(unsigned =
long oldstate1, unsigned
>
>  void rcu_read_unlock_special(void);
>
> +#ifndef CONFIG_PCPU_RCU_PREEMPT_COUNT
> +
>  void __rcu_read_lock(void);
>  void __rcu_read_unlock(void);
>
> @@ -81,6 +83,37 @@ void __rcu_read_unlock(void);
>   */
>  #define rcu_preempt_depth() READ_ONCE(current->rcu_read_lock_nesting)
>  #define rcu_preempt_depth_set(val) WRITE_ONCE(current->rcu_read_lock_nes=
ting, (val))
> +#define pcpu_rcu_preempt_special_set() do { } while (0)
> +#define pcpu_rcu_preempt_special_clear() do { } while (0)
> +
> +#else /* #ifndef CONFIG_PCPU_RCU_PREEMPT_COUNT */
> +
> +#include <asm/rcu_preempt.h>
> +
> +static __always_inline void __rcu_read_lock(void)
> +{
> +       pcpu_rcu_preempt_count_add(1);
> +       barrier();
> +}
> +
> +static __always_inline void __rcu_read_unlock(void)
> +{
> +       barrier();
> +       if (unlikely(pcpu_rcu_preempt_count_dec_and_test()))
> +               pcpu_rcu_read_unlock_special();
> +}

Previous code had comments about the barrier(); , can you add back
those comments?

Also there was a compiler barrier in the body of the if() as well?

For reference:

void __rcu_read_unlock(void)
{
        struct task_struct *t =3D current;

        barrier();  // critical section before exit code.
        if (rcu_preempt_read_exit() =3D=3D 0) {
                barrier();  // critical-section exit before .s check.
                if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
                        rcu_read_unlock_special(t);
        }

