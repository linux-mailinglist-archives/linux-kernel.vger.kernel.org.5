Return-Path: <linux-kernel+bounces-51777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0145848F30
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3881CB221CE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930DB22EE0;
	Sun,  4 Feb 2024 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yHtcUesN"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724D422EE4
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707063460; cv=none; b=j7qqTVAvClJmKaRk5xI3rvF2Z2xkdERYau3zlNAIXKA4QpwJQL5cZ4b+0P4r6bKroI2MetjXhptdVGE/xOJ9BVD14Im7b9h9piyJ22QanUOV2xCehtuxfy1HkEQjCmeKuUg9guuHAVALXiWia2ygd5G7WjhB6dUDZhaV9ywmciI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707063460; c=relaxed/simple;
	bh=to2OBQooB2bY+rgljHt4uaz9h8TvFbBAnxNcwMwHRF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLnXFv2cp7sfRU3cjfpSgXgnxJz2wgFrzy0GJCiIR2snF7JB4Yki7PpqQ74968muVrGuP3m85V2agpRu5hoEB6WPaARN6fh/5imfrYhvFGD9WIQ3Yc5GqjVJyGOO+NdZOTj5v3DIglqpHaOPzRkF3XnnQHt8KkLBmfhKnsX84g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yHtcUesN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d93b982761so164865ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 08:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707063459; x=1707668259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gR8mCFXieSn2fI05m7xsuH5LKF6XnUBI7N+gwzR4+1A=;
        b=yHtcUesNUnmmEM/eBaEkohwTdyvRxWgJo0c8iHmnUNAzzFNNLXDWq5ReK5l31rlizz
         z9SH/dlgu374yu7xF8gt4oqd69H4azsEzEmks3McNqTBzZT1j9FczfVxgIOrEX0t1NEp
         P4Potdu976axnbw+xnid0YejeZ57ekoK2edirPkPSTD4ttJJMZh4/hfzhPlUZyFl7V+z
         3DqwAh8NKspiRrd8w0Z+hqyuRknXvDkst1/Yo9j4E7HLGneCksPvyUdC1GIZEFEzZIvM
         OeMk0YnYDTBXOJvodhyvVTZFIkaSLe4+PMhMAtzNhs+GQ5HrgMTQmPLTk53/PGYCnKmY
         2/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707063459; x=1707668259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gR8mCFXieSn2fI05m7xsuH5LKF6XnUBI7N+gwzR4+1A=;
        b=dd2vpReA2yMsE688ibJvdokT+WSAECYZTrmPL8bgowMom5tOxuwCHieOyIJppyxKld
         2wltWL+QqF1bDnpjmBz85i9E9+0/ENR3xgtvQMEQ4CPPoHDjGUpJzP3RxGbjM7I0AU3B
         wBCwI9qkmUdj18mSg+VeIL5cKklqR1WSHR6jfKSK70zDWxt2msLDCDCY3LIwx9J02Pkr
         8tce9klhUtpd+/nA3QE3e+DjugeqUoKIfRnEmGRp8jH+8jn0vukx2HkwX/IE+l07Az6H
         8ajKCCkk7YhwnVgB1A5ONWwyuJZlGE5wYr2VlHs3dbElyGxwkBy28wDK4SikUnvL/1Tm
         7faQ==
X-Gm-Message-State: AOJu0Yx2D/DwYFU6miADKqls0GWzssMHe2irAtY1aGnAXLpyLUx7wx1D
	zGJ0M9RzzGO+yuDQ5ljJThIIR4Dn9A+wvIv1W9fSODq3p9YIbYrxOkxrTXGNeclE93gi+uMjmj4
	JBDNB6daqR6WSFHf4tfKQOgdeIeSAg+pj4LUS
X-Google-Smtp-Source: AGHT+IGSTu3Lad/7ru7MAsWyHtWYX5fvh3BjujCmDIEe9RbfXJhczY7Xe7tRqf2uSWCiqrfvPWwtb734Hj21uj9MizQ=
X-Received: by 2002:a17:902:e547:b0:1d9:6c20:b900 with SMTP id
 n7-20020a170902e54700b001d96c20b900mr167822plf.7.1707063458573; Sun, 04 Feb
 2024 08:17:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202233855.1236422-1-tjmercier@google.com>
In-Reply-To: <20240202233855.1236422-1-tjmercier@google.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Sun, 4 Feb 2024 08:17:25 -0800
Message-ID: <CALvZod4KroCg=zp0bugdDZmG9v-mwUnxKJacrd5nADH491hAqg@mail.gmail.com>
Subject: Re: [PATCH v3] mm: memcg: Use larger batches for proactive reclaim
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Efly Young <yangyifei03@kuaishou.com>, 
	android-mm@google.com, yuzhao@google.com, mkoutny@suse.com, 
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 3:39=E2=80=AFPM T.J. Mercier <tjmercier@google.com> =
wrote:
>
> Before 388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive
> reclaim") we passed the number of pages for the reclaim request directly
> to try_to_free_mem_cgroup_pages, which could lead to significant
> overreclaim. After 0388536ac291 the number of pages was limited to a
> maximum 32 (SWAP_CLUSTER_MAX) to reduce the amount of overreclaim.
> However such a small batch size caused a regression in reclaim
> performance due to many more reclaim start/stop cycles inside
> memory_reclaim.
>
> Reclaim tries to balance nr_to_reclaim fidelity with fairness across
> nodes and cgroups over which the pages are spread. As such, the bigger
> the request, the bigger the absolute overreclaim error. Historic
> in-kernel users of reclaim have used fixed, small sized requests to
> approach an appropriate reclaim rate over time. When we reclaim a user
> request of arbitrary size, use decaying batch sizes to manage error while
> maintaining reasonable throughput.
>
> root - full reclaim       pages/sec   time (sec)
> pre-0388536ac291      :    68047        10.46
> post-0388536ac291     :    13742        inf
> (reclaim-reclaimed)/4 :    67352        10.51
>
> /uid_0 - 1G reclaim       pages/sec   time (sec)  overreclaim (MiB)
> pre-0388536ac291      :    258822       1.12            107.8
> post-0388536ac291     :    105174       2.49            3.5
> (reclaim-reclaimed)/4 :    233396       1.12            -7.4
>
> /uid_0 - full reclaim     pages/sec   time (sec)
> pre-0388536ac291      :    72334        7.09
> post-0388536ac291     :    38105        14.45
> (reclaim-reclaimed)/4 :    72914        6.96
>
> Fixes: 0388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive =
reclaim")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>

Acked-by: Shakeel Butt <shakeelb@google.com>

