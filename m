Return-Path: <linux-kernel+bounces-33636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642EC836C86
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A12E1F25519
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF34E3DBAB;
	Mon, 22 Jan 2024 15:55:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C0F3DB9E;
	Mon, 22 Jan 2024 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938935; cv=none; b=GX1ZIgxzeR50XI//OmUVPNBUe4Dn5ZadDjVeJKSiYLjaNnvfJse8Ge7b8t6WI5wSLCe1uZj4xIWoPEhA5+UA8CiPjhMeoUD1miFFDfj8usOqb/XyEb72X+IUSytALn6dB5NFMdFmT4+vxHU2bHO2szBdqpf8zaofGMY0MjxI5RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938935; c=relaxed/simple;
	bh=wFHV5w4eFFMMNTf7evJdhihmrKVVk9HXlU999A05S6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3OjpJmSWR7mdyZkcFgxValS/RpxsC9NJIU5Me/8EwWAdECqqJsS7ABTjTYPfWJYZAH0KJMjA/76zolc+OF2DDOe3CtInYOpdnTxf8jF/EIRoiIhgfqrhmjsbV2RMj17jHmwXAOyIsIuZnIu7p/WnpF28VX3CZtEa7qPTSMZQro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6071DC433C7;
	Mon, 22 Jan 2024 15:55:33 +0000 (UTC)
Date: Mon, 22 Jan 2024 10:57:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dennis Zhou <dennis@kernel.org>, Tejun
 Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Andrew Morton
 <akpm@linux-foundation.org>, George Guo <guodongtai@kylinos.cn>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH] percpu: improve percpu_alloc_percpu_fail event trace
Message-ID: <20240122105700.05e5ee46@gandalf.local.home>
In-Reply-To: <20240122073629.2594271-1-dongtai.guo@linux.dev>
References: <20240122073629.2594271-1-dongtai.guo@linux.dev>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 15:36:29 +0800
George Guo <dongtai.guo@linux.dev> wrote:

> From: George Guo <guodongtai@kylinos.cn>
> 
> Add do_warn, warn_limit fields to the output of the
> percpu_alloc_percpu_fail ftrace event.
> 
> This is required to percpu_alloc failed with no warning showing.

You mean to state;

  In order to know why percpu_alloc failed but produces no warnings, the
  do_warn and warn_limit should be traced to let the user know it was
  rate-limited.

Or something like that?

Honestly, I don't think that the trace event is the proper place to do
that. The trace event just shows that it did fail. If you are confused to
why it doesn't print to dmesg, then you can simply add a kprobe to see
those values as well.

-- Steve

> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---

