Return-Path: <linux-kernel+bounces-162711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB348B5F67
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9C72823C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754098627D;
	Mon, 29 Apr 2024 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aR8IZmw8"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BF88613E;
	Mon, 29 Apr 2024 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714409660; cv=none; b=Clge0UMdZVMOxTFJgF6EjbIciXcw28lVEsJnYdDX5/QJuCIcVC7W6t3P1p9FAU9htOr+0NNweV+ynXsehnacQhgzysBNum0kvM/aIhQWfmXKRk6eh7ZJPimbhCapTjL8avAgKkd3eGrSnG+FqU5Kw8RLbwiACJxRA+c5AZJv7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714409660; c=relaxed/simple;
	bh=m+a0mpd9lPCvf7rECTwJNwAyUY/aioHvQrkAhuahk7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GphrjEWmPhcClEclA+sXuRWtxthfulvoXFqxzW2F7evUQXgCRLrUj9t4uWSODd3wjWKo7wtHzJ+6BiIRgXAp7XGlPBZr79mdRdOTewwTRTy3oYVwBgmhi/kl5s8/il9iZfB24HIRmHKt0EO5Cz0yejDyTKEPUuAXSuqdX52q2yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aR8IZmw8; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1F4ECC0000E7;
	Mon, 29 Apr 2024 09:54:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1F4ECC0000E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1714409652;
	bh=m+a0mpd9lPCvf7rECTwJNwAyUY/aioHvQrkAhuahk7c=;
	h=From:To:Cc:Subject:Date:From;
	b=aR8IZmw8AueI1Pf30pWHZiYSPYjF3df3uyCgMZJJg0+ckeR1ICbBaZsXseg4GQ38n
	 XQYL1UfzR4B/jA0iS0HyTF1wgqrHAXwr3ZagwhCrglkSCmODtvXBYnt1COqIkRoKW9
	 ZVAJ1dI4q09Ol/XAsSBufK+LIfE72i4Y9Lft1P5w=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 2C56818041CAC4;
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
Subject: [PATCH net-next v2 0/2] net: dsa: adjust_link removal
Date: Mon, 29 Apr 2024 09:54:03 -0700
Message-Id: <20240429165405.2298962-1-florian.fainelli@broadcom.com>
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

Changes in v2:

- remove a now unused phy_device pointer in
  dsa_port_phylink_mac_link_down

Florian Fainelli (2):
  net: dsa: Remove fixed_link_update member
  net: dsa: Remove adjust_link paths

 include/net/dsa.h |  11 ----
 net/dsa/dsa.c     |   3 +-
 net/dsa/port.c    | 136 ++++------------------------------------------
 3 files changed, 12 insertions(+), 138 deletions(-)

-- 
2.34.1


