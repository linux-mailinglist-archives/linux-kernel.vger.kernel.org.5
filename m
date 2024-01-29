Return-Path: <linux-kernel+bounces-42490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E8A840219
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6519284059
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5676856479;
	Mon, 29 Jan 2024 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ElH86OJz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAD156454
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521776; cv=none; b=WDV9urKzFCsi5DET0vf+cwrUUvT8gqMbZcOs7iT/2nlQ8N/odNRx9z+kjVs3Ir34jIb17uhul5g5w9B0MAgpYrdDZkIexL3y6edx190d6toDTq/ga9N1xdsE2ETEXejJcCPXteYx4yb6rwOPjaDq+8TRNv1/b02JNRR8b3lOwSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521776; c=relaxed/simple;
	bh=9fwTsy09+zhtJYD5oZvv7jgCqz036BRm5TDsLVRnhYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1mvAzNVbtz5nM/RrOfs2dWXanNV/1GD7Vcjb5wmnq8lvSMAOR8TKQbu9e+RRYBWCfu6AfmrP2ebjh5rI+ufvZbZuQxLkHFDsEeZYtyxZ5e5HzWgionKVayd1EU97jFMu8bRkb4s87uf8zWrMdugg3zbfKz9mnDRAycqgoJb4Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ElH86OJz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706521773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OCIW9vJhBOYMefsIUqmT/GeymZeEusUcC32sI5mr9No=;
	b=ElH86OJzWzP6d+U32u+K/ywkO34AbhsJ3SD1b2nAODOJYWSEXnosRJmD628dD2hSZ/20ve
	3DFQ8WsZGKNOLLFYBq56pPTgtjD9RIEZ8Sx90V+0iO6OFifYSOMyGW7Iuz9csBZcXhMMwl
	NN+xH1kvPXCk7Yx6Eqi2aDuNS9YUSh8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-_Qr3tQcfP8S6khmn53WbBQ-1; Mon, 29 Jan 2024 04:49:29 -0500
X-MC-Unique: _Qr3tQcfP8S6khmn53WbBQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEBED811E81;
	Mon, 29 Jan 2024 09:49:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 844B91C060AF;
	Mon, 29 Jan 2024 09:49:26 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] netfs: Miscellaneous fixes
Date: Mon, 29 Jan 2024 09:49:17 +0000
Message-ID: <20240129094924.1221977-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Hi Christian,

Here are a couple of fixes for netfslib:

 (1) Fix an i_dio_count leak on a DIO read starting beyond EOF.

 (2) Fix a missing zero-length check in an unbuffered write causing 9p to
     indicate EIO.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

David Howells (1):
  netfs: Fix missing zero-length check in unbuffered write

Marc Dionne (1):
  netfs: Fix i_dio_count leak on DIO read past i_size

 fs/netfs/buffered_write.c | 3 +++
 fs/netfs/direct_write.c   | 5 ++++-
 fs/netfs/io.c             | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)


