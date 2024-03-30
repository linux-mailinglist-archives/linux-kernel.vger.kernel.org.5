Return-Path: <linux-kernel+bounces-125581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FAA892900
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 04:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8BC283704
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19A0522F;
	Sat, 30 Mar 2024 03:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FoO4eL2f"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A0028F0
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 03:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711769044; cv=none; b=p80Z8dViyPH9m3MlQODT7B8xuahDYjootaCUrgAgT1fxS0jqgscYHtFwx58KQqZ7zmGDfk9vShye83zVM67CRVlf66P3Bj2K35Lq1xqoEMU5W1VSQ55OMabnvGTCqNR6dG0e9o7ntmcT8F8AaD6d+UcbLxi0Vh85ok+S5WU9eNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711769044; c=relaxed/simple;
	bh=h2Tm3pEm9Nt5hIefYgP+/nHpTDgFRHaCSfnkaij5Dc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmyAX+RQnnxPpKIhwm2SVXXgDQRZ0qDDJDccZmzNJX7v809LxEs5dPfvEuVCRvFZIek2l78501jkS5qcBitj9pCNNvS2wtDHyiRSZtnlpCUQAV4awgvZMwBZF9GQMYQ/4nGFlnjVW/aPJ+puo6M2cjAUq+I7y/AYjuKiOFtg6Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FoO4eL2f; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e062f3a47bso211165ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711769042; x=1712373842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezRcUqT68/3s/Hl09bdcw2yDCHcZpLFddkxtJsbDh70=;
        b=FoO4eL2fZmnYWvTOhnfJX12dbug1LK5HMxhYrM+yhRKmERYxocbz+V29EwI/mh3iQQ
         8P8Mmog0uUwk+xA4mVpLVxfSkizNQxCEq48viQ7Ir+uNejbnZsHYx5vuD49gPr5LLGr9
         FAwe61/IfwXSrBNqRGcURdouHs1Gvy6/X78urYwLbosTrYcDfFtd4gNzbvOv9W2ZBP6D
         IMG1/aXY38DmxR+t0mqAkd4Df2scI/B7vfbCb8rJjRjYV9rr3t41Qfmfi4xdHSxczpJe
         lwVvfNmVNFa+aQ2ONyNTFBK/jY+ySHcprj+CIe2X6T8jpE1WHWsh3on0y3uinfjPdl3M
         +13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711769042; x=1712373842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezRcUqT68/3s/Hl09bdcw2yDCHcZpLFddkxtJsbDh70=;
        b=a8zLz/9qke2XFavBwP04EKxqbn6RWOXf86RAAbmblVPwkxJ2LM9sa0ZlcPYM/W8gep
         NvPkJFwklLCSbVvZEncD30UCIZOnHdxiz8SNj942uuNyqZZsjP4AJN8rzERY4L4SOjrE
         8STGD/avSJf0JnFSlDPshpz+jLPq51kmSqoAKrYRDVjQVYSTBJBts2EjAMXALZ05vGD1
         S0ykuL1uw83YZeHIlpX4emDuatdojb4XJ4DCpE+TvSo0ndiJAdCBr1I+WRQZ6ll913zX
         26R+SOqyNdx/MrQpvyoc/lDjzsRF+Kzzb0zVWhAv8MAMi/9IDr9a4aw9H6Dnktwz9cDT
         8JFg==
X-Gm-Message-State: AOJu0YxTv4U5fpvMSCXxVVQIlTQ0WLlcXdNY73nVJ+IRLNCCenYZ1JGW
	j7ktQxOUWkLEwI5nUzR0f5SoQrGHmD0sT/WTsj/SE7nqfzUGgq+AffsYEN9To2D4G9ILV71jQ1j
	M3fnAIR0nGrPpMSspP+s+vHPzl0gQFB561vGW
X-Google-Smtp-Source: AGHT+IG6kYEiOVf6A2H0J1kNrqCEXN3m0BQFC1lV6Ie2Febpmv+NBLHkMz9otjF40n+ChdIDrxzUrJc1Eim5E11jMfo=
X-Received: by 2002:a17:903:18f:b0:1e0:9f59:ed0e with SMTP id
 z15-20020a170903018f00b001e09f59ed0emr293071plg.25.1711769041822; Fri, 29 Mar
 2024 20:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329235812.18917-1-frederic@kernel.org>
In-Reply-To: <20240329235812.18917-1-frederic@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 29 Mar 2024 20:23:49 -0700
Message-ID: <CAP-5=fVwT1FPTps=i=hG2O0sWr9DH92VSt66Co=Rhf9dyZX7ag@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf: Fix leaked events when sigtrap = 1
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 4:58=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> While looking at task_work users I just noticed that perf doesn't flush
> its own upon event exiting. This looks especially problematic with child
> events. Please have a thourough look at the last patch, I may easily
> have missed something within the maze.
>
> Frederic Weisbecker (4):
>   task_work: s/task_work_cancel()/task_work_cancel_func()/
>   task_work: Introduce task_work_cancel() again
>   perf: Fix event leak upon exit
>   perf: Fix event leak upon exec and file release
>
>  include/linux/perf_event.h |  1 +
>  include/linux/task_work.h  |  3 ++-
>  kernel/events/core.c       | 40 +++++++++++++++++++++++++++++++-------
>  kernel/irq/manage.c        |  2 +-
>  kernel/task_work.c         | 34 +++++++++++++++++++++++++++-----
>  security/keys/keyctl.c     |  2 +-
>  6 files changed, 67 insertions(+), 15 deletions(-)

Thanks for this! I wonder if this relates to fuzzing failures like:
https://lore.kernel.org/linux-perf-users/CAP-5=3DfUa+-Tj2b_hxk96Qg5=3DQu7jY=
HgHREbsmBa2ZmuF-X9QaA@mail.gmail.com/
"[ 2519.138665] unexpected event refcount: 2; ptr=3D000000009c56b097"

Thanks,
Ian

> --
> 2.44.0
>

