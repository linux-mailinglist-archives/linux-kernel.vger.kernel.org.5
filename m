Return-Path: <linux-kernel+bounces-97084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E23A876546
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46CE8283552
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B457364AB;
	Fri,  8 Mar 2024 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qna8pR9R"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6E33BBC1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904389; cv=none; b=rT3GbY8AKM9B0D4MyvxY1NLWOaqY7BzDOFMHS7EJsCvxGSt8Yjt4ykjur1Uxguoxz1ciKddzBIhE4lvMV2auaTQsZ4h5s7EdjKDInL0bVJXOqtQ9mbNCpcSFePCOhnx681UsmeLshJ0AeBv3WXNgq5/QariOAvkWfw89sJE8WAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904389; c=relaxed/simple;
	bh=T4mgYWIxiTfuwZ09Vexg+mUkAPMYEV07jO59q4ZGk9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7WfDtICfw/ku3y2dr/n9zcXsdu/Pi1BtsYYp6C/K5QeE05PXuVpPuNsVo5dKB1y44UbHPjqVclBgF0CsyHnfGZZHDKsDB1j5F/huRKMuU9jKQwecSvrGuv1l7K7PoBJlmWlyDq3KnWMyYB2zpukoRrB8GrnGXuOK4EAS/N+EQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qna8pR9R; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso552235a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 05:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709904387; x=1710509187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SZUX/MJM+g7s3/c5nEwMVnxHOynzt0A7HHdgK/jj9I4=;
        b=qna8pR9Rxeyg/t+ZpuvWcB3E3EELhCKmg8PR7hzCSuvj0jmMHYwRwuoEAdgcqLUyUY
         Ggm448aNZZEnMZciTJIudPq/bMj5Is9YjgOErhiyUvpW4Ehn6g84TzV/YpPnUy8Ax+yD
         t5Pv4/XkOTs0G6X6mCI98Gf/wQpTWZBdf14LaulkSSWh7lye61x2vwdUnRH6lSnhId1c
         2wlQgWBl7oa2xcWy1Ol3RQTyOm7EQrBEl0PDOFr5+ClCdTigNo6rRaXeEwEtLdpQjmXi
         kRxWVhUKi05xfWi/TSWiFwoKxHGMEMdV7WsxBF/Y/c56QtDCHJhjnb9hO5hLgTtHh55W
         GC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709904387; x=1710509187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZUX/MJM+g7s3/c5nEwMVnxHOynzt0A7HHdgK/jj9I4=;
        b=JxSb0Gvkx6LYH8WvAxG37HQRLAlja9otHNdDIMqyGfK8f2KBOi69tChGpLyRdwqEwm
         rvyqn2a+2VV/6DYbdLaSbJXoIn2VhFyuobu2Yo8JsxMye4y1fGnFvh4FREYvYGQNZXuE
         +vv8n5QSZwY6fir2gSSGa2ceHDy+A2IKcnY83Y7F0K2W1KHbg23SWT3j+dUgpPdwxzM7
         JeIv/H8HMDTyTpTPZ1qnIGlIpFMFeqTrI/Z1m+zCzZ+0u9IE71k5J0oXx4ZSeigfelRe
         /psVWtV+Im0SaXuBfaPd4liJUaqM3DZO6ZTdTS6dq0GVzAO95h2w6JVxKIjnf11/Lp3p
         K39w==
X-Gm-Message-State: AOJu0Yzz4bAyzbvZV4PDjzVF5fwnY4qvUWx0MDqAGhseVdFWtvAhNtI/
	NQ/mF1+vCv8Ii8ZeXEu2L15bvfbnFrR/ptWo26yiI573ihBBuycgE3YlxNp3XH9GueD83WudNsB
	MkZFHpb3mDfcN0EUZWFgpDAYpsi5vTpJSPJkDpw==
X-Google-Smtp-Source: AGHT+IGFMs0YCfp4JUyIvx5B4iy48/FVoDLSrjIhZkglbFujXNqbl+4cjA1ozadZubPbn88RffAj1ozMNmSHIcr7OGc=
X-Received: by 2002:a17:90b:249:b0:29b:c1af:ffca with SMTP id
 fz9-20020a17090b024900b0029bc1afffcamr95468pjb.31.1709904387269; Fri, 08 Mar
 2024 05:26:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308105901.1096078-1-mingo@kernel.org> <20240308105901.1096078-3-mingo@kernel.org>
In-Reply-To: <20240308105901.1096078-3-mingo@kernel.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 8 Mar 2024 14:26:16 +0100
Message-ID: <CAKfTPtAFQZHxzgju2As6qAmi+VxWk1H_5L44UX+XcbqYHSneCQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] sched/balancing: Remove reliance on 'enum
 cpu_idle_type' ordering when iterating [CPU_MAX_IDLE_TYPES] arrays in show_schedstat()
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 11:59, Ingo Molnar <mingo@kernel.org> wrote:
>
> From: Shrikanth Hegde <sshegde@linux.ibm.com>
>
> show_schedstat() output breaks and doesn't print all entries
> if the ordering of the definitions in 'enum cpu_idle_type' is changed,
> because show_schedstat() assumes that 'CPU_IDLE' is 0.
>
> Fix it before we change the definition order & values.
>
> [ mingo: Added changelog. ]
>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/stats.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
> index 857f837f52cb..85277953cc72 100644
> --- a/kernel/sched/stats.c
> +++ b/kernel/sched/stats.c
> @@ -150,8 +150,7 @@ static int show_schedstat(struct seq_file *seq, void *v)
>
>                         seq_printf(seq, "domain%d %*pb", dcount++,
>                                    cpumask_pr_args(sched_domain_span(sd)));
> -                       for (itype = CPU_IDLE; itype < CPU_MAX_IDLE_TYPES;
> -                                       itype++) {
> +                       for (itype = 0; itype < CPU_MAX_IDLE_TYPES; itype++) {
>                                 seq_printf(seq, " %u %u %u %u %u %u %u %u",
>                                     sd->lb_count[itype],
>                                     sd->lb_balanced[itype],
> --
> 2.40.1
>

