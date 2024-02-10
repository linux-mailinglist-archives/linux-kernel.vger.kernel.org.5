Return-Path: <linux-kernel+bounces-60480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB18850575
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8F5B24DDC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76745CDC2;
	Sat, 10 Feb 2024 16:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQPe1VQF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414395C908
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707583980; cv=none; b=tvQRdvCuU1c4ZLMuECdx9Dvxaf1rr9CZbNzKsthDW8i5meX/oJYGsGmWIw0ypgGcycQ38G5Zp6dmQ3h6eErVfYLZ5Rum0MUWWAW11/Gy8eBS1UTRzuRtJ4/86FBb8jlx/iU7Ib5sCiYGnbBa7jQjYN+udoA/fY9UxB6lDeAiBDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707583980; c=relaxed/simple;
	bh=0JWG02bhsd1Y1pLGIUQfKn5oHH6Uh5NErnSElNVvr5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OctcWcaJQ1QzIHxakZaPT/8EWTXblU68kX1LVtjq3Bad4z4hRFlwPFNZnWeuFbEqz3dlwnB1ABGVwWL1leu/h3AL6TLMgG92ckK6qlBIsSlbL4pAaiAxeXlXmbDgAGoSDjRMLn4BpuBWxZ6WoUFkWa14xFQJiuybvs7EFHjWHuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQPe1VQF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707583977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/JHi9CwFInkSQeN39Fd9gZFUZtv3HNk0+Aar5uXCB3Y=;
	b=bQPe1VQFKyexV/Odx1cykmjjcN9wdEb7WKEkSbbNZdmPAaeBz1gbNV62nLrCecfvTd/DyF
	EDjoZg7F4TaGCCb2a2qtjVbayLoL5z+ztwhNpkJ7Mg2dU9JSH5/3XHm4V0wRKdNs6v5Cfi
	4tf+lvJRrqtwcBMrEIklru3sJQgKAHM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-sw7yyYNVMHS622X-z7BN4g-1; Sat, 10 Feb 2024 11:52:52 -0500
X-MC-Unique: sw7yyYNVMHS622X-z7BN4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C23C185A780;
	Sat, 10 Feb 2024 16:52:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with SMTP id 70E561C10C0C;
	Sat, 10 Feb 2024 16:52:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 10 Feb 2024 17:51:36 +0100 (CET)
Date: Sat, 10 Feb 2024 17:51:33 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240210165133.GD27557@redhat.com>
References: <20240209130650.GA8048@redhat.com>
 <20240209-stangen-feuerzeug-17c8662854c9@brauner>
 <20240209154305.GC3282@redhat.com>
 <20240209-radeln-untrennbar-9d4ae05aa4cc@brauner>
 <20240209155644.GD3282@redhat.com>
 <20240210-abfinden-beimessen-2dbfea59b0da@brauner>
 <20240210123033.GA27557@redhat.com>
 <20240210-dackel-getan-619c70fefa62@brauner>
 <20240210131518.GC27557@redhat.com>
 <20240210-chihuahua-hinzog-3945b6abd44a@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210-chihuahua-hinzog-3945b6abd44a@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 02/10, Christian Brauner wrote:
>
> On Sat, Feb 10, 2024 at 02:15:18PM +0100, Oleg Nesterov wrote:
> > On 02/10, Christian Brauner wrote:
> > >
> > > The question is what is more useful for userspace when they do:
> > > pidfd_send_signal(1234, PIDFD_SEND_PROCESS_GROUP)?
> > >
> > > (1) They either mean to signal a process group that is headed by 1234.
> >
> > Yes, this is what I had in mind, see also another email from me.
> > Simple, clear, and matches kill(-1234).
>
> I went for a walk and kept thinking about this and I agree with you.
> It will require that 1234 will be a process group leader but I think
> that this is ok to require that.

Yes... but I am starting to understand why you mentioned the new
open PIDFD_PROCESS_GROUP flag... perhaps we can do something like
this later, but this needs more thinking.

> +	if (type == PIDFD_SIGNAL_PROCESS_GROUP)
> +		ret = kill_pgrp_info(sig, &kinfo, pid);

I guess you meant

	if (type == PIDTYPE_PGID)

other than that,

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


