Return-Path: <linux-kernel+bounces-148376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC73D8A81B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8251C21CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF11013C832;
	Wed, 17 Apr 2024 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDrkr/E5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C998E2744B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352182; cv=none; b=SYaROR/Y6tYnylj+PhT3QoC6ceoyEWFJYQ3H/LCoWjt8sFp1ru9bRTEfEJnrxZX2sFqJ4nGaEgZJWMsvPw3iRnBzuzhxKHi1TkrlMuzcPMhlbslQlTikMY3sUB1LSU6V1DWz8KC9TPj+7o76yPENWPa2xciH/PrIrhgaCLTs3Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352182; c=relaxed/simple;
	bh=8hmmXLTj/2sUJvXXbIiKT5QGG3NWZGbMJdnVyduZ2UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n97kkNw7wx0F2R5YtoCJecgan0U4utt+xSHBJIQqqqqR51whv/B9r95kVKaK9M4eYbAiir0YzcnpQhKmOp8aA21sWisB8+Rfaa+dMfBQ9juWxQxLuuXZzG7Q17y1J9ipppYmnacbaLuYV5FOUEdIuTVVPMCLDAQxuo2PEmoPonk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDrkr/E5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713352179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8hmmXLTj/2sUJvXXbIiKT5QGG3NWZGbMJdnVyduZ2UM=;
	b=FDrkr/E5RNrTBBwOWfBTVzC7XU3O9Ki1lDm6IwNFv8mhHKxISi11PCiAXFTHBCKCswY6vp
	E7SSdpF86Qf2YsxVOonifPv0gNUee1K/3cY5mkaVEiWiztjCVE20TQJyanhbi25/WT1+Cl
	VnyLr6kGbp2FvUHMFwZMMyN2fqE0x2M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-iHh2QwPLPqaB_5d9GzSgWQ-1; Wed,
 17 Apr 2024 07:09:36 -0400
X-MC-Unique: iHh2QwPLPqaB_5d9GzSgWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBF4F3C14941;
	Wed, 17 Apr 2024 11:09:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.182])
	by smtp.corp.redhat.com (Postfix) with SMTP id 96F411C060A6;
	Wed, 17 Apr 2024 11:09:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 17 Apr 2024 13:08:10 +0200 (CEST)
Date: Wed, 17 Apr 2024 13:08:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [patch V2 07/50] posix-cpu-timers: Split up posix_cpu_timer_get()
Message-ID: <20240417110803.GA27840@redhat.com>
References: <20240416144438.GA17990@redhat.com>
 <87o7a8wdhr.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7a8wdhr.fsf@somnus>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 04/17, Anna-Maria Behnsen wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > On 04/11, Thomas Gleixner wrote:
> >>
> >> In preparation for addressing issues in the timer_get() and timer_set()
> >> functions of posix CPU timers.
> >
> > Cough... I must have missed something, but posix_cpu_timer_get()
> > doesn't look right with or without this trivial patch.
> >
> > It doesn't initialize itp->it_value if cpu_timer_getexpires() == 0,
> > this means that sys_timer_gettime() will copy the uninitialized
> > cur_setting->it_value on the stack to userspace?
>
> The initialization of itp is already done by the callsites.
> do_timer_settime() in posix-timers.c as well as do_cpu_nanosleep() in
> posix-cpu-timers.c execute a memset before calling
> posix_cpu_timer_get().

Indeed. Somehow I missed this memset(). Even if I tried to read the
simple do_timer_gettime/posix_cpu_timer_get functions several times ;)

Thanks for correcting me!

Oleg.


