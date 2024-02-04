Return-Path: <linux-kernel+bounces-51611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CED4848D34
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D051E1F224C6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA27A22309;
	Sun,  4 Feb 2024 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJqmGnWi"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D42622081
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707047132; cv=none; b=Xa8OftqYfhdrZVZAcixQsPE3VzbMfkBDTUZdM+jGczmYl6lhrteJaW+PbOHyAYGyQzf2aXIEbDvs7CaqmPCcS3uQLoReywwQMavZk/4MgckQEJYPyZhzeFdMqqVHjD1Hr4lB86qzg4b8tw86QzprjyGrMeFzblRQnL1XYLGIRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707047132; c=relaxed/simple;
	bh=XR83UQlwxz6s5+olPT6yncgAKlHegp9awIw+AN/9VJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7iGc+kwrEuAInV4vPuciPD20088zePAgJvMvNcFIJuz1ZwvIq4zJnSV3f3RlIlxme9k9iO5slwanrilYhKnjwG4s+2sPCWqtSZKS3S13ImZQnawNi12qz1uyyFrVHdgP/1FXvl2YESnNs6Q/Issd9dLh4jVC9DQ8u2PeMrjBrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hJqmGnWi; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-290b37bb7deso2888200a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 03:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707047130; x=1707651930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3rkWxkZIZnZS6vY+tGpyDAUE64mPHdya01WcnVrnuEU=;
        b=hJqmGnWiSGKsObJ17nQvT2TUvf++PC+WopYLn2Qea5ly9WIx9XDVYhOU5iS1NsMlyh
         RLPg7i0tqXZTKwSUTi965ARrGK7sQuZ8XCH9erhHXDkeEx+ip94KNEeHQp8HQKCzCUiO
         bdqP56+70M9K5ll8dA43vSOxY6OBTfZiZ5dZWjfMnvVphx9aQX73oxy7kRS80kmXDA0d
         mMFXo8HyRnj9vmq2v35b5ju7E20YMDNrWA1pV0ZDGsgXFOK31+X7ofbcpRHt4YSJqLSy
         PQFV4EqETn8B6sFcE2D693GR6vLBv5xt8g8ZPj/soQAU4x8jyFf0anaKehpQMYLK2cz1
         i9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707047130; x=1707651930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rkWxkZIZnZS6vY+tGpyDAUE64mPHdya01WcnVrnuEU=;
        b=BhuuxRpkyid0CERLqZiH/E/wpzyi85aOArJ5qPHGUiTGpsbT9614W/mli+J5CnkSEH
         u9XQryX26IrM1m5eXl6UGIDLXfDaIvqcTKUnH0QdCDBO20dpCy4/mgNZqzeG8mkZkUhr
         5WigEw53EOwdhLN4LxFrCfTgzR25viQwnQ0Pd1Fx3Fep4Vg3RuGKO7XwmXJ7qPLRzUgk
         6FUdq2WqOB2RWwDkUIMVFtZmkiqf+DEm7wF9uS6tbU/0Q2xtWMN8j7Dt2XS4rVNVAm8z
         aoRStuw8RUjhlDTZAxMSMC5dDmvJ6QjXV2EOykjqwplgBG7WRKRlR4VI5ilMinrAGlji
         Ut2A==
X-Gm-Message-State: AOJu0YyZRH/gCzyiEDH8ZFkg2YrIb1MdmYJgqyVVVJwt3gfSaFLM+CsE
	5wJKbVhdc64KQVKUNibScJ0gncu2ucDEgA/Rj4InhRfFcZJ9wpgS4Ao1mPZakN5wApo57k9I0DQ
	z36upl+nREksVfvThZwbaLzvSYUwuP6phcawI4w==
X-Google-Smtp-Source: AGHT+IFQ956jj3duj7CC1HL8RzD/3WY3ppBJ8h9We6XCfshFDd2wvtLUPw57DbwDftTOs83VDBkgckb8iXKe0MVmm38=
X-Received: by 2002:a17:90b:e0c:b0:295:d722:a420 with SMTP id
 ge12-20020a17090b0e0c00b00295d722a420mr6260158pjb.6.1707047129757; Sun, 04
 Feb 2024 03:45:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204044618.46100-1-void@manifault.com> <20240204044618.46100-3-void@manifault.com>
In-Reply-To: <20240204044618.46100-3-void@manifault.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 4 Feb 2024 12:45:18 +0100
Message-ID: <CAKfTPtCGfUSa4trbCPnbhDqwqM9jL-qpfg=_E6G9amRuhm4NHg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] sched/fair: Do strict inequality check for busiest
 misfit task group
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Feb 2024 at 05:46, David Vernet <void@manifault.com> wrote:
>
> In update_sd_pick_busiest(), when comparing two sched groups that are
> both of type group_misfit_task, we currently consider the new group as
> busier than the current busiest group even if the new group has the
> same misfit task load as the current busiest group. We can avoid some
> unnecessary writes if we instead only consider the newest group to be
> the busiest if it has a higher load than the current busiest. This
> matches the behavior of other group types where we compare load, such as
> two groups that are both overloaded.
>
> Let's update the group_misfit_task type comparison to also only update
> the busiest group in the event of strict inequality.

fair enough

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e7519ea434b1..76d03106040d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10028,7 +10028,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>                  * If we have more than one misfit sg go with the biggest
>                  * misfit.
>                  */
> -               if (sgs->group_misfit_task_load < busiest->group_misfit_task_load)
> +               if (sgs->group_misfit_task_load <= busiest->group_misfit_task_load)
>                         return false;
>                 break;
>
> --
> 2.43.0
>

