Return-Path: <linux-kernel+bounces-80513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB103866911
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551D21F267A6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F4321A0B;
	Mon, 26 Feb 2024 03:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="WY4CX7oN"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4511CD3B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919963; cv=none; b=TCi+27MEzq/g/34QsTrAltKZPHPV+7/GyosIKbfXCY8jdGstt4qeRc7B9yG9Q6fbrT//wpSJYrYyF+JivAi8mfS3C7dheuDK6xoRYgPYPIcfo/5L/x+8e968WNnisRFRQ6dF92yxrSW2Ql7TuqpuZeqCYjWGkLqplpu6zSp9fv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919963; c=relaxed/simple;
	bh=9dOFkhnaSWEiTNeTcyRPAntKh09djoq4BBpWP88iABk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kFZJIWuOMPQbKMxLMYZlUB8CxQExveQPpbpJuIJX/gLV7vrXVcQjJkceRd+e2erB/Sg3RTpRbigr5I9HQlwmH4byrwQqiYghT5dX1FC8Q4QiKFAIPerVGz0VRHQ0fJStCaWeuIODGatKWFOIubARVXcYDCiSBITAr4TMPpWD0mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=WY4CX7oN; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc96f64c10so4532855ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919961; x=1709524761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88SDs5w2MY5mWdpm7KClCN1gnNwWnjOc3NGMH26ZbvA=;
        b=WY4CX7oNKQ4s9z2H/oGxPzedlv32aZZsSA30QRJXpxbcQZO5GmdDobTV0qdy1u8hRF
         psPLHEpTYgU/21Mn312YfJIn0/JkHl7mRNYDl58+Ec7mu6AGggQvw9+TquSRCOIGRUmU
         Kd70rsUyPEaqJYC1pOaD+5gNInd72LYyHn6GzRutU0tTjICC0uPvHXxQx/lSAkY6bVr/
         MvsQnd4Xwa59mIxZYDtjVdibBetwTbRgSOaoopxUyKUFTsWRAp3a0zHplnvmz7q8RRAU
         72WWXfZbK2VH9o4VAuGetp/XVB9j6PBd5MXa9Hsnwyj2I0VqiWkLfTJ0o6OxgPhkbHKH
         JZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919961; x=1709524761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88SDs5w2MY5mWdpm7KClCN1gnNwWnjOc3NGMH26ZbvA=;
        b=A6YmYhj4cAG0cPj1oCoDRfhWj0zCWFpAgKt+ChE1qCvDtVKy97D7xZW+6S6j5+T1zI
         3GIrOw9K2PBE5tq84/GsgX6D4hp+P+f/j3COJxuf1Ms6bCOiVuHbxF3VhohKamdTW0Aj
         YxN6VQgQ4GQ1JEDlqAq7Uu0tjRj0zkVRwizY2ZlbYifnkODIhH5yzTMsdbr0KWYNldCj
         nPuDGkzaIn/jE3g17Rcnkl1RrT7Uexn0WaSfby47jPFCRLhcmRxESEri2ygsEWdu14jJ
         N6NbVSnn9VikEddfT0i/LjltDEuxmvmK5piheiDbUnUqAi7e3w8SjyEkyTWC9ISNq0Fl
         EHcw==
X-Forwarded-Encrypted: i=1; AJvYcCXAHQHSvWwfen08gMSZfmNM2HNHVQ343yqEv7gjkNPzYhHNu3hbfBi6R/K9rgNy9Y2fdmW9r9B0ekgKGbP6xqNA+5UcQfpvL+vNJbrs
X-Gm-Message-State: AOJu0YwQKmqS8wYfci1Fr/pg4vqrXqlW0GRew/0jyhDZo9JmkfS/FBbq
	T9gA/bru0d4KnpaUAJVCqKVyF46qd3E7gleJ55urqvg8ASw37s4AMIqlD3HTFIU=
X-Google-Smtp-Source: AGHT+IHHKA7WbMNfON9AlIWpadoT5wUcsmIO9ZwMI88sw4QwOntJPm3qi0ddoq5Mspb1oo2nJBuAAA==
X-Received: by 2002:a17:903:120c:b0:1dc:1831:8ede with SMTP id l12-20020a170903120c00b001dc18318edemr5950697plh.53.1708919961518;
        Sun, 25 Feb 2024 19:59:21 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id iy13-20020a170903130d00b001da105d6a83sm2893426plb.224.2024.02.25.19.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:59:20 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 2/8] Staging: rtl8192e: Rename variable TxRxSelect
Date: Sun, 25 Feb 2024 19:59:09 -0800
Message-Id: <20240226035915.370478-3-tdavies@darkphysics.net>
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

Rename variable TxRxSelect to tx_rx_select to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
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
index aa915d09bd63..05abc001507c 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1778,13 +1778,13 @@ void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
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


