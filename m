Return-Path: <linux-kernel+bounces-131678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5475D898AC1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8884EB225AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537E56E615;
	Thu,  4 Apr 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sd2kMj8n"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6271BDC4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243421; cv=none; b=OJKcMOLiPV3x+wOYTkf/lapuOrgm/njQQETa7rqgnwmK75sImkgNxaqPMSzZF7tktEclnKw5Xb29tv935Dik3Z2dBJmWScTWGaxPKAetBygx6u+n2ZRhJewioZK730DtvNWbaGiYhiePnCYtKEDiHjGchrN8TuvhwfKjS4V3jFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243421; c=relaxed/simple;
	bh=5HJKLFzBvdY60o38v0HdSOBXSSPwHu6x0Ps3wSnRufY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYhv9qX5zhG4TUum042lc9sT+VMytGZLqJqJJcvnECqGUeo8WPnLjwEnDC+4IyjYxznxBUbeJAeAR6lhEyLSyf9PbL7ue9tKhpiFa8NFeA9ulS8GzDw1QTlUtC0JKIDCIN7Rfe8YFfhObZYiQHa137CtMHIHxbttbr6l6bd/2Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sd2kMj8n; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a2474f2595so841984a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 08:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712243419; x=1712848219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=45gvEKFW0el3OK8y0LXAU49bilwZWaNQkrdfszt6ReI=;
        b=Sd2kMj8nwj6R68FCw60oL7t9Lz4tl4nGgFsuNxAF+9Kvy18HrnGl8pTCanQidOnBFS
         e1iHPgMpTFeen6FW5n8FRAmEDwmgL5IBdfv/WV6oo+3hNz8m9uQ8xcljXdpIJbGyoP1h
         +SyVqS1AT5cg9vM10d32QeScnJ0Sed9hdrDp56NZtjLqKfLJrdtoLwInq+KTIMU+Twv+
         Sc6HLCn2IqAamYshO4ZJAgz2/QSS3rnRQUr+RwlWbVjH/Zyl71vrRu7jNqzuagTXrNh7
         RrkOUftYnCMi0qcLJNF+mgahOH0mM8ppLx01Hr+M/ebQji4N1rH+q1VjQ6vrAg/kSk10
         G+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712243419; x=1712848219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45gvEKFW0el3OK8y0LXAU49bilwZWaNQkrdfszt6ReI=;
        b=qL7cUGVFBiHna1U7OmuJBB+qEwyt2N+7xvEC0aMRrcZV493KZJg52TfsavjPq3fw1l
         d0r9DSwEZZOTpx8sDOJ0Jvj94ATdWJe4zBvy/dbMBkfpjpL/Z0KZbfbdCFCoQc4/4AWn
         r7vyMKrkdv7K8GB5tEzqx4py2szZU/wTCiMcO+5AST6ujVcQgJx3r8d8RsUpfsun08+/
         b8QRCGdExs8hrDrzbOM6w41OWBArrVK9Uk0Zco9saRoM8PvLmpKr7GiX7SWXetpDB6S6
         9qrJZoqS9T05ryjx7Md7MbN7vZH0X68whBsFSGkvSEgTTvuMhv3GrOVafyAuFLHlyYJi
         xnMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXABq0d6C9XQRgUGqc8oioVA+OXkgKIGJbAxZ2p1pUTJYCL6uEzwtrHp1RGYYtM9Jl0Aky/wJtPWwM2mmDgVDvSnjxHV/5KeUBKNjRh
X-Gm-Message-State: AOJu0YzGDWKZzybXBllClK5UJbn5tztUCHqDH2ogP+936JnX9YcBXxpA
	mLv8sCU7b1Jwp2uXq1ZniqKwx1IV2YBF1l6OSBBIJTwcNCKRtmArEQ+Fkm9cSvQLVu07pSfqjuf
	HFMY6I3EfnG/nXPEZdWt3yXQ14CDpXQWR/ai0Bg==
X-Google-Smtp-Source: AGHT+IE+JFFL0yOgPsiB2MsU/H2XhtaiGdVvFK3HzYpVEFCCECOTWC5ucld0OF7qdHUK7RcycH1eT2ZDDPmABnk9aGQ=
X-Received: by 2002:a17:90b:3841:b0:2a2:abc1:cb48 with SMTP id
 nl1-20020a17090b384100b002a2abc1cb48mr2797779pjb.18.1712243419222; Thu, 04
 Apr 2024 08:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712147341.git.vitaly@bursov.com> <e97fd467bbe1d7168bbd73b7c9d182f46bf47a90.1712147341.git.vitaly@bursov.com>
 <xhsmh5xwxb4g5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmh5xwxb4g5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 4 Apr 2024 17:10:07 +0200
Message-ID: <CAKfTPtBFFSOzAfnJ4DLMdaaWh0FebJ30VJ9kZOET7br9juaRHQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] sched/fair: allow disabling sched_balance_newidle
 with sched_relax_domain_level
To: Valentin Schneider <vschneid@redhat.com>
Cc: Vitalii Bursov <vitaly@bursov.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Apr 2024 at 16:14, Valentin Schneider <vschneid@redhat.com> wrote:
>
> On 03/04/24 16:28, Vitalii Bursov wrote:
> > Change relax_domain_level checks so that it would be possible
> > to include or exclude all domains from newidle balancing.
> >
> > This matches the behavior described in the documentation:
> >   -1   no request. use system default or follow request of others.
> >    0   no search.
> >    1   search siblings (hyperthreads in a core).
> >
> > "2" enables levels 0 and 1, level_max excludes the last (level_max)
> > level, and level_max+1 includes all levels.
> >
> > Fixes: 9ae7ab20b483 ("sched/topology: Don't set SD_BALANCE_WAKE on cpuset domain relax")
>
> Not that it matters too much, but wasn't the behaviour the same back then?
> i.e.
>
>         if (request < sd->level)
>                 sd->flags &= ~(SD_BALANCE_WAKE|SD_BALANCE_NEWIDLE);
>
> So if relax_domain_level=0 we wouldn't clear the flags on e.g. SMT
> (level=0)

Yes, I have been too quick: this patch [2019] was quite "old" and the
last one which changes the condition so I assumed it was the culprit

>
> AFAICT the docs & the code have always been misaligned:
>
>   4d5f35533fb9 ("sched, cpuset: customize sched domains, docs") [2008]
>   1d3504fcf560 ("sched, cpuset: customize sched domains, core") [2008]
>
> History nitpicking aside, I think this makes sense, but existing users are
> going to get a surprise...
>

