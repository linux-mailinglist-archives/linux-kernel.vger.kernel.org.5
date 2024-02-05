Return-Path: <linux-kernel+bounces-52897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E84F849DFB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513FB1C22234
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F3E446B8;
	Mon,  5 Feb 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wb06kQfv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6165A446B2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146646; cv=none; b=o1G/lPgsZZK83M1n9xFM7USIPmAOq/ogPdR54VZ9RlzwHNjASauXPUHrp62W2fm4p7m/gML+YpqeMhf5K4k/5F10LZdJRy1FMkqrtT5qnVNJyJmd+TV506E6ICzM3yuMRKA3kBaCm9y80fEMcJ8N33WWTOIxN0AuMkba6ChsJB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146646; c=relaxed/simple;
	bh=bY2LCfx5dCeJo/RzEZUvi63DItu/t1wlxCBwCaaht2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvEQ9x7gd9msll6ouMa9Qbi6rVevfoLQaJrm6a85m9g4/2+jFgCWja96tj6ZKiihx8ncrAKYlBz2V0Vt/K4sUpTt7cjakFBcHqWSFgO7yqBLTQY2DrZ/wDagOtnBHIO1tcWWsQH9tMslmDqqBav/0qHMfNuLVwKMcJtUT+xr5dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wb06kQfv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707146643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yMmxqlMU+IwtfjOZB2FX79QpzJiP3NtOWGspNIlRY28=;
	b=Wb06kQfvuWN4HOzFEs42IS+VClIyzSzovYyEcG2NyRRwqqswxoWpZ0EAe5bCwDuzHs5Eem
	+Q4mjmeCjqpdca60MNaaOZ7ALme4x/V9RjsLy8DRxoERFiFmVjfJmvdmEfEYKsA54s1yND
	03SMX3DziwmEodOJOGAw4NK7hqY5wOs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-KihJCJEhN_i8IzwsAGZJog-1; Mon, 05 Feb 2024 10:23:59 -0500
X-MC-Unique: KihJCJEhN_i8IzwsAGZJog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95B9687DC00;
	Mon,  5 Feb 2024 15:23:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.165])
	by smtp.corp.redhat.com (Postfix) with SMTP id 2A40F1C060AF;
	Mon,  5 Feb 2024 15:23:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  5 Feb 2024 16:22:44 +0100 (CET)
Date: Mon, 5 Feb 2024 16:22:41 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] pidfd: implement PIDFD_THREAD flag for
 pidfd_open()
Message-ID: <20240205152241.GB15853@redhat.com>
References: <20240131132541.GA23632@redhat.com>
 <20240131132602.GA23641@redhat.com>
 <20240202-helium-eurem-f63c0f9328c0@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202-helium-eurem-f63c0f9328c0@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 02/02, Christian Brauner wrote:
>
> > @@ -2050,6 +2051,8 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
> >
> >  	seq_put_decimal_ll(m, "Pid:\t", nr);
> >
> > +	/* TODO: report PIDFD_THREAD */
>
> So I think we don't need to do anything here. Since PIDFD_THREAD sets
> O_EXCL in file->f_flags and in contrast to do_dentry_open() it isn't
> dropped. So userspace can already detect PIDFD_NONBLOCK as O_NONBLOCK
> and PIDFD_THREAD as O_EXCL.

Ah, indeed, I didn't know that fs/proc/fd.c:seq_show() reports ->f_flags.
Thanks.



OK, what about another TODO in sys_pidfd_send_signal() ?

I mean, should I send a simple patch which changes pidfd_send_signal()
to use do_send_specific() if PIDFD_THREAD ? Or do you think this should
be controlled by pidfd_send_signal's "flags" argument?

I honestly do not know what makes more sense.

Oleg.


