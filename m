Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A033A7D351C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjJWLp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbjJWLpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:45:10 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEC410FB;
        Mon, 23 Oct 2023 04:45:08 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39MLx6W5018223;
        Mon, 23 Oct 2023 04:45:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=JZuj+TXpGcDe4yHZ3tY3RfIizoyIL6N2Au+s/0qKWKA=;
 b=Qb9rj7BAgFA/wSh1bdCFc8och2zyh+iT20JP4cbawlGygB+lW8ythF3aVWignGHzbFKT
 cnTnt1tu5WFce9UEYEmcTg/SBbO+c8Jnuhm9FZBHODC5RXmx7CETEYBkYU0zE1oL37+i
 36YtBjIzsYUT6du1u2PSLWuKV+Q1uKWLFwWBhRXraai8pVyZY+1/rSodZw5dCIO0U5ua
 pfFrT6v4XuF2EBOakT4u1eAdwd4qPa90afhWBcSwD5y8LB0kuYG1i3DWcN1F9HyPzRy8
 Mwu7gc3koT0/2WgORJACDf3WJaElL/y0IRE3jIfGfPTnNacv7QFHWDzb8cB3Opfls7M6 Hw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tvc0qp113-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 04:45:03 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 23 Oct
 2023 04:45:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 23 Oct 2023 04:45:02 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 395273F7044;
        Mon, 23 Oct 2023 04:45:01 -0700 (PDT)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>,
        Shinas Rasheed <srasheed@marvell.com>
Subject: [PATCH net-next 0/3] Cleanup and optimizations to transmit code
Date:   Mon, 23 Oct 2023 04:44:45 -0700
Message-ID: <20231023114449.2362147-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: du1-BUYvZUFGhcxJZLcWYgghew067oG_
X-Proofpoint-GUID: du1-BUYvZUFGhcxJZLcWYgghew067oG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_10,2023-10-19_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup dma sync calls, add xmit_more functionality and then further
remove atomic variable usage in the prior.

Shinas Rasheed (3):
  octeon_ep: remove dma sync in trasmit path
  octeon_ep: implement xmit_more in transmit
  octeon_ep: remove atomic variable usage in Tx data path

 .../ethernet/marvell/octeon_ep/octep_config.h |  3 +-
 .../ethernet/marvell/octeon_ep/octep_main.c   | 35 ++++++++++---------
 .../ethernet/marvell/octeon_ep/octep_main.h   |  9 +++++
 .../net/ethernet/marvell/octeon_ep/octep_tx.c |  5 +--
 .../net/ethernet/marvell/octeon_ep/octep_tx.h |  3 --
 5 files changed, 30 insertions(+), 25 deletions(-)

-- 
2.25.1

