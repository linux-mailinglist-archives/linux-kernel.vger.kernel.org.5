Return-Path: <linux-kernel+bounces-40761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164BD83E575
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6ECF281E10
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ACA4207E;
	Fri, 26 Jan 2024 22:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="BaCClZLe"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09851250F4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308300; cv=none; b=G/cU4CYbE6VZDLsa8G0gV9ETgrZd5u82KAkmvATzGR8hnWUqP827QxoePUmLge2023cjmlFMtcm2Sxn+WJxiHhBew8S8tElZ6zptClE04KPyimP15Fg/pIK2a6C4FieyryhuwnOnzqGToJKgVM5oGgR5jBMZYY0Q5ixXYmh2C/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308300; c=relaxed/simple;
	bh=nO6p7BKAKzCQo9sDWJzov6jJZScg2X6bh+XALigQqFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gICE18R4RdFNzRAs80qWKUduO9V8515xxjU8LIdvj8AHCqQ+DRO3Gh710mIb+BqTC8o4zKFJ/s0AfLAshfLGVFaz1bYPn3AVY4gBob0cwydeADRe1CaNR7bEymdYsqkjE3DWv6CrEo3y3mpEjk4blYX/h3/MxgFKroWe2CzBAOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=BaCClZLe; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d74045c463so6870295ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706308298; x=1706913098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP85DBzUfzDHmLzx+iRbnDBtmrAXCtM9a0isDSNNa5Q=;
        b=BaCClZLeqwRQRYfBR6izzMQN/nW/d/mTX7bf503we+8GEhUfBj2Stg61ZUxafv55ML
         Pqxcqglvhgz7Yx1x31FcM9LYWJybW8A38iiFHKyzphUWXVSaWu3En5T39U2qdY2OlltY
         p9s0T99RlNZeXBvka9xwBVZObJj5bj7m8KwKvs2PJ1FxJ2hT5nsj0BwtdhgCovF7CfDx
         GUkrqlMq9059YgJpaC33yE+UCZ/35nbDzNGKSYGglv6ZtP/eEHlBSPO7kIj51suqS6oD
         TxN2wnYyPuOsk1phnGo9QwFi3oM15/2moouEToiYpWXyv9YqiqjLvn7+y/aHRiJiRKvc
         7OqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308298; x=1706913098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GP85DBzUfzDHmLzx+iRbnDBtmrAXCtM9a0isDSNNa5Q=;
        b=RTpZQnVw1eEBcpCYBCD2+Q1/DEMyqA2OIgzvMBFiZzQuZHY7EaxAlaV9x6/Bja9ne0
         pRubnXBRvjI2myf1dPNOXkK44nR8xONctvuitarm9l4guAdILBb67Q++P/VGuHwFo4gZ
         SmVfQVlVgYWbevOvv+JJWglXpKHeJQoVeddsR46WlH8i4DFLC1ykxLpXdt8TjH1aMPaY
         Ow4xVxziRZsEJ+pbbaWq9K8Hm+gKCkyWsXmMkLtrE4qI376Ri6vsicSZIZEB4UckVCRA
         rPv4vV4vUmK4WUOkM/bpiDhnOFrMobYGlhV76kKJ0gbaFAxJ4Vk/Dvd0G9JLPvYt9YqK
         TRgg==
X-Gm-Message-State: AOJu0Ywb3KXFp2/r8COwy5iP7jKkwNVN/xnkdTxtKMBmYoZ36vbGRnzR
	R0lTOGxTaTjUNakTQ9BZppV7p461AScR+0h1orYyHzbIP6Tpk9qcl/PsuUFT9ZY=
X-Google-Smtp-Source: AGHT+IHOSH5bL0kg5OXTY0Ky3dBjIpaQPU3dgPoLFcF5+tOcad9R7UiKUw7FYdcHRTzSHHGqjgSJVw==
X-Received: by 2002:a17:902:c44a:b0:1d7:4506:29da with SMTP id m10-20020a170902c44a00b001d7450629damr392897plm.40.1706308298335;
        Fri, 26 Jan 2024 14:31:38 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8a8f431b7sm737909pln.300.2024.01.26.14.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:37 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 02/18] Staging: rtl8192e: Rename function rtllib_rx_ADDBARsp()
Date: Fri, 26 Jan 2024 14:30:50 -0800
Message-Id: <20240126223106.986093-3-tdavies@darkphysics.net>
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

Rename function rtllib_rx_ADDBARsp to rtllib_rx_add_ba_rsp to 
fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Update commit message.
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index ee9ce392155c..da7319c124e7 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -300,7 +300,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	}
 }
 
-int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
+int rtllib_rx_add_ba_rsp(struct rtllib_device *ieee, struct sk_buff *skb)
 {
 	struct ieee80211_hdr_3addr *rsp = NULL;
 	struct ba_record *pending_ba, *admitted_ba;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 13a901c0db1d..94f370b40378 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1772,7 +1772,7 @@ void ht_reset_iot_setting(struct rt_hi_throughput *ht_info);
 bool is_ht_half_nmode_aps(struct rtllib_device *ieee);
 u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate);
 int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
-int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb);
+int rtllib_rx_add_ba_rsp(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
 void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
 			   u8 policy, u8 overwrite_pending);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 44b36cc867d9..cf855ba39c10 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1556,7 +1556,7 @@ static void rtllib_process_action(struct rtllib_device *ieee,
 			rtllib_rx_ADDBAReq(ieee, skb);
 			break;
 		case ACT_ADDBARSP:
-			rtllib_rx_ADDBARsp(ieee, skb);
+			rtllib_rx_add_ba_rsp(ieee, skb);
 			break;
 		case ACT_DELBA:
 			rtllib_rx_DELBA(ieee, skb);
-- 
2.39.2


