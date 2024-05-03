Return-Path: <linux-kernel+bounces-168380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DA98BB7C2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019EC1F23A41
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544CE84D30;
	Fri,  3 May 2024 22:50:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF11824AC
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714776634; cv=none; b=kmMfqNpWurRyjp2q95BKJwifko1qIYPjao1p3ZkzBfrfNgBEn3goiol15YuN5SOFPY099+iYEaQppic9N48yRdwFk+u9xMXunTqv0Er83xlbecd92J+6fDyEaqhmzAQoV6/fdxnpOnqH++XD9YmlayWafyoPBesEjWK6SgpYdyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714776634; c=relaxed/simple;
	bh=VuXalIPTL9sTa7bnw/R/Fo8g3BmGZ0SIUARYlC9WdwQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cMfoCv7aSXagqRvyY3dJ4ytpFL5kFE4Bm5VeskDMLQQ9HXpNQ7PfYShSRijxVyrQEGi13r0bpu0LcMbgTZFUuf4Gn3UA+wzal9rCBfGwgEg/e3glFjvfWNW29o+Ypya08Fb5EY5PONUg/aFDZ1leUCzS4i3Atg94k3AE1MU0KY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E42DC4AF1B;
	Fri,  3 May 2024 22:50:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s31jd-00000000NKd-3lK5;
	Fri, 03 May 2024 18:50:33 -0400
Message-ID: <20240503225033.758019899@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 03 May 2024 18:50:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-linus][PATCH 2/9] selftests/user_events: Add non-spacing separator check
References: <20240503225013.519028385@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Beau Belgrave <beaub@linux.microsoft.com>

The ABI documentation indicates that field separators do not need a
space between them, only a ';'. When no spacing is used, the register
must work. Any subsequent register, with or without spaces, must match
and not return -EADDRINUSE.

Add a non-spacing separator case to our self-test register case to ensure
it works going forward.

Link: https://lore.kernel.org/linux-trace-kernel/20240423162338.292-3-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/testing/selftests/user_events/ftrace_test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index dcd7509fe2e0..0bb46793dcd4 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -261,6 +261,12 @@ TEST_F(user, register_events) {
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
 
+	/* Register without separator spacing should still match */
+	reg.enable_bit = 29;
+	reg.name_args = (__u64)"__test_event u32 field1;u32 field2";
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(0, reg.write_index);
+
 	/* Multiple registers to same name but different args should fail */
 	reg.enable_bit = 29;
 	reg.name_args = (__u64)"__test_event u32 field1;";
@@ -288,6 +294,8 @@ TEST_F(user, register_events) {
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
 	unreg.disable_bit = 30;
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
+	unreg.disable_bit = 29;
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
 
 	/* Delete should have been auto-done after close and unregister */
 	close(self->data_fd);
-- 
2.43.0



