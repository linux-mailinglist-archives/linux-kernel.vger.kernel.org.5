Return-Path: <linux-kernel+bounces-81114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F96867063
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F371E1C23ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47CC1CFBB;
	Mon, 26 Feb 2024 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGF1/Eov"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981C71CF8B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941247; cv=none; b=TgPfd+CtUIueUh7PGqIN3X7+xC6+8NjGotIGz9cQy7pg2e01y/aLARt0p56VgeO5LNkpEKED5JqyR34y0UT5geiDcJ860luveHloDSQ5TzxgpDcj0YQHqmBBrjuiB99UAq5OMqu0kN1+/1t1JdJNun9EOQg8SqcmifH59RujvPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941247; c=relaxed/simple;
	bh=jXyCSwfEfgtitmvvOzWK+WbjZxeHuFZ72QpiXFWQcM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VL6ndxYhF3DJ3qZ5dnpF3SIEYHXsh3mp4Ea3xFIlc+ObkQKBG8yIAx02rmGCH/oYN9+TVLOr71Ay47bk6Wmc83/S3FH15yv00Hc1iW7njLvCjwVHr+N0J7vqZP1PnUiULw8kwRjsfhAIP0K2mTHifKxlRh7KuqUVc2De7SeHmGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGF1/Eov; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708941244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8HwGjvRq3lJ4FY+hSowWJUSjq8Gl0d7h9FtCWkTtsM=;
	b=AGF1/EovOMRq3I7R4+tPFRFlBflyQ5//h7y+8/rjIYqNADKY3mzSgz6qq9iAjJ3VSURO8A
	xEr5Celz88H8Km1j05GQctwSkcFuQG8NT3eLUhtaaZ9UawXDskA6y7YVJSlqmVHJYat/hG
	I47PhkOWHlfnUyjT5/fXqG063Jonogg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-4rXsdhxlMIOFit0Igdk_1g-1; Mon,
 26 Feb 2024 04:54:02 -0500
X-MC-Unique: 4rXsdhxlMIOFit0Igdk_1g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83F421C54468;
	Mon, 26 Feb 2024 09:54:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.85])
	by smtp.corp.redhat.com (Postfix) with SMTP id 232551C060B1;
	Mon, 26 Feb 2024 09:54:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 26 Feb 2024 10:52:43 +0100 (CET)
Date: Mon, 26 Feb 2024 10:52:41 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Wen Yang <wenyang.linux@foxmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_signal: simplify/cleanup the the usage of ksig->info
Message-ID: <20240226095240.GA9510@redhat.com>
References: <20240223105025.GA4542@redhat.com>
 <tencent_7C50F304C14CB2A5133317F8A13D1F544D0A@qq.com>
 <20240223141928.GB8267@redhat.com>
 <20240223143131.GC8267@redhat.com>
 <20240223144458.GD8267@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223144458.GD8267@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

OK, lets forget about "no need to initialize ksig->info" part for now.

Yes, PF_USER_WORKER's never dereference ksig, but I agree this doesn't
look clean without other cleanups. I'll probably return to this later
when other pending problems with PF_USER_WORKER are fixed.

Wen, thanks again for your review.

Oleg.

On 02/23, Oleg Nesterov wrote:
>
> On 02/23, Oleg Nesterov wrote:
> >
> > On 02/23, Oleg Nesterov wrote:
> > >
> > > On 02/23, Wen Yang wrote:
> > > >
> > > >
> > > > On 2024/2/23 18:50, Oleg Nesterov wrote:
> > > > >+			/*
> > > > >+			 * implies do_group_exit(), no need to initialize
> > > > >+			 * ksig->info
> > > > >+			 */
> > > > >  			goto fatal;
> > > >
> > > > There is little question:
> > > > If the this conditions is met:
> > > >    current->flags & PF_USER_WORKER
> > > > It may execute “goto out“ instead of do_group_exit().
> > >
> > > Yes, but vhost/io workers do not use ksig at all.
> >
> > Ah, wait...
> >
> > I forgot about the ->sa_flags check before hide_si_addr_tag_bits().
> >
> > OK, thanks... I'll send V2.
>
> Tomorrow.
>
> I'll recheck, but I think we need the patch below as 1/2 regadless of
> this change
>
> Oleg.
> ---
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2897,13 +2897,13 @@ bool get_signal(struct ksignal *ksig)
>  		/* NOTREACHED */
>  	}
>  	spin_unlock_irq(&sighand->siglock);
> -out:
> +
>  	ksig->sig = signr;
>
>  	if (!(ksig->ka.sa.sa_flags & SA_EXPOSE_TAGBITS))
>  		hide_si_addr_tag_bits(ksig);
> -
> -	return ksig->sig > 0;
> +out:
> +	return signr > 0;
>  }
>
>  /**


