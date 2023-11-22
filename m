Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB3B7F4FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344050AbjKVSe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjKVSey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:34:54 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A31D50;
        Wed, 22 Nov 2023 10:34:51 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMIT5KW019590;
        Wed, 22 Nov 2023 10:34:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=0GqnSZpL4E/OI68ZnBo58kjUaFbXjIqAqR9BlWTLW7g=;
 b=c/Ibi1n+X3/JmOHutygyBnb1iitVpUMCXTlGzyxZBU73au8WxltZRRk4IiKgU8K+K11W
 Bh/HiQ0zXZ395CcASz3D8AHjhOVmh1VZ0zv12WyUpzvfchu6nkJRFsBhr4aAOpexCHAu
 pcH2rKuAe5U5xOjrnts5rbvPFhR3p4s465Fc9uzLSZpxJ+vTyq8EuL1gf044LlVgT1B4
 QJx9HkGYr9HEO62FeSfZYez7pUo9ENZBOXbiG+gLomzUSVU699+BC8zstyKuRrcrethZ
 ZkzSY9Ugi19tUvq9kr5RSrXjIRfXa5IRbA9LraywLpc4Tj0cBsQFS0ae+Z2NhNC2H/O9 PQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uhpxn00ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 10:34:42 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 22 Nov
 2023 10:34:39 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 22 Nov 2023 10:34:39 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 8B3203F7040;
        Wed, 22 Nov 2023 10:34:39 -0800 (PST)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, <jesse.brandeburg@intel.com>,
        <sumang@marvell.com>, Shinas Rasheed <srasheed@marvell.com>
Subject: [PATCH net-next v2 0/2] Get max rx packet length and solve
Date:   Wed, 22 Nov 2023 10:34:33 -0800
Message-ID: <20231122183435.2510656-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QKQM7XTY9JWB2nlUHbrxiNRER0mQ8uvK
X-Proofpoint-GUID: QKQM7XTY9JWB2nlUHbrxiNRER0mQ8uvK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_13,2023-11-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patchsets which resolve observed style issues in control net
source files, and also implements get mtu control net api
to fetch max mtu value from firmware

Changes:
V2:
  - Introduced a patch to resolve style issues as mentioned in V1
  - Removed OCTEP_MAX_MTU macro, as it is redundant.

V1: https://lore.kernel.org/all/20231121191224.2489474-1-srasheed@marvell.com/

Shinas Rasheed (2):
  octeon_ep: Solve style issues in control net files
  octeon_ep: get max rx packet length from firmware

 .../ethernet/marvell/octeon_ep/octep_config.h |   2 -
 .../marvell/octeon_ep/octep_ctrl_net.c        |  42 ++++--
 .../marvell/octeon_ep/octep_ctrl_net.h        | 125 +++++++++++-------
 .../ethernet/marvell/octeon_ep/octep_main.c   |  10 +-
 4 files changed, 113 insertions(+), 66 deletions(-)

-- 
2.25.1

