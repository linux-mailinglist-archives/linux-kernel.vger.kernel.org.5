Return-Path: <linux-kernel+bounces-56738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F23E584CE5D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9E62879DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6E58002B;
	Wed,  7 Feb 2024 15:47:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D641B7FBDE;
	Wed,  7 Feb 2024 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320829; cv=none; b=in4zsczbZ19tRAEAPqiwx6VxejN9G6y9N/DH+XUys3TmSh/ENeQp+aWXu/qxn5XMLDvYpeo+wQEUNyFgQDkLEhDVdmrtuBuQ/nLdzhzOOkhaodPkexUjaJx0Lk/Fcvt06gMGnMCPFW0UOs+x6ZPCJB3QmL4L1crSfWeLc1OwHjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320829; c=relaxed/simple;
	bh=OjwsOP8AG5skKI4fhs6803ooEFYrGsVmNA28weA5DaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMckhjV7R44HvAvt6JX4FkNenE8sjGbE368J1ZnGfiUzVrHjUqii6omKQOImiH3Kf/CmD3mxF32/lXU8y0ONw25zdvJDX9JpzRUUNd2kioaHvE2vqSvfgqd7zpLnE7iZyNLAKbBNmC0p3E8eGRo41t3L9S7b6eZauiWomo9GGyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7176C433F1;
	Wed,  7 Feb 2024 15:47:07 +0000 (UTC)
Date: Wed, 7 Feb 2024 10:47:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Mete Durlu <meted@linux.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: use ring_buffer_record_is_set_on() in
 tracer_tracing_is_on()
Message-ID: <20240207104703.071ee985@rorschach.local.home>
In-Reply-To: <yt9dzfwch00u.fsf@linux.ibm.com>
References: <20240205065340.2848065-1-svens@linux.ibm.com>
	<20240205075504.1b55f29c@rorschach.local.home>
	<yt9djznj3vbl.fsf@linux.ibm.com>
	<20240205092353.523cc1ef@rorschach.local.home>
	<yt9d34u63xxz.fsf@linux.ibm.com>
	<yt9dsf262d2n.fsf@linux.ibm.com>
	<20240206060113.39c0f5bc@rorschach.local.home>
	<yt9deddovn3w.fsf@linux.ibm.com>
	<20240207060923.182ecb55@rorschach.local.home>
	<9a062196-ccbe-440e-a2f9-23eb8c5eb837@linux.ibm.com>
	<20240207072812.4a29235f@rorschach.local.home>
	<yt9dzfwch00u.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 07 Feb 2024 14:33:21 +0100
Sven Schnelle <svens@linux.ibm.com> wrote:

> My assumption without reading the code is that something like this
> happens:
> 
> CPU0                             CPU1
> [ringbuffer enabled]
>                                  ring_buffer_write()
>                                      if (atomic_read(&buffer->record_disabled))
>                                             goto out;
> echo 0 > tracing_on
> record_disabled |= RB_BUFFER_OFF
> csum1=`md5sum trace`

Note, the CPU1 is performing with preemption disabled, so for this to
happen, something really bad happened on CPU0 to delay preempt disabled
section so long to allow the trace to be read. Perhaps we should have
the return of the echo 0 > tracing_on require a synchronize_rcu() to
make sure all ring buffers see it disabled before it returns.

But unless your system is doing something really stressed to cause the
preempt disabled section to take so long, I highly doubt this was the
race.

-- Steve


>                                  [adds trace entry to ring buffer,
>                                   overwriting savedcmd_lines entry because
>                                   it thinks ring buffer is enabled]
> csum2=`md5sum trace`


