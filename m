Return-Path: <linux-kernel+bounces-82684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AB6868845
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED50F286FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EEB5337F;
	Tue, 27 Feb 2024 04:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="ATC3/lru"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E28F51C23
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008927; cv=none; b=MNf038qS1ys0JyYfzhoPlv6ANz4djV21/pdV1JWUtdHvSVQCd3oEeKgjo+r+QChr8vb3Q9xccKACDg5bXFnGuVlGofwQlNjmQJ6lD8xoylm7k1zJW22PqScsw2CVUOuEf7gJ83VuRlW3uyFHeHbZtH4Sl6pHUkVA3Zrb32K1DhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008927; c=relaxed/simple;
	bh=vtE0HQO5CTViHYJ0FOlOi3jB0yEXi4DyKJph2TmqnIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GefLdDG//sqo9CEVuO+NoepCaf4Py9MJ1a5zVwzJjyzU90LRLorkGEzuWfgMJAw/qEU3NMr4P4xSeUnTpTJILvUXVZct7JcP4Chuuu4T0L/ibiuZKOqsVSBJUfDnXnnwpUnAIdEi2OqilE3dOAeiq32WSgx4ForK7wFqW32bjmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=ATC3/lru; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e48eef8be5so2611372b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008923; x=1709613723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTeGqJBlqp2POB710RiU2T4uCXKoM61haRgZvOEZzlA=;
        b=ATC3/lruKp+VqIopt1atqf5S7LJXUsOYtdLSnFTc0aHyv41t1scxkc8nQ2UJu+u4F9
         7pzqdIWg/KtKzC4I2RtgocEc0aCbiW4W6zQEBU2sHPqt6DwiOOmXC48Zwh/Mf7lUNXS5
         QWzYo9XZ8+tDU4tW2XGWoQZ0/VsA1uzHZW0sfgcUraaNeiORvmYiHSIHU3GKmYBScAVq
         XcvMMEp+InQ9jZwoE6VihkLVpc3Cg5LwFBe3T7p6wJ7PulF62uqVTB5qVJxU3bsFfo6m
         a6H1tn0bThLg6eAu+EWIIIncxM4lZwHpy2z3sLdWdcQDz9ezySljFl1+/h22WUwComJi
         pyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008923; x=1709613723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTeGqJBlqp2POB710RiU2T4uCXKoM61haRgZvOEZzlA=;
        b=QbbOdDdafeXwaXO1Nhd/+AEUSN7xzwMGi68DyzCRPnYBs2WuDhnnP79rVWKAiPQOZJ
         oaDRF8E7/X3rKsU60k+al4dUSKl12l9R4rnVuZsHEo5glZ4mubH4SKuo2koLiVZ1nT2n
         pdcYBHZiKnvU/Xx5sR6vPdvBlqiTrgXFTOd6TMmzD1eW2p2KKALl6leITFuusEGVBjZO
         GNKkwtwVvGa3xF8gmAPG1HBqgT7rAd8302zqD+GElQjj7iWtydoEbeGWEx+oOCheCvbn
         eJ+HnT5KXL/6RI0AhUg5MJdG6EHQl6wy7PACQ0v+FW0wJ8zaOrCaF0AVX6zw/ujFO4Pt
         9h5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbWsWvcSJHAh00rcL0ytn0kcHQ64JwpUNz1/AL3vHfPak3F3Bmyj5oDEvlMvHzTUjguSx47/elyvRMrdedppJ1tPCytLrgUIqlmhhv
X-Gm-Message-State: AOJu0YxtooZe3iFMwd+1PHcId9s2nFw5cEf90cgL3nMLsLILZaVJIoRn
	yMTKAUFUbtqYFSEyU/wmSSy/qjRTRD4A3MQTny5hcEStfjokJnYB+2AHQ2bTGwc=
X-Google-Smtp-Source: AGHT+IGbLpjLMTPjyTpkHFwmvsp2AmwhppLWePj/eaCxc6WMrzBVGYy/wC2YCbh6OTvPYkuWDbqzTQ==
X-Received: by 2002:a05:6a00:d4a:b0:6e4:3a32:49e1 with SMTP id n10-20020a056a000d4a00b006e43a3249e1mr7265336pfv.11.1709008922890;
        Mon, 26 Feb 2024 20:42:02 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:02 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 01/20] Staging: rtl8192e: Rename function rtllib_rx_ADDBAReq()
Date: Mon, 26 Feb 2024 20:41:38 -0800
Message-Id: <20240227044157.407379-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227044157.407379-1-tdavies@darkphysics.net>
References: <20240227044157.407379-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename function rtllib_rx_ADDBAReq to rtllib_rx_add_ba_req to fix
checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Fix 75 char line limit checkpatch warning
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index da7319c124e7..bd1d86e0323d 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -211,7 +211,7 @@ static void rtllib_send_DELBA(struct rtllib_device *ieee, u8 *dst,
 		netdev_dbg(ieee->dev, "Failed to generate DELBA packet.\n");
 }
 
-int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
+int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 {
 	struct ieee80211_hdr_3addr *req = NULL;
 	u16 rc = 0;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 348644998744..95a8e9416f61 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1771,7 +1771,7 @@ u8 ht_c_check(struct rtllib_device *ieee, u8 *pFrame);
 void ht_reset_iot_setting(struct rt_hi_throughput *ht_info);
 bool is_ht_half_nmode_aps(struct rtllib_device *ieee);
 u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate);
-int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
+int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_add_ba_rsp(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
 void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 2545ac8963c4..f12ee685e989 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1551,7 +1551,7 @@ static void rtllib_process_action(struct rtllib_device *ieee,
 	case ACT_CAT_BA:
 		switch (*act) {
 		case ACT_ADDBAREQ:
-			rtllib_rx_ADDBAReq(ieee, skb);
+			rtllib_rx_add_ba_req(ieee, skb);
 			break;
 		case ACT_ADDBARSP:
 			rtllib_rx_add_ba_rsp(ieee, skb);
-- 
2.39.2


