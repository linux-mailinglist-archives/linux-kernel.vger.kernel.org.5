Return-Path: <linux-kernel+bounces-41316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD85483EEB7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807F81F2332D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07EC286AE;
	Sat, 27 Jan 2024 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdFS4rez"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7614256756
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706373184; cv=none; b=eDDe7WcsoQQKQRrIan0JzHynVvAcq+kbec3X990paWaR1IeQYjyzCIDp6Rpg1sLJh6RznIyFEiiatXJGZkjT4uzpFtnLUKwYWV/Kknf33pG6OD69fNsbAiNly8436k0YH/Iz+e5UG4S9Y++9kIT30V2kJgcO0S4mS1lt3RRTe4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706373184; c=relaxed/simple;
	bh=kCA9TsgWAj9jn5vlEBGgkwF7celX9k9TNJISTn56xmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocaThquUR3ty1nOCyhU8hiDYQcER2C7/JpV2YErteVLFZj4OYoOX3PDNG06zF2XPgrVWBuNSz+mpwFrQrJcbIhlDBqLLImggszvOZz3jAPtZqn89R9BAadqAvsQnn1X3n0J+/iehh8xDO1iU6YbHSQy8q63SN9vS0dt8+piOkLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DdFS4rez; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706373181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kCA9TsgWAj9jn5vlEBGgkwF7celX9k9TNJISTn56xmI=;
	b=DdFS4rez6b1FpM7VDRDPe9I/S/64LdhV4mdmdQICFscCFQJ0SeQh01D3U/JzhWycxb8DyO
	zhZBASOAV5/AXicUiFd1palTkxlf1cBHmSKhN0Lz5g8dQg+xUu4amKudacOqHd4APNJR6p
	5AaNaLIxfe/i0A/Sh+saF+egaovdiaw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-Fc0-O_u7Mjaip4MGg-JMYQ-1; Sat, 27 Jan 2024 11:32:55 -0500
X-MC-Unique: Fc0-O_u7Mjaip4MGg-JMYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65637835381;
	Sat, 27 Jan 2024 16:32:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.4])
	by smtp.corp.redhat.com (Postfix) with SMTP id D52E42166B32;
	Sat, 27 Jan 2024 16:32:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 27 Jan 2024 17:31:41 +0100 (CET)
Date: Sat, 27 Jan 2024 17:31:39 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240127163117.GB13787@redhat.com>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
 <ZbQpPknTTCyiyxrP@tycho.pizza>
 <20240127105410.GA13787@redhat.com>
 <ZbUngjQMg+YUBAME@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbUngjQMg+YUBAME@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 01/27, Tycho Andersen wrote:
>
> It seems like (and the current pidfd_test enforces for some cases)

Which pidfd_test ?

> we
> want exactly one notification for a task dying.

This can't be right. EVERY user of poll_wait() or wait_event/etc
must handle/tolerate the false wakeups.

> I don't understand
> how we guarantee this now, with all of these calls.

I don't understand why do we need or even want to guarantee this.

The extra wakeup must be always fine correctness-wise. Sure, it
would be nice to avoid the unnecessary wakeups, and perhaps we
can change wake_up_all() to pass a key to, say, only wake_up the
PIDFD_THREAD waiters from exit_notify(). But certainly this is
outside the scope of PIDFD_THREAD change we discuss.

The changes in do_notify_parent() (I have already sent the patch) and
in exit_notify() (proposed in my previous email) just ensure that,
with the minimal changes, we avoid 2 do_notify_pidfd's from the same
exit_notify() path.

> > exit_notify() is called after exit_files(). pidfd_getfd() returns
> > ESRCH if the exiting thread completes release_task(), otherwise it
> > returns EBADF because ->files == NULL. This too doesn't really
> > depend on PIDFD_THREAD.
>
> Yup, understood. It just seems like an inconsistency we might want to
> fix.

Not sure this worth "fixing"...

Oleg.


