Return-Path: <linux-kernel+bounces-118532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846FE88BC39
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0FC2E2296
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEBB13341C;
	Tue, 26 Mar 2024 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k5t1Hqh9"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E164C1CAA2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441599; cv=none; b=Mg6V+9pa0HywZwSpRob0DvwQ0ECAMFLlJLSYnUMnQRxKsEFnb0oHd9utOChnXcv4Ztkf+BPpO5l+AIhXXsesHisAn8aRp/TkPP6QTU0I1MZD93luQuzybA4+b1WOREsCtqyYlJGDWH56OXcqAv6Jh9F0DNqNz1Qk/plxfNCiDUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441599; c=relaxed/simple;
	bh=uta7yJqyJgVGP1W2oY6+EHfQSP0GZXi8K9+J3DxkzFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEl9NdubdAfmE7h+CmIKqnNvYzmP+I5MU8rpPWHsR8dT4lK17ZyUyJkXb2ge0QDw4oxWiuOPqBVSPcfjtQXKeqPLhUSNKXBOoaJsJ3gxInywMyGclLMg9nPYsrEfuDJ5b4/0yrjeF7Jd/7iDSV8robpcryka5nmvx0ZL5AKrZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k5t1Hqh9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e0edd0340fso3564445ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711441597; x=1712046397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SA+oWp9Gkp8wd1CRZ/Rt7CsWBWTIxXvZJfZfs1FORvg=;
        b=k5t1Hqh9aiYNGTKXRxrUDx4ntPxwQ2f22IK70SoZA1t09ba09OY5YE2xBY/+QIfKOI
         CcEr7fa9/gAj7EtQ7ChFW7W4d4CsoT1XkDOo4dpoIYqi+C8PltLv4TrxcZA3u7AI490c
         E0NDEDISqi6v3y9lf6uy1exOoqxbDPbz8bQxS7oRyNRltr/Bh9HaAQrJ05jdns7V4m8A
         gwjomc5WINIe2H25qsRvGVII1RvMxUmM4lx+DuWB0k/YS+fvCuDkQbtBLGY3gBt5kHb1
         +SiSvZmY2fJtjumlxPwV4oX+CrnPR2rC+aNN5NxgZk8t4qG1rfs57M3cd5fCXUMc28uV
         GaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711441597; x=1712046397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SA+oWp9Gkp8wd1CRZ/Rt7CsWBWTIxXvZJfZfs1FORvg=;
        b=qVqkVFwmg5PysOhAiE+GvpY0TBDnAf9QyITmGykZkLzi5OCLcckCeQ3AWqUTRkjngQ
         k8A2CN4w241vRN1Vl5kBMclqAVRV6KV2/x5nRDE/9GpOjIsbgGOSBq0WgffkKxe52THg
         y46uPnugdbTQ46fTCT1rfan1AtmqeN71Ggr9eEseMS0pp2ey1jXD8B7e3wtJaKGH5HeV
         tvM9DuyRRl9RSyKfhMy1YzDltPTz0sN4OuLkclOa/nUfEudOqXpW/qNTTNU4ZSzLJdxy
         ioPeK2rS/hLLGk0v+dCDFprRG0A6hB2qo3GR+ulK31SVHmQGvsQBNeVryIS/B6AifWyT
         XfyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWkf9RuPJYLGZSI1gVyuXgveiaZ18ndHh4z6Cnj1DWdXGee8U8ADcdIAfxkIGu0vmLiIvjTVxl8+RwwR2OUWnAcYOQSZM3Lr1Us1WI
X-Gm-Message-State: AOJu0YyykFYvkiz5wEjjIV6MZniXvNz5tlwsYOXkNj9dLxQ2rM2PJZB/
	bB+VvoRB3s+FxubecqOfr9TQJqCjbbu4rK73bzxSH24BB7ielUY28SQX0znfAAtQdl7tsLb1shQ
	Vtt/5vwURSDkzrNrjXRc44Ypph/4YLlYIxNhDXg==
X-Google-Smtp-Source: AGHT+IEEra7ju6hHRvLtV8tUAKvdcjCi1j/8EYR4ywdCHSmQPfZDtjEmSpmGLs/4B1O++CAiy8SKGLSTdMMyL1Ql+o0=
X-Received: by 2002:a17:902:c94d:b0:1e0:c91d:4487 with SMTP id
 i13-20020a170902c94d00b001e0c91d4487mr4461288pla.43.1711441597278; Tue, 26
 Mar 2024 01:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307085725.444486-1-sshegde@linux.ibm.com>
 <20240307085725.444486-4-sshegde@linux.ibm.com> <ZgKAJAiAM61MLPBN@gmail.com>
In-Reply-To: <ZgKAJAiAM61MLPBN@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 26 Mar 2024 09:26:25 +0100
Message-ID: <CAKfTPtBTUHv3xBe0U75_4GGYPLYj-NC1uSGd6QjdQyS5k1N0QA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] sched/fair: Combine EAS check with overutilized access
To: Ingo Molnar <mingo@kernel.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, peterz@infradead.org, yu.c.chen@intel.com, 
	dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org, nysal@linux.ibm.com, 
	aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com, 
	pierre.gondois@arm.com, qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 08:58, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
> >  /*
> > - * Ensure that caller can do EAS. overutilized value
> > - * make sense only if EAS is enabled
> > + * overutilized value make sense only if EAS is enabled
> >   */
> > -static inline int is_rd_overutilized(struct root_domain *rd)
> > +static inline int is_rd_not_overutilized(struct root_domain *rd)
> >  {
> > -     return READ_ONCE(rd->overutilized);
> > +     return sched_energy_enabled() && !READ_ONCE(rd->overutilized);
> >  }
>
> While adding the sched_energy_enabled() condition looks OK, the _not prefix
> This is silly: putting logical operators into functions names is far less
> readable than a !fn()...
>
> > -     if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
> > +     if (is_rd_not_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
>
> Especially since we already have cpu_overutilized(). It's far more coherent
> to have the same basic attribute functions and put any negation into
> *actual* logical operators.

I was concerned by the || in this case that could defeat the purpose
of sched_energy_enabled() but it will return early anyway

return !sched_energy_enabled() || READ_ONCE(rd->overutilized);

>
> Thanks,
>
>         Ingo

