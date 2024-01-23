Return-Path: <linux-kernel+bounces-35599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543F28393D7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5331F23BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A5660B9C;
	Tue, 23 Jan 2024 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXgVhh8Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E31860872
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025310; cv=none; b=TeE/tNqTwRyjVzzOIoLBP9lblOIG/1gyjIfcEtF60x6mBzGPfusi8h6DrSZ0JceYCayq0JvBnLqrpprr3iBRMrVyVJqmyIlP7j7boq0N5bm/U65u9+dVGP6J+Z18+HgeCiUcqsKl8r2a/8QcHVcPsXqxcAl0auxVqUy84CfB6B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025310; c=relaxed/simple;
	bh=oh3Zhs9WXUh2/NAJqpmzYlnua86s8LfxQ3ifv3XPgEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdmAB75eHS7VejlKw9JQ2VeEGprTkjJ6LSsPQ6jOT3+TDl6MX2AezBMKkr/yuHmmB3I1qPhExyZUfNwUIYs302LbkxIEhbHxCbiLeDNNGXjHseizwEvDWBUxiEonbxcjKX4rqQmxHLqEZcuWxVB6DGuvxUnubueM34m7rqVh1ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gXgVhh8Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706025307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GjkSdKZOfRMPgNl3Qm01JjYpubCaTKo6HETyRd+5mTk=;
	b=gXgVhh8QxSr0AJnXnKdt8UKNUYhDXAlN+PB6v1uDrOGOEf1IydWHLERqnCyBfbNBO9vlMU
	qv/chNmQf0OvBvvzUPFQMTOFruI1YPMLS6N87z0+BUcnt+PIz9M1WhiQ7xpKW4J/CuZGPB
	1hzHfbi6/eH5ppRgCLPPzJzODqNHBO8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-5Gsk90L4PvC0i5xjIyE1xw-1; Tue, 23 Jan 2024 10:55:05 -0500
X-MC-Unique: 5Gsk90L4PvC0i5xjIyE1xw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B341B88B7AE;
	Tue, 23 Jan 2024 15:55:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.197])
	by smtp.corp.redhat.com (Postfix) with SMTP id 988592026D66;
	Tue, 23 Jan 2024 15:55:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 23 Jan 2024 16:53:51 +0100 (CET)
Date: Tue, 23 Jan 2024 16:53:49 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Dylan Hatch <dylanbhatch@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] getrusage: use sig->stats_lock rather than
 lock_task_sighand()
Message-ID: <20240123155349.GA9978@redhat.com>
References: <20240122155023.GA26169@redhat.com>
 <20240122155053.GA26214@redhat.com>
 <20240122155723.149081552c9a9e122b1f783b@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122155723.149081552c9a9e122b1f783b@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 01/22, Andrew Morton wrote:
>
> On Mon, 22 Jan 2024 16:50:53 +0100 Oleg Nesterov <oleg@redhat.com> wrote:
>
> > lock_task_sighand() can trigger a hard lockup. If NR_CPUS threads call
> > getrusage() at the same time and the process has NR_THREADS, spin_lock_irq
> > will spin with irqs disabled O(NR_CPUS * NR_THREADS) time.
>
> It would be super interesting to see Dylan's original report.

from "[RFC PATCH] getrusage: Use trylock when getting sighand lock."
https://lore.kernel.org/all/20240117192534.1327608-1-dylanbhatch@google.com/

	Processes with many threads run the risk of causing a hard lockup if
	too many threads are calling getrusage() at once. This is because a
	calling thread with RUSAGE_SELF spins on the sighand lock with irq
	disabled, and the critical section of getrusage scales linearly with the
	size of the process. All cpus may end up spinning on the sighand lock
	for a long time because another thread has the lock and is busy
	iterating over 250k+ threads.

> Is it possible for carefully-crafted unprivileged userspace to
> deliberately trigger this?

Yes, just you need to create a process with a lot of threads calling
getrusage().

See mine and Dylan's test-cases in
https://lore.kernel.org/all/CADBMgpz7k=LhktfcJhSDBDWN0oLeQxPqhOVws3fq0LNpnfOSYg@mail.gmail.com/
There are very similar and simple.


And again, this is a known problem and we need more fixes.

Oleg.


