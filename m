Return-Path: <linux-kernel+bounces-95131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B425874990
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576D328265B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3AE6341F;
	Thu,  7 Mar 2024 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqtUIJRv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8993F63406
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800013; cv=none; b=q/fPqsG4Uv2ju+hvL6mfpSFpgwZryXykdVQJY0cttENo61yQ4Cti35K680rO/dSZ926xHJRsYZaL7q0C9i6Dg/U0XoSp1OOlIK/pM1a92oJ1UZ5Kj08XNhsYA9yeGfYQ72k7gr2i06yyM+nA3B9scabN46k5ZleNQVyA8GD/8kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800013; c=relaxed/simple;
	bh=GSLLGWd6A4v0+iH8U2RooYpIV7bjKBaVVn5koXyUZhs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=GvoDFwEVGnm1XIk3NvOyNELzFak6KLoF2tSzgwiu97WwhV8ypsVB4v5j1UxpxSOvcQ74p96iv6ufpC4fF8DKK1Ul5TMo2i8NmfBUWOI0rTdOuXN0DlNFd6KVmd9SmfuadvKLboDX1igVBLTF+b1t73ApmLhVe8+JW/8awpwtUzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QqtUIJRv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709800010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNYFlX4GZ3sigkzX5bE6FkuPu9beg0e7HrY2SFlhQWw=;
	b=QqtUIJRvj3cQ75rPH375N5q9byV0RHZjGKWzF9GHjxoRmgH1X9uQu1QHavVUZ/UlH4AsgD
	+zNWJmxvSA7FA1ESW5GooLymhhgTpXPT5Ydp7FyZs4nuvNB0oTLZUl9Qrz1b7Wb6r8qnSN
	haBskzFOOyM+0vXTaoINGW6C2AnqcOs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-YCH9Z4zEMva3JJyiGTu8eQ-1; Thu,
 07 Mar 2024 03:26:45 -0500
X-MC-Unique: YCH9Z4zEMva3JJyiGTu8eQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A97D91C006AE;
	Thu,  7 Mar 2024 08:26:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 177F9C37A83;
	Thu,  7 Mar 2024 08:26:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZelGX3vVlGfEZm8H@casper.infradead.org>
References: <ZelGX3vVlGfEZm8H@casper.infradead.org> <1668172.1709764777@warthog.procyon.org.uk>
To: Matthew Wilcox <willy@infradead.org>,
    Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: dhowells@redhat.com, Christoph Hellwig <hch@lst.de>,
    Andrew Morton <akpm@linux-foundation.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
    linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
    linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: Replace ->launder_folio() with flush and wait
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1821329.1709800001.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Mar 2024 08:26:41 +0000
Message-ID: <1821330.1709800001@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Matthew Wilcox <willy@infradead.org> wrote:

> commit e3db7691e9f3dff3289f64e3d98583e28afe03db
> Author: Trond Myklebust <Trond.Myklebust@netapp.com>
> Date:   Wed Jan 10 23:15:39 2007 -0800
> =

>     [PATCH] NFS: Fix race in nfs_release_page()
>... =

>       invalidate_inode_pages2() may find the dirty bit has been set on a=
 page
>       owing to the fact that the page may still be mapped after it was l=
ocked.
>       Only after the call to unmap_mapping_range() are we sure that the =
page
>       can no longer be dirtied.

Is that last sentence even true?  It evicts folios from the TLB and/or
pagetables, but it doesn't actually trim any mmap made - in which case,
userspace is perfectly at liberty to regenerate and dirty the folio the mo=
ment
the folio is removed from the page tables.  Otherwise DIO-to/from-mmap wil=
l
deadlock.

> but my belief is that we should be able to get rid of it.

I think you're probably correct.  The best we can do, I think, is to prefa=
ce
any call to invalidate_inode_pages2() with a flush-and-wait over the same
range.

David


