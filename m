Return-Path: <linux-kernel+bounces-150511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F05A8AA04C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8ADD1F22D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531CF17109B;
	Thu, 18 Apr 2024 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/G2yRUH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B016F855
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458388; cv=none; b=G7pcou6norSAn4V86dyBBcnEpcU78mBT5Nskaugq4hZT9iZ0j1ZHUP4HghezVr0J5VBTGuPs0XxShJNT/rWghrzcXnbOqBvMOlsuVVBQMvtzKqIc0wHtyJtvwiKG2bAjvYUGTXrPTWQQ4QycY66k9V4qf2sNCHmQUhPddi0GkX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458388; c=relaxed/simple;
	bh=ks+gYRlgMWjelNLaqSdEzg0InsxM+LPkXXjPq760u0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7h1l7qDrlrxXop3P5K2vgiq0NwUAaNEYnADZMyF/aN2paZC+ZpOSp0lQZWN4NF7OIH60SvyY6SSYSL6VZQE7bgJBqovQWU5gCroY3xx97yZRh7nHn9I5/P+CLsdFbMLlYmy9HhiDJjLT3OsFr5xtqll3ganxq21XVHxbavVdOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/G2yRUH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713458385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+7Ta3iQIct248tsu1U+JX3MhnFMLBvhD6niHZD7BgJE=;
	b=I/G2yRUHOIf3N0iA2j11yr7Ev1eFi5jswPLW9Z2pbJo1qHsRMZFwVSDxR24o1+fcMGYi3B
	I3lgYs25bVslu40eIBCya8u8ywXLjGYOpfCTBRlopZHhLFyg7vmhxJ3U5HkZmo1SSZgkOi
	eBGG8ZrN8+htDh0HyExOT4T6mmjs94w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-90jbMu4_M02DbE-Ne4_P2A-1; Thu,
 18 Apr 2024 12:39:42 -0400
X-MC-Unique: 90jbMu4_M02DbE-Ne4_P2A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D00E1C0432F;
	Thu, 18 Apr 2024 16:39:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.182])
	by smtp.corp.redhat.com (Postfix) with SMTP id 1704D20296D3;
	Thu, 18 Apr 2024 16:39:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 18 Apr 2024 18:38:16 +0200 (CEST)
Date: Thu, 18 Apr 2024 18:38:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [patch V2 26/50] signal: Get rid of resched_timer logic
Message-ID: <20240418163811.GA23440@redhat.com>
References: <20240410164558.316665885@linutronix.de>
 <20240410165552.572304080@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410165552.572304080@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 04/11, Thomas Gleixner wrote:
>
> There is no reason for handing the *resched pointer argument through
> several functions just to check whether the signal is related to a self
> rearming posix timer.

Agreed, these changes looks good to me.

But,

> SI_TIMER is only used by the posix timer code and cannot be queued from
> user space.

Why? I think sigqueueinfo() can certainly use si_code = SI_TIMER, so

> @@ -1011,6 +1001,9 @@ static int __send_signal_locked(int sig,
>  
>  	lockdep_assert_held(&t->sighand->siglock);
>  
> +	if (WARN_ON_ONCE(!is_si_special(info) && info->si_code == SI_TIMER))
> +		return 0;

this can be easily triggered by userspace and thus looks wrong.

Oleg.


