Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9943F7F265E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjKUHbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjKUHbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:31:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDBF10E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700551899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77Bzl/+Kq0+MzNg2uBfJvKrlDQ1jm6M8H9m1x9Ji14Q=;
        b=G9bNE1EPKLxDZi+B3kkNegL2Jeft7dD1SS7TQiSudQ9jlOXgv29gDnJg2zAb/WFJk4xrhI
        gSuoq5Uv6Bi4GdiByrtPeHSaPoxwVbN05nFrCSQm7zaXXmhVBrzYCzsLYtAb2iKVnCJi2R
        egN9LBEvpVy/tfYMNsBUyEY0GfVaYLA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-ETEATdwXPl-IT_04BPdwNQ-1; Tue,
 21 Nov 2023 02:31:35 -0500
X-MC-Unique: ETEATdwXPl-IT_04BPdwNQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F6543804A4D;
        Tue, 21 Nov 2023 07:31:35 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60E281C060B0;
        Tue, 21 Nov 2023 07:31:32 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com
Subject: [PATCH v2 5/5] Documentation: Add reconnect process for VDUSE
Date:   Tue, 21 Nov 2023 15:30:50 +0800
Message-Id: <20231121073050.287080-6-lulu@redhat.com>
In-Reply-To: <20231121073050.287080-1-lulu@redhat.com>
References: <20231121073050.287080-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the document to explained how the reconnect process
include how the Userspace App need to do and how it works
with kernel

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 Documentation/userspace-api/vduse.rst | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
index bdb880e01132..6e01c21d94df 100644
--- a/Documentation/userspace-api/vduse.rst
+++ b/Documentation/userspace-api/vduse.rst
@@ -231,3 +231,32 @@ able to start the dataplane processing as follows:
    after the used ring is filled.
 
 For more details on the uAPI, please see include/uapi/linux/vduse.h.
+
+HOW VDUSE devices reconnectoin works
+----------------
+0. Userspace APP checks if the device /dev/vduse/vduse_name exists, if not create
+   the device. If yes means this is reconnect, goto 3
+
+1. Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
+   /dev/vduse/control.
+
+2. In ioctl(VDUSE_CREATE_DEV), the kernel alloc the memory to sync the reconnect
+   information.
+
+3. Userspace App will mmap the pages to userspace
+
+   If this first time to connect, userspace App need save the reconnect
+   information (struct vhost_reconnect_data) in mapped pages
+
+   If this is reconnect, userspace App need to check if the saved information
+   OK to reconnect, Also userspace App MUST set the bit reconnected in
+   struct vhost_reconnect_data to 1. (kernel will use this bit to identify if the
+   userAPP is reconnected )
+
+4. Successfully start the userspace App.
+   userspace APP need to call ioctl VDUSE_VQ_GET_INFO to sync the vq information. also
+   APP need to save the reconnect information (struct vhost_reconnect_vring)
+   while running
+
+5. When the Userspace App exit, Userspace App need to unmap all the reconnect
+   pages
-- 
2.34.3

