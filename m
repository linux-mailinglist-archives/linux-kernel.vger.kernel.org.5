Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A4E8136A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443422AbjLNQqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjLNQqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:46:11 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D2E114;
        Thu, 14 Dec 2023 08:46:17 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE9LXoN016663;
        Thu, 14 Dec 2023 08:45:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=pfpt0220; bh=1b9Ucpj9
        gnfZxgBpgNijv5lFY+zJaKovhnq+EmMW+dk=; b=KhRjo32KOxR9CLtYlibXPhJ+
        7ryV1lY3N9fP3JQDWT26XDpq68LXWLMUimVG5FKCDJuqEmf6L7qLfP8dxnT4yVTC
        nDzqFQaWgHN3piYnvEQBH8ChLh+6s+QUUc/CoWON7RQFLj4T8EL51G8iME3O4qjp
        IxYVueGVusJ+c+pNXvQJx/vfuzA+qHWQy6R2flXxUfAGYxtstbFvyj1o3oW+LOXV
        meArh/aou+tdnX4bzCfnZPj19NdwFHG6MYC57Qxw6h8QlxhC8zOTmJrmTvuHlL5k
        bpuxY+JxIN2RJMWj7+jdhjbI9YU/bUsO873rxYvD7Fq+/4+GUkWxpHd3SQW+Qw==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uyy0nsjga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 08:45:50 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 14 Dec
 2023 08:45:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 14 Dec 2023 08:45:48 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 59A953F7088;
        Thu, 14 Dec 2023 08:45:48 -0800 (PST)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <kheib@redhat.com>, <konguyen@redhat.com>,
        <shenijian15@huawei.com>, "Shinas Rasheed" <srasheed@marvell.com>
Subject: [PATCH net-next v5 0/4] add PF-VF mailbox support
Date:   Thu, 14 Dec 2023 08:45:32 -0800
Message-ID: <20231214164536.2670006-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: X-AYg-st7lJQJ5x8eyT0HODGc-j6SVO3
X-Proofpoint-GUID: X-AYg-st7lJQJ5x8eyT0HODGc-j6SVO3
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
V5:
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

