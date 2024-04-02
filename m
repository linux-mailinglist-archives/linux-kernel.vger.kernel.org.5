Return-Path: <linux-kernel+bounces-128248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC38895848
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE961C220D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3627513174F;
	Tue,  2 Apr 2024 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="CL6v63oR"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D62A1292CA;
	Tue,  2 Apr 2024 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072002; cv=none; b=liG1h7kj/cVEJG+rRy8fd5V+C1Yfv1wIpYvRXFiy5UhzvqmNe/b6Zy9bN4baNJLDILYapBQk8Y8TSMbOqaRMOsYlm+Ye0fmTDfCzQB7BaMO/hxmOj5cqn1uMUVfYcY52JZNiiifIVpYYMF1HcZ6Cf2ym8tO7HhExr3UnGVx98as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072002; c=relaxed/simple;
	bh=nCxLLPJHebodPG2k3MpRrm+DJLqcXUj28bzwSsbOYqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HuZHXyabXshO1F1pWya4S+f8pqeAUtr9LnhtkYx8XVwA9YkhAncvsYMT5Xml144WCy19EJwig4+wzl5qSmOTcGmGbv07BFs6wiVYiqU7cttlOBRwyfe7heUK7Meo962APwSahAz8FzGoscJjsqPTF4wcPrClrtWWE34uJb9gGec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=CL6v63oR; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6941547C1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1712072000; bh=j4ZZRIZKI5PCRswsmoJpAy8RY59uVx96GRTr8tMX/CI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CL6v63oRzhx++bViJYDfvGYqKctwQfF/y8Zr8jf+WTCyOraK1NL713qBFdSRQV5II
	 QNmjksvDSuAOCeTGYiEOFzUXUwVMCDnbQmRePI5YhOtpAVQ1+SX9PeY/qA8Uhf8Gxr
	 9mH8lei+MzzqdTBco2ZBOWmFOXDuON/mW/M0PAs7nGJJmX8BL4vMqv9OKvkbrKco2t
	 kh1UEc7utCGAqTu+qTb17tnpfd4+xkaauHkzxjfg695mcddcBaEKs5Zbq2/m/p5HWR
	 JN0v7SJ+m9guHDyqCVA2qkE510CI+09mfS/iCxaydiwgiMRmSqQSQP4A/vuoKW2EDt
	 0ouMQpJHRsjHg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6941547C1D;
	Tue,  2 Apr 2024 15:33:20 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sarat Mandava <mandavasarat@gmail.com>, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, rostedt@goodmis.org
Cc: Sarat Mandava <mandavasarat@gmail.com>, linux-doc@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 shuah@kernel.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH] trace doc: Minor grammatical correction
In-Reply-To: <20240321112757.17502-1-mandavasarat@gmail.com>
References: <20240321112757.17502-1-mandavasarat@gmail.com>
Date: Tue, 02 Apr 2024 09:33:19 -0600
Message-ID: <87le5vwzi8.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sarat Mandava <mandavasarat@gmail.com> writes:

> Use the correct relative pronoun.
>
> Signed-off-by: Sarat Mandava <mandavasarat@gmail.com>
> ---
>  Documentation/trace/tracepoints.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/trace/tracepoints.rst b/Documentation/trace/tracepoints.rst
> index 0cb8d9ca3d60..decabcc77b56 100644
> --- a/Documentation/trace/tracepoints.rst
> +++ b/Documentation/trace/tracepoints.rst
> @@ -27,7 +27,7 @@ the tracepoint site).
>  
>  You can put tracepoints at important locations in the code. They are
>  lightweight hooks that can pass an arbitrary number of parameters,
> -which prototypes are described in a tracepoint declaration placed in a
> +whose prototypes are described in a tracepoint declaration placed in a
>  header file.
>  

Applied, thanks.

jon

