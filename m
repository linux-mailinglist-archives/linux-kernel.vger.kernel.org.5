Return-Path: <linux-kernel+bounces-18127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A778825933
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F23C2B23B98
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A4234569;
	Fri,  5 Jan 2024 17:39:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3773328AD;
	Fri,  5 Jan 2024 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-555144cd330so2313723a12.2;
        Fri, 05 Jan 2024 09:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704476365; x=1705081165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJ864dYz0Y/ieesbskVDxoJcEEeyC5EY2kKFTREupmw=;
        b=vv5XuswkR3iqdG+N1cvCw2j5vcA3HcOak4oSa4Y/5rIdCllm2xM1of5aLMvWsgNGpw
         JcfCFuUqUrKe9SLwWMfX3aG2UBkNLOVHEcv46BdCdSxv6pUeme3O0PXmYAAsQfY44ubS
         eXR8s67fguMBYAdeCW+fXdczgWwNmayKZV0lyS17zia1/8ZdflMsjd52aI/SGFDVD0pE
         lltakgRFhVcYRYsE3/iM+3zQnerOROQeFJaKNXHHYNZQnEtWvbK1XeeMTjcHSrVAG6Fq
         C1fDchM19YPebBjwMW9B/N55z/31W0yLCDD0tzn7aUKy8A+c7gTFqDXBt1zKvUklrr2D
         +PTg==
X-Gm-Message-State: AOJu0YwK/qSlvdObNwrqKsEZqesAPaEjpcOv4ct0f/7ttx9fGZYOj19c
	6U7VPWokmINwdyM2Wc36ZPQ=
X-Google-Smtp-Source: AGHT+IGyQ5UPMpiPztaoNOSolUVO5SxStnGCTjj8mPdURwzEdikfftdAYvKOznarqWAM8jLdGt6i9g==
X-Received: by 2002:a50:9e06:0:b0:553:6b20:b707 with SMTP id z6-20020a509e06000000b005536b20b707mr1633983ede.15.1704476364965;
        Fri, 05 Jan 2024 09:39:24 -0800 (PST)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id g1-20020a056402114100b0055534d5e75csm1186668edw.6.2024.01.05.09.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 09:39:24 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: leit@meta.com,
	netdev@vger.kernel.org (open list:NETWORKING [IPv4/IPv6]),
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH net-next] net/ipv6: resolve warning in ip6_fib.c
Date: Fri,  5 Jan 2024 09:39:20 -0800
Message-Id: <20240105173920.1041474-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some configurations, the 'iter' variable in function
fib6_repair_tree() is unused, resulting the following warning when
compiled with W=1.

	net/ipv6/ip6_fib.c:1781:6: warning: variable 'iter' set but not used [-Wunused-but-set-variable]
	 1781 |         int iter = 0;
	      |             ^

Rewrite RT6_TRACE() macro to keep the variable in scope.

Clang 18 removes the trace completely from the binary when the trace is
disabled[1], so, no overhead is expected with this change.

[1] Link: https://paste.debian.net/1303162/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/net/ip6_fib.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 9ba6413fd2e3..d2ef60ebeb25 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -30,11 +30,7 @@
 
 #define RT6_DEBUG 2
 
-#if RT6_DEBUG >= 3
-#define RT6_TRACE(x...) pr_debug(x)
-#else
-#define RT6_TRACE(x...) do { ; } while (0)
-#endif
+#define RT6_TRACE(x...) do { if (RT6_DEBUG > 3) pr_debug(x); } while (0)
 
 struct rt6_info;
 struct fib6_info;
-- 
2.39.3


