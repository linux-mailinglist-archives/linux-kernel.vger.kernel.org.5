Return-Path: <linux-kernel+bounces-127555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D6D894D98
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297021F221A5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1E951C4A;
	Tue,  2 Apr 2024 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEXqphu8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F97A3D57A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046774; cv=none; b=CKf+iVYGhYn2sKeBxYQ4xMXENq09xUQBrDlU2FiJnclM+sYV2CPQ6Vkp7/cG0B9DnAIIaBLWsWyHyvengv4YoJHcjdc5tJFIvpGfEw0UHcWVIMWurf2bGLND/tC6uJ2r7coDhDj5b5LMFJOtFb6SWghkMSHyy0uJlLsDG0Uq1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046774; c=relaxed/simple;
	bh=SbhTatDUNlFMsocczlgnCcBAF0CiyLb5vhHsAQLt2SU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Wcr7xT9I9CbvD9pudv/yofnaIupK47sxWdtSh58IUY3w6RJm7SNX7PfXRQy+Nm2lqJkx92PpTHqrfijUI1eOp8pqKFAnMrMQlVVMAwi6TmkiSzdXxPd3o2wqDxtwO4T4tX4/RFKx511JffQUBJSVQ3XUOmtLpTFtLtFbCvTOTUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WEXqphu8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712046772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+sMESiDiEk7NQ7Fx8r6KwgieS1M3kfYVE+bjq9Liog=;
	b=WEXqphu8N5LujXWmpTtqdMmO1AiQFzi7mSjpWxLJi/qojf1BVsJl6Rj5oavNlimgB/4bde
	MPbqaOOl9Hjkw5IloA9nktjlKHG7F+FV391/a3r0gdTInE3JhJQoITE2yqXxpbzOS8MHVw
	mWRGUaluQsQ+Kv/DCnPtHFWJm+73WEA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-5i1cRV1HP_OxdCzQ3Kdzqw-1; Tue, 02 Apr 2024 04:32:47 -0400
X-MC-Unique: 5i1cRV1HP_OxdCzQ3Kdzqw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F188879844;
	Tue,  2 Apr 2024 08:32:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 66B2CC1576F;
	Tue,  2 Apr 2024 08:32:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240401135351.GD26556@kernel.org>
References: <20240401135351.GD26556@kernel.org> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-27-dhowells@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Jeff Layton <jlayton@kernel.org>,
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
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 26/26] netfs, afs: Use writeback retry to deal with alternate keys
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3002685.1712046757.1@warthog.procyon.org.uk>
Date: Tue, 02 Apr 2024 09:32:37 +0100
Message-ID: <3002686.1712046757@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Simon Horman <horms@kernel.org> wrote:

> > +	op->store.size		= len,
> 
> nit: this is probably more intuitively written using len;

I'm not sure it makes a difference, but switching 'size' to 'len' in kafs is a
separate thing that doesn't need to be part of this patchset.

David


