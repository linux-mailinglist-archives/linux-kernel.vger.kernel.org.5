Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292457E40C9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjKGNq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjKGNpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:45:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D297B19A6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:45:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5E6EC116AF;
        Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699364713;
        bh=MEly15joX3iGPNe4Bqgq2fyROyUdrn2/gZnJBP4EApw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=Fxl0cKLNml8AzZg3nbyxZUINPRnwD9eHc/uU472w+YRwp3RIhHI7WifpQgV/3eJ+f
         8G1kJ+E/rmPKkdB8gj6hRuC3Pn9Y2IUA8Lyv0x4RcRSFEVKZNcN3PXD8LisIB1zJxP
         qqbrkrO+pCdvQhSId+wC1XboCtdIQfdnAmdVcclQv1ekOySKNNF3bJOxoO/BB0Pymc
         Q0M49xS4Epq7U92tZWGUAmLrxUupTGSkI3TRsvIG94Ax2Id84sMudbn4DYknPaCvdk
         /Fyn+3JGdwtjRWwC4z9oa7hbMt6LFStqwIIDYfPIe+00qoAJIwx633mwMPm7kXWyxn
         kWqnCFfcqCK1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id B194DC4332F;
        Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Tue, 07 Nov 2023 14:45:07 +0100
Subject: [PATCH 07/10] printk: Remove the now superfluous sentinel elements
 from ctl_table array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-7-e4ce1388dfa0@samsung.com>
References: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
In-Reply-To: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
        josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=873; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=4F7FfvA5YIYVfM3aTH/t6RzZ+sHqLku1lqY0e/c0V1o=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlSj9mSKxvYgMV+EZ9fAXhr9RqLxPpdn0SBoshU
 cESPw29PkqJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZUo/ZgAKCRC6l81St5ZB
 T5DFC/9BuvcmChEcZ6WGOaVO1nSJgybOZgQryx5Pjk1ep8Z8kkFbQOvz9rq5RAcFej2KwBaRNsP
 KmdFgK16LHM23jK1tneJG7PdCGtjZ1de1I/55cMWNQ7xR+D9eV0muryi36FGrL6kaDPk/giYWTo
 1ii/PseR44gfIGj1OPNHPdeqCRJEQX5bGOtqM0u0oZkX7qPjD3skvNlBVd/fZZVr53rl7kJqUkP
 qbi56CUNGIEjzRRQqszRHrgLtXd0DoExFlNIVwVu42kCYtGhUoXPeH+VZjVuao3QRsoWUy1u3FJ
 Qh5L/ryAR9bWATY4nBhZ92paw3gr6zYl9BKB13NxYUHMENYMwj4/Fqb+tVTGie9FS4drplN0DIy
 9w4GSs2m9PvIlpAgRMWVPgFNAT/+ca+Sk0FrwGKaaZDDg0UUGmyG6usqHs4MYK68kdn6/qkfwea
 LNg5nV/tvgW8pkqw3xhBTf6W10DHUHyw8OfXeh7VxJPm2tNKgw2lIzdkrExZWEZys6ytM=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which
will reduce the overall build time size of the kernel and run time
memory bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

rm sentinel element from printk_sysctls

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/printk/sysctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index c228343eeb97..3e47dedce9e5 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -76,7 +76,6 @@ static struct ctl_table printk_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
-	{}
 };
 
 void __init printk_sysctl_init(void)

-- 
2.30.2

