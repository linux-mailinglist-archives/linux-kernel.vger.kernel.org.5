Return-Path: <linux-kernel+bounces-65203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 405AE854957
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F114228EFA2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29295381D;
	Wed, 14 Feb 2024 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUAY5a+7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83044535D7
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 12:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914300; cv=none; b=F51pVaCHIaoK+2Ky3nu1j2hpYqXVvw6hOqzWsovF8RkBhwSypG5xu7SorI3hbM5mvHu0YFi9FzEmWoPnfbLJzIQlb5R5hKe7psc1N0rnG8lrdRnWqS9QlDeQZmAl7SYYL1eK/jMttmKj7DCUoOIHU20UPHlPV0hC0TfqyFj/zEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914300; c=relaxed/simple;
	bh=5L00shtRx0u3K3qY4nS2i8Dv2Y+Jru41wZEr3M9uzfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgI0zJHjm9N4FoeQ1G8/md9hfSZmDoV1q1fQ2FnDJcmfj4EFjjCz2lS81/861o8Bd/3U740FYdvUavizQzW2+lHSbsdRDh54ptyrzDNvDVlwwSUQ3/OZ+38v+lVzm0g1mVb5fKsnVZnZlYWXqSkhmBtuhK+lJvEc8ZPobNb3onk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OUAY5a+7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707914297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oO8fV9kKnERG1FqkS8YQ493S/NllBnU42M5+nmWoL50=;
	b=OUAY5a+7E1dQjSN4x8iWypboyyzga0Jevqnkin1TOD9mXsqHgjL1JDOsTKBQdES1/iMLFX
	HB8QsnRgusqICMMXoCvIW5Gz7YVd3qh3BufsMbYsUfTfwcvsN5eiLKMJp161IvS1Yf6Ecp
	Spo5C8ifciPBo2d6yqibsop4XMhPcEg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-DiAhQK0yORKi6rXiTKTaKQ-1; Wed,
 14 Feb 2024 07:38:15 -0500
X-MC-Unique: DiAhQK0yORKi6rXiTKTaKQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D2702812FE5;
	Wed, 14 Feb 2024 12:38:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.126])
	by smtp.corp.redhat.com (Postfix) with SMTP id 910572166B36;
	Wed, 14 Feb 2024 12:38:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 14 Feb 2024 13:36:58 +0100 (CET)
Date: Wed, 14 Feb 2024 13:36:56 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240214123655.GB16265@redhat.com>
References: <20240209-stangen-feuerzeug-17c8662854c9@brauner>
 <20240209154305.GC3282@redhat.com>
 <20240209-radeln-untrennbar-9d4ae05aa4cc@brauner>
 <20240209155644.GD3282@redhat.com>
 <20240210-abfinden-beimessen-2dbfea59b0da@brauner>
 <20240210123033.GA27557@redhat.com>
 <20240210-dackel-getan-619c70fefa62@brauner>
 <20240210131518.GC27557@redhat.com>
 <20240210-chihuahua-hinzog-3945b6abd44a@brauner>
 <20240210165133.GD27557@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210165133.GD27557@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 02/10, Oleg Nesterov wrote:
>
> On 02/10, Christian Brauner wrote:
> >
> > +	if (type == PIDFD_SIGNAL_PROCESS_GROUP)
> > +		ret = kill_pgrp_info(sig, &kinfo, pid);
>
> I guess you meant
>
> 	if (type == PIDTYPE_PGID)
>
> other than that,
>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Yes, but there is another thing I hadn't thought of...

sys_pidfd_send_signal() does

	/* Only allow sending arbitrary signals to yourself. */
	ret = -EPERM;
	if ((task_pid(current) != pid) &&
	    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
		goto err;

and I am not sure that task_pid(current) == pid should allow
the "arbitrary signals" if PIDFD_SIGNAL_PROCESS_GROUP.

Perhaps

	/* Only allow sending arbitrary signals to yourself. */
	ret = -EPERM;
	if ((task_pid(current) != pid || type == PIDTYPE_PGID) &&
	    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL)
		goto err;

?

Oleg.


