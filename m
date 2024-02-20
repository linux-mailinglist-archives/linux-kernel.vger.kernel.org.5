Return-Path: <linux-kernel+bounces-73347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E24485C14C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7F6286C96
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705AB78B49;
	Tue, 20 Feb 2024 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9auCsaf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0464D7867B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446224; cv=none; b=tcl1XyIAtbS9OaT7FgvhiMYwdEBpr0nCVBY/0i78t1QjYxNORVQ5s2GyT15qKp0UFf/jPBqnSGufC9fdEa/Je6Gwp6f4n7fnlLOrwM6reclwilnDDNwKkn3dU7TLh1CYPBWnHhW9KY6PacF9pnZVy4p3D+AmmDRBvXOefjEIv7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446224; c=relaxed/simple;
	bh=Hrdacup/C5QmVjecHU71SSg6+eH8XXbOCw03LZMhQeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgTDrRvmn5kOYtKQhLZ+8NL19xltnZzv5PWOcHoBDKGg0yGzn9eRWCfGHS11rEhpoYNHwd+ABz64xqHUjCwkmPMzuu4cucaKe1mej0sKReX08oagxvj8UOK/UDNQB3YsLZslMYuTpfwsRB0faHmQFW9Lq+ZVFbMQ6sSAlzjhUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9auCsaf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708446221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NiZZHsiRmz0k99S9blsg/bV1RotGSiSDOneujawkCNI=;
	b=P9auCsafn1GZQZTOZgiMGnHexn9v9q6JxNfD2y8mF5dxJDfBMBLg2j8gKNGtvTSko6UiMb
	cmUVsAUti0NK0BEIKfwWLrN7bxPHOEpTB1iHWW83az7b7ISdbl0rDfIT8tFofXfKm0vgRV
	NwLep95a2eq7ft6ws7xFWfD4KnFiNNY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-CUFkZZuyNOC3Pv8y0Eewpw-1; Tue, 20 Feb 2024 11:23:38 -0500
X-MC-Unique: CUFkZZuyNOC3Pv8y0Eewpw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C24E2106D063;
	Tue, 20 Feb 2024 16:23:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.160])
	by smtp.corp.redhat.com (Postfix) with SMTP id 226A0492BCA;
	Tue, 20 Feb 2024 16:23:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 20 Feb 2024 17:22:04 +0100 (CET)
Date: Tue, 20 Feb 2024 17:22:02 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240220162201.GD7783@redhat.com>
References: <20240214123655.GB16265@redhat.com>
 <20240216-albern-aufwiegen-1de327c7dafd@brauner>
 <20240216130625.GA8723@redhat.com>
 <20240216-ohnedies-improvisieren-58edcc102b6a@brauner>
 <20240216181214.GA10393@redhat.com>
 <20240220-einwurf-depesche-d8682be0370c@brauner>
 <20240220090255.GA7783@redhat.com>
 <20240220-pragmatisch-parzelle-8a1d10a94fae@brauner>
 <20240220110012.GB7783@redhat.com>
 <20240220-anlegen-feinmechaniker-3c2cfcc3ec01@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-anlegen-feinmechaniker-3c2cfcc3ec01@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 02/20, Christian Brauner wrote:
>
> On Tue, Feb 20, 2024 at 12:00:12PM +0100, Oleg Nesterov wrote:
> >
> > Perhaps we can kill the "task_pid(current) != pid" check and just return
> > EPERM if "kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL", I don't think
> > anobody needs pidfd_send_send_signal() to signal yourself. See below.
>
> Yeah.

You have my ack in advance

> > > +       /* Currently unused. */
> > > +       if (info)
> > > +               return -EINVAL;
> >
> > Well, to me this looks like the unnecessary restriction... And why?
>
> Because right now we aren't sure that it's used

Yes, but...

> and we aren't sure what use-cases are there.

the same use-cases as for rt_sigqueueinfo() ?

Christian, I won't really argue but I still disagree.

Let me first repeat once again, I do not know what people do with pidfd
and pidfd_send_signal() in particular, so I won't be surprised if this
change won't cause any regression report.

But at the same time, I can easily imagine the following scenario: a
userspace programmer tries to use pidfd_send_signal(info != NULL), gets
-EINVAL, decides it can't/shouldn't work, and switches to sigqueueinfo()
without any report to lkml.

> Yes, absolutely. That was always the plan. See appended patch I put on top.
> I put you as author since you did spot this. Let me know if you don't
> want that.

Ah. Thanks Christian. I am fine either way, whatever is more convenient
for you.

But just in case, I won't mind at all if you simply fold this minor fix
into your PIDFD_SEND_PROCESS_GROUP patch, I certainly don't care about
the "From" tag ;)

A really, really minor/cosmetic nit below, feel free to ignore:

> -		if ((task_pid(current) != pid) &&
> +		if (((task_pid(current) != pid) || type > PIDTYPE_TGID) &&

we can remove the unnecessary parens around "task_pid(current) != pid"
or add the extra parens aroung "type > PIDTYPE_TGID".

I mean, the 1st operand of "&&" is

	(task_pid(current) != pid) || type > PIDTYPE_TGID

and this looks a bit inconsistent to me.

Oleg.


