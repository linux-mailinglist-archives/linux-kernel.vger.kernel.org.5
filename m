Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ADC767FCE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjG2N4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjG2Nz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:55:56 -0400
X-Greylist: delayed 135 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 29 Jul 2023 06:55:52 PDT
Received: from p3plsmtpa08-03.prod.phx3.secureserver.net (p3plsmtpa08-03.prod.phx3.secureserver.net [173.201.193.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8AA1FE7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 06:55:51 -0700 (PDT)
Received: from localhost ([82.27.99.45])
        by :SMTPAUTH: with ESMTPA
        id PkNyqM7LIgssUPkO0q93dq; Sat, 29 Jul 2023 06:53:36 -0700
X-CMAE-Analysis: v=2.4 cv=XoY8e3J9 c=1 sm=1 tr=0 ts=64c519e0
 a=YwMIiW7BGddQzL8MrqPWMg==:117 a=YwMIiW7BGddQzL8MrqPWMg==:17
 a=Qe_DDWJ2S8ZzKdoxMNcA:9
X-SECURESERVER-ACCT: atomlin@atomlin.com
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     linux-kernel@vger.kernel.org
Cc:     tj@kernel.org, jiangshanlai@gmail.com, peterz@infradead.org
Subject: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Date:   Sat, 29 Jul 2023 14:53:32 +0100
Message-Id: <20230729135334.566138-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDm+ivhAG0siGQTlgWZ1nlzf+D2vp9U5BHNoR4ign5AtO7ygzgpr0Kj+Jq+BWNQ+RDj0fqB6LRpM0Eqaz55G37n+b/tU2V/lbJmSVFWagz8RscjdS5gf
 cWe+dbF5uKU+Non476fA6AHoiT1FqbOKj3ufRfnirk5UMvRFhSIC7mLBFOVbT+1tfKTrB6clDUSYj8DKi+RH2/VHi0bZVQt4StwBdVCjaFqDeAShb6E27Gqx
 ZaHGqvXV/v77Zx6M2dOlyZKYgYqwF8ZipH0Kf1QJhAc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux kernel does not provide a way to differentiate between a
kworker and a rescue kworker for user-mode.
From user-mode, one can establish if a task is a kworker by testing for
PF_WQ_WORKER in a specified task's flags bit mask (or bitmap) via
/proc/[PID]/stat. Indeed, one can examine /proc/[PID]/stack and search
for the function namely "rescuer_thread". This is only available to the
root user.

It can be useful to identify a rescue kworker since their CPU affinity
cannot be modified and their initial CPU assignment can be safely ignored.
Furthermore, a workqueue that was created with WQ_MEM_RECLAIM and
WQ_SYSFS the cpumask file is not applicable to the rescue kworker.
By design a rescue kworker should run anywhere.

This patch series introduces PF_WQ_RESCUE_WORKER and ensures it is set and
cleared appropriately and simplifies current_is_workqueue_rescuer().

Aaron Tomlin (2):
  workqueue: Introduce PF_WQ_RESCUE_WORKER
  workqueue: Simplify current_is_workqueue_rescuer()

 include/linux/sched.h |  2 +-
 kernel/workqueue.c    | 25 +++++++++++++++----------
 2 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.39.1

