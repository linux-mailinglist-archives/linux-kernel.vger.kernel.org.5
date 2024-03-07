Return-Path: <linux-kernel+bounces-95257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC67874B5E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD4E1C21676
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752A385295;
	Thu,  7 Mar 2024 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dM+7awZx"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48FB42047
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805250; cv=none; b=DjV4js2Dr/e7CuPoiDyK9TKdzD+2+D7IBpMQ8yAoZcCJ0VUt3cW/Q4fVvcxm9JOmD0I5wfkcERgIuGYfHFJDkIC9icUbomhZbfDflZKxhWmCwwk1ERkPxqYJYQyB5xq5CnfAlG2u2a9b7soLlFUDXmJC0A+Lbi+MlOAMJSg78Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805250; c=relaxed/simple;
	bh=MCTAdOE5qQKLVvKWiaFrEiQ/HXb5XPaLK7RVUm9LgIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SVD+oVHfNCBAa9Gbq8A16cXtQrMVQO62ZAcZg4562Q+By/9EMVbdMYcvNsEC7o8dL2aahXVH7nVjuTlk2ZDkOLjMt0Qnlsrq0II3IS0D2FqR6QMjOFnOETIR6QKHB5lqg/+mQ77hScO3Difc3UleqrRZJOUViOFBow4+4pbjp7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dM+7awZx; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5673b5a356eso744441a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 01:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709805247; x=1710410047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I3DIVgIQtbxBFgHYdrkm8qDZTG2wrsK4cDuPuZWRLf8=;
        b=dM+7awZx44+0OKPpluuHCa5f2RfPTAqrZRnioUA1llxg8CURJU4vKFtnympygfeUBn
         tMTrWNIIupC42PcowvpNKnXZ9il1ukFo5Z7TSCRu/67dsk/S1q2g6EeNVOIpNQ3EwYzZ
         NgN0TGE/t4e0gRwbP0XxSAI7BJ1McM4QG86iw4N7pcjM3YjIhpDQJ+/mLOy5/pKmbsuz
         2dfDJRdddpAwO5kSG5hwszel+fjfkQieSApgpIM0mZfOzeVSYVLk/ed8nhT+iVEToA8n
         0w/GzKAFbeEr0Eaem6EuLiebszScUmX2OI2ZLeKPc0dXOX3clHHG06YXy3Wl+lgE2q+K
         VbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709805247; x=1710410047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3DIVgIQtbxBFgHYdrkm8qDZTG2wrsK4cDuPuZWRLf8=;
        b=WOJJHKv0/X6o72PLPagjkdFDKbnKLSoqvNvfgycoa8nzjlyxRd9Hwbq+8tUUQ6/LxX
         32F7CbuVUFFYq8lPrhMDcxBsgei0rPSqPnERFBsx68e9EhQ+X8Vb/jkQtyn7+hgIBt85
         ILkWbg1EjmTtmJyRl+zKgk0xn/yMAgxUckGGXKuJ2+gyXSD7/FPLUgevpysV3VXavSzP
         HmcESUyHp1oz/1444wBxxy8Uw7ml90YZqbDv7/soFmU/b7uTVOXc5VPWJUgH5RxTNgWa
         1s4UzE9buhJHQmVY0sqzhta9KZ0PVh5blOvOjrsVOFqoPHYJKk+Z1GVsNHlbyLVJaq0i
         J3wg==
X-Forwarded-Encrypted: i=1; AJvYcCW8orklfvI3dCcjLTVFrxCwxXzkP2+fgPz4w0szSgT32UX3FnbOxD44Ul7Fa1pKaMW4z9VNClQLKMrmTfEg149A3KUw0sKdWOFdYE7a
X-Gm-Message-State: AOJu0YwzfdnzKgiPObbI6vrDZdK9L327mVyQpKbMb46bFLS1EaJS2bMT
	9R2/wPApq6mnhjRRsrv9GVDThBxloORuI1otnINYqO1uPqt3jXOe
X-Google-Smtp-Source: AGHT+IFDJOZS/zcttQ6vcsVUUH0Zmr5rEjPzF+lqN6Lwja3v7FlWo2VmnQhf4hz0lp0IoV7IsGnq4w==
X-Received: by 2002:a05:6402:1d8f:b0:566:ac71:97c5 with SMTP id dk15-20020a0564021d8f00b00566ac7197c5mr10655634edb.18.1709805246915;
        Thu, 07 Mar 2024 01:54:06 -0800 (PST)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id d17-20020a056402517100b005671100145dsm5686202ede.55.2024.03.07.01.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:54:06 -0800 (PST)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: rick.wertenbroek@heig-vd.ch
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] phy: rockchip: Fix typo in function names
Date: Thu,  7 Mar 2024 10:53:18 +0100
Message-Id: <20240307095318.3651498-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several functions had "rochchip" instead of "rockchip" in their name.
Replace "rochchip" by "rockchip".

Signed-off-By: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c |  4 ++--
 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c     | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 76b9cf417591..35d5c18661a3 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -245,7 +245,7 @@ static int rockchip_combphy_exit(struct phy *phy)
 	return 0;
 }
 
-static const struct phy_ops rochchip_combphy_ops = {
+static const struct phy_ops rockchip_combphy_ops = {
 	.init = rockchip_combphy_init,
 	.exit = rockchip_combphy_exit,
 	.owner = THIS_MODULE,
@@ -352,7 +352,7 @@ static int rockchip_combphy_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	priv->phy = devm_phy_create(dev, NULL, &rochchip_combphy_ops);
+	priv->phy = devm_phy_create(dev, NULL, &rockchip_combphy_ops);
 	if (IS_ERR(priv->phy)) {
 		dev_err(dev, "failed to create combphy\n");
 		return PTR_ERR(priv->phy);
diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
index 121e5961ce11..3cdc7625b308 100644
--- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
+++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
@@ -187,7 +187,7 @@ static const struct rockchip_p3phy_ops rk3588_ops = {
 	.phy_init = rockchip_p3phy_rk3588_init,
 };
 
-static int rochchip_p3phy_init(struct phy *phy)
+static int rockchip_p3phy_init(struct phy *phy)
 {
 	struct rockchip_p3phy_priv *priv = phy_get_drvdata(phy);
 	int ret;
@@ -210,7 +210,7 @@ static int rochchip_p3phy_init(struct phy *phy)
 	return ret;
 }
 
-static int rochchip_p3phy_exit(struct phy *phy)
+static int rockchip_p3phy_exit(struct phy *phy)
 {
 	struct rockchip_p3phy_priv *priv = phy_get_drvdata(phy);
 
@@ -219,9 +219,9 @@ static int rochchip_p3phy_exit(struct phy *phy)
 	return 0;
 }
 
-static const struct phy_ops rochchip_p3phy_ops = {
-	.init = rochchip_p3phy_init,
-	.exit = rochchip_p3phy_exit,
+static const struct phy_ops rockchip_p3phy_ops = {
+	.init = rockchip_p3phy_init,
+	.exit = rockchip_p3phy_exit,
 	.set_mode = rockchip_p3phy_set_mode,
 	.owner = THIS_MODULE,
 };
@@ -280,7 +280,7 @@ static int rockchip_p3phy_probe(struct platform_device *pdev)
 		return priv->num_lanes;
 	}
 
-	priv->phy = devm_phy_create(dev, NULL, &rochchip_p3phy_ops);
+	priv->phy = devm_phy_create(dev, NULL, &rockchip_p3phy_ops);
 	if (IS_ERR(priv->phy)) {
 		dev_err(dev, "failed to create combphy\n");
 		return PTR_ERR(priv->phy);
-- 
2.25.1


