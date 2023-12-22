Return-Path: <linux-kernel+bounces-9229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CCF81C29D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77EB31C23629
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83763138A;
	Fri, 22 Dec 2023 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="DGOi1nn7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AFDA41
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 01:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c6e2a47f6so14329275e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1703207647; x=1703812447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4AYqORwDz1jRnysZB/QYLSUyIuQ8pE/C0Rq3AFW3pZQ=;
        b=DGOi1nn73FKmTiKQd1CfexRMt7DeaMr/0Ee7gwKRCnaaptE0WaufQa1bG362/1mhVT
         ROEeOfmyKiOUEBS4cg7nIHhjr0RBI3IMq3i5fcXKkDfksgEHE8FkoXKOt/SJfN1IsBRK
         0Myr3/BiHhcJ9U+e9Z5sTFMQ0t4Pl75F+wj4QKT91bdkjjAkxCT6/2VDHrfCO7wbP30f
         Ta048lqwT4spZllunZmRWt3Vez+mphp9oeYPZZSSDsDrHj1EyfahPFRqmXlDVLsMOgvY
         E63TFmoePnk538E7cM3DhvhRvjtp3LkjWdbd/Eahjr7t32kQ1loHlStZ+oZ0K9wbXyKR
         Hykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703207647; x=1703812447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AYqORwDz1jRnysZB/QYLSUyIuQ8pE/C0Rq3AFW3pZQ=;
        b=IHe8wZpBbuUBNYsKe6inerKmCycgS/r+b01U37gI52luo/zqoKHbmaiFSq+/CXlpyV
         unAWCXPkhvv7oNPe0wd6SKpmmvPAngo9ghx44N9fvo+XwxMkRI8+uQR9v7dvgDuycayA
         3HBp99VP+E2UKzbYa6WLjZRB0EEFd34gDel53mwx4NKHzvIgZVjhePnWM/jgdj7f1axl
         LQUeycipeoTmdQ958iMYiJqKQuE4leK12LffD2z2uSXXz17DjWglfUw+Rirjze1jC3HH
         Xapv6IwcHMKVXG0Uz+YYABeRjV1zvUjP/YGFqVXbksGxV6U6oY7eUg93gxVNW0oxKf7J
         Umyw==
X-Gm-Message-State: AOJu0YxJp0BYNlujhlweoscF1ksw5Lmy0HFi2LF67JYfA+AxKbCY6L5h
	Ye1hg4nfx1nS9wGxX2vKAj7CbUjnnc3O
X-Google-Smtp-Source: AGHT+IFPw/KAJEzLFeKSdjiM6DqfzEUf2lLQrvkGjEV4RVjI8hJHmBeNh0BLw7UldWaB4NAqc0CgCw==
X-Received: by 2002:a05:600c:a:b0:40c:4716:5116 with SMTP id g10-20020a05600c000a00b0040c47165116mr148388wmc.260.1703207646782;
        Thu, 21 Dec 2023 17:14:06 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id bh20-20020a05600c3d1400b0040d15dcb77asm12893958wmb.23.2023.12.21.17.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 17:14:06 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/tcp_sigpool: Use kref_get_unless_zero()
Date: Fri, 22 Dec 2023 01:13:59 +0000
Message-ID: <20231222-tcp-ao-kref_get_unless_zero-v1-1-551c2edd0136@arista.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703207639; l=1189; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=HyHdpdpf+8IPxstZOUIyu9E1qEH2nY16X0RtlouQwOg=; b=1K3hRfXyCvhRQ6tlDUVpu06PCZt8oDM0ZZhz0g7Nxd18BnbJmRTO5Ih0UErsTrnhYl4Dz5sdM v509Cm+vOnoA4npCoa1gjoitDE2qU4McLkx2ymxr8+hREeqwNpNCezb
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

The freeing and re-allocation of algorithm are protected by cpool_mutex,
so it doesn't fix an actual use-after-free, but avoids a deserved
refcount_warn_saturate() warning.

A trivial fix for the racy behavior.

Fixes: 8c73b26315aa ("net/tcp: Prepare tcp_md5sig_pool for TCP-AO")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp_sigpool.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_sigpool.c b/net/ipv4/tcp_sigpool.c
index 55b310a722c7..8512cb09ebc0 100644
--- a/net/ipv4/tcp_sigpool.c
+++ b/net/ipv4/tcp_sigpool.c
@@ -162,9 +162,8 @@ int tcp_sigpool_alloc_ahash(const char *alg, size_t scratch_size)
 		if (strcmp(cpool[i].alg, alg))
 			continue;
 
-		if (kref_read(&cpool[i].kref) > 0)
-			kref_get(&cpool[i].kref);
-		else
+		/* pairs with tcp_sigpool_release() */
+		if (!kref_get_unless_zero(&cpool[i].kref))
 			kref_init(&cpool[i].kref);
 		ret = i;
 		goto out;

---
base-commit: 1a44b0073b9235521280e19d963b6dfef7888f18
change-id: 20231222-tcp-ao-kref_get_unless_zero-fe7105781ba4

Best regards,
-- 
Dmitry Safonov <dima@arista.com>


