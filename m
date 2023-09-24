Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2540B7AC8ED
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjIXNVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjIXNUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:20:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEACF19BD;
        Sun, 24 Sep 2023 06:18:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CE8C433C8;
        Sun, 24 Sep 2023 13:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561500;
        bh=v+kjxH+8OrRaW4gMS8neV9tdlMoMKrRmQAPLQr171wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q36FmwPGmlxD2F67ahXk98i1FS/eoXRilbaFywEBthDF5EnNmKIO+8t9IWJxucxsS
         Q3e0LFVHs9VbLaazTjaUma8nIfFvlpH1gy291oWd/ZrXu8A2SFcGoZ6XhDC0j5GHe9
         cX4jUegYuJiMKI7rayQ4bmL5idQhchec5EfCAonbOeg6X2wfv+CjZM+nx4BBQxgOu0
         MiO4/D/AvyWNIjYE+xsUypDUZ7TPvIOD4/K+LJNEoI2z7UX9Q6lXLk/zm7w6i2Mx7G
         wFkQ8BTTZuLHZ5oxb2XuPA5XRfb4mmarZYn0WmIIaIviqU6odC4rNQncF7nSicZPfr
         c/kqSj0TKq9Qg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tze-nan Wu <Tze-nan.Wu@mediatek.com>,
        Sasha Levin <sashal@kernel.org>, matthias.bgg@gmail.com,
        linux-trace-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 14/28] ring-buffer: Do not attempt to read past "commit"
Date:   Sun, 24 Sep 2023 09:17:31 -0400
Message-Id: <20230924131745.1275960-14-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131745.1275960-1-sashal@kernel.org>
References: <20230924131745.1275960-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.55
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

[ Upstream commit 95a404bd60af6c4d9d8db01ad14fe8957ece31ca ]

When iterating over the ring buffer while the ring buffer is active, the
writer can corrupt the reader. There's barriers to help detect this and
handle it, but that code missed the case where the last event was at the
very end of the page and has only 4 bytes left.

The checks to detect the corruption by the writer to reads needs to see the
length of the event. If the length in the first 4 bytes is zero then the
length is stored in the second 4 bytes. But if the writer is in the process
of updating that code, there's a small window where the length in the first
4 bytes could be zero even though the length is only 4 bytes. That will
cause rb_event_length() to read the next 4 bytes which could happen to be off the
allocated page.

To protect against this, fail immediately if the next event pointer is
less than 8 bytes from the end of the commit (last byte of data), as all
events must be a minimum of 8 bytes anyway.

Link: https://lore.kernel.org/all/20230905141245.26470-1-Tze-nan.Wu@mediatek.com/
Link: https://lore.kernel.org/linux-trace-kernel/20230907122820.0899019c@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Reported-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 42ad59a002365..c0b708b55c3b9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2388,6 +2388,11 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	 */
 	commit = rb_page_commit(iter_head_page);
 	smp_rmb();
+
+	/* An event needs to be at least 8 bytes in size */
+	if (iter->head > commit - 8)
+		goto reset;
+
 	event = __rb_page_index(iter_head_page, iter->head);
 	length = rb_event_length(event);
 
-- 
2.40.1

