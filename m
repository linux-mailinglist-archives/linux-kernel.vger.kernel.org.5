Return-Path: <linux-kernel+bounces-29089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDF6830846
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D2A1F24EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DA5208C4;
	Wed, 17 Jan 2024 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8kZ2JSA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B11E4A2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705502466; cv=none; b=XndKm4QJ7uTD/DqhJ0SaemGk9C2T0tebgusJpjAW6W2xp71+mufpyl5Q4lgutwDQmlILYEwbQt4R6w1gOSvBiH7XImAKOYA6kOrCIExhzkX3Lo9qhdk2Uc05nIdbuko4QMx/Iy7ATJ5Q64mgyZ4tJenEjKzEtU9g/QOjfhdGtt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705502466; c=relaxed/simple;
	bh=p3PhD9pywXC24H/ujtsByu0pLu4W+wIOg1w98qdZHiA=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By; b=WlL3/Tx+8uh0FgtfnIoVUYSRVWPlQEmy3euLvnHajOOxgRFwwDje/kZEiG7wEQjDFOy9qq7xs+4IVogK9XD/NQEN3kayWEGhI3/ki4ILx8a42Q0SbnxUtK5WoeBCXHAzTs3o9og8mcyRnjUhXAtFvnHKv789JuMrSHq1DqrgY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8kZ2JSA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705502464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yymEP3evUdrII1Iu+e3QoHtnTzI4s67+MfkKls7SaCA=;
	b=R8kZ2JSA5Np18NSHubRYiMwkJzxkumU4HvH0gvm8GzSVpzoWt+iuc5I2QtqTJ9IlslMY1c
	UBG6kvsA7HmYBp9vgtWYI062t7b8mjDQIwb2C3L283AP0dutoINA6MY5KgkOGTlnGw/2BI
	GoncBzuf8/4MRr++eIOhC40d+lL7ohk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-PUaur0zUO0Ghqkovh3mLNA-1; Wed,
 17 Jan 2024 09:41:00 -0500
X-MC-Unique: PUaur0zUO0Ghqkovh3mLNA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41AF91C0754A;
	Wed, 17 Jan 2024 14:41:00 +0000 (UTC)
Received: from fedora (unknown [10.22.8.191])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CC7B52166B32;
	Wed, 17 Jan 2024 14:40:59 +0000 (UTC)
Date: Wed, 17 Jan 2024 09:40:58 -0500
From: Audra Mitchell <audra@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
	hirokazu.yamauchi.hk@hitachi.com, ddouwsma@redhat.com,
	loberman@redhat.com, raquini@redhat.com, rasmus.villemoes@prevas.dk
Subject: Re: [PATCH v3] workqueue.c: Increase workqueue name length
Message-ID: <Zafm-hkCI4sbOr78@fedora>
References: <20231215193954.1785069-1-audra@redhat.com>
 <20240115170822.451231-1-audra@redhat.com>
 <ZabLkep0gOFEyjxH@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZabLkep0gOFEyjxH@slm.duckdns.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Tue, Jan 16, 2024 at 08:31:45AM -1000, Tejun Heo wrote:
> On Mon, Jan 15, 2024 at 12:08:22PM -0500, Audra Mitchell wrote:
> > Currently we limit the size of the workqueue name to 24 characters due to
> > commit ecf6881ff349 ("workqueue: make workqueue->name[] fixed len")
> > Increase the size to 32 characters and print a warning in the event
> > the requested name is larger than the limit of 32 characters.
> > 
> > Signed-off-by: Audra Mitchell <audra@redhat.com>
> 
> Applied to wq/for-6.9.
> 
> Thanks.

Hey Tejun (and all others)

Thank you for the response. May I humbly mention that I did find the following
while testing my patch:

[    0.120298] workqueue: name exceeds WQ_NAME_LEN (32 chars). Truncating to: events_freezable_power_efficien

In an effort to be thorough, would you like me to submit a patch shortening
this? Perhaps to "events_freezable_pwr_efficient"?

To be clear, I am not pushing the change, however, I do want to make sure that
the changes being submitted are not causing additional clutter. 

Thanks!


