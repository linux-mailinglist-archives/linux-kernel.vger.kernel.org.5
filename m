Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382527AC9AC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjIXNgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjIXN3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:29:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CCC5249;
        Sun, 24 Sep 2023 06:20:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EA6C433B7;
        Sun, 24 Sep 2023 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561629;
        bh=HYpkdOOghk0zSq3UiBqB7n4oHt5uTXUL0NsH5g3Gag4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eWBvsLBxWEbMutg/kMqG5Zucketj6NS+hPqzHlF76u+1SQWQHEA7iNu0sttyHf7gD
         HaB7loqg9jpPjFxcpSGTlL3JLelkT8Ha6DstQl81HRIy4ef7OR2vYjRodDbGFOTBkt
         +T9kPkO3nWX6qO5Ls/aS7OvfiuThfYJpxBhHIXSIODVZcfSNjZuZpeQCSOp4fWteFa
         EBGMekx5w1Yq9dj0DoApB7b42ixXUjWsnLRSM0ews7l3LMbHmIPy2fwwF+zGn7P/In
         ZZfbARhcZs272uy2xJEBig1Elg1EYpC11vddds9p/YnrWqZl58rt1SHQXxshgKGoWh
         c5oRj13jFusPQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zheng Yejian <zhengyejian1@huawei.com>, mhiramat@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 6/7] ring-buffer: Avoid softlockup in ring_buffer_resize()
Date:   Sun, 24 Sep 2023 09:20:13 -0400
Message-Id: <20230924132015.1276811-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924132015.1276811-1-sashal@kernel.org>
References: <20230924132015.1276811-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.257
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
index 445475c229b3a..2a4fb4f1e3cad 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1821,6 +1821,8 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 				err = -ENOMEM;
 				goto out_err;
 			}
+
+			cond_resched();
 		}
 
 		get_online_cpus();
-- 
2.40.1

