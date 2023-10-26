Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345DB7D86E1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345183AbjJZQlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjJZQlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:41:19 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7762F1A2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:41:16 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41cc776ccb4so8019781cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1698338475; x=1698943275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B/p+SmSABAsiAM1HGs7MlXdI15ooHjpFZ3RrRIcsztY=;
        b=UMQolasfAj6vnApYa7c8x4muGg29qTgZhhW1XMH5rohPN7q1qqH1YBQPbAU6ec6YTs
         F0b3Y96N0Ys/lvRcTdUcRYe9sZ3fGYvFezcibD4h2k7Bnpqr63VsBJe8UeGNzVApk2Ff
         ypVo3yuGgDqfNtnaNUHDb/S/HpW3lsMjJLJvvf1sonwU/YLw5DLlKjtGAGi6l7IIkV2O
         I3DMK/UC9yOED58xuCKdAKZZnNh8ga1miz63PSVnEnhCRQNANY0vOUjopLUN6vz/Otfu
         9jJrhuNCCDIqxrZkgpJIEQkauftdqArwOtHIcpWTkd72MrrCD5g7Rh7gt6NnwsqXW0+w
         xG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698338475; x=1698943275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/p+SmSABAsiAM1HGs7MlXdI15ooHjpFZ3RrRIcsztY=;
        b=VEHRzGG/Q98EEjgo9xECZMskoUCtgYOXq3Cg3794W8hw/KnDSEiUsqxtRx5vp+f9YW
         onvV3YfNgTQDKyXrKN0tfuShD+9hfClmAHJVPqGgRmmNnR+Zd3+IwgwRpmkqFrMQ9Jfa
         QxNhBfSaKOdgMViqFn0JX4KjTjTmuBrtfe/5XDlfA2SNvW/c5VGrYMazgKiwNGdhFnRi
         NYUJc28SM1Rm1DyHXNIR5HSZ4tURt7Fuuh/Lu0FDmhpd5I91BvybSOSyypOp0VxHIn5c
         2t+JcF1CcuHQhTSmKj9YCe0a0+p4kQV9+1J5iJDYz7CMatwQE/Lvk1vHwNiG7q/Up45g
         5jUw==
X-Gm-Message-State: AOJu0YxwAUr+0AXZBbR25nC0lpXpasTtWNkJ9wisqAEKOhIB6953/gAq
        aEdAOCvycE/KTfNA24CMNK3cNw==
X-Google-Smtp-Source: AGHT+IFcWjR27pVnVjEugb0ritH7C5+/+6wUabijlnw13id8uM99pLef8sfNC4GhyiaJPKOPWDmQVA==
X-Received: by 2002:a05:622a:287:b0:41c:b94a:98ac with SMTP id z7-20020a05622a028700b0041cb94a98acmr72026qtw.57.1698338475606;
        Thu, 26 Oct 2023 09:41:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:a294])
        by smtp.gmail.com with ESMTPSA id m24-20020ac86898000000b004108ce94882sm5114224qtq.83.2023.10.26.09.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:41:15 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Luca Boccassi <bluca@debian.org>
Subject: [PATCH] sched: psi: fix unprivileged polling against cgroups
Date:   Thu, 26 Oct 2023 12:41:14 -0400
Message-ID: <20231026164114.2488682-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: stable@vger.kernel.org # 6.5+
Reported-by: Luca Boccassi <bluca@debian.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/cgroup/cgroup.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f11488b18ceb..2069ee98da60 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3879,14 +3879,6 @@ static __poll_t cgroup_pressure_poll(struct kernfs_open_file *of,
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
@@ -5287,7 +5279,6 @@ static struct cftype cgroup_psi_files[] = {
 	{
 		.name = "io.pressure",
 		.file_offset = offsetof(struct cgroup, psi_files[PSI_IO]),
-		.open = cgroup_pressure_open,
 		.seq_show = cgroup_io_pressure_show,
 		.write = cgroup_io_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5296,7 +5287,6 @@ static struct cftype cgroup_psi_files[] = {
 	{
 		.name = "memory.pressure",
 		.file_offset = offsetof(struct cgroup, psi_files[PSI_MEM]),
-		.open = cgroup_pressure_open,
 		.seq_show = cgroup_memory_pressure_show,
 		.write = cgroup_memory_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5305,7 +5295,6 @@ static struct cftype cgroup_psi_files[] = {
 	{
 		.name = "cpu.pressure",
 		.file_offset = offsetof(struct cgroup, psi_files[PSI_CPU]),
-		.open = cgroup_pressure_open,
 		.seq_show = cgroup_cpu_pressure_show,
 		.write = cgroup_cpu_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5315,7 +5304,6 @@ static struct cftype cgroup_psi_files[] = {
 	{
 		.name = "irq.pressure",
 		.file_offset = offsetof(struct cgroup, psi_files[PSI_IRQ]),
-		.open = cgroup_pressure_open,
 		.seq_show = cgroup_irq_pressure_show,
 		.write = cgroup_irq_pressure_write,
 		.poll = cgroup_pressure_poll,
-- 
2.42.0

