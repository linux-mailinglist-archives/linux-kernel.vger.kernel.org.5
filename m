Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829CB7567B4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjGQPWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjGQPWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:22:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C38E7F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:21:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85E526111D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEA2C433C8;
        Mon, 17 Jul 2023 15:21:41 +0000 (UTC)
Date:   Mon, 17 Jul 2023 11:21:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     <kkabe@vega.pgw.jp>
Cc:     regressions@lists.linux.dev, bagasdotme@gmail.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: radeon.ko/i586: BUG: kernel NULL pointer
 dereference,address:00000004
Message-ID: <20230717112138.1fd48cca@gandalf.local.home>
In-Reply-To: <230715113911.M0124687@vega.pgw.jp>
References: <20230714100019.6bf9b1ab@gandalf.local.home>
        <230715113911.M0124687@vega.pgw.jp>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jul 2023 11:39:11 +0900
<kkabe@vega.pgw.jp> wrote:


> Yes, this is puzzling. That's why I need other people's opinion on this.
> Does it matter the DUT is a slow machine (Pentium 120MHz)?
> 

Hmm, I wonder because the workqueue is running __init functions, could it
possibly be that it didn't finish before the end of boot, where it frees
all the functions? It shouldn't do that because there's code to make sure
it's done before it continues further.

But just in case something isn't working as planned, you could try this
patch to see if the bug goes away.

-- Steve

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 05c0024815bf..af5a40ef3be4 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3771,13 +3771,13 @@ static int test_for_valid_rec(struct dyn_ftrace *rec)
 	return 1;
 }
 
-static struct workqueue_struct *ftrace_check_wq __initdata;
-static struct work_struct ftrace_check_work __initdata;
+static struct workqueue_struct *ftrace_check_wq;
+static struct work_struct ftrace_check_work;
 
 /*
  * Scan all the mcount/fentry entries to make sure they are valid.
  */
-static __init void ftrace_check_work_func(struct work_struct *work)
+static void ftrace_check_work_func(struct work_struct *work)
 {
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
