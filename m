Return-Path: <linux-kernel+bounces-104486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B70687CE97
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369691F228A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A78A374F0;
	Fri, 15 Mar 2024 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="P9AovEa4"
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F44A28E31
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512376; cv=none; b=dX0y9tsKJw6C/KnGeVG2ylm5yAr7PsGC52XSgFhojiC9g2SS5CUVFmLqoTE4kAe6TbK6mhNHfjPv/kqg2wwOeq3P3suKwldXBZ7r6VvDWCvhSc7KLOTq3VkIzC2rUFbUHUexYZTE74jw33ZKKEhMh3zTnTwBZReNnTs0AMYPZSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512376; c=relaxed/simple;
	bh=0Pc/THBqWx+ITIiBxPEFl4/7az1HUvbjHA/bsKIC7/8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hx/k4dtGVHzEPg9G3M2hZ4RuGUaXGAH0LlmtsEbjLkMKxkEIITRjEhaPYtsgpMEtJClRF15PM8DKk7d4gx6q6E2z8GREu1iTE1I8TTj8wd7zWeALXn8xCgkfUehkqEvr4qvZGWgjKGWa2qkNSWyMxlWt0Fa1YxPv4M4XhfNRSLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=P9AovEa4; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=eicCXfRMj0HqboV6DQdhIV7VLLlwcoV4+0bYeQUIqo0=; b=P9AovEa4l44Sgo/c95yscj3mQh
	+8C5tbsuR7rsLR1j56fsy3X2a7fPMWASs+2cSqZUxJJ/XTcQ+/dEzL1uxmX/koQ6FiNWzJJG+aWYz
	l7ZPRoWdNTmhGIXh46Ao5QFAS5tLPTF8qZVqylj58olmIC1B1JjFLuyCp1/5e1HzdgAjNgnttex2K
	CLjatNmvcsLaajSSgOMcVmLwv7nQaOin2UlDMPx6mo+CuSneRjmQRkCJSufL+qG57s9anHxRupfT4
	mrv3PuD0UHDzMrP3wf8Bb5aNhEeZ7v6kIy3FiSmuwNWfDNWxqdbiREtl83Q9X4qunkyd0aPMT8izO
	2aFrhM+A==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rl7wP-000PHK-Mw; Fri, 15 Mar 2024 14:49:45 +0100
Received: from [178.197.249.11] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rl7wP-0037bz-0s;
	Fri, 15 Mar 2024 14:49:45 +0100
Subject: Re: [PATCH] MAINTAINERS: Update email address for Quentin Monnet
To: qmo@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
References: <20240315133606.65971-1-qmo@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <38a00cd0-b7fb-8006-9fb8-2c19f37c170a@iogearbox.net>
Date: Fri, 15 Mar 2024 14:49:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240315133606.65971-1-qmo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27215/Fri Mar 15 09:31:18 2024)

On 3/15/24 2:36 PM, qmo@kernel.org wrote:
> From: Quentin Monnet <qmo@kernel.org>
> 
> With Isovalent being acquired by Cisco, I expect my related email
> address to disappear sooner or later. Update my email entries in
> MAINTAINERS and .mailmap with my kernel.org address instead.
> 
> Signed-off-by: Quentin Monnet <qmo@kernel.org>

I'll queue it up via bpf, thanks!

> ---
>   .mailmap    | 3 ++-
>   MAINTAINERS | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 2216b5d5c84e..02cd23b76eda 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -497,7 +497,8 @@ Prasad Sodagudi <quic_psodagud@quicinc.com> <psodagud@codeaurora.org>
>   Punit Agrawal <punitagrawal@gmail.com> <punit.agrawal@arm.com>
>   Qais Yousef <qyousef@layalina.io> <qais.yousef@imgtec.com>
>   Qais Yousef <qyousef@layalina.io> <qais.yousef@arm.com>
> -Quentin Monnet <quentin@isovalent.com> <quentin.monnet@netronome.com>
> +Quentin Monnet <qmo@kernel.org> <quentin.monnet@netronome.com>
> +Quentin Monnet <qmo@kernel.org> <quentin@isovalent.com>
>   Quentin Perret <qperret@qperret.net> <quentin.perret@arm.com>
>   Rafael J. Wysocki <rjw@rjwysocki.net> <rjw@sisk.pl>
>   Rajeev Nandan <quic_rajeevny@quicinc.com> <rajeevny@codeaurora.org>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 76b3714710c2..02dadb5de58b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3967,7 +3967,7 @@ F:	kernel/bpf/bpf_lru*
>   F:	kernel/bpf/cgroup.c
>   
>   BPF [TOOLING] (bpftool)
> -M:	Quentin Monnet <quentin@isovalent.com>
> +M:	Quentin Monnet <qmo@kernel.org>
>   L:	bpf@vger.kernel.org
>   S:	Maintained
>   F:	kernel/bpf/disasm.*
> 


