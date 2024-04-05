Return-Path: <linux-kernel+bounces-133581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B5B89A5F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F711F22273
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F5A174EF9;
	Fri,  5 Apr 2024 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="synrOl6z"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F212B1DA32
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351524; cv=none; b=JuVG2QnHoqexgn+zko41e8J96zx1VC79gUdoUDCin1T2qXmMmUjTYYfKV0/y/wsiwGhuspTo6lc0FT34+Dp00+ZRAZtYq35qJlHwba+iIlYvdOdWz4ZBTY+ngbliPEkh2Mq5izeAp+Ys19TwMtPp9QUWym7HLWM0YNEmJFzdhn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351524; c=relaxed/simple;
	bh=etGcceYyj73Mq7eHwc/i3lQnXWb9e7CPjfKQ1jt8WpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ovjKm0Y/fWmUfXIFJBIgedWxaTtd2jBWJ84sxhXIHAIhW1eZIXwmtuMmTYsyXPQNPJpeSd9uzh6j9Q3UptiIb5WfPP6tGaSL1nPlC1Ul/7v1FlRl/8s7rqzQ0+KDUnzzDKo0DVbxkG72tpCCvpadK1GBXPJxGGnbsukmpmrUJGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=synrOl6z; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e2b728ffa3so12115ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 14:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712351522; x=1712956322; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rk9OtJSbXo5wYmw5m6uC9ppOoGN36uVqXM/VVExKLUo=;
        b=synrOl6zqr7lnkdJ00KmD5txCBFUbV7KUqyN458UJx15NYK7Cg6IGULEs37jgQ0zT0
         xs5nyfSgVLWL/xEZ8qhLan+zrFa+//9zHh+p8FaCn9qmSFd3QKwiW5EMy3rP8j5P91dT
         29xDbTSwuulatFJTT3Cmsgs5aloj0TqrXuvY64X6NjXE5In8F93mOb0QwCDX2JyriuBe
         WD2nDssEzvNryNq0OU3bFLLt9x8w+4ao2WgRCtiV3iPbVKTcyrkn4T659d9uGWeZhDkp
         BnBOrNmNJTTcOh/oPGmswUs8gIBtGXDD1/V8NdcOACFhZ2evDWwLwFSftAvfSw1eBG9m
         JMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712351522; x=1712956322;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rk9OtJSbXo5wYmw5m6uC9ppOoGN36uVqXM/VVExKLUo=;
        b=jfD/ZZOMOEHNNBBY9nSGNbw5CMQGjnr5nLJUZ9b2knB+txA/oOdzSxz5H41GmoexXh
         Dkpwvu0L6/Ib9T7pxg0TNwdG4EULTE0my6TVba825JjW+H5+rmLYws3CtFYmQTehvOrZ
         wyGUPnNV8dPw03noLIZ3iaRydMFjo7uue/99vjqhGR8wgt64Rw8lKO5wWwldGECqAWSc
         /RV87yitsY7qjLQz+HhfOzMrYVFwVPf5wVB6HWe8LdHPC33feYqpYshxOPVZcbA8/BuN
         cTOHtbohbuCkd9V3SvEBJWTWyao7l9OAaYEK//oElZwHd7bfXdXzDmiAa507ZIbjrc0m
         qZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl9dZiLpKRq2QzPB6tvVwghFSvgyicnS18yad6GDsb/2kO/OQbailEkA6JtDnoXM2QOnYtFTZOWEaE4gKzssOunZoV5PCCN/Hck/Aw
X-Gm-Message-State: AOJu0YxrbOXnhFwHBRR7AOFPc+97gNts4u+fkjxRupP0303AEV0Lmrse
	GATBqsH+VMLS/Q4IH4xJXdj7WkiM2ETsD15I6eBksN0w+EJ471t/KY4muRZBsA==
X-Google-Smtp-Source: AGHT+IF0dZLuoxHZvNTWvEd6tiflqLZN9eBrMsDNjI1WGvKExPfPORZcpum0QBw9JB2GHCBhwq8PjQ==
X-Received: by 2002:a17:902:db01:b0:1e3:d0f0:4623 with SMTP id m1-20020a170902db0100b001e3d0f04623mr12247plx.17.1712351521944;
        Fri, 05 Apr 2024 14:12:01 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id h11-20020a63210b000000b005dcc8a3b26esm1861016pgh.16.2024.04.05.14.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 14:12:01 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com,  juri.lelli@redhat.com,  vincent.guittot@linaro.org,
  dietmar.eggemann@arm.com,  rostedt@goodmis.org,  mgorman@suse.de,
  bristot@redhat.com,  vschneid@redhat.com,  linux-kernel@vger.kernel.org,
  kprateek.nayak@amd.com,  wuyun.abel@bytedance.com,  tglx@linutronix.de,
  efault@gmx.de
Subject: Re: [RFC][PATCH 03/10] sched/fair: Cleanup pick_task_fair() vs
 throttle
In-Reply-To: <20240405110010.024746026@infradead.org> (Peter Zijlstra's
	message of "Fri, 05 Apr 2024 12:27:57 +0200")
References: <20240405102754.435410987@infradead.org>
	<20240405110010.024746026@infradead.org>
Date: Fri, 05 Apr 2024 14:11:57 -0700
Message-ID: <xm26zfu7ecpu.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Peter Zijlstra <peterz@infradead.org> writes:

> Per 54d27365cae8 ("sched/fair: Prevent throttling in early
> pick_next_task_fair()") the reason check_cfs_rq_runtime() is under the
> 'if (curr)' check is to ensure the (downward) traversal does not
> result in an empty cfs_rq.
>
> But then the pick_task_fair() 'copy' of all this made it restart the
> traversal anyway, so that seems to solve the issue too.

Yeah, putting the check_cfs_rq_runtime inside of that condition was
specific to the exact pnt_fair code, and the specific places that
nr_running was and was not checked. pick_task_fair doesn't care about
any of that, and if instead put_prev manages to throttle the picked
task, we can still successfully switch to it for a moment.

Reviewed-by: Ben Segall <bsegall@google.com>

>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/fair.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8435,11 +8435,11 @@ static struct task_struct *pick_task_fai
>  				update_curr(cfs_rq);
>  			else
>  				curr = NULL;
> -
> -			if (unlikely(check_cfs_rq_runtime(cfs_rq)))
> -				goto again;
>  		}
>  
> +		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
> +			goto again;
> +
>  		se = pick_next_entity(cfs_rq);
>  		cfs_rq = group_cfs_rq(se);
>  	} while (cfs_rq);

