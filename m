Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72EB7539B3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjGNLkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbjGNLk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:40:26 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3083530FA;
        Fri, 14 Jul 2023 04:40:23 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 8A6C9100009;
        Fri, 14 Jul 2023 14:40:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8A6C9100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689334819;
        bh=eu8/qlieVAdLMy2mRVFcsfWVK/cHJOdzyxcUfVIBZpw=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=rmNlqtFM4WPMziN4PntsI21alPkv/F61V2CRL9GplDicgKlc6i1yq0pVtDgRoQ/z7
         bT9+6VCEcb98Kz5+xsDYN7WzZiRDHSuJcKg5LpKdwxUYaaMd30P5mMD8+8Lkdyu305
         RZ3QSKn9nVz2WpxQQZy5JidNFmgLcs6Z9Q9MHPre6GCpYMKjnfQzMaxFTrAT5ShMqF
         bXj8onpsudfvEsRsMnB/D9vWVKUJ2g7QAGr5mGcqWYYllPV3tsGqS+Zn8pB42aHqjT
         zcDKvkMDKn5JmDKRKyaj93BmGAlblYFp+Wt9iI25S7fwzuyerOseSlo4iMVIAKiLDC
         TNIffb/zXSKmw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 14 Jul 2023 14:40:19 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 14 Jul 2023 14:39:47 +0300
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
Subject: [PATCH v7 0/6] meson saradc: add iio channels to read channel 7 mux inputs
Date:   Fri, 14 Jul 2023 14:37:47 +0300
Message-ID: <20230714114010.293440-1-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178622 [Jul 14 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 523 523 523027ce26ed1d9067f7a52a4756a876e54db27c, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;www.spinics.net:7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/07/14 02:56:00
X-KSMG-LinksScanning: Clean, bases: 2023/07/12 20:30:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/14 02:46:00 #21611850
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

v6->v7:
all patches:
	add tag Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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

