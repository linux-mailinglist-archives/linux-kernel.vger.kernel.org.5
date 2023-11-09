Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A2A7E6DE8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344556AbjKIPoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbjKIPm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:42:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBA9387A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699544470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QXSR/5dGYSLLIzkrUqlSUZEGpATfuh7Jb7sNeswoiGc=;
        b=F2MWDIPnPHARVmmpMPcsr9m6G4FXV03IQEDshCeoECjL+FrxYb+xdedCeiZfA3MF29xfRI
        07P9VmwSgVIDHyPbMSgLVR9XjdAG+WQIqHhaNYKaJHwQCD+kFBR7FoBFtSiac/E8ZlkZ1d
        8wDczD1NS6rkL3yJC3l0GiN8yB9v2UU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-kjPBqPX_MlGhtVbMphMM6Q-1; Thu, 09 Nov 2023 10:41:07 -0500
X-MC-Unique: kjPBqPX_MlGhtVbMphMM6Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED89A8122A2;
        Thu,  9 Nov 2023 15:41:06 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 316B4492BFA;
        Thu,  9 Nov 2023 15:41:06 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 33/41] afs: Mark a superblock for an R/O or Backup volume as SB_RDONLY
Date:   Thu,  9 Nov 2023 15:39:56 +0000
Message-ID: <20231109154004.3317227-34-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

