Return-Path: <linux-kernel+bounces-40165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F46583DB74
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA66F1F227DE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5151C29E;
	Fri, 26 Jan 2024 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aYsKVrvJ"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8494E1B968
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706278131; cv=none; b=LeP/gn9rO1TOHIPjx6fC8op6Bqd/x2dQnD6HsyPtb7xVsRGMHR6+AuuvNwBWZE3yRkkKdnrl5H6OTinKfkzEDI6gPe156/kwQ++Y+I4nZzZ4ynnnNBYQRCsnBh1N+KPmoc/q01SfR/CAHJI9Jr5swCj4Dts4eerN4+ZUQyuIolE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706278131; c=relaxed/simple;
	bh=bZ2MhTaq0zNiZra1mLRQ063RnIF35SU3cR/v9TDg4Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/OUDslV78V9S5lce/ZMeYxebsjoVvjC2n3KXED2WrkvwuI0lxl6XiS6E/Gwri8cvEF7fzzHlMo2hCgfiL2DEiHpq8Zh2VLfpYw8F6GSUYu5i+Yr+NBMaIMmkthFe2AFQJZBjnFyWw/XV8JZ3fnsz8mte0AhPGPb2yVx3RoX24o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aYsKVrvJ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so1374610a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706278129; x=1706882929; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bZ2MhTaq0zNiZra1mLRQ063RnIF35SU3cR/v9TDg4Fs=;
        b=aYsKVrvJizSmmMmg/ZNMIOnVxmQPqopPM+blTfDRtKaxYIZJ7GZqFkK/3WZpzMxk0C
         U6a3yb8Tdk5Myb9N8nUIvLAnspSZpDWRvWF3Jekh+3EuQeCwZPty2kTi5BwzoeHu+zWu
         xssZGOuCNnq/iIxGN+BOOUomoeuvwybwErinMwfwiPjBIStX8h3nc6cuuOaZKMjXMjvd
         j5jZVL56gsIK6bX1WyoenPhL6JvYEoxp7nwK1nnk5deiHlH5rz67JOxSSbHkwoI5+YiG
         movNKx7s2oUp06+Q5bp7PnAtttG2oan8sRkG6ujJaq+qA9diUfi6bYAYsrwJpMj+ECSn
         5ZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706278129; x=1706882929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZ2MhTaq0zNiZra1mLRQ063RnIF35SU3cR/v9TDg4Fs=;
        b=boKpxy6MVlklJSChyuGF8cbRSnVBnXlDH8FJ86KcJJV67whQEA40QcTo2ugHcqs9fL
         q+FVxiqpU7kXCLnhueJ6YHvhLnuLpBMelBo9Tirci6DZa8ZScqe8+4REpcDd8pAGmbsj
         DxFGOFujbjh60fvXtw4LFLTgRoxnaTPEmGt01bJeTEfiUfdUabZ+6lJLhfdxIuTqM5gn
         AxH+TJl1CK/3jl1LFPXIoBYiEVznDOJJ4iranwkXclFCAAlvEoEXwkayMXy0YRo6n+TC
         PTFC3udZcucK9/HnosybfRSnJRP4qEfVQqEUhqHdGMalnufnAdEGoNHa4khlUw0YK05E
         phfw==
X-Gm-Message-State: AOJu0Yx9MYLDxlI4FLaobBj5er2SxYcMsz2rIATze1U3OG+HM4CGa/Xe
	YTEw105om+1Ns6zNeYuD+lHQH0E13OZ47KZ5JGAz5DXnlpREJBY1J5efu1EaE2unAz+Mbnrd4Wi
	pNdESF4Lg8S+i6cHUnks7/iUB0gg6QvAFSEovCw==
X-Google-Smtp-Source: AGHT+IE6zOB2uKDBALWoKFYSD7eVFd5vGOXlSXwrlbwjg5bHeNrFTYSRyAl8hJXB8foxAFnjGOIRbhZIUyaQuHaRSjI=
X-Received: by 2002:a17:90a:bb13:b0:28d:b263:870 with SMTP id
 u19-20020a17090abb1300b0028db2630870mr1336375pjr.31.1706278128670; Fri, 26
 Jan 2024 06:08:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105222014.1025040-1-qyousef@layalina.io> <20240105222014.1025040-2-qyousef@layalina.io>
 <CAKfTPtBYcVWxYOhWZjzcQUB1ebUBA-B30hvToqGBq6JnfRUZNg@mail.gmail.com>
 <20240124222959.ikwnbxkcjaxuiqp2@airbuntu> <CAKfTPtDxqcrf0kaBQG_zpFx-DEZTMKfyxBu_bzCuZ_UZhJwOnA@mail.gmail.com>
 <20240126014602.wdcro3ajffpna4fp@airbuntu>
In-Reply-To: <20240126014602.wdcro3ajffpna4fp@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 26 Jan 2024 15:08:37 +0100
Message-ID: <CAKfTPtDqABnPDmt0COqyRpYSuj_WWwLrqL+Tbfa8J8b5u5eQtQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	Pierre Gondois <Pierre.Gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 02:46, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 01/25/24 18:40, Vincent Guittot wrote:
> > On Wed, 24 Jan 2024 at 23:30, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 01/23/24 09:26, Vincent Guittot wrote:
> > > > On Fri, 5 Jan 2024 at 23:20, Qais Yousef <qyousef@layalina.io> wrote:
> > > > >
> > > > > From: Qais Yousef <qais.yousef@arm.com>
> > > > >
> > > > > If a misfit task is affined to a subset of the possible cpus, we need to
> > > > > verify that one of these cpus can fit it. Otherwise the load balancer
> > > > > code will continuously trigger needlessly leading the balance_interval
> > > > > to increase in return and eventually end up with a situation where real
> > > > > imbalances take a long time to address because of this impossible
> > > > > imbalance situation.
> > > >
> > > > If your problem is about increasing balance_interval, it would be
> > > > better to not increase the interval is such case.
> > > > I mean that we are able to detect misfit_task conditions for the
> > > > periodic load balance so we should be able to not increase the
> > > > interval in such cases.
> > > >
> > > > If I'm not wrong, your problem only happens when the system is
> > > > overutilized and we have disable EAS
> > >
> > > Yes and no. There are two concerns here:
> > >
> > > 1.
> > >
> > > So this patch is a generalized form of 0ae78eec8aa6 ("sched/eas: Don't update
> > > misfit status if the task is pinned") which is when I originally noticed the
> > > problem and this patch was written along side it.
> > >
> > > We have unlinked misfit from overutilized since then.
> > >
> > > And to be honest I am not sure if flattening of topology matters too since
> > > I first noticed this, which was on Juno which doesn't have flat topology.
> > >
> > > FWIW I can still reproduce this, but I have a different setup now. On M1 mac
> > > mini if I spawn a busy task affined to littles then expand the mask for
> > > a single big core; I see big delays (>500ms) without the patch. But with the
> > > patch it moves in few ms. The delay without the patch is too large and I can't
> > > explain it. So the worry here is that generally misfit migration not happening
> > > fast enough due to this fake misfit cases.
> >
> > I tried a similar scenario on RB5 but I don't see any difference with
> > your patch. And that could be me not testing it correctly...
> >
> > I set the affinity of always running task to cpu[0-3] for a few
> > seconds then extend it to [0-3,7] and the time to migrate is almost
> > the same.
>
> That matches what I do.
>
> I write a trace_marker when I change affinity to help see when it should move.

same for me

>
> >
> > I'm using tip/sched/core + [0]
> >
> > [0] https://lore.kernel.org/all/20240108134843.429769-1-vincent.guittot@linaro.org/
>
> I tried on pinebook pro which has a rk3399 and I can't reproduce there too.
>
> On the M1 I get two sched domains, MC and DIE. But on the pine64 it has only
> MC. Could this be the difference as lb has sched domains dependencies?
>
> It seems we flatten topologies but not sched domains. I see all cpus shown as
> core_siblings. The DT for apple silicon sets clusters in the cpu-map - which
> seems the flatten topology stuff detect LLC correctly but still keeps the
> sched-domains not flattened. Is this a bug? I thought we will end up with one
> sched domain still.
>
> TBH I had a bit of confirmation bias that this is a problem based on the fix
> (0ae78eec8aa6) that we had in the past. So on verification I looked at
> balance_interval and this reproducer which is a not the same as the original
> one and it might be exposing another problem and I didn't think twice about it.

I checked the behavior more deeply and I confirm that I don't see
improvement for the use case described above. I would say that it's
even worse as I can see some runs where the task stays on little
whereas a big core has been added in the affinity. Having in mind that
my system is pretty idle which means that there is almost no other
reason to trigger an ilb than the misfit task, the change in
check_misfit_status() is probably the reason for never kicking an ilb
for such case

>
> The patch did help though. So maybe there are more than one problem. The delays
> are longer than I expected as I tried to highlight. I'll continue to probe.

