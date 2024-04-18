Return-Path: <linux-kernel+bounces-150321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810A68A9D45
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE182870C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3D115FA73;
	Thu, 18 Apr 2024 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0fv+MTi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2801DFD8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451169; cv=none; b=ZCV4Y/MLHu7ajr0pumjEt8+4tejRi1D7D2j5uCQqhsb9dJ52p1geMWjcWIzR4e9nyuLjtjCqrqejNqZsq7UB1AbK8RHWGKTnyYjQ/7tBeRaoueU2kuoTUREQtolbK1WFMoEMOEi2g7HFjSTGBESACyQTMNo/AWPBpgSm6voFy2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451169; c=relaxed/simple;
	bh=xzkBULFksHDhU7jOlgpR7yw1uylcLv9ne9ijbOk2w7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEtzWCbMF++AXMUuHb8Ib1mr8MBd/iLfLayXkQpUKnI11WmmaVv6uT/B28EmWasyU7z0IH2OtvPqpVxpCoYoZp0ffpzaXrYnsSk9JL1CFaiDEC9jeVCNad4woCLyJoaUBoMynabzMHYjlwRWb9zJk+K12ujVneAd/cNpSRD6smg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0fv+MTi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713451166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3vSMQ/GMnXjT/XayffdJbIn3Jctp8OFBvmPGYKJ8Q9w=;
	b=h0fv+MTi/VOPGUc2RkXj5xscMSk9Tex9aBwd5ngcCYUfzQMsSdPtsVV2+rWCd6hGUWDXD7
	umLbDsctdnl4I49I8G55KYuG1VUfWQcqlQJhPf/N5h9W/c46GXTpMjgVzZKKsfM06tWXTw
	cSXxQfjtRnWyPhMt9GF3uQaUpOpfS6s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-XPQZDb6zMIWRcvMiCC614Q-1; Thu, 18 Apr 2024 10:39:22 -0400
X-MC-Unique: XPQZDb6zMIWRcvMiCC614Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D71FD18B184E;
	Thu, 18 Apr 2024 14:39:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.182])
	by smtp.corp.redhat.com (Postfix) with SMTP id 57A1C1121312;
	Thu, 18 Apr 2024 14:39:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 18 Apr 2024 16:37:56 +0200 (CEST)
Date: Thu, 18 Apr 2024 16:37:50 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [patch V2 24/50] signal: Replace BUG_ON()s
Message-ID: <20240418143750.GB19794@redhat.com>
References: <20240410164558.316665885@linutronix.de>
 <20240410165552.447880671@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410165552.447880671@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 04/11, Thomas Gleixner wrote:
>
> These really can be handled gracefully without killing the machine.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/signal.c |   11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


