Return-Path: <linux-kernel+bounces-39394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A430683D020
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6053B28ABE5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F5618EC3;
	Thu, 25 Jan 2024 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gK/gao8L"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601EF15AF9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223473; cv=none; b=MhVfCqUu/gfslf7lUB+71zHNJX+ZP6urkpyZ3KoT1TtOROVqqR9kLgz/cZ0J6FOnGp7O4OeLLiJIV2NtH34cg8E70TqlOZ0gXaGoLCpPGhRkxUibJdOVgjTMb61o4XJ6zZbtsWCoG2SQMouFUu+/s4Aos1/MFG2WFCTdjH34I2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223473; c=relaxed/simple;
	bh=3yteI2ybUubAH5CujHpgcS7qoJxKc8vJCs7EzjX9vMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d+1Oz9S4L/c2OspY03GRCI8UQolNcYdyo+nQnqee2yQlQk4/PERVP5Eb2MTqR0FYBoLFdiVHaFemXxTjBYXczgL1AepNGFKlXD1HGKEMfRc7gawAqCfn9w+g/ahN2ZTgLa/Az3FZ3neS4dzW2n0OV03/jsPJ/5gECjaGrwmUMvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gK/gao8L; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3606f3f2f37so37727255ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706223468; x=1706828268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o95DHArKhHsVxZUrtiTfK3GJrg5R+5zGPrNbLEZjDzs=;
        b=gK/gao8LZPQ14f+0l1Z/+ivgHpju3xt99PQTI/cOjX4zckT76Ao7/ofkfMZOM/dKY3
         huhuUoAasEEsNHDBwxKIkVMhT1VBnxGfnbjiPJKJbswZYdFIkXci5IsVQOmx9poTHHD1
         hWZFcA8fGZDbx+laWc3yhOV75Uj8m/jdqrEIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706223468; x=1706828268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o95DHArKhHsVxZUrtiTfK3GJrg5R+5zGPrNbLEZjDzs=;
        b=wjCQj0YAQpIhD7OWs3WSAfC9IreUhk1sCkJFSGRxAB2gCGpXgR9iE43yhSoc9v+g+1
         8fcalFX7vcSk0L7dWBQWVv9ABo8bvJ9NF4xV1S9xiu5EhdT/U7/1E2entDjouveErV7y
         2OWt23x4pH8G59izuTAihzmUlcrI2xdMaYapSzHqBZBVChdEYw5gM6IeOcxe2d/e+Fn2
         IsbeNF/JXEdhupBWtWTMCy0Zr6UoS7+D4f7FsXapmbL1Afi11kZdho80W0HY6+5FaEQW
         1O9S2lWdRbEd+tPzQS0FizCOiUOWbytCyyG/yEdmt5SM43UAKRBlKYiBGSkHS+emhVwj
         yhXg==
X-Gm-Message-State: AOJu0YziTTNUYl1oTWE+wInC37WHLvrUX8H5JZsT9jYukQqTGjzUVCJ2
	FzEjVRYvpYQOmT4sSBOZuvU8fsoPh6xQTnnKsKS7kJ9hRbppI1C42xnQH3gtFU2JuvCPfgdk0NV
	QwZL0c2K3kvbHMgtNN4RVtzFIqEn5HozUbWIa5rzxaiuIUKH+NrWoaiOdKRr1d/MU36ryOic5Kl
	YMINgmSr3l05UfMNOks6l9+Gu5pMTWWOVZQPiv5pouWUsayg==
X-Google-Smtp-Source: AGHT+IGAK1VuD1OD6e8Ft02aMvZ4LCBGzC3c9/ElbXUFGVr5EYlwpCty3o6SVFhtKkGYwoGiIA7Yrw==
X-Received: by 2002:a05:6e02:12ea:b0:360:76fb:a894 with SMTP id l10-20020a056e0212ea00b0036076fba894mr557277iln.62.1706223467756;
        Thu, 25 Jan 2024 14:57:47 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id z24-20020a631918000000b005d68962e1a7sm19948pgl.24.2024.01.25.14.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 14:57:47 -0800 (PST)
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
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
Subject: [PATCH net-next v3 2/3] eventpoll: Add per-epoll busy poll packet budget
Date: Thu, 25 Jan 2024 22:56:58 +0000
Message-Id: <20240125225704.12781-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125225704.12781-1-jdamato@fastly.com>
References: <20240125225704.12781-1-jdamato@fastly.com>
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


