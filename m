Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959017E3AC3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjKGLGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbjKGLGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:06:23 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFFAEA;
        Tue,  7 Nov 2023 03:06:20 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A7Ab30n023702;
        Tue, 7 Nov 2023 12:06:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=GsZbf1O
        usFrNfhIV1CDJxzRVyg3nK7nEux7A+R3rSug=; b=C94JsqqU67pqRk8zLjuDXnx
        DwAMqHuToFm3IR1gYqfTMzGtQvaWcmM7E8rnXvRCG5X7pmSHb9v4j+LzeNkTl5DA
        +2tl6wKCXhrk1oWV6cWL0z/2pxyAab/Yb/pNpq3UvQhx4iUhW6Y2Wzwr3t25B8CD
        Q+dWHcnGgxe0LLkRuc+guJLuctCoM/L1NhWgYhrsBfuPKPVozaolzDhN7/MS/uSp
        eZiqIv3afNqQp/xfKESkXtxwNjI8+JpEL2RMMx7SyJDlT1fb4c+Vey+HpJ/hsDYJ
        F++jJrm9Cd8Pj+Hrf74xu/kwmMYeDZK482St4Vj629/FLFLnhDZnPzMC6zSKiqA=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u5ehtks2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 12:06:00 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E012D100059;
        Tue,  7 Nov 2023 12:05:58 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D2FB121ADBC;
        Tue,  7 Nov 2023 12:05:58 +0100 (CET)
Received: from localhost (10.201.20.114) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 7 Nov
 2023 12:05:58 +0100
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
CC:     Antonio Borneo <antonio.borneo@foss.st.com>,
        <linux-gpio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] pinctrl: stm32: fix array read out of bound
Date:   Tue, 7 Nov 2023 12:05:20 +0100
Message-ID: <20231107110520.4449-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.114]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_01,2023-11-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing code does not verify if the "tentative" index exceeds
the size of the array, causing out of bound read.
Issue identified with kasan.

Check the index before using it.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Fixes: 32c170ff15b0 ("pinctrl: stm32: set default gpio line names using pin names")
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index a73385a431de..56677bad10f7 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -1283,9 +1283,11 @@ static struct stm32_desc_pin *stm32_pctrl_get_desc_pin_from_gpio(struct stm32_pi
 	int i;
 
 	/* With few exceptions (e.g. bank 'Z'), pin number matches with pin index in array */
-	pin_desc = pctl->pins + stm32_pin_nb;
-	if (pin_desc->pin.number == stm32_pin_nb)
-		return pin_desc;
+	if (stm32_pin_nb < pctl->npins) {
+		pin_desc = pctl->pins + stm32_pin_nb;
+		if (pin_desc->pin.number == stm32_pin_nb)
+			return pin_desc;
+	}
 
 	/* Otherwise, loop all array to find the pin with the right number */
 	for (i = 0; i < pctl->npins; i++) {

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.42.0

