Return-Path: <linux-kernel+bounces-41375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7562283EFC6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F39283AC9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249C82E847;
	Sat, 27 Jan 2024 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxNyqPLv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51752E834
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706384010; cv=none; b=X4OY9XXRZmz37jOGGYDa4WzB8n7+C764X+j/ZmBBhZJT/3uSKrxb7/FLFDRZED/hGDt9Q+u3FV5nHDWpcoz1FK8MjapXePQ+yzFKT/bO66aKuiCGwY2QrZMC+jOH5jDrPCzcmTyvObwVv2lvesfjs394i0e86qB9lAXPdMcLOGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706384010; c=relaxed/simple;
	bh=tspagdP0rzK+AQCZ0dOlmKPm6GSncitJWM+JedleeQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0bKfESGu6l2ICnSFx+RY+hXSnHsyj+r+QDqNvOJv8Pv5Rh6IbXZsE1xIOXinywE8rz4VvnhY6e1IimnEC4QSIdxY3eGQH1vO1NPFlhrJbKMqhiK+aGcMU7ddADVcfBlQ/iMHNJgtIUNsZHBE1Y0clEXzqsyoUeYpuFcKccN5tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxNyqPLv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706384008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tspagdP0rzK+AQCZ0dOlmKPm6GSncitJWM+JedleeQk=;
	b=RxNyqPLvWOFOyjid8yKyAA/sj9xS35JTJSpV5cbFQFDZYj8TaJ4tJdkHR2frMLQqOmQKWW
	aQf+J03ACEsqsevx7Jfp3MOBnPPFpmg1oMsuLX7OaaAwUFG7KO9JmlBbM83xJwDF3/fU1N
	d38o95RqP2xogNHEGl/EApL/77O0MVg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-t_1FSmKlMQmL8ucdYDk2cg-1; Sat, 27 Jan 2024 14:33:21 -0500
X-MC-Unique: t_1FSmKlMQmL8ucdYDk2cg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15B81185A780;
	Sat, 27 Jan 2024 19:33:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.4])
	by smtp.corp.redhat.com (Postfix) with SMTP id B10E6C15587;
	Sat, 27 Jan 2024 19:33:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 27 Jan 2024 20:32:07 +0100 (CET)
Date: Sat, 27 Jan 2024 20:32:05 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tandersen@netflix.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pidfd: don't do_notify_pidfd() if
 !thread_group_empty()
Message-ID: <20240127193204.GD13787@redhat.com>
References: <20240127132043.GA29080@redhat.com>
 <20240127132105.GA29091@redhat.com>
 <ZbU72/83nv2UdcCK@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbU72/83nv2UdcCK@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 01/27, Tycho Andersen wrote:
>
> On Sat, Jan 27, 2024 at 02:21:05PM +0100, Oleg Nesterov wrote:
> > do_notify_pidfd() makes no sense until the whole thread group exits, change
> > do_notify_parent() to check thread_group_empty().
> >
> > This avoids the unnecessary do_notify_pidfd() when tsk is not a leader, or
> > it exits before other threads, or it has a ptraced EXIT_ZOMBIE sub-thread.
> >
> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
>
> Looks good to me, thanks.
>
> Reviewed-by: Tycho Andersen <tandersen@netflix.com>

Thanks Tycho,

Oleg.


