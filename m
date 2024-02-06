Return-Path: <linux-kernel+bounces-55636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD3484BF4F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3111C1F24A66
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8161CAA5;
	Tue,  6 Feb 2024 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="K+jYPpOz"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860DF1BF3C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707255415; cv=none; b=ssS0MULZcUzUY+5ifUbzejJKsdWlg6Mt5XvXOu1KpPheN0GJ+yps0yWxFJd/JJY5vIsLkIwSDAHPSbl9k9K+NEK8qk91moNe5GI9F02k/jMG6DOroO4C4rtUn63jr5g8u/VoHnR8S77czgruuGGHoj2kfwYk4DpR8ZjhSEGQ5cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707255415; c=relaxed/simple;
	bh=SPUSboqfAbrFxY9EJpeosQthLvWmlOFIoX3OnhXn++g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ODZRfRqViSn/JaHlXX6I360cbn8xNOuC/AzHENkk/UUPTeLzFEoHHHBOQda/0GcBAC8FygZhVp9Axq1gSa8ay6Pyp/MFc0Y0TPLq0u3jHRPkSGBu+mhZhxe8vitDxeo7YPGdtx/9RezeOsjvskN1HN7pfcvZEVuJI5ekc4B6dqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+jYPpOz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d9daf74f41so7015ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 13:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707255413; x=1707860213; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k2qT25B0DgnlX6C0JDCUm+O9w7MCSG/bkLIALlP9k7I=;
        b=K+jYPpOzyWtpxemxwBiaEX5bFB0KuBTpWai2Q76eVooS5mWe+7bPbjGTAqAo/2JT5N
         1C/30PXbHcsV2dGGYQF5mref43YrzD77e8NxDgtYYh/RJAMpYyG6bwgds4Iz3Nu9hZfv
         bZ4FrfoNBjp1vbNM/bj8ZOfEGjIubCcWkkL8hTHCY4KU0zMLWq1bET7AH5XcmKOmyyFi
         t15ppKB9ebpvnysiC2kevFVNGQGsZpcAZJy4n3H1pwaZkE6hIxDmcHTZgi7RBXqaBbwH
         qknQwYku3hvligh0fQyI7QU0dJpdO0kh6Va+eVodNYOTyeZy1NRX1CwgdKeb02oAfX+k
         sRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707255413; x=1707860213;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2qT25B0DgnlX6C0JDCUm+O9w7MCSG/bkLIALlP9k7I=;
        b=RbOYV4yFJ7IRZyERtUhoVhTv1e7DGX+j1xBP7JBw8wGsrSRxm/9Tn/6eIwyzIfVLq+
         Y/ef0WcTmsnpb1QD5g7+84B5dPMzvJa0z7GpY5oUBJGBixcoWO+ZvhW8UY7sN+SbamYP
         PuHzY7UNgKNBQw08nqCtj/5Ur3sfMwAuLQXWfGEVlVYOPgnz3umAkoEUBTkTztLnBcw/
         PP0YX5rpTLbg4WREyacNOl4GQF9mDvZwXeqfWTpwAzdhw6+32pzFXs3twBQ4AwDEgAe3
         kSTtMcb8Off6RlSi3gky361tmkIOedAiJ8dAO3oSn9reuWfg8oyH5vnTm9JuX4KZVZMJ
         10SA==
X-Gm-Message-State: AOJu0YzwIRwt2w9UOV5MBrxe4V0nlszXd3+BSLRJ+pngAK8QBLpel0cE
	v6d0Mmi8cpPl3ILsb2I/3771c4wbFqaj7S0w/QmwQHzmuPrmbDv5ObEt+OkWLw==
X-Google-Smtp-Source: AGHT+IGhXwtuQ3Q4xGMSmgkMfbVgv9ps+YSTKuPI2GoIxQ6BQpKb23gubt0afraaP24iUyo99LBZkA==
X-Received: by 2002:a17:902:f68c:b0:1d8:ca49:53e0 with SMTP id l12-20020a170902f68c00b001d8ca4953e0mr68648plg.18.1707255412641;
        Tue, 06 Feb 2024 13:36:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUH0OOHeZXk8wfPtpLl6unQSV+q+jdAX6ZQaWAqvT6iqrvCs96ZwLjYg9ZOqEm7xfxs7ULV/PDCnia1ZpT64dp0aeSMVZ3oCEPAXS2y69y76kJgZflUF8QPO8Ikj7bI5LLh5Y02tMJE1+EjiK58YW9rAFaOC90GQgFdKKHLMchf6xmYLfA8mK++nRL8l6vGcLR2V0QRr0N1WUP8bbzR9MsOmI+rWZ0DldsPUqoAseyYXbtgggWZ2qoaKY4AyoUWHnTZQxHVD3YL2S7sZQUDJW/9qPuNO8AiOFM9eucGbF+6YiRfmnjGNcm35mBBnbU3PSyTRZhf/bKNuQZQ+d9c0SN6czlCcN8gpVqKKxgqo/Jjg46K/34rnl6X
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id k138-20020a628490000000b006d0d90edd2csm2562391pfd.42.2024.02.06.13.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:36:51 -0800 (PST)
From: Benjamin Segall <bsegall@google.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,  Ingo Molnar <mingo@redhat.com>,  Peter
 Zijlstra <peterz@infradead.org>,  Juri Lelli <juri.lelli@redhat.com>,
  Vincent Guittot <vincent.guittot@linaro.org>,  Dietmar Eggemann
 <dietmar.eggemann@arm.com>,  Steven Rostedt <rostedt@goodmis.org>,  Mel
 Gorman <mgorman@suse.de>,  Daniel Bristot de Oliveira
 <bristot@redhat.com>,  Phil Auld <pauld@redhat.com>,  Clark Williams
 <williams@redhat.com>,  Tomas Glozar <tglozar@redhat.com>
Subject: Re: [RFC PATCH v2 3/5] sched/fair: Delete cfs_rq_throttled_loose(),
 use cfs_rq->throttle_pending instead
In-Reply-To: <20240202080920.3337862-4-vschneid@redhat.com> (Valentin
	Schneider's message of "Fri, 2 Feb 2024 09:09:18 +0100")
References: <20240202080920.3337862-1-vschneid@redhat.com>
	<20240202080920.3337862-4-vschneid@redhat.com>
Date: Tue, 06 Feb 2024 13:36:50 -0800
Message-ID: <xm26jznh2s25.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Valentin Schneider <vschneid@redhat.com> writes:

> cfs_rq_throttled_loose() does not check if there is runtime remaining in
> the cfs_b, and thus relies on check_cfs_rq_runtime() being ran previously
> for that to be checked.
>
> Cache the throttle attempt in throttle_cfs_rq and reuse that where
> needed.

The general idea of throttle_pending rather than constantly checking
runtime_remaining seems reasonable...

>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/sched/fair.c | 44 ++++++++++----------------------------------
>  1 file changed, 10 insertions(+), 34 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 96504be6ee14a..60778afbff207 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5462,7 +5462,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   * 5) do not run the "skip" process, if something else is available
>   */
>  static struct sched_entity *
> -pick_next_entity(struct cfs_rq *cfs_rq, bool throttled)
> +pick_next_entity(struct cfs_rq *cfs_rq)
>  {
>  #ifdef CONFIG_CFS_BANDWIDTH
>  	/*
> @@ -5473,7 +5473,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, bool throttled)
>  	 * throttle_cfs_rq.
>  	 */
>  	WARN_ON_ONCE(list_empty(&cfs_rq->kernel_children));
> -	if (throttled && !list_empty(&cfs_rq->kernel_children)) {
> +	if (cfs_rq->throttle_pending && !list_empty(&cfs_rq->kernel_children)) {

.. but we still need to know here if any of our parents are throttled
as well, ie a "throttled_pending_count", or to keep the "throttled"
parameter tracking in pnt_fair. (ie just replace the implementation of
cfs_rq_throttled_loose).

>  		/*
>  		 * TODO: you'd want to factor out pick_eevdf to just take
>  		 * tasks_timeline, and replace this list with a second rbtree
> @@ -5791,8 +5791,12 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>  	 * We don't actually throttle, though account() will have made sure to
>  	 * resched us so that we pick into a kernel task.
>  	 */
> -	if (cfs_rq->h_kernel_running)
> +	if (cfs_rq->h_kernel_running) {
> +		cfs_rq->throttle_pending = true;
>  		return false;
> +	}
> +
> +	cfs_rq->throttle_pending = false;

We also need to clear throttle_pending if quota refills and our
runtime_remaining goes positive. (And do the appropriate h_* accounting in
patch 4/5)


