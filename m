Return-Path: <linux-kernel+bounces-38793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F07083C610
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FA1286D16
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9C06EB43;
	Thu, 25 Jan 2024 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UB9zrDve"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB4B6DCEC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195234; cv=none; b=p5loKSI66mIq2loLAnhoEyjDaTuTewqiykFHAlfZfmnVvsRJ/zdUClz2Oq3reiLeybn2m1Yhz8FjUqTyIMsQY8ZN2P/4lMGbgT5CFDYPO9eO0bGx7GQU6HroV0KCqvlc8OyPbPuIOicckmKCGLQ59b9OtldMjqIGmUvkSodi0Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195234; c=relaxed/simple;
	bh=WNIz1pM1nip4d96uZ6FyoK3kb+lo8a/ChWuGHglRprg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=pek2TAc4M0wKtBVD0XBNc13qIlcTO+T5FvGMKok241MpY+PtTe1+YCVzBfRAenA+02/1w0t93slIN7AWXQhsW3Qms2SaqnTUgkbbrPidWAPgZ4VFd+7+L56y1EoPQ+tPrFfKR9HNGN4kUeTrPG/s2vPOMmoZtLlg73Bx8GZZrKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UB9zrDve; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706195231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAZlY5FFShoqY2jzLb0BK5KQwuTtjmp0YybmXSZUEAw=;
	b=UB9zrDvew+/KCnWOPwrG4teYpWtRT23tKF6L6k0RqGmf1SK1o7tGQ83vBEqBfbGOQ5ucph
	By9b972FCtHMfpn7aFfTB8y97HHj65LtJAB8PehPM0ZoFVp/iE41ROkKn6kWqS+UbyuIo5
	M0k722GLwFi3pCiGxx+NLHZgkeuKVoM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-c9iSLK8_Pc6WcUKnO_R9ng-1; Thu,
 25 Jan 2024 10:07:07 -0500
X-MC-Unique: c9iSLK8_Pc6WcUKnO_R9ng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9553381AE4A;
	Thu, 25 Jan 2024 15:07:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3DE6F1121306;
	Thu, 25 Jan 2024 15:07:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <B01D6639-6F09-4542-A1CE-5023D059B84F@redhat.com>
References: <B01D6639-6F09-4542-A1CE-5023D059B84F@redhat.com> <520668.1706191347@warthog.procyon.org.uk>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: dhowells@redhat.com, Gao Xiang <xiang@kernel.org>,
    Jeff Layton <jlayton@kernel.org>,
    Christian Brauner <brauner@kernel.org>,
    Matthew Wilcox <willy@infradead.org>,
    Eric Sandeen <esandeen@redhat.com>, v9fs@lists.linux.dev,
    linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
    linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
    linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: Roadmap for netfslib and local caching (cachefiles)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <524117.1706195224.1@warthog.procyon.org.uk>
Date: Thu, 25 Jan 2024 15:07:04 +0000
Message-ID: <524118.1706195224@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Benjamin Coddington <bcodding@redhat.com> wrote:

> > NFS.  NFS at the very least needs to be altered to give up the use of
> > PG_private_2.
> 
> Forgive what may be a naive question, but where is NFS using PG_private_2?

aka PG_fscache.

See nfs_fscache_release_folio() for example where it uses folio_test_fscache()
and folio_wait_fscache().

David


