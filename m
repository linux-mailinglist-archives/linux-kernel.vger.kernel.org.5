Return-Path: <linux-kernel+bounces-145217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C7C8A50FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06FC3B21AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8EB129A7C;
	Mon, 15 Apr 2024 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGo6Vqh/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009961292D7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186250; cv=none; b=djyQs5iXf4CA3FH0OAKwCmF7HeKJOmr6DCrtgi6VsOHbU1XVqiAOPxgq9zW/wvnoMVZvsfASZhHsrXmuk3M68WJVgPBI6H/n1kNJE0OGmBM+Wz9+rJiMaG7OkhBl5Du2YsEYTH1hL9Bz05qIcvkA7i4zuYSIHdQ/H4Z3El/E8eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186250; c=relaxed/simple;
	bh=9+bMhlfMhCt5MDDi+GnzheGMjkv5c6dD/+ouIDPqjHE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=gohkBL2SbQvwZ7nDjKWzUFIBYKN7iKe9NbjyYfj131BrIHK1n2GzBW7tJyTYJJFyywLbnUhJ8pabsUck9X3/5I4KYk7L11KbkUKPVoN0z1mGnEnEg0m0I4wpmBuJEU14HjXmGZyraNYse4scmvGjxoZnJ/p2fE5pp0dujUX1UDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BGo6Vqh/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713186248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ptvnzk1WkI8ph1+6mQtrYI+ziVGUn1LcaZGMSp9/x0=;
	b=BGo6Vqh/EPBz2MVjEwjHMTiPOm4mSa73rUjP4P5pFSbfc4g3mSfgcfNlkcPrUgltfmHO56
	Y7FWmKanjNJugd1o3FZTddM3G1UpVAp94X995TzHCJncpEZsz1fdaRHwyTk4wupRFqNuQ5
	WXLegkImII9qFBTgfsah24aAtLAnB5Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-A9VRT3_LO8mlZjn-t-8k9g-1; Mon,
 15 Apr 2024 09:04:04 -0400
X-MC-Unique: A9VRT3_LO8mlZjn-t-8k9g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE6CA2999B20;
	Mon, 15 Apr 2024 13:04:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 367FB492BC7;
	Mon, 15 Apr 2024 13:03:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <39de1e2ac2ae6a535e23faccd304d7c5459054a2.camel@kernel.org>
References: <39de1e2ac2ae6a535e23faccd304d7c5459054a2.camel@kernel.org> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-2-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Matthew Wilcox <willy@infradead.org>,
    Steve French <smfrench@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
    Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>
Subject: Re: [PATCH 01/26] cifs: Fix duplicate fscache cookie warnings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2345943.1713186234.1@warthog.procyon.org.uk>
Date: Mon, 15 Apr 2024 14:03:54 +0100
Message-ID: <2345944.1713186234@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Jeff Layton <jlayton@kernel.org> wrote:

> > +struct cifs_fscache_inode_key {
> > +
> > +	__le64  uniqueid;	/* server inode number */
> > +	__le64  createtime;	/* creation time on server */
> > +	u8	type;		/* S_IFMT file type */
> > +} __packed;
> > +
> 
> Interesting. So the uniqueid of the inode is not unique within the fs?
> Or are the clients are mounting shares that span multiple filesystems?
> Or, are we looking at a situation where the uniqueid is being quickly
> reused for new inodes after the original inode is unlinked?

The problem is that it's not unique over time.  creat(); unlink(); creat();
may yield a repeat of the uniqueid.  It's like i_ino in that respect.

David


