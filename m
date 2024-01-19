Return-Path: <linux-kernel+bounces-31543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BECD1832FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45855280DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4581954BE3;
	Fri, 19 Jan 2024 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxjRvouq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726858BF6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705696263; cv=none; b=tlqUqyVE13dwVVRvXT6mQ64tBm7CQW3mTffzhxyiQyy+qQORaARmV9YB7MK9EwEYyMA0H5QEtdxAwxI0mkfNiDJByQbpXrmWQ38PT3MxFjhsSBONjxizQTsDhVcTBe9dQzXNROePEX22539V9OiZivEmazQIxKpFxTUX+tSBzGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705696263; c=relaxed/simple;
	bh=OKJ8VXzhuKQpiVaB1tux2YO5F2PodmPsL/JSVh8TRDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAQVYdGqYXJUwC/ospFkLXermlce4t581+soySCARavhFPndGqHuUF6KuQMqk+oA4jwVGLJ87e6wt+dmb80D7V5KYBorEVXUq9G7hJOnnfzmgQam1P3DszCZoPH+gzkj6zni3FI7Wr33Ou+TjnHx2q9P0lhsRszT8u1iDinCW/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxjRvouq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705696260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Le/B9zszCG4OnIUWJ5vGWVH4S9ibCDvWqCeyzDoHXaY=;
	b=dxjRvouqBcs8vHHzRnb3z+LuHAJq9UBJryVtRZoSM8KfAO4tW8Hri7gghOg3uVYy/nHnHD
	0TbRiZpxumPk7uYKEMvUx01cqezB8fYns7D1uKUBfH9dUePFGN/INV6mZ8VujCBLeocPsr
	CgAMZGEk4aRWuMX+6UxLDuwOE1PEjUQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-vwGlXyDEORejeGqeaUGfNA-1; Fri, 19 Jan 2024 15:30:56 -0500
X-MC-Unique: vwGlXyDEORejeGqeaUGfNA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CCEA83B82D;
	Fri, 19 Jan 2024 20:30:56 +0000 (UTC)
Received: from fedora (unknown [10.22.32.201])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E9A9A492BC6;
	Fri, 19 Jan 2024 20:30:55 +0000 (UTC)
Date: Fri, 19 Jan 2024 15:30:54 -0500
From: Audra Mitchell <audra@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
	hirokazu.yamauchi.hk@hitachi.com, ddouwsma@redhat.com,
	loberman@redhat.com, raquini@redhat.com, rasmus.villemoes@prevas.dk
Subject: Re: [PATCH v3] workqueue.c: Increase workqueue name length
Message-ID: <Zarb_u7mZCBGrgSX@fedora>
References: <20231215193954.1785069-1-audra@redhat.com>
 <20240115170822.451231-1-audra@redhat.com>
 <ZabLkep0gOFEyjxH@slm.duckdns.org>
 <Zafm-hkCI4sbOr78@fedora>
 <ZagJrod33CPFaXGg@mtj.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZagJrod33CPFaXGg@mtj.duckdns.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Wed, Jan 17, 2024 at 07:09:02AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jan 17, 2024 at 09:40:58AM -0500, Audra Mitchell wrote:
> > Thank you for the response. May I humbly mention that I did find the following
> > while testing my patch:
> > 
> > [    0.120298] workqueue: name exceeds WQ_NAME_LEN (32 chars). Truncating to: events_freezable_power_efficien
> > 
> > In an effort to be thorough, would you like me to submit a patch shortening
> > this? Perhaps to "events_freezable_pwr_efficient"?
> > 
> > To be clear, I am not pushing the change, however, I do want to make sure that
> > the changes being submitted are not causing additional clutter. 
> 
> Oh yeah, please go ahead.
> 
> Thanks.

Hey Tejun,

Do you want this as a stand alone patch or do you want me to re-submit both
patches as a series?

Thanks


