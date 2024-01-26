Return-Path: <linux-kernel+bounces-40771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6464783E57F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20890286C49
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218E05A78A;
	Fri, 26 Jan 2024 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="YGPSj85O"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4CB56B70
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308309; cv=none; b=S6l6ctjCDiFISkXsicOhs2GbLHcU+1Xb5GQ4TvJbIKF5qVZ2FeaVOxeVot+fUmkIesIhePMsotQBJzjTI6nvn4o6rKsbIV6jy5TuK5wEnRQDsT+2nogiYlmimJv0Hc7DpFS5B9aOp5XunGCnPParGWFkzMcwOhVGAXvK5mHVk00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308309; c=relaxed/simple;
	bh=d221A9DTsel1sj0jdwOENIOIP1uW0+yzlQJlionfmy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lv3Gx2F8QIsvdajyWF8mpWmYvH5YAaKiJbK8umMo6neHeTh7RhX5UMtuarbN40SzGJjlrYFoLnxE6fRqMpcx8mpmIGo1FxRjjzJPKIWEITMOTWRac1w5wz9MYHTke4H2zhVM8TeFoVY+tvuDCEL+XtDHY/6DF+26fTuK8/mb+8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=YGPSj85O; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d720c7fc04so6854215ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706308307; x=1706913107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Awp+sOMd2zTDY3BhxjyMABNSYZC/s1kfFh3Ae2mRiGM=;
        b=YGPSj85OwE6rtwwjsqJ0J1PEocXA0SYSz3UEMvPYqQWVVrkNtX0fyjtfC6clE+9QmM
         hxOEpENJV7MgB9sn/+1MSaNuQqGwMhmJFi4VTLp0feTYJAWPQS92uC6n684R2B2ubm91
         BX3RT6qsqWFUN3/xg9kYB7NiqXAVOC9y7Jke9Ht+Zw5/1hs9tTNEqmKHsJvND1tMjv9O
         NCfGl6EhDS5VNllB6s8JICDyJ80dxhdX3YxDObeu4xtWh4rj8ZYGd9VabSoJx/KlK8vH
         tvdyAcxlD8VKmBMqaDXgUJtdo1Ij7DN5jVbBeUoerFQaZZGzTiuF41sEUYoXfzQKLxjf
         7V3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308307; x=1706913107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Awp+sOMd2zTDY3BhxjyMABNSYZC/s1kfFh3Ae2mRiGM=;
        b=T+xPzYsOvpXpgyv9wAYEntqj6TY+EqkwVFqRMBIvO3aQfan9xeJqKxhMu8LiWHwd6i
         BO8p07Ym2UaNF44+pofh1YaZwZF4AaXOY7rs5MbwHO9juVY0fo3g1dtJArTfrdjCaK3S
         gj5oMg9YkwNen2kX1ZYLBBPCVb2FmYFrn3OYwRfGXkuzxMOdXZXvjgBZQSluluL58mLF
         YT4VspfTGMEuYZZVBMQWXFzycNukK2s8KC26h04GYE60kDkpYrPbiBsmJRAmHzMk1BXF
         n+hIVVrYZpAT6+3ev/vtHQbhXvn47U7PbhSED13AAydQO4gMbN5EW2iZhjPP71Ur9tNg
         cEhA==
X-Gm-Message-State: AOJu0YylcqRSjvSAayZxdEPturAsxogyOu5DMn0o8wzim2984+bVuEd6
	vPDVxIlAb7rQBWBi1+uhHvCWCqeJPISklzgdGJ+YvlqXNbgz1KfNn4fsWpRFy98=
X-Google-Smtp-Source: AGHT+IHza2+Xz+W74yxBCYOqYs7ax1jHiGRhJAxELgNshUZ1N7dFgyadhuxJiaLjFulhdHjLnPwImg==
X-Received: by 2002:a17:902:c382:b0:1d7:126:5691 with SMTP id g2-20020a170902c38200b001d701265691mr436608plg.73.1706308307108;
        Fri, 26 Jan 2024 14:31:47 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8a8f431b7sm737909pln.300.2024.01.26.14.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:46 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 12/18] Staging: rtl8192e: Fixup if statement broken across multiple lines.
Date: Fri, 26 Jan 2024 14:31:00 -0800
Message-Id: <20240126223106.986093-13-tdavies@darkphysics.net>
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

Join broken lines across if statement to fix checkpatch warning:
Lines should not end with a '('

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No changes.
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 538689fb5580..ab41632def7a 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1736,10 +1736,8 @@ rtllib_rx_deauth(struct rtllib_device *ieee, struct sk_buff *skb)
 		ieee->link_detect_info.busy_traffic = false;
 		rtllib_disassociate(ieee);
 		remove_peer_ts(ieee, header->addr2);
-		if (!(ieee->rtllib_ap_sec_type(ieee) &
-		    (SEC_ALG_CCMP | SEC_ALG_TKIP)))
-			schedule_delayed_work(
-				       &ieee->associate_procedure_wq, 5);
+		if (!(ieee->rtllib_ap_sec_type(ieee) & (SEC_ALG_CCMP | SEC_ALG_TKIP)))
+			schedule_delayed_work(&ieee->associate_procedure_wq, 5);
 	}
 	return 0;
 }
-- 
2.39.2


