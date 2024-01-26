Return-Path: <linux-kernel+bounces-40769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A7F83E57D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37E9286C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD6958216;
	Fri, 26 Jan 2024 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="M7hHVZq3"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3587A54BD0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308307; cv=none; b=tzomV36IgnZIDT14nN4Ip086hjR+ZSBcNiTdc5PblysrQDFX6Cjp2SFm4ky3L/vs1O1s0PeZPOZdKInCxLUsAWRXBz6fNsae8dKyIOE06bNGE+HAdBNQUjfXZaJE5MxeaPB5DlXvQjwndzfPCiey/4tCh40/jYlmbor6EQyaYiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308307; c=relaxed/simple;
	bh=XtpWpK60biwfi1ZmNMgdSH05iLHa2F1aZ4kMFo4ME/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PiPykP4r1LhEVZz8LGUYN0gZ1jLmSr0xjBxyXKINLHfEkvmW54BInC3k//uZKFUEVvBoqTUKIsFigM9RYq2BqPeTEzkrkqHKVy+cTA/NmFKJ+TvbBw0QTRpqkG+oRQilFqpPT+WhG1roPA30siu7xXU9iF9w93eELguiA15CDdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=M7hHVZq3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d8aadc624dso4978865ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706308305; x=1706913105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eua66fvQaSKTG5liL3X4G3GQFda8Y7Tc5FSILm4aWXs=;
        b=M7hHVZq3UY8yCtgGfTzHM2tSYEHushK/0MypaxPqu8rBsLOZnCjr4/UU77Ed2d3hTu
         kYnJ7VZoaj9/ks8lnGliN13QrF+hV5L/uObT4wTea1rfBnRGvULV+Y9bolTRqLEYNiqB
         p48BX1tz7H2abpYZbFAmYJkyA+GEslU2IYv7MVubk0NwUxkOj/5UXJlJAw3TAMQMw9M/
         HFHnmsvStUhb0tDD2dpTf43xE9X6IEFG057vu3hDNJZPnml/z5bT+8GdlVSUh9jmdIir
         oAoLPnYKr9RChTVPKG1Sa0ITdyiJ7sJc1jbnO9vg+fj+MrEaxHsnjdJ93VNw2OJPZ/8w
         DYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308305; x=1706913105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eua66fvQaSKTG5liL3X4G3GQFda8Y7Tc5FSILm4aWXs=;
        b=D3LFtTppRKDQDBA0xU23DpbqxWe5+8+ccK5l6SpXsMwbdCporM34PM0rXqqwmqUXG8
         m/m4tZ7NbBJciVgepvNVnwiSxzyOcarjgQ4VgTX/+LUJ8J9CJ5aIqk+AnWdQuUzjmlpz
         bMJi5FmMNcXbYBDees5DPN0GSpXvyUY9IQ9r31SlQ8QXD94myxzbYuGh87MAdpITOwsF
         QSzeR8cKT6bs7fKVpEWlkJCl4sqRmuhTS7qiSsa1CjOaHnmlVUSmeoDZFWsQeBottXSa
         HK6uJ5YhRhI1Z2IH/Kd7eaHDrdYWzcEllEjBj/9BY8/ASMAHGtfjpVenjOnuOuTX+694
         yOOA==
X-Gm-Message-State: AOJu0YyGGjZno1tpT1qe56UeCp3Cq5k9qA7P9hnyURKaNpIfnokcgJh6
	JPtj0WKlmolF84FCq+z2zeMXkqIk4RDc9FH2dRphjipwmp1rMLx9wMUPyW7HDKU=
X-Google-Smtp-Source: AGHT+IG8SgMQ9KZ4+OiOFpIgxE+pj9h9DwnjOrrPCxw0Zx2olpC8QftFbeyQxVHjivDVHdGUAN0Jcw==
X-Received: by 2002:a17:90a:3cc8:b0:290:6b0c:2603 with SMTP id k8-20020a17090a3cc800b002906b0c2603mr544678pjd.29.1706308305634;
        Fri, 26 Jan 2024 14:31:45 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8a8f431b7sm737909pln.300.2024.01.26.14.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:45 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 10/18] Staging: rtl8192e: Rename variable SelfHTCap
Date: Fri, 26 Jan 2024 14:30:58 -0800
Message-Id: <20240126223106.986093-11-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240126223106.986093-1-tdavies@darkphysics.net>
References: <20240126223106.986093-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable SelfHTCap to self_ht_cap to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No changes.
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 18dab893270f..a4580445305d 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -98,7 +98,7 @@ struct rt_hi_throughput {
 	u8 cur_short_gi_40mhz;
 	u8 cur_short_gi_20mhz;
 	enum ht_spec_ver peer_ht_spec_ver;
-	struct ht_capab_ele SelfHTCap;
+	struct ht_capab_ele self_ht_cap;
 	u8 peer_ht_cap_buf[32];
 	u8 peer_ht_info_buf[32];
 	u8 ampdu_enable;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 98f0ac80f1fd..76f115f56680 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -516,8 +516,8 @@ void ht_initialize_ht_info(struct rtllib_device *ieee)
 	ht_info->current_mpdu_density = 0;
 	ht_info->CurrentAMPDUFactor = ht_info->ampdu_factor;
 
-	memset((void *)(&ht_info->SelfHTCap), 0,
-	       sizeof(ht_info->SelfHTCap));
+	memset((void *)(&ht_info->self_ht_cap), 0,
+	       sizeof(ht_info->self_ht_cap));
 	memset((void *)(&ht_info->peer_ht_cap_buf), 0,
 	       sizeof(ht_info->peer_ht_cap_buf));
 	memset((void *)(&ht_info->peer_ht_info_buf), 0,
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 545f79387991..60598b41fb9f 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -728,8 +728,8 @@ rtllib_association_req(struct rtllib_network *beacon,
 	}
 
 	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht) {
-		ht_cap_buf = (u8 *)&ieee->ht_info->SelfHTCap;
-		ht_cap_len = sizeof(ieee->ht_info->SelfHTCap);
+		ht_cap_buf = (u8 *)&ieee->ht_info->self_ht_cap;
+		ht_cap_len = sizeof(ieee->ht_info->self_ht_cap);
 		ht_construct_capability_element(ieee, ht_cap_buf, &ht_cap_len,
 					     encrypt, true);
 		if (ieee->ht_info->current_rt2rt_aggregation) {
-- 
2.39.2


