Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACE87F5476
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344480AbjKVXZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjKVXZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:25:31 -0500
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F06A11F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:25:28 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700695526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YRuFFmQdC+GEPgfI4SIAkxSEqgU4CuzXncjpbXVOgmA=;
        b=OYAGGmY34QArkmiHjXDebJ27PVWXyHMvnQZdKucHfTgjB1wcWYWZBFp8TmHRA8jCBIi8v4
        yvW1Y2FRd872H0c4q3qoiHR5jVSk8jX1HncoAHfmzh1blP3uywzK+6Ze2zyzcQKJnohAOI
        ZqfJdF5DZ+e1jm6U7nga+mewJb4vhXs=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 1/7] seq_buf: seq_buf_human_readable_u64()
Date:   Wed, 22 Nov 2023 18:25:06 -0500
Message-ID: <20231122232515.177833-2-kent.overstreet@linux.dev>
In-Reply-To: <20231122232515.177833-1-kent.overstreet@linux.dev>
References: <20231122232515.177833-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a seq_buf wrapper for string_get_size().

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/seq_buf.h |  4 ++++
 lib/seq_buf.c           | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 5fb1f12c33f9..dfcd0f367d6a 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -171,4 +171,8 @@ seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary);
 
 void seq_buf_do_printk(struct seq_buf *s, const char *lvl);
 
+enum string_size_units;
+void seq_buf_human_readable_u64(struct seq_buf *s, u64 v,
+				const enum string_size_units units);
+
 #endif /* _LINUX_SEQ_BUF_H */
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 010c730ca7fc..9d4e4d5f43b4 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -425,3 +425,13 @@ int seq_buf_hex_dump(struct seq_buf *s, const char *prefix_str, int prefix_type,
 	}
 	return 0;
 }
+
+void seq_buf_human_readable_u64(struct seq_buf *s, u64 v, const enum string_size_units units)
+{
+	char *buf;
+	size_t size = seq_buf_get_buf(s, &buf);
+	int wrote = string_get_size(v, 1, units, buf, size);
+
+	seq_buf_commit(s, wrote);
+}
+EXPORT_SYMBOL(seq_buf_human_readable_u64);
-- 
2.42.0

