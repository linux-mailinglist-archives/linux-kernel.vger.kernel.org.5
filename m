Return-Path: <linux-kernel+bounces-59619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F35484F9C5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61801F24744
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3147B7B3F3;
	Fri,  9 Feb 2024 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POmLrgOx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129347691B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496840; cv=none; b=fjFQ/jiBPwiglZidrzcVmt/Sc+vAUjD9/DFmfIPModO59td5sxwnmAvIupUKbRlx7+nr/6DeEamqR4Nnq1zBTHBQF8TmEBMDGtygzZ3j2JLNvGaQw6ODWU9VO/n3dadg1qUywmJtxbBqth34UmEfwn2rdVctokDIImO2o29tIjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496840; c=relaxed/simple;
	bh=QWA/960C0OvEZHcS8yLgjPfOLmmCZE7fkhbKn7qioA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/jHP23L/XnHraAxqKl4D8rDZuRUGap8LOPD3AQFifxKVCPa1K4co6MbiGEwMYXExP4v9LzBuFc+wzXECqJG/F68gvP/0BK3nBSr7mJAjEKOmLS/ND+YbLY8VlgWds4gP9shmW9bDtQNpaWgQdS4M4hS/fRsx4cBRZtN2+mpr5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=POmLrgOx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707496838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ZYBw4xEyhcf/nGZTwXmlIzT8+wX9rv4YZJK1yqjVjI=;
	b=POmLrgOxvBP2uycgzyzrXWtnTmLMegF7eZ+0saEXd8AADebk6OFxHMpBMwnIZeDphvrYT3
	pSwaKrNkJhg1D0NYWG1er3AZU+KiSBYRK0VyTWItWsvAwLuGD++LzoR3g9oEycm5FRfp1o
	G5hzm7zvqQBKIRl0CO0fbCwcqkVJfdc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-8PQEj3GYMC-K35ffYqZ28g-1; Fri, 09 Feb 2024 11:40:33 -0500
X-MC-Unique: 8PQEj3GYMC-K35ffYqZ28g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2ADEC83B8ED;
	Fri,  9 Feb 2024 16:40:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.84])
	by smtp.corp.redhat.com (Postfix) with SMTP id 7E6E91103A;
	Fri,  9 Feb 2024 16:40:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  9 Feb 2024 17:39:16 +0100 (CET)
Date: Fri, 9 Feb 2024 17:39:14 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] signal: add the "int si_code" arg to
 prepare_kill_siginfo()
Message-ID: <20240209163914.GE3282@redhat.com>
References: <20240209130620.GA8039@redhat.com>
 <87sf21zjy8.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf21zjy8.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 02/09, Eric W. Biederman wrote:
>
> Could you can pass in the destination type instead of the si_code?
> Something like I have shown below?

..

> 	info->si_code = (type == PIDTYPE_PID) ? SI_TKILL : SI_USER;

Yes, I considered this option too.

OK, will send V3 tomorrow.

Oleg.


