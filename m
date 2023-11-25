Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297187F8D0A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 19:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjKYSWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 13:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjKYSW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 13:22:27 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAC7F0;
        Sat, 25 Nov 2023 10:22:33 -0800 (PST)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AP1kUfe029211;
        Sat, 25 Nov 2023 19:21:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=inDdaKD
        BJ7Lk9j8vpS8o5PFTDNd1Ufx2FGDjeXB/H1Y=; b=zARPnbEdk4XzEM6YPPCDmOw
        fWGhSHkmUWWhSBR57y6625RMqWaJAQ/zC5cvw6t82WL2zucisa8AcO2qS4NXgwdV
        bGvbrAfONCsk/nc8SoETVTD8iM2zN9IC6GUwgsJ16Ff7OZPzAGkx/W4a5uYuxP0j
        QzFDH7u9zARLOki8K2oOYQOq0TVfyiV4Lh7VrmNd7AWIVydlC6TRVfmmtJ6ea5c/
        ULeZKvNh8+sUEe2opcJdNakW09d925bRjOoWNQ5F1LxLOA3CeBE8fmKq3BcoZi3I
        jKbHCpSic0IAGImzKZidnXewgY65tFR/koM4Y+HvSHGQwX9iaXvEOU+2L3bm7Sg=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uhr8amwcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Nov 2023 19:21:33 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B202D10002A;
        Sat, 25 Nov 2023 19:21:32 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A757B23C6A4;
        Sat, 25 Nov 2023 19:21:32 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 25 Nov
 2023 19:21:33 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] media: i2c: st-mipid02: improvements / cleanups
Date:   Sat, 25 Nov 2023 19:20:48 +0100
Message-ID: <20231125182057.1379357-1-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-25_17,2023-11-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various improvements of the st-mipid02 bridge such as usage
cci_* helpers, active state, v4l2_get_link_freq ...

Alain Volmat (7):
  media: i2c: st-mipid02: add usage of v4l2_get_link_freq
  media: i2c: st-mipid02: don't keep track of streaming status
  media: i2c: st-mipid02: use cci_* helpers for register access.
  media: i2c: st-mipid02: use active state to store pad formats
  media: i2c: st-mipid02: use mipi-csi macro for data-type
  media: i2c: st-mipid02: removal of unused link_frequency variable
  media: i2c: st-mipid02: add Y8 format support

 drivers/media/i2c/Kconfig      |   1 +
 drivers/media/i2c/st-mipid02.c | 481 +++++++++++----------------------
 2 files changed, 153 insertions(+), 329 deletions(-)

-- 
2.25.1

