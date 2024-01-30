Return-Path: <linux-kernel+bounces-44501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31B28422E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF381290F86
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF81679E4;
	Tue, 30 Jan 2024 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFITeLRW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659AC679E1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613770; cv=none; b=oPzPksWVD7HGmtDZwuFf6+7bz3tbZ1Dm3YIFCBh08cwEZ59K34hCGFMLbs+IMpPKSgdh8cHz6OvShzSRxdod/i7CmNe8ULp9PwZ9TSaX9SNxJWLmdxNvFO6lurDvDC08z/zEjvHUb56iAcVqulv4GMfaYNxILvdgfaQx6+vOP4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613770; c=relaxed/simple;
	bh=X10Uv/kIYjCZ9856oEa7EqVQobF7EnFD7p2D/5ZYbuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IauXqJ0GeqvPntQJfCj9McbwHIyZoQ5xm/gqDWFpVifKFz9lHV96+Z5MRd8sOkMUE6GaG4xMP6iIrjeGhJIKLdkGmzKqcsYTc1jK0pwVVSQMpAirqd4NBzoSo1BQaUZCDNDtTkmh3SI7DhnzPG7efZn+SKkeBaEVcVGPQokLmms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eFITeLRW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706613767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lbt6pqkTcAveDCu7SeGXeYjFEpyubx/pRHH7MqmCo50=;
	b=eFITeLRWs3Tp0CLCzbhL10E5+J4RcCZhgK24xf+2/uNZFEvO67MSqjoaBvlx+Hp3Mi0YRp
	hb9lOK5oWs8B2DVgNkNlVV2ellyDKZdDmuV1v93oLDHRpuHhZgdO4PBVKRemeolDrcuQuz
	bfzFgatGVEEgk/JGj7nNguuU92zS+K0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-4AY0TIrwOE2f4qeWfBFE5A-1; Tue, 30 Jan 2024 06:22:43 -0500
X-MC-Unique: 4AY0TIrwOE2f4qeWfBFE5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B83385CBA3;
	Tue, 30 Jan 2024 11:22:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.237])
	by smtp.corp.redhat.com (Postfix) with SMTP id 7239B40C122E;
	Tue, 30 Jan 2024 11:22:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 30 Jan 2024 12:21:28 +0100 (CET)
Date: Tue, 30 Jan 2024 12:21:26 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC PATCH] pidfd: implement PIDFD_THREAD flag for pidfd_open()
Message-ID: <20240130112126.GA26108@redhat.com>
References: <ZbQpPknTTCyiyxrP@tycho.pizza>
 <20240127105410.GA13787@redhat.com>
 <ZbUngjQMg+YUBAME@tycho.pizza>
 <20240127163117.GB13787@redhat.com>
 <ZbU7d0dpTY08JgIl@tycho.pizza>
 <20240127193127.GC13787@redhat.com>
 <ZbVrRgIvudX242ZU@tycho.pizza>
 <20240127210634.GE13787@redhat.com>
 <20240129112313.GA11635@redhat.com>
 <20240129-plakat-einlud-4903633a5410@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129-plakat-einlud-4903633a5410@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 01/29, Christian Brauner wrote:
>
> On Mon, Jan 29, 2024 at 12:23:15PM +0100, Oleg Nesterov wrote:
> > @@ -3926,6 +3927,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
> >  		prepare_kill_siginfo(sig, &kinfo);
> >  	}
> >
> > +	/* TODO: respect PIDFD_THREAD */
>
> So I've been thinking about this at the end of last week. Do we need to
> give userspace a way to send a thread-group wide signal even when a
> PIDFD_THREAD pidfd is passed? Or should we just not worry about this
> right now and wait until someone needs this?

I don't know. I am fine either way, but I think this needs a separate
patch and another discussion in any case. Anyway should be trivial,
pidfd_send_signal() has the "flags" argument.

On a related note, should copy_process(CLONE_PIDFD | CLONE_THREAD) add
PIDFD_THREAD flag "automatically" depending on CLONE_THREAD? Or do we
want another CLONE_PIDFD_THREAD flag so that PIDFD_THREAD can be used
without CLONE_THREAD? Again, I do not know, needs another discussion.

> Otherwise this looks good to me!

OK, thanks, I'll send v2 in a minute. The patch is the same, I only
updated the comments.

Oleg.


