Return-Path: <linux-kernel+bounces-52682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A16F849B5E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070C7282CC4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5966B210ED;
	Mon,  5 Feb 2024 13:06:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95C210E6;
	Mon,  5 Feb 2024 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138375; cv=none; b=t5SccQdXfUJP6dl/Grrmbe3gOSvfSphFOeT1n/lAIoydedf3o/OHqbNu2wLWM2meO6Lh/KZ75C1iRrWD6AD5IJZR3+rpWbzsH+Dr2ii9Eim7zGMjd8IJCGxmoSQPKpE8IM4iYkfgNU8fE0lqsAu0xWJjM3RBj0DqFxl7HPDiOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138375; c=relaxed/simple;
	bh=jNCvi3Kx1udjn5zsmKNV0axNM8kCnrRuz3EFoPq0zNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jv2667yYsz8SrzfHnx26YrN3dcQb+lhU5xGxb4U4A8aYL26vsBLKfu+MZlOQGxitJas13NMPa7NllfwUeUgcADl9oZPx3Tg5dFp2Gmn+As/xZuT/pQlju8R48x819JcTlyc4EN+hX0tvmfzV3fszFMHc21jplKj9NfqkpphJbSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D183C433F1;
	Mon,  5 Feb 2024 13:06:13 +0000 (UTC)
Date: Mon, 5 Feb 2024 08:06:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: richard clark <richard.xnu.clark@gmail.com>, nico@fluxnic.net,
 mhiramat@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question about the ipi_raise filter usage and output
Message-ID: <20240205080609.563df00f@rorschach.local.home>
In-Reply-To: <ZcC4aWWKFU1NgrZM@FVFF77S0Q05N>
References: <CAJNi4rMpt88Gz+149wR9crzApmfUEfpS05sbOgAvOhzh2+Brbg@mail.gmail.com>
	<ZcC4aWWKFU1NgrZM@FVFF77S0Q05N>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Feb 2024 10:28:57 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> > I try to write below:
> > echo 'target_cpus == 11 && reason == "Function call interrupts"' >
> > events/ipi/ipi_raise/filter  
> 
> The '=' checks if the target_cpus bitmap *only* contains CPU 11. If the cpumask
> contains other CPUs, the filter will skip the call.
> 
> I believe you can use '&' to check whether a cpumask contains a CPU, e.g.
> 
> 	'target_cpus & 11'

11 == 0xb = b1011

So the above would only be true for CPUs 0,1 and 3 ;-)

I think you meant: 'target_cpus & 0x800' 

I tried "1 << 11' but it appears to not allow shifts. I wonder if we should add that?

-- Steve

