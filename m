Return-Path: <linux-kernel+bounces-154452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135968ADC37
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46652811C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A2C1AAD3;
	Tue, 23 Apr 2024 03:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+ZMNK1n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3D818032
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842663; cv=none; b=cInou7URGUHFPjoiLmpy8T3M3+eLV9kpu0/w91Nu+HiIy6VCSvdkdgKbo79vGtmuKnpi6R7FwXca94zssJEu/bC7RrAbJjrSTseI1LNVeQPvkjp5DtSVhNeeWrRbH6pEMLWoidkmgozSi21xeQU64lXLw8awTc9ZFSr+qL1JHvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842663; c=relaxed/simple;
	bh=vJd/n/kLvdmg0NXk8w7mFiI4hyLJQTdFN7rDrDQQPMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fhKZjnFnpqKKl+yBhAd9ZtktmLlH4OxwWpYykdSwV7KvK2xcxb/BZBUhDSNrSICCIjlhomi8Ud3Cd5f0rGXkCIXr4+c5vkhbkesUZ4IU/yXOnRXQNk4dcHAbJDXPAOjqFpEOO5sTL5HvR+6HhIVS5cu5lVdK0I3AiNKfcNfG0fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+ZMNK1n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713842659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uscwOeRn66pE3jopQy+2n8hg6XRUl6ziX3+2s+Zw8uc=;
	b=N+ZMNK1nUFfbXIm9hNI1675REZKUW3c0vHp2qtuL+EAxQN7Fy1TlNghYRKi05dBI4piWZW
	Ht1XcTKoIhTELK/oIujokZZayKCb8GkHz7W60LdEiR2q5n3swdXOIWXoTLo1qhm7dAFwE+
	5kZ9y5FeJMuXfEj0FY8DK5OQ6Igq/9Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-6yDpHTlLPuuE7jwtjYSyOw-1; Mon, 22 Apr 2024 23:24:15 -0400
X-MC-Unique: 6yDpHTlLPuuE7jwtjYSyOw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E6228943A4;
	Tue, 23 Apr 2024 03:24:15 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4334C1BDAA;
	Tue, 23 Apr 2024 03:24:12 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH 0/4] vhost: Cleanup
Date: Tue, 23 Apr 2024 13:24:03 +1000
Message-ID: <20240423032407.262329-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

This is suggested by Michael S. Tsirkin according to [1] and the goal
is to apply smp_rmb() inside vhost_get_avail_idx() if needed. With it,
the caller of the function needn't to worry about memory barriers. Since
we're here, other cleanups are also applied.

[1] https://lore.kernel.org/virtualization/20240327075940-mutt-send-email-mst@kernel.org/

PATCH[1] drops the local variable @last_avail_idx since it's equivalent
         to vq->last_avail_idx
PATCH[2] improves vhost_get_avail_idx() so that smp_rmb() is applied if
         needed. Besides, the sanity checks on the retrieved available
         queue index are also squeezed to vhost_get_avail_idx()
PATCH[3] improves vhost_get_avail_head(), similar to what we're doing
         for vhost_get_avail_idx(), so that the relevant sanity checks
         on the head are squeezed to vhost_get_avail_head()
PATCH[4] Reformat vhost_{get, put}_user() by using tab instead of space
         as the terminator for each line

Gavin Shan (4):
  vhost: Drop variable last_avail_idx in vhost_get_vq_desc()
  vhost: Improve vhost_get_avail_idx() with smp_rmb()
  vhost: Improve vhost_get_avail_head()
  vhost: Reformat vhost_{get, put}_user()

 drivers/vhost/vhost.c | 199 +++++++++++++++++++-----------------------
 1 file changed, 88 insertions(+), 111 deletions(-)

-- 
2.44.0


