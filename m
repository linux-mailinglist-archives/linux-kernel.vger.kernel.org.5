Return-Path: <linux-kernel+bounces-92573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B02872262
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A9E283811
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C9C126F2E;
	Tue,  5 Mar 2024 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FudN8fMC"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36BA126F02
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651114; cv=none; b=A77j43Qee1GLQXSJ912CcP0v9DKf7GLSudAKA6iDy2/QO+sPVBJ5xJqVm7MQCaZKVHUSC2n2g/J4oEBqkrPujTvg7wPjmOiEJQOKgsqgoERjvSnQgQ0sY6kZZdscCQ6F1R2BvBRrHDhJbc6hIYQGbH61uOCdctXG4+9qbKyi9IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651114; c=relaxed/simple;
	bh=C6PdQLiJ0DVMBz3a97RhoxDIZXOu6aQNf22UIVlKvsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNQl6G7BRg87acmS6HT8esbOktaiOvJ2mRvdiFrTsnqghsZHhJf4LqnsX//lIQISaN3XmMGnlTgPTVNA3bz2LqqfTpDSTUwIT6B761S/dnJ0Wf0CzDx8Q1cmI2HQ29x+8KrDP9En7kKrDUw+h8LUstV+Bm/zuuH/+15IkOY6swQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FudN8fMC; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso4877900a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 07:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709651112; x=1710255912; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CY9ePlTsMQZsLDB5sNDMSa4N7bgq74vciIKCran/6p8=;
        b=FudN8fMCwS3FB+Oh7wB/1kwUxcF54/GQqyu+7+JHtNaQurgMXEjDWCGqATXhK68AoL
         Igr8iKGowjYBOnAYZxuJFYPqSs+NBLxkShVOQxQlbN5pMy8VQZZB7/KH1HgoykE8m9y6
         5rkotJrlGtPmOOMw748vlLI5MCr85nHR1d6m83oSEpNvE7pr9C/83YL9Wj5H2MKqtxCu
         Bap2wnlZSQb66SSSJSACGAWqTgLtPgtE9EC18fQfWNKmoZfWjv502jN4NqbaOytmffXf
         3KZwdxX+6XxbhExYmtgvnExp2bFlmGiieWLWidaKIsdpv5I2b6E8OwsXz5uXVvrenACg
         /CGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709651112; x=1710255912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CY9ePlTsMQZsLDB5sNDMSa4N7bgq74vciIKCran/6p8=;
        b=AsvjfxJBHVEQHmYPg7+IxKCyivvnUMtqHaCS/PzebSka9GHLNeN3upHZ0RXMmQW719
         wnKuf410irUTLDbuknC6yN9I31spYW09V23zF9YW4Qt4s09keRvBmSOOYGYaOPjtBCQh
         TMeQVZ38kOQ+LEvLiAaH6BzmAkiIWG5HH3aj59VZ6tw+05ENw4GgLJ1ldFIamRGmOFWF
         1ondn0AACFh3gECyW/8L4snnR6Mj3AHAVLeO7As6vE2G7RoJzV94Uodlfc1loUJHnrIA
         nkTw3plSX5aLZmHyCTv5X8w7Mf5P69hQI8wZ1mmt57QUvmMuyWiafl5k1iQPs6v4zsP8
         ONuA==
X-Gm-Message-State: AOJu0YzNsIeLgTqdjEDzTQIMUs3/Mp3MpjItHphuxxp/Xpk46/h6Pr6M
	u+216HTz+V9Edzlozhe0g5USpu2mw9jonbKPpq4kZt7/r53UGnnF6bVQXCXinQP57gGV0iFv9n2
	dqX/Ftw6kq3z0du+UuunmM8ukkY8mOpuxmD6teQ==
X-Google-Smtp-Source: AGHT+IGje7+EK7kxbVLayc4vXIhORPovpXVwiLGAB4YMgQaczmiFmXsgP5U5949kdlKdY0ZJ0g6Q1RFXAqZJ/erhrFQ=
X-Received: by 2002:a17:90b:4007:b0:29b:595b:f672 with SMTP id
 ie7-20020a17090b400700b0029b595bf672mr4522520pjb.31.1709651111971; Tue, 05
 Mar 2024 07:05:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305095111.777525-1-christian.loehle@arm.com>
In-Reply-To: <20240305095111.777525-1-christian.loehle@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 5 Mar 2024 16:05:00 +0100
Message-ID: <CAKfTPtC6D4RTP3T8tqEJKA1drGbAANOaGPKqmELd1G8TLocizg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Remove stale FREQUENCY_UTIL comment
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 10:51, Christian Loehle <christian.loehle@arm.com> wrote:
>
> effective_cpu_util() flags were removed, so remove the comment part
> mentioning it.
>
> commit 9c0b4bb7f6303 ("sched/cpufreq: Rework schedutil governor performance estimation")
> reworked effective_cpu_util() removing enum cpu_util_type.
>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/fair.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 533547e3c90a..6b0c47d00fd3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7849,8 +7849,6 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
>                  * Performance domain frequency: utilization clamping
>                  * must be considered since it affects the selection
>                  * of the performance domain frequency.
> -                * NOTE: in case RT tasks are running, by default the
> -                * FREQUENCY_UTIL's utilization can be max OPP.

Yes, it's no more accurate.
Should we update the comment instead of deleting it as the effect is
still there ?
 "NOTE: in case RT tasks are running, by default the min utilization
can be max OPP."


>                  */
>                 eff_util = effective_cpu_util(cpu, util, &min, &max);
>
> --
> 2.34.1
>

