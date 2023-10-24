Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCFB7D545A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343497AbjJXOvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbjJXOvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:51:36 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1B8A6;
        Tue, 24 Oct 2023 07:51:34 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39O2Kg1J022528;
        Tue, 24 Oct 2023 07:51:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=8IJJFkfM8fhSAXzt+kQuv/DZZRyUhXSsr4Xlh55jzLc=;
 b=dbvqhuGDQ8A6LImGEZ8+AVtOA/W+b55yl8bw+eV/D4Zjn8uobfsvZ6T5uchSUEO3BrD4
 Hy4CKXw/F/SMDNVK7lcLTKVllr3LHz7PHIaJiwACL3Ta7yY96foz4TEALwPZS73zhmYa
 t62WyQ0gDgtp/5oNMKhM5iWnmNFTx+RtiuPqG455hhHXB9Ug5FTFkW5wv/qg2Iry+0HU
 43Uafef2yrVSVHEDUxYlZc6V6cbFbSPKAUs7PIbrtCznZ3YStZRTMjS3PX9V3IQnEpEe
 21bk0FAWZA49oOHdLShyKQmjRpUlvyD2ixz8V+8AdcamvN1WYT7ppR6mlD4BwRYGH4Lc mw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tx523tpn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 07:51:27 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 24 Oct
 2023 07:51:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 24 Oct 2023 07:51:26 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 188A13F7051;
        Tue, 24 Oct 2023 07:51:26 -0700 (PDT)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>
Subject: [PATCH net-next v2 0/4] Cleanup and optimizations to transmit code
Date:   Tue, 24 Oct 2023 07:51:15 -0700
Message-ID: <20231024145119.2366588-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: InEnJ0ARX4ok_1qM6Wq11E2Bv8Cr9sDq
X-Proofpoint-ORIG-GUID: InEnJ0ARX4ok_1qM6Wq11E2Bv8Cr9sDq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_15,2023-10-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pad small packets to ETH_ZLEN before transmit, cleanup dma sync calls,
add xmit_more functionality and then further remove atomic 
variable usage in the prior.

Changes:
V2:
  - Added patch for padding small packets to ETH_ZLEN, part of
    optimization patches for transmit code missed out in V1
  - Updated changelog to provide more details for dma_sync remove patch
  - Updated changelog to use imperative tone in add xmit_more patch
V1: https://lore.kernel.org/all/20231023114449.2362147-1-srasheed@marvell.com/

Shinas Rasheed (4):
  octeon_ep: add padding for small packets
  octeon_ep: remove dma sync in trasmit path
  octeon_ep: implement xmit_more in transmit
  octeon_ep: remove atomic variable usage in Tx data path

 .../ethernet/marvell/octeon_ep/octep_config.h |  3 +-
 .../ethernet/marvell/octeon_ep/octep_main.c   | 38 ++++++++++---------
 .../ethernet/marvell/octeon_ep/octep_main.h   |  9 +++++
 .../net/ethernet/marvell/octeon_ep/octep_tx.c |  5 +--
 .../net/ethernet/marvell/octeon_ep/octep_tx.h |  3 --
 5 files changed, 33 insertions(+), 25 deletions(-)

-- 
2.25.1

