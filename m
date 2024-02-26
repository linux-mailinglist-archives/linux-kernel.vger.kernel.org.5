Return-Path: <linux-kernel+bounces-81004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D693D866EDF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ECF9283CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB59E79DC1;
	Mon, 26 Feb 2024 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="xDyB9ESE"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8D71CD2B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938339; cv=none; b=L2DtvnOCHvokt45PgVZS/PcxiU8mHM3Iu8zA875YMFX2uag9QPaiUTp11g3XaoglJ3Xh8h54YT6cn9bo5GszDk3ycfsvRTm/92LjUkb3Dft7H1iYlCZ32b8iVVLJbOfVClj/L2QwJxSKY+9uFIzl3GcuqAK6mJ59Bg9Vsjz+Xas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938339; c=relaxed/simple;
	bh=krkPkE2Z5L0UxpKDRAB4tBQ/QZXyjRxjCqMUWq6zpk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6Wj+BwGKqW419+O6zP5YlwgJ1ruo9UyHuecZPS4kyj4y5efFzvbqspKfJZt82NpdCzVyNk9uoMCzeBRrSdDCqIupy3LzaqrVJ7bjWmhBdx5+Zvs76FahszXG+MxfrJCtNLHxAIHFmzR1GEbfM9FXE+RaSYZkn7Xwys+gZuQtpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=xDyB9ESE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412a8b79b46so554715e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1708938337; x=1709543137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVqQ7Rjy5L8DAOM0lDlFnwur37SLSiQdNyMxMNLovDA=;
        b=xDyB9ESESOcNO8RZYRw2RQqRlb+kFDo2yy3tPUfl4dy0ru6tb/0UwPQ8SR9G9Cg6Ki
         Gnte6G8MdbNJ0x7r8qs7G0g5z0yyQRxksay8ZogvzrtMqwqdGXakxYZh3+yLWdliEsvk
         Rr7q8JGymAXMCWv5dF5fU9PhxkE19I6BnmREmbEgNtFzloQ1VlXMrPcFe7Z10h0W/BXG
         5M1QuxZ4r388Pw9q+VUU1OBg9VE06cVNpjDek11mHVyumStI6miG+2NLEdRWiCVmvWCs
         Yp0uxGc0Fx26bkrFfZtNbR2k1k6ugIqx1tfj4tl7KGfsy0pRD8DwdusXBnfNP1IORoRP
         wMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708938337; x=1709543137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVqQ7Rjy5L8DAOM0lDlFnwur37SLSiQdNyMxMNLovDA=;
        b=N3P2ejJkjJtULszpsYKM6pfPaUnQ3QVW3boVgK0VIk4+AK+pt+ek0sBKSIU29Qarwh
         2hc1+rRymWFU0FiZhmtX+zSQx62GSqoz9AaOR5RUcxvTch5RdFdKVUWSSchNnEJLLLGr
         8UBKAXvxop8LxX5EH9zcZfuhzo0xTYe52R2SOuU+dSbg1qvHEpZWQSv0fx8zJbwpLpZh
         gcYqRqyqWszX3uJc6M1dEiEujUdverFESMC1tn5WeU4mYYSWipiMULxnphp2zreH7P3P
         kI8oYNKUNCxq1kbCjgFoNSSYi8dGemZSKXce0hZAMLHLroKCyLA0dEN5GDaqdPFU9Sz1
         Lnjw==
X-Forwarded-Encrypted: i=1; AJvYcCUeeZeDMGBt1AtMDx4YmJivF54isI0BayWu0EhlciZCo6GJek5rpVwO9FQo+/0zcJa1Z/LoLyzvjnwpcR7wgO0AK/KmDD52w7anJPWq
X-Gm-Message-State: AOJu0Yw50eneta9YIhfgzHb0E37BJN2H0RjsK2vEDqK0q+JfK6wxPjFe
	LZb1/MIidK+CNqYl2u1q6yB3BPisK4/qTAq9ZwFuAqULqle9wzITL0F1VWhWzn8=
X-Google-Smtp-Source: AGHT+IFMrND3CGXr30BMgK7aqK6xYyb6lMe9pffxDZ2J6ciAdDCzXrZc//N36r9hNyKptzEOz81QOA==
X-Received: by 2002:a05:600c:444d:b0:412:9842:c4f2 with SMTP id v13-20020a05600c444d00b004129842c4f2mr5387610wmn.12.1708938336615;
        Mon, 26 Feb 2024 01:05:36 -0800 (PST)
Received: from fedora.fritz.box (aftr-82-135-80-35.dynamic.mnet-online.de. [82.135.80.35])
        by smtp.gmail.com with ESMTPSA id jd17-20020a05600c68d100b004129335947fsm11283074wmb.8.2024.02.26.01.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:05:36 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: anna-maria@linutronix.de,
	frederic@kernel.org,
	jstultz@google.com,
	liaochang1@huawei.com,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de
Subject: [PATCH v2] time: Use div64_ul() instead of do_div()
Date: Mon, 26 Feb 2024 10:03:06 +0100
Message-ID: <20240226090305.117120-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <E2A9A6AE-84F4-4C86-80CA-CC0C480FD9A8@toblux.com>
References: <E2A9A6AE-84F4-4C86-80CA-CC0C480FD9A8@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes Coccinelle/coccicheck warning reported by do_div.cocci.

Compared to do_div(), div64_ul() does not implicitly cast the divisor and
does not unnecessarily calculate the remainder.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- s/div64_long/div64_ul/ as suggested by Chang Liao
---
 kernel/time/jiffies.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index bc4db9e5ab70..fccee15e94d5 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -91,7 +91,7 @@ int register_refined_jiffies(long cycles_per_second)
 	/* shift_hz stores hz<<8 for extra accuracy */
 	shift_hz = (u64)cycles_per_second << 8;
 	shift_hz += cycles_per_tick/2;
-	do_div(shift_hz, cycles_per_tick);
+	shift_hz = div64_ul(shift_hz, cycles_per_tick);
 	/* Calculate nsec_per_tick using shift_hz */
 	nsec_per_tick = (u64)NSEC_PER_SEC << 8;
 	nsec_per_tick += (u32)shift_hz/2;
-- 
2.43.2


