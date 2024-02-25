Return-Path: <linux-kernel+bounces-80346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CA1862DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 00:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282F92816F0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95121BC4A;
	Sun, 25 Feb 2024 23:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="IvgDWFzv"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCE328EC
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 23:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708903740; cv=none; b=GPosqtJ68NPgixRL/wJnZA45nfAwKs+ZgQakOMsqzq+zWrNh1ALHjVven9VhtoSYP1obxxkAHgQMg6m3+q2HEw4eRhQ08Bu1eFhTQzW1R1gtx2T8y7QElVMbUVa7Zy1krA3KpETNAJVBYvCY7hswpQpcTDYg5J4I1UuTq5BsE0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708903740; c=relaxed/simple;
	bh=JYqDb+EWiG9lGhTTrSezJxj3tBLURMYEVMB73IGVPWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LYm/86nmc0RRhlfranHC3uHT/TLELy0z6Zpd3206LTebDbOxCzIDNwJV8M6kdY3x71tuwLLK6BU6lu8Kc1Pc0ifL/czlh67v0IjuB02ZWWgHlOkwWJHu4gznVX+OwArRrRih9v6MjRPKSBsf5qDpIABAbT+Fj0i0Jh7PKlxWjso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=IvgDWFzv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412949fd224so11397425e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1708903737; x=1709508537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mOoug/fJ1o4Ds1BQ7HtXxre7Wl3jDmckcXaES65Kt2E=;
        b=IvgDWFzvxdL1TlQuu4r1TslkduAxt6M1Kcfst2WfHSpVvKCojfRvYP11E3jwcvsMlS
         vgjkkXDzGBNGt57nSGpajZV/NSDkPAStR3DcNdtaSrq/M8ptR1ESOkc8+lcfDuLCfFTr
         T37nqa3a+G9pqpp6qsMwfj8LZClI3HzcIbfJxXMyzqY6dvYMUEMo+36j+7yH6g7g5v2/
         pNkR9skTR14eYsT4ptBl8eJoP9YmEufq+UnP62k7y4Of9eGNGMt/zY1P6PJbFw1ES2DW
         ABOjfWGXGg6GbX+44padguTef+hdplGO2h36SCyyBpxpV4Y3oMc9tBc867jhNhGqXWoI
         MZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708903737; x=1709508537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOoug/fJ1o4Ds1BQ7HtXxre7Wl3jDmckcXaES65Kt2E=;
        b=sqn8YzXmf8ahtVbEzqSqPghuALfsinrdZLxyrpw2Az9PnJ80QcVWJ2eCZWu7ZJF2cC
         uye7kXrslHhqnkchBfu8xJBbO1Ex0iK4/xELtHydIW82OdgxQqWiARu9JDsmx1M01GkY
         zE0Zj9mDlqtrv7n4g9fYf+Xpyo0Utpqx/YW+gtVSpW9ZNMpd7nlHU+Wb535J9qQIHt7Z
         7XNhEzmIDHUfZCS1y58OCCjjd/U2FXa+yqcYRQ5U1JB3bfJ5ishPjxCPLNdNUn+YwTFx
         Xw1J7gpCHwyYDuSp6eCj2ytv4GJk7h6QyDo3hC6F9GXj/y0FJV20crGE2sEPqA0u5S7S
         7oxw==
X-Gm-Message-State: AOJu0Yya1yHnpjzbNoFcXFjmzXRzYWv0tRCwYe6L7H1omgZKO6nZTo41
	8ZB2hCm3ukxKgrQCgeHB3YuwigQ9qhvpnLRxCSmU/qYqyOWEN5gQBaoSqTVa9kLF1n40JuZsL8E
	l7BUntg==
X-Google-Smtp-Source: AGHT+IHYvjdQBdkoiJ5uvQcdAbTExkDGFKiATkYmYQqFLFOqAPVvNLpikGDm5yyX/3kxJ2PXDl+vog==
X-Received: by 2002:a5d:634f:0:b0:33d:39db:a0f8 with SMTP id b15-20020a5d634f000000b0033d39dba0f8mr5078147wrw.7.1708903736554;
        Sun, 25 Feb 2024 15:28:56 -0800 (PST)
Received: from fedora.fritz.box (aftr-82-135-80-35.dynamic.mnet-online.de. [82.135.80.35])
        by smtp.gmail.com with ESMTPSA id z6-20020a5d4d06000000b0033d873f08d4sm6279675wrt.98.2024.02.25.15.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 15:28:56 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] time: Use div64_long() instead of do_div()
Date: Mon, 26 Feb 2024 00:25:42 +0100
Message-ID: <20240225232541.17659-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes Coccinelle/coccicheck warning reported by do_div.cocci.

Compared to do_div(), div64_long() does not implicitly cast the divisor and
does not unnecessarily calculate the remainder.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/time/jiffies.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index bc4db9e5ab70..9d23178e2b6a 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -91,7 +91,7 @@ int register_refined_jiffies(long cycles_per_second)
 	/* shift_hz stores hz<<8 for extra accuracy */
 	shift_hz = (u64)cycles_per_second << 8;
 	shift_hz += cycles_per_tick/2;
-	do_div(shift_hz, cycles_per_tick);
+	shift_hz = div64_long(shift_hz, cycles_per_tick);
 	/* Calculate nsec_per_tick using shift_hz */
 	nsec_per_tick = (u64)NSEC_PER_SEC << 8;
 	nsec_per_tick += (u32)shift_hz/2;
-- 
2.43.2


