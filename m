Return-Path: <linux-kernel+bounces-34635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C24583859A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B16B259FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE2633CED;
	Tue, 23 Jan 2024 02:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lliGD1VC"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A733FF4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 02:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705976737; cv=none; b=Ya1C6uPPHAHkS+NRjQAxhcCbvGUpj5nLIhyVeJdkdi6Ce1p53uFLwSOHlt7fr8Snz2om2IDw6KQj6EbirhLVgp3EvQffgeRGwNxJgptEJYcFavO5wJTHmUY1yQXyAVEnw3tiI3pK76Rmx2NwklWEL1c/7uJfHNg1KEFhccBNGj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705976737; c=relaxed/simple;
	bh=ysRcFbGQ5p/ls5XIwFIv22IFWYlKtkPn5NUDI0tHdHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAwQsP4ifC4hsOW7umCvgZnf+AprB6JCthPD2u4TkeOGXG0SZW7shNmlmJyB3A7MTZ7Q1XE4rN1/JIR1vliL9OWYCSSXZB34YhCG7Jdv+dr8n/IEv6jk6ud0FAuTT844r3kObnYwR1f6BmNN6QEeaGEKRrf1NT7p7AD6ZIFZcTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lliGD1VC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e865bccb4so17075e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705976734; x=1706581534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysRcFbGQ5p/ls5XIwFIv22IFWYlKtkPn5NUDI0tHdHQ=;
        b=lliGD1VCRuggr1DlJeull3ZCzM0uVTNquBzTj0DNvKtfIn2omgOFNQuwVkPD8LQtTJ
         JdIkP7SfeEFLnHeKle3fDQVYOHi9HMec4SU43utpLojbZINz0y85FfvEJFWyiJA/6yer
         kY/0hQYOOTSo8NtbC8y+zLryQRL4yNzcc+JAly1O588Cq9vaBr5PGqKyLeT44pgjK0ry
         1E79Yg6k63ukYWzCEb4jvnLVCq9V9Ws7kmC+BeNjtZkTH2zBL7+yEF9k6ALYL1ul+k3e
         jbnavJgBT1dvgBs4A4mUGu4CS6JV85I6Vek3ldg+JVDvQ7T/BLc2EU8PFmXgDHfbST29
         Sz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705976734; x=1706581534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysRcFbGQ5p/ls5XIwFIv22IFWYlKtkPn5NUDI0tHdHQ=;
        b=k+k4beb0GE8WSP1Y94d6FJHx7TZMGfh3aMWnPVumxku5Af0gxUjPOGDGpBuvYJ2eN4
         L2b6sHJ21qtcFJtEGmWk0t0g6JvVgU1zI3K9keMbrolMT8V4kD6dSmLAAtww1TljPDbE
         Qwir7KoATpaVArMJOzwz+/l67B6wroUNnKiZB+MMPQYkCN2tJvSNhSTFwd3MVtQk9MTm
         IEktFgZsJd70+0pStmOw4HoMOryUHCzSDjpXf6Y26qI0dLu6qe86eC0wS15MM8Ee+63Z
         rvpCBL1Hb56D9oocOdWZI+ZvRbnRJnG4SyslCZGVSLIVmzoNIQqAwJOcnC3uEkf/oKco
         0Qsw==
X-Gm-Message-State: AOJu0YzTxcc7uUmnZAJpm/yWMOwmK+3axgn81fwTyVSP/hiD/ARtUDdP
	stp78+LPkkEBbCWxoOLZEE1JmzE+NAhYkB/ez36PkMC2SKrC0OU1yj4mO6412ZNBu/7nR11kk/R
	EEvlfwOGEdCyOtB91Dsu/VrEOXJ5puSS0+k8v
X-Google-Smtp-Source: AGHT+IEpcicRjFt4pPgD8o1zSRn4vyWZTcoaq8n3EvRlQyVYjfHUDtqLfz/XZTt7bFDYztKnzWDndT4W5ULijtyHiyc=
X-Received: by 2002:a05:600c:1d14:b0:40e:490c:48a9 with SMTP id
 l20-20020a05600c1d1400b0040e490c48a9mr56750wms.3.1705976733713; Mon, 22 Jan
 2024 18:25:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121214413.833776-1-tjmercier@google.com>
In-Reply-To: <20240121214413.833776-1-tjmercier@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 22 Jan 2024 19:24:56 -0700
Message-ID: <CAOUHufa9BySrKZ5ws9xJoEsdUfbErb4V=2=JSm-dB9B7zMyJbQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm:vmscan: fix inaccurate reclaim during
 proactive reclaim"
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com, 
	yangyifei03@kuaishou.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 2:44=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> This reverts commit 0388536ac29104a478c79b3869541524caec28eb.
>
> Proactive reclaim on the root cgroup is 10x slower after this patch when
> MGLRU is enabled, and completion times for proactive reclaim on much
> smaller non-root cgroups take ~30% longer (with or without MGLRU). With
> root reclaim before the patch, I observe average reclaim rates of
> ~70k pages/sec before try_to_free_mem_cgroup_pages starts to fail and
> the nr_retries counter starts to decrement, eventually ending the
> proactive reclaim attempt. After the patch the reclaim rate is
> consistently ~6.6k pages/sec due to the reduced nr_pages value causing
> scan aborts as soon as SWAP_CLUSTER_MAX pages are reclaimed. The
> proactive reclaim doesn't complete after several minutes because
> try_to_free_mem_cgroup_pages is still capable of reclaiming pages in
> tiny SWAP_CLUSTER_MAX page chunks and nr_retries is never decremented.
>
> The docs for memory.reclaim say, "the kernel can over or under reclaim
> from the target cgroup" which this patch was trying to fix. Revert it
> until a less costly solution is found.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Fixes: 0388536ac291 ("mm:vmscan: fix inaccurate reclaim during
proactive reclaim")
Cc: <stable@vger.kernel.org>

