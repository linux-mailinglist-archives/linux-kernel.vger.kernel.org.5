Return-Path: <linux-kernel+bounces-74740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA8585D87B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB2128778B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8181169962;
	Wed, 21 Feb 2024 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBN9BLQe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAED4F885
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520213; cv=none; b=lqOmPEp2YYijCdEgdfVtN/8amaWVqOnwCn3wlxib9DBBg1/g94BAidX/h54ydDx9mHTtyZ8ZUgUOWwFFk/+vpsDjX9/07AnJR+TEoXAJapycXTkBJqsgRjJeklC/MSK2aInD62Lu9z3BT9DS4n0AAmn4oNwmB9GquvK/kr+cWpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520213; c=relaxed/simple;
	bh=pg1mcNVSjCSg//U1qEGOAKr/92rgrkQahsiIB89xZPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1JLskG6HwkDqH0n8FVQWLPpcaIVkqDYBf9TJKhLGv8Yf5wFk+QTdLqRCIhKjFmjy9nc4vG8wFCRAdGLX+YM4p3cdKfBnhhaPN3kHloFoT1nDZa9mAyYjAlQJpJSjY5EMnBldLJXlpbTv+vu99JAcRiWRkdxpt2Qy6t9tJi25LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBN9BLQe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708520211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qeM6ln5GPe+54z6KZr8QF1BPN1lbild34z3N9RGW30M=;
	b=ZBN9BLQecB9PZpriCFPxaGUCSMz2NjdcFxAYFp+e9gxHxvN614QDc11BfBGmgylpP/aIUS
	YrJl5/b+Aqio0ragnEh1i8ZV9JPOCELjc1vZK145tVuo+ua7JbP+dwXNfbYDlh0obqOaIu
	TkAhdGCL5x8FYpaafrt8N6jcsF5XUKg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-bWiMgYo1NRyg3lvkXBfQGQ-1; Wed, 21 Feb 2024 07:56:46 -0500
X-MC-Unique: bWiMgYo1NRyg3lvkXBfQGQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AB5B8630C0;
	Wed, 21 Feb 2024 12:56:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.78])
	by smtp.corp.redhat.com (Postfix) with SMTP id D677C8CE8;
	Wed, 21 Feb 2024 12:56:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 21 Feb 2024 13:55:28 +0100 (CET)
Date: Wed, 21 Feb 2024 13:55:26 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240221125525.GA16773@redhat.com>
References: <20240216130625.GA8723@redhat.com>
 <20240216-ohnedies-improvisieren-58edcc102b6a@brauner>
 <20240216181214.GA10393@redhat.com>
 <20240220-einwurf-depesche-d8682be0370c@brauner>
 <20240220090255.GA7783@redhat.com>
 <20240220-pragmatisch-parzelle-8a1d10a94fae@brauner>
 <20240220110012.GB7783@redhat.com>
 <20240220-anlegen-feinmechaniker-3c2cfcc3ec01@brauner>
 <20240220162201.GD7783@redhat.com>
 <20240221-zapfhahn-pulsschlag-e8f9d919c350@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221-zapfhahn-pulsschlag-e8f9d919c350@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 02/21, Christian Brauner wrote:
>
> On Tue, Feb 20, 2024 at 05:22:02PM +0100, Oleg Nesterov wrote:
> >
> > > > > +       /* Currently unused. */
> > > > > +       if (info)
> > > > > +               return -EINVAL;
> > > >
> > > > Well, to me this looks like the unnecessary restriction... And why?
> > >
> > > Because right now we aren't sure that it's used
> >
> > Yes, but...
> >
> > > and we aren't sure what use-cases are there.
> >
> > the same use-cases as for rt_sigqueueinfo() ?
>
> Specifically for pidfd_send_signal() I mean. To me it seems very
> unlikely that anyone would be opening a pidfd to itself

Ah, with this, I do agree. And that is why (I think) we can remove
the "task_pid(current) != pid" check in the "info != NULL" branch.

Oleg.


