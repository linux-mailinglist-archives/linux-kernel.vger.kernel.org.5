Return-Path: <linux-kernel+bounces-59566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A862B84F900
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBC81F23553
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED35176045;
	Fri,  9 Feb 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJo24ZyD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C198D7603E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494290; cv=none; b=nWoGUz2cbnb0jiQjqNbqjmm/JMLeo1U8ZZSZDi52Ne9C9oG9SShlZgWKFDYwEnRhTicPFzV/h9ILZm9e44BM3n8Z2kCMSFGzcnjKyZmRfj7EqlVeroD4m5NfIOp08EaLCev6+hMnxzeLV7Ntlf5a+Iht05N3umnODHE2xo4wdDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494290; c=relaxed/simple;
	bh=9liaOJHkXmgoMLq2BOqbcJsWNZ7++m9AMPpRUz4DQBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0Xfogzhyi+PNf4PiYBFjRjvkUYdQV8mBeaudpmE+GevFAnXP5MpDmbrWk4oNGCNHbZg8noPjPRef1+GBJrDBVeGP8HgppPhZNSSixKHhJXuXhhAkRtrxSuEoW7+Bz+bse1lyGDyYLer5MCS6gJ1t1IFvEqcWWo1tz8zYj4ln9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJo24ZyD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707494287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9liaOJHkXmgoMLq2BOqbcJsWNZ7++m9AMPpRUz4DQBU=;
	b=eJo24ZyDMmPlsogtRIFAltPi97s9Ge5MoEKqiRqRoBTZf6pGygjRmGA8XziYjUEVXdL8S7
	mhN9XNMaQDIMGI3JdF/+J5LuqRfg4jTYTgqB6Nr+8ftyZsvFEQ3wr9H0q08xKX0Hi+Qs2+
	UZ0cuGgk//O784Hx86Eh4N7SNdzZIc4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-xcCQgqAgMLaBubu3R9dYCQ-1; Fri, 09 Feb 2024 10:58:04 -0500
X-MC-Unique: xcCQgqAgMLaBubu3R9dYCQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0544B185A780;
	Fri,  9 Feb 2024 15:58:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.84])
	by smtp.corp.redhat.com (Postfix) with SMTP id 58FA840C9444;
	Fri,  9 Feb 2024 15:58:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  9 Feb 2024 16:56:47 +0100 (CET)
Date: Fri, 9 Feb 2024 16:56:45 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240209155644.GD3282@redhat.com>
References: <20240209130620.GA8039@redhat.com>
 <20240209130650.GA8048@redhat.com>
 <20240209-stangen-feuerzeug-17c8662854c9@brauner>
 <20240209154305.GC3282@redhat.com>
 <20240209-radeln-untrennbar-9d4ae05aa4cc@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209-radeln-untrennbar-9d4ae05aa4cc@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 02/09, Christian Brauner wrote:
>
> On Fri, Feb 09, 2024 at 04:43:05PM +0100, Oleg Nesterov wrote:
> >
> > So the question: do you think we also want PIDFD_SIGNAL_SESSION_GROUP?
>
> Thought about this as well and my feeling is to wait until someone asks
> for it. Right now, we have a reason to add PIDFD_SIGNAL_PROCESS_GROUP
> because of Andy's use-case. If someone has a use-case for session groups
> then yes. Otherwise I'd just not bother?

OK, agreed.

and I forgot to mention, if you want to add PIDFD_SIGNAL_PRGP you can
look at __kill_pgrp_info().

Oleg.


