Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8327E6DCB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343963AbjKIPm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343757AbjKIPmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:42:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A3435AF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699544442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vmvyNEq0mjAiqaSKGBoHUs1cA03yuKyhB0WO0XE/N4w=;
        b=ViBIagmYmXmfvStrH7cQgu2AOoTiCizVQP59/ClsC4VSyea9hCKc7w/H5f5aMh6Mevao8x
        uswOfwpia0lIjSrVWNbIAs+38GY3JLIxo8uxZQFMphWJIhErDbOeCMLvwuKQqaGFvs/bsO
        TxsLU4MzcEIxPMlk9Wp2eZKN7Vxexf0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-4nh_J7PWP_WADuUUKjtDNA-1; Thu, 09 Nov 2023 10:40:32 -0500
X-MC-Unique: 4nh_J7PWP_WADuUUKjtDNA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C04C101B049;
        Thu,  9 Nov 2023 15:40:27 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 969C62026D68;
        Thu,  9 Nov 2023 15:40:26 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/41] afs: Don't skip server addresses for which we didn't get an RTT reading
Date:   Thu,  9 Nov 2023 15:39:34 +0000
Message-ID: <20231109154004.3317227-12-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the rotation algorithms for iterating over volume location servers and
file servers, don't skip servers from which we got a valid response to a
probe (either a reply DATA packet or an ABORT) even if we didn't manage to
get an RTT reading.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/rotate.c    | 2 +-
 fs/afs/vl_rotate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 1c8f26a7f128..689acb0ad64b 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -426,7 +426,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 		if (!test_bit(i, &op->untried) ||
 		    !test_bit(AFS_SERVER_FL_RESPONDING, &s->flags))
 			continue;
-		if (s->probe.rtt < rtt) {
+		if (s->probe.rtt <= rtt) {
 			op->index = i;
 			rtt = s->probe.rtt;
 		}
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index af445e7d3a12..6e29272ffa8e 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -195,7 +195,7 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 		if (!test_bit(i, &vc->untried) ||
 		    !test_bit(AFS_VLSERVER_FL_RESPONDING, &s->flags))
 			continue;
-		if (s->probe.rtt < rtt) {
+		if (s->probe.rtt <= rtt) {
 			vc->index = i;
 			rtt = s->probe.rtt;
 		}

