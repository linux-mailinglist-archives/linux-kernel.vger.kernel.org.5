Return-Path: <linux-kernel+bounces-143917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9FD8A3F85
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 01:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC8028226A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4402053E0C;
	Sat, 13 Apr 2024 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl7AgR88"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180E22907;
	Sat, 13 Apr 2024 23:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713049524; cv=none; b=hdpMApI6ikcS7kt1zCAVk27RKiLFpFRHi6xQobFkyTQyVrNfRao7r3ViN53xRWjfGmaNY+zcBvEosWrZ/24/Wqa5eunmSkedH+00JCqnnA/IL5oE5QYuFueB62MEFLraoulWoJXmJJKEj2ul7AgaInkUclwYbWvyNCCNfQ+Y+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713049524; c=relaxed/simple;
	bh=8QEicRx42xj/J7UkEpto502zcBqvBEWrDJOliH3rKmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3Ja3obQkeQ8XfMuXeD4HoHzbiOZQwrlYTEdLFlzgM43XQsjM5G637T2pFuUtIK1QMR4yVPZ+2yjq+aD+mE/VgswVVkrljXwnNmgVgRnzLp9+ip9SlKw8SeCy95ijZprUV0DWWZ3OEumOog7SAEPsMxFzLj8Ezy5ohy+Kdf11Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dl7AgR88; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-416a8ec0239so10775615e9.0;
        Sat, 13 Apr 2024 16:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713049521; x=1713654321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=07rvDcYqUh3/Dt5nvYFufhJtipnvIOms6QidQpuPmH4=;
        b=Dl7AgR88nZpWBnOewfRFvZkgVA8xxRKKP6/OExj9qWQ7hmty+ai0lUB5eCWOe30thc
         81Z4V9+bUUfDU+rmChr7wFwY05Z8v9eud//1t1r5wIFMNWmABM1JwiZlukqIxC+COrL3
         cJtD4OaYMrkZOhKRs4waNMG6v4yW0HpbrlR7c9L9BHcfzN4XfuuDZq7FNfP3p13+AX+G
         i99SWni8mO5Fm7B4KJqj7UAASHAbgCfa4xegHDRuqMteIbjjmVJujx/BvlMGbkqtNV5S
         WBiL7xYPNSpmdUFT2PDV0XDuhPz1L0Oj7mL5vssQ5cdii+UKSwYfIlHDilgrKOm6WBNo
         SDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713049521; x=1713654321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07rvDcYqUh3/Dt5nvYFufhJtipnvIOms6QidQpuPmH4=;
        b=e/mMInGd2QEs+LHfbeaq3jVxImKLIT5reaN6cUCydAV5E6Cvh6fAVRsVJV4+2yhH4V
         kSf5fAK+JVWILXxdRFavZD0Pr6O6qjFuYGzg2uYq81ayXASrqdPoU1q7DTGK9J9FFEVC
         FMX3xofU0pXJbZTQnrGItbrSRbj23X900PlMy4zZcdzsIq+JCRgyrEZPLTUl5bP63sED
         29n8RqAbyXuJ620dhT05jF43Q4dSfVVwO/jQ9QS1CFuzZK1/51t11Ju3Oh9nHrWbO/wV
         KulM7XboH9HbORUE9aHYA3D950RG+6v+S9HntgWZQTL0kg4Y7ZIHJM1ryZxH42aCWBsW
         Etig==
X-Forwarded-Encrypted: i=1; AJvYcCWJZgUQq+y+biq+w7QQ7Koif4V8YsuhvawR/ReKa1TZbB25nbGnApvEnLZX+oENIcC7+dj5N11f54fQbKWMogYETU6Bjh/l72/ghf2QHlFTFnS3Kmx018RxG3yU86mgUIPh2jFKs9Ze+FOAlKY=
X-Gm-Message-State: AOJu0YxYP1bR3ygy1ZHxZIq8i6SM2BScBLpD25WgWeeea1cNjhQR02P7
	dSsr+BJ48QVW3cVrKT5j1pq7kZwl5SAELi0cymetTqZIwx6ebm5c
X-Google-Smtp-Source: AGHT+IEWdxKZcdIPalz7fsxdwwP+xAiU+4CSeyDMaQe7wC2X83AnDjW4o/FObjWOHjOxhkKTXW6jHA==
X-Received: by 2002:a05:600c:1d09:b0:417:29a3:3f50 with SMTP id l9-20020a05600c1d0900b0041729a33f50mr5260855wms.11.1713049521199;
        Sat, 13 Apr 2024 16:05:21 -0700 (PDT)
Received: from lewis-nuc.. (a.e.3.a.e.c.e.b.9.9.8.e.e.7.8.3.2.5.b.3.a.b.d.1.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:1dba:3b52:387e:e899:bece:a3ea])
        by smtp.googlemail.com with ESMTPSA id r10-20020a05600c35ca00b00415dfa709dasm10213859wmq.15.2024.04.13.16.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:05:20 -0700 (PDT)
From: Lewis Robbins <lewis.robbins2@gmail.com>
To: lewis.robbins2@gmail.com
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: rtw88: reduce failed to flush queue severity
Date: Sat, 13 Apr 2024 23:59:03 +0100
Message-ID: <20240413230030.390563-2-lewis.robbins2@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce the log message severity when we fail to flush device priority
queue. If a system has a lot of traffic, we may fail to flush the queue
in time. This generates a lot of messages in the kernel ring buffer. As
this is a common occurrence, we should use dev_info instead of dev_warn.

Signed-off-by: Lewis Robbins <lewis.robbins2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 0c1c1ff31085..800f4eabae13 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -1040,7 +1040,7 @@ static void __rtw_mac_flush_prio_queue(struct rtw_dev *rtwdev,
 	 * And it requires like ~2secs to flush the full priority queue.
 	 */
 	if (!drop)
-		rtw_warn(rtwdev, "timed out to flush queue %d\n", prio_queue);
+		rtw_info(rtwdev, "timed out to flush queue %d\n", prio_queue);
 }
 
 static void rtw_mac_flush_prio_queues(struct rtw_dev *rtwdev,
-- 
2.44.0


