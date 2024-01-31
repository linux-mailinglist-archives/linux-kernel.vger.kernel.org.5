Return-Path: <linux-kernel+bounces-46765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9348443D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22EA285E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB6412AAE1;
	Wed, 31 Jan 2024 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkdUg28i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B33D12AAC0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717537; cv=none; b=MYOJ04cqSNx+qnkzGVxgYZpV5253Qpg8pvDK+/1c3qzicS9zvK0h9EY0kYuHAZRM0Zd6THCWQJnAw8fl4/pMr52lQpeBG9SNW+T2Y2IlHYIYnyDV1mTNSV0fh2DVzBc2O11991k/UFzFYXbDO5b24TRUUGFP9Ts9gyA8Y8yx9EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717537; c=relaxed/simple;
	bh=S1qTKH+/x2gUmwDwbwoq2bbAx6ywfZvkV7z45JdkYAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhauwpTPPCVe3ft+49iH/s/HgNMNw7N8YMSgXPreb7ajIEFZJrNsoocQK1akr8zbOb+DdseRJ16FqjHS1AghQatrXI/3naT5az1j21wB4+9T3jQYf3yymFrFi+Y6fhNCHvVq/Eoc04WDIbynYl7uCoRO4UuNbtKI8wA0PHon0Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkdUg28i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706717535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/GWpU8/PPvh6a0jaZSWCVPOPeuCzSthvQH0dRHb6u3M=;
	b=bkdUg28iIqSjIzn3711LHI3k1tt9EH3NLtYj65Ccj+caydXDOlRgvVhWL2fKDtxiQFOfPB
	p0BsdcY9uWbyT4wF+36kX3J7l8QNmFydsPDTpr9WI+jSrNVXIjlKhIT79TNCQuCn6b22Z0
	Xd3QHheg5Ya0lXou0fsbI2bFl89o3dA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-sl97ymzFM4S9JRgbCSB_qA-1; Wed, 31 Jan 2024 11:12:10 -0500
X-MC-Unique: sl97ymzFM4S9JRgbCSB_qA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1EE7185A783;
	Wed, 31 Jan 2024 16:12:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.249])
	by smtp.corp.redhat.com (Postfix) with SMTP id A4CC73C2E;
	Wed, 31 Jan 2024 16:12:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jan 2024 17:10:55 +0100 (CET)
Date: Wed, 31 Jan 2024 17:10:53 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/1] pidfd: implement PIDFD_THREAD flag for
 pidfd_open()
Message-ID: <20240131161053.GC2609@redhat.com>
References: <20240131132541.GA23632@redhat.com>
 <20240131141204.GA24130@redhat.com>
 <20240131-engel-entern-9b5c96659948@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131-engel-entern-9b5c96659948@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 01/31, Christian Brauner wrote:
>
> On Wed, Jan 31, 2024 at 03:12:04PM +0100, Oleg Nesterov wrote:
> >
> > After this patch we can easily add another feature, pidfd_poll()
> > can add, say, POLLHUP to poll_flags if the pid is "dead".
> >
> > So the user can do
> >
> > 	poll(pidfd, { .revents = POLLHUP });
> >
> > and it will block until release_task() is called and this pid is
> > no longer in use (pid_task() == NULL).
> >
> > Do you think this can be useful?
>
> Yeah, I think this is something that people would find useful. IIUC, it
> would essentially allow them to do things like wait until a task has
> been waited upon

Exactly.

OK. I'll try to make the (hopefully simple) patch on top of this one
on Friday, if Tycho agrees with V3. Will be busy tomorrow.

> * systemd completely relying on pidfds to manage services to guard
>   against any pid races.
> * Extended dbus to allow authentication via pidfds.
> * Extended policy kit to enable secure authentication of processes via pidfds.
> * Language support for pidfds: Go, Rust etc.
> * An endless number of tools that added support for them.
> * glibc support for pidfd apis.
>
> There's a bunch more. That literally obliterated whole bug classes.

Thanks for this info!

Not that I ever thouhgt that pidfd is "useless", not at all, but as I said
(and as a Perl progammer ;) I simply do not know what people actually do with
pidfds ;)

Oleg.


