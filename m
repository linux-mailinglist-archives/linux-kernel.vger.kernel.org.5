Return-Path: <linux-kernel+bounces-30278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C702831C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663EC283B38
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C502C878;
	Thu, 18 Jan 2024 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVW7z7Cg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E2E250E7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591542; cv=none; b=styE0iQQJIdOWvXyhq8KziCTEsUqm7pilchjAL7lnVlgTbWEb8uvboC6xN/0wBOjHiZUkDz/gFryuNaWiYuyraAqvLukijJRNhQfCTUOJqThrjxaZzJ/ac8ior6zRHYlPmaaW9wrzY9BtBL4jKwis8Kv8G2Qg6OTHoma/eOpUnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591542; c=relaxed/simple;
	bh=bv8EIfucd5lBrjjXVVDPU3FSiLtb8atCLikYS+cOi0U=;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To; b=r0Uxcx1BwF9G7aYUWjvNls7igzJ2/g1Cr+tw4dRCiCOYlv0/QtP04op1PFQNsUlxyK4TC59zp+CzR1gM9ORKLogKY89IroONCHAuo0IKfTj9x3X7ngkxjOSWZ9e+1QwxouDEWCyVK+1uL0o/HOWrwslbEN/i/Ibgy4NZvk++9ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVW7z7Cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1011DC43390;
	Thu, 18 Jan 2024 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705591542;
	bh=bv8EIfucd5lBrjjXVVDPU3FSiLtb8atCLikYS+cOi0U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SVW7z7Cg7uBzrupT3P+M0huZwscyqIFAUvkR8lMUWOI1kMhI7WutgJYTNKa60UXEl
	 3igECw7aCQd7Y3s8DQX7J8cYc1fkFRZ3AWN5yDVkYHsD9TcUrNh5fApx9L9yE2W8xq
	 1tzr6fKrAF4x42Q7G+/IPIVrc142OiEJeLuInikONOBwdJqp73peJ6celGZt2u2Htl
	 6C07wt2UWaOQx1GnpWXDj55qj3aEyEXdo3PtOvnH5tEIUomOwMKcmfqAbV2p4aQiFN
	 wtKdVNAlKi8wlepYq07zK8ejC56R/odwfe/SJvrszewChOnZ9etUOByQMF/u84jF85
	 Lro7blXHXaomA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCAEC47DAF;
	Thu, 18 Jan 2024 15:25:41 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathanl.linux.ibm.com@kernel.org>
Date: Thu, 18 Jan 2024 09:25:12 -0600
Subject: [PATCH RFC 1/5] dump_stack: Make arch description buffer
 __ro_after_init
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240118-update-dump-stack-arch-str-v1-1-5c0f98d017b5@linux.ibm.com>
References:
 <20240118-update-dump-stack-arch-str-v1-0-5c0f98d017b5@linux.ibm.com>
In-Reply-To:
 <20240118-update-dump-stack-arch-str-v1-0-5c0f98d017b5@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 Brian King <brking@linux.ibm.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 John Ogness <john.ogness@linutronix.de>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Petr Mladek <pmladek@suse.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Nathan Lynch <nathanl@linux.ibm.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705591541; l=904;
 i=nathanl@linux.ibm.com; s=20230817; h=from:subject:message-id;
 bh=uGRC5bEXAZpqbl74Y43nE5tPlwjA0DDYCHWXiMdO7oY=;
 b=mRB3b+vZUc4j1CZuAqps+dMLW3dhH0rtknvVIhYr75cbUsWxHXQzwL1XHsgm2Dka6lOqHqzli
 tuQArMMkTQ6A8GpmfpD4X7jCoFyeMG5WzBkP2vlcjAz4E3Oo1hWIy2X
X-Developer-Key: i=nathanl@linux.ibm.com; a=ed25519;
 pk=jPDF44RvT+9DGFOH3NGoIu1xN9dF+82pjdpnKjXfoJ0=
X-Endpoint-Received:
 by B4 Relay for nathanl@linux.ibm.com/20230817 with auth_id=78
X-Original-From: Nathan Lynch <nathanl@linux.ibm.com>
Reply-To: <nathanl@linux.ibm.com>

From: Nathan Lynch <nathanl@linux.ibm.com>

The static hardware description buffer is populated by arch code
during boot and should not change afterwards, so mark it
__ro_after_init.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
---
 lib/dump_stack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 83471e81501a..1057f102f6f2 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -6,6 +6,7 @@
 
 #include <linux/kernel.h>
 #include <linux/buildid.h>
+#include <linux/cache.h>
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
@@ -15,7 +16,7 @@
 #include <linux/utsname.h>
 #include <linux/stop_machine.h>
 
-static char dump_stack_arch_desc_str[128];
+static char dump_stack_arch_desc_str[128] __ro_after_init;
 
 /**
  * dump_stack_set_arch_desc - set arch-specific str to show with task dumps

-- 
2.43.0


