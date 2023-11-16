Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88CE7EE4BB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345474AbjKPPxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345437AbjKPPxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:53:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769FCD59
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700150007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QXSR/5dGYSLLIzkrUqlSUZEGpATfuh7Jb7sNeswoiGc=;
        b=QEYl1/fwUTqW9eUdnPb38MKuyWkZ5wqyK65U9a6ERHOr6zyUIJsYFW6XIF8xdMGBUeW7OY
        nLd+AJx6ZnFPPh9eCvGrV9A9KRkJGyfsmfozau02ZnAzZG6BEfSrOlkiz7wtrBkj2L2z+l
        Pp45tHGsk9ZOC1WAcMAwmE7lxI7pni8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-tVT4BDpqNDOIyaQdbQ-Cdg-1; Thu,
 16 Nov 2023 10:53:24 -0500
X-MC-Unique: tVT4BDpqNDOIyaQdbQ-Cdg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19A543C0F36D;
        Thu, 16 Nov 2023 15:53:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D1A0492BFE;
        Thu, 16 Nov 2023 15:53:23 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] afs: Mark a superblock for an R/O or Backup volume as SB_RDONLY
Date:   Thu, 16 Nov 2023 15:53:12 +0000
Message-ID: <20231116155312.156593-6-dhowells@redhat.com>
In-Reply-To: <20231116155312.156593-1-dhowells@redhat.com>
References: <20231116155312.156593-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark a superblock that is for for an R/O or Backup volume as SB_RDONLY when
mounting it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index e95fb4cb4fcd..a01a0fb2cdbb 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -407,8 +407,10 @@ static int afs_validate_fc(struct fs_context *fc)
 			return PTR_ERR(volume);
 
 		ctx->volume = volume;
-		if (volume->type != AFSVL_RWVOL)
+		if (volume->type != AFSVL_RWVOL) {
 			ctx->flock_mode = afs_flock_mode_local;
+			fc->sb_flags |= SB_RDONLY;
+		}
 	}
 
 	return 0;

