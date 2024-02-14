Return-Path: <linux-kernel+bounces-65219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801038549A7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F29B2625D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BF65338F;
	Wed, 14 Feb 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbHHB5YM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9702552F6D;
	Wed, 14 Feb 2024 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915060; cv=none; b=JBe/3R4IZ97wG1dYfRs4idAYsAk2K1KhGt9EMWJ5ngJ0mYbUYWs33+2+lnLXDGBulMHt/fNNov518buOmIReebmnbHud4z4YWTcCdoJp/ObF9xZikPj16KpgAx1K/RCd73h0tBYo4O2RfRYtx+5uQujwr7g0PPRllpHMP9/v/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915060; c=relaxed/simple;
	bh=RWvrLf1KdKNmNFeac58ILq9M4ZuHDUel2ED6opH/yF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TLj5G5r4NHifJ6cYqx4Gmjv+F0vfRxVz51mFrZ2kWM0NOvvgI0s+/MrDybch3sP8FZrtnRJvayTFNVCHe8Lz9AGV+nfUf/HrjGbafnIbXeOippc9q87DzXsIcgj5Hm41V9fyzvsf3w/MVljjeARmKS0bTXSfhgnOdPWSnrpGXh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbHHB5YM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DFDC433F1;
	Wed, 14 Feb 2024 12:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707915060;
	bh=RWvrLf1KdKNmNFeac58ILq9M4ZuHDUel2ED6opH/yF0=;
	h=From:To:Cc:Subject:Date:From;
	b=GbHHB5YMLk9ThdE3OtsWaRdn22I5l5bLwWAedWKevCHc5W8yZd6L6/SWY4GkFQE++
	 U+O2SIC/j63NEbYi5s1B03pgX6wanqWt6CHuTCP1RF47hGs0zDb01R7FeB/ej1r1Hr
	 OTMs+FfCPJZl0MmyuiKEflyaFLgGxWipLa1S46wBFm7n9an5HleDce8BT1We13WJdB
	 VKRjNyXPHfmqwZ2Ndv+TGv1BHVfug1ukdClnKVkrdZZ8zUeSdAs+JBNazv9CztW1rL
	 LOQgPbZiKBLX1oB0F+bcNEs4roCyQp0sPYIiRGNvQkWfJqd2TpdwELVEhM3r7S3cm9
	 Ulm2Os9SwpbVQ==
From: Kalle Valo <kvalo@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jeff Johnson
 <quic_jjohnson@quicinc.com>
Subject: [regression] tracing: kmemleak warning in allocate_cmdlines_buffer()
Date: Wed, 14 Feb 2024 14:50:56 +0200
Message-ID: <87r0hfnr9r.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Steven,

I upgraded our ath11k test setup to v6.8-rc4 and noticed a new kmemleak
warning in the log:

unreferenced object 0xffff8881010c8000 (size 32760):
  comm "swapper", pid 0, jiffies 4294667296
  hex dump (first 32 bytes):
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace (crc ae6ec1b9):
    [<ffffffff86722405>] kmemleak_alloc+0x45/0x80
    [<ffffffff8414028d>] __kmalloc_large_node+0x10d/0x190
    [<ffffffff84146ab1>] __kmalloc+0x3b1/0x4c0
    [<ffffffff83ed7103>] allocate_cmdlines_buffer+0x113/0x230
    [<ffffffff88649c34>] tracer_alloc_buffers.isra.0+0x124/0x460
    [<ffffffff8864a174>] early_trace_init+0x14/0xa0
    [<ffffffff885dd5ae>] start_kernel+0x12e/0x3c0
    [<ffffffff885f5758>] x86_64_start_reservations+0x18/0x30
    [<ffffffff885f582b>] x86_64_start_kernel+0x7b/0x80
    [<ffffffff83a001c3>] secondary_startup_64_no_verify+0x15e/0x16b

I don't see this warning in v6.8-rc3 and also reverting commit
44dc5c41b5b1 ("tracing: Fix wasted memory in saved_cmdlines logic")
makes the warning go away. Let me know if you need more info or help
with testing, I see the warning every time so it's easy to reproduce.

Kalle

