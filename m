Return-Path: <linux-kernel+bounces-40765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD4B83E579
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FB71F24BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B4A51C2D;
	Fri, 26 Jan 2024 22:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="MrkWa538"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207CF50274
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308304; cv=none; b=FJ1KuRm4sWm1lqeUMeRulcci8EkjilbuIUQ04skZv4qywAJci/9O+rM7cydydDx13oIBlBQ513bVm+xQpPSCmfwDE/I+vWGFkUja+qewDfeG00v74YSxqotTbQQlNEUIKWJwETMXSltHwOsJrQLe2b4ZIpEUjb3k5Yz+GXXLfxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308304; c=relaxed/simple;
	bh=sls9lOLiewyZnZBlFZG2x7cmxajKi6xq3fen54zVl6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8WaAgkTgzkGDiD9YRMEAibyrt0gFrBj79SmByIEtCyRkidxwSHiKjWX4mGwBuBhMSK1dEXftZpXIrEb8EngtSs6/9a+j2/xtjI867MJlUfJKDa9sJ/3KH7ZEUCJ7oRME1LwcYtstwySsB/+yEkYmcw1MIZAh2o+vQh1ccGORN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=MrkWa538; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d70b0e521eso6903585ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706308302; x=1706913102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIloziZvKZDMPx2ffynApFl8FumiobB41xehjM9PZEw=;
        b=MrkWa538oKH+JgsUsvHIL60EETvuf9xkuZ0taQT3U/zTu+f1GbM+jVkftztppOQGE0
         y9Kly31kinS7bLhuqwv7pe+zL7YhdRXy9HJT/BcyvW/LfbtHGRmfr4BnEI4Q3F2o2ycS
         rjGtEEiY9HeXmXO1EAoKzjVsig6vXzpO8BGraL+7Cj3Bgql/nJe8TC82sg2UYz4MVh23
         XnaSt7EgDannZzBqOrBRvzvJrRgFhcsGrILC75Hlx3mORa1+VE/iIOSU091PMfwKCxjV
         qLobiabKf3GrN6ltQGEIh8z6dkz6YZFLongR8xIL48jxnF+lgrEd46QW5Ugpu6mOZGaI
         ursA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308302; x=1706913102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIloziZvKZDMPx2ffynApFl8FumiobB41xehjM9PZEw=;
        b=VH3uz3JP/OdKBdgA32s84FLTdxAuXKfLIwhlBDkczv5SN4y8mNe+8Es+2ZDpdM5SoW
         K3lZewyNw9Kr/Q+CHEDPqR0XWUfjSGD01vKu4KE8rqVl6igQkt2tPSzo0nh/q13wQ+Er
         0N/sEpDcLOzeDszaF0XfdtcglBlf2gkPNMRdvDeqDD37Bzrn9jbfs5ZUa5wVNQ7XqtNo
         /KJ9bWEcJUe3mFYOnwyvylCid2jjZGgEEP9/HWGEzFYhn6XyN2CcvoG65qEjFchLpCC4
         BgAlYXki6SsjrSYznLS+5nGl/lELiuDQR2RIo4rVA1708e9BF6M+2GYgA1TW5GeeWwIZ
         jeKw==
X-Gm-Message-State: AOJu0Yz+M6FZe2LmdpQevPvOqW6cta1Lq+rFVEHknbAhxYTtw04f/c9f
	BI31gThEBUO51wmZHgLU7Ly+oyIlY5GJnhPeZPhpPfUsiHElfdUd5FFjljOqcIA=
X-Google-Smtp-Source: AGHT+IH8czhpUrofjKlE0UIUZgKxhByK82tZ6+dPWJfryzEusRxvJpruXSxlyoeQLlBTSW+RwZyoHQ==
X-Received: by 2002:a17:902:b949:b0:1d7:4377:e5ff with SMTP id h9-20020a170902b94900b001d74377e5ffmr507234pls.122.1706308302392;
        Fri, 26 Jan 2024 14:31:42 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8a8f431b7sm737909pln.300.2024.01.26.14.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:41 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 06/18] Staging: rtl8192e: Rename function MgntQuery_TxRateExcludeCCKRates()
Date: Fri, 26 Jan 2024 14:30:54 -0800
Message-Id: <20240126223106.986093-7-tdavies@darkphysics.net>
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

Rename function MgntQuery_TxRateExcludeCCKRates to
mgnt_query_tx_rate_exclude_cck_rates to fix checkpatch warning Avoid 
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Update commit message.
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index cd45a9c46a94..c380d1c3e9b6 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1821,6 +1821,6 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 void rtllib_indicate_packets(struct rtllib_device *ieee,
 			     struct rtllib_rxb **prxbIndicateArray, u8  index);
 #define RT_ASOC_RETRY_LIMIT	5
-u8 MgntQuery_TxRateExcludeCCKRates(struct rtllib_device *ieee);
+u8 mgnt_query_tx_rate_exclude_cck_rates(struct rtllib_device *ieee);
 
 #endif /* RTLLIB_H */
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index b5fe471f765b..c231e7acd606 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -138,7 +138,7 @@ static void init_mgmt_queue(struct rtllib_device *ieee)
 	ieee->mgmt_queue_head = 0;
 }
 
-u8 MgntQuery_TxRateExcludeCCKRates(struct rtllib_device *ieee)
+u8 mgnt_query_tx_rate_exclude_cck_rates(struct rtllib_device *ieee)
 {
 	u16	i;
 	u8	query_rate = 0;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index e61eb6e87ab4..54100dd81505 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -832,7 +832,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 			if (ieee->ht_info->iot_action &
 			    HT_IOT_ACT_WA_IOT_Broadcom) {
 				tcb_desc->data_rate =
-					 MgntQuery_TxRateExcludeCCKRates(ieee);
+					 mgnt_query_tx_rate_exclude_cck_rates(ieee);
 				tcb_desc->tx_dis_rate_fallback = false;
 			} else {
 				tcb_desc->data_rate = ieee->basic_rate;
@@ -856,7 +856,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 				if (ieee->ht_info->iot_action &
 				    HT_IOT_ACT_WA_IOT_Broadcom) {
 					tcb_desc->data_rate =
-					   MgntQuery_TxRateExcludeCCKRates(ieee);
+					   mgnt_query_tx_rate_exclude_cck_rates(ieee);
 					tcb_desc->tx_dis_rate_fallback = false;
 				} else {
 					tcb_desc->data_rate = MGN_1M;
-- 
2.39.2


