Return-Path: <linux-kernel+bounces-40776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67F983E585
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731952834CA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B435D8F7;
	Fri, 26 Jan 2024 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="U62dS0b3"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD045B20E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308313; cv=none; b=T5F8ZHfifWyZ8owe1vg1jSC9sFDlfjzdMmEpK8nTWdO1JYRTTIQgvVELkv8cABd4gEjmUTZRfxhqkhrqMY+zzuQZiXelP9GNub8TvVVxIO2bMW2Xh6ODdGNqFsAfS7XDuaz4ntt+FhWi3I1fSUsRAhPt+jj7GDBCPbLvW9aUV6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308313; c=relaxed/simple;
	bh=vhQTx59EhDp/8Omj8PRaAAdTFVRz9iVZtUgCQ5BU+uY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SI1Hbc7N9ekwFLBImbQQ1Kh0qqzKkTE7UZfF4mbJqqFLDpvXQVOSaWYr5I9cph8gIZE0iVgifRBzQvpDcmbbBa/lzr36QcmHfW08oZ5DNXGtkyOMwT26x1gXoLpsIEgkbgpGnctc9p2Kr3AU0ownCVmdeVAru5iHzvQF+cPjzOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=U62dS0b3; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-290a55f3feaso689879a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706308310; x=1706913110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlVBJtkw1l7si7jTprgt58L/QjOTckkPdtqQKgZ7qLA=;
        b=U62dS0b37/BPjIciTKuFFY768aJx3pYpjDp0hWnMDQTUntrNlUSdYXWOj4yBWIErld
         nV2vUf/CmLnJxSSJS/lQbQK/B9pNRfi7l+n9cMHTXdm791jcvM+5COLzUq9Yjcn7Z/xj
         tKR5uQqW9aEirHEFeXLVEfU8jMjN5mDKwezDq1UUs9fqBcRgbws2MCO/Q8PELSB47WBd
         +i2JiZiW3pHHryQQRYRl5D6hoUFPZRi/rSkpdWqcwJQzCTiDzHxnYTr/ZaBuxB+kDQgb
         t8PI7xioidSIRIHAioLhp4j7kmQHb+KRIkAbUKiSmH2vM1ihDbbRyes5Ej1RFngt5knm
         MvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308310; x=1706913110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlVBJtkw1l7si7jTprgt58L/QjOTckkPdtqQKgZ7qLA=;
        b=d6sNY3Tm5I+r4y//EoAHxWw3pYaFj3AxXcj/NTaKQ8Tv6YVVV7TAp7JjR8bWj4JqVv
         P3O1iJP5j+hTIuXl5ueR42A1C2Q2HnruLk9LRPZpoqx43OHqsMC2rXXMc0dKIkmazA75
         P6OHQQDZqo+T+4TDXV8Bi4XS0Bfvo+9Q9x7H+/9posYYY+n6/OoSbflqkKj6wtTz36e9
         StT1XWudm4//q/5XLJfLfEg0+4lwH55SKAoQZXtdgGTD/t2V7UEOg5hnEawUqG03TV70
         8Cy9wHdOvDjChmZckbZlE5lEnjBMFRKDFfoP7iZD+ONrBgEFflLdW9wliq+/AEuMTFSv
         LujQ==
X-Gm-Message-State: AOJu0YxBGVMQ7IHnv58VrSP22wHd5SOUL0LOYdPUdV326Evl1WBmsrQk
	69xQfwoexIut2mMtsZcaI/7RTNG3Ib+TrdMoCw7ia0T0HN2Gg18FdPdLSYGoOks=
X-Google-Smtp-Source: AGHT+IF4CuXSLwk3kOCA4efxj42oBrPzqCRnZnZzDG/Y1fAqMUlIt1QFsdFvcEJ63dU+tJ2KqP+XKQ==
X-Received: by 2002:a17:90b:3112:b0:28d:2a72:546f with SMTP id gc18-20020a17090b311200b0028d2a72546fmr567830pjb.70.1706308310600;
        Fri, 26 Jan 2024 14:31:50 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8a8f431b7sm737909pln.300.2024.01.26.14.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:50 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 16/18] Staging: rtl8192e: Rename variable LpsIdleCount
Date: Fri, 26 Jan 2024 14:31:04 -0800
Message-Id: <20240126223106.986093-17-tdavies@darkphysics.net>
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

Rename variable LpsIdleCount to lps_idle_count to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No changes.
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h          | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index 44a9fe831849..5aac9110bff6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -208,12 +208,12 @@ void rtl92e_leisure_ps_enter(struct net_device *dev)
 		return;
 
 	if (psc->bLeisurePs) {
-		if (psc->LpsIdleCount >= RT_CHECK_FOR_HANG_PERIOD) {
+		if (psc->lps_idle_count >= RT_CHECK_FOR_HANG_PERIOD) {
 
 			if (priv->rtllib->ps == RTLLIB_PS_DISABLED)
 				_rtl92e_ps_set_mode(dev, RTLLIB_PS_MBCAST | RTLLIB_PS_UNICAST);
 		} else {
-			psc->LpsIdleCount++;
+			psc->lps_idle_count++;
 		}
 	}
 }
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 8de46b61416b..0ca38ca4d3af 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1071,7 +1071,7 @@ struct rt_pwr_save_ctrl {
 	enum ips_callback_function ReturnPoint;
 
 	bool				bLeisurePs;
-	u8				LpsIdleCount;
+	u8				lps_idle_count;
 	u8				lps_awake_intvl;
 
 	u32				CurPsLevel;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index e47292455585..a7e7a0b0214f 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1079,7 +1079,7 @@ static void rtllib_associate_complete_wq(void *data)
 		ieee->link_detect_info.NumRecvBcnInPeriod = 1;
 		ieee->link_detect_info.NumRecvDataInPeriod = 1;
 	}
-	psc->LpsIdleCount = 0;
+	psc->lps_idle_count = 0;
 	ieee->link_change(ieee->dev);
 }
 
-- 
2.39.2


