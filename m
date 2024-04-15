Return-Path: <linux-kernel+bounces-145551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BA18A57C2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9C8285D63
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE9C82482;
	Mon, 15 Apr 2024 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5fDZqy3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859777F7FF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198579; cv=none; b=JGFxmqUwGRHhUpoHKvFe03QFFvmTNWQCFdd80WTsq7nQum4UOvr6CNmd95bhsPzFFWmxuyL2xfFG0v0miY4YN9UAlQoj0Vlwfhm61IS18iyNuYy/o6hiPjcGw3Bi7gThEU8Uvt9J2uf8eXv5GRVXPbxEIwtsfObkxB37i4nZnAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198579; c=relaxed/simple;
	bh=FCDa/fftBhU5eLi18mr7YJBDUgoS72YVYx/S2TMPhD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E90/bznoxVP+0q5lLdUpjqWOiuXkF24QFQL/IFWjBABihdracr3JU6hijb4o8F6tXlx1+Brs5CVSvZ7RCa2ZOb4Zq8simKs1GcI2BI/4CETV9u2dcFtMPuz2qIfcjYxwCdoc3/5m5Wg+GEm29I7QJzbf4GntYXENK+T2AGyvXiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5fDZqy3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713198577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCDa/fftBhU5eLi18mr7YJBDUgoS72YVYx/S2TMPhD4=;
	b=b5fDZqy3alrsJUhuZfshlTPaDxLlIA4P2GyMEbuCwKwQB4aPlZ5cJrTSZDMVMB/CltVzrI
	6bVxdOr1BitqPJyKikA783SmUI09tVY+OLG7QEmTvugIm6pPTLdBEVUY4wPQgSDfWvw+y2
	UeAXZNf4vF6de1X4QtxR+TllLvLgc7A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-AUOsd1H9Ore82GscJWM5Fw-1; Mon, 15 Apr 2024 12:29:32 -0400
X-MC-Unique: AUOsd1H9Ore82GscJWM5Fw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8140E805B9D;
	Mon, 15 Apr 2024 16:29:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.182])
	by smtp.corp.redhat.com (Postfix) with SMTP id 4C4B7480F02;
	Mon, 15 Apr 2024 16:29:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 15 Apr 2024 18:28:05 +0200 (CEST)
Date: Mon, 15 Apr 2024 18:27:58 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] posix-timers: Handle returned errors poperly in
 [i]timer_delete()
Message-ID: <20240415162758.GB27124@redhat.com>
References: <20240415130023.GA27124@redhat.com>
 <87a5luvhix.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5luvhix.fsf@somnus>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Anna-Maria, I can't really answer, I don't understand this code today ;)
That said, let me try to explain my opinion,

On 04/15, Anna-Maria Behnsen wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > On 04/15, Anna-Maria Behnsen wrote:
> >>
> >> timer_delete_hook() returns -EINVAL when the clock or the timer_del
> >> callback of the clock does not exist. This return value is not handled by
> >> the callsites timer_delete() and itimer_delete().
> >
> > IIUC this shouldn't happen? timer_delete_hook() WARN()s in this case,
> > not sure we need to return this error to userspace...
>
> This shouldn't happen, right.
>
> Even if we do not return this error to userspace, is it valid to proceed
> with the rest of the callsites?

Well, I'd say that nothing is safe after we hit the kernel problem.

But lets suppose we return EINVAL and skip list_del(&timer->list)/etc.
How can this help? What can userspace do to resolve this problem? Is it
better to "leak" this timer? I dunno.

> When it is fine to just ignore the
> -EINVAL return, then I would propose just to add a comment to the code.

Agreed!

Oleg.


