Return-Path: <linux-kernel+bounces-69192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECE3858591
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD341284B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF17135A67;
	Fri, 16 Feb 2024 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JWlLMDNU"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C31350FB;
	Fri, 16 Feb 2024 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108972; cv=none; b=GNdhAIHrb759bNvN09MZdOwfixYdAjJq2nnk34InBJrQeoAsbo5zVqytFJnKREkAxeEEHJt07Kv1lv77buLCxIXDSJnFX9NdNCCVeBj6Iv6TS4yvWgDBXcFiqJYCe5xYtl+4gZpR3yqe/V/fcbH8chaxXgj+r/z5Qlmq/xOp+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108972; c=relaxed/simple;
	bh=i9k3K96piVEikMIz1+hmpkE1mIU1mvLihqfUZnhngpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bvk7fqj2erGx6IL/mTH3jrZ8osXEgW/S0Vc7e0SjTpbSE/pT9XNTfqn3bk50pmsYnuqm+yNSchGDKVWnndOF5V0ruO2onRHbuQbQE2KsIdXKDt2SDlqSK67c7POmxa8lK9c9AnL1Q8di29jbqjokPSam5FFqar+hIvkVDubM72o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JWlLMDNU; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 41628C001645;
	Fri, 16 Feb 2024 10:42:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 41628C001645
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1708108964;
	bh=i9k3K96piVEikMIz1+hmpkE1mIU1mvLihqfUZnhngpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWlLMDNUIQVlrb/EVKF/dk8fEIJvopreIsxpUCoO7nxUIkrJ6gOGCuE8aKTcHRE9a
	 6qD1F2aN7+hE+zbbxuacaz45WZG4SPfUHVrK9wSeLZoOct7ymlGge+lFetseCtfQQc
	 LNY38g7VwzgZv38I7IgGL5TvBdaIXwGDvVaGUX+Y=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id AB8CA18041CAC7;
	Fri, 16 Feb 2024 10:42:42 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list),
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next 2/3] net: bcmgenet: Pass "main" clock down to the MDIO driver
Date: Fri, 16 Feb 2024 10:42:36 -0800
Message-Id: <20240216184237.259954-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216184237.259954-1-florian.fainelli@broadcom.com>
References: <20240216184237.259954-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENET has historically had to create a MDIO platform device for its
controller and pass some auxiliary data to it, like a MDIO completion
callback. Now we also pass the "main" clock to allow for the MDIO bus
controller to manage that clock adequately around I/O accesses.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index cbbe004621bc..7a21950da77c 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -476,6 +476,10 @@ static int bcmgenet_mii_register(struct bcmgenet_priv *priv)
 	ppd.wait_func = bcmgenet_mii_wait;
 	ppd.wait_func_data = priv;
 	ppd.bus_name = "bcmgenet MII bus";
+	/* Pass a reference to our "main" clock which is used for MDIO
+	 * transfers
+	 */
+	ppd.clk = priv->clk;
 
 	/* Unimac MDIO bus controller starts at UniMAC offset + MDIO_CMD
 	 * and is 2 * 32-bits word long, 8 bytes total.
-- 
2.34.1


