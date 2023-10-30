Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8F07DB56D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjJ3Isi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjJ3Isa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:48:30 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84B1C1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:48:27 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39U8LowF012182;
        Mon, 30 Oct 2023 09:48:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=afIMPnz
        B87TsAbYfZBjMKSYVS/aLcv5tgnj+u8RHJ7U=; b=0JUHsAPQxK7ntk560y1wDXB
        Vshe90AiIVyeyc/FDsRfrzt8LX4OVGcL9MsmupmL7PUHsjjm7vl8Gr08H8N2xCX5
        G+GU8fZYtxAXh0KATXsd99o27HxGL0QTY2RyYyM8SB8jH1hxnlx9D0iZT/r+vJU+
        HAF0B5PTv4tqB+ptlMOKJH+mW1RKmufoL+V3U+kEDy0dYuV3F7JEP6N3D9PDJLF6
        v8EdOcOZNCecHEDNppgIUd3rlJ2e5m/KIaaABPMkFkwNLnyVFEsK8iiSWxJp//ae
        Vc5SRIMBqrgu3ykhVPX3vfHM3VJdGMSK/7hMgdW2wdhxlbdqLOOV2XY7aP1QMmw=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u0tw4egbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 09:48:15 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7906C10006C;
        Mon, 30 Oct 2023 09:48:14 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 58C2B21860E;
        Mon, 30 Oct 2023 09:48:14 +0100 (CET)
Received: from localhost (10.201.20.20) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 30 Oct
 2023 09:48:14 +0100
From:   Etienne Carriere <etienne.carriere@foss.st.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <op-tee@lists.trustedfirmware.org>,
        Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v12 0/4] tee: introduce TEE system sssion
Date:   Mon, 30 Oct 2023 09:48:08 +0100
Message-ID: <20231030084812.905549-1-etienne.carriere@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.20]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_06,2023-10-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces TEE system sessions for TEE service sessions that
require TEE to provision resources to prevent deadlock when clients call
the TEE.

This deadlock situation can happen when a TEE service is used by low
level system resources as for example when Linux kernel uses SCMI
service embedded in TEE for clock, reset, regulator, etc... controls.
This case is detailled in patch 2/4:

> This feature is needed to prevent a system deadlock when several TEE
> client applications invoke TEE, consuming all TEE thread contexts
> available in the secure world. The deadlock can happen in the OP-TEE
> driver for example if all these TEE threads issue an RPC call from TEE
> to Linux OS to access an eMMC RPMB partition (TEE secure storage) which
> device clock or regulator controller is accessed through an OP-TEE SCMI
> services. In that case, Linux SCMI driver must reach OP-TEE SCMI
> service without waiting until one of the consumed TEE threads is freed.

Etienne Carriere (4):
  tee: optee: system call property
  tee: system session
  tee: optee: support tracking system threads
  firmware: arm_scmi: optee: use optee system invocation

 drivers/firmware/arm_scmi/optee.c |   4 +
 drivers/tee/optee/call.c          | 130 ++++++++++++++++++++++++++++--
 drivers/tee/optee/core.c          |   5 +-
 drivers/tee/optee/ffa_abi.c       |  14 ++--
 drivers/tee/optee/optee_private.h |  29 ++++++-
 drivers/tee/optee/smc_abi.c       |  32 +++++---
 drivers/tee/tee_core.c            |   8 ++
 include/linux/tee_drv.h           |  16 ++++
 8 files changed, 211 insertions(+), 27 deletions(-)
---
Changes since v11:
- Fixed inline description comments in patch 1/3 and 3/4, other patches
  are unchanged.

Changes since v10:
- Changes patch 3/4, other are unchanged.
-- 
2.25.1

