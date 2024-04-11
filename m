Return-Path: <linux-kernel+bounces-140559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CC38A162D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6071F2350C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6303152539;
	Thu, 11 Apr 2024 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BP2nN3A6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B8914D707
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842993; cv=none; b=D2eQAX9U645MrVivF6GeWvBAF/x2FAsjy+qrw30/kdMRMw0gV5hEW8suY57enUgZSnMhUFrOeo0I6o2cPK3fWugCGhTi3XuX/boWBPzUwkbhsLVkXqc12BSuaOLSYw82+lzgjS5Wc+idf7M9EDTp8U7n6Cp0bjYHyLMNORLV7Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842993; c=relaxed/simple;
	bh=SJ34ciTQhJ3fV8rma6LmvGWcZJp39aNGbHDDG8dbKWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpM259qp45sqtDLXvSQS+BNnLI/U0YvdsPAWjN0STxnUaNQtpcPa0A3F2q5ySk/fW4ZJ/IuKJk/PJ0uuxIEy9ek/KDiV07Yhx9HGgNn/GLd26r3zTrWByrOwZPY30bZ/RcljMqqUL5XFUROfkA2odYANT+qWIglGHzWaM2AMYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BP2nN3A6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712842990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=94SyIWf/l9sBuxilNW3hNkOFqAXyJGS5kVqeXmxJOr8=;
	b=BP2nN3A6PuTw3ISLaPee1wATVJrrQOWpnUN0mxLg9ro0p961vaKXe0dJO8gCvmGqibrclX
	RzxOHrvaDpgjYu+kpNJWNRW6fn/ZGsCOI+qXsvpwW6elQjsJ3jVUk1ygNWkiRn9HKBYPwW
	m1rOFBQruwV5XxKvM6lqOy+jGyqZv0o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-CzxCm4qdNOq75Ny8zAF92w-1; Thu, 11 Apr 2024 09:43:07 -0400
X-MC-Unique: CzxCm4qdNOq75Ny8zAF92w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 251DF188E9C3;
	Thu, 11 Apr 2024 13:43:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.235])
	by smtp.corp.redhat.com (Postfix) with SMTP id 2D3692026D06;
	Thu, 11 Apr 2024 13:43:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 11 Apr 2024 15:41:41 +0200 (CEST)
Date: Thu, 11 Apr 2024 15:41:33 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, Tejun Heo <tj@kernel.org>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Junyao Zhao <junzhao@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: Nohz_full on boot CPU is broken (was: Re: [PATCH v2 1/1] wq:
 Avoid using isolated cpus' timers on queue_delayed_work)
Message-ID: <20240411134133.GC5494@redhat.com>
References: <20240402105847.GA24832@redhat.com>
 <Zg2qFinSkAOmRHcM@slm.duckdns.org>
 <20240403203814.GD31764@redhat.com>
 <20240405140449.GB22839@redhat.com>
 <ZhByg-xQv6_PC3Pd@localhost.localdomain>
 <20240407130914.GA10796@redhat.com>
 <ZhUu0uQxPgcXmQes@localhost.localdomain>
 <20240409130727.GC29396@redhat.com>
 <D0G5OX8W9NH9.1HE33RVAROAJK@gmail.com>
 <20240410135518.GA25421@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410135518.GA25421@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 04/10, Oleg Nesterov wrote:
>
> Will you agree with the change above or what do you suggest instead as
> a simple workaround?

OK, let me send the patch.

Nicholas, Frederic, please review.

> Again, I am not sure I understand, but I too thought that something like
>
> 	housekeeping_check(void)
> 	{
> 		for_each_set_bit(type, &housekeeping.flags, HK_TYPE_MAX) {
> 			if (!cpumask_intersects(cpu_online, housekeeping.cpumasks[type]))
> 				panic();
> 		}
>
> after bringup_nonboot_cpus(setup_max_cpus).

It seems we can make a simpler patch for this. It will (should) fix another
problem when maxcpus < first-housekeeping.

I'll recheck and try to do this later, lets solve the reported problem first.

Oleg.


