Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E78E7C5AC0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbjJKSCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjJKSCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:02:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E792793
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:02:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BHE2Ku020157;
        Wed, 11 Oct 2023 18:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=LANmNJdueyvQi7c+RbU1YOnVyO963av3fCML/59OnNg=;
 b=O3lSyLLCbj4f96Jv4+r7OqeiTyynS/aleT1b1LCzjeLQ+9NT6NjqkqvWj8KEDNr/oLCK
 yPfokbmH2DDEOHbkeaN2okWNlpNKDs2J/eti1VBwkAQyaCJvxHPlVLlKBVQ9xaNrWWDm
 ujXo52LdSew/4MCE0EoAz5nZvLP77gYhO1I3vqQnEzpjD7+XMWaWHeHiiTGoaEI27wEV
 1EydeADLcnvmW3VW6iE8faOBf9NGMUr+W6VBamQCDWVV5vJETnGTKya+E8/7bHiIadnN
 a8PONg/o5ZBWsEsdx4UUOkHle1+6SKvd0E3Xm4XQ8az/VCUe2hP3crEZLj+M8DlGW8+1 Dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx43rypq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 18:01:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39BGjwdH002618;
        Wed, 11 Oct 2023 18:01:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsedrkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 18:01:40 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39BI1eE0029797;
        Wed, 11 Oct 2023 18:01:40 GMT
Received: from mlluis-mac.uk.oracle.com (dhcp-10-175-192-63.vpn.oracle.com [10.175.192.63])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tjwsedrg7-1;
        Wed, 11 Oct 2023 18:01:39 +0000
From:   Miguel Luis <miguel.luis@oracle.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jing Zhang <jingzhangos@google.com>,
        Eric Auger <eric.auger@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
Cc:     miguel.luis@oracle.com
Subject: [PATCH v3 0/3] Fine grain sysregs allowed to trap for nested virtualization
Date:   Wed, 11 Oct 2023 18:00:59 +0000
Message-Id: <20231011180103.91774-1-miguel.luis@oracle.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_12,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110159
X-Proofpoint-ORIG-GUID: xzf-n6Ewm7oFwSQkaKcFwZ04a9JY1xaN
X-Proofpoint-GUID: xzf-n6Ewm7oFwSQkaKcFwZ04a9JY1xaN
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current HCR_EL2 description defines ranges of system register encodings in
which accesses should trap for NV. These ranges include encodings which aren't
defined in the reference manual. In order avoid this, let's rather implement a
more fine grained approach excluding those undefined.

Changes v2 -> v3
 patch 1:
	Fix BRBCR_EL12. (Eric)
	Add Eric's R-b. Thanks!
 patch 2:
	New patch to add missing _EL2 encodings for patch 3.
 patch 3:
	Previously patch 2 in v2.
	Add Fixes tag. (Eric)
	Merge contiguous ranges and exclude undefined encodings. (Eric)

v1 -> v2
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

v2: https://lore.kernel.org/kvmarm/20230925162057.27548-1-miguel.luis@oracle.com/
v1: https://lore.kernel.org/kvmarm/20230913185209.32282-1-miguel.luis@oracle.com/

Miguel Luis (3):
  arm64: Add missing _EL12 encodings
  arm64: Add missing _EL2 encodings
  arm64/kvm: Fine grain _EL2 system registers list that affect nested
    virtualization

 arch/arm64/include/asm/sysreg.h | 48 ++++++++++++++++++
 arch/arm64/kvm/emulate-nested.c | 88 ++++++++++++++++++++++++++++++---
 2 files changed, 130 insertions(+), 6 deletions(-)

--
2.39.2

