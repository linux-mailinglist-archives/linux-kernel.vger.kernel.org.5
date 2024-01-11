Return-Path: <linux-kernel+bounces-23873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3D582B30A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CBB1C23E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516AF50253;
	Thu, 11 Jan 2024 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="KY878Q+0"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBC04D5B2;
	Thu, 11 Jan 2024 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1704990898;
	bh=iptWAYX6bX/a++7Sbagn8Qw6LW3EjeeZBFrURsz1XMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KY878Q+0xUFoEvDQnMBIL4Ovva3pvUTwD8MzXRMMcEdtdzEBFKNuax0FWmjXQVh1R
	 HJ2zraSqBHHxBJ799le8UYcmNAvrOMCcEQZdVTggC+m2HQTRZeWMxTSgjfWIIVNOwm
	 tYFH8Iy3WPtFiz35HRnEC2CePhLlq5pM6tQUCk+6sCfmdXpW23poc+UxpuiRcesI9n
	 7FzMAcwMz1bK4vY0VolVr034VOQ05XL4o6PkDZUETw9zracMli/gdbZTLPEQrgkIXy
	 +hF5LTB1QLo1axF2l/TCUJVyBKPd08Mkk4N5WsxeaQVUdY2CfVlmqk1Ubi67T552e/
	 tkLDE7qnDVgtg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4T9qyV2kSkzKZk;
	Thu, 11 Jan 2024 11:34:58 -0500 (EST)
Message-ID: <c3dba53f-66de-43f5-9b82-38aa807da67a@efficios.com>
Date: Thu, 11 Jan 2024 11:34:58 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Content-Language: en-US
To: Vincent Donnefort <vdonnefort@google.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com
References: <20240111161712.1480333-1-vdonnefort@google.com>
 <20240111161712.1480333-3-vdonnefort@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240111161712.1480333-3-vdonnefort@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-11 11:17, Vincent Donnefort wrote:
> In preparation for allowing the user-space to map a ring-buffer, add
> a set of mapping functions:
> 
>    ring_buffer_{map,unmap}()
>    ring_buffer_map_fault()
> 
> And controls on the ring-buffer:
> 
>    ring_buffer_map_get_reader()  /* swap reader and head */
> 
> Mapping the ring-buffer also involves:
> 
>    A unique ID for each subbuf of the ring-buffer, currently they are
>    only identified through their in-kernel VA.
> 
>    A meta-page, where are stored ring-buffer statistics and a
>    description for the current reader
> 

Hi Vincent,

The LTTng kernel tracer has supported mmap'd buffers for nearly 15 years [1],
and has a lot of similarities with this patch series.

LTTng has the notion of "subbuffer id" to allow atomically exchanging a
"reader" extra subbuffer with the subbuffer to be read. It implements
"get subbuffer" / "put subbuffer" ioctls to allow the consumer (reader)
to move the currently read subbuffer position. [2]

It would not hurt to compare your approach to LTTng and highlight
similarities/differences, and the rationale for the differences.

Especially when it comes to designing kernel ABIs, it's good to make sure
that all bases are covered, because those choices will have lasting impacts.

Thanks,

Mathieu

[1] https://git.lttng.org/?p=lttng-modules.git;a=blob;f=src/lib/ringbuffer/ring_buffer_mmap.c
[2] https://git.lttng.org/?p=lttng-modules.git;a=blob;f=src/lib/ringbuffer/ring_buffer_vfs.c

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


