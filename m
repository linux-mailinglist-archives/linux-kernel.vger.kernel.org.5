Return-Path: <linux-kernel+bounces-92913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5C587280F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA7C1F283EC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EF15BAE6;
	Tue,  5 Mar 2024 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="o1xDt343"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D624B59;
	Tue,  5 Mar 2024 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668534; cv=none; b=I7SOG9DGSQiQYjD9eFBIaPdR8YgSkZSBVLvc9TpIq+gqjjb4S8jF5QZKw8WM0QhQVxk90M5iZVU4RCilLm9lgrFDhhx5hAIo/WJK9Q8ciIBRD8Jdp4uGsCn757lL6DLhbUsTksgeUrYc1CRRs1eSYBfKf+TFbfS6TClAYvhaeMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668534; c=relaxed/simple;
	bh=5g5PeUs2Xr0sbJmSz3oVuKNnaFP8CxzfBpEI7WmRjZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WGJAwLbRHK2qwARgA5JR1EvVutB/ZY97uFRqtAkToT/Jfw+UJmqRVOEonVhnBfq0YD7kZmdJnKmG8hKuiDriQN1V3A33vCaCa+NoEJrWs2PTXbfEKLABBUI0Zn7W9Nelr+iIMyamIYUqCFoM2v9Y4E4i1mBMOYc54WYoA9AReN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=o1xDt343; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so5275326a12.1;
        Tue, 05 Mar 2024 11:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709668533; x=1710273333;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAWw5ssJDn4vzurMzg4iaWJeKDfogx5EbUQszmk3BoU=;
        b=fOyujHx2sygF7pnKfExgcElVq0WwfZZISrmAZj4rAXc8PnmCROQwwmguKZ3n0WTStI
         hIlyXg5XuNeknvjNuPYWNfwknbXNDws+Zjzhf/wAOHV5XZvxOnCAv6dRrwwM+gQnz5Sc
         LgB66vNE6dTsLeDZA2kL2XKURzxHf/zLG/6VblSLPxCs1uTswu4DaTfdgmDpmCUitV7O
         wAD0EwdcrfoicP0U7H6Gk6Aae1q4lao7ecTmVRSFRAm78SGuUjPbdKs0/aW2oF6BXSEq
         aZ1taAZgWF3UhQtujnEMgpCOiUMp3d5BpOMxGGby8Wo0uZgIFnSsCrz7TpY4n+oqRNKE
         fgUA==
X-Forwarded-Encrypted: i=1; AJvYcCVe7ahm4xVusCiBu8ZZBhaTMNljNvP3yA9UUWRPwqUYiVBp53EWjjafgtnE4YqCwx/qb1DZzguFp0Ytrpy2+vX547d9lmurfyAfHwk9syqyLI59xYqa5278+VxHFGzpVOttVyU3
X-Gm-Message-State: AOJu0Yz+XiDdNiXGcfnKf2eI0+j1Ua5WlBcqyE0cG7zNInMxh605hMHU
	zIZZCr9jaRwfxEAAYyLAalFk2wW43hMq3gzy0yum4w77rN5v9eGt
X-Google-Smtp-Source: AGHT+IGUUnI38zxvvToo3773HNpuVccJz5KbhoVIfPsS4kC0d8I7rPtrt2sds+APSzfP9Ew0Bz+JpA==
X-Received: by 2002:a05:6a20:3812:b0:1a0:cd54:6d9f with SMTP id p18-20020a056a20381200b001a0cd546d9fmr2268173pzf.23.1709668532692;
        Tue, 05 Mar 2024 11:55:32 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id p13-20020a635b0d000000b005c6e8fa9f24sm9619194pgb.49.2024.03.05.11.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 11:55:32 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709668531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wAWw5ssJDn4vzurMzg4iaWJeKDfogx5EbUQszmk3BoU=;
	b=o1xDt343909j+4XKO1ilHSWI51mTKrS0hz0gvn1vAINCChFHIAWqxGCd2cMAboBXIsbZGH
	cvguAYhjB2/TIrWI6aVxO1Y+/HLG0mu5AQfxovLSJVBkC5aJAGX1jPSQGyc3pDUX/rIrP9
	ir7CzO2mIQwkFaNvKqyjkOUc3gUAiT9pLVxHBvQFyY3kpkVUDoF59yOWHwFOr6SHqGYZMh
	jVvJKFBUzjrYs7w8rj5eMD+qzYDwSLx1g7m3l05W3bKbjsY4AqTVKEV+WzhxWuLsn3c52s
	immkWohZ9m4LHxaKEi7c+Bk2O2uTNcklhnsvsEfyfOMvMmVkVc2DiaB2RukS2Q==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 16:55:24 -0300
Subject: [PATCH wpan-next] wifi: cfg802154: make wpan_phy_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-wpan-v1-1-376f751fd481@marliere.net>
X-B4-Tracking: v=1; b=H4sIAKt452UC/x2M7QpAQBAAX0X729U5JF5F0jmLLa3r1lfJu7v8n
 JqZBwQDoUCTPBDwJKGNI2RpAm6xPKOiMTIYbQqd61K51Yr0bkXLh1eXt6wmU9dZlZuqGDTE0Ae
 c6P6nLfwG471D974fN9/73W8AAAA=
To: Alexander Aring <alex.aring@gmail.com>, 
 Stefan Schmidt <stefan@datenfreihafen.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=5g5PeUs2Xr0sbJmSz3oVuKNnaFP8CxzfBpEI7WmRjZk=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl53iviWc0vfppzGfeoCCIqnWFtaeGWkcAeRlAS
 OiEHdGnJVeJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZed4rwAKCRDJC4p8Y4ZY
 po4XEACd5HZ/OZlLFhCxh5ObVkQPMRae+B1vuLJAnREVVFtOM0o79QHIotlmbL++WpeSFDy+aJa
 GQKCVrdY0Gvq69lwBKj4RvZJkgTszrN4fDWCWX/nlBj0az7lC6oFM2uvlaa3hXPCjhhQgTT3xGS
 naNLd/naSLKxVHRGxl9qvigAfXYQG7OrbO3uX3wq6IUAuDJNZdchl/bjGfPjsImuY1aeszKqwxD
 zRyKbXuBwOdvJaUe+8CK/I+LYFYP0G8KGMmVCnLeyn3+/+65JkN8HtTNd3aIeEIOZJ4jkyxvHY0
 YO5qT9FFN704eofotiNi3HlusThSUOZr/qSEfTGeB5xEivrldUXZGH4rA8hMj9D5jyqEVGXbYic
 f2Jlif6H/G/PV/ck1SHqX+40Lf8jWB/4IsNCwSeksJJFby5Nruw5gk8RV/ujWLPLd4qzgXlriy/
 EvohQtOD9iWo/A4GxStiEVKqWogOiGTnM5tQEVbrJnZcv9tpyviAxmy4hi6yd0jzA6vAbekU7Yn
 6PNDWOIqCNTOljZgpJEBe79R82cRCipOG+UrUm7Gj3IFYzhIq4HV6Z8Jjdn1UMhNN4hUZyUOfvj
 TqfnLCbqcpCqlX2dRBf4fQzMcEmA1RbnxhBwFX6jM3avCFkpEg+Bt6vkTiFOg9YUAlUqy2woQp5
 n7Ta4MH3aTGys1g==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the wpan_phy_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 net/ieee802154/sysfs.c | 2 +-
 net/ieee802154/sysfs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ieee802154/sysfs.c b/net/ieee802154/sysfs.c
index d2903933805c..6708160ebf9f 100644
--- a/net/ieee802154/sysfs.c
+++ b/net/ieee802154/sysfs.c
@@ -93,7 +93,7 @@ static SIMPLE_DEV_PM_OPS(wpan_phy_pm_ops, wpan_phy_suspend, wpan_phy_resume);
 #define WPAN_PHY_PM_OPS NULL
 #endif
 
-struct class wpan_phy_class = {
+const struct class wpan_phy_class = {
 	.name = "ieee802154",
 	.dev_release = wpan_phy_release,
 	.dev_groups = pmib_groups,
diff --git a/net/ieee802154/sysfs.h b/net/ieee802154/sysfs.h
index 337545b639e9..69961e166257 100644
--- a/net/ieee802154/sysfs.h
+++ b/net/ieee802154/sysfs.h
@@ -5,6 +5,6 @@
 int wpan_phy_sysfs_init(void);
 void wpan_phy_sysfs_exit(void);
 
-extern struct class wpan_phy_class;
+extern const struct class wpan_phy_class;
 
 #endif /* __IEEE802154_SYSFS_H */

---
base-commit: 42683294cc0a9ba010de5d978fd23fd1e778b192
change-id: 20240305-class_cleanup-wpan-f299173274b0

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


