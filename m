Return-Path: <linux-kernel+bounces-19555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFABD826EB7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8082839D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFD844C89;
	Mon,  8 Jan 2024 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FAlGVw/f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3795E4C3AD;
	Mon,  8 Jan 2024 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4089sI8R013690;
	Mon, 8 Jan 2024 04:42:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=9u/49SC5
	0WBd7YpjJHG2tmPETLyQCQuH0KWqieWaf70=; b=FAlGVw/f0WJualSBDMAVv4WQ
	IKfOvtHyJ938wdDXMfFSjSs0UIcT1WtmFZCxccVlc+nO0vV2YQO0U/w9CS+Nbls3
	3jG+qg6d/wphOZ9WKBQer1rO/b0OUNnnq5+49koMJe93fzS3EOmkB5TIcyE98AEb
	ff0lZ36WNMIWLp8jfu01aigU81SE64KHbVeoJTq6nnpD5S7pwGsKuAtUtvKJb1t7
	EZ6SNReue5HTpm0u9NGzFNl0kTC6pgaQ3CCr56OAmwZWRwFT2rkiYTr3GJHTQtxz
	QgM4CbKZtbZ5968cZi1MDPqakHUgqYHBIM3SLSKOop20pPcanIYhg7lvfcdxFw==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vgetxgdn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 04:42:17 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 8 Jan
 2024 04:42:15 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 8 Jan 2024 04:42:15 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 7DB833F7087;
	Mon,  8 Jan 2024 04:42:15 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <sedara@marvell.com>,
        <srasheed@marvell.com>, <egallen@redhat.com>, <mschmidt@redhat.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <horms@kernel.org>,
        <wizhao@redhat.com>, <kheib@redhat.com>, <konguyen@redhat.com>
Subject: [PATCH net-next v4 0/8] add octeon_ep_vf driver
Date: Mon, 8 Jan 2024 04:42:05 -0800
Message-ID: <20240108124213.2966536-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2lKabFo7G2Qubbt6Ziiz2cNbndmCTiXQ
X-Proofpoint-ORIG-GUID: 2lKabFo7G2Qubbt6Ziiz2cNbndmCTiXQ
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

Changes:
V4:
  - Moved some stats from ethtool and added more to ndo_get_stats64
  - Replaced code in IQ full check function to use helper from
    net/netdev_queues.h
  - Refactored code so that NETDEV_TX_BUSY is avoided

V3: https://lore.kernel.org/all/20240105203823.2953604-1-srasheed@marvell.com/
  - Removed UINT64_MAX, which is unused
  - Replaced masks and ULL declarations with GENMASK_ULL(), ULL() and
    other linux/bits.h macros, corrected declarations to conform to xmas tree format in patch [2/8]
  - Moved vfree and vzalloc null pointer casting corrections to patch
    [3/8], and corrected return values to follow standard kernel error codes in same
   - Set static budget of 64 for tx completion processing in NAPI
  - Replaces napi_complete and build_skb APIs to napi_complete_done and
    napi_build_skb APIs respectively
  - Replaced code with helper from net/netdev_queues.h to wake queues in TX completion
    processing
  - Removed duplicate reporting of TX/RX packets/bytes, which is already
    done during ndo_get_stats64

V2: https://lore.kernel.org/all/20231223134000.2906144-1-srasheed@marvell.com/
  - Removed linux/version.h header file from inclusion in
    octep_vf_main.c
  - Corrected Makefile entry to include building octep_vf_mbox.c in
    [6/8] patch.
  - Removed redundant vzalloc pointer cast and vfree pointer check in
    [6/8] patch.

V1: https://lore.kernel.org/all/20231221092844.2885872-1-srasheed@marvell.com/

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
 .../marvell/octeon_ep_vf/octep_vf_cn9k.c      |  491 +++++++
 .../marvell/octeon_ep_vf/octep_vf_cnxk.c      |  502 +++++++
 .../marvell/octeon_ep_vf/octep_vf_config.h    |  160 +++
 .../marvell/octeon_ep_vf/octep_vf_ethtool.c   |  273 ++++
 .../marvell/octeon_ep_vf/octep_vf_main.c      | 1240 +++++++++++++++++
 .../marvell/octeon_ep_vf/octep_vf_main.h      |  334 +++++
 .../marvell/octeon_ep_vf/octep_vf_mbox.c      |  430 ++++++
 .../marvell/octeon_ep_vf/octep_vf_mbox.h      |  166 +++
 .../marvell/octeon_ep_vf/octep_vf_regs_cn9k.h |  154 ++
 .../marvell/octeon_ep_vf/octep_vf_regs_cnxk.h |  162 +++
 .../marvell/octeon_ep_vf/octep_vf_rx.c        |  510 +++++++
 .../marvell/octeon_ep_vf/octep_vf_rx.h        |  224 +++
 .../marvell/octeon_ep_vf/octep_vf_tx.c        |  330 +++++
 .../marvell/octeon_ep_vf/octep_vf_tx.h        |  276 ++++
 21 files changed, 5317 insertions(+)
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


