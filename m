Return-Path: <linux-kernel+bounces-36365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ABD839FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4818285BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A21717588;
	Wed, 24 Jan 2024 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tH9zr1wY"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED9917545
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706064869; cv=none; b=dvieLRvjcY9/kbw/vNwV7BihYjY7enWTbzeEZJu6SmmkKpDZCraam24vKK5Ktbxx4rkR28hXxkSmalT2/Vw434HsAg4Zn1Vf+04G9FuXOrTkOiQun9t/bxWwRRWAW7F5zO1bytf7e+hveiP+G36rPI0xlp7zmjXPNbxrI55dinE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706064869; c=relaxed/simple;
	bh=tt8whk6QkKHecHFyCKI/nRn5ZBU9W9pAuOHdt0se2xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uhihqm79EcwVNnCbylNd7kk82zYoU49m8ReGeqQm+uOkEgj7Hq+ETP5mSroPAwCUMotp5KWil6D3NfHp04lESa68vfa2WItCtY3of1b/5FiQFKmw1pi3fr1KbKObhPG7PgO/aH+K3bO3Ezq5aLUehY2a/64oKnijSMmOTusvqC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tH9zr1wY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6dc6f47302bso1936473b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706064867; x=1706669667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq2iCmnPB94WcqySTTnm3WLG+4jkf9fY7fGI3ZdGS38=;
        b=tH9zr1wY32bhLbQn/L8zBfhSab4FuzEwR8XHnAg0JZxyF5etL9PHPdUzaJ52dEUPDe
         aZs2FFZBtJjjfqqAKfOWFHCosxXBC3i0vhbrN+yKlSBRUksx57UhpyNsIfo5r8vxq5Ye
         U2bIvWJLs0ih0exY0aDVnO8rRndkkhP2Ts2JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706064867; x=1706669667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bq2iCmnPB94WcqySTTnm3WLG+4jkf9fY7fGI3ZdGS38=;
        b=m7Wfyh63DUkVwk5GvtfSaptxmv4Va6HQgU5yWlivM7TRFzILN9v5X45s5NwPJugYhS
         /bzHKGEw6kXmn0ohEZkZk8neWJY5JXvarFJRfEEup5CJflhtkqfh3Hi51KFHXaScih1F
         9zvlhyOm9ki7AJqh1ePtScx52rVnE2lnop0ZtJzZd7BVgd/LqqH0OatR730MlLMDANuA
         9vmKhiV79rGOVh7ttA2lWA+Wb+lB0VhRCwQe8k3LL+7jNEvZdILOnr4xhR0StnqL336H
         ZR227p4VaLsjnSYvx24lcQipkyCMDMNDCKGmPN1NpsVB9R3DQINtFLDyG6M929p12Az3
         Qxng==
X-Gm-Message-State: AOJu0YwxYOVhVFCqg28lIaMM1TFUl4/dCztY4vYeL8sflphBS6uHDwOR
	rdtPp+jGh/KVUCjIwCB1cyYmOOLPe4D+a/tmzn13EDiPDFJHpN+dMsHyWri/xMk=
X-Google-Smtp-Source: AGHT+IGodI8N0Czn5sWE4mbKrdlX6VeLBQ+z79W6omRxv5iM82o7VtlJXdsv7TV9KmnVN9aTE4/aNA==
X-Received: by 2002:a05:6a00:3a09:b0:6db:a0e5:7ec3 with SMTP id fj9-20020a056a003a0900b006dba0e57ec3mr9228809pfb.22.1706064867592;
        Tue, 23 Jan 2024 18:54:27 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id z14-20020a62d10e000000b006d9b38f2e75sm12974229pfg.32.2024.01.23.18.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 18:54:26 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-api@vger.kernel.org,
	brauner@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [net-next 2/3] eventpoll: Add per-epoll busy poll packet budget
Date: Wed, 24 Jan 2024 02:53:58 +0000
Message-Id: <20240124025359.11419-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240124025359.11419-1-jdamato@fastly.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using epoll-based busy poll, the packet budget is hardcoded to
BUSY_POLL_BUDGET (8).

Add support for a per-epoll context busy poll packet budget. If not
specified, the default value (BUSY_POLL_BUDGET) is used.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/eventpoll.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4503fec01278..40bd97477b91 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -229,6 +229,8 @@ struct eventpoll {
 	unsigned int napi_id;
 	/* busy poll timeout */
 	u64 busy_poll_usecs;
+	/* busy poll packet budget */
+	u16 busy_poll_budget;
 #endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -437,10 +439,14 @@ static bool ep_busy_loop_end(void *p, unsigned long start_time)
 static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 {
 	unsigned int napi_id = READ_ONCE(ep->napi_id);
+	u16 budget = READ_ONCE(ep->busy_poll_budget);
+
+	if (!budget)
+		budget = BUSY_POLL_BUDGET;
 
 	if ((napi_id >= MIN_NAPI_ID) && ep_busy_loop_on(ep)) {
 		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep, false,
-			       BUSY_POLL_BUDGET);
+			       budget);
 		if (ep_events_available(ep))
 			return true;
 		/*
@@ -2098,6 +2104,7 @@ static int do_epoll_create(int flags)
 	}
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	ep->busy_poll_usecs = 0;
+	ep->busy_poll_budget = 0;
 #endif
 	ep->file = file;
 	fd_install(fd, file);
-- 
2.25.1


