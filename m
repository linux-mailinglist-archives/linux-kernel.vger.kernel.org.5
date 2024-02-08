Return-Path: <linux-kernel+bounces-58315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F88184E48C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F5CDB28F52
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C337D3ED;
	Thu,  8 Feb 2024 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flpjLXso"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEAE7CF13
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407936; cv=none; b=hnCFl+1XyIZu8Nt3UsLYer6+It/qd5+fxot+Q4m/Qt68in1kN0xoyeGOeUBeRUQMKfhbKdPtLvoZKDAKxqjYw59WR+vceutJACRRMRxwlnRU7vp257a8tyzcylKI4qVeX+iSxl5UNAWdv33qbq6Sp7IKenTJJBWENozaL02CLzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407936; c=relaxed/simple;
	bh=8oJy4Kfei28svL0fI4SkUs4fm5SgdA1bndhR0xQYe7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu8X+Ae7+9aOFS9iLHQ4gNSUwRdq7I1Tf4+yhe2zAGzyj4Xp14MOfVPNRxgN28XNFcG8FxQtloszcIWtPMa8wc+0xYbF0GCiqPsHnfJ/sa1yEDNdF4m0gDK/QG94BWW21S65CVxfcpuQGELFTLMivDsc4YQJHbjuQAF+t0pEUVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=flpjLXso; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707407933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+3BZHF1qWhvPf5pTxNj3ZoKVEMefGkuazF41aVOoNk=;
	b=flpjLXsoXAJPD+GXVWgsM0/mrt0Sl0aLTbyPXg2LbtPvsYGqE85Br6N7xXeIJSBWvogW6D
	NPAG4I7eBu8krHkb4lIV4Kxf7aSki3SvnRaDajEfUTq01BbyAPMxkJovO4OPNQ3Jbwa9Au
	qWAqISiYN+i1tVdIYiAOtip3Y8vlOiE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-i0aRowXuP9KsXO5z6OR4Gw-1; Thu, 08 Feb 2024 10:58:50 -0500
X-MC-Unique: i0aRowXuP9KsXO5z6OR4Gw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0ED510201EA;
	Thu,  8 Feb 2024 15:58:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.158])
	by smtp.corp.redhat.com (Postfix) with SMTP id 29551112132A;
	Thu,  8 Feb 2024 15:58:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  8 Feb 2024 16:57:34 +0100 (CET)
Date: Thu, 8 Feb 2024 16:57:31 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
Message-ID: <20240208155731.GH19801@redhat.com>
References: <20240207114549.GA12697@redhat.com>
 <8734u32co5.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734u32co5.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 02/08, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > Turn kill_pid_info() into kill_pid_info_type(), this allows to pass any
> > pid_type to group_send_sig_info(), despite its name it should work fine
> > even if type = PIDTYPE_PID.
> >
> > Change pidfd_send_signal() to use PIDTYPE_PID or PIDTYPE_TGID depending
> > on PIDFD_THREAD.
> >
> > While at it kill another TODO comment in pidfd_show_fdinfo(). As Christian
> > expains fdinfo reports f_flags, userspace can already detect PIDFD_THREAD.
> >
>
> I have a question here.
>
> Why is this based on group_send_sig_info instead of send_sig_info?

Well. send_sig_info() accepts "struct task_struct *", not "struct pid *",
it doesn't do check_kill_permission(), and it doesn't handle the possible
race with mt-exec.

> In particular I am asking are the intended semantics that the signal is
> sent to a single thread in a thread group and placed in the per thread
> queue, or is the signal sent to the entire thread group and placed
> in the thread group signal queue?

This depends on PIDFD_THREAD. If it is set then the signal goes to
the per thread queue.

> Because honestly right now using group_send_sig_info when
> the intended target of the signal is not the entire thread
> group is very confusing when reading your change.

Agreed, so perhaps it makes sense to rename it later. See

	despite its name it should work fine even if type = PIDTYPE_PID.

in the changelog above.

Oleg.


