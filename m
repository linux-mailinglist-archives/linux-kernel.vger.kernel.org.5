Return-Path: <linux-kernel+bounces-129615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F70B896D5C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B681F2C495
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB9A143869;
	Wed,  3 Apr 2024 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgLvvZIl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09992142E75
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141718; cv=none; b=qRnIdCrtM1yPqJI9IjjrRB4J8hIuxylmhoa3bC8Y1Yy3Ken4uQGODuKjvfHgjxaJSabAr7VY8lH2tMGiP8ZOdgGWHHuIjG7K6cbwuSHSNw4kNOtscW1tSJ/BcwV1MunPPLphq+pqALBsNmcOYzjk7Qf+nTnqZ1F4PZkOiCsEY7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141718; c=relaxed/simple;
	bh=ACQpn9vs7GeKGUhlQvB3CXp7C7P0aciqvgBCFb4+LHI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=QnWoA1N74nuw1EyLNJ6R8f0osnDnIQYCfYxn0UogMgHC5mFyZDCExRbgmT4BCflYV7+Fx/5fVasCn6vZNr/pEK+Thx3z6VQrB4ZOlv3j9PuSG9QiA22nsGkZMepQ48qOTn0PNCyak8zuqFtHqLQ5cWVHnkN5rhvBVoS0pOyl4lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgLvvZIl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712141716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOHdI5+Rm0qGsBNAwcaXDe1QoVGd2FuT8Hymhfhq4nw=;
	b=RgLvvZIlbsdYPcjXswfc0Dlh5O0K0303/AG0UrcjEBE96OIs77Z4F4M6DXjzgckz+wglp5
	7c/lTqy83XRr5s1mDPzOJ0kZU/PTjUyaQZ6d4YP7gPUix/jLcZVjqpWXaPJQ1LKqUnbMcd
	YlM2YwzQcBuTkTW6Zj70Dnmuort4FYk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-XFTgKXIOOraQHI6hCfH_XA-1; Wed, 03 Apr 2024 06:55:10 -0400
X-MC-Unique: XFTgKXIOOraQHI6hCfH_XA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0A868007BB;
	Wed,  3 Apr 2024 10:55:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 97C6CC1576F;
	Wed,  3 Apr 2024 10:55:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240403101422.GA7285@lst.de>
References: <20240403101422.GA7285@lst.de> <20240403085918.GA1178@lst.de> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-16-dhowells@redhat.com> <3235934.1712139047@warthog.procyon.org.uk>
To: Christoph Hellwig <hch@lst.de>
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
Subject: Re: [PATCH 15/26] mm: Export writeback_iter()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3300437.1712141700.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Apr 2024 11:55:00 +0100
Message-ID: <3300438.1712141700@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Christoph Hellwig <hch@lst.de> wrote:

> On Wed, Apr 03, 2024 at 11:10:47AM +0100, David Howells wrote:
> > That depends.  You put a comment on write_cache_pages() saying that pe=
ople
> > should use writeback_iter() instead.  w_c_p() is not marked GPL.  Is i=
t your
> > intention to get rid of it?
> =

> Yes.  If you think you're not a derivate work of Linux you have no
> business using either one.

So why are we bothering with EXPORT_SYMBOL at all?  Why don't you just sen=
d a
patch replace all of them with EXPORT_SYMBOL_GPL()?

David


