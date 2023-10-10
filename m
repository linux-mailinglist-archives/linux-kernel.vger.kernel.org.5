Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AB87BF135
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441936AbjJJDGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378482AbjJJDGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:06:13 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAE993
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 20:06:10 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4S4LQ66L5tz4xVbp;
        Tue, 10 Oct 2023 11:06:06 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl1.zte.com.cn with SMTP id 39A35vK4078952;
        Tue, 10 Oct 2023 11:05:57 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 10 Oct 2023 11:05:59 +0800 (CST)
Date:   Tue, 10 Oct 2023 11:05:59 +0800 (CST)
X-Zmail-TransId: 2b056524bf971e2-8eea1
X-Mailer: Zmail v1.0
Message-ID: <202310101105590891853@zte.com.cn>
In-Reply-To: <CAJuCfpFabCn8gcuLV322RKC=xzVm0C+64HQP+CkFNJZ4VO42ZA@mail.gmail.com>
References: ZSPayGSz6HQBp+3W@gmail.com,202310092030430136422@zte.com.cn,ZSP3cuEsgwWcIKRw@gmail.com,CAJuCfpFabCn8gcuLV322RKC=xzVm0C+64HQP+CkFNJZ4VO42ZA@mail.gmail.com
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <surenb@google.com>, <mingo@kernel.org>, <peterz@infradead.org>,
        <hannes@cmpxchg.org>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <juri.lelli@redhat.com>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjIgMC80XSBzY2hlZC9wc2k6IE9wdGltaXplIHRoZSBwcm9jZXNzIG9mIHVwZGF0aW5nIHRyaWdnZXJzIGFuZCBydHBvbGxfdG90YWw=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 39A35vK4078952
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6524BF9E.000/4S4LQ66L5tz4xVbp
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

When psimon wakes up and there are no state changes for rtpoll_states,
it's unnecessary to update triggers and rtpoll_total because the pressures
being monitored by user have not changed. This will help to slightly reduce
unnecessary computations of psi.

There are also some minor related optimizations, please see below.

Update_triggers() always return now + group->rtpoll_min_period, and the
return value is only used by psi_rtpoll_work(), so change update_triggers()
to a void function, let group->rtpoll_next_update = now +
group->rtpoll_min_period directly.

Update group->rtpoll_next_update after called update_triggers() and
update rtpoll_total. This will prevent bugs if update_triggers() uses
group->rtpoll_next_update in the future, and it makes more sense
to set the next update time after we finished the current update.

The parameter update_total in update_triggers() is useless now. Since if
changed_states & group->rtpoll_states is true, new_stall in update_triggers()
will be true, then update_total should also be true. We have no need for
update_total to help judgment whether to update rtpoll_total, so delete
update_total.

Change log
----------
v1->v2:
----------
(1) the line number of group->rtpoll_next_update in patch 1 remain unchanged
(2) split patch 3 from patch 2

Yang Yang (4):
  sched/psi: Change update_triggers() to a void function
  sched/psi: Avoid update triggers and rtpoll_total when it is unnecessary
  sched/psi: Update rtpoll_next_update after update triggers and rtpoll_total
  sched/psi: Delete the function parameter update_total of update_triggers()

 kernel/sched/psi.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

-- 
2.25.1
