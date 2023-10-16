Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C387CA360
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjJPJFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjJPJEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:04:52 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C75E1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:04:50 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39G7phQ3017535;
        Mon, 16 Oct 2023 11:04:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=+KwoOYk
        zj5H40O26JJtXUk+e+fUkDGx8/XQV9xP6wMQ=; b=Ld8tDPOJUx/PdAwqC83sDwF
        hOEpOVz72illBdLRDATN6RcyFLmvxC1pX5z6MYJixiNn5eD7lTlkaaIRRMy6Tpze
        IcSod+O4XpZWbmG+8HkfuXo7NXhVzmRW+ZXvdKSlC/wZ5HDAF6mhrzQbSFDnlYSF
        jrQOKWjU8N1ez4faEUFRMQ4cgllDpWGd8ua/iNAcRUE319+g6yNtZ9ku7uXOCUna
        b4awdUmBPLwmPd0GJuxiDfCXgs1sJZj0TwwcI3ffsRxieuf/0OkyePWy6sdWGgmg
        Gmi+Ksm1/iSVpMSrVObVMBzL6RX3NOhB72m5XrX2cMXZDS3QtlMx1DtrwF9e0Jg=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tr4hym8x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 11:04:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0B6BE10005C;
        Mon, 16 Oct 2023 11:04:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ED43D218610;
        Mon, 16 Oct 2023 11:04:30 +0200 (CEST)
Received: from localhost (10.201.20.20) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 11:04:30 +0200
From:   Etienne Carriere <etienne.carriere@foss.st.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <op-tee@lists.trustedfirmware.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v11 0/4] tee: introduce TEE system sssion
Date:   Mon, 16 Oct 2023 11:04:24 +0200
Message-ID: <20231016090428.1369071-1-etienne.carriere@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.20]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_02,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
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
 drivers/tee/optee/ffa_abi.c       |  13 +--
 drivers/tee/optee/optee_private.h |  29 ++++++-
 drivers/tee/optee/smc_abi.c       |  31 ++++---
 drivers/tee/tee_core.c            |   8 ++
 include/linux/tee_drv.h           |  16 ++++
 8 files changed, 209 insertions(+), 27 deletions(-)
---
Changes since v11:
- Changes patch 3/4, other are unchanged.
-- 
2.25.1

