Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F1775C49D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjGUKZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjGUKYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:24:48 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4024730F2;
        Fri, 21 Jul 2023 03:24:23 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 2745A100006;
        Fri, 21 Jul 2023 13:24:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2745A100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689935062;
        bh=tFCW/uaLj61ag756MfONvhXmQcmfZ0nLYjbhS1U4p1g=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=PaVcMPqScfXEAVZrFPlKf0lqQQndn2hUC5BTeY795uAnVKnxDjDNKAEG5Gwv6gV4L
         Ssz2b2fhMwUeKYemdRfcGBDvZN9kB6TWbtAjW+LUscKV7WYnlSXt5t5W7VrCDr06TW
         yHcFjfACklRNPoqkHWV3MieRedCACHtaq5XFKcpVp6fhsSd2iOt4S94BvDWb5SOG5L
         reO5+WiPu1XJfu8H8LSt0P8k+AYBy9IaOu9wJa2NaNzTKcKyRM5/wWlpk2n1Fw7m78
         4u62lnRiTF+eZZz3LboFi5Vus0RdCzwVSrCIKEMgMOSi+PznvGXi23jEqxphcBoTkm
         gqq33is7CILdg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 21 Jul 2023 13:24:21 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 21 Jul 2023 13:24:21 +0300
From:   George Stark <gnstark@sberdevices.ru>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <gnstark@sberdevices.ru>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>
Subject: [PATCH v2 0/2] iio: adc: meson: fix core clock enable/disable moment
Date:   Fri, 21 Jul 2023 13:23:07 +0300
Message-ID: <20230721102413.255726-1-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178775 [Jul 21 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 525 525 723604743bfbdb7e16728748c3fa45e9eba05f7d, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;www.spinics.net:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/07/21 08:11:00
X-KSMG-LinksScanning: Clean, bases: 2023/07/21 08:13:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/21 05:36:00 #21651174
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a part of effort to support meson a1 SoC and make meson saradc driver
independent from vendor boot code initialization in common.

Core clock (passed to adc module thru dts) is supposed to be responsible for entier module
and should be on before accessing modules' regs.

I've made experiments and here are the results:

on odroid-c1 (meson8) adc regs became readonly with core clock off:
# disable clock (HHI_GCLK_MPEG0 bit 10)
devmem 0xc1104140 32 0xBFFA72FF
devmem 0xc110868C
0xE3A851FF
devmem 0xc110868C 32 0xE3A85100
devmem 0xc110868C
0xE3A851FF
# enable clock
devmem 0xc1104140 32 0xBFFA76FF
 devmem 0xc110868C
0xE3A851FF
devmem 0xc110868C 32 0xE3A85100
devmem 0xc110868C
0xE3A85100

on vim3 (a311d) adc regs became readonly with core clock off:
# disable adc core clock:
devmem 0xff80004C 32 0xFFFFFEFF
# the adc register become readonly:
devmem 0xff80902c
0x002C2002
devmem 0xff80902c 32 0x002C2000
devmem 0xff80902c
0x002C2002

on a1 adc registers are none-readable-writeable when adc core clock is off:
devmem 0xfe002c2c
0x00002003
# disable clock
devmem 0xfe00081c 32 0xFFFF9FFF
devmem 0xfe002c2c
0x00000000
# enable clock
devmem 0xfe00081c 32 0xFFFFFFFF
devmem 0xfe002c2c
0x00002003

Changelog:

v1->v2:
patch 'iio: adc: meson: improve error logging at probe stage'
	- add fixes tag, previous version [1]
	- move to devm_clk_get_enabled
	- return enable/disable core clock calls to suspend \ resume callbacks
	but did it at the last step and the first step respectively

patch 'iio: adc: meson: improve error logging at probe stage'
	patch was added to address Jonathan's comment

[1] https://www.spinics.net/lists/linux-iio/msg80369.html

George Stark (2):
  iio: adc: meson: fix core clock enable/disable moment
  iio: adc: meson: improve error logging at probe stage

 drivers/iio/adc/meson_saradc.c | 39 +++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 17 deletions(-)

-- 
2.38.4

