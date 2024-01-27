Return-Path: <linux-kernel+bounces-41374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD6883EFC3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC001F23F35
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4A72E62D;
	Sat, 27 Jan 2024 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qr0ZPAm3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A522E41A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706383970; cv=none; b=oZb7w4QqgiM/pZe3RYZWIyDmqZjSilOkIP9g6S5KBVmLCAHrIoIvAMY9WIewAR2uBU2ey7+PWUm6pR+o2nlF9Scj3JzfqWdFhyDwJIizL36ukBIWwfocd+miohHq5BsIiG7UBqQivUCasd0IBPXtcgiQ4mDGxGHR/iXzfK3Wsp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706383970; c=relaxed/simple;
	bh=O+26wNDTbnhxQ0dT1QMv9vCHeo7qkq4db2h6R0uH6/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEb+vHfIAKVDS3aqP5x0EKxfG8FgnTO6gpRDNlTb/oOp7u4SoQFZeLmcgDp2RVx+joir/PmvjAkq5JS7ZXW8i45MWL8YqTD0UZ5xr8artQl++Jrep4rywQvwjBqGABLFORbgrF54yVTaNmVK0WqrFCJ+/9s5L4EVt5SvHvrd7Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qr0ZPAm3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706383966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O+26wNDTbnhxQ0dT1QMv9vCHeo7qkq4db2h6R0uH6/8=;
	b=Qr0ZPAm3pr0kMsH5KvlwOaNFfNl+Soir650dlI0a1tZoI3mUXicNeWiHUCd65IU7YyaiKu
	kFHkjWb39lJdp+D+vN+SQMRVJjAG/LU4JELsg6FHYolv2jqBRyz5GyOIuQ2SNYDKR2vhLK
	FmCNSlJcuQfKw+fPBIyWUFrdykDbLfs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-L4jdJzmyMMmfUpsmAq3A2A-1; Sat,
 27 Jan 2024 14:32:44 -0500
X-MC-Unique: L4jdJzmyMMmfUpsmAq3A2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 012BC28C976D;
	Sat, 27 Jan 2024 19:32:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.4])
	by smtp.corp.redhat.com (Postfix) with SMTP id 74A4C40C9444;
	Sat, 27 Jan 2024 19:32:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 27 Jan 2024 20:31:30 +0100 (CET)
Date: Sat, 27 Jan 2024 20:31:27 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240127193127.GC13787@redhat.com>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
 <ZbQpPknTTCyiyxrP@tycho.pizza>
 <20240127105410.GA13787@redhat.com>
 <ZbUngjQMg+YUBAME@tycho.pizza>
 <20240127163117.GB13787@redhat.com>
 <ZbU7d0dpTY08JgIl@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbU7d0dpTY08JgIl@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 01/27, Tycho Andersen wrote:
>
> > > > exit_notify() is called after exit_files(). pidfd_getfd() returns
> > > > ESRCH if the exiting thread completes release_task(), otherwise it
> > > > returns EBADF because ->files == NULL. This too doesn't really
> > > > depend on PIDFD_THREAD.
> > >
> > > Yup, understood. It just seems like an inconsistency we might want to
> > > fix.
> >
> > Not sure this worth "fixing"...
>
> Yep, maybe not. Just wanted to point it out.

On the second thought I am starting to understand your concern...

Indeed, in this case -EBADF is technically correct but it can confuse
the user which doesn't or can't know that this task/thread is exiting,
because EBADF looks as if the "int fd" argument was wrong.

Sorry I missed your point before.

Oleg.


