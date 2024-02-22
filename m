Return-Path: <linux-kernel+bounces-77227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD320860277
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E73AAB2C2DB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A9A71740;
	Thu, 22 Feb 2024 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVNYFStX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F11C71736
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628982; cv=none; b=AvZyld4cFUThvShKyu3Z+35C8EMLgfwRUG3NhopO1PwPoEyWYsa9iTyCr9vsDvgSUcsa81Elvmhb30YyP3cgd2CxRiMhzhiQn5yB9KPqRv5Z6SSYDxqdvbBkuiKEdMQKtOwia2b3b2Q8eYdg7i3Zd/degUvgCsFMRBoxQwsjI3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628982; c=relaxed/simple;
	bh=nIS2Vbt7rQAe49eVU0bw0f9o5zWBRT8Sgqdd/vBQ8Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoxkoSfA6r3TqC2iEeBlagbTu0dy/wsY/LIoZDsB2cFMUj4sAx4EKkU4ceV/nnobZrf5ffoP21VydqRMn1G5v+5amqAwbHGlK5JDfJhQD2Eh93ZyFKpx2ZmEobivAW+lBJ9lhspCxewU9i7SCFyLbGD/nyJO5B9Ntjwy1BHA54c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVNYFStX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708628979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NOIRP45lMGptwf1yH+rHDdW28P46s2WyXukLgbrFpzQ=;
	b=dVNYFStX0oskcq8f7ABT2sTN7qxt/+tq3zRbTNyRJyhpJ61xBNA6om7AatKz2BkG3GrQP/
	wkGmV/hR3ABSzIN2RzpW1HIJRZysCHJPQvxK8JGk5bO6gGguqNkSiqGgrcAzd2/MqBI2N4
	995NKDwxCKVQy+rSuKuv7kP3zOE7jCQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-GZaW2W6aPJWbUqzbDInRrg-1; Thu,
 22 Feb 2024 14:07:11 -0500
X-MC-Unique: GZaW2W6aPJWbUqzbDInRrg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 682D33816440;
	Thu, 22 Feb 2024 19:07:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.32])
	by smtp.corp.redhat.com (Postfix) with SMTP id D7C4B2166AEE;
	Thu, 22 Feb 2024 19:07:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 22 Feb 2024 20:05:50 +0100 (CET)
Date: Thu, 22 Feb 2024 20:05:47 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: wenyang.linux@foxmail.com
Cc: Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mike Christie <michael.christie@oracle.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kernel/signal.c: explicitly initialize si_code and
 use ksig->info uniformly
Message-ID: <20240222190546.GA5993@redhat.com>
References: <tencent_195B55A5521705954D5EA4873327F8E53D0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_195B55A5521705954D5EA4873327F8E53D0A@qq.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 02/23, wenyang.linux@foxmail.com wrote:
>
> From: Wen Yang <wenyang.linux@foxmail.com>
>
> By explicitly initializing ksig->info.si_code and uniformly using ksig->info,
> get_signal() function could be slightly optimized, as folowes:

I don't understand. Why do you think it will be optimized? in what sense?

> 	clear_siginfo(&ksig->info);
> 	ksig->info.si_signo = signr = SIGKILL;          --> missed si_code

because we do not need to set .si_code in this case?

> 	sigdelset(&current->pending.signal, SIGKILL);
> 	trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,  --> unnecessary SEND_SIG_NOINFO

Why do you think the usage of SEND_SIG_NOINFO is "unnecessary" or bad?
To me this looks good.

> @@ -2732,8 +2732,9 @@ bool get_signal(struct ksignal *ksig)
>  		     signal->group_exec_task) {
>  			clear_siginfo(&ksig->info);
>  			ksig->info.si_signo = signr = SIGKILL;
> +			ksig->info.si_code = SI_USER;
>  			sigdelset(&current->pending.signal, SIGKILL);
> -			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
> +			trace_signal_deliver(SIGKILL, &ksig->info,

Well. to me this look like the minor but unnecessary pessimization.

AFAICS, we do not need to initialize .si_code. The usage if ksig->info
instead of ksig->info means that TP_STORE_SIGINFO() will actually read
the memory.

Sorry, I don't understand the point at all :/

and it seems that we can simply kill clear_siginfo(), but this is
another story.

Oleg.


