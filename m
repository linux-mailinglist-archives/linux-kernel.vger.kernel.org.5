Return-Path: <linux-kernel+bounces-59549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 720E984F8C9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47F72887DA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3754C74E3E;
	Fri,  9 Feb 2024 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LccG94XZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C2474E28
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707493472; cv=none; b=YLbMFjogvoA3Awjk5Qnm0F+MfFJac/XiwxYbncW1b98sPH1BWT9hn67AlhstN5TrXfZOnI7RGIncNqJZC6YlKoqyIQ3L8AV646AdF42nZ+m+XMkMghUbcwGI7LutvUC7uFAft0P8Yx2i5CV+8rBnGXZd7WflUrbCID4LOKxhMEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707493472; c=relaxed/simple;
	bh=8laP6uomvxanGYT7yrAFbIjiqPGzbWck4Bytm/WmMvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9QlBx/Qkm+7AK/hNhP/D7InbenTdNWM1uzU3SA6tc7NBlDWnw1VCY2zYxV/avGDPW41Gvf3uGQbNS/D++PamElYDXTPN8gjjiPj5SF2tmYzq/reTGkxG66cX/aNj4nI6k8B/52FHfbXajrgYFA/r7sP3EbJKH1QCIKMj5B17t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LccG94XZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707493470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8laP6uomvxanGYT7yrAFbIjiqPGzbWck4Bytm/WmMvk=;
	b=LccG94XZHRxVh66M3VNm/U1L7m+x1iYadhSCZTVod8itImpdh3mg/qF49fVoi/E/GZSAKN
	dAW0vG5WLLhPEQSrNCo+Pexf0bWUe3mbp4jReJ6hjlfY9VWbuPqkckAB3yXv99DJMRANTk
	lsXh0oZ+B2kPIKYZaS9RA68KnuVS3s4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-tcF3PfSbMDufhk5k1eOCwA-1; Fri,
 09 Feb 2024 10:44:25 -0500
X-MC-Unique: tcF3PfSbMDufhk5k1eOCwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEEB338130B4;
	Fri,  9 Feb 2024 15:44:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.84])
	by smtp.corp.redhat.com (Postfix) with SMTP id 0EC362166B31;
	Fri,  9 Feb 2024 15:44:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  9 Feb 2024 16:43:08 +0100 (CET)
Date: Fri, 9 Feb 2024 16:43:05 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240209154305.GC3282@redhat.com>
References: <20240209130620.GA8039@redhat.com>
 <20240209130650.GA8048@redhat.com>
 <20240209-stangen-feuerzeug-17c8662854c9@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209-stangen-feuerzeug-17c8662854c9@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 02/09, Christian Brauner wrote:
>
> How do you feel about the following (untested...) addition?

LGTM, but let me read this patch once again tomorrow, I have
a headache today.

> I've played with PIDFD_SIGNAL_PROCESS_GROUP as well but that code is
> fairly new to me so I would need some more time.

Heh, I was going to send another email to discuss this ;)

Should be simple, but may be need some simple preparations.

Especially if we also want PIDFD_SIGNAL_SESSION_GROUP.

So the question: do you think we also want PIDFD_SIGNAL_SESSION_GROUP?

Oleg.


