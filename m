Return-Path: <linux-kernel+bounces-839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2C08146EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0DA1C22A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E8924B57;
	Fri, 15 Dec 2023 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffiHkhFQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF224B30;
	Fri, 15 Dec 2023 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c69403b3eso5253075e9.3;
        Fri, 15 Dec 2023 03:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702639792; x=1703244592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XpdCVDeSx25taP7QY8j0ivdRn5G3/1hqXyiZNxHPDZs=;
        b=ffiHkhFQXjTfl6i7VurjNXr0enfkRqfJz5HNawGaKq/3JVxRaVRFdWN4ATOPWXMwn6
         f2dIDK8rzLLR/EmFd2aAK7+1BbQdjaD3v8Tia0HOPnEEihw/e+tlpVN46SqOD1PMKhhf
         Fq4nQ3iVMdvhBaXodRjII8b4wkZLQbR7NzcWl1qUxRl2KRSrr1pUAeA422H1ehBwAM2g
         g8Z9y2hHEN/GzAWF608bo9SnifPigaW+Zk5uyYSfyZ4Yqd+dK2GiwYTnnW7G/ERHPTGn
         xf7hUTvXsvPHAPbwLQgnWBFCTVrH6cyWPtFwBzLO2247gaO6pnPhImQ2OVrdnoOjNlHE
         ykmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702639792; x=1703244592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpdCVDeSx25taP7QY8j0ivdRn5G3/1hqXyiZNxHPDZs=;
        b=OOqv3ZHpnPpzJRfppaFo8TK3RuCVSTUc6uIFkExeCWkMWm2Ru2oiiRubgTBM2VhL+q
         WemgwNaYckxCzG1QrpALUxUR6yfxF3KNHDynHYxthnT6dwLEKp7NUT1kvFFiZb2aXM0U
         yoIOjjAhIknr0Y6OStGBpnAVvJErzUBMdXqAeTVWwtXkDowyIBsNVcoEeph4wTgjNJ/6
         5ZCw92sEEF3wq75Nlw3fglM66MECr2SH+l8Wu3WrYoT4GR9eDEy6MEr6CvMN4DIxM1Oz
         ox91HhPLQMZArNSd6DuHv6JlUGuvo29tmUJiWR2qmBH56pb3R6NdZAw4/fJIO6zbWUrt
         rjWA==
X-Gm-Message-State: AOJu0YyZcGIgWc3RtUwg2FizBzp55ZUsc5TSfxE8qslPWcJAY5m3HIKZ
	aiceVxHybmxbo1OsA20RY98=
X-Google-Smtp-Source: AGHT+IEQoR0GiDgBalzSADI3L4P8cGCDNVIEQwoouG28tZ/cQPaGiPfLz+p9GY3Jaad31QQEqH1D7w==
X-Received: by 2002:a7b:c5cc:0:b0:40c:53d1:4c6 with SMTP id n12-20020a7bc5cc000000b0040c53d104c6mr2947832wmk.166.1702639791893;
        Fri, 15 Dec 2023 03:29:51 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id fl9-20020a05600c0b8900b0040b43da0bbasm28939219wmb.30.2023.12.15.03.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:29:51 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] PM: hibernate: Fix spelling mistake "hiberantion" -> "hibernation"
Date: Fri, 15 Dec 2023 11:29:50 +0000
Message-Id: <20231215112950.13916-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a pr_info message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index f8c81ef5b172..4b0b7cf2e019 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -671,7 +671,7 @@ static void power_down(void)
 		if (error == -EAGAIN || error == -EBUSY) {
 			swsusp_unmark();
 			events_check_enabled = false;
-			pr_info("Wakeup event detected during hiberantion, rolling back.\n");
+			pr_info("Wakeup event detected during hibernation, rolling back.\n");
 			return;
 		}
 		fallthrough;
-- 
2.39.2


