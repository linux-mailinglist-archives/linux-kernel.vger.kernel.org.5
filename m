Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF347E40CE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbjKGNqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjKGNpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:45:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE65719AD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:45:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E709C116B6;
        Tue,  7 Nov 2023 13:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699364714;
        bh=qwSXhaWEmixJwqWSMH3MjGwCx8gW/xJ5LMhTeY8N37c=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=cELQPunZr+QxIp/71qTIrYa6HCziailKodMK+NbHbf1iEXKlEjK8rvV1WrhF/NVaZ
         B7FDmbVz9dh5mdS4GA7RqBNhNQoId93tvOPevu3xSa5mrLzXUB8M1wWO/iMQ0AFfRs
         yYMf7mNeEIFVKSA/LKD3nh/KpXdzk/6ocAebbi4MQLXy5sSNCnd9yX197UePbA5CAL
         4pS2Xyh1d6ZUXwJ3p08s4j6uI2lTDGwesaYKo6BeB54bG4ciuekyCLLVtaBOTlMjy+
         KSADba/YAVCg2i45UCbNAmUHidcML0hd+mr4b/LPgTpp86t17UkVQoWDMZgS8YaRXC
         uM6nEawX/kXZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id E9D7BC4332F;
        Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Tue, 07 Nov 2023 14:45:10 +0100
Subject: [PATCH 10/10] bpf: Remove the now superfluous sentinel elements
 from ctl_table array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-10-e4ce1388dfa0@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=5yAM9vjgw7Y3iEKSRDwgsfEUNzgbP7A1qp4Iomp+9Rw=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlSj9nV+EKn4+sR2DS4tZ3BKgI/sF7yqN7tDACZ
 iMVXqJI5ymJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZUo/ZwAKCRC6l81St5ZB
 T2DXC/wP7wywT8y+9hh45MC6AtzUWy1pNcmg0ZDiAX+kO6B4AS676JoI8W97+2AvSIUss34djxy
 rXTIXEdlHOGk6i0aZDX9pBcNWDykFV5r5R3XwopCL9VrGzONl25nKRSZ7mfj41HCvESbEGCwAmc
 tP5ue7NQTJbLbEmJQyHM+4net9sagAvtYkjsh6OEGUV3xpP82MjMhJ0TcZTc9xMMcSlaUOJNJ9m
 dcZxctXezLOfwam0iIDt4A0sDsTM2MjQ/xbfKZhKwKKE7SEMpBojsAKoYNyVOqpjNzeafgIdy0O
 N3QUkJ/LLv29i2746+VnMD2ZxPBq3+tsENJ7QjIlGikLUXnDaHuGyBcSG2T2B7DAZX12/PSGZJ/
 o9MHPDKZVOC1nbOyq/3dE04DsNMS8L+xGH3N6LhH81/WgpltJn8x6WWg/tKVEwwiGFowLLQ3klm
 I8W9nWkU+DYbYhzF3k7D8C9HUxl9ZuZWOtgetfT2/BVOXK6Pe+7mUTx4Vrra6Pf+uDhBQ=
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

Remove sentinel element from bpf_syscall_table.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/bpf/syscall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index eb01c31ed591..1cb5b852b4e7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5679,7 +5679,6 @@ static struct ctl_table bpf_syscall_table[] = {
 		.mode		= 0644,
 		.proc_handler	= bpf_stats_handler,
 	},
-	{ }
 };
 
 static int __init bpf_syscall_sysctl_init(void)

-- 
2.30.2

