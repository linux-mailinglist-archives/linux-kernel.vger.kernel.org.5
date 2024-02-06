Return-Path: <linux-kernel+bounces-55556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EF384BE14
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DD81C2298E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A6E1B7F7;
	Tue,  6 Feb 2024 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PD9H/Qe3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF78F1B7E4
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707247637; cv=none; b=S6mWjos7aF4+9JNVcVrz2P8F2L9VF8XSYaFrnH/rIbjY1d5AGCNgjkHYSye/3CvyQ1i6nLfj4txeaVYjXTBOLG8Rha/zOXG9zK6IalFQ/nafN0edx3SuoeyBhCKc9V8C5Krarzm67drdEK8b+s7sKY6nocM8syrdyP/5F4VewZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707247637; c=relaxed/simple;
	bh=AROLcne/Zq10AQJLNHGj6fYDE/CKNNGjHYS5FckbS0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4AfN/fzzKmj2Qe0ecMfGhZq+j/Y5iEkv98rN4nr8kUoqxuiJOluCsRs/uwWgy6UlZ4z9PVB2/VexhCxG/nqgCGoNCbvVY33CxnpPEN1D3T2tNhfYS4q3G3uC6JQv5A/YFRUbyvpXHyyuh6fPe6gwcq+WXrZ4LU4I7jmMgO0Q1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PD9H/Qe3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707247634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AROLcne/Zq10AQJLNHGj6fYDE/CKNNGjHYS5FckbS0c=;
	b=PD9H/Qe3YfxpVD3XcqZ5tVkDxyAQS6bx1aMfUTXN+3IA6qMZaLd8A9M636xuRC5QSD2ujM
	AfZCTsrgNWmM9kzCXf/eaH1QvpHZa0sXknUXC1Qkd4Gr/YmE78DYalLQUAdEZvCOPn83Pn
	sfXIjpFSAEwrItzepZ/9pEkVOzjPLn0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-Nk5j75SXM7mGD_sDN7ATMA-1; Tue, 06 Feb 2024 14:27:13 -0500
X-MC-Unique: Nk5j75SXM7mGD_sDN7ATMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0AB3879849;
	Tue,  6 Feb 2024 19:27:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.46])
	by smtp.corp.redhat.com (Postfix) with SMTP id F2BEFAC1D;
	Tue,  6 Feb 2024 19:27:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  6 Feb 2024 20:25:57 +0100 (CET)
Date: Tue, 6 Feb 2024 20:25:54 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH] pidfd: getfd should always report ESRCH if a task is
 exiting
Message-ID: <20240206192553.GC3593@redhat.com>
References: <20240206164308.62620-1-tycho@tycho.pizza>
 <20240206173722.GA3593@redhat.com>
 <20240206180607.GB3593@redhat.com>
 <ZcJ13uLxD6rTqqZZ@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcJ13uLxD6rTqqZZ@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 02/06, Tycho Andersen wrote:

> On Tue, Feb 06, 2024 at 07:06:07PM +0100, Oleg Nesterov wrote:
> > Or we can check task->files != NULL rather than PF_EXITING.
> >
> > To me this looks even better, but looks more confusing without a comment.
> > OTOH, imo this needs a comment anyway ;)
>
> I thought about this, but I didn't really understand the null check in
> exit_files();

I guess task->files can be NULL at least if it was cloned with
kernel_clone_args->no_files == T

> if it can really be called more than once,

I don't think this is possible. Well, unless the exiting task hits
a BUG() after exit_files() and calls do_exit() recursively.

> are there
> other cases where task->files == NULL that we really should report
> EBADF?

I don't think so...

If nothing else, sys_close() dereferences current->files without any
checks, so I think task->files == NULL is simply impossible if this
task is a userspace process/thread until it exits.

But Tycho, I won't insist. If you prefer to check PF_EXITING, I am fine.

Oleg.


