Return-Path: <linux-kernel+bounces-164717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3DF8B819F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6DD1C23431
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E761A38C3;
	Tue, 30 Apr 2024 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYgYGkiH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47CB19DF5F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714509654; cv=none; b=iCQF3lm+pAzpDxIieN0j4O298DGG2JnkNDk3HMO2yVOKKJsRuSGggob7IpfozywfVzOAUACV7yI0g8O8wxX7sDBueH1xgb60H+JmMc6nU0SwnzFf2M/nuEny4kbwszKezVjC7J/W5VmUsyUg9nUGM6WeSJs5WkNLKjHzxurZgpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714509654; c=relaxed/simple;
	bh=w+6KTqRYqH4g82XjjMnM1W0nz4LoVWr/B/W1NuzYark=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hZXnsw/rwojiRnMmPpmqa1l327M6kmiI9RDSV//+Jj9NucjfLtZFe9o3myLiQwDWshjN3WYWFX9eHfIUvEbQeuK0iYYTheDTp8BVvQ8jRJr9iWTWusHSWVoAj3LhcbTqINx/Ps6jkn1YZGS7LExrE7uWP2/JhnbSESh6AX4Khg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QYgYGkiH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714509651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NgrzgAgGo8i+xwDb/b3m3FxSOTPzpaahtRRF4Q7L0yk=;
	b=QYgYGkiHsRiJixcdlZ7RqSNalxXWFLJzRDlam8RzcixD2Pen3gTp1EWGBSdC+FZKfzjMEd
	FIuGVzsKXd81z0HZ5hPcOu9ZdwJmeb+r3j+W1eX+k2xIeHnSus5atzIS/bAYNG8pdyh433
	wAsF5Md7aQfEil88Ei9860HHzkNhFOk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-Wx_lFYOlMO2wvDeYEn4muA-1; Tue,
 30 Apr 2024 16:40:47 -0400
X-MC-Unique: Wx_lFYOlMO2wvDeYEn4muA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E3E8380673C;
	Tue, 30 Apr 2024 20:40:47 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.75])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AA563C01595;
	Tue, 30 Apr 2024 20:40:45 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v1 0/2] mm/memory: cleanly support zeropage in vm_insert_page*(), vm_map_pages*() and vmf_insert_mixed()
Date: Tue, 30 Apr 2024 22:40:42 +0200
Message-ID: <20240430204044.52755-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

There is interest in mapping zeropages via vm_insert_pages() [1] into
MAP_SHARED mappings.

For now, we only get zeropages in MAP_SHARED mappings via
vmf_insert_mixed() from FSDAX code, and I think it's a bit shaky in some
cases because we refcount the zeropage when mapping it but not necessarily
always when unmapping it ... and we should actually never refcount it.

It's all a bit tricky, especially how zeropages in MAP_SHARED mappings
interact with GUP (FOLL_LONGTERM), mprotect(), write-faults and s390x
forbidding the shared zeropage (rewrite on its way upstream [2]).

This series tries to take the careful approach of only allowing the
zeropage where it is likely safe to use (which should cover the existing
FSDAX use case and [1]), preventing that it could accidentially get mapped
writable during a write fault, mprotect() etc, and preventing issues
with FOLL_LONGTERM in the future with other users.

Only very lightly tested ... because I yet have to even get fsdax running
(I guess, file system on emulated DIMM in a VM? Hmmm :) ).

[1] https://lkml.kernel.org/r/20240430111354.637356-1-vdonnefort@google.com
[2] https://lkml.kernel.org/r/20240411161441.910170-1-david@redhat.com

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vincent Donnefort <vdonnefort@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>

David Hildenbrand (2):
  mm/memory: cleanly support zeropage in vm_insert_page*(),
    vm_map_pages*() and vmf_insert_mixed()
  mm/rmap: sanity check that zeropages are not passed to RMAP

 include/linux/rmap.h |  3 ++
 mm/memory.c          | 92 ++++++++++++++++++++++++++++++++++----------
 mm/mprotect.c        |  2 +
 3 files changed, 76 insertions(+), 21 deletions(-)

-- 
2.44.0


