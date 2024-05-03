Return-Path: <linux-kernel+bounces-167675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 327FA8BAD55
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637511C21AC8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887A7154BE9;
	Fri,  3 May 2024 13:14:13 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A440B153596
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742051; cv=none; b=Lu6mrXDdl9d1Lg6Gqhh2r57pvya+FRy0UFBWMF5oJaqohiRkChi5xGBzbfnfnkU4AcamPGSQweW1eWV0XwFmPCmDMf3fFDEosVsDEbjDjx4aPL0qYWx92LfgZXwBINUJd3cor4TeMGnZu12IGb+0t9yVGGxcptzumlxLzWVclWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742051; c=relaxed/simple;
	bh=9bR9Vm6RUVcJpBA8j9isuCblWYh00RBSvynzMOoXVFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gg+l0IZ6EiJGFvy0IADLtr0QxQub9raISFF5xNkHxzhi4GUrKfm8/43kBvWrggBiksVSrq4oXU2rygxxIYHFhchj7z+FlXmLKcUtULXr8A4zoc1CoTBANnIhymtMjrVyE9e3Tr//hwBVmzMooNOrEGzkmeUqnieFmkFP3p3x7XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjb-0006EE-6j; Fri, 03 May 2024 15:13:55 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjZ-00FiK6-KW; Fri, 03 May 2024 15:13:53 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s2sjZ-008GGK-1m;
	Fri, 03 May 2024 15:13:53 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v7 00/12] add DCB and DSCP support for KSZ switches 
Date: Fri,  3 May 2024 15:13:39 +0200
Message-Id: <20240503131351.1969097-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This patch series is aimed at improving support for DCB (Data Center
Bridging) and DSCP (Differentiated Services Code Point) on KSZ switches.

The main goal is to introduce global DSCP and PCP (Priority Code Point)
mapping support, addressing the limitation of KSZ switches not having
per-port DSCP priority mapping. This involves extending the DSA
framework with new callbacks for managing trust settings for global DSCP
and PCP maps. Additionally, we introduce IEEE 802.1q helpers for default
configurations, benefiting other drivers too.

Change logs are in separate patches.

Compared to v6 this series includes some new patches for DSCP global
mapping support and QoS selftest script for KSZ9477 switches.

Oleksij Rempel (12):
  net: dsa: add support for DCB get/set apptrust configuration
  net: dsa: microchip: add IPV information support
  net: add IEEE 802.1q specific helpers
  net: dsa: microchip: add multi queue support for KSZ88X3 variants
  net: dsa: microchip: add support for different DCB app configurations
  net: dsa: microchip: dcb: add special handling for KSZ88X3 family
  net: dsa: microchip: enable ETS support for KSZ989X variants
  net: dsa: microchip: init predictable IPV to queue mapping for all non
    KSZ8xxx variants
  net: dsa: microchip: let DCB code do PCP and DSCP policy configuration
  net: dsa: add support switches global DSCP priority mapping
  net: dsa: microchip: add support DSCP priority mapping
  selftests: microchip: add test for QoS support on KSZ9477 switch
    family

 drivers/net/dsa/microchip/Kconfig             |   2 +
 drivers/net/dsa/microchip/Makefile            |   2 +-
 drivers/net/dsa/microchip/ksz8.h              |   1 +
 drivers/net/dsa/microchip/ksz8795.c           | 106 ++-
 drivers/net/dsa/microchip/ksz8795_reg.h       |   9 +-
 drivers/net/dsa/microchip/ksz9477.c           |   6 -
 drivers/net/dsa/microchip/ksz_common.c        | 103 ++-
 drivers/net/dsa/microchip/ksz_common.h        |  11 +-
 drivers/net/dsa/microchip/ksz_dcb.c           | 793 ++++++++++++++++++
 drivers/net/dsa/microchip/ksz_dcb.h           |  23 +
 include/net/dsa.h                             |  13 +
 include/net/dscp.h                            |  76 ++
 include/net/ieee8021q.h                       |  57 ++
 net/Kconfig                                   |   3 +
 net/core/Makefile                             |   1 +
 net/core/ieee8021q_helpers.c                  | 242 ++++++
 net/dsa/user.c                                | 103 +++
 .../drivers/net/microchip/ksz9477_qos.sh      | 668 +++++++++++++++
 18 files changed, 2133 insertions(+), 86 deletions(-)
 create mode 100644 drivers/net/dsa/microchip/ksz_dcb.c
 create mode 100644 drivers/net/dsa/microchip/ksz_dcb.h
 create mode 100644 include/net/dscp.h
 create mode 100644 include/net/ieee8021q.h
 create mode 100644 net/core/ieee8021q_helpers.c
 create mode 100755 tools/testing/selftests/drivers/net/microchip/ksz9477_qos.sh

-- 
2.39.2


