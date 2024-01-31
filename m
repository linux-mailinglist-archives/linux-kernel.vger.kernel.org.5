Return-Path: <linux-kernel+bounces-46588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC718441B8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BF7287EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D7D82866;
	Wed, 31 Jan 2024 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIvBLXkS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF66169DEB
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710881; cv=none; b=cPDaiBiUfH937kYpqgsxDoJDdvTWMy9Hl+5C7xImwB973RP1oDN4fV+t92BlW2R1uARknFg5/7XpMb4UDYLY9/xOEphYX1EJ2oIyswzqIDbsCfwa2dHoVgG53irxXGo0OdbPgK2QKsa454PZdAB7IvF+qmxObmKE9o7fOZPPn9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710881; c=relaxed/simple;
	bh=fSiMmFA1Onj6bA6ApyGPOy0mxZtbDqOV4qzmHd/evew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4WqDw22XFtUbzYXZU6TF53DMcBOYOTK3o6deXPUv407s9VY1RQlfKne5n6wgMEZnRUYtuqIoge7a4XMzLe4u/s4ELBwItWvRK6NY4y2nRCv3JcxSgiX4xKHM9W5wufkM1o1W4gV1BG4hxwBwX6ZJ+g/OlT3wdgNCGWvU+mI+gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YIvBLXkS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706710878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmWgIn8/losqPNaZbqt7S0IwT1KTKOd2fh4BG0eCSsU=;
	b=YIvBLXkSniyNYOrXON6GXrhEe/HNlmad0Py8h/iD6S39JSnNnxRKvKNjrAozzMu40BNM2Z
	13OfEoWCbcUCwqDo9aBwN9rf0RGYF8RYqkJfBkoZvbrRIrAekqwk44fDPYs2lhQPBCzR9e
	xzO2CX8S2Vd238+/hCRwT/T4Y+KwbpU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-9qT7n0-xMQuk6NJR10R6Iw-1; Wed,
 31 Jan 2024 09:21:15 -0500
X-MC-Unique: 9qT7n0-xMQuk6NJR10R6Iw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9737F2812FE1;
	Wed, 31 Jan 2024 14:21:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.249])
	by smtp.corp.redhat.com (Postfix) with SMTP id 8F2DF3C2E;
	Wed, 31 Jan 2024 14:21:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jan 2024 15:20:00 +0100 (CET)
Date: Wed, 31 Jan 2024 15:19:58 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] pidfd: implement PIDFD_THREAD flag for
 pidfd_open()
Message-ID: <20240131141957.GB2609@redhat.com>
References: <20240131132541.GA23632@redhat.com>
 <20240131132602.GA23641@redhat.com>
 <20240131-raubbau-rentier-7ca9be9bc7c9@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131-raubbau-rentier-7ca9be9bc7c9@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 01/31, Christian Brauner wrote:
>
> On Wed, Jan 31, 2024 at 02:26:02PM +0100, Oleg Nesterov wrote:
> > With this flag:
> >
> > 	- pidfd_open() doesn't require that the target task must be
> > 	  a thread-group leader
> >
> > 	- pidfd_poll() succeeds when the task exits and becomes a
> > 	  zombie (iow, passes exit_notify()), even if it is a leader
> > 	  and thread-group is not empty.
> >
> > 	  This means that the behaviour of pidfd_poll(PIDFD_THREAD,
> > 	  pid-of-group-leader) is not well defined if it races with
> > 	  exec() from its sub-thread; pidfd_poll() can succeed or not
> > 	  depending on whether pidfd_task_exited() is called before
> > 	  or after exchange_tids().
>
> I think that we can live with that for now. If it doesn't hinder Tycho's
> use-case it's fine.

OK, good.

> (I often wish that we could report custom data from poll similar to
> kqueue on bsd then we could attach file specific information to the
> notification. That would enable userspace to handle this the way they
> want.)

Or at least perhaps we can change do_notify_pidfd() to use the keyed
wakeups... I'll try to take a look later.

> > thread_group_exited() is no longer used, perhaps it can die.
>
> Feel free to add a patch for that on top of it.

Yes, will do.

Oleg.


