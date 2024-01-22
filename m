Return-Path: <linux-kernel+bounces-32971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D82998362A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A63F1F29AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3E43D0C6;
	Mon, 22 Jan 2024 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4GDL6Mk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9B3CF73
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924223; cv=none; b=nra0nOr70UjFYkFPh7TQ2taYPjSs0T9At5OwQEKIoMUg8z/QtKgk6bs5v7c/m6E+KNMdvwoyxP5rRRTfjK6fwEBLSbcbQ10Wxufa+ZUopTA1nN43eA2OijOa3JX/jGD3KI1GhvDkDCdajRxCXfgIbgFQpVoxBQ0JEbEfzJS2rdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924223; c=relaxed/simple;
	bh=Su7A1i3HKqk5azEV0eLpu0T2S7uFiOiSyMb/yVBo57g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUJVK1H2Bel/y6655N1y4LDG73TWd+CJSykquT9VE4qtVRs7ysMnNF131AWCAo+YgWaVh53BMyUmas5LZj7sw2EbLFL7uLmHIJtqVynVKGofrLlDkhOTM3CyIOtbZCWQDEEruWT/eJXdZFaRszf/UI6pWgsXq9RMcPkzE08stLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4GDL6Mk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705924221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KeeG0FfVujDf91nAvy13CDWA92gJt33lwcR42KZA7GE=;
	b=A4GDL6MkifPuWlXNuaEo44/KvtgumwqIx6eVrrxjQ/rgP+8BpRkVGbwZE9jsDYkHgCrlbY
	d1f+aOiKvF456yLRB0fjFVi7EtjmPDD9PoMCSMjyd/88ybFGSzQa47xlbidQiYVcahL55u
	D2wb7wuEDK+zsOVnNchhvPlQ0RNoq4c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-AisSLAzPOYKrDxNVjIRW0w-1; Mon, 22 Jan 2024 06:50:18 -0500
X-MC-Unique: AisSLAzPOYKrDxNVjIRW0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50BEE80007C;
	Mon, 22 Jan 2024 11:50:17 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5369D400D7AB;
	Mon, 22 Jan 2024 11:50:15 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netfs@lists.linux.dev
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] netfs: Add Jeff Layton as reviewer
Date: Mon, 22 Jan 2024 11:50:01 +0000
Message-ID: <20240122115007.3820330-3-dhowells@redhat.com>
In-Reply-To: <20240122115007.3820330-1-dhowells@redhat.com>
References: <20240122115007.3820330-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Add Jeff Layton as a reviewer in the MAINTAINERS file.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ab5858d24ffc..2f4f4bf2e7f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8223,6 +8223,7 @@ F:	include/linux/iomap.h
 
 FILESYSTEMS [NETFS LIBRARY]
 M:	David Howells <dhowells@redhat.com>
+R:	Jeff Layton <jlayton@kernel.org>
 L:	netfs@lists.linux.dev
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported


