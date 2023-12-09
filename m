Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9900880B335
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 09:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjLIIPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 03:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLIIPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 03:15:08 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D9F137;
        Sat,  9 Dec 2023 00:15:14 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B984onR022969;
        Sat, 9 Dec 2023 00:15:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=sDRjGat0ZBUDwU4+NcA2S9rlaRUQA/aHu/5DtWZZfQ0=;
 b=acHDlSA5GTnFiAeptB2tkolsr0+T6x91H92RaeN8P6F70JWyTc/YkSV4/D2dk0TGJ1Pe
 J0RsGT3MeS2RlNJQAgimq24qEe32rBfdRc5T+lWgYXn9mYi0mPZI8UfThlFktzr7klz+
 q8K7XemuckGwPkc6htstvhPkHGDAiPuNYHgIlkBvYhseiTJtMoo2tYTYaxy/5QEzX6iR
 XgZtYyvnHqXOATlqYL8dlH2kfd8TJAk70GLcouaQc4LLwvNOmWkR1QRbbnT8nS0DFGA2
 42S0e60/xjIewAvNzpvJML6mtkE9InDswwyLb6rPKsqC3CrgCZ8bsdRpNAhBO67aDJT7 sw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uubddfkhp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 09 Dec 2023 00:15:08 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 9 Dec
 2023 00:14:52 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sat, 9 Dec 2023 00:14:52 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 618043F7095;
        Sat,  9 Dec 2023 00:14:52 -0800 (PST)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <kheib@redhat.com>, <konguyen@redhat.com>,
        Shinas Rasheed <srasheed@marvell.com>
Subject: [PATCH net-next v2 0/4] add PF-VF mailbox support
Date:   Sat, 9 Dec 2023 00:14:46 -0800
Message-ID: <20231209081450.2613561-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0hGVGzQwc4ScE3WCogUgPJ1jploSQjSe
X-Proofpoint-GUID: 0hGVGzQwc4ScE3WCogUgPJ1jploSQjSe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset aims to add PF-VF mailbox support, its related
version support, and relevant control net support for immediate
functionalities such as firmware notifications to VF.

Changes:
V2:
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

