Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A97D751437
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjGLXMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjGLXMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:12:13 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92AC173F;
        Wed, 12 Jul 2023 16:12:09 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 598C5120024;
        Thu, 13 Jul 2023 02:12:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 598C5120024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689203527;
        bh=tkzvlUgbyspJS7/IueSbjXgYZDr8iyqjh7w6gb0meyY=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=aYc1mDh8PRtrUIEZIZAn34HIDLXjfJ9PwfZ85IU07vQ2iNtviLWOu0yHLUTLs6pWv
         dmwwQYMs5ythH9OEC5Fl1xsaM2saMoVCMJuFf6yFg/pprpTyoDJ3yfM+WWnp/2zORQ
         tPLbQaGdnl1Bp3ObsDvzGugWksFiO3tol0gH67ObSqdJK3OjngK/mySKgFhQuiXdOc
         VBpXhkunM1l1C7KIQnYtvEzrX1Tr0tU9jQUOpO2xcUN9WlcZV24wnJ14HFEC8tSH39
         cq/YCrBdnDw/vyW3Avhe8d8ULewaRvVunrZtEwbtQaKcTPcwN949L2eeSX4vKP1KG5
         f6O4RHMA+ChFw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 13 Jul 2023 02:12:07 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 02:11:47 +0300
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
Subject: [PATCH v6 0/6] meson saradc: add iio channels to read channel 7 mux inputs
Date:   Thu, 13 Jul 2023 02:10:41 +0300
Message-ID: <20230712231157.261245-1-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178587 [Jul 12 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 521 521 0c3391dd6036774f2e1052158c81e48587b96e95, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;sberdevices.ru:7.1.1,5.0.1;www.spinics.net:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/07/12 21:25:00
X-KSMG-LinksScanning: Clean, bases: 2023/07/12 20:30:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/12 10:49:00 #21602221
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

Changelog:

v1->v2:
split refactoring patch [1] into 4 smaller patches, fix comment style

[1] https://lore.kernel.org/lkml/20230621062715.455652-2-gnstark@sberdevices.ru/

v2->v3:
remove patch 'meson saradc: unite iio channel array definitions' [1] after discussion

patch 'meson saradc: add enum for iio channel array indexes'
  - change enum items prefix from INDEX_ to NUM_ since name 'channel index' is
  more relevant to channel array index in iio world and with 2 tables our array index is
  not always equal to channel number
  - resolve conflicts after deleting [1]
  - update commit message, previous patch [2]
  - return channel number for temp channel. It wasn't used and isn't used currently
  but may need later

patch meson saradc: support reading from channel 7 mux inputs
  - resolve conflicts after deleting [1]
  - update commit message, previous patch [3]
  - add routine find_channel_by_num to get channel by channel number

[1] https://lore.kernel.org/lkml/20230623022334.791026-4-gnstark@sberdevices.ru/
[2] https://lore.kernel.org/lkml/20230623022334.791026-5-gnstark@sberdevices.ru/
[3] https://lore.kernel.org/lkml/20230623022334.791026-7-gnstark@sberdevices.ru/

v3->v4:
add new patch 'iio: adc: meson: remove unused timestamp channel' [1]

patch 'iio: adc: meson: move enums declaration before'
	update commit message, previous patch [2]
patch 'iio: adc: meson: move meson_sar_adc_set_chan7_mux'
	update commit message, previous patch [3]
patch 'iio: adc: meson: add enum for iio channel numbers'
	update commit message, previous patch [4]
patch 'iio: adc: meson: add channel labels'
	update commit message, previous patch [5]
	change sprintf(label, "%s\n", "temp-sensor") to sprintf(label, "temp-sensor\n")
patch 'iio: adc: meson: support reading from channel 7 mux'
	rewrite enum meson_sar_adc_chan7_mux_sel definition and
		read_label routine proposed by Andy [7], previous patch [6]

[1] https://lore.kernel.org/lkml/20230705160413.000062e7@Huawei.com/
[2] https://lore.kernel.org/lkml/20230627224017.1724097-2-gnstark@sberdevices.ru/
[3] https://lore.kernel.org/lkml/20230627224017.1724097-3-gnstark@sberdevices.ru/
[4] https://lore.kernel.org/lkml/20230627224017.1724097-4-gnstark@sberdevices.ru/
[5] https://lore.kernel.org/lkml/20230627224017.1724097-5-gnstark@sberdevices.ru/
[6] https://lore.kernel.org/lkml/20230627224017.1724097-6-gnstark@sberdevices.ru/
[7] https://lore.kernel.org/lkml/ZJwGCNA+ZURri24i@smile.fi.intel.com/

v4->v5:
patch 'iio: adc: meson: move enums declaration before variables declaration'
	update commit message, previous patch [1]
patch 'iio: adc: meson: move meson_sar_adc_set_chan7_mux routine upper'
	update commit message, previous patch [2]
patch 'iio: adc: meson: add channel labels'
	update commit message, previous patch [3]
patch 'iio: adc: meson: support reading from channel 7 mux inputs'
	update commit message, previous patch [4]

[1] https://lore.kernel.org/lkml/20230707153322.114302-3-gnstark@sberdevices.ru/
[2] https://www.spinics.net/lists/linux-iio/msg80226.html
[3] https://www.spinics.net/lists/linux-iio/msg80227.html
[4] https://www.spinics.net/lists/linux-iio/msg80230.html

v5->v6:
patch 'iio: adc: meson: move enums declaration before variables declaration'
	update commit message, previous patch [1]
patch 'iio: adc: meson: support reading from channel 7 mux inputs'
	update commit message, previous patch [2]
[1] https://www.spinics.net/lists/linux-iio/msg80315.html
[2] https://www.spinics.net/lists/linux-iio/msg80314.html

George Stark (6):
  iio: adc: meson: remove unused timestamp channel
  iio: adc: meson: move enums declaration before variables declaration
  iio: adc: meson: move meson_sar_adc_set_chan7_mux routine upper
  iio: adc: meson: add enum for iio channel numbers
  iio: adc: meson: add channel labels
  iio: adc: meson: support reading from channel 7 mux inputs

 drivers/iio/adc/meson_saradc.c | 173 +++++++++++++++++++++++++--------
 1 file changed, 134 insertions(+), 39 deletions(-)

-- 
2.38.4

