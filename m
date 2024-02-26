Return-Path: <linux-kernel+bounces-80512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A494866910
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1BD1F2650D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E341CFA7;
	Mon, 26 Feb 2024 03:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="akQb35X2"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134D71CD32
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919962; cv=none; b=JVRIO8IGQfgZF3Y9fJOse/XGFXlxKVMGJGKzIwWzD0j4a3aB04VtX6/uK2QK7EdZaOXVGZ6gbh5RmjW3cKEQYAoPaiuvF02tzpvRrDHPySPfyIn1yjy7zqNClZ7xImbcU9e1UFWzL121naYWwFPJJIutZXi3Bz5U/CQqrXPzQYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919962; c=relaxed/simple;
	bh=XMhOdgnSD6GDUy09AMGDG/6abedE0Ur/5K9wiwhXNEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gEKjzKfVFBiv8u9UKmOXN2LPFWF4oUz5Xmu2tl4RHV3xBFNt53fZFaHiOtf13kpUnYIj0P2eiOPQJ4pdOE6rO3WznwZyvUjqboGLpilI9ZY80Wy4Uad3UZSyryFgsxOcJf8jjUJLj8tO7fmoUu79uOKCTFq6L2lMAXmTPEOaW00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=akQb35X2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc29f1956cso16073975ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919960; x=1709524760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV07OOKtBhvvjlkzVTWXYYy+Q8Ud6DjYC8gS8WRZRDQ=;
        b=akQb35X2PjbUatKH7bNtdb07IdtfACLhJeVDtWWgGPxAUCts4nuZdKoE/n1srWeP6l
         mKMRvFk30otBg50/XiZwknt32GUgWVW9ZozmeILNLd+oE9Ip6DmZg65B2abQ4+VVCYE1
         UGX4346op6S8pa+7EgPK8/yDNkYtCi6T7nB+FctxOccBeyYeSBQc2q0/IMZblVf6HqwT
         LEg18AsLVYSbcbxapEfCMGRPbZz0Ww8UjbPEEe3y8wqSXGLnPdWU4KKqFWhp39z35KWM
         rJohxRVCOoJ3UIbsvmtZfw3k1Mt4esBKFTi6ZAiE8pWZqXMVamIXA0aGOtCgN55Jrr/v
         kQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919960; x=1709524760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JV07OOKtBhvvjlkzVTWXYYy+Q8Ud6DjYC8gS8WRZRDQ=;
        b=BOGMA73YN7b3s14/7BadpvE5LpR7HpaGW6kqrHa7SWb+i6I4TaeQ9hMLH5cVrblFxH
         yMsh08K8m1QXL3XJmd8iJzBhvF5ZXZC5VVvZhFUpDwIBwXHH76kP3kzzRSZwFGVZZpAw
         sdXQJz4a207qBolJd7bGps4AzNyDPgA7pmTkfte9lC+hK/TLUTR+pCKa4wpQR16ZFv7X
         nKcmVl4N5NhuKuy6gNbBsEUjJOvGrw641KLtq0urFMXmDCMrvr/wRCczH0F+Qi5q1XpV
         h6Dm9HD8noAJi13NNIXWn1fmARMmKdTD3QOh+Nm6GUfBs8XoY+AR//VVqFzETCodVjx2
         Ck1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwHUEJgX58XBsIvJLZLH2J8v956b/A00X3Z0iC9HH2LWj/7zGZZLtJOm8bcCjkMUx5i24+fRnqm05WahAxo/aYop0VV2eaBnoqrJKp
X-Gm-Message-State: AOJu0Yx7CYHBfmUcGMBV5Ox2Tg6b9bMTaXIxRYcmIHhUmZXLyeL/RR5C
	A76y6fjRuJuyiMUuz1U3G+vbW3nTsUpXVXWNFX/gshGUoB8+cojfus5wmV39txA=
X-Google-Smtp-Source: AGHT+IEeD8vJpMRL9cED8xvAZ0LEBa2sDmKEmqhf/4yxpLXCJL1Bb6gx+sfqCxT8D4Go3e9OShm/Zg==
X-Received: by 2002:a17:902:ebce:b0:1dc:156c:a864 with SMTP id p14-20020a170902ebce00b001dc156ca864mr6143522plg.4.1708919960334;
        Sun, 25 Feb 2024 19:59:20 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id iy13-20020a170903130d00b001da105d6a83sm2893426plb.224.2024.02.25.19.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:59:20 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 1/8] Staging: rtl8192e: Fix 5 chckpatch alignment warnings in rtl819x_BAProc.c
Date: Sun, 25 Feb 2024 19:59:08 -0800
Message-Id: <20240226035915.370478-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226035915.370478-1-tdavies@darkphysics.net>
References: <20240226035915.370478-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tabs and spaces to fix checkpatch warning: 'Alignment should match
open parenthesis'

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index bd1d86e0323d..c06633867641 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -254,7 +254,7 @@ int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 		goto OnADDBAReq_Fail;
 	}
 	if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
-		   (u8)(ba_param_set->field.tid), RX_DIR, true)) {
+			   (u8)(ba_param_set->field.tid), RX_DIR, true)) {
 		rc = ADDBA_STATUS_REFUSED;
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
 		goto OnADDBAReq_Fail;
@@ -277,7 +277,7 @@ int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 	ba->ba_start_seq_ctrl = *ba_start_seq_ctrl;
 
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev) ||
-	   (ieee->ht_info->iot_action & HT_IOT_ACT_ALLOW_PEER_AGG_ONE_PKT))
+	    (ieee->ht_info->iot_action & HT_IOT_ACT_ALLOW_PEER_AGG_ONE_PKT))
 		ba->ba_param_set.field.buffer_size = 1;
 	else
 		ba->ba_param_set.field.buffer_size = 32;
@@ -338,7 +338,7 @@ int rtllib_rx_add_ba_rsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	}
 
 	if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
-		   (u8)(ba_param_set->field.tid), TX_DIR, false)) {
+			   (u8)(ba_param_set->field.tid), TX_DIR, false)) {
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
 		reason_code = DELBA_REASON_UNKNOWN_BA;
 		goto OnADDBARsp_Reject;
@@ -433,7 +433,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 		struct rx_ts_record *ts;
 
 		if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
-			   (u8)del_ba_param_set->field.tid, RX_DIR, false)) {
+				   (u8)del_ba_param_set->field.tid, RX_DIR, false)) {
 			netdev_warn(ieee->dev,
 				    "%s(): can't get TS for RXTS. dst:%pM TID:%d\n",
 				    __func__, dst,
@@ -446,7 +446,7 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 		struct tx_ts_record *ts;
 
 		if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
-			   (u8)del_ba_param_set->field.tid, TX_DIR, false)) {
+				   (u8)del_ba_param_set->field.tid, TX_DIR, false)) {
 			netdev_warn(ieee->dev, "%s(): can't get TS for TXTS\n",
 				    __func__);
 			return -1;
-- 
2.39.2


