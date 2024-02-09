Return-Path: <linux-kernel+bounces-59909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4875F84FD37
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785DB1C21D78
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6147084A50;
	Fri,  9 Feb 2024 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3RII4bM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6E582892
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508524; cv=none; b=jlDJ2spTKtE7qoX0uaE9N5kEmW29Afc3kSjQZovk0+8KuvQG//PYZprXr9xttEJtsNCWjoqcD8eSwK6UixRxYRhuPk2e1tGMOhPoJN8agggd7IfL/erBlJdaTSBsrocE/xTOL6fUgoH8eLN2J1Jvmgs3yz8YZNJukmPiWGdC+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508524; c=relaxed/simple;
	bh=ct4pYLqbWEvaFepWlnW0LcNyrdRiTi4jZVyKCOleQ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNaBi+he3qyRTEePG9VxDG+nXfvklCXdOcBPDrHvEXyK7A8ZPaLltcW3OvpFZtcLJr4FrDWFwiMWhC0YuWT8DOU1NNH6vHWOLKk0amE8+AAJAAV0MU5TDYNFw2DXw9CfpusAdyOiqeM7kIzTS/Phjn8NUvFuVTsGORimVJI5MzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G3RII4bM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707508521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Em5WxJdAGOzFKe0pJRNSvAunQeanzmTyzeJclMZdng=;
	b=G3RII4bMyDeihOcWTW8HGP+gaHFuQUN7uV9iNKQmTnT4VkknTF4sd4bg0TzvJ2k2/5ksAS
	ON2m+TvCUPdBi9dZmw9arlXMhwHJiuIjfWEE4SnIEiUNkHuRKFgAgk6OvVUeWYQVkuiADF
	jPZtE3/iEPVNi3eDNgr6aGfO1tWNqVs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-OsTCtYDJO_q9nZf8IYR7-w-1; Fri,
 09 Feb 2024 14:55:16 -0500
X-MC-Unique: OsTCtYDJO_q9nZf8IYR7-w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37EF738130AE;
	Fri,  9 Feb 2024 19:55:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.63])
	by smtp.corp.redhat.com (Postfix) with SMTP id 90968492BE2;
	Fri,  9 Feb 2024 19:55:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  9 Feb 2024 20:54:00 +0100 (CET)
Date: Fri, 9 Feb 2024 20:53:58 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] signal: add the "int si_code" arg to
 prepare_kill_siginfo()
Message-ID: <20240209195332.GA24647@redhat.com>
References: <20240209130620.GA8039@redhat.com>
 <87sf21zjy8.fsf@email.froward.int.ebiederm.org>
 <20240209163914.GE3282@redhat.com>
 <20240209-traben-geothermie-8c6aa7e1984f@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209-traben-geothermie-8c6aa7e1984f@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 02/09, Christian Brauner wrote:
>
> On Fri, Feb 09, 2024 at 05:39:14PM +0100, Oleg Nesterov wrote:
> > On 02/09, Eric W. Biederman wrote:
> > >
> > > Could you can pass in the destination type instead of the si_code?
> > > Something like I have shown below?
> > 
> > ...
> > 
> > > 	info->si_code = (type == PIDTYPE_PID) ? SI_TKILL : SI_USER;
> > 
> > Yes, I considered this option too.
> > 
> > OK, will send V3 tomorrow.
> 
> Hm, I don't think that's necessary if you're happy to have me just fix
> that up in tree.

Thank you!!!

looks obviously correct, but again, I will double check tomorrow just
in case.

> but I have a baby on my lap so double check, please:

;) I'm familiar with this.

Oleg.


