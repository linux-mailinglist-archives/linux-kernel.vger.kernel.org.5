Return-Path: <linux-kernel+bounces-30390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8371C831E15
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47311C25DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45842C856;
	Thu, 18 Jan 2024 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/+XHgjh"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839F42C845
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597237; cv=none; b=oh/KR2vxgpXejTPF6ZPgY0+nQhF+QtiBvovrHLpPrkaok6lhjPnUHYss/Nr9T3OCXdgNdTq8JOMldmtdjf4grYajthYYZnvlsITxjVfGA6kfi/8YavoCfzF6ULINoSuzSEU5VIz8jyPDhYRPFpB47hyQJE7B/Xk2Kzn5EfbHcEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597237; c=relaxed/simple;
	bh=1m1rU7Y8d2rR1bpdRYBhiZEswfbajZFmkz5LTl7Jhps=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=NXN3ZkwM83bkzBd8VfzbiKjgOUcIX7lSINzVQUlcYStQuN9rZ0hsXQvC9RMA6PsySNsYV9AavriMYZOLriYwzgEvjX2/f6+PtSvnYTvszW9Uk7poEmVF98WOSojyTzKE9zXVMorzn4e4G5H8oRMSY3r4NlwlVW3d58sGbrMGqbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/+XHgjh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2e0be86878so184795666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705597233; x=1706202033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kjrBGDaeevj+9jk3sVLGectZbotvZgvQYBHMTvFb5U=;
        b=N/+XHgjhqwm2At02+oHFpLYFf+JI0hb5k0w6bNYKpWQ2W34qfJ/CdPLAr6VupDiKrj
         kKJN/j7GoQkl42e5vNEfiP7yjUfoEcEd7QVtRRsV5zdWIEE9BpwKkoOW6uRP1I/hxCyZ
         RQTbCgZtcrdO2R7g9gjuOysPW6TvwAlt2szNye7Kh5guiMm/b/fCPD6kt8dr4jEBy64A
         cAbKoiUbh8+EK1p00Io3XuLdcywk3MtA7ZHLGGCgxx1jKXpzej2iBihlv5iPsjXj1CWO
         0Z06WdzzvjtTZtsi1uJdlKkgPjcy+UCG5RO6R7s7+TXuMcwoUBtPMZ8anTAe3tqQ4xw2
         SiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705597233; x=1706202033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kjrBGDaeevj+9jk3sVLGectZbotvZgvQYBHMTvFb5U=;
        b=L4wPI5MRBJQR/484ZHfCV5FtlDzu5IQNZ9XUq+2ebiOM1os+4zEOIcO/PeLINLW/tJ
         v4Qzkf8O4TVF55PePeRDt4E1DYjmFazpm8EpKYQjbCTlkDLBzJCum+zW/NfZf2WNL4cb
         00SMeoTD5S+acF0RXPqZGlKbzCFH093D1mPoSzlIeJCUpe8yWeK1quWXF8CmodnU2BWz
         Lx/9bBFyRdT+SLdgdJv64u4QKt0N+637DYIN+IMdjp9P68vEBCSFCO1a+wAn7w/ZnyGp
         q3CZ1yjJrCEBB+npa50VgeSfrl6BgkxLQD7WBBtSEw3rwQbr42pWpOfky7If02/peN+O
         8d1w==
X-Gm-Message-State: AOJu0YxYhnC4BQO+KWkZLavxfzNqubyDHVzlt0hZTdg7v8DEvE1kZR8O
	6fQMx4ll9LIBAI3rqvaUb13YOiA0kWcxoCPzuXxLRhuDnHjnhtpaQM4SYwg3OEHGDBeRG2QFxjJ
	4nAx1Cam2U6iyUwUw03TZYCUq1JHF2J1Vfr60szXy45v9Gn1uJw==
X-Google-Smtp-Source: AGHT+IEY7bH4EZyhQcqbaeJB5aahjldR3PVHe/EF5sQKj6HHgdkvOZdE0UuKm5RU377WEgOy+N+2DVi3r3gxBrmCQ3M=
X-Received: by 2002:a17:907:3c0f:b0:a2b:a4c1:52ef with SMTP id
 gh15-20020a1709073c0f00b00a2ba4c152efmr1065632ejc.3.1705597233504; Thu, 18
 Jan 2024 09:00:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <20240117-zswap-xarray-v1-1-6daa86c08fae@kernel.org> <CAJD7tkYEx57CPBoaN9GW4M3Mx-+jEsOMWJ02nLKSKD-MLb-WPA@mail.gmail.com>
 <ZaktH7xc72x4Xr3d@casper.infradead.org>
In-Reply-To: <ZaktH7xc72x4Xr3d@casper.infradead.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 18 Jan 2024 08:59:55 -0800
Message-ID: <CAJD7tkapY4nx=uAXuyQhJN=rz7QPj6p9OJzpPwZGr_7+7Ywotw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: zswap.c: add xarray tree to zswap
To: Matthew Wilcox <willy@infradead.org>
Cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	=?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 5:52=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Jan 17, 2024 at 10:20:29PM -0800, Yosry Ahmed wrote:
> > >         /* walk the tree and free everything */
> > >         spin_lock(&tree->lock);
> > > +
> > > +       xas_for_each(&xas, e, ULONG_MAX)
> >
> > Why not use xa_for_each?
>
> xas_for_each() is O(n) while xa_for_each() is O(n log n), as mentioned
> in the fine documentation.  If you don't need to drop the lock while
> in the body of the loop, always prefer xas_for_each().

Thanks for pointing this out. Out of ignorance, I skipped reading the
doc for this one and operated under the general assumption to use xa_*
functions were possible.

The doc also says we should hold either the RCU read lock or the
xa_lock while iterating, we are not doing either here, no?

