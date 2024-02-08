Return-Path: <linux-kernel+bounces-58239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F43084E34C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE37228FFF4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03361B7E4;
	Thu,  8 Feb 2024 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6szAznS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266506EB4B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707402932; cv=none; b=ka8jrvYiHsAJHFCdZwxg0KX3hPRIXtdpVZ6co2z2ormVagpICkaFjgSalMDo8BXP/ohrzg5QOE0U4DY3y3RqyvUlI7qqD0EhqX6yob7D3Nm5i52wsEquUu5KeJP86P1IYsYRpjt3DAZZgWHEj2qlObl2Ifyf0kSGYYXKB/Iuna4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707402932; c=relaxed/simple;
	bh=9YqzliOGzkkMDhfypshk6U0P1+CqguZTr81ooRTLRZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuYqhar1vsL7zvoQkeFPpEXLHsxIs1+3zuZxYIcoYrqO8WaO0xFfY/RETr3SH1BYLwOyrv/45qjHS0iUED/JBZgr6TZ1IcBs+42EGD23D0/cApYZPKTJBv+3eNFhZSobSRBMfvVOSIdXtaF0GadALnfQjM/5L/W1l+BajUtxfe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L6szAznS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707402928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rIFybJDnOhyzqhit+HnnDJoYVstx80eqvFnajir605c=;
	b=L6szAznS7mh/uZM80v2NhZN3JjI+hq37P+TGlGrtjDQrZI6/p5TrLnEbclXNw3aKdM4wfp
	LaHHQL4pgdp4DZ/fNVQs0zmo4C9/FR7GI8YXs8UzSzKF7VwtvjdwEFiQqyQpvpbKR631tI
	OEOa9CwPIIbZ3ifHFfXfSWul3UCxepc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-mHzfyN9iPPuu-h2TqO4tDA-1; Thu, 08 Feb 2024 09:35:26 -0500
X-MC-Unique: mHzfyN9iPPuu-h2TqO4tDA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8DFF84AE41;
	Thu,  8 Feb 2024 14:35:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.158])
	by smtp.corp.redhat.com (Postfix) with SMTP id 0B0BE492BC6;
	Thu,  8 Feb 2024 14:35:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  8 Feb 2024 15:34:10 +0100 (CET)
Date: Thu, 8 Feb 2024 15:34:07 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
Message-ID: <20240208143407.GF19801@redhat.com>
References: <20240207114549.GA12697@redhat.com>
 <20240208-fragt-prospekt-7866333b15f0@brauner>
 <20240208135344.GD19801@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208135344.GD19801@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 02/08, Oleg Nesterov wrote:
>
> On 02/08, Christian Brauner wrote:
> >
> > On Wed, Feb 07, 2024 at 12:45:49PM +0100, Oleg Nesterov wrote:
> > > +	type = (f.file->f_flags & PIDFD_THREAD) ? PIDTYPE_PID : PIDTYPE_TGID;
> > > +	ret = kill_pid_info_type(sig, &kinfo, pid, type);
> >
> > If the user doesn't provide siginfo then the kernel fills in the info in
> > prepare_kill_siginfo() a few lines above. That sets info->si_code to
> > SI_USER even for the PIDFD_THREAD case. Whenever the info is filled in
> > by the kernel it's not exactly userspace impersonating anything plus we
> > know that what we're sending to is a pidfd by the type of the pidfd. So
> > it feels like we should fill in SI_TKILL here as well?
>
> Hmm. Agreed, will do, thanks.

Cough... lets forget this patch for the moment.

Is prepare_kill_siginfo() correct when we send a signal to the child
pid namespace? si_pid = task_tgid_vnr(current) doesn't look right in
this case but perhaps I am totally confused.

And why do we need it at all? Can't sys_kill() and pidfd_send_signal()
just use SEND_SIG_NOINFO?

OK, I am sure I missed something. Will read this code tomorrow.

Oleg.


