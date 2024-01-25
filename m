Return-Path: <linux-kernel+bounces-39174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD04A83CC0D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461E91F27A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F35B135407;
	Thu, 25 Jan 2024 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ReTY6K6r"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA9A13474F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706210337; cv=none; b=H4TVg71nLczzsngRZ3TC/cu3bhK+Z0HnRZUgHX0pvKOa686E6tL3iAFZLN+K+VKpp/5OQSwL9kf93z9nBwl6goGj97rNQz1tD8Rlf3VWHMl6iJTS4mTcgVlQ8ynuTRHm0KtiJ9sQd+hstzOyAk01DMuki/71605MytwT4Jma1to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706210337; c=relaxed/simple;
	bh=lab1cc/BnvmVMoI/6a4oqJtvBk6zbJgk82AeHiJrUN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OBrpvMk39STUZS3erLw8NPSqFOdWflcnB35hGyo3lnBDt2SDuXYvNJQISP5SlFVkBE++56CBnqaigH8hey9GAKCHP3gfhxv0CpeoZmbEIvEgYvLlIpCLF4i1uwgRPK8VyZee8yUb+ibvDakmM7wkLpX0kyWqStZ6UmFkavMW2wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ReTY6K6r; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d89518d3b1so4104515ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706210335; x=1706815135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vgDFOq40XBBKNZXci2Ggytp+MQppzv/horYrfyyqlNM=;
        b=ReTY6K6rez9zYsde1a6ELbDDYS6P2XW2eDpp09JX7+NVwe3U6i6nEMXhDs0OizXU4D
         GEJZ3Cz397l0rhkMwHl7RbIZMi6SMEy4RchuVeSgEl5Q0pup4hxzuz7mStpkPDHWZDWJ
         4PRRCGxabQ7REwDpcaiwfS3u5wO0frQ7IHwgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706210335; x=1706815135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgDFOq40XBBKNZXci2Ggytp+MQppzv/horYrfyyqlNM=;
        b=YrE0CDOevg/LkKi3x1iDjU3oznAIHtntG89ROy5W6zFbkOSgNaCO8xnvrEQn6jy1qS
         Frgo0HllDlbNekgeDikw4HQrnJNKwTGK27UkdLt909k7h/mYOs88Gn6t5TiwkLW5FL0u
         whDDqueNFT43kjCIUOvK617ePmX9o8PsDtyoKG5j42SBNDV1SrrvQf/kFqM19NcAG0ym
         4tKeoGSj9+6wkO/ZZkjI5HPeVb3Rg4LDljA1G6KxKTEdkaZwr8bZhuOi9TW4BZ+WVsuM
         BCqB/mxHrzy8wECkMGf0FAMdZiiUItJVfPOub7YKTH5Dd2FRSmIPhHn/PQG941PwiHWl
         JJKA==
X-Gm-Message-State: AOJu0Yxmt/Ldt+V4etCxTrH7xjqLRazSkfxui/7zR7p4i0stjKNEtB/3
	I+C9HTlYFwBW/M+31c8C73/6hltzomksN6wY/R55i53dHlhLW1PIKxwMtelTbbzA7BY2cLes+4b
	B47EsZnEK5LZ2VMPKBRQ8heMHEGYVAjz3LWkvNq+QPMEkusK4CqApWNg29aolOgQ7lJ+umiEI5l
	wjp3aUIaTgrwX/a4nubiz0dxpjppblTbx4N+sZpJJbx4s=
X-Google-Smtp-Source: AGHT+IHdKHB94OhPgZOVY77ABy+eW7S+fOS7rs6rmsVrvHAqW+Nt5DJrWXeJyflcQ9xYvVmNTGX+MA==
X-Received: by 2002:a17:902:ced0:b0:1d4:bd1f:e4b7 with SMTP id d16-20020a170902ced000b001d4bd1fe4b7mr29761plg.24.1706210334003;
        Thu, 25 Jan 2024 11:18:54 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902d0c900b001d706c17af2sm12215017pln.268.2024.01.25.11.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:18:53 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	alexander@mihalicyn.com,
	leitao@debian.org,
	wuyun.abel@bytedance.com,
	kuniyu@amazon.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH net-next] net: print error if SO_BUSY_POLL_BUDGET is large
Date: Thu, 25 Jan 2024 19:18:40 +0000
Message-Id: <20240125191840.6740-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When drivers call netif_napi_add_weight with a weight that is larger
than NAPI_POLL_WEIGHT, the networking code allows the larger weight, but
prints an error.

Replicate this check for SO_BUSY_POLL_BUDGET; check if the user
specified amount exceeds NAPI_POLL_WEIGHT, allow it anyway, but print an
error.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 net/core/sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 158dbdebce6a..ed243bd0dd77 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1153,6 +1153,9 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			return -EPERM;
 		if (val < 0 || val > U16_MAX)
 			return -EINVAL;
+		if (val > NAPI_POLL_WEIGHT)
+			pr_err("SO_BUSY_POLL_BUDGET %u exceeds suggested maximum %u\n", val,
+			       NAPI_POLL_WEIGHT);
 		WRITE_ONCE(sk->sk_busy_poll_budget, val);
 		return 0;
 #endif
-- 
2.25.1


