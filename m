Return-Path: <linux-kernel+bounces-59252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F5A84F3DC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201FA1C24894
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C830E25626;
	Fri,  9 Feb 2024 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuQLrUlr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422E225614
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476118; cv=none; b=YLaJIfR4qOglI09kltc+teM7V3oI8A5vBpAGbjEDp5CZqfMrNpPh5Gtol1fltAQEhXxZHClpVwWy5AB5btPQHzNabYzF0vShEDVSUqhjOmzK38hwOWXf5nOoJFTdhtNK/cokx2wCKv0XbXzbTRsv+7eoXfxMbGGkWkyyRc2vdU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476118; c=relaxed/simple;
	bh=PuoJ7FAF6sK9oT75e0IAxDQhewqKsNVGGVSNtkERdh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdiAPrEeY20EQpKZC8lZJrp7An35co2oty9Og+9vz0l/JLmJNDkt0pnCoFiCxHfXWn2f/Xgc6pSMwWTXjOeq+j8k0OMP+0Qlf1VVuoEKsRJgABTpeu1lhDx/VSKoE/+PCWctnpy9hHYFJBRJVjNsV2kshD0NkLgEMssWsBlKtFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cuQLrUlr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707476114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMAPlkEOykUikv1rtlx9+4EfL9AWEUsHnCPiEO7N96Q=;
	b=cuQLrUlrb9kuQbIjc8NwoKXl1lg+7ad9hlxfwwd6lAmwVO5OsThrBaG2RHyqMTkfmiYI6a
	PFuh+6j+HJRcRNaUeinOEbpGdBsB1L0Zfi0sRHLK0xCzJzslAYgExz6zywXnT7HBNzlL2w
	uyqRvVjP8Fx5uVQQNMXJaX/PoZRfwBM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-HLskda55OjePR3B4iQ8_IA-1; Fri, 09 Feb 2024 05:55:11 -0500
X-MC-Unique: HLskda55OjePR3B4iQ8_IA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B43DC85A58B;
	Fri,  9 Feb 2024 10:55:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.84])
	by smtp.corp.redhat.com (Postfix) with SMTP id 4629C8BCC;
	Fri,  9 Feb 2024 10:55:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  9 Feb 2024 11:53:54 +0100 (CET)
Date: Fri, 9 Feb 2024 11:53:52 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
Message-ID: <20240209105351.GB3282@redhat.com>
References: <20240207114549.GA12697@redhat.com>
 <8734u32co5.fsf@email.froward.int.ebiederm.org>
 <20240208155731.GH19801@redhat.com>
 <20240209-postfach-notorisch-f8443677b490@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209-postfach-notorisch-f8443677b490@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 02/09, Christian Brauner wrote:
>
> On Thu, Feb 08, 2024 at 04:57:31PM +0100, Oleg Nesterov wrote:
> > On 02/08, Eric W. Biederman wrote:
> > >
> > > Because honestly right now using group_send_sig_info when
> > > the intended target of the signal is not the entire thread
> > > group is very confusing when reading your change.
> >
> > Agreed, so perhaps it makes sense to rename it later. See
>
> Agreed. The function seems misnamed and incorrectly documented. It just
> seems that it's never been used with PIDTYPE_PID but it's perfectly
> capable of doing that. So maybe just put a patch on top renaming it to
> send_sig_info_type() and remove the old comment. But I can live without
> renaming it for now as well.

OK, I'll update the comment, please see below.

It should probably say more about the case when type > PIDTYPE_TGID,
but this is "offtopic" for this patch.

Oleg.

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1437,7 +1437,8 @@ void lockdep_assert_task_sighand_held(struct task_struct *task)
 #endif
 
 /*
- * send signal info to all the members of a group
+ * send signal info to all the members of a thread group or to the
+ * individual thread if type == PIDTYPE_PID.
  */
 int group_send_sig_info(int sig, struct kernel_siginfo *info,
 			struct task_struct *p, enum pid_type type)


