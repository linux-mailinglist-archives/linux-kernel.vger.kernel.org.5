Return-Path: <linux-kernel+bounces-52419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3510C8497DE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FB4282FE0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0549C1755E;
	Mon,  5 Feb 2024 10:38:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9267517575;
	Mon,  5 Feb 2024 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707129504; cv=none; b=HczjSbV0gM0kqwGczz/c3vakOVE/8Kfj/un6xmQJOpunwdVsxLSXHBu1aZc1x5NO0nYXQf9D6t8+kj2Hiu5wcP/pd6250s9k2/OlHHCmuL03sTqz+eC4GDLq7r0vKyNdb0orjAOPq1BOs8HMfYnNn1AMEfmr2+LHzzQ8PGHo2N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707129504; c=relaxed/simple;
	bh=/QC8CAThaPcMyddwkEEQp4pIMysU99QBeEJYEmYBv94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CEd1D07rZ+MSZPLYtMITUTS4BIyHPTVLGSxzZMAvTkHoZiQKfr60b2dvK3s6gJE7tskRn+e0Wu6yjsGv+5STk6Xw76JulBJ9WtQgiNhJVSYBfQ/0xywpf/SFi2QhtC2tVUyquVb+DKpf0WOsu1AKDhkMz13l9LRzTT+dP2+2MM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90635C433C7;
	Mon,  5 Feb 2024 10:38:22 +0000 (UTC)
Date: Mon, 5 Feb 2024 05:38:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: richard clark <richard.xnu.clark@gmail.com>
Cc: nico@fluxnic.net, Mark Rutland <mark.rutland@arm.com>,
 mhiramat@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question about the ipi_raise filter usage and output
Message-ID: <20240205053819.3cf848f0@rorschach.local.home>
In-Reply-To: <CAJNi4rMpt88Gz+149wR9crzApmfUEfpS05sbOgAvOhzh2+Brbg@mail.gmail.com>
References: <CAJNi4rMpt88Gz+149wR9crzApmfUEfpS05sbOgAvOhzh2+Brbg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Feb 2024 17:57:29 +0800
richard clark <richard.xnu.clark@gmail.com> wrote:

> Hi guys,
> 
> With the ipi_raise event enabled and filtered with:
> echo 'reason == "Function call interrupts"' > filter, then the 'cat
> trace' output below messages:
> ...
> insmod-3355    [010] ....1.. 24479.230381: ipi_raise:
> target_mask=00000000,00000bff (Function call interrupts)
> ...
> The above output is triggered by my kernel module where it will smp
> cross call a remote function from cpu#10 to cpu#11, for the
> 'target_mask' value, what does the '00000000,00000bff' mean?
>  ~~~~~~~~~~~~~~

It's the CPU mask. bff is bits 101111111111 or CPUs = 0-9,11.


> 
> Another question is for the filter, I'd like to catch the IPI only
> happening on cpu#11 *AND* a remote function call, so how to write the
> 'target_cpus' in the filter expression?
> 
> I try to write below:
> echo 'target_cpus == 11 && reason == "Function call interrupts"' >
> events/ipi/ipi_raise/filter

You mean when it is sent only to CPU 11? Not when the event is
happening on CPU 11. Like the above example, the event was triggered on
CPU 10, but the mask was for all the other CPUs.

If you are looking for just CPU 11, you can do:

  echo 'target_cpus == 0x800 && reason == "Function call interrupts"'


> 
> But the 'cat trace' doesn't show anything about cpu#11 IPI info,
> although both the /proc/interrupts and the smp_processor_id() in the
> remote function shows there's IPI sent to the cpu#11.
> 


-- Steve

