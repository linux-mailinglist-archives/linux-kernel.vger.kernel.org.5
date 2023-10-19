Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4EE7CF172
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344889AbjJSHjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344874AbjJSHix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:38:53 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D36418A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:38:50 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 90779120009;
        Thu, 19 Oct 2023 10:38:47 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 90779120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1697701127;
        bh=qHjagzBNZKS0ba9ZInkR/Ivhhk92bbpsh29/iG18+hQ=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=XxpYGcDJc+HSvMqApotEG9nODqofEAVEDU0s/+s+2xDHnTt+0yuAUJAb9NvbGZJAo
         YNteXy8I1h3cJNE5/V1CkhHivhC7nXjYD/lf52rreWoLhlCGCtBUS26E+oGRBfDE2m
         azqe5fa68YAQri5RVa//rVlaEJSlSQi9SMKmbKVeOig1QsX+uCxkRdqj8z0M3rZBp9
         SW7CE12j1DwfXxiUi02zUKZR9xAHzlB8kwmmTT66k3vXfHh3+hvwz3FDZ48KKrkd7s
         l5hrIgd+sISkBUCnjetWHDWZVU90jPKfN3qWtLMf+UrkENNiUScXinrHswanMsNvOb
         tkkx2MYkdZ0qQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 19 Oct 2023 10:38:47 +0300 (MSK)
Received: from CAB-WSD-0004828.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 19 Oct 2023 10:38:47 +0300
From:   Martin Kurbanov <mmkurbanov@salutedevices.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, Yu Zhe <yuzhe@nfschina.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@salutedevices.com>
Subject: [PATCH v1 0/2] jffs2: make cleanmarker support option
Date:   Thu, 19 Oct 2023 10:38:36 +0300
Message-ID: <20231019073838.17586-1-mmkurbanov@salutedevices.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180720 [Oct 19 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 541 541 6f62a06a82e8ec968d29b8e7c7bba6aeceb34f57, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/19 05:18:00 #22229383
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset support for disable cleanmarker option. This is useful on
some NAND devices which entire OOB area is protected by ECC. Problem
fires when JFFS2 driver writes cleanmarker to some page and later it
tries to write to this page - write will be done successfully, but after
that such page becomes unreadable due to invalid ECC codes. This occurs
because the second write necessitates an update to ECC, but it is
impossible to do it correctly without block erase.

Martin Kurbanov (2):
  jffs2: introduce jffs2_nandflash()
  jffs2: make cleanmarker support option

 fs/jffs2/Kconfig    | 10 ++++++++++
 fs/jffs2/erase.c    |  2 +-
 fs/jffs2/fs.c       |  4 ++--
 fs/jffs2/os-linux.h |  7 ++++++-
 fs/jffs2/scan.c     |  2 +-
 5 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.40.0

