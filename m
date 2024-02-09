Return-Path: <linux-kernel+bounces-60020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0706284FEA1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F20F1C25A9C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68B53A267;
	Fri,  9 Feb 2024 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="b+oKolW1"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5545339AF2
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513350; cv=none; b=CqS+KLqckHSmPosJ17o5gQvwQWofJ7lSx6n61LrK0QPXzm16pkSLwpnIsTTnddOkz6Qmlz6riRd4jPmVyxfKRbxGmwzKMaHgcFQIbe5ZjzStwoaDhLcdzOqcnFGK7MBF7dG5p4RgoWrEQiwyppUI/82hBoZGawsNzfQ1BBTjdmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513350; c=relaxed/simple;
	bh=L4RwZXaFjOs7euXjMxwYiABkrXXZbZcKloyh3rbhzu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t6BB34qGvURvX2iy6AyA+wdrE3LUBNmVoq8cpJPiqmQfVyBHZEy2EAXhrMxVscG4TtJ3DOnNA328oirvSYQk/T6z0hN/VD4x2vgmsqnRSUmdbZqjDanl1SLcIzVtwDEypvbnVBvQR/CBjsEVFrilWk8HkWnTLJt4/7JC7gAMtww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=b+oKolW1; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e06725a08dso1057098b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707513348; x=1708118148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFThVNztewuogOwemulUSfgykwCuDZCM+kDTpLgPy0E=;
        b=b+oKolW1DTy82nN0oHPSubUTCq0lfavtXVbB+bq7BhtLyG5UQz2/UGVrWFoqxLXtXZ
         dVRnG/xGHm/t8rC6wEND/pRFlk4EvZLpzlsB3pJmN3pukc4dAwBYqSP8jIr99g7Olovb
         5lzKrpzLmclX6vrZj38Tco/LFCzUmVtqNHkfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513348; x=1708118148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFThVNztewuogOwemulUSfgykwCuDZCM+kDTpLgPy0E=;
        b=bHitKsVNPD/hLvSCX/8g1P+Ls6Q3SR2cil5iilECAVBPdWTi0P9UkwjsS93JT/Ci0L
         jGiFk4QNpn9kRJUswzK2Bnu5QSuWMmGlON9P+i9u7r97fKk/CqJkEg3HWJGfZJk7XiCt
         taemAswDDAbTojBiRa7NzoQfgsX2cKi2rrmHxBJLzFFc1mGdaB5JgK21Mh8eaMJQUj64
         8akIYAHNzexQl7mv73aQhOb5rl6JI33GqN2nt7/zIH4m+cHygHxrWfQcGwZtx/XUeFvq
         93KOBCM293AQH23ENfhDpEW1WmdSrgSQvAkxtiJG7dG4KNVh3PvHe//bj30f5fZbBX7D
         Ri6w==
X-Gm-Message-State: AOJu0YwbNE5pk1f/VkAd/JlM/dc+Rz8RAXg+UCTrSLhmZxu1EHctMhh6
	7Z4O2LObaooAzqoCqX55zwxuKvJOgkwSpXYmvD4nJ/Y6yBo6v/pUkptWz0rW1J/G3pGSfRtBBbP
	57KL6+atoEcYdY2xpJQmAGgVmenN2d2dgZvvrW1Y/dyb4J1J4MmGZznB7pMk3CPS21vALOqFwch
	JGYenOJWZXFX4MDWZXqlStdxxIUJQfnWxqq7AnVj/T3jU4TA==
X-Google-Smtp-Source: AGHT+IHBtWZUAFvJ7g8Am1KSc4m3iLUyccIs9HN9bZVz88EdQc9f018q6t7kU5QG9vMdtqZXX3RafA==
X-Received: by 2002:a05:6a20:d708:b0:19c:8d73:721e with SMTP id iz8-20020a056a20d70800b0019c8d73721emr464952pzb.36.1707513347879;
        Fri, 09 Feb 2024 13:15:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVdfNV3zIRMqCFWm0pUC8hu56lzq0vEgBCLGbtY0asu7ymZ5imx6EuZrSCehX/vvQ8oqWC6oUjGT+11xrnw2ltOPIfx0BIPn9mTkH3XYri9Y4KwD9wFMlJxRkPFBBcOUb7GxFHqJRwHwwkUc286hkZznY+jNz1pSnmV74R9Kv3uv+DskkGQvb2XrOU+AtdzbMwdVM970wFrPdGDXbeNfsY1KkeDRZL2iONNd75Q18hZhliWAZsjdRFiDV2z3qEh2Sm1keYNhjbpAYwb+wCXbTwMnbYvZhq+6njlY8t0iTq+EAaaUaq2Drpc+Sb0zwS6FPNBNVFXr570xg7UPO+pPusZj3GSrjKB/Dpr0eNDdQ0BKl0BF7l6CzXd5b9anDK/ltX3YwdBp8r8bdIs1M5TNd1E24E9RicTb7jvvmDgL51zokAZzyzqyUhz3Qvu7Qs0x0KjL+8L1PCUYwBkh0whJK1UTAt3iJXUjxzhP5T1sGJlqJ+djLuJGYx05CE6B+dOhdxGV0/vHZ3prPDyNTtUcrIfrX+mNXG1G5KmREXRS40SyQOzcumij41wqEK/HkeXUXPF9GUZeGUDLlklma/nmL3I1IBFeGTrC2y53gyOLsmEBfPSw87XKwJPdDFTgEU=
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id x23-20020aa79197000000b006e05c801748sm969629pfa.199.2024.02.09.13.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:15:47 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-api@vger.kernel.org,
	brauner@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	weiwan@google.com,
	David.Laight@ACULAB.COM,
	arnd@arndb.de,
	sdf@google.com,
	amritha.nambiar@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
Subject: [PATCH net-next v7 2/4] eventpoll: Add per-epoll busy poll packet budget
Date: Fri,  9 Feb 2024 21:15:22 +0000
Message-Id: <20240209211528.51234-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240209211528.51234-1-jdamato@fastly.com>
References: <20240209211528.51234-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using epoll-based busy poll, the packet budget is hardcoded to
BUSY_POLL_BUDGET (8). Users may desire larger busy poll budgets, which
can potentially increase throughput when busy polling under high network
load.

Other busy poll methods allow setting the busy poll budget via
SO_BUSY_POLL_BUDGET, but epoll-based busy polling uses a hardcoded
value.

Fix this edge case by adding support for a per-epoll context busy poll
packet budget. If not specified, the default value (BUSY_POLL_BUDGET) is
used.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 fs/eventpoll.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 401f865eced9..ed83ae33dd45 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -229,6 +229,8 @@ struct eventpoll {
 	unsigned int napi_id;
 	/* busy poll timeout */
 	u32 busy_poll_usecs;
+	/* busy poll packet budget */
+	u16 busy_poll_budget;
 #endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -435,10 +437,14 @@ static bool ep_busy_loop_end(void *p, unsigned long start_time)
 static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 {
 	unsigned int napi_id = READ_ONCE(ep->napi_id);
+	u16 budget = READ_ONCE(ep->busy_poll_budget);
+
+	if (!budget)
+		budget = BUSY_POLL_BUDGET;
 
 	if (napi_id >= MIN_NAPI_ID && ep_busy_loop_on(ep)) {
 		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep, false,
-			       BUSY_POLL_BUDGET);
+			       budget);
 		if (ep_events_available(ep))
 			return true;
 		/*
@@ -2091,6 +2097,7 @@ static int do_epoll_create(int flags)
 	}
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	ep->busy_poll_usecs = 0;
+	ep->busy_poll_budget = 0;
 #endif
 	ep->file = file;
 	fd_install(fd, file);
-- 
2.25.1


