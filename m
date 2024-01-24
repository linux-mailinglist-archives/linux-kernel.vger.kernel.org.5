Return-Path: <linux-kernel+bounces-36230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C3B839DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09C728B989
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6671D10EF;
	Wed, 24 Jan 2024 00:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoh3yJdM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B45620
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706056854; cv=none; b=OO+xS5dRzDAtB3jwSyROzl9UTb6sQAZ4S31CJUDCz42vm1mSVYqEKsDTN1spJD+/X+Z2ibQ3TvCeqs+FfPrvcG1QdtMiXhUGDANUUVCYf5SE0F+8BquPltM36bX/Xe96ia8HqAa5n+lPWh8j3UpGmrGQWApSaHWV78Y6bgm97Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706056854; c=relaxed/simple;
	bh=ER5Bp0V1Zhc+FoYdut0RUMjI9BKEJAxh4pg9D81lGAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulIr/oDc4QBCC+WSw6Dqah6Z1MBFq3pKaC4Z6uXBeuU0epppcxiHu9w9eR8rR+lRbsqLPxF1UsrA8IP9Y8Ub5k61UPpoLI1JuHkCFcLahsAkpH5wbuk4Jtc6fkX3KwE/SYYHAWA5iQwKsfMuzjeZmHDmcLNI+biWDeflevETzUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hoh3yJdM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706056851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xiOvb37QfLscKQcu8Koz59w2wt96DY2PQzu4935ySGU=;
	b=hoh3yJdM8gu1Rsx476XTScARP8ha1dzRYfyoztyZ6zf6hT8dCvuLKyxk5PKjCRd+cziNyv
	L3NVA807d38cuoSZHtSEf+Irw557tQ5w6BkxWpQFTC9t4AI5xTa5BzqKV3getoEgrn1qtd
	LKmhMKE20hRuJPhu9t3hAUZvqBGsLkE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-g_pKhG1NPECvcelyEyiKkQ-1; Tue, 23 Jan 2024 19:40:46 -0500
X-MC-Unique: g_pKhG1NPECvcelyEyiKkQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB5A6835380;
	Wed, 24 Jan 2024 00:40:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.7])
	by smtp.corp.redhat.com (Postfix) with SMTP id B2A0151D5;
	Wed, 24 Jan 2024 00:40:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 24 Jan 2024 01:39:32 +0100 (CET)
Date: Wed, 24 Jan 2024 01:39:30 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Dylan Hatch <dylanbhatch@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] getrusage: use sig->stats_lock
Message-ID: <20240124003930.GA26412@redhat.com>
References: <20240122155023.GA26169@redhat.com>
 <CADBMgpxNUoaermXsEj0Hs0KT=Q0xRpz5y+Px=oAGDP2Efg8yyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADBMgpxNUoaermXsEj0Hs0KT=Q0xRpz5y+Px=oAGDP2Efg8yyw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 01/23, Dylan Hatch wrote:
>
> I have one last question -- is there possibly an edge case in which
> the hard lockup
> can still happen? How likely is it for many writers to force enough
> readers to do a
> retry on the seqlock, disabling irq and causing the lockup?

I don't know how likely is it, and I guess the repro should be more creative ;)

But yes. Please see the TODO: section in the changelog,

	- Turn sig->stats_lock into seqcount_rwlock_t, this way the
	  readers in the slow mode won't exclude each other.

and more importantly,

	- stats_lock has to disable irqs because ->siglock can be taken
	  in irq context, it would be very nice to change __exit_signal()
	  to avoid the siglock->stats_lock dependency.

There are other users which take stats_lock under siglock (and the
"fs/proc: do_task_stat" series changes 2 of them to not do this), but
__exit_signal() is most problematic.

If we remove this dependency, we can turn read_seqbegin_or_lock_irqsave()
into read_seqbegin_or_lock() which doesn't disable irqs.

Oleg.


