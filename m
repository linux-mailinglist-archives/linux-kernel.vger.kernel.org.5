Return-Path: <linux-kernel+bounces-140178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F9B8A0C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4148E285649
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23560144D2D;
	Thu, 11 Apr 2024 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Da3qdCRw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEBE13B2A8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827849; cv=none; b=W3nfRnRs+XMXpDCof3GkBEP4HKc1bsym8AkhhQUefPewxhY66QUcaWfLUwE8mWGSvxOVWTfmDc1rnHqvI14DvOQwbV3PuM3x4liaHGszj8Qy7GU0ZBeh1DBA2r6j29OdhnV+YhQqW0Ja/6Q1125W/mjeQEoCt7E/hhBxS2fiRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827849; c=relaxed/simple;
	bh=nPlDhjLJl8vVK2JOE4C46tNSSM/DHidQf1aYKFUdmy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFv09J7SWMsSgmXoG23vOZJt9CuFgI79sedKwhGhzw9MoolKwtMkr4hI25ca/bSJ9Is9Lm0Ba0jLxTPrGHHhSv9BbKslGjT9vmdpLzzLT17qj2lfgRu5/n0siKMOKU3eSOt3gUb7z0oo2ZVaHPwYM3BhZinPAS5P6b5pvEeNhCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Da3qdCRw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712827846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p72eUFR+DE8NOypI2Opz7gp0RzPrglSluMB3fxFXBQY=;
	b=Da3qdCRwZzofYzXBvt7vwx58Lgy8OF664e5qODHZmNFmtm8uyiSxisWroQJJ8BRXVEUa66
	ieeuQLa+vK4eJYXEQe82qjjt8SHrA0JhIVq3XZHs802fUcz2hAk4g5C4mG0582zrQyOzq+
	Hus8o4FxkfdCu2bL5q2gBu3kwFazSYg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-WQs05tYPPn2c55yqXt7QKA-1; Thu, 11 Apr 2024 05:30:39 -0400
X-MC-Unique: WQs05tYPPn2c55yqXt7QKA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7556A802CB0;
	Thu, 11 Apr 2024 09:30:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.235])
	by smtp.corp.redhat.com (Postfix) with SMTP id 41A50492BC6;
	Thu, 11 Apr 2024 09:30:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 11 Apr 2024 11:29:13 +0200 (CEST)
Date: Thu, 11 Apr 2024 11:29:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Eric Van Hensbergen <eric.vanhensbergen@linux.dev>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	kent.overstreet@linux.dev
Subject: Re: [GIT PULL] fs/9p patches for 6.9 merge window
Message-ID: <20240411092907.GA5494@redhat.com>
References: <ZfRkyxUf8TIgsYjA@1149290c588b>
 <20240408141436.GA17022@redhat.com>
 <74f117635037a82dc2fb2923993cf329b6939b7e@linux.dev>
 <e73a1e0c90ebce33c23f8f7746c23c1199f62a78@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e73a1e0c90ebce33c23f8f7746c23c1199f62a78@linux.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 04/10, Eric Van Hensbergen wrote:
>
> April 10, 2024 at 12:20 PM, "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev> wrote:
> > April 8, 2024 at 9:14 AM, "Oleg Nesterov" <oleg@redhat.com> wrote:
> > > Hello,
> > >  the commit 724a08450f74 ("fs/9p: simplify iget to remove unnecessary paths")
> > >  from this PR breaks my setup.
> >

> I think
> I've reproduced the problem, fundamentally, since you have two mount
> points you are exporting together. I believe we are getting an inode
> number collision which was being hidden by the "always create a new inode
> on lookup" inefficiency in v9fs_vfs_lookup.  You could probably verify
> that for me by stating the /home directory and the / directory on the
> server side of your setup.

Yes, yes,

	$ ls -ldi / /home
	2 dr-xr-xr-x. 18 root root 4096 Jan  4  2016 /
	2 drwxr-xr-x.  7 root root 4096 Dec 20  2022 /home

that is why I showed you the relevant parts of my /etc/fstab

> If qemu detects that this is a possibility it usually
> prints something: qemu-system-aarch64: warning: 9p: Multiple devices
> detected in same VirtFS export,

My qemu is quite old, it doesn't. But I tested this on another machine
and yes, the newer qemu does warn.

(annoyingly, I had to redirect stderr to the file to see this warning,
 it is cleared by the booting kernel otherwise).

> I can confirm that multidevs=remap in qemu does appear to avoid the
> problem,

Confirm!

I didn't know about this option (and again, my old qemu doesn't support
it), but everything seems to work just fine with the newer qemu and
multidevs=remap. Thanks!

So I think this regression is minor.

> now that i can
> reproduce the problem, I'm fairly certain I can get a patch together
> this week to test to see if it solves the regressions.

Thanks ;)

Oleg.


