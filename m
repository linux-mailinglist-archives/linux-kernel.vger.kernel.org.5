Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31107AC90C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjIXNYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjIXNXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:23:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8AD170A;
        Sun, 24 Sep 2023 06:21:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A802C433B7;
        Sun, 24 Sep 2023 13:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561661;
        bh=ZO2LodoczqZs61F4E2XaTs+zsj1/EX5byibDy/w65QI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hWjKVGwIMRUcqSW8AJqgMEy6coFSTAB80pwj57t/Dcp4fNG5U6y3QYc9UfY/gLAdh
         K51rPMrCdT80n8C2VqNdKPF0lae/fIiIPEOXvGVxCWwvZAqNrZLbFoULP+pF6qOpiF
         y/R8S/PwxOkMtD768ALmxXbYdM6xECks5bg7KFtLqKn9D0HGtWpsON1r4VWKOPnDIA
         DHhB1lfHhngksnU8WU0ZqCFJCV+YRJiS5vlRTvl5BnwvLBEb3RgFEQoMf/YlWGnQzV
         752YHgQK+FOGzZrWU55roq6PZpiRmBbasGDQllSkbERvJ26oeZO5sMP4fzbKcwCFn0
         yN0vWg9bdyjVg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zheng Yejian <zhengyejian1@huawei.com>, mhiramat@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 5/6] ring-buffer: Avoid softlockup in ring_buffer_resize()
Date:   Sun, 24 Sep 2023 09:20:48 -0400
Message-Id: <20230924132050.1277021-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924132050.1277021-1-sashal@kernel.org>
References: <20230924132050.1277021-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.326
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Yejian <zhengyejian1@huawei.com>

[ Upstream commit f6bd2c92488c30ef53b5bd80c52f0a7eee9d545a ]

When user resize all trace ring buffer through file 'buffer_size_kb',
then in ring_buffer_resize(), kernel allocates buffer pages for each
cpu in a loop.

If the kernel preemption model is PREEMPT_NONE and there are many cpus
and there are many buffer pages to be allocated, it may not give up cpu
for a long time and finally cause a softlockup.

To avoid it, call cond_resched() after each cpu buffer allocation.

Link: https://lore.kernel.org/linux-trace-kernel/20230906081930.3939106-1-zhengyejian1@huawei.com

Cc: <mhiramat@kernel.org>
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1949d7bbe145d..f0d4ff2db2ef0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1686,6 +1686,8 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 				err = -ENOMEM;
 				goto out_err;
 			}
+
+			cond_resched();
 		}
 
 		get_online_cpus();
-- 
2.40.1

