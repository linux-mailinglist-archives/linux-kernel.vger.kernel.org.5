Return-Path: <linux-kernel+bounces-54728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FD384B2F7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AFAE1C23470
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21067CF18;
	Tue,  6 Feb 2024 11:01:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0521EA72;
	Tue,  6 Feb 2024 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217279; cv=none; b=RZhCDvc9gk9UFP7Vll7WLWhcXVUKc+N/5Zf7ieDNuXIhOnXFlWM/T/pFz821+O6kDfmJ9cwU49kNrcLmLauAwnf75Fk3mGKRWnP553T34egR62QRfTG3OnwwafDiklKPMhW1Cb55gMD7bnq5l7AckR4fsLpz8CDc26nCvphXEEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217279; c=relaxed/simple;
	bh=S/gp/iNk5s/SxUEGNUOUBz+7FwLwrPc2i7zkwKKt8MY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uePftiiq37Jtf6aNScrh4RqSHbfUFkFW8yu2tS3uz7dySiuz5yBkPUx/QkDIjgcmbKVpPRTTVR68ZYWB9Gkzn/4NSX2snniy8ABQXTbVrz2M2olMzgtIo0eaOizDQ0bwGeUy1ywSYL+KuozdH1pDf/KdmZJ60zXs7IwaV8yG1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3906BC433C7;
	Tue,  6 Feb 2024 11:01:17 +0000 (UTC)
Date: Tue, 6 Feb 2024 06:01:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
Subject: Re: [PATCH] tracing: use ring_buffer_record_is_set_on() in
 tracer_tracing_is_on()
Message-ID: <20240206060113.39c0f5bc@rorschach.local.home>
In-Reply-To: <yt9dsf262d2n.fsf@linux.ibm.com>
References: <20240205065340.2848065-1-svens@linux.ibm.com>
	<20240205075504.1b55f29c@rorschach.local.home>
	<yt9djznj3vbl.fsf@linux.ibm.com>
	<20240205092353.523cc1ef@rorschach.local.home>
	<yt9d34u63xxz.fsf@linux.ibm.com>
	<yt9dsf262d2n.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 06 Feb 2024 09:48:16 +0100
Sven Schnelle <svens@linux.ibm.com> wrote:

> I added some logging, and the test is not triggering this issue. So i
> assume the default of 128 cmdline entries is just to small. Sorry for
> the noise. Lets see whether we're still triggering some failures with
> the other fix applied in CI. If we do, maybe we want to increase the
> saved_cmdline_size for the ftrace test suite.

I wonder if it is a good idea to increase the size when tracing starts,
like the ring buffer expanding code. Maybe to 1024? Or is that still
too small?

-- Steve

