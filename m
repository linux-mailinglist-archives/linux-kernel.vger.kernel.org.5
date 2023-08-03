Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9F676E907
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbjHCNCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbjHCNCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:02:25 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F8A1712;
        Thu,  3 Aug 2023 06:02:24 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 373CMHMg031514;
        Thu, 3 Aug 2023 15:02:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=NC/gO8r
        cXxgF7iDZLm/BwKaekNu7y4HW12TwJd7n5aY=; b=k0oA0R6c9TplsKdrZEHP2Rg
        eRFd3Rr3eik+BOoAzo8MwNwE7DrKXiZba4iuQ+WmVnJ7mq1Icr5lvnvw0iOhrE2N
        G7zsHc5/eSQ6pPI7IDDZIUeerdmM9mt2nDjhUMPQTjCJcV4jkV2i+jfGHYzw6N2q
        oUmNjbL0A/ygyYoZ8zzInx4IHZ/0K8pLicycmuq2f61no0z9O5xrj0P9U31qiZhv
        hD4Kisk0L1zyfZ62rCemZ4trG8R5EZJeFdSsXt57MppKBTdgJDwHfvGq94EGETrk
        VoAU57z5eUHY2SrpGetjRfresA1o6UV3YZgF2EznNOU2YxSRm6IgDLwSIBKSZcQ=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s893bhkfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 15:02:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5934D10008B;
        Thu,  3 Aug 2023 15:01:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36C472171E2;
        Thu,  3 Aug 2023 15:01:57 +0200 (CEST)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 3 Aug
 2023 15:01:56 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH 0/6] serial: stm32: improve DMA pause and resume
Date:   Thu, 3 Aug 2023 15:01:28 +0200
Message-ID: <20230803130134.155355-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_12,2023-08-03_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series improves DMA management in stm32-usart driver.

It is not recommended to switch DMAT and DMAR bits when a DMA transfer
is in progress. This is going to be replaced by dmaengine_pause or
dmaengine_resume.

stm32_usart_rx_dma_pause, stm32_usart_rx_dma_resume, stm32_usart_tx_dma_pause
and stm32_usart_tx_dma_resume functions, are all redirected to a single function,
called "stm32_usart_dma_pause_resume", that has been created to simplify dma
pause/resume.

Amelie Delaunay (1):
  serial: stm32: synchronize RX DMA channel in shutdown

Valentin Caron (5):
  serial: stm32: avoid clearing DMAT bit during transfer
  serial: stm32: use DMAT as a configuration bit
  serial: stm32: modify parameter and rename stm32_usart_rx_dma_enabled
  serial: stm32: group dma pause/resume error handling into single
    function
  serial: stm32: replace access to DMAR bit by dmaengine_pause/resume

 drivers/tty/serial/stm32-usart.c | 307 ++++++++++++++++++-------------
 drivers/tty/serial/stm32-usart.h |   1 +
 2 files changed, 185 insertions(+), 123 deletions(-)

-- 
2.25.1

