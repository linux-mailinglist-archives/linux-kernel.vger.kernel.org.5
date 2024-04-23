Return-Path: <linux-kernel+bounces-155705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7748AF5E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081A628605F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2499813E051;
	Tue, 23 Apr 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yc3o9Te7"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594CF1BC23
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895100; cv=none; b=E12ULyDPjzKz0b8yWXj2BGjcCGhDxhu3P2Eac6jR9byA59uEiyzfjcQBOOJhDwh9cve53h3vbxSQEsGRxEKKjlJjK4PMdrSlF5pdJgck8IG1P/WBaHTv3gnNfi/n5hTZ/J7ZZdoSA0Tp+aKpqbW+TeFIi23+8nLFyByL/vNRbxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895100; c=relaxed/simple;
	bh=SRmMiVJNHY3dDe641SBcogYA9dhCnTJSpL2O3oo4uHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCSHetY0kN9wkxYpAUkfyPYC2XsmH2RVzMQp8hfhor2FNu+Krplr1ApfidMMpBnV3qsKJBWUJ4od6yRb3WByhV/xKTMbUzudZ1M4SKBp605/OguHQPPr7ZFiHoGM/SSpdz3LTLyhVjERZZacL1BEQn2u8CpCGae+da4egoG1vCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=yc3o9Te7; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2dd7e56009cso32143591fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1713895095; x=1714499895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9B8eXcmZ97ONLTtCWWjVm+MKijPPu4vhRh0ro3qBaWQ=;
        b=yc3o9Te7o1q1T9NuPmYd2xd0TekiavwNYhjAndBweAyG38tJkqf3bObJTtimPaZLr3
         w2OCYGSigvpKV2eHxl+lh/5Rsh4sIsTEVXsps6d1tD4XdZC3520sIYvTI1LNjC1OQGfN
         UbgXeFRZq6MVKSjf8l7x64H0JD1IIKWq3hdZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895095; x=1714499895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9B8eXcmZ97ONLTtCWWjVm+MKijPPu4vhRh0ro3qBaWQ=;
        b=En8mIJgZFAkty+Ocfup/UZNx/HSgZyo0kKIgO6YNOQvyya4Og7JX49IRWZ0yFyquH3
         NGe3DoHbKHIka0LuZn8cNdT1z+b33uAg8p6+px1jk8mwYYrPWCXVG4vK0s0oU7f33PTd
         GAlEMVBW4uUvIC/Og1Sr71EcPQdNoS1Jq0Kxm4xjYEXIYC+mG85fHP8jt8YSB+79Rt+F
         e9UerK0V8GIY7hvmvth2le2oJ4bZJMCLQlqm9Y7t30d2lU+n5Bhg2UvZdhS9qe3B97y+
         rlGBxLPhcVLNt103hn8qRxLHjw842yMc20jEMrtwaB8hEnjm9d+O7Jk3lLpq6zGauKpT
         WSsQ==
X-Gm-Message-State: AOJu0Ywps5Z6Qwxz9VyLMttye31q316qa4on4lUl1TUkGUZLx62B8dqj
	JT2sXtZh+GA3HzD0+Y5IBe985U10s+U2TGOCYkZNs+AxIxad6Qw4PKixA3T9oLfVy3YZ1t45z8o
	cM1xsrT8/dCJD+UbBScszrwLBca3wx/v2TyZxJw==
X-Google-Smtp-Source: AGHT+IEnSc1tfYpb0PQBfoKjTLLEnX1cTm3AcRcS0BsoOJGktTKN63BmrVbfDjW8YbOgCbVr5RVxz5VwqMYdrMi/9nw=
X-Received: by 2002:a05:651c:c1:b0:2dc:e69a:fdbc with SMTP id
 1-20020a05651c00c100b002dce69afdbcmr8450ljr.1.1713895095197; Tue, 23 Apr 2024
 10:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407090558.3395-1-jiangshanlai@gmail.com> <20240407090558.3395-4-jiangshanlai@gmail.com>
In-Reply-To: <20240407090558.3395-4-jiangshanlai@gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 23 Apr 2024 13:58:01 -0400
Message-ID: <CAEXW_YRjuWMLvmZ_oVHEe837gPAyjBs5OMvZc=T1PXYB0apNmQ@mail.gmail.com>
Subject: Re: [PATCH V2 03/11] rcu: Reorder tree_exp.h after tree_plugin.h
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, x86@kernel.org, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <quic_neeraju@quicinc.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Zqiang <qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 5:03=E2=80=AFAM Lai Jiangshan <jiangshanlai@gmail.co=
m> wrote:
>
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>
> Enable tree_exp.h using some rcu preempt macros introduced in
> the next patch. The new macros touch core rcu-preempt fields
> and are better to be implemented in tree_plugin.h.
>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  kernel/rcu/tree.c        | 2 +-
>  kernel/rcu/tree_plugin.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d9642dd06c25..57d1ae26861f 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -5245,6 +5245,6 @@ void __init rcu_init(void)
>  }
>
>  #include "tree_stall.h"
> -#include "tree_exp.h"
>  #include "tree_nocb.h"
>  #include "tree_plugin.h"
> +#include "tree_exp.h"
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index b1264096d03a..d899b4afc21c 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -103,6 +103,7 @@ static void __init rcu_bootup_announce_oddness(void)
>  #ifdef CONFIG_PREEMPT_RCU
>
>  static void rcu_report_exp_rnp(struct rcu_node *rnp, bool wake);
> +static bool sync_rcu_exp_done(struct rcu_node *rnp);
>  static void rcu_read_unlock_special(struct task_struct *t);

OK with me, but not sure if the reordering of header inclusion is
needed? You could get the same results by just adding declarations of
the new helpers to tree_exp.h.

Not sure if tree_plugin.h needs to be included last, I for some reason
thought it needed to be - but looks like not. I found a thread that
shed some light into the header file including C code thing as well,
which may or may not help:
https://lore.kernel.org/all/8ab3ca72-e20c-4b18-803f-bf6937c2cd70@paulmck-la=
ptop/#t

Thanks.

