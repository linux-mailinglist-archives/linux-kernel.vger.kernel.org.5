Return-Path: <linux-kernel+bounces-166253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8338B981C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889261C20D49
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C645645B;
	Thu,  2 May 2024 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFZ6JWoF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B2456448
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643534; cv=none; b=OwvxMx4+e25i+2HMz862EPIIsb1GuaCdfQKhLxPcmUgzHT4xjYtdBHCk05l9SK5i+MHIRbJLykZsCq6l3qBs0S+iYXmn0HUmsiiUXzSdqTECBpB9uZo1wNgVttQe3ylmuOy4uNLoqR6nl1VbjlFtHFe6xWwzY1j7B6OZnP6RaFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643534; c=relaxed/simple;
	bh=1K2m1ZK4jkv/p2zkpmXkXg4nPfMK7vRZ98Av3byv4fM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m7TM6r0+XgUVTjk9z9EMpGv5D5dkS4k/qzkdMH6s6LoaOyAAvIYpCMS26Gzh5XIo0zn5NclYplHJbXCRL/w8nQuY1xapSRqhcg3t9gEt9QSQcUKa49I4zXL6ckM8EdG27c8zJlKF8s+FrJwZFaEphfemd1uxkO4yBCALgwP7P/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFZ6JWoF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714643532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tstmt5L3lDWDwvbX2UANesO3SfpQYRIvnhHG8+Nwf7U=;
	b=PFZ6JWoFMcvr7xoxMbEPJ+GyX/8IQSJi+RdpBrTo5+aS/YM8lV75CZkjtdPw37ryxjTdR7
	XG0CQ1GSIkC43dPeFr8xGG7z5bZ9AxQJgN2L+tpTIHkHwk/iBQuQtQFuaLUOCdhxMQXFTv
	39LKlGJpwYmwZLmpT5/IYnL9mayMJ50=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-r9Oadj5OMiu_itETd4b5Kg-1; Thu,
 02 May 2024 05:52:06 -0400
X-MC-Unique: r9Oadj5OMiu_itETd4b5Kg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F3DF1C05149;
	Thu,  2 May 2024 09:52:05 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.193.188])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AF688C271A9;
	Thu,  2 May 2024 09:51:58 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,  Mathieu
 Desnoyers
 <mathieu.desnoyers@efficios.com>,  Peter Zijlstra <peterz@infradead.org>,
  Thomas Gleixner <tglx@linutronix.de>,  linux-kernel@vger.kernel.org,
  "Paul E . McKenney" <paulmck@kernel.org>,  Boqun Feng
 <boqun.feng@gmail.com>,  "H . Peter Anvin" <hpa@zytor.com>,  Paul Turner
 <pjt@google.com>,  linux-api@vger.kernel.org,  David.Laight@aculab.com,
  carlos@redhat.com,  Peter Oskolkov <posk@posk.io>,  Alexander Mikhalitsyn
 <alexander@mihalicyn.com>,  Chris Kennelly <ckennelly@google.com>,  Ingo
 Molnar <mingo@redhat.com>,  Darren Hart <dvhart@infradead.org>,  Davidlohr
 Bueso <dave@stgolabs.net>,  libc-alpha@sourceware.org,  Steven Rostedt
 <rostedt@goodmis.org>,  Jonathan Corbet <corbet@lwn.net>,  Noah Goldstein
 <goldstein.w.n@gmail.com>,  Daniel Colascione <dancol@google.com>,
  longman@redhat.com,  kernel-dev@igalia.com
Subject: Re: [RFC PATCH 0/1] Add FUTEX_SPIN operation
In-Reply-To: <20240502-gezeichnet-besonderen-d277879cd669@brauner> (Christian
	Brauner's message of "Thu, 2 May 2024 10:45:41 +0200")
References: <20240425204332.221162-1-andrealmeid@igalia.com>
	<20240426-gaumen-zweibeinig-3490b06e86c2@brauner>
	<f052ff72-72c9-4b83-9285-2cd9d52e5f72@igalia.com>
	<20240502-gezeichnet-besonderen-d277879cd669@brauner>
Date: Thu, 02 May 2024 11:51:56 +0200
Message-ID: <8734r0o81v.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

* Christian Brauner:

> Unless I'm missing something the question here is PID (as in TGID aka
> thread-group leader id gotten via getpid()) vs TID (thread specific id
> gotten via gettid()). You want the thread-specific id as you want to
> interact with the futex state of a specific thread not the thread-group
> leader.
>
> Aside from that TIDs are subject to the same race conditions that PIDs
> are. They are allocated from the same pool (see alloc_pid()).

For most mutex types (but not robust mutexes), it is undefined in
userspace if a thread exits while it has locked a mutex.  Such a usage
condition would ensure that the race doesn't happen, I believe.

From a glibc perspective, we typically cannot use long-term file
descriptors (that are kept open across function calls) because some
applications do not expect them, or even close them behind our back.

Thanks,
Florian


