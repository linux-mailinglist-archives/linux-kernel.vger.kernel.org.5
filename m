Return-Path: <linux-kernel+bounces-36129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DDF839C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18991F24A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F75A4F211;
	Tue, 23 Jan 2024 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iv6NuYg4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF03FB32
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048634; cv=none; b=jjBFBwtg7jioyBCKJLaVsMuUA3c91kzWwMXCsJPbPLTi9OJdBl3G1VEEc+1SBBL6GJ9Nlvht2MIAwKkprsbUdWPDE3P/yP3utzc4fdiK4442MD0EbexEOQms5aeMzkExXBD+XN3BMw3kX2vjkTo7ToyQyPp+f8hSyTmGgP4gyPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048634; c=relaxed/simple;
	bh=2qeiv2f0Rnl56+1ZOayTWh56YtuPy1oK2jgNwHECTgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7Z9jt744134LC323zX79BVTigK21OM4Gr2f5QBf0rT3a36MAmbuFuf2jv6GklTR0NTlY1vnykk8bHdcEJU1aPknap+7xSlgWirtrfMabjqlxqiuWXwG4shU08gu6AtlfsiiXPh2rWdUwUIUSWghlLjPMRp9G6q8KQjUEXgrYWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iv6NuYg4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706048632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QRtv6MwGFAiCHrTTIDTaoBSr2kODb8F3izG+iIcZ5ik=;
	b=Iv6NuYg4YHuCNxhCWECXrhVjNoX+humBXbZvaqTvNAvEUwozW1O7+PFShmztOn5hPnpUEw
	2T4DJYEnYoF9OCs3mho4BhastxeJ1lQcTWFWyppwTMhelzQBWoI8qJWKLu+FCykXh0vIrj
	9KWEAeVnhluA1h3HRFrAkjjJVY0QdmY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-1l936kqxOMambpdCa9tscA-1; Tue, 23 Jan 2024 17:23:47 -0500
X-MC-Unique: 1l936kqxOMambpdCa9tscA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C4BC85A596;
	Tue, 23 Jan 2024 22:23:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.197])
	by smtp.corp.redhat.com (Postfix) with SMTP id C5A6540D1B60;
	Tue, 23 Jan 2024 22:23:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 23 Jan 2024 23:22:34 +0100 (CET)
Date: Tue, 23 Jan 2024 23:22:31 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240123222231.GA25162@redhat.com>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbArN3EYRfhrNs3o@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

I am already sleeping. I'll try to reply to other parts of your email
tomorrow but I am not sure, I will be very busy with family duties.

On 01/23, Tycho Andersen wrote:
>
> > >  	__exit_signal(p);
> >
> > and,  do_notify_pidfd() is called before __exit_signal() which does
> > __unhash_process() -> detach_pid(PIDTYPE_PID).
> >
> > Doesn't this mean that pidfd_poll() can hang? thread_group_exited()
> > won't return true after do_notify_pidfd() above, not to mention that
> > thread_group_empty() is not possible if !thread_group_leader().
>
> I was wondering about this too, but the test_non_tgl_poll_exit test in
> the next patch tests exactly this and works as expected.

Well, if release_task() completes __exit_signal() before the woken task
does thread_group_exited(), pid_task(PIDTYPE_PID) will return 0 and
pidfd_poll() won't hang.

But to be honest I can't understand test_non_tgl_poll_exit() at all. I don't
even understand why the process/thread created by fork_task_with_thread()
should ever exit. And why it creates the "writer" child... Never mind, too
late for me to read the code.

Oleg.


