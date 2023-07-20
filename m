Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BF675AA1B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjGTI6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjGTIe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:34:28 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9BAFD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:34:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=kenan.liu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VnpHxio_1689842054;
Received: from iZbp125ew08a9bxe5bn4s4Z.localdomain(mailfrom:Kenan.Liu@linux.alibaba.com fp:SMTPD_---0VnpHxio_1689842054)
          by smtp.aliyun-inc.com;
          Thu, 20 Jul 2023 16:34:23 +0800
From:   "Kenan.Liu" <Kenan.Liu@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     luoben@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] Adjust CFS loadbalance to adapt QEMU CPU topology.
Date:   Thu, 20 Jul 2023 16:34:11 +0800
Message-Id: <1689842053-5291-1-git-send-email-Kenan.Liu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kenan.Liu" <Kenan.Liu@linux.alibaba.com>

Multithreading workloads in VM with Qemu may encounter an unexpected
phenomenon: one hyperthread of a physical core is busy while its sibling
is idle. Such as:

%Cpu0  : 19.8 us,  3.8 sy,  0.0 ni, 76.5 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu1  :  6.4 us,  1.0 sy,  0.0 ni, 92.6 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu2  : 15.8 us,  4.5 sy,  0.0 ni, 79.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu3  :  4.7 us,  0.7 sy,  0.0 ni, 94.6 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu4  : 15.5 us,  4.5 sy,  0.0 ni, 80.1 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu5  :  4.7 us,  0.7 sy,  0.0 ni, 94.6 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu6  : 13.4 us,  3.4 sy,  0.0 ni, 83.2 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu7  :  2.7 us,  0.3 sy,  0.0 ni, 97.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu8  : 16.1 us,  4.8 sy,  0.0 ni, 79.1 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu9  :  2.0 us,  0.3 sy,  0.0 ni, 97.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu10 : 17.5 us,  5.2 sy,  0.0 ni, 77.3 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu11 :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu12 : 17.6 us,  4.5 sy,  0.0 ni, 77.9 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu13 :  0.3 us,  0.0 sy,  0.0 ni, 99.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu14 : 16.1 us,  4.1 sy,  0.0 ni, 79.8 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
%Cpu15 :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st

The main reason is that hyperthread index is consecutive in qemu native x86 CPU
model which is different from the physical topology. As the current kernel scheduler
implementation, hyperthread with an even ID number will be picked up in a much
higher probability during load-balancing and load-deploying.

This RFC targets to solve the problem by adjusting CFS loabalance policy:
1. Explore CPU topology and adjust CFS loadbalance policy when we found machine
with qemu native CPU topology.
2. Export a procfs to control the traverse length when select idle cpu.

Kenan.Liu (2):
  sched/fair: Adjust CFS loadbalance for machine with qemu native CPU
    topology.
  sched/fair: Export a param to control the traverse len when select
    idle cpu.

 kernel/sched/fair.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 99 insertions(+), 4 deletions(-)

-- 
1.8.3.1

