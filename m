Return-Path: <linux-kernel+bounces-162713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A46B8B5F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A49283749
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2708126F08;
	Mon, 29 Apr 2024 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="kdZxOEY4"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BB586136;
	Mon, 29 Apr 2024 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714409662; cv=none; b=bCtyjeLYhC96Q4luS8UMd5edDsVLjPfZc3++jPy+R4Eom0LO+VCM9x5trzwt/t/crva/Ub84UNi6mEGQD96FuqJCO23uM0UjCbP/koIZ332JDHXynZa9OfcpVexM705bH4QUw7VmSFceZxyhPUTREurYloJOhJ/iENnGoszDuq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714409662; c=relaxed/simple;
	bh=1cY9CF5Pxn/f+iiJlu9BrbQu3wy8IFak5Fd0SvXjG+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h5wK+lCS6LPHCpTidvoQFsv095e1hk+qtOK3Ltrwk5TbnXCCCgpqZKX5tX0OwBkYe8LXQpIMv3nf7n9EDD1fsbkCivFL5V/9PV8/TGXvbF9I4UHfYOWxEF18jNVMx4gLicspwRS89qjK9I4ktPLaGRjjmqOLyLXYZpQcDsx94sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=kdZxOEY4; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 48DFAC0000E8;
	Mon, 29 Apr 2024 09:54:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 48DFAC0000E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1714409652;
	bh=1cY9CF5Pxn/f+iiJlu9BrbQu3wy8IFak5Fd0SvXjG+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kdZxOEY4uYBrpxrmWDwwg/XQvixUhkhSanXXTM2C1F+am8ZirnmLbxjUOr31p8490
	 Lvh8dHajpbReBZ6I4yiJWDDKgmkjL+S1Vw24W0lVBjqtsyr6ggi5PRfFwzGUOJxG24
	 Sc8FjqZ6n+rlxfInpvZ5I3BC+8AzX++zX/sKfIng=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 5F2BC18041CAC6;
	Mon, 29 Apr 2024 09:54:10 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/2] net: dsa: Remove fixed_link_update member
Date: Mon, 29 Apr 2024 09:54:04 -0700
Message-Id: <20240429165405.2298962-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429165405.2298962-1-florian.fainelli@broadcom.com>
References: <20240429165405.2298962-1-florian.fainelli@broadcom.com>
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


