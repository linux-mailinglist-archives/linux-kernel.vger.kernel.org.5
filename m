Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAE475485F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 13:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjGOLHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 07:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjGOLHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 07:07:10 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCD135AA;
        Sat, 15 Jul 2023 04:07:06 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id D7A1F100005;
        Sat, 15 Jul 2023 14:07:02 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D7A1F100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689419222;
        bh=DW++SCgcxwIjmRUMsxVsWA8vee4FRUorFqSKgGAnm5g=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=RAVAdQgyO96POnt/ovs5pN3Xx70UA5jxwWI3bLfn0GJagZ2V+jz1cCwKl4JSgehtI
         8FVflHNL3jRqS7UCpiMgOz4A3cQMPE9kNTw2CiK+M5IXNpAJToy8OoPAPzra6iZVvg
         amGSIA/W2rout6hgBVUg+Rkem85+SHODE8rmpAQiS2WfOwM+xrrIQUHkM5vkM8QHv3
         y1HtjPAKAa4KZETc2wDrFBm0sxJpw2LCEAEXa62nUNtKL1SckxwdaJVAzP31zXtyyq
         eh3O/2+brGdKVulnH08pAbZzKkVcOf3q6gc8gRLfUgFAO5HlOl4ONdw409pLXAvsj3
         3dRWRVjLolMtg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Sat, 15 Jul 2023 14:07:02 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 15 Jul 2023 14:06:22 +0300
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
Subject: [PATCH v1 0/3] iio: adc: meson: tune init sequence
Date:   Sat, 15 Jul 2023 14:05:57 +0300
Message-ID: <20230715110654.6035-1-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178635 [Jul 15 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 523 523 523027ce26ed1d9067f7a52a4756a876e54db27c, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/15 07:52:00 #21618415
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

Information was taken from vendor kernel 5.4, 4.19 and vendor uboot 2019.
Most of the bits are undocumented at all or it's not said how they affect measuring.

All those bits are already initialized in bl* code and since kernel driver dosn't
rewrite or reset any registers but only changes some bits at init stage everything
works fine.

Test procedure is rather simple - one can change those bits in runtime
(e.g. using devmem) and try to read channels (cat /sys/bus/platform/drivers/meson-saradc/.../iio:device0/*)
changing some of those bits leads to measure procedure errors or abnormal results.
Another test is build meson saradc as module, reset adc by reset bit, reload module
and compare measure results to those got before reset.

George Stark (3):
  iio: adc: meson: init channels 0,1 input muxes
  iio: adc: meson: init internal continuous ring counter
  iio: adc: meson: init voltage control bits

 drivers/iio/adc/meson_saradc.c | 73 ++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

-- 
2.38.4

