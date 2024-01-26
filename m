Return-Path: <linux-kernel+bounces-40662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CDB83E3CF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4E528731F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C362B249FC;
	Fri, 26 Jan 2024 21:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Cl1ia1m"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A816425563
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706303972; cv=none; b=pnl4A8OgPfNuBOO84IvZw1aDZTd4nBYyQlYIF1GRzp6hV41bNR5yd1nfH88yo4qGCBlnOwJO/yLZUdYQD2tvjG1IUc+ulFO8azTa5tudtl7/reHIkEmov1p1NDGDan+Pyhb/OwF+OVypx5r/glpGyv0DBvzoKYfDPlg4d85vfIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706303972; c=relaxed/simple;
	bh=iZ9/NOwULnLgCu30iHG6IXsA/6yP47MV5xrO2yo/sEU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lb6RS2sUzOyi5JO/zDhAUZd5M81MJIlT5IYfn7NNkL11Pwaqt2d6HAEemf+zppCfoZy793pt+R7Xkw5wF6Oc795ZnahpUbSiqDdX/NFbZA7SAOsOXHgtIUBLatvUFfu0aMCGxaXR3y7eEf+FrNAVOgPjDgs5K6FPQOMe6fuJR7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Cl1ia1m; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d63c7c4248so1875906a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706303970; x=1706908770; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SSSmPXy+o6tjb/tu3Cmmv9kAukC4V0XKiEOwf1LwTRI=;
        b=0Cl1ia1mjVSvnyvNpTdyBGKkPkxbDfvd/D28Rz2RlDHbXgmxWaCDiGnX/SUPuL3X+l
         vfbGLDRErommMjd98e2NUSIHyrcJrz61H+xxiWJlqU9Cn7a9CvSA31LlY6rKO2KjTSrv
         RLmn2NiXUxmvou8ISv46xYkHvKkKwdXDKOB7TJA+FVyT/7jGfjR526Gg4StjgFxMPBdy
         BE4smedOVTATzy0H8JVpjABHz1rshRy+9qclhQBJ7KzUZdfv0W1g1u1I21Ej2ZrfJDIE
         eDTFGJ8gDWyolb0sj014jGO2ujKYFj5HqIBb7kzIMBAkbfyOvY6KTf3NNkoJphFkaeqZ
         2epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706303970; x=1706908770;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSSmPXy+o6tjb/tu3Cmmv9kAukC4V0XKiEOwf1LwTRI=;
        b=AHdVAeHlm0MbPvxWdUSsw4FCR/ggfJPYSxgdXpkT+81jhfqAYzzA0mWXgfkFcy6KWD
         eydPwGdmEwKlZuVzACo27hnhykwpzieUuG4Zixszh9pYYIkMR27qxHmxxdgePHEJavre
         7fw8VyHocNzNnI8y/J6slLpSME3J+pyX1g09F3AZcLqXKA17U7eopnbYMk3P2c0mzsHD
         dLifDW/hAcCOBquKS+KoXSBr1QrMEQEknNm6BZiiBkfrjvW3zukpcW+UWShQ/lm5lHbv
         tHQ36S6/qxox1PG2sJ2XhZeJcR8h+xihGmVcnc2c51T5BstHlHSjuCunaVNc4iLoRZtt
         MclA==
X-Gm-Message-State: AOJu0Yw4OBe7OCLkQP9rSpHMZuktmtVnAB3q+QW42xS7WF5nl7RsjplS
	wNBubp28dzwFxU4MGWd8dvWS4jlJBICa6mA2F4rDHRFV9PblGVrFoFYnwviDVUYThPqMBO+PyKv
	BE3WRmixYXfmyaw==
X-Google-Smtp-Source: AGHT+IGcJWdPGw8oLDxI59hFrmxzukTd0LWse+OHibEL8NCT4Uo50G49MeRK/UoAadCeD0k85qrwHAnVrXGgL4Y=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a17:902:8218:b0:1d4:3238:37ce with SMTP
 id x24-20020a170902821800b001d4323837cemr10104pln.5.1706303970014; Fri, 26
 Jan 2024 13:19:30 -0800 (PST)
Date: Fri, 26 Jan 2024 21:19:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240126211927.1171338-1-tjmercier@google.com>
Subject: [PATCH v2] mm: memcg: Don't periodically flush stats when memcg is disabled
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: android-mm@google.com, Minchan Kim <minchan@google.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The root memcg is onlined even when memcg is disabled. When it's onlined
a 2 second periodic stat flush is started, but no stat flushing is
required when memcg is disabled because there can be no child memcgs.
Most calls to flush memcg stats are avoided when memcg is disabled as a
result of the mem_cgroup_disabled check added in 7d7ef0a4686a
("mm: memcg: restore subtree stats flushing"), but the periodic flushing
started in mem_cgroup_css_online is not. Skip it.

Fixes: aa48e47e3906 ("memcg: infrastructure to flush memcg stats")
Reported-by: Minchan Kim <minchan@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e4c8735e7c85..bad8f9dfc9ab 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5586,7 +5586,7 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	if (alloc_shrinker_info(memcg))
 		goto offline_kmem;
 
-	if (unlikely(mem_cgroup_is_root(memcg)))
+	if (unlikely(mem_cgroup_is_root(memcg)) && !mem_cgroup_disabled())
 		queue_delayed_work(system_unbound_wq, &stats_flush_dwork,
 				   FLUSH_TIME);
 	lru_gen_online_memcg(memcg);
-- 
2.43.0.429.g432eaa2c6b-goog


