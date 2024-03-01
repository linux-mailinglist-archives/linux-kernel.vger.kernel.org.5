Return-Path: <linux-kernel+bounces-87740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2B386D862
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA401C20BAA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FCC33C8;
	Fri,  1 Mar 2024 00:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMob+8Vk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C72D2568
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709253391; cv=none; b=ajtDRn7KHI6rUO2l1PZWfiqPl8F/xJQ7XPvqbeb3IQAscWlUCW0XOEq15jSIpTmQkrsL4OXupB5uCcJYgOrnqTbG1w2f/ZB3HZR9ULDcH1vOQVmNmAz9HatazVFAqT/Do3C3wGRMBiu6kHX9lcQniHpb89JfNNWz0junHW/WbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709253391; c=relaxed/simple;
	bh=ShGRxPqNPfcifghubLV8w8xhZEaB9Yp77oxbIJa45kI=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=WKLphBhIj+bj4CuJ9gFRKNP1YXPmKF+9ZcANd+orjAQ/kjBYiayFcpziw5z5MJaFlbiOsm/VN1UyEG5/w2jSqBtX6+E5+JfTnCBpCcMMBbydaz5Uw/vVA9TfaJZlsCAjQ8i4aqIqSV6MytDQ+esfmLggMdmNG8m7b69LiokDEr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMob+8Vk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DADC433C7;
	Fri,  1 Mar 2024 00:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709253391;
	bh=ShGRxPqNPfcifghubLV8w8xhZEaB9Yp77oxbIJa45kI=;
	h=Date:From:To:Cc:Subject:From;
	b=HMob+8Vkr389G28JaRGTdFJhWRB+Nd1cavSwugTLsTpgfA+KFlhbg2cv2ItyGIrWC
	 r/ccUut0MevVfnMbF+UL+iFCMLcHvS7kWEzVx0uXHqQ0wXjUCs8sqs4pUg+qG7hX27
	 +Vifnwkb/Mx2eS5Ljr1ctY2mSrg1TqfgTvs2fcLNKD6pXhZwQUBI1KDaJhQJ1QVypj
	 ZpH4CPvTY1QjLSk/6LxrLlnjvH67tZixK5O1EQipq5YGzgCgMFAXEw8obo8MyS0Suo
	 LXoaDwAPd0LWoNzUvGbe3UrQ0u+d3yecCN0J7TEnA/Lq3EP0KUgwXSQjiJeXh+wx27
	 4UbsjeB1E5EQA==
Date: Fri, 1 Mar 2024 09:36:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.8-rc5
Message-Id: <20240301093627.14516d10f02a5ba9116e9702@kernel.org>
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

Probes fixes for v6.8-rc5:

  - fprobe: Fix to allocate entry_data_size buffer for each rethook
    instance. This fixes a buffer overrun bug (which leads a kernel
    crash) when fprobe user uses its entry_data in the entry_handler.


Please pull the latest probes-fixes-v6.8-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.8-rc5

Tag SHA1: 771e808cce33b2bac31d03006ec542ca6fc2585d
Head SHA1: 6572786006fa96ad2c35bb31757f1f861298093b


Masami Hiramatsu (Google) (1):
      fprobe: Fix to allocate entry_data_size buffer with rethook instances

----
 kernel/trace/fprobe.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

