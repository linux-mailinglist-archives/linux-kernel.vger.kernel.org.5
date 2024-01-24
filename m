Return-Path: <linux-kernel+bounces-37766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7316583B4E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCF62860B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB64413666A;
	Wed, 24 Jan 2024 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="aRfSZ0tI"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCC1135419
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136300; cv=none; b=OVXRD4w+CRziWxKcz014h+3t/Td+34/PbdCDo6vMNEXG3kqS21PBygpWBqfoP5IbDwM3Z9Gp+xVRgp8huaR4UwzaMRcgk8SywlHiZmCwi/nh6p4QKTMU07rWfvrHolrRbXv33IoClQA406WonankjGz0HGD6LeZhJcWqA2e30GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136300; c=relaxed/simple;
	bh=GfWAlbCJEkaXj7meVqIZfFReBbav+A1O3s6V10t3Z64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ub5jAhh4TlfcLv6YgnK46sFjZfODNVx5xigZbEBsJkOXDAmX3kSkEqVxew/odNZxk4vHyBzsid7LIJ40s8+zfwqs/A1THic7N6R1dAn51jf5hpwIlZIUk1ULqchGakuFyAUx6eAh5EW4f+q2ZhiYdX0MXEVYu+BBYcED5z/2/hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=aRfSZ0tI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d7354ba334so38565825ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706136298; x=1706741098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lend1c+2XgQTDI7pDwrpRTYkCgdYKaKbQn9DvF9y7QM=;
        b=aRfSZ0tIEzYrGEcrTghSbcvw8H5rqMfOQ+V/o1vMv+4Aj+fZUjEkKX700xQPE1w2gS
         wfrmDncN5FtFs4H9OiASiW0bBFNNJ9kXda76Z8b74OhHsK7NwRps4CuLLh1YwsPFEnvF
         XKfZpE/CkLIxIk2+RxzT0kyh/+eYqnkS7+uQFZfuhrpBjhey041HBAchN2WkZGqDTBoJ
         VIuEYmns5rynEQIX9JDy6bxXWRi+0zl8FjR9jXyUsSXXKUno8iomdE95FIBY7Z/i1qzl
         NAf2WQSfKpobmrLLJ4EgGVpPKmO64nOF3KssHKAXKn6lpcFIxLfFxP4ZkpSelq2FNAv/
         T+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136298; x=1706741098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lend1c+2XgQTDI7pDwrpRTYkCgdYKaKbQn9DvF9y7QM=;
        b=lp9MLkbZdgQhv9+UHSGP/k0H25HwPcXVZNWB/mPtGEoMQkXaTKSoi4xRriQ913UjrO
         3c38ttfSqXJJAw93rDW6Wu2RpkTR8WWYNkA9uIP92JHojWmlI2jKK3i+OoAjxv4Do0tV
         EwiNxLqxm+TSElXfTvlrTti2TaWZ3QGbDIKZwMNEgCmNm1ottRabZv3+JHRk7rKDqNQc
         ykXgRahS06TJpnnWB7yT3xHBwafP2NzkbT1qVmoy+xvgii9gAlXzEz0zAg+jNOA+DPCg
         8PuyKpWDeJTmHYNU6WrL3Dpko7iiT4K9tUksRm/ieks7hUarN5bT+F/YJISUckwFHth4
         xBsg==
X-Gm-Message-State: AOJu0Yymk1KrOFZvkNL7e9oOVCIsOoPxTJh1EYgfXVatoZFBUJpIg0Pc
	zX85u9DQmacWpgv52WGEMFS9h6kcc7/JENx8p09hVtsMchzzALyxcRoOKXuaDqw=
X-Google-Smtp-Source: AGHT+IG76B4urlG+Fd+2o3qlJY1tSulF9yGBiT3cAVFw8XG5S943j6nNNRzfd5yO+TxI6lAPvhSyDg==
X-Received: by 2002:a17:903:1249:b0:1d7:b00:739c with SMTP id u9-20020a170903124900b001d70b00739cmr91191plh.102.1706136298006;
        Wed, 24 Jan 2024 14:44:58 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c28500b001d73a2acc0csm6743987pld.283.2024.01.24.14.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:44:57 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 02/18] Staging: rtl8192e: Rename function rtllib_rx_ADDBARsp()
Date: Wed, 24 Jan 2024 14:44:36 -0800
Message-Id: <20240124224452.968724-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124224452.968724-1-tdavies@darkphysics.net>
References: <20240124224452.968724-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename function rtllib_rx_ADDBARsp to rtllib_rx_add_ba_rsp to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
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


