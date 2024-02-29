Return-Path: <linux-kernel+bounces-86057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84FB86BF12
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D8A1C2121C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CAD376E5;
	Thu, 29 Feb 2024 02:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="W1zUOW8a"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8AF286A7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709174616; cv=none; b=C0mbDqIdCQHBoJIqwpgmBHk8/nl6fGRF8wGAOre7HvkoP+vuqGis/xrQN4wdEILsyHZox1wXD1iO1dpWg/lOTKrZkjEL8SVZ5SNX9bi+EZ51a5YUgpCV3xTQAXZZ3db905bmibL80zXE2yypqOkqKq8WyL+lAB2QkCHJulYJJTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709174616; c=relaxed/simple;
	bh=srm/OFIg/q2IKVUnLLHmtPyC+Nces81JgQnlTjMD2dQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pfLoVZB6e16aEKr5rI02pRwZNSol9qCFtFdBOK7Vjl8XGIDYl7oitEkkDs0d+JPUWD/7I+1YgdiMWAYmSSERJKxNiH32rSHhdoU1IuXk5QtrhMe0LLcp8h4NoBMq4Ek8HGemK5ycwVloF7nAyVhVl0RH+CEREDZuZz0JWP+TKCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=W1zUOW8a; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e57ab846a1so257793b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709174614; x=1709779414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAMKnLLLOoIxypoohPMOXgHVsRQhwwvK6oUJPHvqkzw=;
        b=W1zUOW8a4EtbdUogvMBTmeuTGAGVRhjX7ooMolLxoA9Xvg/EHH+tuysMs2PytqF0qU
         KOqZde0QpLCR/1jG6wWcf8g+wFY0WNK/EISF3hZqXAAs3oBC9ilb1mwLSocmy4Lq+Xm0
         5PX/t806YvngFM73Z6fUZbKagaO/i+tRrJU/97cq7HCPFwqGjI7oh3CvN6vt8+sAxx4M
         oQ3m5fWgRcQ1Iy1ILVvpV46Jkfo9pA3ZlMVzGWtHzvwLvOu4thl6admzDLz0k3JHKz9E
         yv/+gDiqp5lP8Bmhq65eOXvHGWDNZVnuf3RbgyJn6VfDyZA01ENdTOqoC0PWqem0O7LM
         9cSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709174614; x=1709779414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAMKnLLLOoIxypoohPMOXgHVsRQhwwvK6oUJPHvqkzw=;
        b=tv8UvUnYfBR6xrfZU/4UdUex0Q2Hx9OfTi5yhU1uTTe5Txt1vkRwgo3d3QNYajfO9a
         WJ7pacc4LjgU9NrA2qV/y91sGYH8LkqheWeHKLI1qkfoB5TB8KkeXAZPhmZOtG/cb7Ug
         GFCMqr/kZQDUb9T2FXsFiem0Hrmp/LLHX1ula/cv5W7b3vZA2Wc2RuWMb8HgejM5hMGj
         ZbWIg/TdWGENacUTNhOVhPFvobyk2phXgRYLmmvm8tHTKdRB6iEj0YIOlgY9PBsJEcVr
         yzRqh6bhs7F6Cylpxw87Sw+jX00mNKB10mlkPbmBLr4RIxhrlUPb7lBQ4R1ZLmLNpX9p
         qMAg==
X-Forwarded-Encrypted: i=1; AJvYcCVibYmp32GXDwrILxuLz2GCsbI0oR61LBqAUlTrPteOOTf4Wi/fednbBzEwg8ADvuWoQsY2MQH6jqCaSm8Qz76U8s1JP5DXd3361bUW
X-Gm-Message-State: AOJu0Yxv+s/hSMbKDwh2ga1PxHrLTpZBdWgvbfh6ykkZp41dYiHIbCtJ
	ImMq9per022U3gMHVCOHAMXKvZq1TSXJ+osbEjcMlUSsn4vOxZVOt5DkNlw1QI8=
X-Google-Smtp-Source: AGHT+IG4s25AhDsjSTjWYj7p2s1kxiOY3p6T3r9cEUYLMLQfKzmQxsorp4fRg7QZOGAEQ0pdN7mUgg==
X-Received: by 2002:a05:6a00:80ce:b0:6e5:799b:17b3 with SMTP id ei14-20020a056a0080ce00b006e5799b17b3mr891299pfb.21.1709174614223;
        Wed, 28 Feb 2024 18:43:34 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id u23-20020aa78497000000b006e5092fb3efsm141504pfn.159.2024.02.28.18.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 18:43:33 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 2/8] Staging: rtl8192e: Rename variable TxRxSelect
Date: Wed, 28 Feb 2024 18:43:19 -0800
Message-Id: <20240229024325.453374-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229024325.453374-1-tdavies@darkphysics.net>
References: <20240229024325.453374-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable TxRxSelect to tx_rx_select to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: no charges
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 18 ++++++++---------
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 24 +++++++++++------------
 drivers/staging/rtl8192e/rtllib.h         |  4 ++--
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index c06633867641..030e0a87c931 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -125,7 +125,7 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *dst,
 
 static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 				    struct ba_record *ba,
-				    enum tr_select TxRxSelect, u16 reason_code)
+				    enum tr_select tx_rx_select, u16 reason_code)
 {
 	union delba_param_set del_ba_param_set;
 	struct sk_buff *skb = NULL;
@@ -139,7 +139,7 @@ static struct sk_buff *rtllib_DELBA(struct rtllib_device *ieee, u8 *dst,
 
 	memset(&del_ba_param_set, 0, 2);
 
-	del_ba_param_set.field.initiator = (TxRxSelect == TX_DIR) ? 1 : 0;
+	del_ba_param_set.field.initiator = (tx_rx_select == TX_DIR) ? 1 : 0;
 	del_ba_param_set.field.tid	= ba->ba_param_set.field.tid;
 
 	skb = dev_alloc_skb(len + sizeof(struct ieee80211_hdr_3addr));
@@ -199,12 +199,12 @@ static void rtllib_send_ADDBARsp(struct rtllib_device *ieee, u8 *dst,
 }
 
 static void rtllib_send_DELBA(struct rtllib_device *ieee, u8 *dst,
-			      struct ba_record *ba, enum tr_select TxRxSelect,
+			      struct ba_record *ba, enum tr_select tx_rx_select,
 			      u16 reason_code)
 {
 	struct sk_buff *skb;
 
-	skb = rtllib_DELBA(ieee, dst, ba, TxRxSelect, reason_code);
+	skb = rtllib_DELBA(ieee, dst, ba, tx_rx_select, reason_code);
 	if (skb)
 		softmac_mgmt_xmit(skb, ieee);
 	else
@@ -486,9 +486,9 @@ void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
 
 void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
 			   struct ts_common_info *ts_common_info,
-			   enum tr_select TxRxSelect)
+			   enum tr_select tx_rx_select)
 {
-	if (TxRxSelect == TX_DIR) {
+	if (tx_rx_select == TX_DIR) {
 		struct tx_ts_record *ts =
 			 (struct tx_ts_record *)ts_common_info;
 
@@ -497,14 +497,14 @@ void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
 					  (ts->tx_admitted_ba_record.b_valid) ?
 					 (&ts->tx_admitted_ba_record) :
 					(&ts->tx_pending_ba_record),
-					 TxRxSelect, DELBA_REASON_END_BA);
-	} else if (TxRxSelect == RX_DIR) {
+					 tx_rx_select, DELBA_REASON_END_BA);
+	} else if (tx_rx_select == RX_DIR) {
 		struct rx_ts_record *ts =
 				 (struct rx_ts_record *)ts_common_info;
 		if (rx_ts_delete_ba(ieee, ts))
 			rtllib_send_DELBA(ieee, ts_common_info->addr,
 					  &ts->rx_admitted_ba_record,
-					  TxRxSelect, DELBA_REASON_END_BA);
+					  tx_rx_select, DELBA_REASON_END_BA);
 	}
 }
 
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index e9a193b5ab10..9903fe3f3c77 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -171,14 +171,14 @@ void rtllib_ts_init(struct rtllib_device *ieee)
 
 static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 						  u8 *addr, u8 TID,
-						  enum tr_select TxRxSelect)
+						  enum tr_select tx_rx_select)
 {
 	u8	dir;
 	bool	search_dir[4] = {0};
 	struct list_head *psearch_list;
 	struct ts_common_info *pRet = NULL;
 
-	if (TxRxSelect == TX_DIR) {
+	if (tx_rx_select == TX_DIR) {
 		search_dir[DIR_UP] = true;
 		search_dir[DIR_BI_DIR] = true;
 		search_dir[DIR_DIRECT] = true;
@@ -188,7 +188,7 @@ static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 		search_dir[DIR_DIRECT] = true;
 	}
 
-	if (TxRxSelect == TX_DIR)
+	if (tx_rx_select == TX_DIR)
 		psearch_list = &ieee->Tx_TS_Admit_List;
 	else
 		psearch_list = &ieee->Rx_TS_Admit_List;
@@ -225,7 +225,7 @@ static void MakeTSEntry(struct ts_common_info *ts_common_info, u8 *addr,
 }
 
 bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
-	   u8 *addr, u8 TID, enum tr_select TxRxSelect, bool bAddNewTs)
+	   u8 *addr, u8 TID, enum tr_select tx_rx_select, bool bAddNewTs)
 {
 	u8	UP = 0;
 	struct qos_tsinfo tspec;
@@ -265,7 +265,7 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 		}
 	}
 
-	*ppTS = SearchAdmitTRStream(ieee, addr, UP, TxRxSelect);
+	*ppTS = SearchAdmitTRStream(ieee, addr, UP, tx_rx_select);
 	if (*ppTS)
 		return true;
 
@@ -274,21 +274,21 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 		return false;
 	}
 
-	pUnusedList = (TxRxSelect == TX_DIR) ?
+	pUnusedList = (tx_rx_select == TX_DIR) ?
 				(&ieee->Tx_TS_Unused_List) :
 				(&ieee->Rx_TS_Unused_List);
 
-	pAddmitList = (TxRxSelect == TX_DIR) ?
+	pAddmitList = (tx_rx_select == TX_DIR) ?
 				(&ieee->Tx_TS_Admit_List) :
 				(&ieee->Rx_TS_Admit_List);
 
-	Dir = ((TxRxSelect == TX_DIR) ? DIR_UP : DIR_DOWN);
+	Dir = ((tx_rx_select == TX_DIR) ? DIR_UP : DIR_DOWN);
 
 	if (!list_empty(pUnusedList)) {
 		(*ppTS) = list_entry(pUnusedList->next,
 			  struct ts_common_info, list);
 		list_del_init(&(*ppTS)->list);
-		if (TxRxSelect == TX_DIR) {
+		if (tx_rx_select == TX_DIR) {
 			struct tx_ts_record *tmp =
 				container_of(*ppTS,
 				struct tx_ts_record,
@@ -321,11 +321,11 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 }
 
 static void RemoveTsEntry(struct rtllib_device *ieee,
-			  struct ts_common_info *pTs, enum tr_select TxRxSelect)
+			  struct ts_common_info *pTs, enum tr_select tx_rx_select)
 {
-	rtllib_ts_init_del_ba(ieee, pTs, TxRxSelect);
+	rtllib_ts_init_del_ba(ieee, pTs, tx_rx_select);
 
-	if (TxRxSelect == RX_DIR) {
+	if (tx_rx_select == RX_DIR) {
 		struct rx_reorder_entry *pRxReorderEntry;
 		struct rx_ts_record *ts = (struct rx_ts_record *)pTs;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 8e2f27b98f30..bbea287df535 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1779,13 +1779,13 @@ void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
 			   u8 policy, u8 overwrite_pending);
 void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
 			   struct ts_common_info *ts_common_info,
-			   enum tr_select TxRxSelect);
+			   enum tr_select tx_rx_select);
 void rtllib_ba_setup_timeout(struct timer_list *t);
 void rtllib_tx_ba_inact_timeout(struct timer_list *t);
 void rtllib_rx_ba_inact_timeout(struct timer_list *t);
 void rtllib_reset_ba_entry(struct ba_record *ba);
 bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS, u8 *addr,
-	   u8 TID, enum tr_select TxRxSelect, bool bAddNewTs);
+	   u8 TID, enum tr_select tx_rx_select, bool bAddNewTs);
 void rtllib_ts_init(struct rtllib_device *ieee);
 void TsStartAddBaProcess(struct rtllib_device *ieee,
 			 struct tx_ts_record *pTxTS);
-- 
2.39.2


