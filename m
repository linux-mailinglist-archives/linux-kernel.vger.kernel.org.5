Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B3A811376
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379300AbjLMNu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379214AbjLMNu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:50:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE39318F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702475430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z3fXIPXuGexzb3JH5UnibU+knvRn4aWjn9nvZHgRZUg=;
        b=bO2zIP4NzhJcdI+XmyhlwWevddlqgZHq2BRffFt02PV23xOjE2zsdQxpjd8yQ6p7nNB8kn
        cXJkZiED7BTMs4qv6/IqJV0h/MA8PCI2KIBPcbHsVO8+JuHJEJx4so+lWQLonNkohxPsUT
        et0DTnQ4u0ysj9bhb3PiwzZKQQtJbwg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-csY2hgwvOb-vxy8PjmHO1w-1; Wed, 13 Dec 2023 08:50:26 -0500
X-MC-Unique: csY2hgwvOb-vxy8PjmHO1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFC178828C6;
        Wed, 13 Dec 2023 13:50:25 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2160E1C060B1;
        Wed, 13 Dec 2023 13:50:25 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/40] afs: Handle the VIO and UAEIO aborts explicitly
Date:   Wed, 13 Dec 2023 13:49:34 +0000
Message-ID: <20231213135003.367397-13-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When processing the result of a call, handle the VIO and UAEIO abort
specifically rather than leaving it to a default case.  Rather than
erroring out unconditionally, see if there's another server if the volume
has more than one server available, otherwise return -EREMOTEIO.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---

Notes:
    Changes
    =======
    ver #2)
     - Treat UAEIO as VIO too.

 fs/afs/rotate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 13ec8ffa911a..0829933f4d9a 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -330,6 +330,13 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 			goto restart_from_beginning;
 
+		case UAEIO:
+		case VIO:
+			op->error = -EREMOTEIO;
+			if (op->volume->type != AFSVL_RWVOL)
+				goto next_server;
+			goto failed;
+
 		case VDISKFULL:
 		case UAENOSPC:
 			/* The partition is full.  Only applies to RWVOLs.

