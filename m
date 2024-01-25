Return-Path: <linux-kernel+bounces-38709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDDE83C46D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F3B1F24C33
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B035563500;
	Thu, 25 Jan 2024 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHAV0TPB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD184634F3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191929; cv=none; b=mm2N1E5V39xoThN/Pf/O7VyIaEFhD/206bQ9pULyuwoZzFLZoNdWYG7ZulRffbpmRnM562DRB92ul99HdH+KOk4RqgA0rdrVnt6Gp+bmPh45PNVhX779rG9WZipi13ySGR8HoHZQT0fAXhEsBZpnLIM5UbeEGG66/lNUux5Fx14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191929; c=relaxed/simple;
	bh=E87yYMUmIZQHj4uCon05JeVlBr+VAITmiBQh7svNdRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BRmnBiowJUxOa4KDEgrhnFIaH9dW1nDJ/C2pFm5losjLObFoj2RpHsLwxfiHr2+HeqIEvKaElQSsSxd/f6ty4IWtCPmJHRRujjK2KWlDj1leposElgCggEZpk9wQGATbzzBuBM1C35w2ZlIptq/zJaRl2hFE2/pLzAojABoxf4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHAV0TPB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706191926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ACqcEjg537hZBJWAT4QAy+L6J3AJYKEx3L1s6N7xY70=;
	b=DHAV0TPB30rDH/Gc6GGbeA4kVuPrXy7g+f7PUts+OyoWvDl1MMDS7chB05hEEED6stme//
	rEDPd4DKAD3mgdvhM43eY4fPqYo1TXUfub+vn1VpwfhjkxwQi0TqOWEWU75CdTFKcvV87v
	WUV2J7gPmW+OAyDNWVFoTXd9u1qRsEY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-Ton7HokXPSWRswBc5p_IDw-1; Thu,
 25 Jan 2024 09:11:59 -0500
X-MC-Unique: Ton7HokXPSWRswBc5p_IDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A4A21C0BA46;
	Thu, 25 Jan 2024 14:11:58 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 060CB51D5;
	Thu, 25 Jan 2024 14:11:55 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Gao Xiang <xiang@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Eric Sandeen <esandeen@redhat.com>, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: Roadmap for netfslib and local caching (cachefiles)
Date: Thu, 25 Jan 2024 09:11:54 -0500
Message-ID: <B01D6639-6F09-4542-A1CE-5023D059B84F@redhat.com>
In-Reply-To: <520668.1706191347@warthog.procyon.org.uk>
References: <520668.1706191347@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 25 Jan 2024, at 9:02, David Howells wrote:
..
> NFS.  NFS at the very least needs to be altered to give up the use of
> PG_private_2.

Forgive what may be a naive question, but where is NFS using PG_private_2?

Ben


