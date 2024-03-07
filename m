Return-Path: <linux-kernel+bounces-95803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F498752EE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782321F23941
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C2612EBE0;
	Thu,  7 Mar 2024 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="yp+TJBKd"
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA40212EBF0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824625; cv=none; b=JMLof6WqdX61bD14pBpOfVyvdVIivzoELuabNtvzC+dqrQ27UMK2go1SHPUCfEnK0kXZHFCTtgRIuaD3101ZfprSJIGZrzLQyyT6LnT/Qmrx5zWs5NQD6wUpZ9TPubRnyFwxeLiQV2Bc3EuW+aT1Hvt5IozWFnkVt2sXq/gWRIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824625; c=relaxed/simple;
	bh=P0y5oZLDg2zyDGADWKpqmnG1esUxoJ6x/fEmofQJw4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYtMrsVPtnbgSrDa0XneQzRcJ7P9efrvVGDSosVwUJUCkbiPoDmXflw/WxLYvyR9OdKH3ldWd4L9yVbFZrZPk9BZbsnZq33q3bInsV7qez/JmZl8GOokNIk4jRpP1jjLabNzgOB9Ze0NFiKQi57gKhev/jKNBuwBR4FqEK7Migk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=yp+TJBKd; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TrCZX6vMFzfD3;
	Thu,  7 Mar 2024 16:16:52 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TrCZX208jzn3H;
	Thu,  7 Mar 2024 16:16:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709824612;
	bh=P0y5oZLDg2zyDGADWKpqmnG1esUxoJ6x/fEmofQJw4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yp+TJBKdQIrmtmrJefS/CPDtym8NIeZuHTbtyUrgyFZFS6hE59P2J1IUQVllB2IdI
	 RjjkoIkn5wQ3ZODeCoomo+BFTRmF0bUx/BWxrkb09nDoCDKjlIWfLbzbBkzYsuP+EQ
	 v7E2j5722W25pG0qytRsa0unbizQK71ljtYL8OOU=
Date: Thu, 7 Mar 2024 16:16:41 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] landlock: Use f_cred in security_file_open() hook
Message-ID: <20240307.eeluu4OoJ4la@digikod.net>
References: <20240307095203.1467189-1-mic@digikod.net>
 <20240307-fehlten-gewinn-18c93d5fb9e6@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240307-fehlten-gewinn-18c93d5fb9e6@brauner>
X-Infomaniak-Routing: alpha

On Thu, Mar 07, 2024 at 11:17:13AM +0100, Christian Brauner wrote:
> On Thu, Mar 07, 2024 at 10:52:03AM +0100, Mickaël Salaün wrote:
> > Use landlock_cred(file->f_cred)->domain instead of
> > landlock_get_current_domain() in security_file_open() hook
> > implementation.
> > 
> > This should not change the current behavior but could avoid potential
> > race conditions in case of current task's credentials change.
> 
> I have no problem with the patch but I'm curious how that credential
> change could happen behind your back?

I hope nothing would change it (except maybe io_uring?), but it is
(more) atomic with the security_file_alloc() call and consistent with
Landlock's current (allowed_access) and future (f_cred) checks on files.

I chatted a bit with Paul and it resulted that is difficult to get
strong guarantees about credential consistency (i.e. following all call
sites).  Anyway, it also looks safer to follow the same approach as most
LSMs.

> 
> > 
> > This will also ensure consistency with upcoming audit support relying on
> > file->f_cred.
> > 
> > Add and use a new get_fs_domain() helper to mask non-filesystem domains.
> > 
> > file->f_cred is set by path_openat()/alloc_empty_file()/init_file() just
> > before calling security_file_alloc().
> > 
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20240307095203.1467189-1-mic@digikod.net
> > ---
> >  security/landlock/fs.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index 6f0bf1434a2c..c15559432d3d 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -248,15 +248,18 @@ get_handled_fs_accesses(const struct landlock_ruleset *const domain)
> >  	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
> >  }
> >  
> > -static const struct landlock_ruleset *get_current_fs_domain(void)
> > +static const struct landlock_ruleset *
> > +get_fs_domain(const struct landlock_ruleset *const domain)
> >  {
> > -	const struct landlock_ruleset *const dom =
> > -		landlock_get_current_domain();
> > -
> > -	if (!dom || !get_raw_handled_fs_accesses(dom))
> > +	if (!domain || !get_raw_handled_fs_accesses(domain))
> >  		return NULL;
> >  
> > -	return dom;
> > +	return domain;
> > +}
> > +
> > +static const struct landlock_ruleset *get_current_fs_domain(void)
> > +{
> > +	return get_fs_domain(landlock_get_current_domain());
> >  }
> >  
> >  /*
> > @@ -1334,7 +1337,8 @@ static int hook_file_open(struct file *const file)
> >  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
> >  	access_mask_t open_access_request, full_access_request, allowed_access;
> >  	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
> > -	const struct landlock_ruleset *const dom = get_current_fs_domain();
> > +	const struct landlock_ruleset *const dom =
> > +		get_fs_domain(landlock_cred(file->f_cred)->domain);
> >  
> >  	if (!dom)
> >  		return 0;
> > -- 
> > 2.44.0
> > 

