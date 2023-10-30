Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563297DBF79
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjJ3R70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjJ3R7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:59:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A549E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1698688750; x=1699293550; i=rwahl@gmx.de;
        bh=3+BNL6SPLpvd3sFp0B7ZcppgnOAFJ+7gHr0yrWGG1aI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=neOoe66otHcmzzM6acCqvRxWxGmF0oT/XhDhGPjsxe2h/zPFbxplX3/Qcq6dmtSQ
         QOu2dvN5mBIDxAzXvY+uxxP+e1jbF3UFGWnKYtMbyTGdRFXZyGzbnJiwy03fuBqGV
         KPmdlFyBa5xf5moXAX8qlgRPq7qecXf3TrWrF0Ji0uM20XWkPrzX86Wm/Ok1fay/2
         7J8BdHMsA1O8cgcWAoXAmF21TnC4XBYO4RbbC+2Pvwk3x3mnDvh3dhDRmdr6+gHXN
         4fl72a3HhUaupWFRoasK4OL1JfuoF/xJH5GPQtpcA89MCOf2UxxuXbc/EAkK9o0y4
         0UXZzuguXwIEPScTlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.147.134]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiPl-1r2dJg3uNJ-00U4fP; Mon, 30
 Oct 2023 18:59:10 +0100
From:   Ronald Wahl <rwahl@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ronald Wahl <ronald.wahl@raritan.com>
Subject: [PATCH] stacktrace: check whether task has a stack before saving it
Date:   Mon, 30 Oct 2023 18:58:54 +0100
Message-ID: <20231030175854.12675-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RltZoYf5ZaBlnvVgjQzX8Ikmy3GKvfZMIJFvZb/XjSWJH3wKAlP
 AXUtW7Z4TjiiEtsmmf+Xd9Cgkc8iAwwW8A6cLpqfMqExih+Q4vwW3HzLoiq3Miie5QuMGcO
 FGOuu3jzF6WJmPzg7CXezeUlVS+laZzCsMWHwUhbK3NPf7nV7a9VYRB9zD7kQPD7q/eUqjh
 cdjlsLvd2hXzHep1P6WRQ==
UI-OutboundReport: notjunk:1;M01:P0:YEjjUHEUVd0=;Vtcz1+LlvhgPAujd56QVYFxiDKE
 9zCYaTddLdTvllLtXIBH/sgIljikXCwkcN33wgugqawCFvAmX2x8kJjN1ql/Ob9hCuye86TUJ
 lpdMsVQ8HIk20ZphrD4A50ABem4R8ZkLncjFIyw6KJ0arTT87pa4OQi8UvlNGuc+nOpSrCx2b
 QWngmRPOBagJLX/93qsglo9URrYviQpSe/w6Eu0eWsW4oJ61gfhL6d85PL/SDBWZhPuW6nI9w
 Z5omOmrdttutJNouYlrM/Ux6zFRA+GL5H140/pFQ2ML/JTmTG3zJaz59GAKUEliNnFuwLLBtX
 pFYzGRK6oVUGjjj/Qs3I8N81hJVEJSinWSbtXyNrTJcy2N9Tn7+gGIVuPU1ppSLnYeKVmsC8m
 q+n4ZTh66o7Nf80LeYKIpG8C9WabcwW9gA2T1XOhlgViaMnzVxmE//usbQeoE0VEXULqgLEWd
 siGnnvMgnN3Ow8MesqaIT9KHaYWyr4E12r99w8ElwhxmiNpqM7a+T/IPLerBnlVoCEpZZF7R2
 X1cvGnV5GcE+cYz5kb3IITSKVlU7wneHj2XsvMODXks2E4fQR15G5CZQwI/K5VwSBQTC+mBz7
 u5UBe7UkJ0/Ym4vLzyi7ro2GAE+xpWBOl5J8PrXDs6pVsNqawPyAc3w8Rl1nRFsvkrBsJOdXm
 UZR62l1BKPqXnQ6lGx20ApKJSgyX7XliNNHqho35LUUHrDy7wuj2aQ5DXF0Y/0/qyuHmR1JAN
 mADJpcr1VVfxUTRVcRoM4+33WFnvIRUNf3HiNWPSptHW9zDL9RA6X8RTjBEzOENQSLqZfO7sB
 6RH81bGjZsZdy1BlM8Qx6aDvrkgBEMmO+DZV9mJ+pKGRSr5qdaP1Z9Fl2H6yV+nuggygY3DuH
 n/LGGFDHMtV3cdw27nslUkOdcXvSIX1QW/PnpjykTWO1cRYTKnNJgpgvhPDMHAIbejSjxGWP9
 BUZDyw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I encountered a crash on ARM32 when trying to dump the stack of some
zombie process. This is caused by a missing check whether the task
actually has a valid stack. This commit adds this check.

Commit 214d8ca6ee85 ("stacktrace: Provide common infrastructure")
introduced this check for platforms that define CONFIG_ARCH_STACKWALK
but ARM32 is not one of them.

Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
=2D--
 kernel/stacktrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 9ed5ce989415..38ae52349306 100644
=2D-- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -298,6 +298,9 @@ unsigned int stack_trace_save_tsk(struct task_struct *=
task,
 		.skip	=3D skipnr + (current =3D=3D task),
 	};

+	if (!try_get_task_stack(task))
+		return 0;
+
 	save_stack_trace_tsk(task, &trace);
 	return trace.nr_entries;
 }
=2D-
2.41.0

