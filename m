Return-Path: <linux-kernel+bounces-159035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 279F88B287D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52342B235BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC89152172;
	Thu, 25 Apr 2024 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="mWf5RM7H"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119CD12C7FF;
	Thu, 25 Apr 2024 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071221; cv=none; b=kZI4MbCIzOD6hJN+UqIV75MutTn4aN+c5rFjTygERdzR/st9mtiB2BdTxfnLxE1rGy1ZnF1XLVk9oRE617+lvheUnnUkM1yPv+N1jkE7lWjmYyvgh80ogGQALFn1mjDxVz74ya5nxU7C5i2EpHJUMp4IuitWkwEvsvNMApDgEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071221; c=relaxed/simple;
	bh=i229HuGnK6rnO0c8XB389KhSn7gIi9EvW1umOfM9bsw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tFonw9/Mi3uY9UeT0yYNnd+3GGEY9sTFqQXrXydEiT080vwfWLNr+bQK/HhRb19ra2oXllMakFZR+fu3GKa4h/8VNCngY36+LevJfG/I70ByR2+Og/Ph6zVtirfq0nQVx0oheSPgRHwKHLpmCGZYLM1ESbPY65XhiUzav6Np8UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=mWf5RM7H; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id E5F72C0005E7;
	Thu, 25 Apr 2024 11:53:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E5F72C0005E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1714071218;
	bh=i229HuGnK6rnO0c8XB389KhSn7gIi9EvW1umOfM9bsw=;
	h=From:To:Cc:Subject:Date:From;
	b=mWf5RM7HHqlww6PpMnfpHP2vCzipEdxptglTp4J9T74DTOu1T4J8Aq9CRsx53JCsE
	 L+33QUdWJ4tq1XCTCbcZfHqQ0S7GOT34CCQSMO4L2Aq+TCzWNJMo/FZwZY9mlt0CjR
	 BynAWffPdjePFdXCdMUTmZMEHkhVg8PEwZ/Nes9o=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id ECCB218041CAC4;
	Thu, 25 Apr 2024 11:53:35 -0700 (PDT)
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
Subject: [PATCH net-next 0/2] net: dsa: adjust_link removal
Date: Thu, 25 Apr 2024 11:53:34 -0700
Message-Id: <20240425185336.2084871-1-florian.fainelli@broadcom.com>
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

Florian Fainelli (2):
  net: dsa: Remove fixed_link_update member
  net: dsa: Remove adjust_link paths

 include/net/dsa.h |  11 ----
 net/dsa/dsa.c     |   3 +-
 net/dsa/port.c    | 135 ++++------------------------------------------
 3 files changed, 12 insertions(+), 137 deletions(-)

-- 
2.34.1


