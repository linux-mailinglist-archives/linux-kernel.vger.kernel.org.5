Return-Path: <linux-kernel+bounces-46947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4748446B6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA7028DC97
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CC512FF6F;
	Wed, 31 Jan 2024 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNHC8j7g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DD512DDAB
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724190; cv=none; b=FYfHweucS5pb6Ah/C+GWL2RU513tYqnIUnHuJkbjHeUtc4DHRPAETJVIEshKTn2UYBB1I2VhQg3+wXyOwV51my9CWw8DMau1jiZB5tWrs6c5ytD5eVIfZgUrmX+3niav7UdWd7eOfsIjkCwHr70RKMHLTHJSgpklA93/iYQzzVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724190; c=relaxed/simple;
	bh=fC3hvECKtCFypEuerDMNoG/UZBOT7Ld0GR4SGXo8Mr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2zoB2oM6pGZj4ildfw/EWrdXwuVnI6HnqoXewFao118z+vME1qDl1R33BB7U/DCSqlvRv5JgQEJlgJwphS4KtyxXHzH43yXdASjVrtfDCsnwtKZczPm9W/4th1onob3CwjJ6J/fXULqE1yHvIXSdSYgOCHOumkERP7+m9PW0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNHC8j7g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706724187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OjWSdnzVIc5DKpSGecXOiiUOX1tI2G9mHRb0zHs00A=;
	b=PNHC8j7gmGxJnrh92/DyaAo8CmowjIGHcwDwaisHe3Qq5CTEuE5PNhWTmnrz5cUAEH/YhQ
	7rsM62MXJiFEI/u2WLmfYXXHUAwIZg/UET2ZOyowW2+OEFHW9OlACoUkcXN4Xbp/Ohux/w
	KgXz3gJ57cp9s07pkkVYXipCFgEpdX0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-jvh8vazaP-i5_VuRTPYOrg-1; Wed,
 31 Jan 2024 13:03:04 -0500
X-MC-Unique: jvh8vazaP-i5_VuRTPYOrg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D98C63806291;
	Wed, 31 Jan 2024 18:03:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.249])
	by smtp.corp.redhat.com (Postfix) with SMTP id BD4BB48C;
	Wed, 31 Jan 2024 18:03:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jan 2024 19:01:49 +0100 (CET)
Date: Wed, 31 Jan 2024 19:01:47 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] pidfd: implement PIDFD_THREAD flag for
 pidfd_open()
Message-ID: <20240131180146.GD2609@redhat.com>
References: <20240131132541.GA23632@redhat.com>
 <20240131132602.GA23641@redhat.com>
 <ZbqCKgTuP/IaEbMM@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbqCKgTuP/IaEbMM@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 01/31, Tycho Andersen wrote:
>
> >  int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
> >  {
> > -	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
> > +	bool thread = flags & PIDFD_THREAD;
> > +
> > +	if (!pid || !pid_has_task(pid, thread ? PIDTYPE_PID : PIDTYPE_TGID));
>
> Small typo here, trailing ;. When I fix that, tests pass for me.

OOPS.

Christian, should I spam lkml with v4, or will you add this fix yourself?

> Assuming that's fixed up:
>
> Reviewed-by: Tycho Andersen <tandersen@netflix.com>
> Tested-by: Tycho Andersen <tandersen@netflix.com>

Thanks Tycho!!!

Oleg.


