Return-Path: <linux-kernel+bounces-72646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F6085B6A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2431F2124D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CFF5FDA4;
	Tue, 20 Feb 2024 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fK0gdxTh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4384A5E3A0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419865; cv=none; b=T3zB9YIbxsMlstqEqlnIrZpKfKtwf0YsjkbD5XDNQt+tQeVfHbDi3jOVpFVg2Hs+Wku05W9J3BTNn1CWBlOcNiZ7W3+Mx6NEBgh4xHlKT3DvQTNncRuLKgYOuRRthrPcdiyVKM68jrZMN9b5mm+ybRu1RwXnm25lRn+R8TMTsX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419865; c=relaxed/simple;
	bh=inr5XQBJ4gP+HBs5eVHAxHMefhyOxnWbYqKIi1snm08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeNfa1/c1NrYzMxGPlTDKZgsIWtrrCefuMg0sHzRUvxanlyAeIaHd09tm8/kUbpkIYA1t+yU7SgmTExnixIeccJgk8jW5VCvqi0S6WL7iLE5PgIUdVsw1+7NnwRUi458G5jSbDij8iK/SG7EEFwelluBQQoIOZGlaWISisgQaHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fK0gdxTh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708419863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=inr5XQBJ4gP+HBs5eVHAxHMefhyOxnWbYqKIi1snm08=;
	b=fK0gdxThtmG73HtkqV9+9bcF1Kl2INAwAbtPadObpH7AZfeXL0QBRNqj/WZnmfhb44ZI91
	yWadPqqYFjN0FwL8uWCg6idsceJfBrC7xu5N7+rKIPmZb8uDPc+s4LYdL+65At/TuUAqrA
	K5PLaBBbC8/ZTjNGjs+yV4gHaUgU7y4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-F3ZS-YIEN_6VNDKVyB9QWQ-1; Tue, 20 Feb 2024 04:04:17 -0500
X-MC-Unique: F3ZS-YIEN_6VNDKVyB9QWQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 246D085A58E;
	Tue, 20 Feb 2024 09:04:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.160])
	by smtp.corp.redhat.com (Postfix) with SMTP id 7BD33492BCC;
	Tue, 20 Feb 2024 09:04:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 20 Feb 2024 10:02:58 +0100 (CET)
Date: Tue, 20 Feb 2024 10:02:56 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240220090255.GA7783@redhat.com>
References: <20240210-dackel-getan-619c70fefa62@brauner>
 <20240210131518.GC27557@redhat.com>
 <20240210-chihuahua-hinzog-3945b6abd44a@brauner>
 <20240210165133.GD27557@redhat.com>
 <20240214123655.GB16265@redhat.com>
 <20240216-albern-aufwiegen-1de327c7dafd@brauner>
 <20240216130625.GA8723@redhat.com>
 <20240216-ohnedies-improvisieren-58edcc102b6a@brauner>
 <20240216181214.GA10393@redhat.com>
 <20240220-einwurf-depesche-d8682be0370c@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-einwurf-depesche-d8682be0370c@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 02/20, Christian Brauner wrote:
>
> On Fri, Feb 16, 2024 at 07:12:14PM +0100, Oleg Nesterov wrote:
> > On 02/16, Christian Brauner wrote:
> > >
> > > > SI_USER means that the target can trust the values of si_pid/si_uid
> > > > in siginfo.
> > >
> > > Bah, what an annoying nonsense. I see that this can be used to emulate
> > > stuff like SI_TIMER and SI_ASYNCIO. But I very much doubt the value of
> > > e.g., emulating SI_DETHREAD. Maybe I'm missing something very obvious.
> >
> > I don't understand...
>
> My question was what the purpose of being able to to set si_code to
> e.g., SI_DETHREAD is and then to send a signal to yourself? Because it
> looks like that's what rt_{tg}sigqueueinfo() and pidfd_send_signal()
> allows the caller to do. I'm just trying to understand use-cases for
> this.

Ah. IIRC criu uses this hack to restore the pending (arbitrary) signals
collected at dump time.

I was a bit surprise sys_pidfd_send_signal() allows this hack too, I don't
think that criu uses pidfd at restore time, but I do not know.

Oleg.


