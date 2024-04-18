Return-Path: <linux-kernel+bounces-150801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 586198AA4B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2E71F21760
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A67199E85;
	Thu, 18 Apr 2024 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFVaEgAw"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0CD194C87
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713475420; cv=none; b=QySuNKuOwKtYuH5FZlQPHo14rctOO7Rj4dzO+NCRvzgXJDsT5i9/b0hcDjR+yRR5I8ts4kedrJBD57jGR4OCg+Ms//+2XJ9wr1mcpDdhIhwG+2SGrU/CqBm7DRRXXbhciukMTjyicitEfhiZN6cauTnpmtAvLyYBEwuS08XMS1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713475420; c=relaxed/simple;
	bh=wYalYvd4bYEay973j3KTZyV29Ho5YwrE1KyGZ1KnlgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRFCWK5AVrNlmCYPyZZQGxHgs7NTmCLMXKgBpBOtnRkPuDePFeoZrkCBzyoIe9uvB2vdZZ151DzqnHrP95CelnyOheBOhw74k1QRQ/s2oIulfUcSVXXSOMKuLikfjfS/tSXlSTP3pARiRhTM3oswtQsPvURCvtPhi24YZKxrfL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZFVaEgAw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51ddc783e3so153915666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713475417; x=1714080217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYalYvd4bYEay973j3KTZyV29Ho5YwrE1KyGZ1KnlgE=;
        b=ZFVaEgAwWC/2Pvg7Ypnq/zIiQNSHCNnI51To28V5suYVoiQMxVk0bferCnPf5YGPke
         /P568lPj+RMGpsF4FQUtLz6wLUlnSDgKANDNBpZbLRw/QMaXspv0xELHWl8qkw3hFxJW
         GtTZKnjZykuH65OrN7AuVbmDzTrmhwxQpmQFSarL2wqWjrWzg0v/k6L97hFUSXsILSog
         zRoLNMWNXK1PhZKeKDdaKEsSCuHZHUufWb0g57M9qlx9yR0SbQy/bsLiAFYIDrnZk4UT
         6sW/O1jJOxeMqcorRBCa+Pw+aW7YO1jan+tD2MzTxs9oKXG8BCYCOJiZ528UW+tsml5A
         qgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713475417; x=1714080217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYalYvd4bYEay973j3KTZyV29Ho5YwrE1KyGZ1KnlgE=;
        b=dltxWBfEJUSyDnkqKjm6Oyl4XS+2vJTgVyglciy2mfUmIUYkN7fSC63yNugD7UG3Dj
         AIsKtNhfKDKwMAOpAHESPmYg4ynLMnWCsTdZYwxergx5Xxuzyaff9i+UdgUUvLU8dUqR
         8sJHYNzCRvA3t4qMwiRldvX+kcodZjXUr///4Jy0b+FVgRc+R7H+eFTgelgj+MTzMmTW
         Znxdq9G3DJQX9ntZ4azjkMAubGEHCYOHAn3JDsEcH0piSClIk7a5pXKQD7VotGOGt4Mi
         kPJBiPmu5A7clBSHI5ktPCZOCeoCA3pKap9WjnnEVHh1YCpz+hHeDqzhXtRkMWzuAg0z
         wZMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0dtpIjTC91AtkAqWi84gRtk3DqdsIYJzT7Fag0PIPuyKKfgK5R5f4y/I5+z5d+jl3Hk9/WFc+R+gDwbGWvLgzTa4lHWg2MxYggdsJ
X-Gm-Message-State: AOJu0YxgQCO/3wQmGueiJnNpAkSfELIN5JHJ0yJswNw17OMGtAcYlISR
	y5L5VXNCHW6T/TZoWPxERxyVFcqIAKFDfZ79eIlL0/uppk/bAf7zdTGbQ1T9zj41u8QFThLrTE3
	VTrgFnd+fpai0BPPEb9QzzaTWfukkiYcKVBpV
X-Google-Smtp-Source: AGHT+IE+jIlHU4WcaqMzFdFWnRNrWh1I/I1LmnfLavnHBCPlaJu7GYVzwrGYnuyYgovrzEFHVjqFlQyyrOWhsCBSVS4=
X-Received: by 2002:a17:906:f1d6:b0:a55:5c04:89a4 with SMTP id
 gx22-20020a170906f1d600b00a555c0489a4mr182160ejb.21.1713475417327; Thu, 18
 Apr 2024 14:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328990014.3930751.10674097155895405137.stgit@firesoul>
 <CAJD7tkbZAj3UQSHbu3kj1NG4QDowXWrohG4XM=7cX_a=QL-Shg@mail.gmail.com>
 <72e4a55e-a246-4e28-9d2e-d4f1ef5637c2@kernel.org> <CAJD7tkbNvo4nDek5HV7rpZRbARE7yc3y=ufVY5WMBkNH6oL4Mw@mail.gmail.com>
 <ZiGNc6EiuqsTJ2Ry@slm.duckdns.org>
In-Reply-To: <ZiGNc6EiuqsTJ2Ry@slm.duckdns.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 18 Apr 2024 14:22:58 -0700
Message-ID: <CAJD7tkZOV4rQQ0s=bZT=vO-OT4FxBG+R4nypUKcQTRGap4BGHA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] cgroup/rstat: introduce ratelimited rstat flushing
To: Tejun Heo <tj@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	cgroups@vger.kernel.org, longman@redhat.com, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, shakeel.butt@linux.dev, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org, Wei Xu <weixugc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 2:15=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Yosry.
>
> On Thu, Apr 18, 2024 at 02:00:28PM -0700, Yosry Ahmed wrote:
> ...
> > I think this is an artifact of different subsystems sharing the same
> > rstat tree for no specific reason. I think almost all flushing calls
> > really need the stats from one subsystem after all.
> >
> > If we have separate trees, lock contention gets slightly better as
> > different subsystems do not compete. We can also have different
> > subsystems "customize" their trees, for e.g. by setting different
> > time-based or magnitude-based rate-limiting thresholds.
> >
> > I know this is a bigger lift, just thinking out loud :)
>
> I have no objection to separating out rstat trees so that it has
> per-controller tracking. However, the high frequency source of updates ar=
e
> cpu and memory, which tend to fire together, and the only really high
> frequency consumer seems to be memory, so I'm not too sure how much benef=
it
> separating the trees out would bring.

Well, we could split the global lock into multiple ones, which isn't
really a solution, but it would help other controllers not to be
affected by the high frequency of flushing from the memory controller
(which has its own thresholding).

For updates, cpu and memory would use separate percpu locks as well,
which may help slightly.

Outside of this, I think it helps us add controller-specific
optimizations. For example, I tried to generalize the thresholding
code in the memory controller and put it in the rstat code, but I
couldn't really have a single value representing the "pending stats"
from all controllers. It's impossible to compare memory stats (mostly
in pages or bytes) to cpu time stats for instance.

Similarly, with this proposal from Jesper (which I am not saying I am
agreeing with :P), instead of having time-based ratelimiting in both
the rstat code and the memcg code to support different thresholds, we
could have the memory controller set a different threshold for itself.

So perhaps the lock breakdowns are not enough motivation, but if we
start generalizing optimizations in some controllers, we may want to
split the tree for flexibility.

