Return-Path: <linux-kernel+bounces-59268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED1C84F44B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD0628F60F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D118E28DBC;
	Fri,  9 Feb 2024 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FphucTcS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245E428699
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476962; cv=none; b=N1NXnn4s3rV+7qAev9TajMl0W8Qsia78Sl/X0fpbMbKBbl0p4bdLqkfwZ4sQoeJ09VypsM7b0gZ1gwenftmDJaT/K9XEpkJCMhUAzz/CPGJ9V/LqfhTRahcbEBB+4Vlxb61dz4zLHxAtfIveus04cjNLnGtVYg7qj7z49lQ19eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476962; c=relaxed/simple;
	bh=vYGSasQPQ+waLNUKIyeyV6A0z7rQTFbg/b3dnkeB2y8=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=rIG6I2XothFONI4YjtYUEtr2DzH1NwjUwwvnojtnwUQIPAX02NXmz2TqwqiGelNGRETyUAtL+q6cDoOCtiK3VhuDgWm7MmxzPqDyFTlNjsRvNCLxG3T+e02GFtCVabY2Mnxm3DkQTgkG3au+1yKyCrDGGK54vwh53hv7802+3go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FphucTcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D71C433C7;
	Fri,  9 Feb 2024 11:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707476960;
	bh=vYGSasQPQ+waLNUKIyeyV6A0z7rQTFbg/b3dnkeB2y8=;
	h=Date:From:To:Cc:Subject:From;
	b=FphucTcSWR3MECQSlUPt8tsubTMDRjPOHv30eBXxPw97v9aIdJCO+tyBVcPZ19hGA
	 DULGj+sVJ6PvXTszNwbBmybjnp2I+O2kQuSRiVkOo7ZYBOP0FiGaVvmO3EKPLDNerk
	 fkXp4533T7oW2rTgI+5hTtgUI5aBBOLy+dYDIppFhbH4TbVscblZOoGtX+BmU2iJNi
	 vs7wortEDjF4WwV9os9Q7QsvaikmkmrGSnIcxoj/jRx10TpJo66KRvEXSwx1txyx8a
	 WPDXM49kTck8S4nSoNHKW2JA/fJnV4bBLaXbXnTSfO5pUb/QHGujeA4nbIGQpxO8wT
	 xqKcoUOJCVp7w==
Date: Fri, 9 Feb 2024 20:09:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Li zeming <zeming@nfschina.com>, Masami Hiramatsu (Google)
 <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: fixes for v6.8-rc3
Message-Id: <20240209200916.e1607c9688a39971feb43867@kernel.org>
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

Probes fixes for v6.8-rc3:

 - kprobes: Remove unnecessary initial values of local variables.

 - tracing/probe-events: Fixing parser bugs.
   . Fix to calculate the argument size and format string after setting
     type information from BTF, because BTF can change the size and format
     string.
   . Fix to show $comm parse error correctly instead of failing silently.


Please pull the latest probes-fixes-v6.8-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.8-rc3

Tag SHA1: bdad2be231fd9d040e3d5552f35e1e329df5aa9f
Head SHA1: 9efd24ec5599ed485b7c4d9aeb731141f6285167


Li zeming (1):
      kprobes: Remove unnecessary initial values of variables

Masami Hiramatsu (Google) (2):
      tracing/probes: Fix to show a parse error for bad type for $comm
      tracing/probes: Fix to set arg size and fmt after setting type from BTF

----
 kernel/kprobes.c           |  4 ++--
 kernel/trace/trace_probe.c | 32 ++++++++++++++++++--------------
 kernel/trace/trace_probe.h |  3 ++-
 3 files changed, 22 insertions(+), 17 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

