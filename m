Return-Path: <linux-kernel+bounces-59266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD07484F442
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C2128EB67
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6756A28DD8;
	Fri,  9 Feb 2024 11:08:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC3720311;
	Fri,  9 Feb 2024 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476900; cv=none; b=sAz+ZKYfkw+KVuPdIZqeKJi0I/NM5GriS9wcTQNnfA1QkKYmXwTIVdGcA0Ua6TfVFa8mzSQ2xIBAVabKw4JQB2bJySFNAijbmOXqAcrtzTcsFXWJwrN1q81++gU6TTton4V+sTJqv4AFy4fct/x5Le+rDAEI+0ifLfi/fp/zZFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476900; c=relaxed/simple;
	bh=FiJFCAzhA8MBSZzF9YaUsWepIiKIPum0C7stDf9fpaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JD9F7BoANZCkKJF18j8v4uomgjo9D+TYWPzM7KgcUDahsykfUEZS1gWOwESQgj70LD4tL9hDPEGAO0nKNo75YqRQzqLD1YDC0qts5cyCUIHaQUGJGDiaBiameSUY4qH3zKTiJVyrHDz5tCoQzELRJWMLRK7GZijV791PMqN5OZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB95C433F1;
	Fri,  9 Feb 2024 11:08:17 +0000 (UTC)
Date: Fri, 9 Feb 2024 06:08:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org, Vincent
 Donnefort <vdonnefort@google.com>, Sven Schnelle <svens@linux.ibm.com>,
 Mete Durlu <meted@linux.ibm.com>
Subject: Re: [for-linus][PATCH 2/2] tracing: Fix wasted memory in
 saved_cmdlines logic
Message-ID: <20240209060814.4a75e4cd@rorschach.local.home>
In-Reply-To: <20240209102255.462566699@goodmis.org>
References: <20240209102220.255052617@goodmis.org>
	<20240209102255.462566699@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 09 Feb 2024 05:22:22 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

>  	s->map_cmdline_to_pid = kmalloc_array(val,
>  					      sizeof(*s->map_cmdline_to_pid),
>  					      GFP_KERNEL);
> -	if (!s->map_cmdline_to_pid)
> -		return -ENOMEM;
> -

The above was accidentally removed. Putting it back (with an update for
the new algorithm) and retesting now.

-- Steve

