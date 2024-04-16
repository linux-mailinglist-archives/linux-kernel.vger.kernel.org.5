Return-Path: <linux-kernel+bounces-146733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 039DE8A6A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269D81C20C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5626129E88;
	Tue, 16 Apr 2024 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sq7AS0AV"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE55129E70
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713268770; cv=none; b=r15pFUKB8yuE+nw9IM8in6PLa5MYMhQxBwrjcmMBxHw/9iDfYoQf3xA5GBBRBgDD7hHEX/TBrpMf+x6dr63GG9OSkW+s7OMG8JE0q3njkPE81IeORQkHThUc+mTi79+5TUNKGdK+AjyDKkELNfkX8xnHhoRzLqHwLAJy/rP9Yi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713268770; c=relaxed/simple;
	bh=qbqi+XsX6wxH4QDDPdchG2lSzTVOiuCarFXtt6z8m5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iodQNTMN5sHqVIqhtG5RcSjbNF8LTg+8F4ByE4yeiLXtKO5HQ/tgCsHzeAnwiVUu/abhT/2+g6Y1IhCpL+M9aULmbfUp5FOZ0lqg1nmVTe2eVJIe7p15q2iMopSRIB0cWWlDJxLImlrk2Jnq3IyRQkNh5eEc25wuRl89J8+l94M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sq7AS0AV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so34128905ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713268768; x=1713873568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hQ8Km8pUrRdj6HD7UNUZL3puRDpbGZKIzvHBUwGPNQw=;
        b=Sq7AS0AVnoecKFWatpxGI2SSmdkhBbFCsgLii44duGuCJ4saM4AbnEXdoXDcXoY1t5
         EiogZ5nylvlaTh8K8zviKfTr2C+ElWN/O7WS1r1BAHwnnjpkkxudDRj2b3eNpNhUPXIR
         HXiHi0IFuOMXDZz2dudbSURVrymaF1fU2IQAp8CKH9NwqS5Z+OR2wdkxOlaHV76mN30f
         Wx0zQC31+N/HW5qYyWOtKJFNKP0/7AUcjq7SsAhiIdy3W/qaKKjwrRohgAT/DkvdxqZS
         HkIwepD3jH1ij0/y74nrAToWsg7ia+WUyKKhfBcs5LXtxbyOZNhtgjEBU6VpViqJU6Ro
         ATuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713268768; x=1713873568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQ8Km8pUrRdj6HD7UNUZL3puRDpbGZKIzvHBUwGPNQw=;
        b=NuFuOBhInaAibnuOZ1eGq17wL+JXbZ2ccFF0YVD9chN9AMBMl9YqYBB7v+j6sapA2k
         hasT1p+zocY9q8g9WXfiXDDn7RXtoNfw0DxJYcJWlgj1duNI55TIf9rXv7DqwTu2Uob+
         MJmIEHPJwnNoxgqKi/VOKiDi96nExkfjcYxd+lDyc0v9CKOGIHT/wBjhP4912Ntfk2Z5
         /yAPSXADKLIOmCQdwbaDvoE4QzTd6VXU+W9gq6ETYEHjiDOGQirgGplNLJUyKq9N3gio
         aDCE5IEHrc8q2jYWgyYcdmadEAQpiwyOVawK74L01SZuScvM+/QQryYOuNikCFJZvIWI
         27JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKcFyCenRR6oaHP0o/HZ5aZvoH3E3YhvIx+9U2kHRa4eQ9K/zAxF6ARf/bvK3mUC2khZWWAyLMCeAxIwBT1d+CLUCjH/xRw05bLRKY
X-Gm-Message-State: AOJu0Yw4athRS+YMhftXMCc2jy7rHeGZVszs3fwcGUmFgzTiJZdfte+6
	5QcJyRo5U9xtwPFcbhMhOp33Gh+TasF//IdqUwq6jKeqVwFQJSnZ
X-Google-Smtp-Source: AGHT+IG3114+5T4rKIudyGIHpqSw90eJAE+y4lnLAgiCoA96yKOqVpWxd3xunDkFep4E/G/a19QgEA==
X-Received: by 2002:a17:902:f688:b0:1e2:6165:8086 with SMTP id l8-20020a170902f68800b001e261658086mr13188458plg.61.1713268768024;
        Tue, 16 Apr 2024 04:59:28 -0700 (PDT)
Received: from karan-IdeaPad-3-15ALC6-Ub.. ([2401:4900:1c96:c7dd:27d5:f53e:33a6:5717])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902c41200b001e3dff1e4d1sm9590941plk.268.2024.04.16.04.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:59:27 -0700 (PDT)
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Karan Sanghavi <karansanghvi98@gmail.com>
Subject: [PATCH] Staging : ks7010 ks_wlan_net : Fixed Unnecessary Paranthesis, Prefer Fallthrough and Line spacing issue.
Date: Tue, 16 Apr 2024 17:29:03 +0530
Message-Id: <20240416115903.92706-1-karansanghvi98@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed a coding style issue.

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
 drivers/staging/ks7010/ks_wlan_net.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 0fb97a79ad0b..4b1b5d9b883b 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -12,7 +12,6 @@
 #include <linux/netdevice.h>
 #include <linux/timer.h>
 #include <linux/uaccess.h>
-
 static int wep_on_off;
 #define	WEP_OFF		0
 #define	WEP_ON_64BIT	1
@@ -181,26 +180,26 @@ static int ks_wlan_set_freq(struct net_device *dev,
 
 	/* for SLEEP MODE */
 	/* If setting by frequency, convert to a channel */
-	if ((fwrq->freq.e == 1) &&
-	    (fwrq->freq.m >= 241200000) && (fwrq->freq.m <= 248700000)) {
+	if (fwrq->freq.e == 1 &&
+	    fwrq->freq.m >= 241200000 && fwrq->freq.m <= 248700000) {
 		int f = fwrq->freq.m / 100000;
 		int c = 0;
 
 		while ((c < 14) && (f != frequency_list[c]))
 			c++;
-		/* Hack to fall through... */
+		[[fallthough]];
 		fwrq->freq.e = 0;
 		fwrq->freq.m = c + 1;
 	}
 	/* Setting by channel number */
-	if ((fwrq->freq.m > 1000) || (fwrq->freq.e > 0))
+	if (fwrq->freq.m > 1000 || fwrq->freq.e >)
 		return -EOPNOTSUPP;
 
 	channel = fwrq->freq.m;
 	/* We should do a better check than that,
 	 * based on the card capability !!!
 	 */
-	if ((channel < 1) || (channel > 14)) {
+	if (channel < 1 || channel > 14) {
 		netdev_dbg(dev, "%s: New channel value of %d is invalid!\n",
 			   dev->name, fwrq->freq.m);
 		return -EINVAL;
@@ -663,7 +662,7 @@ static int ks_wlan_set_rts(struct net_device *dev, struct iw_request_info *info,
 	/* for SLEEP MODE */
 	if (vwrq->rts.disabled)
 		rthr = 2347;
-	if ((rthr < 0) || (rthr > 2347))
+	if (rthr < 0 || rthr > 2347)
 		return -EINVAL;
 
 	priv->reg.rts = rthr;
@@ -701,7 +700,7 @@ static int ks_wlan_set_frag(struct net_device *dev,
 	/* for SLEEP MODE */
 	if (vwrq->frag.disabled)
 		fthr = 2346;
-	if ((fthr < 256) || (fthr > 2346))
+	if (fthr < 256 || fthr > 2346)
 		return -EINVAL;
 
 	fthr &= ~0x1;	/* Get an even value - is it really needed ??? */
@@ -780,7 +779,7 @@ static int ks_wlan_set_encode(struct net_device *dev,
 		return -EINVAL;
 
 	/* for SLEEP MODE */
-	if ((index < 0) || (index > 4))
+	if (index < 0 || index > 4)
 		return -EINVAL;
 
 	index = (index == 0) ? priv->reg.wep_index : (index - 1);
@@ -881,7 +880,7 @@ static int ks_wlan_get_encode(struct net_device *dev,
 	}
 
 	/* Which key do we want ? -1 -> tx index */
-	if ((index < 0) || (index >= 4))
+	if (index < 0 || index >= 4)
 		index = priv->reg.wep_index;
 	if (priv->reg.privacy_invoked) {
 		enc->flags &= ~IW_ENCODE_DISABLED;
@@ -1863,8 +1862,8 @@ static int ks_wlan_set_power_mgmt(struct net_device *dev,
 	    uwrq->mode != POWER_MGMT_SAVE2)
 		return -EINVAL;
 
-	if ((uwrq->mode == POWER_MGMT_SAVE1 || uwrq->mode == POWER_MGMT_SAVE2) &&
-	    (priv->reg.operation_mode != MODE_INFRASTRUCTURE))
+	if (uwrq->mode == POWER_MGMT_SAVE1 || uwrq->mode == POWER_MGMT_SAVE2 &&
+	    priv->reg.operation_mode != MODE_INFRASTRUCTURE)
 		return -EINVAL;
 
 	priv->reg.power_mgmt = uwrq->mode;
-- 
2.40.1


