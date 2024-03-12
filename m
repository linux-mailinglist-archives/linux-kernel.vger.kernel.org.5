Return-Path: <linux-kernel+bounces-100292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEDB87951F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EB2CB21B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7927A72A;
	Tue, 12 Mar 2024 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQvwX6kd"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354AB7A71C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710250190; cv=none; b=AdIdPdzUwLbLoNWOFFZzLGjNQmZ7iDIa5VFOtMKbmxQgSpnJNzwPMu7pcO5sl4gBom2Iqfhh27mwsWsB0qjntxScGeSgjPUxYuvDvGmo4RipfKbFXkj17resfPCgqu6+5sho+yzqWEJeLYXdj0BJC6ofs5np9+pKPzkm/RbpzYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710250190; c=relaxed/simple;
	bh=CeQUf6duqfcgE2UiAog44q2605GN+QLpjdFo2IcF8Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSGenfJgyIzr4RQpmteswSPQt8tYOfX3LhpurjaVNXfYgtG5UU4ifPxECX7qS2huUvMczzbxAAb2Pfckoq5kEWnfrjSGqt11/QHP2at7U40xic4MIirlBaIwax7dbBN2pyB03rXr1JYWbKWfqxG3u1G9DhHU2CS4+Gl2I9hgYXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BQvwX6kd; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29c4fe68666so177618a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710250188; x=1710854988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GEpybsUIu7Ie6lckJfM0SLnsbZaN3ghhlo+SnNx7CE0=;
        b=BQvwX6kdBvEdDbKIhQFSzlSouVWurAVw0Vig3PDR+NMpLaeToQZiskiv390KmSOEfm
         zNegYTeuOhkaxM7XUNchX7g1ef4vYaWYTFTVi9Kvt0p3I9Rnl/Bb4/eyJd+FuFoKKq7O
         YYY+tHXas2NZTqb4wyGVz+PEFu6wmAaJz33QnJbbtFHONwhy/YsIJK9cyOLIbk8a9V5Y
         0AOkUOARmpyg44ERfan7EES+3hn0XIT1boBcsJbo4+YxrnGhbCs9+TDiOgWNn+adBpJL
         ALZtTsb0C5RKeizoBMn7VzVTpeDVE6IhZovMgIJrbI/AfrfzvcONJimOsKq6YgP0IrIb
         cmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710250188; x=1710854988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEpybsUIu7Ie6lckJfM0SLnsbZaN3ghhlo+SnNx7CE0=;
        b=tVr4JIhK/NEZzEVWYIPWnoWspl2Sxn3RbHuhJ8yqz0hBRZPGlm1FaUyG8ZXqPZW3vK
         gtpJLUnrRLN1cLrRyMwxOrQKtLxI2ye1dzBvWZSQoDX1Ct7np1/vGsNh6JWj06OMxY2V
         EW/en0k5IWCqaxs2ulJxEvKZikr55Io75Ws+bi8PgZrE6MiHCFSHJajmUANOI+G4gAyb
         0/3A/u4655OftH2f3qfPv/VSC87oco1NjIIs0QBZJgA12c6cR5HIpotFmRkn+d4Nn85+
         RSllIp3eI1uIVSMEQoVjk3a0Lf9uqw+G/oY4j0czmL+4RKR404mEXLWjyO7+ar1eWiOK
         KH+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOwxbEiQt3WrsVTZ+hhDu2Rk3tFrHHeOSi7DVQihi4gyGCRoHxM8fU7VV3DlO3NZuZBNwDBZbZR/d4P2EWSrsGQbT0TiJijHg5XVFv
X-Gm-Message-State: AOJu0YzL33WNpX5oOOnJ4yHbK41uf6/hUTyQUVnlUpVQoh9fAk8U7z9Q
	9r2BHaYpOHGa0Aezeg0hXiDzJlExZtPQAjJ3D7DYt2/jTtnaaO9sUKACXJNmEK/49z9z17H8fK1
	bi/runw1QWzuxm4BhYQKvsynhsN9nQqpu5Bqmtk/N1hF10cMhKJA=
X-Google-Smtp-Source: AGHT+IEOKVXB/sYjmsJkpYkH4NtqHv7IijuWxCyStTO41Lztb/c8UsJbZy0Bun8lpCHIIB1tD2aJmPaCOAADj8YTAz4=
X-Received: by 2002:a17:90a:d906:b0:29b:2eab:6bda with SMTP id
 c6-20020a17090ad90600b0029b2eab6bdamr337869pjv.35.1710250188368; Tue, 12 Mar
 2024 06:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308202209.2452-1-daweilics@gmail.com>
In-Reply-To: <20240308202209.2452-1-daweilics@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 12 Mar 2024 14:29:36 +0100
Message-ID: <CAKfTPtD+sN+ADsxNcyVddk0MAMSkGMtM1E91Fie8dGysL=SCDA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix initial util_avg calculation
To: Dawei Li <daweilics@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 21:23, Dawei Li <daweilics@gmail.com> wrote:
>
> According to the comment for post_init_entity_util_avg(), it seems that
> we are assuming se->load.weight has the same scale/unit as that of
> cfs_rq->avg.load_avg.
>
> As far as I understand, se->load.weight is the scaled-up load, instead
> of the true weight (as mapped directly from the nice value) of a task.
> When CONFIG_32BIT is set, we have load == weight; when CONFIG_64BIT is
> set, we have load == weight * 1024. However, cfs_rq->avg.load_avg is
> the sum of true weights of tasks, as se->avg.load_avg corresponds to
> the true weight of a task.
>
> Based on how sa->util_avg is calculated in the code, we could be
> inflating sa->util_avg by 1024 times? Could this be the reason why
> "However, in many cases, the above util_avg does not give a desired
> value. ... "?

No, this is about the fact that this estimation of util_avg can give
insane value because even the correct se_weight(se) can go up to 88761
whereas util_avg should never go above 1024

>
> I'm not entirely sure about it. Posting this for clarification and
> comments.

Good catch.

The commit message needs to be updated to remove your question above
but otherwise looks good

>
> Signed-off-by: Dawei Li <daweilics@gmail.com>
> ---
>  kernel/sched/fair.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6a16129f9a5c..0d13e52e1a92 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1031,7 +1031,8 @@ void init_entity_runnable_average(struct sched_entity *se)
>   * With new tasks being created, their initial util_avgs are extrapolated
>   * based on the cfs_rq's current util_avg:
>   *
> - *   util_avg = cfs_rq->util_avg / (cfs_rq->load_avg + 1) * se.load.weight
> + *   util_avg = cfs_rq->avg.util_avg / (cfs_rq->avg.load_avg + 1)
> + *             * se_weight(se)
>   *
>   * However, in many cases, the above util_avg does not give a desired
>   * value. Moreover, the sum of the util_avgs may be divergent, such
> @@ -1078,7 +1079,7 @@ void post_init_entity_util_avg(struct task_struct *p)
>
>         if (cap > 0) {
>                 if (cfs_rq->avg.util_avg != 0) {
> -                       sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
> +                       sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);
>                         sa->util_avg /= (cfs_rq->avg.load_avg + 1);
>
>                         if (sa->util_avg > cap)
> --
> 2.40.1
>

