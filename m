Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A27C7EB906
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjKNV5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbjKNV5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:57:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B93E3;
        Tue, 14 Nov 2023 13:57:14 -0800 (PST)
Date:   Tue, 14 Nov 2023 21:57:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699999033;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZyNm6zjsHnLhgpddgvEBkRYkAW72R/W124on/N7HXhQ=;
        b=RXqACAOycE+0B7DF0wNmMg1GIBxrOKNSMruSmAtkxpoiLhimNsrHVBqMwQ4GKqL98nCfYu
        ZYaf2QxRi5EF7nhZwWfKIwJhASh2pTL328aqQXCzS8Q86Dd0lQd/vQuRqv3tqE+KOQssO7
        oZed/4x6E11Jf6tSef2htk27w07W9prVy5hZnfoG3loHIV+7xuYOdxxPiy3SWr3OYMn03v
        u04z9z8kHnaKtbrV1FiXrVY9ejQDdWrhrV/o9ypUL3LJshFNbnI4IcWrezKHieCt0upRTy
        yyKqx0wvmZhjO+qwJk0PemSO2DLPKLtPOB5XwDLEAmgBiVWZnm5w0EHxc+Kjlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699999033;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZyNm6zjsHnLhgpddgvEBkRYkAW72R/W124on/N7HXhQ=;
        b=2A+xYwJBgsmiTPqhY0xQDQLlo59Vo7phk2vpAAyUlTIWmriAAoikwD+lOcSvARC+RB6/Gu
        RW7nCU7NM5w+k0DQ==
From:   "tip-bot2 for Johannes Weiner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: psi: fix unprivileged polling against cgroups
Cc:     Luca Boccassi <bluca@debian.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org,
        #@tip-bot2.tec.linutronix.de, 6.5+@tip-bot2.tec.linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231026164114.2488682-1-hannes@cmpxchg.org>
References: <20231026164114.2488682-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Message-ID: <169999903275.391.5317186908629148143.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     8b39d20eceeda6c4eb23df1497f9ed2fffdc8f69
Gitweb:        https://git.kernel.org/tip/8b39d20eceeda6c4eb23df1497f9ed2fffdc8f69
Author:        Johannes Weiner <hannes@cmpxchg.org>
AuthorDate:    Thu, 26 Oct 2023 12:41:14 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 14 Nov 2023 22:27:00 +01:00

sched: psi: fix unprivileged polling against cgroups

519fabc7aaba ("psi: remove 500ms min window size limitation for
triggers") breaks unprivileged psi polling on cgroups.

Historically, we had a privilege check for polling in the open() of a
pressure file in /proc, but were erroneously missing it for the open()
of cgroup pressure files.

When unprivileged polling was introduced in d82caa273565 ("sched/psi:
Allow unprivileged polling of N*2s period"), it needed to filter
privileges depending on the exact polling parameters, and as such
moved the CAP_SYS_RESOURCE check from the proc open() callback to
psi_trigger_create(). Both the proc files as well as cgroup files go
through this during write(). This implicitly added the missing check
for privileges required for HT polling for cgroups.

When 519fabc7aaba ("psi: remove 500ms min window size limitation for
triggers") followed right after to remove further restrictions on the
RT polling window, it incorrectly assumed the cgroup privilege check
was still missing and added it to the cgroup open(), mirroring what we
used to do for proc files in the past.

As a result, unprivileged poll requests that would be supported now
get rejected when opening the cgroup pressure file for writing.

Remove the cgroup open() check. psi_trigger_create() handles it.

Fixes: 519fabc7aaba ("psi: remove 500ms min window size limitation for triggers")
Reported-by: Luca Boccassi <bluca@debian.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Luca Boccassi <bluca@debian.org>
Acked-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org # 6.5+
Link: https://lore.kernel.org/r/20231026164114.2488682-1-hannes@cmpxchg.org
---
 kernel/cgroup/cgroup.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1d5b9de..4b9ff41 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3885,14 +3885,6 @@ static __poll_t cgroup_pressure_poll(struct kernfs_open_file *of,
 	return psi_trigger_poll(&ctx->psi.trigger, of->file, pt);
 }
 
-static int cgroup_pressure_open(struct kernfs_open_file *of)
-{
-	if (of->file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RESOURCE))
-		return -EPERM;
-
-	return 0;
-}
-
 static void cgroup_pressure_release(struct kernfs_open_file *of)
 {
 	struct cgroup_file_ctx *ctx = of->priv;
@@ -5299,7 +5291,6 @@ static struct cftype cgroup_psi_files[] = {
 	{
 		.name = "io.pressure",
 		.file_offset = offsetof(struct cgroup, psi_files[PSI_IO]),
-		.open = cgroup_pressure_open,
 		.seq_show = cgroup_io_pressure_show,
 		.write = cgroup_io_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5308,7 +5299,6 @@ static struct cftype cgroup_psi_files[] = {
 	{
 		.name = "memory.pressure",
 		.file_offset = offsetof(struct cgroup, psi_files[PSI_MEM]),
-		.open = cgroup_pressure_open,
 		.seq_show = cgroup_memory_pressure_show,
 		.write = cgroup_memory_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5317,7 +5307,6 @@ static struct cftype cgroup_psi_files[] = {
 	{
 		.name = "cpu.pressure",
 		.file_offset = offsetof(struct cgroup, psi_files[PSI_CPU]),
-		.open = cgroup_pressure_open,
 		.seq_show = cgroup_cpu_pressure_show,
 		.write = cgroup_cpu_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5327,7 +5316,6 @@ static struct cftype cgroup_psi_files[] = {
 	{
 		.name = "irq.pressure",
 		.file_offset = offsetof(struct cgroup, psi_files[PSI_IRQ]),
-		.open = cgroup_pressure_open,
 		.seq_show = cgroup_irq_pressure_show,
 		.write = cgroup_irq_pressure_write,
 		.poll = cgroup_pressure_poll,
