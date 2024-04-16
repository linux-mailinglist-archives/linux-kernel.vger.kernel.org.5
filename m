Return-Path: <linux-kernel+bounces-147052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 273C98A6EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18221F236D2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F2212EBDC;
	Tue, 16 Apr 2024 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjTq+sJg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75DE12E1D9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278778; cv=none; b=s8CjX6ECOwZMkCx1QRJaGAmbglK7bnBiZuhniP7b+yEYnAMWRLCTWwIiA1BegHJPrYfp5k/0E32MWlaiJXTxOA/R6ouQjQavZrL0IKfFY2GLSthdr4RUii6JOElhVM1ad/hxPrse8XhVxDLlM7Qg+w6pVh5hZo0B9uHcy7HqRGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278778; c=relaxed/simple;
	bh=3TxHZ4ZRaEXdkE2iyGrPF64b8dJ88F1bx4hw6cwnxfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4V95eev489HF8RTrfzhCtCIyyPQa3AosGqPaPv7Zwyev7a5p5KXgB861+BWPwAMAYG6wlz8/Ex4IlAe4raoLU4hArh8FwcMb6TpWo/9MU8qD0CKtN60+X14OUH4Tdv1GUAJ/r8wQ8M+suUmbwCZfyp2th4SploruJnZIu3sty4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AjTq+sJg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713278775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3TxHZ4ZRaEXdkE2iyGrPF64b8dJ88F1bx4hw6cwnxfY=;
	b=AjTq+sJgHbuUD9G3dUvNTkEgFhHKXYaroP+Z+HnhYsfUYSUeLnbAKftB/CiCtGF1ZOrJMU
	w85IcvfRbUT3o9Lx6Ib3SyPXBQksjRIsbpxz8w4qLaZJrumA//CkenV6pzzO0VA/0cqYT8
	KEXz0IANAZ4oQrX0YMoZhNG+GFm4xnE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-six1j7VsNiC3wbwE5cj3Qg-1; Tue, 16 Apr 2024 10:46:11 -0400
X-MC-Unique: six1j7VsNiC3wbwE5cj3Qg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DA7D80591B;
	Tue, 16 Apr 2024 14:46:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.182])
	by smtp.corp.redhat.com (Postfix) with SMTP id 3BFB51C06667;
	Tue, 16 Apr 2024 14:46:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 16 Apr 2024 16:44:45 +0200 (CEST)
Date: Tue, 16 Apr 2024 16:44:38 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [patch V2 07/50] posix-cpu-timers: Split up posix_cpu_timer_get()
Message-ID: <20240416144438.GA17990@redhat.com>
References: <20240410164558.316665885@linutronix.de>
 <20240410165551.376994018@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410165551.376994018@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 04/11, Thomas Gleixner wrote:
>
> In preparation for addressing issues in the timer_get() and timer_set()
> functions of posix CPU timers.

Cough... I must have missed something, but posix_cpu_timer_get()
doesn't look right with or without this trivial patch.

It doesn't initialize itp->it_value if cpu_timer_getexpires() == 0,
this means that sys_timer_gettime() will copy the uninitialized
cur_setting->it_value on the stack to userspace?

Oleg.


