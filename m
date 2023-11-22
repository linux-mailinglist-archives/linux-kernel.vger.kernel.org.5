Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6F17F430F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343737AbjKVKCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjKVKCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:02:13 -0500
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860C7D67;
        Wed, 22 Nov 2023 02:02:07 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 21E6C100070;
        Wed, 22 Nov 2023 13:02:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 21E6C100070
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1700647324;
        bh=n8qpJm5BdFlE5bE6a2wtkfW484J73eK792NGWVHcjvw=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=LZNLlc5d9qKjEtb+VsU665EYUwDs/n5OeqAI5+ODt0sf73nqsvqkGFz7vtiQSRjo4
         0PGNwFB4bsnRhe/wHP0zdxWIxV0bwKz3G/XgV319n90HqPnffUrfopDqHmVjbx8AKt
         CljJ1W10VAeGHeQmlzeSFouW5A+CLy9IFDCkswLC+m9isY+LCont5xGVIout7ZiQQr
         gc8XAxs2s/BRmiCBD3YFuKf1MUosK+R2X9TyIGTdWYMBx9liEbo6BjFKIEgc6bqziK
         596m37w1mVJ3RntolPcc0nyFnaIHDyzknlAJP2//2y45gZIopJDMsUStQi0uyUTcRa
         dp7q+D+dgnzcQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 22 Nov 2023 13:02:03 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 Nov 2023 13:02:03 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
        <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
        <shakeelb@google.com>, <muchun.song@linux.dev>,
        <akpm@linux-foundation.org>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v2 0/2] mm: memcg: improve vmscan tracepoints
Date:   Wed, 22 Nov 2023 13:01:54 +0300
Message-ID: <20231122100156.6568-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181524 [Nov 22 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/11/22 07:49:00
X-KSMG-LinksScanning: Clean, bases: 2023/11/22 05:56:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/22 05:48:00 #22499758
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The motivation behind this commit is to enhance the traceability and
understanding of memcg events. By integrating the function cgroup_name()
into the existing memcg tracepoints, this patch series introduces a new
tracepoint template for the begin() and end() events. It utilizes a
static __array() to store the cgroup name, enabling developers to easily
identify the cgroup associated with a specific memcg tracepoint event.

Additionally, this patch series introduces new shrink_memcg tracepoints
to facilitate non-direct memcg reclaim tracing and debugging.

Changes v2 since v1 at [1]:
    - change the position of the "memcg" parameter to ensure backward
      compatibility with userspace tools that use memcg tracepoints
    - add additional CONFIG_MEMCG ifdefs to prevent the use of memcg
      tracepoints when memcg is disabled

Links:
    [1] https://lore.kernel.org/all/20231101102837.25205-1-ddrokosov@salutedevices.com/

Dmitry Rokosov (2):
  mm: memcg: print out cgroup name in the memcg tracepoints
  mm: memcg: introduce new event to trace shrink_memcg

 include/trace/events/vmscan.h | 91 ++++++++++++++++++++++++++++++-----
 mm/vmscan.c                   | 21 ++++++--
 2 files changed, 95 insertions(+), 17 deletions(-)

-- 
2.36.0

