Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2825375C677
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjGUMEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjGUMEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:04:44 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D92E3A9B;
        Fri, 21 Jul 2023 05:04:26 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L9YE57006035;
        Fri, 21 Jul 2023 14:04:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=ZAVWTjSBvcL2snk08HQthnfWTjygvX1KBY6CnQVeJpA=;
 b=Q9lIIu5IpXp/JAkHssnbEx+2AvqNDU7cDiRfMrf2sB3yyUa0r33zQRMA4z145msYHrBU
 ZwwcYGUYZHXfjouA/Kq4VVqa8tZbFHoAACLE8p/H2p0kJpjwWQwZUe/vID3qL2WiXX+Y
 KZDDTdSjLQX8x3CHtzoBM6TB/QXPCeSwXUSuwcv6pSRwzaUYxklWeP/imisVILY3TKKg
 qv1V43wpCCQrB/2hvcZWNr+tMzeXNV7pOmcels2TZnYmJhsR9HwGPOQ8rfKJVNJYCddS
 lk9t7RVJpsYyhP4DRtF7gYoJSJxdTTD3V2LQxjraSNmbNKVq1G3dmF+Vhqop3bkAHl8z Bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ryqgms5gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 14:04:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B13B010002A;
        Fri, 21 Jul 2023 14:04:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A9910229A68;
        Fri, 21 Jul 2023 14:04:09 +0200 (CEST)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 21 Jul
 2023 14:04:09 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Alain Volmat <alain.volmat@foss.st.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/2] media: stm32: correct s_stream calls in dcmi & st-mipid02
Date:   Fri, 21 Jul 2023 14:03:13 +0200
Message-ID: <20230721120316.1172445-1-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_07,2023-07-20_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the stm32 dcmi driver is calling s_stream to all subdevs until
reaching the sensor subdev.  This serie corrects this by having a subdev
only calling s_stream on its source subdev.

v2: correct an uninitialized variable (ret) in st_mipid02 patch

Alain Volmat (2):
  media: i2c: st_mipid02: cascade s_stream call to the source subdev
  media: stm32: dcmi: only call s_stream on the source subdev

 drivers/media/i2c/st-mipid02.c               | 13 +++-
 drivers/media/platform/st/stm32/stm32-dcmi.c | 63 +++++---------------
 2 files changed, 26 insertions(+), 50 deletions(-)

-- 
2.25.1

