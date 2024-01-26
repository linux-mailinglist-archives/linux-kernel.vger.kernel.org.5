Return-Path: <linux-kernel+bounces-40190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A954083DC02
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DF27B28D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E59C1B81B;
	Fri, 26 Jan 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cV47q5tS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514171CA90
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279713; cv=none; b=i7T9i7auCtGRqzGnpXq2yJ62sZU4rWieuwTYk2+wT3bdyNAaIIkiKGmfDYFpWYg1z97+2CLZE+5cbJdS5ZouOHheReVqnp7XgTTM5covTlCfRke0nzW26cE5ctCprySO8C2joBqaa23wWmF2o16hOwsTVmNYuUAv9ih97pLPiCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279713; c=relaxed/simple;
	bh=5Mp8HJAIqERvQL0b3/83tZjCcwW56ouo++Tx5D+tlFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haHiaMitB1EZ4UkGg7DZFz83qJHj06PHBQtLoqHRpU3Rf2tkKIttgkrJ/f5ZFnNpvC7vHfZhVhsa6N3GGwkh7HrkK73iQEaTkkvIIIodh1Qz0eLGVZEVTLcVqytXSRnpPXUXC7VYGU3qeyM4pU9MNV+XFxOsF5Rr3MPEJ6nuKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cV47q5tS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706279711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gu8a9U+kDXaRGvEtVtRt5Sa1+ew9Z1jeQJa10E23ijo=;
	b=cV47q5tSfrYs4VkXLoISz0/R1SglHOxTbqCeRJMswKKRy8pjm+DJZVslXsCTL2llBhFdSo
	v+ZSxecptZg4IvcnNUsl+A1gjfY+zisLvEY1oKthKl2Hqo6roZTzgO7HBV+jdY9FxDpE5L
	NG4eVyiCU8DuBBK5Va0AbpDnzKrw7dU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-6a8axaRlOeC6WIXbPx2xyQ-1; Fri,
 26 Jan 2024 09:35:06 -0500
X-MC-Unique: 6a8axaRlOeC6WIXbPx2xyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDEB82825BAC;
	Fri, 26 Jan 2024 14:35:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.164])
	by smtp.corp.redhat.com (Postfix) with SMTP id 4E0802028CD2;
	Fri, 26 Jan 2024 14:35:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 26 Jan 2024 15:33:52 +0100 (CET)
Date: Fri, 26 Jan 2024 15:33:50 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240126143349.GD7386@redhat.com>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
 <20240126-kulinarisch-ausziehen-d2af51882d2f@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-kulinarisch-ausziehen-d2af51882d2f@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 01/26, Christian Brauner wrote:
>
> > --- a/include/uapi/linux/pidfd.h
> > +++ b/include/uapi/linux/pidfd.h
> > @@ -7,6 +7,7 @@
> >  #include <linux/fcntl.h>
> >
> >  /* Flags for pidfd_open().  */
> > -#define PIDFD_NONBLOCK O_NONBLOCK
> > +#define PIDFD_NONBLOCK	O_NONBLOCK
> > +#define PIDFD_THREAD	O_EXCL	// or anything else not used by anon_inode's
>
> I like it!
>
> The only request I would have is to not alias O_EXCL and PIDFD_THREAD.
> Because it doesn't map as clearly as NONBLOCK did.

But it would be nice to have PIDFD_THREAD in file->f_flags. Where else
can we keep it?

I chose O_EXCL because it can only be used at open time, it can never
be used or changed after anon_inode_getfile(), so we can safely do

	pidfd_file->f_flags |= PIDFD_THREAD;

in __pidfd_prepare() and then check in pidfd_poll/pidfd_send_signal.

What do you suggest instead?

Oleg.


