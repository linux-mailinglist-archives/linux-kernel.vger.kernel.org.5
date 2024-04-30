Return-Path: <linux-kernel+bounces-164422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7206A8B7D73
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F9F1C23620
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7641802AB;
	Tue, 30 Apr 2024 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fz9OwFXc"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DF9176FA8;
	Tue, 30 Apr 2024 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495709; cv=none; b=Q5gxKOlpHuwNvEOnsO66aI068r5yDnBwKHAUrOo3PlbjV5qnIoAl01pmIZfp5DrD2tiPFTiJAw4EBk49rekNR6SdyiaXOqMuO3ezpMxdSKSjaOEaHKSBIf5BitrGgc005/s9H9uJRKiiuGFSYLthwCK8Ue1XNAA5gevyhZRm4Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495709; c=relaxed/simple;
	bh=1cY9CF5Pxn/f+iiJlu9BrbQu3wy8IFak5Fd0SvXjG+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CxZbPLjsZrRd/Bp4tWmhmyPd7y8+7lTmEBFa6ukXy2ch+QGWQhtUV2SWRtdIMOaV5OYWREusLVGYkwdwGNiqeyJWFPyWiPWvG2YpOgL5ybNWyGz6zD17V+7L8JXZzm/XbsCOllxfd8l9S2DJQuvDFm/kcAUKZU6dBGSR9aDWD0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fz9OwFXc; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id AA676C0000EA;
	Tue, 30 Apr 2024 09:48:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com AA676C0000EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1714495704;
	bh=1cY9CF5Pxn/f+iiJlu9BrbQu3wy8IFak5Fd0SvXjG+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fz9OwFXcHe26UTwdZymiz8C/hBIHx7M17yxC2X9MATkocMHN/Rbezo25iFhCvVtKr
	 V0SavK0k2Fqy5A3DL58gH71ec4Dpk0grlCmt24oHzGCFZ26p+MqhTxtcYlK1C6kgyG
	 TMUb24XDGWLfizszh3rKD2+9+ogz2XEiK033QR+8=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id C18EC18041CAC6;
	Tue, 30 Apr 2024 09:48:22 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 1/2] net: dsa: Remove fixed_link_update member
Date: Tue, 30 Apr 2024 09:48:15 -0700
Message-Id: <20240430164816.2400606-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164816.2400606-1-florian.fainelli@broadcom.com>
References: <20240430164816.2400606-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have not had a switch driver use a fixed_link_update callback since
58d56fcc3964f9be0a9ca42fd126bcd9dc7afc90 ("net: dsa: bcm_sf2: Get rid of
PHYLIB functions") remove this callback.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 include/net/dsa.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index a6ef7e4c503f..678f1fd8b189 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -25,7 +25,6 @@
 struct dsa_8021q_context;
 struct tc_action;
 struct phy_device;
-struct fixed_phy_status;
 struct phylink_link_state;
 
 #define DSA_TAG_PROTO_NONE_VALUE		0
@@ -873,9 +872,6 @@ struct dsa_switch_ops {
 	 */
 	void	(*adjust_link)(struct dsa_switch *ds, int port,
 				struct phy_device *phydev);
-	void	(*fixed_link_update)(struct dsa_switch *ds, int port,
-				struct fixed_phy_status *st);
-
 	/*
 	 * PHYLINK integration
 	 */
-- 
2.34.1


