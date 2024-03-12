Return-Path: <linux-kernel+bounces-100923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48AD879FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CC92832A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A48648CD4;
	Tue, 12 Mar 2024 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6ByBer2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F1826286
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710286655; cv=none; b=A4DKib7fo6Cd2A5DsztBqgq8ZDUDZFYI5xocJ6wh599/VhT6RX3k9WDGVd52GHFWJl011HRkWBozXyWY0Hq5EVY6NNwGtj//qoDOgLZXd1gNR+Sy+x/MVgTIoojXYSt8hi/+aSkAW3ZyBTLz+vOiZKo24nv8Mx91S5L0lpR4nbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710286655; c=relaxed/simple;
	bh=sORqIWNE5pVZeCpAkrvOfyLvuvyrqYzdWFV3rMd6lFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NAMJ+VSYQa6SBKd+smWgtAxjznS7Idcz4hmMQrLl/WsbW6201Pbchw79rdI/nHfiGJNes1K+BmriN4zBfCwiDhS+2hxfean66UrPyCQYDFLngGCEVg7qX3Ak7iLqGvEuHrSd+K+bAep4ME0F8dQ2cNjaqGP3RrBUxnxeoJryXPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6ByBer2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710286652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r3wV6mjrmbOYtgkKlQ1vhr8VmTlakhpayL5vbSQu//g=;
	b=X6ByBer2aPq1akuP+wEyOZci40O0YHulDYSBAyQN+SEgVOUqCYzIIdBEM+pnYcGrNnW0X1
	AqbE028KdVaWs854fvWthB2O3xYpqxnQXpCQlNP8LEG3wlkAFLlpQDClF1R1beGxlhwf/T
	bJt78NeGOBkRWBV7z75o4kXg1pMsQfE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235--pGCYMqpNLaoidRRNBp53Q-1; Tue,
 12 Mar 2024 19:37:29 -0400
X-MC-Unique: -pGCYMqpNLaoidRRNBp53Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9A2C1C07266;
	Tue, 12 Mar 2024 23:37:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 11524492BC7;
	Tue, 12 Mar 2024 23:37:26 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] rxrpc: Fixes for AF_RXRPC
Date: Tue, 12 Mar 2024 23:37:16 +0000
Message-ID: <20240312233723.2984928-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Here are a couple of fixes for the AF_RXRPC changes[1] in net-next.

 (1) Fix a runtime warning introduced by a patch that changed how
     page_frag_alloc_align() works.

 (2) Fix an is-NULL vs IS_ERR error handling bug.

The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/rxrpc-iothread-20240312

And can be found on this branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-iothread

David

Link: https://lore.kernel.org/r/20240306000655.1100294-1-dhowells@redhat.com/ [1]

David Howells (2):
  rxrpc: Fix use of changed alignment param to page_frag_alloc_align()
  rxrpc: Fix error check on ->alloc_txbuf()

 net/rxrpc/sendmsg.c | 4 ++--
 net/rxrpc/txbuf.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)


