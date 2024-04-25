Return-Path: <linux-kernel+bounces-159034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 076948B287B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323CB1C20F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E9D1514DE;
	Thu, 25 Apr 2024 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="wGO2Ef7h"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEC51514C2;
	Thu, 25 Apr 2024 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071220; cv=none; b=HW/7My0VEQWuSUcEtj0A19QtNZsyZfoscVKBbynR1XwOjr+k9NKsAyScD5h7ISR4z7JAW1I6sOxXjSMrf+zwSMFYls1x1X6nxze5iysIwN6pPYq6xG+HNdOfA7e+KYQgqUzsYJWc7MG/vVX4r1m/xpnuCzbwbACQemePIAR1adI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071220; c=relaxed/simple;
	bh=1cY9CF5Pxn/f+iiJlu9BrbQu3wy8IFak5Fd0SvXjG+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UohFVvloU/ctP0tBD9UuEfy5pACkzp7J293kdtPVC1X5rB7N0fqhUeXUMOVDZ/Q3ESwCYv4osY/0CSwgSVCFzHEdZijUAOpzC6aZpYbzRLbh/jmIirLnkyaeZeurB3qQ9v+b+QpOLUKIjZ0d2BuuZHnTfY5BPiPtD/GgKLORyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=wGO2Ef7h; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 16F1CC0005CE;
	Thu, 25 Apr 2024 11:53:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 16F1CC0005CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1714071218;
	bh=1cY9CF5Pxn/f+iiJlu9BrbQu3wy8IFak5Fd0SvXjG+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wGO2Ef7h98trB6uCbZfj45YbQX3X88Ge5o6km5zR1sq2vYXQb5cWnvOlnboAo63ig
	 XR0mXuTQaIl1euXQ1WsOnL6lMNl5fQHj7UhDL/4rPcQxHUot+zDKLlMS8NHCnjHupy
	 53Enq6pJgJN7MFfHq/a++Gwijm/7EzzqLInh0qk8=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 2C51518041CAC6;
	Thu, 25 Apr 2024 11:53:36 -0700 (PDT)
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
Subject: [PATCH net-next 1/2] net: dsa: Remove fixed_link_update member
Date: Thu, 25 Apr 2024 11:53:35 -0700
Message-Id: <20240425185336.2084871-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425185336.2084871-1-florian.fainelli@broadcom.com>
References: <20240425185336.2084871-1-florian.fainelli@broadcom.com>
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


