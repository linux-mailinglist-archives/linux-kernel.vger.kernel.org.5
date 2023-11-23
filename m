Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF3C7F5906
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344352AbjKWHT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjKWHT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:19:57 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44865E7;
        Wed, 22 Nov 2023 23:20:01 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id F3C7D120069;
        Thu, 23 Nov 2023 10:19:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru F3C7D120069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1700723998;
        bh=lZF9371oFwWHYclBtgIos+B4yi9eiNAnR9wB8hzCp2Y=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=j0R1+coT6RwtVmEQ3JuUoAtNtwg94Qu3dV9y4OhXC3gmCvOVxw6UaFeLEIqQ/xUOB
         uoxORQsiuW8AQgq4iOaDwm4wqU8QgEepDzmKxq9lE9DROtAKFiwSZH7jMBjwV++dR0
         3rBhQLXRJSAhxgUDba7Of6C1P0O/V97/Zssezj4vtXMR/zObBEEF1jcf4WIgnMGpKO
         d8jXsS/DXNisgI46uxFPL/IBmp/NqdQaw1nYTImFocDpmQUpU9gu3mUjpeYT1mqu9A
         GMCOtHivhxEeXZj4a387ghj/ef+mtnSIAdXH6XNzCOkFe7OLZvJ//zk7cYvsWS/6jV
         r+Hb0WJuX/RXg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 23 Nov 2023 10:19:57 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 23 Nov 2023 10:19:56 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <muchun.song@linux.dev>, <akpm@linux-foundation.org>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v3 0/3] samples: introduce cgroup events listeners
Date:   Thu, 23 Nov 2023 10:19:42 +0300
Message-ID: <20231123071945.25811-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181550 [Nov 23 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;lore.kernel.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/11/23 06:48:00
X-KSMG-LinksScanning: Clean, bases: 2023/11/23 06:48:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/23 04:50:00 #22507336
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

To begin with, this patch series relocates the cgroup example code to
the samples/cgroup directory, which is the appropriate location for such
code snippets.

Furthermore, a new memcg events listener is introduced. This
listener is a simple yet effective tool for monitoring memory events and
managing counter changes during runtime.

Additionally, as per Andrew Morton's suggestion, a helpful reminder
comment is included in the memcontrol implementation. This comment
serves to ensure that the samples code is updated whenever new events
are added.

Changes v3 since v2 at [2]:
    - rename cgroup_v2_event_listener to memcg_event_listener per
      Andrew's suggestion

Changes v2 since v1 at [1]:
    - create new samples subdir - cgroup
    - move cgroup_event_listener for cgroup v1 to samples/cgroup
    - add a reminder comment to memcontrol implementation

Links:
    [1] - https://lore.kernel.org/all/20231013184107.28734-1-ddrokosov@salutedevices.com/
    [2] - https://lore.kernel.org/all/20231110082045.19407-1-ddrokosov@salutedevices.com/

Dmitry Rokosov (3):
  samples: introduce new samples subdir for cgroup
  samples/cgroup: introduce memcg memory.events listener
  mm: memcg: add reminder comment for the memcg v2 events

 MAINTAINERS                                   |   1 +
 mm/memcontrol.c                               |   4 +
 samples/Kconfig                               |   6 +
 samples/Makefile                              |   1 +
 samples/cgroup/Makefile                       |   5 +
 .../cgroup/cgroup_event_listener.c            |   0
 samples/cgroup/memcg_event_listener.c         | 330 ++++++++++++++++++
 tools/cgroup/Makefile                         |  11 -
 8 files changed, 347 insertions(+), 11 deletions(-)
 create mode 100644 samples/cgroup/Makefile
 rename {tools => samples}/cgroup/cgroup_event_listener.c (100%)
 create mode 100644 samples/cgroup/memcg_event_listener.c
 delete mode 100644 tools/cgroup/Makefile

-- 
2.36.0

