Return-Path: <linux-kernel+bounces-55425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D234684BC8D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028AC1C23C40
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C28A134C6;
	Tue,  6 Feb 2024 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+6j5QnF"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480EA134A5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241976; cv=none; b=NdJHEZKQjKzRt2S3GApXiw3yH5vbb5TL2IuqAncquGkdC8gL0X/JTSLn1jhDjJMF7XFHhiaSyRAw5mLCYXnbxi9ZE2b8hpdko2kQGMgXDQQqQ2a0X2vjVxrEbo0guk7oX4V8Zcj7DnEhpyTT1lChU7NflspDSSCcUChYrIP7hvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241976; c=relaxed/simple;
	bh=pn7KC3O9zKWEIlwgIeUCkjbs1TZhMmi1wHUXX84n1Vs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uVVQPVubxCS6sohmw09nux7/69YsqaxxV7+l+Y2kPb+YDSEHVspjZYrdudIz3zk03Qp/x0XE3RqrFV6LqZKC3II0FauVENhy8adsG5+65cSaLurnNA1CDTC2+RN4y95ZJAOW04SY1lV++xPeLYvw30FcUtCsd6Sqv+PpIS9Rglk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q+6j5QnF; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e04e1ac036so2135678b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 09:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707241974; x=1707846774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NnkI5UQ3se7RbAiVyXACobU8giPRA6UB/GtRqT8enc4=;
        b=Q+6j5QnFaIqWjR521tzupPPdV0HaZ58RmPTKQW86m/4hwZo449hudap667v0bj437L
         Oh3v/oeBErJk63/OIfDJd6QnVnES77RyQ8T3ZQj1hiSAHix4fBP4QKm/ec5j6GYKeh2d
         tbFXnvyjG2ljHKNyBUPxc0RoBOEIWHjTgpPky+upToptaQf1jWRV0hYgpy+IqsdEYTIE
         SNseEkdfQSkq7GfhlQhTGAT40Cx07GydG4RDYo1g8HfnMy9Cc3ueJ9QK2/9VdaxEgC5y
         o9AL1vgin3FWfe2b5Fh3EDwGT0D5YZKN6twcCK+cEy1tMNiBm8o2G+0LKfJiMf9BvM5S
         uVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707241974; x=1707846774;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnkI5UQ3se7RbAiVyXACobU8giPRA6UB/GtRqT8enc4=;
        b=GahabxyPTVsDleQEncA9P80kbe2ZyEp44bqlZXs8H6ETcXqoJeXd3ItaQsRDm2rHVp
         bI/EtCXIlPyMUUP6SQ0PBM506uTYVyyYKJlys+b1icEB4naxo189XUhQ1k6JVOt6Du2j
         Ih2mmK2IV04VTPNm9Q2/3gUGDNRPP8xAXXXURbKoydhco1uerB5gt8FwXAtKiSwY4n14
         Ao7+RZfoY62YXLJVxL1Xns2B6WnkB7qB4Qp/EnfUyUwURMayPfBEXrEUWUo9MJIxbdZ7
         igccyi8L0Cwnf4YLHEpA8gfXU1CteC8ePYHPCRmQ/+sIqgiQDPVsUXJ8qbJFJEHYn8Fz
         0riQ==
X-Gm-Message-State: AOJu0YzpkTIKsZtD/3JWbgforUaAQvWnJYUMo3D+niPHMgde7gDjAASM
	nkJtTcAcQDexfB17Dq65SqqgVSShju5Z89VghmI6qOqlcn1LVhbrEuUB+sr5zBon2+x2gKLtl1I
	gUhc5sSZNNH9Njg==
X-Google-Smtp-Source: AGHT+IFfvyuPQfLG3R8pxlTzGNbrQ4aI0ovDtf3rTDW0vN+S5SToqxRa433lLgtzsnmPoI64wOwc7OjmECXxhZo=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a05:6a00:17aa:b0:6df:ef44:90bb with SMTP
 id s42-20020a056a0017aa00b006dfef4490bbmr11498pfg.5.1707241974509; Tue, 06
 Feb 2024 09:52:54 -0800 (PST)
Date: Tue,  6 Feb 2024 17:52:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206175251.3364296-1-tjmercier@google.com>
Subject: [PATCH v4] mm: memcg: Use larger batches for proactive reclaim
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Efly Young <yangyifei03@kuaishou.com>
Cc: android-mm@google.com, yuzhao@google.com, mkoutny@suse.com, 
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Before 388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive
reclaim") we passed the number of pages for the reclaim request directly
to try_to_free_mem_cgroup_pages, which could lead to significant
overreclaim. After 0388536ac291 the number of pages was limited to a
maximum 32 (SWAP_CLUSTER_MAX) to reduce the amount of overreclaim.
However such a small batch size caused a regression in reclaim
performance due to many more reclaim start/stop cycles inside
memory_reclaim. The restart cost is amortized over more pages with
larger batch sizes, and becomes a significant component of the runtime
if the batch size is too small.

Reclaim tries to balance nr_to_reclaim fidelity with fairness across
nodes and cgroups over which the pages are spread. As such, the bigger
the request, the bigger the absolute overreclaim error. Historic
in-kernel users of reclaim have used fixed, small sized requests to
approach an appropriate reclaim rate over time. When we reclaim a user
request of arbitrary size, use decaying batch sizes to manage error while
maintaining reasonable throughput.

MGLRU enabled - memcg LRU used
root - full reclaim       pages/sec   time (sec)
pre-0388536ac291      :    68047        10.46
post-0388536ac291     :    13742        inf
(reclaim-reclaimed)/4 :    67352        10.51

MGLRU enabled - memcg LRU not used
/uid_0 - 1G reclaim       pages/sec   time (sec)  overreclaim (MiB)
pre-0388536ac291      :    258822       1.12            107.8
post-0388536ac291     :    105174       2.49            3.5
(reclaim-reclaimed)/4 :    233396       1.12            -7.4

MGLRU enabled - memcg LRU not used
/uid_0 - full reclaim     pages/sec   time (sec)
pre-0388536ac291      :    72334        7.09
post-0388536ac291     :    38105        14.45
(reclaim-reclaimed)/4 :    72914        6.96

Fixes: 0388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive re=
claim")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>

---
v4: Add additional info to commit message and move definition of
batch_size per Michal Hocko. No functional changes.
v3: Formatting fixes per Yosry Ahmed and Johannes Weiner. No functional
changes.
v2: Simplify the request size calculation per Johannes Weiner and Michal Ko=
utn=C3=BD

 mm/memcontrol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 46d8d02114cf..02b054a316d3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6963,6 +6963,8 @@ static ssize_t memory_reclaim(struct kernfs_open_file=
 *of, char *buf,
=20
 	reclaim_options	=3D MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE;
 	while (nr_reclaimed < nr_to_reclaim) {
+		/* Will converge on zero, but reclaim enforces a minimum */
+		unsigned long batch_size =3D (nr_to_reclaim - nr_reclaimed) / 4;
 		unsigned long reclaimed;
=20
 		if (signal_pending(current))
@@ -6977,8 +6979,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file=
 *of, char *buf,
 			lru_add_drain_all();
=20
 		reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
-					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
-					GFP_KERNEL, reclaim_options);
+					batch_size, GFP_KERNEL, reclaim_options);
=20
 		if (!reclaimed && !nr_retries--)
 			return -EAGAIN;
--=20
2.43.0.594.gd9cf4e227d-goog


