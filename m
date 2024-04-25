Return-Path: <linux-kernel+bounces-159309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3545B8B2CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CE51C218D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22199181BB7;
	Thu, 25 Apr 2024 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWgAaHoe"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78DF181BAA;
	Thu, 25 Apr 2024 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082847; cv=none; b=RYe1jNPkZhr0V08cTvn0wzW9gUQtJGrcQBjo8Hu+qOwFpLHS+8ATNvOHazR3dzML72mx1B9jfr0ROhlu6deRj2xNtQUyYLMnM/r2kVdN8mIEWdPRPKmTtDoE0DNwV38XLYIVEoCPaMvVsuVhPqWSmHLvqRiuummHvkUOq3ur878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082847; c=relaxed/simple;
	bh=1SF70NTHCTRYZByoZHjPlVMIlx5+KlolbViI5fbMAFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fcIzSJQVSlmSgG2HNU689oHVVFwTFWoIpR8nZqFC/SM/urlp+EKpR0ZdG4P6FLbABmurC8+61q5LYijq02MOIFHmr+QYCh7iRS2qvImzT2IurO5xHoyNGAlSyOVVkgIOs0iPAG4HNK1Y8+ltZHlEcAMuETfPM0q9pnRvzwdoeQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWgAaHoe; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78ebc7e1586so253708385a.1;
        Thu, 25 Apr 2024 15:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714082845; x=1714687645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o13Arm3Rvf2gFBkSt1a4X4Ztws3UYrTbZey0ecJRfQk=;
        b=aWgAaHoebYKrJJtwJGNR8OseIiNKLeS8As7AO1O3ck7AT7D1PAA9pt/5sk+WPmHCeo
         T1np7nK6QfQCiyiWwNHWKqV2aTVtjEGch1vGnX9Vod1VZvaDFANPKCNSS84DAti3zPlk
         U524QNpeABWlNgFIGRd/BGvF86f6W4fXgLoQCh49IWeHzKRI8f0IbyX4vCpopGUNZ9SI
         a/f4BoXCCDkyNPuRtLL9Ly/cyStqM0ULqgyha7gHLxqG0Rz96iRPd6d+BVZyNKSeRCsy
         fzh8stSCcTClb0cD7/SD/93tI2kRsL+OoViU9X/3Q/QZRiP6n4SLaxw/mz86cvN/J55W
         HMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714082845; x=1714687645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o13Arm3Rvf2gFBkSt1a4X4Ztws3UYrTbZey0ecJRfQk=;
        b=V61uZ5kA0C5hvNHBPJEzg14LNEpm6/iUbg3eg0tRNzWPyUYhoTwlqXM6Y5qvkdVC5B
         uVtyc4CRWeUMI7j3ISmoyedSwZOtn8cihe+rZhW3qX+tdubomDzeLGyycSxNLfW1+3Dl
         ZgBkB3IRzzo6TsBwwr9RV5y9wZrsDfaUWxr3NBt2mKHXRj79RgWKlzEmexn++U8B0tOn
         Mmm3q95p7se9Lx9plSdDSZg8ddlzRQjAnCrswOFP140o8CLmW1VMnduIrOGkQENbdb2y
         sUSh/2z0UntGZtVQjTrorh/Rn/5kzX7B6f1TdEEgDlzibaE1GfO/RsC585L6clkzawro
         Hi6w==
X-Forwarded-Encrypted: i=1; AJvYcCXlOHPEV4wGQOiEu+XYNASLgGiZmluYuFaHV1qPO2xwLM7EWxS58JLH7wE6rwe+PhsPm1oHb9/SpPOI6RgZerXOp0iU1+Ynea6NfF+2HmlxrQqxBaIeOTxbDxG5XsmQrOSpSxLI
X-Gm-Message-State: AOJu0YxvypzBTAqMp6LtAnignvE2BwmZYaI8WT57dhjl2C/i/L4hbglT
	iOaw4/7cuIYijBaIpdKClL4LsTPZOWHTwjf4HagFp5ZKPbKCsN75
X-Google-Smtp-Source: AGHT+IEb3tH4zRjlqCsGO2g1hapDLeFj3TNbvP15N+hZRE3y0OUF1M5cOm0vomLmYYrjn/g4e+xsGg==
X-Received: by 2002:a05:6214:250d:b0:69f:3c1d:201 with SMTP id gf13-20020a056214250d00b0069f3c1d0201mr7242034qvb.16.1714082844800;
        Thu, 25 Apr 2024 15:07:24 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q2-20020a0c9a42000000b006a044503615sm4692891qvd.72.2024.04.25.15.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:07:23 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.or,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
Date: Thu, 25 Apr 2024 15:06:48 -0700
Message-Id: <20240425220650.2138801-2-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425220650.2138801-1-opendmb@gmail.com>
References: <20240425220650.2138801-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EXT_RGMII_OOB_CTRL register can be written from different
contexts. It is predominantly written from the adjust_link
handler which is synchronized by the phydev->lock, but can
also be written from a different context when configuring the
mii in bcmgenet_mii_config().

The chances of contention are quite low, but it is conceivable
that adjust_link could occur during resume when WoL is enabled
so use the phydev->lock synchronizer in bcmgenet_mii_config()
to be sure.

Fixes: afe3f907d20f ("net: bcmgenet: power on MII block for all MII modes")
Cc: stable@vger.kernel.org
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 9ada89355747..86a4aa72b3d4 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -2,7 +2,7 @@
 /*
  * Broadcom GENET MDIO routines
  *
- * Copyright (c) 2014-2017 Broadcom
+ * Copyright (c) 2014-2024 Broadcom
  */
 
 #include <linux/acpi.h>
@@ -275,6 +275,7 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 	 * block for the interface to work, unconditionally clear the
 	 * Out-of-band disable since we do not need it.
 	 */
+	mutex_lock(&phydev->lock);
 	reg = bcmgenet_ext_readl(priv, EXT_RGMII_OOB_CTRL);
 	reg &= ~OOB_DISABLE;
 	if (priv->ext_phy) {
@@ -286,6 +287,7 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 			reg |= RGMII_MODE_EN;
 	}
 	bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
+	mutex_unlock(&phydev->lock);
 
 	if (init)
 		dev_info(kdev, "configuring instance for %s\n", phy_name);
-- 
2.34.1


