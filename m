Return-Path: <linux-kernel+bounces-82692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AF386884D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B28287018
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53895579F;
	Tue, 27 Feb 2024 04:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="iAiBBt4N"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C6C54F83
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008934; cv=none; b=gVa6GxmTg2D+dxfd+orRmmPOSTB6/MES/glXftVHBA/xSRV+5RIeQ6Werqt055WcKL0NAVAO/abv3jWBDGnPswFE9cBlfnq1Gy/0Nd8Dt9VcM0X4WnE+GmjcboaVUjCeDqNY7PzMHWwafwxARqueTDmgF5CXPscm4XazaeyJrsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008934; c=relaxed/simple;
	bh=PG7R9LP/p6+DQlOU8Jrp8FyMGw5i1TE9sJUY1y+sl4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pRKooOca8oGTvsN5bYpAq8NuYCFYwCrY0+I0FafL1fpOAuYodXj1ZCXJ9lFB4mDzOlg9VQEJnmjzig489XEC3iUWKw2ByciXooDVLvQELGomSR7mE3ZnmM//PxwAFn4eg93RloJG+HI/DNvbA+4ji2eUi4YFCZye3ezdbeJMRFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=iAiBBt4N; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e4751b97eeso1907792b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008933; x=1709613733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kj0lfzux4GLg48IwZCKkqknJLfu/rk3Sg7vSDrSduwk=;
        b=iAiBBt4NA5rKtqX7qz7y1T1QsCAW4oObXL8SLLx2e4pAyagpudcS0Uhi+TEeXdhd+v
         pjME8t2OaZ19GO13iLK2+0XYZn3h76GMMhVrYiMlHn0METc44+zecAgGVXOKFLIo3p1m
         qpVMSLYfkIQM8ppNREFw/oehGpgUauXol5GHtxu2zYTexDgXPyrbe9f6m4NdWAvu8jSK
         mU+UGRwlUQAJafD+Uat+zRv8M3msTMmMdrAcXXsWKcHP2ySYdKjwpvXNoR8Qxl/i80DD
         ep4sD+C28r5Ks/Wpw8cHYoRBxpLZHCCfy1g+vKzUlPidQqzIhF9aZVxyhPoLtO75Cd8q
         IzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008933; x=1709613733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kj0lfzux4GLg48IwZCKkqknJLfu/rk3Sg7vSDrSduwk=;
        b=M/R481aFi/YuvE13oLV6PULK24u45lx4XDMGi/k81rnZKjfivNTs40xf7fLQe0hgro
         sJscomXJDuYhqyaHu8BhIHaI7CJ7CmFXq0QlLmHMO8h6OUMInoxYKsg8j6ByaMUo18Xz
         UzjsuiLZ75SiXpCp+I/gP9e89LMpfG2UNLCAmtHHtL1IdZT2kj9c+VffXvw6z7qXYh9p
         BLJ54fZHfXmQ4VxLIC6nG3RcdSzpsC+jMQGVibaEfot+SL/1Q6ywoYdC4VODvTnqUo3T
         3FD0RYTIQo7NptYTzjoh9pdNdD/5h0V/te/XDAo8O77ogskVa10GjKi6cOUmTPMgnoXb
         fhvA==
X-Forwarded-Encrypted: i=1; AJvYcCWLwWUBXPH03rXpqn9/iLCGeizIJA1Bbb2wXDiQT0/SX8U3E/ZeEDYmMjXM9OB1Y29VP1vrqY/VDhuudXwYjSMIW+s2535WpyVaFkeB
X-Gm-Message-State: AOJu0YznQ/hg1yETZ/QkjOSo18Lkc7SPFwXGSRNhOYpBv/GhWDZkka00
	H9XhLBVpNhYD7owgLPTKhVfmKhpcnGwY3PlMkNOBayv0ON6NQGGwVx0rSk8QVtI=
X-Google-Smtp-Source: AGHT+IE0lUScJ3xAwnkBadKfEUlNWkvrb2ESJhkg7t+RUXumRrq4RsPKNyjQWwYkasqZNODYhJr2xg==
X-Received: by 2002:aa7:9992:0:b0:6e1:482b:8c8e with SMTP id k18-20020aa79992000000b006e1482b8c8emr7529222pfh.17.1709008932871;
        Mon, 26 Feb 2024 20:42:12 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:12 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 10/20] Staging: rtl8192e: Rename variable BssCcxVerNumber
Date: Mon, 26 Feb 2024 20:41:47 -0800
Message-Id: <20240227044157.407379-11-tdavies@darkphysics.net>
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

Rename variable BssCcxVerNumber to bss_ccx_ver_number to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: no changes
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c      | 6 +++---
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 9ec4a3b8ae3c..c703e6d95fb9 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -935,7 +935,7 @@ struct rtllib_network {
 	u8	MBssidMask;
 	u8	MBssid[ETH_ALEN];
 	bool	bWithCcxVerNum;
-	u8	BssCcxVerNumber;
+	u8	bss_ccx_ver_number;
 	/* These are network statistics */
 	struct rtllib_rx_stats stats;
 	u16 capability;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 103117692a88..051371e0138c 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1843,10 +1843,10 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 	    info_element->data[3] == 0x03) {
 		if (info_element->len == 5) {
 			network->bWithCcxVerNum = true;
-			network->BssCcxVerNumber = info_element->data[4];
+			network->bss_ccx_ver_number = info_element->data[4];
 		} else {
 			network->bWithCcxVerNum = false;
-			network->BssCcxVerNumber = 0;
+			network->bss_ccx_ver_number = 0;
 		}
 	}
 	if (info_element->len > 4  &&
@@ -2356,7 +2356,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	dst->bMBssidValid = src->bMBssidValid;
 	memcpy(dst->MBssid, src->MBssid, 6);
 	dst->bWithCcxVerNum = src->bWithCcxVerNum;
-	dst->BssCcxVerNumber = src->BssCcxVerNumber;
+	dst->bss_ccx_ver_number = src->bss_ccx_ver_number;
 }
 
 static int IsPassiveChannel(struct rtllib_device *rtllib, u8 channel)
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 477d736fe22d..794c50b2737e 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -744,7 +744,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 		ckip_ie_len = 30 + 2;
 	if (beacon->ccx_rm_enable)
 		ccxrm_ie_len = 6 + 2;
-	if (beacon->BssCcxVerNumber >= 2)
+	if (beacon->bss_ccx_ver_number >= 2)
 		cxvernum_ie_len = 5 + 2;
 
 	pmk_cache_idx = sec_is_in_pmkid_list(ieee, ieee->current_network.bssid);
@@ -851,11 +851,11 @@ rtllib_association_req(struct rtllib_network *beacon,
 		tag += os_ccx_rm_cap.Length;
 	}
 
-	if (beacon->BssCcxVerNumber >= 2) {
+	if (beacon->bss_ccx_ver_number >= 2) {
 		u8 CcxVerNumBuf[] = {0x00, 0x40, 0x96, 0x03, 0x00};
 		struct octet_string osCcxVerNum;
 
-		CcxVerNumBuf[4] = beacon->BssCcxVerNumber;
+		CcxVerNumBuf[4] = beacon->bss_ccx_ver_number;
 		osCcxVerNum.octet = CcxVerNumBuf;
 		osCcxVerNum.Length = sizeof(CcxVerNumBuf);
 		tag = skb_put(skb, cxvernum_ie_len);
-- 
2.39.2


