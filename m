Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6190B7AC987
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjIXNcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjIXNbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:31:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B7C126;
        Sun, 24 Sep 2023 06:19:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9D2C4339A;
        Sun, 24 Sep 2023 13:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561556;
        bh=K8J0QDkxbSrQUnC9nMsSjjLZcAM3sGpsS/OS8LrWF9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aC29fN7gZcwOmSDB0lHctCzVdf6dEkhSEnt9d0P8bGQ/ypn4AxDIUWGY/JmifRzDb
         /RNbKoOMVRK/BkC2coFY34Sq33pTthlBiYDNkpXJGKyeuYFSH2C6H0U65ddE5lmrlm
         tsYQCHMuGGpJ+aOu1czXAzDN5vOyEHAiOZ0Aoaq8Y7vVOEwQfQEk4ylvS071yg07eW
         fQSdvX1vtkJ6r7unE1n5t82C6eD8ngm/YuC9nGFsTSQz9V1AOeFfDQewLxfmyxp8Yq
         wKuDAaAFwAEkw1JPU+0eQYzVDuegsLNMqd9iqtKIwEGfyGnZB39WMHRTRk2WYNAL12
         b1glWCmey+5sw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zheng Yejian <zhengyejian1@huawei.com>, mhiramat@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 08/18] ring-buffer: Avoid softlockup in ring_buffer_resize()
Date:   Sun, 24 Sep 2023 09:18:45 -0400
Message-Id: <20230924131857.1276330-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131857.1276330-1-sashal@kernel.org>
References: <20230924131857.1276330-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.133
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
index db7cefd196cec..b15d72284c7f7 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2176,6 +2176,8 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 				err = -ENOMEM;
 				goto out_err;
 			}
+
+			cond_resched();
 		}
 
 		cpus_read_lock();
-- 
2.40.1

