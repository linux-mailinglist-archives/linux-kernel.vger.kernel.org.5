Return-Path: <linux-kernel+bounces-58212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C59A384E2CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D7E1C272C4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE0178678;
	Thu,  8 Feb 2024 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mp9jYl3e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD1E768E5
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401256; cv=none; b=V2ywGt3Fjy+Ssmr6sEtxkz/qgIJYb/CbACV7nNgy/KuYy32FIXT9c3KvIZi3UdTcnWmPsj0ZM/YBAYQHxuKz0jo9DtRbqAU368CMIbuALWzdIDZj5P9NlEt4dod486o35x3/SaWyq00lvIKvxZOfK1L8VKcQgqBu6sVx0DmxyKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401256; c=relaxed/simple;
	bh=kdkN1666dxlYpFN1wkFyWk+HZr9DG034hODU02ZZMnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUaNlkKN6cSsNaGNlRJrNVv4+OXAVgLJ+t69tEnB7unrCruw55VwxieOtckqZ39IR9qTNNC1k8PlVm12Ln60xUkPm9hpFa/KUUy98qsnsKaBI7noNYgN+AMRpbUEj5ZiICiVOjBTKcsaf5i1TAcvI7r1sRWityW7hEMfNdE+CsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mp9jYl3e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707401252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kdkN1666dxlYpFN1wkFyWk+HZr9DG034hODU02ZZMnc=;
	b=Mp9jYl3eobex8M2Cgsm9Dl2VTRIqs8aB6YmHe7GjX9wHHveEdnNhnwN2T4pEjTFE/Pgpn5
	LjjPGeE8/IhhbyceJcOv0k1WKByCoGDN/rbi79X0ju8mF8fxDXzJjUcWmFXRldE4KSSFoj
	2wQPEKWghLBuZI94olDY7bKK6vrybaA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-RINaUWZCONCKEsYUTXb-Yg-1; Thu,
 08 Feb 2024 09:07:29 -0500
X-MC-Unique: RINaUWZCONCKEsYUTXb-Yg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 829053C13AAC;
	Thu,  8 Feb 2024 14:07:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.158])
	by smtp.corp.redhat.com (Postfix) with SMTP id 3A7662026D06;
	Thu,  8 Feb 2024 14:07:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  8 Feb 2024 15:06:12 +0100 (CET)
Date: Thu, 8 Feb 2024 15:06:10 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
Message-ID: <20240208140610.GE19801@redhat.com>
References: <20240207114549.GA12697@redhat.com>
 <20240208-fragt-prospekt-7866333b15f0@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-fragt-prospekt-7866333b15f0@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 02/08, Christian Brauner wrote:
>
> I would also suggest we update the obsolete comment on top of
> pidfd_send_signal() along the lines of:

Yes, but...

> + * If the @pidfd refers to a thread-group leader the signal is thread-group
> + * directed. If @pidfd referes to a thread then the signal is thread directed.

No, this depends on PIDFD_THREAD only.

If it is set then the signal is always "thread directed" even if @pidfd refers
to a thread-group leader.

Otherwise the target task must be a group leader and the signal will be
"thread-group directed".

Right?

Oleg.


