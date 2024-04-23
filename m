Return-Path: <linux-kernel+bounces-155749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 112688AF6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D081C22D16
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECD013FD75;
	Tue, 23 Apr 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DHJsIUgs"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990592230F;
	Tue, 23 Apr 2024 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897228; cv=none; b=FferU4kJQ6lRcC/i4skpAwqqY2ow9wq/UFm9w6A7uGGA45QAIMSqEvN9rF1s/X1n34bf6qqjanlk7YF35nB4APmOHrO4bAgeulsJDnvQVHMuS1kM3XKWVmiE3iAtSEBpntBSdQEfXMe1rUxhtJwWWRDcCXztE9fLBCr+5shA44s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897228; c=relaxed/simple;
	bh=PoVxr6mN/QScs8qWuW3NkJNxsWMJn5z2pce3x1YhnZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aGdl90VQc+WxfH0XjzjH0a0/+WOESfjJABLU/L3m1Zp4TAVVkTAFRUQMF+iw99vo1K1KO+o3kOSZNXeq33NRslCuQ59PiWk8kYPF7bYEJ7VHkfZ2udMuYYrlTncQB9c3qLKDCJhkWwCPYzTn0ugKJjUUUKBr+6iNeuWlNJtYU5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DHJsIUgs; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id C90A7C002802;
	Tue, 23 Apr 2024 11:33:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com C90A7C002802
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1713897220;
	bh=PoVxr6mN/QScs8qWuW3NkJNxsWMJn5z2pce3x1YhnZU=;
	h=From:To:Cc:Subject:Date:From;
	b=DHJsIUgsQT5z8fnCxxtcH5dbq7vKknMhZUqSVa2woUkEa7fjt0rvYrDIU5n/6eB3K
	 jISb9expmCKeHN1ejJIAlyJpt8GJCAga6mQtOK4tzE0cY+J4ZsqxQxfmqvP6BvW7u/
	 IMyt794lqEeGDosDnpZWdoP0IVLjTp2rH/94wbZE=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id E047F18041CAC4;
	Tue, 23 Apr 2024 11:33:38 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 0/8] net: dsa: b53: Remove adjust_link
Date: Tue, 23 Apr 2024 11:33:31 -0700
Message-Id: <20240423183339.1368511-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

b53 is now the only remaining driver that uses both PHYLIB's adjust_link
and PHYLINK's mac_ops callbacks, convert entirely to PHYLINK.

Florian Fainelli (8):
  net: dsa: b53: Stop exporting b53_phylink_* routines
  net: dsa: b53: Introduce b53_adjust_531x5_rgmii()
  net: dsa: b53: Introduce b53_adjust_5325_mii()
  net: dsa: b53: Force flow control for BCM5301X CPU port(s)
  net: dsa: b53: Configure RGMII for 531x5 and MII for 5325
  net: dsa: b53: Call b53_eee_init() from b53_mac_link_up()
  net: dsa: b53: Remove b53_adjust_link()
  net: dsa: b53: provide own phylink MAC operations

 drivers/net/dsa/b53/b53_common.c | 208 ++++++++++++++++---------------
 drivers/net/dsa/b53/b53_priv.h   |  12 --
 2 files changed, 105 insertions(+), 115 deletions(-)

-- 
2.34.1


