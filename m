Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8827BDB76
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346311AbjJIMUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346640AbjJIMUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:20:09 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF61CA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:19:14 -0700 (PDT)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4S3ykk1fcMz8XrRJ
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 20:19:10 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4S3ykb5bS6z4xVbr;
        Mon,  9 Oct 2023 20:19:03 +0800 (CST)
Received: from szxlzmapp05.zte.com.cn ([10.5.230.85])
        by mse-fl1.zte.com.cn with SMTP id 399CJ1NO046217;
        Mon, 9 Oct 2023 20:19:01 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 9 Oct 2023 20:19:05 +0800 (CST)
Date:   Mon, 9 Oct 2023 20:19:05 +0800 (CST)
X-Zmail-TransId: 2b046523efb95fa-35ade
X-Mailer: Zmail v1.0
Message-ID: <202310092019052043489@zte.com.cn>
In-Reply-To: <ZSPayGSz6HQBp+3W@gmail.com>
References: CAJuCfpHV+Tf+-YqdWFwQNAeQJU5aqOM56R2GzbehFaFQcHuxAg@mail.gmail.com,202310071421311735972@zte.com.cn,ZSPayGSz6HQBp+3W@gmail.com
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <mingo@kernel.org>, <surenb@google.com>, <peterz@infradead.org>
Cc:     <hannes@cmpxchg.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgMC8zXSBzY2hlZC9wc2k6IE9wdGltaXplIHRoZcKgcHJvY2VzcyBvZiB1cGRhdGluZyB0cmlnZ2VycyBhbmTCoHJ0cG9sbF90b3RhbA==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 399CJ1NO046217
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6523EFBE.000/4S3ykk1fcMz8XrRJ
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

The parameter update_total in update_triggers() is useless now. Since if
changed_states & group->rtpoll_states is true, new_stall in update_triggers()
will be true, then update_total should also be true. We have no need for
update_total to help judgment whether to update rtpoll_total, so delete
update_total.

Update_triggers() always return now + group->rtpoll_min_period, and the
return value is only used by psi_rtpoll_work(), so change update_triggers()
to a void function, let group->rtpoll_next_update = now +
group->rtpoll_min_period directly.

Yang Yang(3):
  sched/psi: Change update_triggers() to a void function
  sched/psi: Avoid update triggers and rtpoll_total when it is unnecessary
  sched/psi: Delete the function parameter update_total of update_triggers()

 kernel/sched/psi.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

-- 
2.25.1
