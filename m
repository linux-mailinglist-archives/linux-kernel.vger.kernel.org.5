Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCF37ADCF8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjIYQWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjIYQWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:22:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7534DDF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:22:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PECL0J010063;
        Mon, 25 Sep 2023 16:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=D8/L7io2iZBhsdwjWoh1XJ3RaISMq8Xsh3QW8UMayYo=;
 b=ptp08a/ru91GJQ19d4baO50CZV6M/SUZrZEe8Pv/YnEn9cE5lhzH+p9tT55aUFRBm4FY
 xsITu4qKle0YFKpIaheBBbH0FmS+n9u0pBjRsD2M2zQDoZrGjK7ShkuazPaUSI7m6YVu
 Pxx1lu0W2QWFr9nWKhx5OGn9W3Bf91ZQB2tyTZHBPj+/3lE6a9XMXdcqXqzYm4FBb7/+
 GWoPKcUxaQYKOlKcJsE3kWYTVHSucZk2EpGyWTAL4TV911PC/PtgU1432rotROfYPZo8
 Q/uqcs2cQSSBUMFPwfN5zCzc6QAu8Pil7Xar3kXaQK4O2JX4YFfjlZ4RwyHCN5hzn1Sl 9Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbc3tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 16:21:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PFVeVW034938;
        Mon, 25 Sep 2023 16:21:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf4yd6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 16:21:45 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38PGLi1w024071;
        Mon, 25 Sep 2023 16:21:44 GMT
Received: from mlluis-mac.uk.oracle.com (dhcp-10-175-170-37.vpn.oracle.com [10.175.170.37])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3t9pf4ycur-1;
        Mon, 25 Sep 2023 16:21:44 +0000
From:   Miguel Luis <miguel.luis@oracle.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
Cc:     miguel.luis@oracle.com
Subject: [PATCH v2 0/2] Fine grain sysregs allowed to trap for nested virtualization
Date:   Mon, 25 Sep 2023 16:20:55 +0000
Message-Id: <20230925162057.27548-1-miguel.luis@oracle.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_13,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=847 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250126
X-Proofpoint-GUID: EEyGGGEQ6o-CJQjZZsVLRe3voyfEkgOO
X-Proofpoint-ORIG-GUID: EEyGGGEQ6o-CJQjZZsVLRe3voyfEkgOO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current HCR_EL2 description includes _EL1 registers that are not affected
by NV. Let's exclude them from those ranges to implement a more fine grained
approach.

Changes v1 -> v2
 patch 1:
	fix indentation
 patch 2:
	improve commit message (Marc)
	fix indentation (Marc)
	follow kernel comment format (Marc)
	describe LRs in ranges (Marc)
	include AMEVCNTVOFF0<n>_EL2 and AMEVCNTVOFF1<n>_EL2
 patch 3:
	drop. Excluded IMPDEF range is trapped by HCR_EL2.TIDCP

v1: https://lore.kernel.org/kvmarm/20230913185209.32282-1-miguel.luis@oracle.com/

Miguel Luis (2):
  arm64: Add missing _EL12 encodings
  arm64/kvm: Fine grain _EL2 system registers list that affect nested
    virtualization

 arch/arm64/include/asm/sysreg.h | 11 +++++++++
 arch/arm64/kvm/emulate-nested.c | 44 ++++++++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 6 deletions(-)

--
2.39.2

