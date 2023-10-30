Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DF17DB487
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjJ3HlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJ3HlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:41:15 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CCA0C4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:41:12 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-ac-653f5a7fb3a4
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Subject: [v3 3/3] mm, migrc: Add a sysctl knob to enable/disable MIGRC mechanism
Date:   Mon, 30 Oct 2023 16:25:40 +0900
Message-Id: <20231030072540.38631-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231030072540.38631-1-byungchul@sk.com>
References: <20231030072540.38631-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnoW59lH2qwc25chZz1q9hs/i84R+b
        xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHF910NGi+O9B5gs
        Nm+aymzx+wdQ3ZwpVhYnZ01mcRDw+N7ax+KxYFOpx+YVWh6L97xk8ti0qpPNY9OnSewe786d
        Y/c4MeM3i8fOh5Ye804Gerzfd5XNY+svO4/Pm+Q83s1/yxbAF8Vlk5Kak1mWWqRvl8CV8Wrt
        C5aCr7wVr5Z2MjUwzubuYuTkkBAwkTh2fxETjP1w8zE2EJtNQF3ixo2fzCC2iICZxMHWP+xd
        jFwczAIPmCTmvl3BCJIQFgiQOLl1PVgzi4CqxLL7m8GaeQVMJU72/WaEGCovsXrDAbBBnECD
        Ph/vAqsRAqrZ/v8wM8hQCYHPbBKXb31kgWiQlDi44gbLBEbeBYwMqxiFMvPKchMzc0z0Mirz
        Miv0kvNzNzECA39Z7Z/oHYyfLgQfYhTgYFTi4Q0It0sVYk0sK67MPcQowcGsJMLL7GiTKsSb
        klhZlVqUH19UmpNafIhRmoNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoFxWhWf79v4mAux
        nzYJNmzwyCkVTuU+Wbj6buSEFVf9jndtuz0r8nGbArvgwsQWs9MPej22sSyul1Yztrq8Zu52
        2TkyqxiFBc8pqvTdl7jqV3eY9U3rqk1T0yYmxMV4xF36barAadFxIbzU+irb2aAF88+UFBy5
        c4tJT75G/EAjX5SWxueA8ilKLMUZiYZazEXFiQDXhJNNeAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrFsfZZ9qsPkrn8Wc9WvYLD5v+Mdm
        8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4vquh4wW
        x3sPMFls3jSV2eL3D6C6OVOsLE7OmsziIOjxvbWPxWPBplKPzSu0PBbvecnksWlVJ5vHpk+T
        2D3enTvH7nFixm8Wj50PLT3mnQz0eL/vKpvH4hcfmDy2/rLz+LxJzuPd/LdsAfxRXDYpqTmZ
        ZalF+nYJXBmv1r5gKfjKW/FqaSdTA+Ns7i5GTg4JAROJh5uPsYHYbALqEjdu/GQGsUUEzCQO
        tv5h72Lk4mAWeMAkMfftCkaQhLBAgMTJreuZQGwWAVWJZfc3gzXzCphKnOz7zQgxVF5i9YYD
        YIM4gQZ9Pt4FViMEVLP9/2HmCYxcCxgZVjGKZOaV5SZm5pjqFWdnVOZlVugl5+duYgSG8bLa
        PxN3MH657H6IUYCDUYmHNyDcLlWINbGsuDL3EKMEB7OSCC+zo02qEG9KYmVValF+fFFpTmrx
        IUZpDhYlcV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUAyPnJ//QSlOprwy1co+/ntjRor53bUAf
        +92Sw9KL9p6ft1fkZVu/1Jtthw/u2/lNMPfbjbV9J39rcBvmP2ze+SD8d1/M3q7F0bPEdulM
        Orz2AttMmeA1WxjO/mho/p7nXrxKK4trubVL1Q/mQMmpMre3xhyd+NrZp9coa27UG13bsIQF
        7r9CBFcosRRnJBpqMRcVJwIA4xMH/F8CAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sysctl knob, '/proc/sys/vm/migrc_enable' to switch on/off migrc.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/migrate.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 76278eca8417..f6bbdc2d4fb1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -58,6 +58,48 @@
 #include "internal.h"
 
 #ifdef CONFIG_MIGRC
+static int sysctl_migrc_enable = 1;
+#ifdef CONFIG_SYSCTL
+static int sysctl_migrc_enable_handler(struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table t;
+	int err;
+	int enabled = sysctl_migrc_enable;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	t = *table;
+	t.data = &enabled;
+	err = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
+	if (err < 0)
+		return err;
+	if (write)
+		sysctl_migrc_enable = enabled;
+	return err;
+}
+
+static struct ctl_table migrc_sysctls[] = {
+	{
+		.procname	= "migrc_enable",
+		.data		= NULL, /* filled in by handler */
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_migrc_enable_handler,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
+	{}
+};
+
+static int __init migrc_sysctl_init(void)
+{
+	register_sysctl_init("vm", migrc_sysctls);
+	return 0;
+}
+late_initcall(migrc_sysctl_init);
+#endif
 
 atomic_t migrc_gen;
 
@@ -242,7 +284,7 @@ static inline bool migrc_stopped_pending(void)
 
 static bool can_migrc_system(void)
 {
-	return !migrc_stopped_pending();
+	return sysctl_migrc_enable && !migrc_stopped_pending();
 }
 #else
 static inline void migrc_mark_folios(struct folio *fsrc, struct folio *fdst) {}
-- 
2.17.1

