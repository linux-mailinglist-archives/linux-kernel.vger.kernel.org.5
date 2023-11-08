Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424D27E5693
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344524AbjKHM5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjKHM5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:57:03 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276211BF3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 04:57:01 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 24A0A120005;
        Wed,  8 Nov 2023 15:56:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 24A0A120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1699448219;
        bh=o3HN9w6B5G0SK9zVHy0ukaxr6aC9dqXoqv66Yn0Zd9M=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=DdqjDPh8qW8V14JgGwGL/HvMuY+T+kFXf/EYR91Btj4Q/P9WbejwgzshPuvYvjZHM
         sYGp7grnbNQY4Tko58HVM43Qjso+cGCNnj1mqGy0RzseaAiwA7vzb+Gk43ALEu5bqc
         /HxD9+z6IucoPa3x2QB781ao9GVq4qO0X8UtLNgac1ABArq/7FP6TMqbBHuSKlm+7D
         OWOVTQHWVYH5XPOn2IIDDP9mENqeMjmiCPNAkDeD2Gi9vAhGVGZJZvMCEBb2Qb3khi
         De77qVz09nGFcjIh0G/eNV2wH5vSasEt4v+9zizfhEXtWKXq5YcDQxgpMbVX1Bdcod
         rmxez/vr1KAxQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  8 Nov 2023 15:56:58 +0300 (MSK)
Received: from pc (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 8 Nov
 2023 15:56:57 +0300
From:   Evgeny Bachinin <EABachinin@salutedevices.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Evgeny Bachinin <EABachinin@salutedevices.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Miles Chen <miles.chen@mediatek.com>,
        Alexey Romanov <avromanov@salutedevices.com>
CC:     <kernel@sberdevices.ru>, <evgen89bachinin@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] firmware: meson_sm: cleanup error paths inside probe()
Date:   Wed, 8 Nov 2023 15:56:02 +0300
Message-ID: <20231108125604.162383-1-EABachinin@salutedevices.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181206 [Nov 08 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: eabachinin@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/08 12:09:00 #22428609
X-KSMG-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At first, patches series refactors sysfs node creation to avoid extra code
paths. After that, the resource leak in probe error path is fixed.

Evgeny Bachinin (2):
  firmware: meson_sm: refactor serial sysfs entry via dev_groups attrs
  firmware: meson-sm: unmap out_base shmem in error path

 drivers/firmware/meson/meson_sm.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

-- 
2.34.1

