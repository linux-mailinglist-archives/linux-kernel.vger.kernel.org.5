Return-Path: <linux-kernel+bounces-118956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F64488C1E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A3C1C39F9D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A1C7175A;
	Tue, 26 Mar 2024 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NXOHwlrM"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7526BB5D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455536; cv=none; b=KgRLCVCTc3axJ+WrU87gKdmj97iR5/AqGDJm0E7MUiSkgpRYbAVtfiVdjUozna3i3Y9u4003NIhzuDzyrfMQdW4xNNTCberACjrVwTpBHdcJKDByHDkarvnGcgm3/XqEumzf6M7sFqsstwIodnbiye1PFCmnCo7XzEs1S4nMZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455536; c=relaxed/simple;
	bh=9rVUUhguyKYMjkeTWxNxhL0yTS4z2tHrtGbc79u6mko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnsmZWrmTgKaPV0ERcTmCcjjMg3LsK3e7NsqxlkfCHJAaRpwPYppo/jhz353smTRYxEmiwcOhlqXpMAk0fHfJgGdSHg0Te3IvRvsGN1qX+nMwJjRgwjIvnRZLs6mr38ioQZd5IKrNt5bTZnnEuT4CjJZY8e7B8tFA5iDeW3sgus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NXOHwlrM; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 880F02C922;
	Tue, 26 Mar 2024 08:18:49 -0400 (EDT)
	(envelope-from adamg@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=9rVUUhguyKYMjkeTWxNxhL0yTS4z2tHrtGbc79u
	6mko=; b=NXOHwlrMWUP7qjUopdi3LnPUUiyMrHbjOrHxw9nV7K+9jYBWy8YFJp6
	32GlGuJiiDLm0er1k20roY0S0N9i9QoI7DTK2IWm34F+IiEYbDTdOB9sKvQ027aL
	CuMLraUvew8rGNaRmLtGKlbbWCEt6lw0qsbqWOJf0OMNgWHnEu3g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 72CA82C921;
	Tue, 26 Mar 2024 08:18:49 -0400 (EDT)
	(envelope-from adamg@pobox.com)
Received: from pogo.deviceside.com (unknown [71.19.144.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1503D2C91F;
	Tue, 26 Mar 2024 08:18:46 -0400 (EDT)
	(envelope-from adamg@pobox.com)
Received: from iguana.24-8.net (99-122-168-208.lightspeed.irvnca.sbcglobal.net [99.122.168.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: iguana@pogo.deviceside.com)
	by pogo.deviceside.com (Postfix) with ESMTPSA id 89215C01CE;
	Tue, 26 Mar 2024 05:18:44 -0700 (PDT)
Date: Tue, 26 Mar 2024 05:18:32 -0700
From: Adam Goldman <adamg@pobox.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: option to log bus reset initiation
Message-ID: <ZgK9GNLURNg63zRU@iguana.24-8.net>
References: <Zfqo43xhFluOgO01@iguana.24-8.net>
 <20240325004134.GA21329@workstation.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325004134.GA21329@workstation.local>
X-Pobox-Relay-ID:
 FE53D1C2-EB6A-11EE-82F6-A19503B9AAD1-07713566!pb-smtp21.pobox.com

Hi Takashi,

On Mon, Mar 25, 2024 at 09:41:34AM +0900, Takashi Sakamoto wrote:
> Now we have two debug parameters per module for the slightly-similar
> purpose. In my opinion, it is a pretty cumbersome to enable them when
> checking bus-reset behaviour. I think it is time to investigate the other
> way.
> 
> Linux Kernel Tracepoints[2] is one of options. Roughly describing, the
> tracepoints mechanism allows users to deliver structured data from kernel
> space to user space via ring-buffer when enabling it by either sysfs or
> kernel command-line parameters. Linux kernel also has a command-line
> parameter to redirect the human-readable formatted data to kernel log[3].
> I think it is suitable in the case.
> 
> It requires many work to replace the existent debug parameter of
> firewire-ohci, while it is a good start to work just for bus-reset debug.
> The data structure layout should be pre-defined in each subsystem, thus we
> need to decide it. In my opinion, it would be like:
> 
> ```
> struct bus_reset_event {
>     enum reason {
>         Initiate,
> 	Schedule,
> 	Postpone,
> 	Detect,
>     },
>     // We can put any other data if prefering.
> }
> ```

Maybe these should be four separate trace events?

> Would I ask your opinion about my idea?

It seems that tracepoints are the modern way to make debugging logs, so 
if we want to modernize the FireWire driver, we should replace the 
existent logging with tracepoints.

-- Adam

