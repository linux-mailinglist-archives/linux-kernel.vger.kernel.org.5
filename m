Return-Path: <linux-kernel+bounces-8122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3DD81B266
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F37AB275BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB69230335;
	Thu, 21 Dec 2023 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Lv/x3rDs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF6B3398E;
	Thu, 21 Dec 2023 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL6IGer019052;
	Thu, 21 Dec 2023 01:28:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=v99kQxAd
	tpEt3M6lqd22NVNMCYcE19GlNI8tMkZFstg=; b=Lv/x3rDsY5XWTIraMr6ncsZH
	VXM6VqEAs3HhmIP171zhZGRFEK/wBeDye6mfSDtVxdaFHpDk3OamMKx8HX+Cu3Pi
	nH5+QGFfwfMy+rPjn9LKYXSb5QZ2upqf1k8921cNM8HBys0fpxkbIZEOwaAvGUZ5
	/jmsNTjPJ73KOAJ52TpyQ+Xgj/lobiRMl0/ZRflWF6ICuakdWOzL5Hr76O6wW2F/
	AQPa7nQhnjDTc8LBt8Pmwhkb+4TI68JDmD48N9bAakROWeV+F/hWoE//Sh1vY9iI
	ry2p5ZYUr77VJSzAZnDWgfXqHdEkw3InRrNt0HuKcvG/o3uX+cQkkujQ5X+s4A==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3v4fyr13xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 01:28:52 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 21 Dec
 2023 01:28:51 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 21 Dec 2023 01:28:51 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id CF3173F7048;
	Thu, 21 Dec 2023 01:28:50 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <sedara@marvell.com>,
        <srasheed@marvell.com>, <egallen@redhat.com>, <mschmidt@redhat.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <horms@kernel.org>,
        <wizhao@redhat.com>, <kheib@redhat.com>, <konguyen@redhat.com>
Subject: [PATCH net-next v1 0/8] add octeon_ep_vf driver
Date: Thu, 21 Dec 2023 01:28:36 -0800
Message-ID: <20231221092844.2885872-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: DE6Jo0w6wJOuWpOLhhIXLwXbE3f1lhEm
X-Proofpoint-ORIG-GUID: DE6Jo0w6wJOuWpOLhhIXLwXbE3f1lhEm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

This driver implements networking functionality of Marvell's Octeon
PCI Endpoint NIC VF.

This driver support following devices:
 * Network controller: Cavium, Inc. Device b203
 * Network controller: Cavium, Inc. Device b403
 * Network controller: Cavium, Inc. Device b103
 * Network controller: Cavium, Inc. Device b903
 * Network controller: Cavium, Inc. Device ba03
 * Network controller: Cavium, Inc. Device bc03
 * Network controller: Cavium, Inc. Device bd03

Shinas Rasheed (8):
  octeon_ep_vf: Add driver framework and device initialization
  octeon_ep_vf: add hardware configuration APIs
  octeon_ep_vf: add VF-PF mailbox communication.
  octeon_ep_vf: add Tx/Rx ring resource setup and cleanup
  octeon_ep_vf: add support for ndo ops
  octeon_ep_vf: add Tx/Rx processing and interrupt support
  octeon_ep_vf: add ethtool support
  octeon_ep_vf: update MAINTAINERS

 .../device_drivers/ethernet/index.rst         |    1 +
 .../ethernet/marvell/octeon_ep_vf.rst         |   24 +
 MAINTAINERS                                   |    9 +
 drivers/net/ethernet/marvell/Kconfig          |    1 +
 drivers/net/ethernet/marvell/Makefile         |    1 +
 .../net/ethernet/marvell/octeon_ep_vf/Kconfig |   19 +
 .../ethernet/marvell/octeon_ep_vf/Makefile    |   10 +
 .../marvell/octeon_ep_vf/octep_vf_cn9k.c      |  488 +++++++
 .../marvell/octeon_ep_vf/octep_vf_cnxk.c      |  500 +++++++
 .../marvell/octeon_ep_vf/octep_vf_config.h    |  160 +++
 .../marvell/octeon_ep_vf/octep_vf_ethtool.c   |  307 ++++
 .../marvell/octeon_ep_vf/octep_vf_main.c      | 1231 +++++++++++++++++
 .../marvell/octeon_ep_vf/octep_vf_main.h      |  338 +++++
 .../marvell/octeon_ep_vf/octep_vf_mbox.c      |  430 ++++++
 .../marvell/octeon_ep_vf/octep_vf_mbox.h      |  166 +++
 .../marvell/octeon_ep_vf/octep_vf_regs_cn9k.h |  154 +++
 .../marvell/octeon_ep_vf/octep_vf_regs_cnxk.h |  162 +++
 .../marvell/octeon_ep_vf/octep_vf_rx.c        |  511 +++++++
 .../marvell/octeon_ep_vf/octep_vf_rx.h        |  224 +++
 .../marvell/octeon_ep_vf/octep_vf_tx.c        |  332 +++++
 .../marvell/octeon_ep_vf/octep_vf_tx.h        |  276 ++++
 21 files changed, 5344 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/marvell/octeon_ep_vf.rst
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/Kconfig
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/Makefile
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_config.h
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.h
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_regs_cn9k.h
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_regs_cnxk.h
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.h
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.h

-- 
2.25.1


