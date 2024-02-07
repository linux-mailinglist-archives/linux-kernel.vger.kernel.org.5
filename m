Return-Path: <linux-kernel+bounces-56483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D05784CAB6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881691F27F1E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0835A0F5;
	Wed,  7 Feb 2024 12:28:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4161759B5B;
	Wed,  7 Feb 2024 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308900; cv=none; b=nYXRs43CkKR12/sySfrnvj6cWkzCEO/ID+64QCiBCPOhnhe0TBOEnBRfsLTGfAdGkehfhisBHISy726ZNVlTRE3jiZaIcKPStMqDmC5UubJ+n/Kdwy0dQUqzwglRKY1GMLoon8jX7i2mPS9iRnT9hIOcghpGS7MIh931Ikjrocw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308900; c=relaxed/simple;
	bh=bB8ao9k5FwzcKPDglzpXKInrfcRJlfz/wXfTNITCd4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdLGvn3ujPhtOXo4O7mFhwWPV6+C3tSRaA81e+4LM3V0PV+t6zs0XLgxfD1s0/H5Rqv6+IxQzFk+rC0wtlntLxs3Md9aMB3imZcaHb8XISHfKsXToAfbfnKVxbn2TjnROIDyP9oEV/jGQjV9arQ78SUy6fNaChYKpNakqS7pT58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE19C43390;
	Wed,  7 Feb 2024 12:28:17 +0000 (UTC)
Date: Wed, 7 Feb 2024 07:28:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: use ring_buffer_record_is_set_on() in
 tracer_tracing_is_on()
Message-ID: <20240207072812.4a29235f@rorschach.local.home>
In-Reply-To: <9a062196-ccbe-440e-a2f9-23eb8c5eb837@linux.ibm.com>
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
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 13:07:36 +0100
Mete Durlu <meted@linux.ibm.com> wrote:

> wouldn't the following scenario explain the behavior we are seeing.
> When using event triggers, trace uses lockless ringbuffer control paths.
> If cmdline update and trace output reading is happening on different
> cpus, the ordering can get messed up.
> 
> 1. event happens and trace trigger tells ring buffer to stop writes
> 2. (on cpu#1)test calculates checksum on current state of trace
>     output.
> 3. (on cpu#2)not knowing about the trace buffers status yet, writer adds
>     a one last entry which would collide with a pid in cmdline map before
>     actually stopping. While (on cpu#1) checksum is being calculated, new
>     saved cmdlines entry is waiting for spinlocks to be unlocked and then
>     gets added.
> 4. test calculates checksum again and finds that the trace output has
>     changed. <...> is put on collided pid.

But the failure is here:

on=`cat tracing_on`
if [ $on != "0" ]; then
    fail "Tracing is not off"
fi

csum1=`md5sum trace`
sleep $SLEEP_TIME
csum2=`md5sum trace`

if [ "$csum1" != "$csum2" ]; then
    fail "Tracing file is still changing"
fi

1. tracing is off
2. do checksum of trace
3. sleep
4. do another checksum of trace
5. compare the two checksums

Now how did they come up differently in that amount of time? The
saved_cmdlines really should not have been updated.

(note, I'm not against the patch, I just want to understand why this
test really failed).

-- Steve

