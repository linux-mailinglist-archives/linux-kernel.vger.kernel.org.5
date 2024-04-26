Return-Path: <linux-kernel+bounces-159808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 202638B3461
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 453A3B23578
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FF913F451;
	Fri, 26 Apr 2024 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHliov4X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6505A13F425
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124650; cv=none; b=GBBsQ7lwz5fcCKdLv4wpIA0R7FKgiEwYR/gIUqNprjF5qeSs2XHA8Y54imLSH/BIiHFMGG+XxROQmNSM1kYQyyz9tPgvs+EQwADtIOtjf+RqI22pZc88/PV1vRJt41tn+68GeA50KcQTPdW77hqv+ZL8/wZO1fWNe5gSvTPucLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124650; c=relaxed/simple;
	bh=pmgilF8ToQ+8ZjQbwsCILaNYDi9BiJ0128c5TJVmOaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uy+UffYjPaJFhXx4hhXZHmz/CHd6Q7WtSdH1iuCJX0l6CYmWW95vm0rvdKnJvPY8WyrYoUASrwdyjQJMH9vL/qKmKikZyv9Ob0DnpjbRH3lX83L1CAGt16cqzH1f9dBqsJMDjwhLI6LTj080IMFEWxDUtPaY+5yyJFB3gRikFWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHliov4X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714124648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ThRbfX0S+BKG7HsDfQ7j+bHT6F0CY2NaaiZlfhtWgy4=;
	b=UHliov4Xq4PgDS/6KxfPPSgX/ybwqUCwJm5FdjtvlDoJlWbSsa+qEnPqKRWbEJW9s6hhqc
	gJkLQUFChyLUP4sNmJZ8RKwnB6NHGJS0nz/2jApphIZOpNMdsytOJ6XE/hGc8/rpnEbvYL
	BkmRYiKJtsTXotJBSK5qUJGjCfkdl8A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-thNNxvOKOA2akbY9q6qn5Q-1; Fri,
 26 Apr 2024 05:44:00 -0400
X-MC-Unique: thNNxvOKOA2akbY9q6qn5Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 827D73803916;
	Fri, 26 Apr 2024 09:43:59 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 58CA840C6CB2;
	Fri, 26 Apr 2024 09:43:53 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,  Peter Zijlstra
 <peterz@infradead.org>,  Thomas Gleixner <tglx@linutronix.de>,
  linux-kernel@vger.kernel.org,  "Paul E . McKenney" <paulmck@kernel.org>,
  "Boqun Feng" <boqun.feng@gmail.com>,  "H . Peter Anvin" <hpa@zytor.com>,
  "Paul Turner" <pjt@google.com>,  linux-api@vger.kernel.org,  "Christian
 Brauner" <brauner@kernel.org>,  David.Laight@ACULAB.COM,
  carlos@redhat.com,  "Peter Oskolkov" <posk@posk.io>,  "Alexander
 Mikhalitsyn" <alexander@mihalicyn.com>,  "Chris Kennelly"
 <ckennelly@google.com>,  "Ingo Molnar" <mingo@redhat.com>,  "Darren Hart"
 <dvhart@infradead.org>,  "Davidlohr Bueso" <dave@stgolabs.net>,
  libc-alpha@sourceware.org,  "Steven Rostedt" <rostedt@goodmis.org>,
  "Jonathan Corbet" <corbet@lwn.net>,  "Noah Goldstein"
 <goldstein.w.n@gmail.com>,  "Daniel Colascione" <dancol@google.com>,
  longman@redhat.com,  kernel-dev@igalia.com
Subject: Re: [RFC PATCH 0/1] Add FUTEX_SPIN operation
In-Reply-To: <20240425204332.221162-1-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Thu, 25 Apr 2024 17:43:31 -0300")
References: <20240425204332.221162-1-andrealmeid@igalia.com>
Date: Fri, 26 Apr 2024 11:43:51 +0200
Message-ID: <875xw44fxk.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

* Andr=C3=A9 Almeida:

> With FUTEX2_SPIN flag set during a futex_wait(), the futex value is
> expected to be the PID of the lock owner. Then, the kernel gets the
> task_struct of the corresponding PID, and checks if it's running. It
> spins until the futex is awaken, the task is scheduled out or if a
> timeout happens.  If the lock owner is scheduled out at any time, then
> the syscall follows the normal path of sleeping as usual.

PID or TID?

I think we'd like to have at least one, possibly more, bits for free
use, so the kernel ID comparison should at least mask off the MSB,
possibly more.

I haven't really thought about the proposed locking protocol, sorry.

Thanks,
Florian


