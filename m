Return-Path: <linux-kernel+bounces-21041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718738288EC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA5F1C23DD9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E923639FD9;
	Tue,  9 Jan 2024 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qr8mtCa/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4342B39FCF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 15:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D6BC433C7;
	Tue,  9 Jan 2024 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704813811;
	bh=sjD930zIK8cjO4nX6B7w5xUGEtjiFCtfNqOyC3jFeCs=;
	h=Date:From:To:Cc:Subject:From;
	b=qr8mtCa/4tjtYoUjryoH8yLO7QqzlLlj30UbvdaMt7PD8nkp4ccO46uYHiRKnDjIY
	 WC8rMDuxwneothOL92L2Q3feah6JmQ46fMxevawHNV2Na0ghfKP1ys66FaTiMntTWF
	 yccYLQFliXTU2KGkN6JPR2HgnstamJ3FsxpVIZjakG+DvytpMf4F4OkrlyXsVx+433
	 z1B38IVT1AW8ulMwUIe0x53ur3e8vWLSouEH093xW4JPzGWvWU0DRYAnaLj0JFFIp5
	 bpuQAO2yQZhN/ZOi4En4wL1k3qJJ7mj98fItiKt81XaKFLZWFpjqxsed27p4DekbLU
	 hleIuLNraIUdg==
Date: Wed, 10 Jan 2024 00:23:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Naveen N Rao <naveen@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes update for v6.8
Message-Id: <20240110002328.7adb07c24ff0b28c271e6099@kernel.org>
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

Probes update for v6.8:

- Kprobes trace event to show the actual function name in notrace-symbol
  warning. Instead of using user specified symbol name, use "%ps" printk
  format to show the actual symbol at the probe address. Since kprobe
  event accepts the offset from symbol which is bigger than the symbol
  size, user specified symbol may not be the actual probed symbol.


Please pull the latest probes-v6.8 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-v6.8

Tag SHA1: 64ba9c09b7537e611861d19c66032dcb4e98b7fc
Head SHA1: 9c556b7c3f520d42c435c0d78b25c719c060f8a1


Naveen N Rao (1):
      trace/kprobe: Display the actual notrace function when rejecting a probe

----
 kernel/trace/trace_kprobe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---------------------------
commit 9c556b7c3f520d42c435c0d78b25c719c060f8a1
Author: Naveen N Rao <naveen@kernel.org>
Date:   Thu Dec 14 10:47:02 2023 +0530

    trace/kprobe: Display the actual notrace function when rejecting a probe
    
    Trying to probe update_sd_lb_stats() using perf results in the below
    message in the kernel log:
            trace_kprobe: Could not probe notrace function _text
    
    This is because 'perf probe' specifies the kprobe location as an offset
    from '_text':
            $ sudo perf probe -D update_sd_lb_stats
            p:probe/update_sd_lb_stats _text+1830728
    
    However, the error message is misleading and doesn't help convey the
    actual notrace function that is being probed. Fix this by looking up the
    actual function name that is being probed. With this fix, we now get the
    below message in the kernel log:
            trace_kprobe: Could not probe notrace function update_sd_lb_stats.constprop.0
    
    Link: https://lore.kernel.org/all/20231214051702.1687300-1-naveen@kernel.org/
    
    Signed-off-by: Naveen N Rao <naveen@kernel.org>
    Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
    Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 52f8b537dd0a..c4c6e0e0068b 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -487,8 +487,8 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 		return -EINVAL;
 
 	if (within_notrace_func(tk)) {
-		pr_warn("Could not probe notrace function %s\n",
-			trace_kprobe_symbol(tk));
+		pr_warn("Could not probe notrace function %ps\n",
+			(void *)trace_kprobe_address(tk));
 		return -EINVAL;
 	}
 

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

