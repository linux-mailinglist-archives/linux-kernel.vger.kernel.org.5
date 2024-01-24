Return-Path: <linux-kernel+bounces-36269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A9A839E37
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE3F1C27803
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630171396;
	Wed, 24 Jan 2024 01:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gV+XAYQB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926F1860
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706059612; cv=none; b=uKgpZRPJnz2p1srGWIt2tqW+NFf5dDZpzZtN1omlalQSJ+A98J+acL2UKYwCdQSMiISE5+PRyS+LAl+IseZYUMOmDkDm2mSr4t32ZuX2IczRbldEh9XTCWMR/5pc8L/dE47rzRo4dgv8ab1oNsENZhV99HxXWot/VQ4SfobLWQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706059612; c=relaxed/simple;
	bh=OUE9f/qleU0xiD8NQz2GDqnq9GjdrISzx5tWwgLKeSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGAfxxsPMViqBoBl/cRXw1+lYI0aTBmKrmjR4ZlR4f6gmrR7/v63Cf1hIM+DSVEqQAKT/kA6QOWoUICOSo1VBLVDihwNyTMAY9qkAefiBPAzf4lBKO0ksYLs9LxuDkNpq5cgcbVHUG5zf32HXTCVOjhA6zHSsjbYAG52IdUSvgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gV+XAYQB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706059610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OUE9f/qleU0xiD8NQz2GDqnq9GjdrISzx5tWwgLKeSQ=;
	b=gV+XAYQBWjqlPkZedCi62yfJ6ZXl+FJ/C36tbr4E0VTaH5vTAz96UVUjcf30oMHdOZxLXh
	4WevmoxW0CnoY1ISUjLdvmxiiFFxrSE58V2ZlA6jbxlPj3xjzG6KkarI3k+EwlCNUkktsY
	QmyIyqbryaJt8Rd/HgmXMHKwf9H69cM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-DCk2LN3nOYSOJ7LOlXBz-w-1; Tue, 23 Jan 2024 20:26:46 -0500
X-MC-Unique: DCk2LN3nOYSOJ7LOlXBz-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4187E84A292;
	Wed, 24 Jan 2024 01:26:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.7])
	by smtp.corp.redhat.com (Postfix) with SMTP id E7173C2590E;
	Wed, 24 Jan 2024 01:26:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 24 Jan 2024 02:25:32 +0100 (CET)
Date: Wed, 24 Jan 2024 02:25:30 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240124012529.GC26412@redhat.com>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240123222231.GA25162@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123222231.GA25162@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 01/23, Oleg Nesterov wrote:
>
> But to be honest I can't understand test_non_tgl_poll_exit() at all. I don't
> even understand why the process/thread created by fork_task_with_thread()
> should ever exit. And why it creates the "writer" child... Never mind, too
> late for me to read the code.

Ah, OK, it passes thread_wait_exit to fork_task_with_thread(), and this "fn"
reads sk_pair and does exit() which is actually exit_group().

Oleg.


