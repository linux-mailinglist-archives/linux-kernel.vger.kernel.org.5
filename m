Return-Path: <linux-kernel+bounces-101205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5872887A3F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E7928297A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5698D1BC44;
	Wed, 13 Mar 2024 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WP+0+Rak"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62431B7F8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317715; cv=none; b=uk0y26ds6ylfGF3lc6YGwe1FptjnGgWiFPohNvfFSYgfcPXRTXtwIVJVPM3oeYY0eaic8c7jgXj0c++VWw4GeeEQbtwGfDykEkW7lR4ihUGFOTizR2diMyetfLOyKC64O2xqD9RB32ZFXuVERJeIPc4jinuD/wrMO/lb6ZIINxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317715; c=relaxed/simple;
	bh=n7rXU4O0tgKGaggLBSJ+Myujm1amDRFVKcM7UuW3eok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=avNuY3Awo0e0Zn1mZo2aMHYf7/cRMfIq2aCAPgxydnNbbAkWlSXsjLKnEv1zWdJd+JJ1dn+we3ypY3PAC9Nb5+Z7x5s0uXzh+3o9WBqsCzaaZ2v/h8S4zTM4KyuuiBvXu/jr8RAQ6e4Lg2nY99LF0d9ep6s1nGby2rNIFloFXgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WP+0+Rak; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710317712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XeoAjTK81zFe9kZVKVWoanFV5nZRRMbcdpKdKscy/GU=;
	b=WP+0+RakthRaIPvxOtCC89eM6CifTKokb5Jnat2sXh5tpJx9Gg73uXKLktA0+YybEcUWQ3
	CZpHdCnYCQzRw/PFwAf1KXiSQQPUZ1++RPTN7o0IG03kgQ3/5syuPZA7JZYu2v8MnKVZPu
	h1NNr8qlg9C0l+EHB2CPpoYE0SqShN8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-6NKIEnDhMdC1vA5m0qazIw-1; Wed, 13 Mar 2024 04:15:09 -0400
X-MC-Unique: 6NKIEnDhMdC1vA5m0qazIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93C4B84B167;
	Wed, 13 Mar 2024 08:15:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AF188C4F9A0;
	Wed, 13 Mar 2024 08:15:07 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] afs: Miscellaneous fixes
Date: Wed, 13 Mar 2024 08:15:01 +0000
Message-ID: <20240313081505.3060173-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hi Marc,

Here are some fixes for afs, if you could look them over?

 (1) Fix the caching of preferred address of a fileserver.  By doing that, we
     stick with whatever address we get a response back from first rather then
     obeying any preferences set.

 (2) Fix an occasional FetchStatus-after-RemoveDir.  The FetchStatus then
     fails with VNOVNODE (equivalent to -ENOENT) that confuses parts of the
     driver that aren't expecting that.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

Thanks,
David

David Howells (2):
  afs: Don't cache preferred address
  afs: Fix occasional rmdir-then-VNOVNODE with generic/011

 fs/afs/rotate.c     | 21 ++++-----------------
 fs/afs/validation.c | 16 +++++++++-------
 2 files changed, 13 insertions(+), 24 deletions(-)


