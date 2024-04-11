Return-Path: <linux-kernel+bounces-139611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD21D8A0551
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32807B23DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235C460BBE;
	Thu, 11 Apr 2024 01:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKzY82lb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD0F6FD9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797762; cv=none; b=iSZM/RmP1BAm2YdQ3GEOGyEvrqU25AYLEGs8YmesuAsy2c9H0tv5Sp59+x02AL1vu3WLRxz4ZNniytpJbL3lblKPS9H1Vqen3yDZcVEWmepRKyACBHCmm7kBaVwMwX5O0FMm3S2H8vdVTobOnkA8nYkFlcpqhNnoCZb1CEvVJbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797762; c=relaxed/simple;
	bh=ygxU464u0P3fo7HWssZPLnVUq3RPDFen+uncw9iKt8w=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=m74mGEYhs2Wl1IUU7o4tBfjGLaPDYr4J/ZuwE2fT1kfdbSe9cbG8QAUpsxlM+5k/KioL1aBL9affHbGadTkqhM8pq1GMQpbTKdFZrYVf8He7MDJzaFKQ76+HaNymVfzDjWUHk9gh7Z9WZ74hjDJ5RdceFrNfx8QEkzaeuYZIu7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKzY82lb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D2BC433C7;
	Thu, 11 Apr 2024 01:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712797761;
	bh=ygxU464u0P3fo7HWssZPLnVUq3RPDFen+uncw9iKt8w=;
	h=Date:From:To:Cc:Subject:From;
	b=UKzY82lbyTP850OnFhsXXFSlplAPnWXXMV+Fb5dOCcRpRfiXIEwLB/TJK+ZKTq3kP
	 w0TDkKsTU+tcXmkvQMaLXv9lXmBFdRSfhXsCRM3rFFg19ik8HrbiBxlto7PEm5Y/r+
	 LLsXP/lls8v5cwxks051E2C1KBU3kbfN8bQkh7pWDxbCZ0wTsWeenyRSAseqDD5aAa
	 3YNdQ/KCCphVYPwanRTnlzfFCPTDuPyRnmUjpr0PM6XJ8pPBFRTjFM91Vrg3qJ9tsW
	 WUraf7MgwIcrnYH8lxlEitZEzme1zPjOH9ZhJdKGXVI6gqGGCoiWJ4hi3C5Snj3yck
	 5yRkm9nPgcT1w==
Date: Thu, 11 Apr 2024 10:09:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Zheng Yejian <zhengyejian1@huawei.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.9-rc3
Message-Id: <20240411100918.15b7b8a7ad25718a9dffff91@kernel.org>
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

Probes fixes for v6.9-rc3:

- kprobes: Fix possible use-after-free issue on kprobe registration. Since
  check_kprobe_address_safe() uses `is_module_text_address()` and
  `__module_text_address()` separately, if the probe address is on an
  unloading module, the first `is_module_text_address()` return true but
  the second `__module_text_address()` returns NULL (module is unloaded
  between them). Thus it expects the probe is on the kernel text, and
  skips to get the module reference. In this case, when it arms a breakpoint
  on the probe address, it may cause a use-after-free problem.
  To fix this issue, we only use `__module_text_address()` once and tries
  to get reference of the module, if it fails, reject the probe.


Please pull the latest probes-fixes-v6.9-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.9-rc3

Tag SHA1: 67bbfb7d79488db2f7e80bc4442d090254127c3c
Head SHA1: 325f3fb551f8cd672dbbfc4cf58b14f9ee3fc9e8


Zheng Yejian (1):
      kprobes: Fix possible use-after-free issue on kprobe registration

----
 kernel/kprobes.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

