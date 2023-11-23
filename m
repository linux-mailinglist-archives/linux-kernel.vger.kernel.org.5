Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48497F67A8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjKWTjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKWTjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:39:44 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CB1D43;
        Thu, 23 Nov 2023 11:39:47 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 8B11F120010;
        Thu, 23 Nov 2023 22:39:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8B11F120010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1700768384;
        bh=3yNZRyHWMdnnlqHBz7P8oLgTMmMyWNxQ6iEoDg0G7sA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=dvmOZBOqdWu3rS3gcaqdktBkeo0jLcSQM3wfFcsJheGAJUxm0HNz0wSIXCHXTOUad
         TKQ3dh8V4f3rZTWvFyy1vdvwTLoxVhkhp/WclxT8me8cF3FaI/KTH9MR4UZtATL9K1
         lMzlk7woD6o6eokd/aev2ytEPBlbRcbkvEtG8YdMeWKBGCgQg5pLppUTLTV7NFIzN0
         XRX5PnCLeFobjS87/I2mw2Qm2t0W5MxgoI6rC8yyRGuH2CKNHd1pjQUAVHUWqosAgK
         X023mS6oDLWKitT8ii1dEaCKQAPD+36KbNMpbuKNDMm/85MZkvSGRxsxevd8Qmp5HG
         tuMp2LOngGJeg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 23 Nov 2023 22:39:44 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 23 Nov 2023 22:39:44 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
        <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
        <shakeelb@google.com>, <muchun.song@linux.dev>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v3 0/2] mm: memcg: improve vmscan tracepoints
Date:   Thu, 23 Nov 2023 22:39:35 +0300
Message-ID: <20231123193937.11628-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181569 [Nov 23 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 4 0.3.4 720d3c21819df9b72e78f051e300e232316d302a, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;lore.kernel.org:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/11/23 18:34:00
X-KSMG-LinksScanning: Clean, bases: 2023/11/23 18:34:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/23 17:02:00 #22509098
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

The motivation behind this commit is to enhance the traceability and
understanding of memcg events. By integrating the function cgroup_ino()
into the existing memcg tracepoints, this patch series introduces a new
tracepoint template for the begin() and end() events. It utilizes a new
entry field ino to store the cgroup ino, enabling developers to easily
identify the cgroup associated with a specific memcg tracepoint event.

Additionally, this patch series introduces new shrink_memcg tracepoints
to facilitate non-direct memcg reclaim tracing and debugging.

Changes v3 since v2 at [2]:
    - use cgroup_ino() instead of cgroup_name() for memcg tracepoints
      because cgroup_name() acquires a global rw_lock, which can
      potentially slow down the system
    - introduce a stub macro for each shrink_memcg tracepoint to avoid
      using ifdefs within the common vmscan code."

Changes v2 since v1 at [1]:
    - change the position of the "memcg" parameter to ensure backward
      compatibility with userspace tools that use memcg tracepoints
    - add additional CONFIG_MEMCG ifdefs to prevent the use of memcg
      tracepoints when memcg is disabled

Links:
    [1] https://lore.kernel.org/all/20231101102837.25205-1-ddrokosov@salutedevices.com/
    [2] https://lore.kernel.org/all/20231123071945.25811-1-ddrokosov@salutedevices.com/

Dmitry Rokosov (2):
  mm: memcg: print out cgroup ino in the memcg tracepoints
  mm: memcg: introduce new event to trace shrink_memcg

 include/trace/events/vmscan.h | 95 ++++++++++++++++++++++++++++++-----
 mm/vmscan.c                   | 17 +++++--
 2 files changed, 95 insertions(+), 17 deletions(-)

-- 
2.36.0

