Return-Path: <linux-kernel+bounces-48659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 300F0845F71
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2501C293E4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178ED12B145;
	Thu,  1 Feb 2024 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yW9h8rcu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F08527A;
	Thu,  1 Feb 2024 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810761; cv=none; b=QEkfayjoIIUEll3NLni0qyjGlZcJCBWq7rYXLe8//wIKssLxpx5BxcN03amxI3i/pMMw/mEHmkBwPUApUYcWiztMKkeYk2qTFXE/3wSU9smpsls/Y3x4orVnSQLuL6LO6QEmReLIr7pvpbKLRjmaU2cPRxOROzGa8p2KciIDUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810761; c=relaxed/simple;
	bh=fkeFsHgWwEit3Sw9Uz4fXI9/KvhF8HPRnkCbIJwN+E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIQwuB55RC+cUsmPmLicAFsdWz+EfakQVLeXFXkCOUg1RgzcsIwMP+EXkT66hOYxe08jTO0KjQD40r1+fg3Ee1T6orM3dGtf+Fx15FMV+Iopa1JrLP2acopedvkW8gqTi8lUT9FK7ePnUhSPnPUeY16g/zERstej0K51s9SpW9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yW9h8rcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A3FC433F1;
	Thu,  1 Feb 2024 18:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706810760;
	bh=fkeFsHgWwEit3Sw9Uz4fXI9/KvhF8HPRnkCbIJwN+E4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yW9h8rcunQJwiS6e0Wzc4oFIdmG3JQ5ZSCGcMwS6XireO/QHPfCN3XdJXoDy339nq
	 pATXt0FCcqVR6JRRVZzg7F3yVVRee+ax/Da0tzHcWnIFaP8mhZqaz2BnWXbFWeLR/l
	 N45AE/qxkEBKlTGNICdH5cfYDiVbZomsB7cNFmo0=
Date: Thu, 1 Feb 2024 10:05:59 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tracing/timerlat: Move hrtimer_init to timerlat_fd open()
Message-ID: <2024020122-uncombed-moody-a96d@gregkh>
References: <7324dd3fc0035658c99b825204a66049389c56e3.1706798888.git.bristot@kernel.org>
 <2024020109-duffel-finally-4f0b@gregkh>
 <05c12163-d348-4615-a9e3-f36787629e0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05c12163-d348-4615-a9e3-f36787629e0e@kernel.org>

On Thu, Feb 01, 2024 at 05:02:56PM +0100, Daniel Bristot de Oliveira wrote:
> On 2/1/24 16:44, Greg KH wrote:
> > On Thu, Feb 01, 2024 at 04:13:39PM +0100, Daniel Bristot de Oliveira wrote:
> >> Currently, the timerlat's hrtimer is initialized at the first read of
> >> timerlat_fd, and destroyed at close(). It works, but it causes an error
> >> if the user program open() and close() the file without reading.
> > 
> > What error exactly happens?  Userspace, or the kernel crashes?
> 
> sorry, kernel crash:
> 
> # echo NO_OSNOISE_WORKLOAD > /sys/kernel/debug/tracing/osnoise/options
> # echo timerlat > /sys/kernel/debug/tracing/current_tracer
> 
> # cat ./timerlat_load.py
> #!/usr/bin/env python3
> 
> timerlat_fd = open("/sys/kernel/tracing/osnoise/per_cpu/cpu0/timerlat_fd", 'r')
> timerlat_fd.close();
> 
> # ./taskset -c 0 ./timerlat_load.py
> <BOOM>

Then obviously, this is a real, functional, change, so say so in the
kernel changelog :)

thanks,

greg k-h

