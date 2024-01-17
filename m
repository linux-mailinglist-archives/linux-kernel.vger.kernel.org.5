Return-Path: <linux-kernel+bounces-29198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81625830ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCE428C627
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D842231F;
	Wed, 17 Jan 2024 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpgodsjU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851AF2230A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508090; cv=none; b=ClKUYQTuw5Fz6Q8xFv2ToXxeWKKU2b+/eOwGBkc5WqvkvD1J6QM6yVNg0md6WqDdlDEF7en3vCfmWNTuojdk37v1PkcN0lJdgvny3b2WaneSj4vrB7FrLIEskUDTULwP/4TThHH4npKeJIb5TU6CRe3ahUTjTML78IqumDfslxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508090; c=relaxed/simple;
	bh=NNp7EBLIzaXw/7mCitS2vMhUdRanFmB9E2Mm7QsT++E=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:
	 Organization:From:To:cc:Subject:MIME-Version:Content-Type:
	 Content-ID:Content-Transfer-Encoding:Date:Message-ID:X-Scanned-By;
	b=isIpFiROjDOGVeFutE0mEkVGw7CoirqUJwT8yes9PDAZ75e30ma/P0y7W5FPHMqNc37yr7qNGDKew6VBUP1czHxQX+RfrHe+fRXLUW49hqWiI3uwD+59/D5UYY471jWtWE/z4nhc9S6kJMXiMJfU0NlKrWfpEL6uf4RHMPkef0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JpgodsjU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705508087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LeaeQDlEh2LuJK20KLIGSOeAcFEeBt+olazsW/kSruE=;
	b=JpgodsjU4OnnPGhLUlDeWFVdrlasHfudeUdaUgKQBJ0fuXptJlzZ9IJVVgXEQHbDEP9eUF
	pLq+Ya+3mrtGLaR6CiR63cI8taIbLVdttZyDkn3/VaidXu+GT0r29CSVGCLl8lPX5EdMtt
	teRSDmbSOYPMWs8domg21Vlyx39jP/8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-V68_g6WuPauNusTbKnV1XA-1; Wed, 17 Jan 2024 11:14:43 -0500
X-MC-Unique: V68_g6WuPauNusTbKnV1XA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B75D85A58F;
	Wed, 17 Jan 2024 16:14:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D0DA12026D6F;
	Wed, 17 Jan 2024 16:14:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix missing/incorrect unlocking of RCU read lock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2929033.1705508081.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jan 2024 16:14:42 +0000
Message-ID: <2929034.1705508082@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

In afs_proc_addr_prefs_show(), we need to unlock the RCU read lock in both
places before returning (and not lock it again).

Fixes: f94f70d39cc2 ("afs: Provide a way to configure address priorities")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/proc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 3bd02571f30d..15eab053af6d 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -166,7 +166,7 @@ static int afs_proc_addr_prefs_show(struct seq_file *m=
, void *v)
 =

 	if (!preflist) {
 		seq_puts(m, "NO PREFS\n");
-		return 0;
+		goto out;
 	}
 =

 	seq_printf(m, "PROT SUBNET                                      PRIOR (v=
=3D%u n=3D%u/%u/%u)\n",
@@ -191,7 +191,8 @@ static int afs_proc_addr_prefs_show(struct seq_file *m=
, void *v)
 		}
 	}
 =

-	rcu_read_lock();
+out:
+	rcu_read_unlock();
 	return 0;
 }
 =


