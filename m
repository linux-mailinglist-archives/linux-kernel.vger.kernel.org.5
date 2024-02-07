Return-Path: <linux-kernel+bounces-56321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 701B384C8AB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08FDFB2560F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9E214274;
	Wed,  7 Feb 2024 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ON8auzqI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470CD802
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301818; cv=none; b=Vh9bO50o1l46CksbyK5acgQP9O3URz3qEhpmZ/7yLUge1kCPnJQKUROuULI+XMc3Yy8IYXREne42YQTVMHKnQa8Na4Oi3WWtIf8/rLsXKA5s+VFT5dSHdshtpp4FRJNf/peFGMZ40ruqHONpY4ALBg40XG3ie9eflvtG+WdUJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301818; c=relaxed/simple;
	bh=SYwYCEnqQYQ+hYirpuiPZCwt/4X5tBxQZJMg02Qkego=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mER8BUtlCzKbdMsOqDhbeHtL4IzLVx1kmWtprybMw1hOia/9eRSWxiTwS25hU64C4fPu0vtaKUyXLPbPrmdwrByCkodphwztN4T/5LIneUAIST8RmJllLLW696Lj1k0XpYMg1gEixCyaO1y/TxVfX2/voEXr+NsF1nnaE5nHwo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ON8auzqI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707301814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SYwYCEnqQYQ+hYirpuiPZCwt/4X5tBxQZJMg02Qkego=;
	b=ON8auzqITwmWvKkwKfMVXaiOXaBGp8OB/kMgXlANbMhhX68TdZC5F/edYGq54k2KCrIGCR
	b0Qa2d4kGmCI71FMGBCBEuR1AvrfxDGtFuvUSHfvWDudK1twvnZCDsgRmiZvJQKegLRnqy
	4OJK0a6nns6Xq48NeiZHdt0G1IKhe8w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-HW9XA8KdNFeMtgpCsj9MIg-1; Wed, 07 Feb 2024 05:30:09 -0500
X-MC-Unique: HW9XA8KdNFeMtgpCsj9MIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 945FD828CEB;
	Wed,  7 Feb 2024 10:30:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.212])
	by smtp.corp.redhat.com (Postfix) with SMTP id E898B112131D;
	Wed,  7 Feb 2024 10:30:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  7 Feb 2024 11:28:52 +0100 (CET)
Date: Wed, 7 Feb 2024 11:28:50 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Tycho Andersen <tycho@tycho.pizza>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH] pidfd: getfd should always report ESRCH if a task is
 exiting
Message-ID: <20240207102849.GA6627@redhat.com>
References: <20240206164308.62620-1-tycho@tycho.pizza>
 <20240206173722.GA3593@redhat.com>
 <20240206180607.GB3593@redhat.com>
 <ZcJ13uLxD6rTqqZZ@tycho.pizza>
 <20240206192553.GC3593@redhat.com>
 <20240207-beseitigen-ausfliegen-b2b95de67c4f@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207-beseitigen-ausfliegen-b2b95de67c4f@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 02/07, Christian Brauner wrote:
>
> On Tue, Feb 06, 2024 at 08:25:54PM +0100, Oleg Nesterov wrote:
> > On 02/06, Tycho Andersen wrote:
> >
> > > On Tue, Feb 06, 2024 at 07:06:07PM +0100, Oleg Nesterov wrote:
> > > > Or we can check task->files != NULL rather than PF_EXITING.
> > > >
> > > > To me this looks even better, but looks more confusing without a comment.
> > > > OTOH, imo this needs a comment anyway ;)
> > >
> > > I thought about this, but I didn't really understand the null check in
> > > exit_files();
> >
> > I guess task->files can be NULL at least if it was cloned with
> > kernel_clone_args->no_files == T
>
> Won't this give false positives for vhost workers which do set
> ->no_files but are user workers? IOW, return -ESRCH even though -EBADF
> would be correct in this scenario?

OK, agreed. Lets check PF_EXITING or exit_state.

Oleg.


