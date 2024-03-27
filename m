Return-Path: <linux-kernel+bounces-121424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A56588E7C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2191F33349
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12448146A84;
	Wed, 27 Mar 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNSF++lG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A0D14535D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549419; cv=none; b=CAy3Bzj0fG+TWujeLk1Q55fTQ3/B5reuJE0rOoL8CdyAciU8UO7rJHD/08baMrn39selbPoG4iaOw4GbXnHEth4EQNeYwXCDfUKRJOX66Q0TaYyA8F1i0HNefF06ORsp+lUf0pUDPSKmhnUYeYXaLi+Fd7o+GXIBxK8qaPq9BJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549419; c=relaxed/simple;
	bh=Sksl8i8PnOiTqr4IVGDYXs4HXDKRPWF92JDKDZBGrGk=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=A74CqaJDjW3x7UJqc0d3nou8gi1QtBrEDfv+NEW7hHpEMZHjA2D8IfN1R/pzazRc4qAOKPo9DpSPD+XF3eA5mkJi0ZDqeRAqzl0ieIPEHJKJ5xhHKlO6oC57ltneV4aHe5fecjaKGfFcKrcmel2AoxzR9GpvCvvQr8CC0Mg0ZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNSF++lG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443F8C433C7;
	Wed, 27 Mar 2024 14:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711549418;
	bh=Sksl8i8PnOiTqr4IVGDYXs4HXDKRPWF92JDKDZBGrGk=;
	h=Date:From:To:Cc:Subject:From;
	b=VNSF++lGGgcAk0F3gsRRNKpNnyXiZJOxodQVycktupLQWWOqXus9X4/1tVh1TOfv6
	 Hj7fm2HMjaM5XnfVwUumlU8Lmqd1aLw5fOJbhkm1ZSxj2RaUwBlcRKetFT5xYITdQe
	 POM1ebitJylhnfiSlW6PFBHOWyScGf5sXRRebtmx7HCKwxTY7aeFexcr2CzDJt4qBj
	 CTwimF4VDC1BnEqbqwOO/eIzYVWyOjkbIGLYDCJl55NqvTTAaWxuQjDoPfHTautPb3
	 TBprYsc6F0tqFxTVqHM/4IyXWQIFeE5IRgxD2mfU2I5oegdnz9P1tH9KWhlGvbb5E5
	 +1s7jTB4jtwIA==
Date: Wed, 27 Mar 2024 23:23:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.9-rc1
Message-Id: <20240327232335.c817e6f17b84328f462d9e57@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Probes fixes for v6.9-rc1:

 - tracing/probes: initialize a 'val' local variable with zero. This variable
   is read by FETCH_OP_ST_EDATA in a loop, and is expected to be initialized
   by FETCH_OP_ARG in the same loop. Since this expectation is not obvious,
   thus smatch warns it. Initializing 'val' with zero fixes this warning.


Please pull the latest probes-fixes-v6.9-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.9-rc1

Tag SHA1: f7e169092950bdda7a36a77325e3490700668a66
Head SHA1: 0add699ad068d26e5b1da9ff28b15461fc4005df


Masami Hiramatsu (Google) (1):
      tracing: probes: Fix to zero initialize a local variable

----
 kernel/trace/trace_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit 0add699ad068d26e5b1da9ff28b15461fc4005df
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Date:   Wed Mar 20 17:10:38 2024 +0900

    tracing: probes: Fix to zero initialize a local variable
    
    Fix to initialize 'val' local variable with zero.
    Dan reported that Smatch static code checker reports an error that a local
    'val' variable needs to be initialized. Actually, the 'val' is expected to
    be initialized by FETCH_OP_ARG in the same loop, but it is not obvious. So
    initialize it with zero.
    
    Link: https://lore.kernel.org/all/171092223833.237219.17304490075697026697.stgit@devnote2/
    
    Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
    Closes: https://lore.kernel.org/all/b010488e-68aa-407c-add0-3e059254aaa0@moroto.mountain/
    Fixes: 25f00e40ce79 ("tracing/probes: Support $argN in return probe (kprobe and fprobe)")
    Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
    Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 217169de0920..dfe3ee6035ec 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -839,7 +839,7 @@ int traceprobe_get_entry_data_size(struct trace_probe *tp)
 void store_trace_entry_data(void *edata, struct trace_probe *tp, struct pt_regs *regs)
 {
 	struct probe_entry_arg *earg = tp->entry_arg;
-	unsigned long val;
+	unsigned long val = 0;
 	int i;
 
 	if (!earg)
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

