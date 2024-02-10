Return-Path: <linux-kernel+bounces-60409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83A985047E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 14:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3FF0B22A5F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 13:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FE2535CE;
	Sat, 10 Feb 2024 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZNW4wxJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9411E482D2
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707571004; cv=none; b=qTM0tMi9+xDq4tSnJLmwkaaskJV4RdUnRI17/NJNWWH4F0+qPMev/LBJKvcRTXvEJzgXOiUIHX8/LhK5gFIyhlDwJbkHG1D6jnLIxa7c8pCBbvzb6KnCCJ8MOvKYrn6la6DMFCUjU0y8DOwK98+soSdGqW9RihQZ2j8cf0By76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707571004; c=relaxed/simple;
	bh=HpFHIIqeBXqulmQa3+Js29X+KfMEgFiwOOrpHsnaLgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Db55CAQ3hhZJwjsu0K1i2MHMdRLzUVZxqgjcrLxPF6IJhAnKqGwmp7jeN2zOIR6L8KbGi/QJFCA5suFaL35lcJTSKyeBYpOT0L9wmLOEhwIVihPD4Ql7Zo4LmG4cj8eRcv7uR68pXttYkNvdFvORGZ6jk+dwBmWhRC5UjPx5bXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZNW4wxJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707571001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sR82DA640YvaUHIigK5faA7hW88PKr3uHIF6nXu33zM=;
	b=fZNW4wxJYsIoO7nkGC3JN4fjqe3GxenImQ3mjBg/LgC8H7Svn0Xr+106eaSPkhJ0lj/tyJ
	MdvkGTzRpOUjp/qAsKDqTcQEC/l8myFQGeQLFp9ogVOL1MKVAQGKR1gCN1eB8MS/3h2Z3f
	A/2mmi1+jdkx9RpEUA07yQv9Ir22wyE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-Py3ii3VeMSK9g5YxLLwysA-1; Sat,
 10 Feb 2024 08:16:37 -0500
X-MC-Unique: Py3ii3VeMSK9g5YxLLwysA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C5D33C0ED4C;
	Sat, 10 Feb 2024 13:16:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with SMTP id 832DA400D6D2;
	Sat, 10 Feb 2024 13:16:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 10 Feb 2024 14:15:21 +0100 (CET)
Date: Sat, 10 Feb 2024 14:15:18 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240210131518.GC27557@redhat.com>
References: <20240209130620.GA8039@redhat.com>
 <20240209130650.GA8048@redhat.com>
 <20240209-stangen-feuerzeug-17c8662854c9@brauner>
 <20240209154305.GC3282@redhat.com>
 <20240209-radeln-untrennbar-9d4ae05aa4cc@brauner>
 <20240209155644.GD3282@redhat.com>
 <20240210-abfinden-beimessen-2dbfea59b0da@brauner>
 <20240210123033.GA27557@redhat.com>
 <20240210-dackel-getan-619c70fefa62@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210-dackel-getan-619c70fefa62@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 02/10, Christian Brauner wrote:
>
> The question is what is more useful for userspace when they do:
> pidfd_send_signal(1234, PIDFD_SEND_PROCESS_GROUP)?
>
> (1) They either mean to signal a process group that is headed by 1234.

Yes, this is what I had in mind, see also another email from me.
Simple, clear, and matches kill(-1234).

> (2) Or they want to signal a process group of which 1234 is a member or
>     the leader.

Somehow I didn't even consider this option when I thought about
PIDFD_SIGNAL_PGRP...

> From a usability perspective (1) is a lot more restrictive because it
> requires @pidfd to refer to a process group leader.

Yes, but to be honest (2) doesn't fit my head. Probably simply because
I always had (1) in mind...

But I won't argue if you think that (2) has useful usecases.

Oleg.


