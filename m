Return-Path: <linux-kernel+bounces-110638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1D1886196
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CDD1F22DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB29134CC7;
	Thu, 21 Mar 2024 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wb5frFT7"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6ED79F0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052754; cv=none; b=lH1XcmBc2l/+1cljFR9Nn4kDTujC3DX6wDs/wRZ7Bn0W2ckGQ/ptmYdJdEbr6I5qw1S5Ftic2KexEgf9295QAdul+3U8/j8ZpwBxy0Y6/mcyc/t8uiYUsDRPCAw4YkEbXiL4OxxFt7mDY3RNAvGnf9n7oSSycjlyGMEpxGDTDy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052754; c=relaxed/simple;
	bh=KFPqyrctUaYq3cli0WFxDcsfh2suA7GJpBgvoQCG1WA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mF2IVp6nHhDSxj8mD0nm76x8hahi/RYXyIOwTXVjJboWqQPt2E5xQ7nlk0rZj0pqoiqJo36+rJvkS/WBW8boJ4IoWBOmm+cyZ2AFD2/XXTL2szRxoNXGSbFAZJPc+LmN0XJkLv9HBHPckoecu7IJhBp1AMYszLR5jp4BwnxXZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wb5frFT7; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56b9dac4e6cso450a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 13:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711052751; x=1711657551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFPqyrctUaYq3cli0WFxDcsfh2suA7GJpBgvoQCG1WA=;
        b=Wb5frFT7aidgDpbBdzBaFW025n/Ekv+RHP+QqWDbro7HCTapHWJRPkiKs7w54GsnlQ
         B4TNk0flfGbQ3U3njwkL2CYMZQXbJCio5GeoTJMojWmV/LDNbG0UoorSmYUQew3H4vJX
         OUHgOg5W3P021ahqWwmupfy1ycUrjH0oatr5UrzHgP55hNF6kdGjyJg7xAh5i+CYauH3
         SNvvAxY2f9Vi5vWTnOiUbZUPwLGDSvO4/IEzWcLEftCCAhnRkAgtcQM4ezflkJ+AXgId
         dAMeeiDNQ9B23xCD0fnngsxHam83Ug8fQObm2rRX//aK4JjTM3O8if4ffFIfGkdiRv2o
         OiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711052751; x=1711657551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFPqyrctUaYq3cli0WFxDcsfh2suA7GJpBgvoQCG1WA=;
        b=wSSH0MU46SXJXsh74HjhKnWVLZoUhEAzFzxBV6ORMD2ByB3CujYalg/VDmswgZm6kS
         PAffxnlhlmhN+ODdAPMh2mLpVFFuvrrtv8GVQnzRVrsD3hxQPbJClP/jOEnvDVRmSq9H
         rg7/59HNpjhT9QPH8QdOp2TCz7Ts8oaHaLDXQMzhWfCFKgP5JWzNfILQOfguFWLDWVBf
         JXzBokoDLPhyMAT1aeF4TUXVWXDSNapIfc2qEvCNN4o7Uo7aUAm7xAR4i9m1gd9tStfi
         BcksHuKotFmVz2bDa+kSFgxxfdReU5FwrrK/7rACskUwZhcVEEoX+i4iAguxz5dwHVux
         NVZg==
X-Forwarded-Encrypted: i=1; AJvYcCXoTTbDRIrkvmb9vPZ8d7jmZQ9n9h22NdlpxlVmjQaUkO1GfDqhMll7FKG0JicBqXamCYqeIzrtbW/t9eWAETTy0c9IDIm7Y42gCu29
X-Gm-Message-State: AOJu0YyBvZBu1Zf8FspdsihSYJt8cu8l9hY9R+YUdDcTzmXpFCKNfAin
	oqtcnCaAGfCWixpIPAtf/VSWWsp4r+5tJe4oNFnWvwdwjuJRmyxGdkHcGBhYMxlCzkw/fkYDa3D
	o113WlLvvRkvK4epGAf7Bj+gxdbSkKk8IURUA
X-Google-Smtp-Source: AGHT+IEfSUNCQOhpAtDYrpFxqJCdx/9aTLDUe7gh8vSWGiAmT1kQ4XWHeuhhZ5QcoBuJNWUJoCsdHuOniv4PcJcKPdo=
X-Received: by 2002:aa7:d156:0:b0:56b:a060:1e4 with SMTP id
 r22-20020aa7d156000000b0056ba06001e4mr278342edo.2.1711052750857; Thu, 21 Mar
 2024 13:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220825122726.20819-1-vincent.guittot@linaro.org>
 <20220825122726.20819-2-vincent.guittot@linaro.org> <CABk29NsQf_xStzWg8bB_hpNpPC_LduMs-M058LjdhnDG16wN_A@mail.gmail.com>
 <CAKfTPtDSC25N8TvszDAjseqdLdGy4qiDnwobNThkt8piSL_5Pw@mail.gmail.com>
In-Reply-To: <CAKfTPtDSC25N8TvszDAjseqdLdGy4qiDnwobNThkt8piSL_5Pw@mail.gmail.com>
From: Josh Don <joshdon@google.com>
Date: Thu, 21 Mar 2024 13:25:38 -0700
Message-ID: <CABk29NuU30DHproFY-i3_baEhXxofCyLQx-Z5LV74y8_6m7uGA@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/fair: make sure to try to detach at least one
 movable task
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 9:58=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi Josh,
>
> Sorry for the late reply.

No worries, responses to your comments inline below.

> > We had a user recently trigger a hard lockup which we believe is due
> > to this patch. The user in question had O(10k) threads affinitized to
> > a cpu; seems like the process had an out of control thread spawning
> > issue, and was in the middle of getting killed. However, that was
> > being slowed down due to the fact that load balance was iterating all
>
> Does it mean that it was progressing but not as fast as you would like

It was a hard lockup, so it's more than just "not fast enough".
Indeed it was progressing, but not at a rate sufficient to avoid
lockup.

> > these threads and bouncing the rq lock (and making no progress due to
> > ALL_PINNED). Before this patch, load balance would quit after hitting
> > loop_max.
> >
> > Even ignoring that specific instance, it seems pretty easy for this
> > patch to cause a softlockup due to a buggy or malicious process.
>
> The fact that the rq is released regularly should prevent a
> softlockup.

That doesn't prevent a softlockup; kernel is stuck looping over a long
list of tasks for too long, regardless of whether it is releasing and
re-acquiring the rq locks.

Note also that load balance can come from softirq in a context where
we have IRQ disabled, which can lead to hard lockup as well.

> And we could even fasten can_migrate() which does a lot of
> useless stuff for task affined to 1 cpu.

That seems like a useful optimization, but not really relevant? It
doesn't matter how small we make the constant factor, we still have an
O(n) operation in kernel mode here.

> > For the tradeoff you were trying to make in this patch (spend more
> > time searching in the hopes that there's something migratable further
> > in the list), perhaps it would be better to adjust
> > sysctl.sched_nr_migrate instead of baking this into the kernel?
>
> That could be a solution but this increases the iterations for all
> cases including those which are more time consuming to sort out and
> the number of tasks that you will migrate in one lb. The latter is the
> one which consumes time

Is is really that bad? loop_max will be unchanged for most cases since
it gets min'd with nr_running anyway. And, even if loop_max ends up
larger in some other instances, we still terminate the iteration after
fixing up env->imbalance (granted, we'll migrate more tasks to achieve
a better balance with a larger loop_max, which I think is your point).


Another idea then: what about separating the number of tasks we can
move from the number of tasks we can search? You effectively want to
keep the number of tasks that can be migrated small (nr_migrate), but
be able to search deeper in the list for things to pull (a larger
search_depth).

- Josh

