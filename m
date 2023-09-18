Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BB17A4995
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241955AbjIRM06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242064AbjIRM0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:26:47 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DBFD1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:26:31 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38I85PTM017571;
        Mon, 18 Sep 2023 14:26:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:content-transfer-encoding:mime-version; s=
        selector1; bh=9LpcWqyU6j+ruwMsRPUjQwhjDUYiqwuo2YGiyOEQqJE=; b=AR
        XsFTAwgva6oMXYgi5uoX1t/naUqU3RyKd7CKWVS5BSEk4RlndhipDBITqBJZI6Oi
        mmCTi7MBdM6PGiy16/ee6MNWPB0P4Upky4Y8Jq7mIba2KN7VXvv13SiZN1y4PN2f
        YDzirs4kI0BhNxdOiUzk3eOqujAcVTLT8CsFKPeYRTeKo5kNf8Q3p4vvJYD285YL
        B9ULU+Lbvq2CnnIMDHDlW6HBtfHqMA1yYEIgd2tP1RxIt08/ZyYegrvz/h0t9668
        AKif8SEQBuY5cu5LxKaiq8XIdE+HFULe7J2Imq96PvnqLp7TRt8ZJNjrNBAYiWAb
        QeCZlUzrELagpfnw+3rg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t5nx0cabh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 14:26:27 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D35E9100061;
        Mon, 18 Sep 2023 14:26:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C416625AF07;
        Mon, 18 Sep 2023 14:26:26 +0200 (CEST)
Received: from [192.168.8.15] (10.201.20.114) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 14:26:26 +0200
Message-ID: <556007adcfd12f5f0bd997dba6c050aa28922ed3.camel@foss.st.com>
Subject: async probe: boot crash with v5.10.188 on STM32MP157
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Saravana Kannan <saravanak@google.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>
Date:   Mon, 18 Sep 2023 14:26:21 +0200
In-Reply-To: <AS8PR10MB4712C2960C439EF76E25DA98EEF7A@AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM>
References: <cd0d84738c07dea1410e4bb739fb1c1e0e8f8a26.camel@st.com>
         <AS8PR10MB47124BE71CB331EEE18891FDEEF7A@AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM>
         <fdb9b57462fd6d532365fcf3795f3a6825bb1f07.camel@st.com>
         <AS8PR10MB4712C2960C439EF76E25DA98EEF7A@AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Originating-IP: [10.201.20.114]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_05,2023-09-18_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

while devlink and async probe looks ok in v6.6-rc1, I get randomly boot
crash on STM32MP157 with kernel v5.10.188 after the upstream commit
3108eb2e8aa7 ("mmc: mmci: Set PROBE_PREFER_ASYNCHRONOUS") got backported.

In v6.6-rc1, really_probe() checks for probe dependencies with
device_links_check_suppliers(). In older kernels this part is missing.
In the specific case of STM32MP157, the driver mmci can get async-probed
while the probe of pinctrl/stm32/pinctrl-stm32.c has already registered
the pinctrl but has not added any gpiochip yet.
This causes pinmux_ops::set_mux() to fail and thus mmci probe fails too.

Boot log contains:

[2.205476] stm32mp157-pinctrl soc:pin-controller@50002000: No gpio range de=
fined.
[2.205515] mmci-pl18x 58005000.sdmmc: Error applying setting, reverse thing=
s back
[2.205828] mmci-pl18x: probe of 58005000.sdmmc failed with error -22
[2.210434] stm32mp157-pinctrl soc:pin-controller@50002000: GPIOA bank added

From a quick code check, also the LTS v5.15 and v6.1 looks impacted, but
I have not tested them, so far, due to the difficulties to replicate the
crash.

Is there any mandatory upstream patch that got lost in the backport process=
?

Or is there something incorrect to be fixed in pinctrl-stm32 driver?

What are the possible workaround I can use? Would kernel flag fw_devlink=3D=
off
work reliably for all the mentioned kernel versions?

Regards,
Antonio
