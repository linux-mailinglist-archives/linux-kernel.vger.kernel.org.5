Return-Path: <linux-kernel+bounces-117160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4779488A811
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CF61F3B965
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E9212D1FC;
	Mon, 25 Mar 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T292jTaQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D20C83CDE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374089; cv=none; b=GPSZRyPF5vSdbl4EIyETkRqp9mkR81FACg0de4Wr+sHc+l86pvLOzXz0OkY/mYyqK8VTCHge2ljWQCbROSPWZ7ZoSj6WgXBYtVkf78DBh9NQhtHYSoxb8VIU59T43fBbkB23idTTAwHovCZVAJ0LTDYV7bT/JmG9wu2+BIWCKn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374089; c=relaxed/simple;
	bh=RwZOPAwjCEBMOkBn0hi/OdheNFiglgJTPGD5gXKkYx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j0MxgGkRpwN+RYErIVw5/qGP1NjGzBAIARLF4FRp2OKeJvnBfYuH3PprmdBlIChlAk+qcDmQG8Wquez6Hx9yHknuYB9vxdEHHDri0+VnSPkNwgGDocrOHwoTtCgcDefOaZEnOPU8raHCvkg5OKvL/9q0VZeI3AxbAMcjNRhAvZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T292jTaQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711374087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=stQvP6laILDGNlyKdB5zsolFqWnOVdSrYR9bZmkcQ4c=;
	b=T292jTaQ6zK/9Fse61YJqS6/+ALhpHLXvdT4BM13nSNQ50PMz15lBEs27EU/XIjcEE++XY
	4DvV3RBw26FtG3iYTV5ud2iwpKZWR9m+aud04Wx6aLW6N4mski17hlHhoPY41Ls/IpJEQF
	sKwvTTeCEncNZnByYfReonggCQCW1ok=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-RMWioxctObOBJuESaGvNAQ-1; Mon,
 25 Mar 2024 09:41:25 -0400
X-MC-Unique: RMWioxctObOBJuESaGvNAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BEC91C0F478;
	Mon, 25 Mar 2024 13:41:24 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.143])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EEC532166B35;
	Mon, 25 Mar 2024 13:41:19 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>
Subject: [PATCH v1 0/3] mm/secretmem: one fix and one refactoring
Date: Mon, 25 Mar 2024 14:41:11 +0100
Message-ID: <20240325134114.257544-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Patch #1 fixes a GUP-fast issue, whereby we might succeed in pinning
secretmem folios. Patch #2 extends the memfd_secret selftest to cover
that case. Patch #3 removes folio_is_secretmem() and instead lets
folio_fast_pin_allowed() cover that case as well.

With this series, the reproducer (+selftests) works as expected. To
test patch #3, the gup_longterm test does exactly what we need, and
keeps on working as expected.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: xingwei lee <xrivendell7@gmail.com>
Cc: yue sun <samsun1006219@gmail.com>

David Hildenbrand (3):
  mm/secretmem: fix GUP-fast succeeding on secretmem folios
  selftests/memfd_secret: add vmsplice() test
  mm: merge folio_is_secretmem() into folio_fast_pin_allowed()

 include/linux/secretmem.h                 | 21 ++---------
 mm/gup.c                                  | 33 ++++++++++-------
 tools/testing/selftests/mm/memfd_secret.c | 44 +++++++++++++++++++++--
 3 files changed, 65 insertions(+), 33 deletions(-)

-- 
2.43.2


