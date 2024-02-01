Return-Path: <linux-kernel+bounces-48427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36044845BF1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B2C1C26D9F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6530626A3;
	Thu,  1 Feb 2024 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mZeVk456"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C075F494;
	Thu,  1 Feb 2024 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802273; cv=none; b=NYh6TsMC1C28BneU66NhuegR2+qMmXlTyN8DmKWKD8LJ8Phfer22nuU0FnJNX+Bw4EwjuSly5egkWRqn/goGfIsFFjHaVmvNdfZafuEiMRLLb6YrlUZJy9Okxfniz4wQbiu3QYkYn0f9o2fTWAZ7o+nqlfZcsAI0z3EmC/DPoVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802273; c=relaxed/simple;
	bh=cFF+cZZhYXujuj65xq6IcWbd/D/Sk1miTqOWKe1WC0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDEri6hGzaQNtoV6kdy4BZW1uLQiyltd5isHBVjMObSzNKJLaA+r/647AbUW4ohK+FoaYikbxhnqt6XeN7WX3z+xYSSQDoAj9C1VPB7KaY57R07sB/Xjka6lHhHmipsqR/wfBlFzStR4N8ZzzaSAdB8dB6brQvMZUPbmRcwwEmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mZeVk456; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5007EC433F1;
	Thu,  1 Feb 2024 15:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706802272;
	bh=cFF+cZZhYXujuj65xq6IcWbd/D/Sk1miTqOWKe1WC0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mZeVk456WY4ZB6GKYrS3EUkJLgEevilMSVtyEsxmfk2o7uDku7H2+7jEUBUMQvtV7
	 toSu0B0VREbRzofoAPJ+3MYbn7rPZmua1gD8L2oDmhGDJNTq2fN9a4XbIQfM4N+kCH
	 5DdwCTalYRIPKw/Fen0kviDGTw7YN+Z+HV0LmVhU=
Date: Thu, 1 Feb 2024 07:44:31 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tracing/timerlat: Move hrtimer_init to timerlat_fd open()
Message-ID: <2024020109-duffel-finally-4f0b@gregkh>
References: <7324dd3fc0035658c99b825204a66049389c56e3.1706798888.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7324dd3fc0035658c99b825204a66049389c56e3.1706798888.git.bristot@kernel.org>

On Thu, Feb 01, 2024 at 04:13:39PM +0100, Daniel Bristot de Oliveira wrote:
> Currently, the timerlat's hrtimer is initialized at the first read of
> timerlat_fd, and destroyed at close(). It works, but it causes an error
> if the user program open() and close() the file without reading.

What error exactly happens?  Userspace, or the kernel crashes?

thanks,

greg k-h

