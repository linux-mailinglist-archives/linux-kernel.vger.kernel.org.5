Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83767B7ACE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjJDIzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjJDIzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:55:07 -0400
Received: from muru.com (unknown [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95657A6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:55:01 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 459A480BD;
        Wed,  4 Oct 2023 08:54:45 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] printk: Check valid console index for preferred console
Date:   Wed,  4 Oct 2023 11:54:33 +0300
Message-ID: <20231004085434.42570-1-tony@atomide.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_NONE,T_SPF_HELO_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's check for valid console index values.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 kernel/printk/printk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2410,6 +2410,10 @@ static int __add_preferred_console(char *name, int idx, char *options,
 	struct console_cmdline *c;
 	int i;
 
+	/* See struct console */
+	if (idx > SHRT_MAX)
+		return -EINVAL;
+
 	/*
 	 *	See if this tty is not yet registered, and
 	 *	if we have a slot free.
-- 
2.42.0
