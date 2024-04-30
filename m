Return-Path: <linux-kernel+bounces-164421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EEC8B7D70
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7975D1C23491
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939B817B51C;
	Tue, 30 Apr 2024 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DmmhP072"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DBB173351;
	Tue, 30 Apr 2024 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495707; cv=none; b=EKljh9EOt6SM7fxURAXazr6i+VS6ky6U2sDxvFbUu/ktznAoTJkNGjWR24Qk1P9WYeL3t9iAL5olXKqMWZnJIT5ESAsYJXB3V+ykTbP706Iqr2BWxuRYzDlOZ3esfX/B83cDYxTcAko4cJE6pV1x68UhHyHPymoncP6rcL80kZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495707; c=relaxed/simple;
	bh=5W9Inn1KYFdL7ebyOXY7xzYoXMJTpvXH1GOhmapT3mM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DQiVS+7fATe8jGh101bjdY3owoFNB4T3XyauX+XIQg19XZcLWumEC/T1c9wzpGIAPmVvA99OMvSPu/jwBH8asKZz3IUTZMbaTt/8giN4pABoSiNKEbzT7EmLjJ7hhvJxZNeYOJ5/HUPsh5RVT05AUCHgUWv65lhaQiyVMqvUzZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DmmhP072; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 7771BC0000E8;
	Tue, 30 Apr 2024 09:48:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 7771BC0000E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1714495704;
	bh=5W9Inn1KYFdL7ebyOXY7xzYoXMJTpvXH1GOhmapT3mM=;
	h=From:To:Cc:Subject:Date:From;
	b=DmmhP072Xf0Q6w4zIlffZdLCiugMTG+nSodI3KrBkDNpaqBvas/Viod5aPl+PAeDR
	 X2otUzbfAk45gn639Md9qmnhIPmBnz+WSS5Ef/FS7lszKFBE1WDEZP62wVFfJMyJn2
	 I9pzpSXUZBQz8a1XA7J6FPyKzhlm4+yp6qzN7XRY=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 8D16F18041CAC4;
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
Subject: [PATCH net-next v3 0/2] net: dsa: adjust_link removal
Date: Tue, 30 Apr 2024 09:48:14 -0700
Message-Id: <20240430164816.2400606-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the last in-tree driver (b53) has been converted to PHYLINK, we
can get rid of all of code that catered to working with drivers
implementing only PHYLIB's adjust_link callback.

Changes in v3:

- removed additional code in dsa_port_phylink_mac_link_down pertaining
  to the phy_device reference

Changes in v2:

- remove a now unused phy_device pointer in
  dsa_port_phylink_mac_link_down

Florian Fainelli (2):
  net: dsa: Remove fixed_link_update member
  net: dsa: Remove adjust_link paths

 include/net/dsa.h |  11 ----
 net/dsa/dsa.c     |   3 +-
 net/dsa/port.c    | 139 ++++------------------------------------------
 3 files changed, 12 insertions(+), 141 deletions(-)

-- 
2.34.1


