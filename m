Return-Path: <linux-kernel+bounces-134105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8050189ADAD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 01:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3671E1F21689
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 23:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0FB58103;
	Sat,  6 Apr 2024 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fD1DY5P0"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024A4482C7;
	Sat,  6 Apr 2024 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712447741; cv=none; b=k124R2QHJIJIxKaxtv6Q6pyQA2QFjc4ATVdN+ZH7KZwwpnpsm2wXsV0xItLZ2Y+c+yEEhhc9j9M6AUswVaPJybmuA/3ZupEpbeCCcdSi3IcPDuz+ZMCFW78VBsRqQQ06GfT+UBadKt//EGdjEm3UD4Ws8C/Yv0LuEAhwv5p7Wkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712447741; c=relaxed/simple;
	bh=Z0fSrQayCZEZ7BN+ls9wJNksXQi4tTCQ51JwCFxbtVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oRtKHB5uY1UH/i9L8sApwWT7gcr8fuhJoh905JW+F8rmtPbJcycCEvmdGkY7ibexp7KbjQxXPv+XDj+DI6IUIw3UEcRelM9FZoVD36XOBmd1RsDXBpmrqeeXlgNWNqVOJby5azoLkq0txd9n563WwRUWKNMCOtxq1c1afc6n9Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fD1DY5P0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a2d37b8c4fso816995a91.1;
        Sat, 06 Apr 2024 16:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712447739; x=1713052539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AXM7kfM1Z58yWKWsC/e8tiwljIuUChOEbm514WnQ12k=;
        b=fD1DY5P096pY7+SuZlyA351kB6jXujeOuSaJ8MtVKcZPTbvKx5uQgLWRwtY+hKd1xP
         Ggi6AarBCrJRh7/VBXuDr3GTvvcgoKWK9048a3JZarPxMNhNHxqjH6ijzKh0MZYzOFHX
         3aQcWwSLlGqsUd9NXjS4FOWEMnfAD2+uPE8+ZNKQJOnb9VA7tyn06VyIOtxZWfXpj/rN
         19LO0ncZkKIJ2WjHk+le3VoHvpz0HioHT7qj5TROZKe5RXWQbsureD5fYqsfZKmYzlko
         O3upYT65SeRYHjz2/A2OirKBRe1ZxNachOGwCU8olJZ/bqcEreEwYpm7vgzXxoCvfhMl
         BaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712447739; x=1713052539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXM7kfM1Z58yWKWsC/e8tiwljIuUChOEbm514WnQ12k=;
        b=IzZUgzrX0v77VH9t620vWPbyKi6bAiS/rjvkTuzFAlEbnSiASzk9rGQiS5bEmKJf1K
         hnEx0HrEFWsfME/7YEIR7wMdL6wtrpWapsqY44OziEAqupsgA+Oan31tNS1CdP2ltiNY
         vjeNgbHX6CgDt60FlqyuFElpKlYF4efJRYHR80+hP9oa4YEby8FpxmzuiZchSyx2riku
         uugeMrQPci8zAokn5ApEu4JOYX/uUQNzPrXh+z/05asIr2BlEjqC95R/FjbbLfrXZgFW
         OkBff98xDc9Bc2jg7ZyAHvhcH/L1mCQAbwRPJZDU3FoetVaS0fkH9HWTc+L+1pNcJPXv
         bcNg==
X-Forwarded-Encrypted: i=1; AJvYcCXVPJpycba2P7Ofx5L/r5Tr1EdYEt+xam15mIwm7LGZKMzJyQmHPgY2Ct2IucUk2kHET1jrfNr71dmh9xZsPC6JQEb8WD4UoSx4bcws1iA018RD5adEbaal1lUwTVbxOnZ1YmqV
X-Gm-Message-State: AOJu0YwPfVmaPhgw37zuN684MgyXeMSO35aBmW2nTv0L4DFv2mv+JMX1
	CGWwAXeQUGptzUD0U0t5Hid+4Z/EL04ppJ+sjcniy9z3Na4sz37B
X-Google-Smtp-Source: AGHT+IE3B5Pz+/ZkseS/mNk/yx/nQmMtrI/bGxa3Q0nv17K2q4uzMUrg6CzyBHy6NMcob3bTLeEQEQ==
X-Received: by 2002:a17:90a:8996:b0:2a2:83b0:5fad with SMTP id v22-20020a17090a899600b002a283b05fadmr4669920pjn.2.1712447739216;
        Sat, 06 Apr 2024 16:55:39 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id bt8-20020a17090af00800b002a2b06ce909sm5460178pjb.17.2024.04.06.16.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 16:55:38 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: toke@toke.dk
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jserv@ccns.ncku.edu.tw,
	cake@lists.bufferbloat.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH net-next] net: sched: cake: Optimize number of calls to cake_heapify()
Date: Sun,  7 Apr 2024 07:55:32 +0800
Message-Id: <20240406235532.613696-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the max-heap construction process by reducing unnecessary
heapify operations. Specifically, adjust the starting condition from
n / 2 to n / 2 - 1 in the loop that iterates over all non-leaf
elements.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 net/sched/sch_cake.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index edee926ccde8..2eabc4dc5b79 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1512,7 +1512,7 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 	if (!q->overflow_timeout) {
 		int i;
 		/* Build fresh max-heap */
-		for (i = CAKE_MAX_TINS * CAKE_QUEUES / 2; i >= 0; i--)
+		for (i = CAKE_MAX_TINS * CAKE_QUEUES / 2 - 1; i >= 0; i--)
 			cake_heapify(q, i);
 	}
 	q->overflow_timeout = 65535;
-- 
2.34.1


