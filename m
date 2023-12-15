Return-Path: <linux-kernel+bounces-1507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A740814F87
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAEEA285756
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33E530130;
	Fri, 15 Dec 2023 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ariPsWsN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446782EF8;
	Fri, 15 Dec 2023 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFIAhn3020035;
	Fri, 15 Dec 2023 10:14:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=WbAOVsm2
	2A6Mljz8c5jxGOOKm4PTAlo9Zgvohh7nb14=; b=ariPsWsNvxsy3DhD4dEGeU/i
	kWyeRg5CNVcwN+vC5yGPKWLw1FNd79eXNa/NmjFFygqdagmfJhWxKuLT4DyNC4tJ
	oRk5vNCI3Wq4jCRuXQqUwZ8QS4EY7W0YijHbePrR7DCjjm/AFCTL6LG0jgeI78pB
	sTuzrG7TCYQ/CXXE+vwmdwJ2vy1RyaSyIjzu19sSQfuLfg9CXJdJ742sN6ygEKng
	wK9K6/OdxfzFFJIh8GgrS8L2M21OfFc+VOZaLWlGnsPFo9+nxXDFKrJptBkGVS1T
	xvJ5Ex3eMmIrloYix6ABmwi4+ORgGQX0epZWUhP/RK9Hw55YTWSjSKa5lrcdOA==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3v06m0v7uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 10:14:29 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 15 Dec
 2023 10:14:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 15 Dec 2023 10:14:27 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 42C553F703F;
	Fri, 15 Dec 2023 10:14:27 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <kheib@redhat.com>, <konguyen@redhat.com>, <shenjian15@huawei.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>
Subject: [PATCH net-next v6 0/4] add PF-VF mailbox support
Date: Fri, 15 Dec 2023 10:14:21 -0800
Message-ID: <20231215181425.2681426-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: vcAZ6w-NGOaKLd6FLrvh_blzG-jHGLi_
X-Proofpoint-ORIG-GUID: vcAZ6w-NGOaKLd6FLrvh_blzG-jHGLi_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

This patchset aims to add PF-VF mailbox support, its related
version support, and relevant control net support for immediate
functionalities such as firmware notifications to VF.

Changes:
V6:
  - Fixed 1/4 patch to apply to top of net-next merged with net fixes

V5: https://lore.kernel.org/all/20231214164536.2670006-1-srasheed@marvell.com/
  - Refactored patches to cut out redundant changes in 1/4 patch.

V4: https://lore.kernel.org/all/20231213035816.2656851-1-srasheed@marvell.com/
  - Included tag [1/4] in subject of first patch of series which was
    lost in V3

V3: https://lore.kernel.org/all/20231211063355.2630028-1-srasheed@marvell.com/
  - Corrected error cleanup logic for PF-VF mbox setup
  - Removed double inclusion of types.h header file in octep_pfvf_mbox.c

V2: https://lore.kernel.org/all/20231209081450.2613561-1-srasheed@marvell.com/
  - Removed unused variable in PATCH 1/4

V1: https://lore.kernel.org/all/20231208070352.2606192-1-srasheed@marvell.com/

Shinas Rasheed (4):
  octeon_ep: add PF-VF mailbox communication
  octeon_ep: PF-VF mailbox version support
  octeon_ep: control net framework to support VF offloads
  octeon_ep: support firmware notifications for VFs

 .../net/ethernet/marvell/octeon_ep/Makefile   |   2 +-
 .../marvell/octeon_ep/octep_cn9k_pf.c         |  59 ++-
 .../marvell/octeon_ep/octep_cnxk_pf.c         |  49 +-
 .../marvell/octeon_ep/octep_ctrl_mbox.h       |   4 +-
 .../marvell/octeon_ep/octep_ctrl_net.c        |   6 +
 .../ethernet/marvell/octeon_ep/octep_main.c   |  84 +++-
 .../ethernet/marvell/octeon_ep/octep_main.h   |  46 +-
 .../marvell/octeon_ep/octep_pfvf_mbox.c       | 450 ++++++++++++++++++
 .../marvell/octeon_ep/octep_pfvf_mbox.h       | 167 +++++++
 .../marvell/octeon_ep/octep_regs_cn9k_pf.h    |   9 +
 .../marvell/octeon_ep/octep_regs_cnxk_pf.h    |  13 +
 .../net/ethernet/marvell/octeon_ep/octep_tx.h |  24 +-
 12 files changed, 864 insertions(+), 49 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h

-- 
2.25.1


