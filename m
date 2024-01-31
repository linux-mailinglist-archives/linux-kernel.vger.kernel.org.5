Return-Path: <linux-kernel+bounces-46984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 061B3844777
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391EF1C22014
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA69282E5;
	Wed, 31 Jan 2024 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ga4fhofE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621C11805F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706726992; cv=none; b=AVe0c3GAffPLxq3fYC04OlBv9bPBx1RRXReVR6kOUZ3OyBv3/++/6iv6/upOdI73GHL1vN0uvMx62L5g1cgGUKwKhdVECsz3J5Mwq7bw3EjN7g0lFKCr+ALOpczpCLi6aDp5c74ssEK3BZc/5T3f9Mc5G+hJyFNbN4EeQr2w34w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706726992; c=relaxed/simple;
	bh=X4u+dQV5QUMk/zja0MJJBmXhJnm57hYRFF/uFj0w7ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxKFgR9Vss9sDwCW3013WycxFl7JQeo5yAHLQ0/k1D5hyWb/0TnUH6jcq0n0Xnqm1BEaOWqnE98KsguaLCN2F6o8SfC3wvjEnCZMTu3LFciTGI71pm6ujJLGT8SItwsvcWqTKv/e1Gz2WB+XEmEbw65H3iBJXQtvL07fVr1bO8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ga4fhofE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706726990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l9U8CKXhwM8+HNsv/ZLK5nhFsmc+OFbd5U+w8VnN6xI=;
	b=Ga4fhofEnPVXjp9X97TJddzGmYliEgFNASmI+Elp9wV5HoJsWxX1tupWrLnMNopu7kKe7U
	ucRRco3e50GfHABTMsdBWo7kUegFvhvLuZTSZcOOrtmsxFPeqKfzHZaVMRoq5RsMWVTOKt
	8XmCKeJPIfxMRV98UlpJ4Yyp+fwys1w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-KU-iabKxMFWAVmHrBJ0N5w-1; Wed, 31 Jan 2024 13:49:47 -0500
X-MC-Unique: KU-iabKxMFWAVmHrBJ0N5w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76D6B1064C64;
	Wed, 31 Jan 2024 18:49:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.249])
	by smtp.corp.redhat.com (Postfix) with SMTP id CAC2FC1ED63;
	Wed, 31 Jan 2024 18:49:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jan 2024 19:48:31 +0100 (CET)
Date: Wed, 31 Jan 2024 19:48:29 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Tycho Andersen <tycho@tycho.pizza>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC PATCH] pidfd: implement PIDFD_THREAD flag for pidfd_open()
Message-ID: <20240131184829.GE2609@redhat.com>
References: <ZbQpPknTTCyiyxrP@tycho.pizza>
 <20240127105410.GA13787@redhat.com>
 <ZbUngjQMg+YUBAME@tycho.pizza>
 <20240127163117.GB13787@redhat.com>
 <ZbU7d0dpTY08JgIl@tycho.pizza>
 <20240127193127.GC13787@redhat.com>
 <ZbVrRgIvudX242ZU@tycho.pizza>
 <20240127210634.GE13787@redhat.com>
 <20240129112313.GA11635@redhat.com>
 <CALCETrUFDkt+K9zG8mczxzAFy9t-6Mx5Cz-Sx+it6a4nt+O0pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUFDkt+K9zG8mczxzAFy9t-6Mx5Cz-Sx+it6a4nt+O0pg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 01/31, Andy Lutomirski wrote:
>
> Right now, pidfd_send_signal() sends signals to processes, like so:
>
>  * The syscall currently only signals via PIDTYPE_PID which covers
>  * kill(<positive-pid>, <signal>. It does not signal threads or process
>  * groups.
>
> This patch adds PIDFD_THREAD which, potentially confusingly, doesn't
> change this (AFAICS).

Yes,

> So at least that should be documented loudly
> and clearly, IMO.

Please note

	/* TODO: respect PIDFD_THREAD */

this patch adds into pidfd_send_signal().

See also this part of discussion

	> > +	/* TODO: respect PIDFD_THREAD */
	>
	> So I've been thinking about this at the end of last week. Do we need to
	> give userspace a way to send a thread-group wide signal even when a
	> PIDFD_THREAD pidfd is passed? Or should we just not worry about this
	> right now and wait until someone needs this?

	I don't know. I am fine either way, but I think this needs a separate
	patch and another discussion in any case. Anyway should be trivial,
	pidfd_send_signal() has the "flags" argument.

with Christian in https://lore.kernel.org/all/20240130112126.GA26108@redhat.com/

Or did I misunderstand you?

Oleg.


