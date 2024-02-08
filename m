Return-Path: <linux-kernel+bounces-58334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 101A384E4C9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B90281AB6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB157D413;
	Thu,  8 Feb 2024 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhoLfLgy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81AA7CF25
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408826; cv=none; b=GCVx+3BiWUO5jlG8qPfuI2a5u4kHtLggFnYw/aM39jLnKFxt7+GON87j068h2gu3wYJJe92USbWa0AHPDrfk6N4T0Gp2+6srGwDdV6Tt2L9dMmlMugzlfTr/iF8LB3gjIU/BF5SoPUpR9f83ElkZoQaRNi77/cYrq789ol6iKqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408826; c=relaxed/simple;
	bh=fGN+8yem8iK2xAq/g74215xfHKUUWP3ssmQdsWN6nkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCN8M+uHOV5UdHmfncDq+daWGP7TMiljmltvncveYQnqK+Ik9mOhjPStX+kIOO65uWBlVGAUvNVyJCVG+PD91MhOBVUsHFS2uxxbqN/vv62bMDu/uhWAjllsDks57GBsn2wPY5KyP/fbL4tYVoMjkHsxnv3wZTJWu+34m0Q6V9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhoLfLgy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707408823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fGN+8yem8iK2xAq/g74215xfHKUUWP3ssmQdsWN6nkk=;
	b=KhoLfLgybZo6mZVGUELNTX5kjiGnDbP/D5QKt8RPHF0+kNBH8XgwrJbbsCEwCsjMOtTrPN
	yQgEUDTccy/HZFuo69CfyMEPFNR0Vz9vUgK73L9LGCnSTpY8AXQ4r4lBMa9uwZcqnMctx3
	NqfqIo4Uq8yUShm57NW0rt0TwXLTrgI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-lBOwh8qBM6KbU3EH3hgsWQ-1; Thu,
 08 Feb 2024 11:13:02 -0500
X-MC-Unique: lBOwh8qBM6KbU3EH3hgsWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 155803C28653;
	Thu,  8 Feb 2024 16:12:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.158])
	by smtp.corp.redhat.com (Postfix) with SMTP id 71A841C14B0E;
	Thu,  8 Feb 2024 16:12:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  8 Feb 2024 17:11:21 +0100 (CET)
Date: Thu, 8 Feb 2024 17:11:19 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
Message-ID: <20240208161118.GI19801@redhat.com>
References: <20240207114549.GA12697@redhat.com>
 <20240208-fragt-prospekt-7866333b15f0@brauner>
 <20240208135344.GD19801@redhat.com>
 <20240208143407.GF19801@redhat.com>
 <20240208-klopapier-aushebeln-446ac80a6e9b@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-klopapier-aushebeln-446ac80a6e9b@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 02/08, Christian Brauner wrote:
>
> > Is prepare_kill_siginfo() correct when we send a signal to the child
> > pid namespace? si_pid = task_tgid_vnr(current) doesn't look right in
> > this case but perhaps I am totally confused.
> >
> > And why do we need it at all? Can't sys_kill() and pidfd_send_signal()
> > just use SEND_SIG_NOINFO?
>
> Yeah, good point. I don't remember as it's been quite a while ago. My
> guess is that it just tried to mirror kill() itself without being aware
> of SEND_SIG_NOINFO. If you don't find anything wrong with this then
> switch it to SEND_SIG_NOINFO in a preparatory patch we can backport,
> please.

Yes, but I still feel I must have missed something. Will read this code
tomorrow.

And another note for the record before I forget this. We can probably
improve and rename access_pidfd_pidns(). Currently it is only used by
pidfd_send_signal() but pidns_install() looks like another user.

Oleg.


