Return-Path: <linux-kernel+bounces-80518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FF9866916
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72621C23E37
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536E84E1C3;
	Mon, 26 Feb 2024 03:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="D6EivWcS"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD94A99C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919968; cv=none; b=dvkhR6xsTZX1Ul+R3UrXbH9CDNmebd+tN6SltUnhFFB8NE/Iv8I8l4dkL8hwYn3K1bfTexOjqKCGzL/2IxpClrWKExDj1cbN//+r+D7Ik8UjARlBkqc3NMcn6AuwAqZS5DFc6vXR+YkGPFpUfeHF0BxoyDoTGJ8mTphACxax5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919968; c=relaxed/simple;
	bh=YCeunnsu5ZMYeBtB47AcnaouRPKXI3Zjqo2gxMsyYT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cmCVVMyuubjt1hKno4yRUIcu6BBPyXR1vYUluomNNCOyEhJ0Eg1oHRUwz62nYJP/mHiwl47vRbCi2bGhoOkk7zmLjTo28uDa64tRmDJBGzCSZYmjU0gS2VVRnW48DXuKeNqv2NcyzZfC0rSIFTU/4LHnxcYl8IEsrk3G3XtyYPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=D6EivWcS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d911c2103aso11055505ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919966; x=1709524766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWpbo37RpiaoOqXUf66a114Vy7k4lyCvrRXvqAK4Zg4=;
        b=D6EivWcS4+3gCo8yYQ64IKt8nzFQemDE5xN/633vb+lArmNOXkq5yFyZYbGWpD2AV2
         BiDcGoM04ykefENl9IdXVVIHGHSANIh/QITJP7qU/Uz7TLd03/pzC5zo2/61yxVoognd
         zdXPv9pdpPKs/2kqSMPQpqcCNadICW+Sko79LWA0WFzqWv2z+Tfx8WD5+lnWe66L0aIW
         4C5iEqxkmB/WoNqz1FmGtjfLHgdyLPbaZBOtelg7E1bRYf9LfoSItDr7G7cLXJQobCeh
         X0lao6iQ0aoCyhPmjBYwYdPIswW2y4yStb7C54P8QgcTs69G5gzfAjAYlPdCM4aWrsuG
         B/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919966; x=1709524766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWpbo37RpiaoOqXUf66a114Vy7k4lyCvrRXvqAK4Zg4=;
        b=i1J18io+RUidbRQiD1Ezj7BEbgaG6wxctRlfpVRv/9C6lX9zCDrxNqoLSvwiew1foF
         gV3AnSX1imbVhwgYzW3MkDD3U/auBvrEHp/AecW3pPaCgjAs0TYhW0KzPRAZYq/nO7fi
         tIyNO6qoy1SsYUt3yWvZ5W1v1oa8M5Gyp9sJTnOO6WiEzYVbENEDd63F55C4+fRdk2oz
         qbrIFs75vpnR0aS8Y8f3Xz8dH30xT+oS3ZUAaKvwEofBMKrRq5ib2lQ2TsnngXHXlm6f
         vHsu9sFufxxHkGoDp43fK4n6BTuof/FtrR4cMpgqiUz7EJO7WHJQG+tBGnXsDpWJxsqy
         CXIg==
X-Forwarded-Encrypted: i=1; AJvYcCXXC5C76DtLNO4O3f52Jc7rpFqe2Pbki3O2wL/qpwNUn6lnJmPPDnk/OYxtEeRtvgIjK7a3bka6uSfytWC7dgSuNnrOcEIRmjBMAVNi
X-Gm-Message-State: AOJu0Yzegtldku+5Z780wqUIYWIxna+sKd0eNElL+zCm+Nhu1WVut4ml
	EpTLp77bd/GbAr60TBRTP9W/lUNoZW76qQoG9uL/joDHue2yPrZ0xwpWJ/tstwHEWJWEgjM58Er
	+
X-Google-Smtp-Source: AGHT+IEZAv3+kYJiLUplU4IGAkwZIxGgUDOEJJsitJKA5Btui7bzAy2jdmP9SKECRcXVmeOi4i6//w==
X-Received: by 2002:a17:902:f545:b0:1dc:696d:6bb0 with SMTP id h5-20020a170902f54500b001dc696d6bb0mr7048782plf.6.1708919966520;
        Sun, 25 Feb 2024 19:59:26 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id iy13-20020a170903130d00b001da105d6a83sm2893426plb.224.2024.02.25.19.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:59:25 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 7/8] Staging: rtl8192e: Rename function rtllib_FlushRxTsPendingPkts()
Date: Sun, 25 Feb 2024 19:59:14 -0800
Message-Id: <20240226035915.370478-8-tdavies@darkphysics.net>
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

Rename function rtllib_FlushRxTsPendingPkts -> rtllib_flush_rx_ts_pending_pkts
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 0581ed1e9ed1..04f3fb54d1b7 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -268,7 +268,7 @@ int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 		goto on_add_ba_req_fail;
 	}
 
-	rtllib_FlushRxTsPendingPkts(ieee, ts);
+	rtllib_flush_rx_ts_pending_pkts(ieee, ts);
 
 	deactivate_ba_entry(ieee, ba);
 	ba->dialog_token = *dialog_token;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 05abc001507c..fe850dbeaa02 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1810,7 +1810,7 @@ bool rtllib_mgnt_disconnect(struct rtllib_device *rtllib, u8 rsn);
 /* For the function is more related to hardware setting, it's better to use the
  * ieee handler to refer to it.
  */
-void rtllib_FlushRxTsPendingPkts(struct rtllib_device *ieee,
+void rtllib_flush_rx_ts_pending_pkts(struct rtllib_device *ieee,
 				 struct rx_ts_record *ts);
 int rtllib_parse_info_param(struct rtllib_device *ieee,
 			    struct rtllib_info_element *info_element,
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 051371e0138c..be0f92e97d12 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -487,7 +487,7 @@ void rtllib_indicate_packets(struct rtllib_device *ieee,
 	}
 }
 
-void rtllib_FlushRxTsPendingPkts(struct rtllib_device *ieee,
+void rtllib_flush_rx_ts_pending_pkts(struct rtllib_device *ieee,
 				 struct rx_ts_record *ts)
 {
 	struct rx_reorder_entry *pRxReorderEntry;
-- 
2.39.2


